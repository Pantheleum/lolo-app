// functions/src/ai/router.ts
import { v4 as uuidv4 } from "uuid";
import { redis, db, CONFIG } from "../config";
import * as functions from "firebase-functions";
import {
  AIRequest, AIResponse, AIClassification, ModelSelection,
  AIRequestType, LatencyRequirement, CostSensitivity,
  SubscriptionTier, MessageMode,
} from "../types";
import { callClaude } from "./providers/claude";
import { callGrok } from "./providers/grok";
import { callGemini } from "./providers/gemini";
import { callGpt } from "./providers/gpt";
import { buildPrompt } from "./promptBuilder";

// --- Mode depth map ---
const MODE_DEPTH_MAP: Record<string, number> = {
  good_morning: 1, checking_in: 1, appreciation: 2, motivation: 2,
  celebration: 2, flirting: 2, reassurance: 3, long_distance: 3,
  apology: 4, after_argument: 4, sos_assessment: 5, sos_coaching: 5,
};

// --- Cost per 1K tokens by model ---
const COST_PER_1K: Record<string, { input: number; output: number }> = {
  "claude-sonnet-4.5": { input: 0.003, output: 0.015 },
  "claude-haiku-4.5":  { input: 0.00025, output: 0.00125 },
  "grok-4.1-fast":     { input: 0.0005, output: 0.002 },
  "gemini-flash":      { input: 0.000075, output: 0.0003 },
  "gpt-5-mini":        { input: 0.00015, output: 0.0006 },
};

// --- Tier to cost sensitivity ---
function costSensitivityFromTier(tier: SubscriptionTier): CostSensitivity {
  switch (tier) {
    case "legend": return "premium";
    case "pro": return "standard";
    default: return "minimal";
  }
}

// --- Classify request ---
export function classifyRequest(request: AIRequest): AIClassification {
  const taskType = request.requestType;

  // Emotional depth
  let emotionalDepth = MODE_DEPTH_MAP[request.mode || ""] || 2;
  const ctx = request.context;

  if (["angry", "crying", "anxious"].includes(ctx.emotionalState || "")) {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  if (ctx.cyclePhase === "luteal_late") {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  if (ctx.isPregnant && ctx.trimester === 1) {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  if ((ctx.situationSeverity || 0) >= 4) {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  emotionalDepth = Math.max(1, Math.min(5, emotionalDepth));

  // Latency
  let latencyRequirement: LatencyRequirement = "normal";
  if (taskType === "sos_coaching" || taskType === "sos_assessment") latencyRequirement = "urgent";
  else if (taskType === "action_card") latencyRequirement = "relaxed";

  return {
    taskType,
    emotionalDepth,
    latencyRequirement,
    costSensitivity: costSensitivityFromTier(request.tier),
  };
}

// --- Select model ---
export function selectModel(classification: AIClassification): ModelSelection {
  const { taskType, emotionalDepth, costSensitivity } = classification;

  if (taskType === "sos_coaching" || taskType === "sos_assessment") {
    return {
      primary: "grok-4.1-fast",
      fallback: "claude-haiku-4.5",
      tertiary: null,
      timeout: 3000,
      maxOutputTokens: 300,
    };
  }

  if (taskType === "gift" || taskType === "memory_query") {
    return {
      primary: "gemini-flash",
      fallback: "gpt-5-mini",
      tertiary: "claude-haiku-4.5",
      timeout: 10000,
      maxOutputTokens: 500,
    };
  }

  if (taskType === "analysis") {
    return {
      primary: "gemini-flash",
      fallback: "gpt-5-mini",
      tertiary: null,
      timeout: 8000,
      maxOutputTokens: 400,
    };
  }

  if (taskType === "message") {
    if (emotionalDepth >= 4) {
      return {
        primary: "claude-sonnet-4.5",
        fallback: "claude-haiku-4.5",
        tertiary: "gpt-5-mini",
        timeout: 8000,
        maxOutputTokens: 400,
      };
    }
    if (emotionalDepth >= 2 && costSensitivity === "premium") {
      return {
        primary: "claude-sonnet-4.5",
        fallback: "claude-haiku-4.5",
        tertiary: "gpt-5-mini",
        timeout: 8000,
        maxOutputTokens: 350,
      };
    }
    if (emotionalDepth >= 2) {
      return {
        primary: "claude-haiku-4.5",
        fallback: "gpt-5-mini",
        tertiary: null,
        timeout: 5000,
        maxOutputTokens: 300,
      };
    }
    return {
      primary: "claude-haiku-4.5",
      fallback: "gpt-5-mini",
      tertiary: null,
      timeout: 5000,
      maxOutputTokens: 250,
    };
  }

  if (taskType === "action_card") {
    return {
      primary: "claude-haiku-4.5",
      fallback: "gpt-5-mini",
      tertiary: null,
      timeout: 5000,
      maxOutputTokens: 300,
    };
  }

  return {
    primary: "gpt-5-mini",
    fallback: null,
    tertiary: null,
    timeout: 8000,
    maxOutputTokens: 300,
  };
}

// --- Call provider by model ID ---
async function callProvider(
  modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number,
  timeout: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeout);

  try {
    if (modelId.startsWith("claude")) return await callClaude(modelId, systemPrompt, userPrompt, maxTokens);
    if (modelId.startsWith("grok")) return await callGrok(modelId, systemPrompt, userPrompt, maxTokens);
    if (modelId.startsWith("gemini")) return await callGemini(modelId, systemPrompt, userPrompt, maxTokens);
    return await callGpt(modelId, systemPrompt, userPrompt, maxTokens);
  } finally {
    clearTimeout(timer);
  }
}

// --- Calculate cost ---
function calculateCost(modelId: string, tokens: { input: number; output: number }): number {
  const rates = COST_PER_1K[modelId] || COST_PER_1K["gpt-5-mini"];
  return (tokens.input / 1000) * rates.input + (tokens.output / 1000) * rates.output;
}

// --- Cache key ---
function buildCacheKey(request: AIRequest): string {
  const parts = [
    request.requestType,
    request.mode || "none",
    request.parameters.language,
    request.parameters.tone,
    request.parameters.length,
    request.context.zodiacSign || "none",
    request.context.emotionalState || "neutral",
  ];
  return `ai:cache:${parts.join(":")}`;
}

// --- Main router entry point ---
export async function routeAIRequest(request: AIRequest): Promise<AIResponse> {
  const startTime = Date.now();
  const responseId = uuidv4();

  // 1. Check cache
  const cacheKey = buildCacheKey(request);
  const cached = await redis.get(cacheKey);
  if (cached) {
    const parsed = JSON.parse(cached);
    return {
      ...parsed,
      requestId: request.requestId,
      responseId,
      metadata: { ...parsed.metadata, cached: true, latencyMs: Date.now() - startTime },
    };
  }

  // 2. Classify & select model
  const classification = classifyRequest(request);
  const modelConfig = selectModel(classification);

  // 3. Build prompt
  const { systemPrompt, userPrompt } = buildPrompt(request, classification);

  // 4. Execute with failover
  let modelUsed = modelConfig.primary;
  let wasFallback = false;
  let fallbackReason: string | undefined;
  let result: { content: string; tokensUsed: { input: number; output: number } };

  try {
    result = await callProvider(modelConfig.primary, systemPrompt, userPrompt, modelConfig.maxOutputTokens, modelConfig.timeout);
  } catch (primaryErr: any) {
    functions.logger.warn("Primary model failed", { model: modelConfig.primary, error: primaryErr.message });
    wasFallback = true;
    fallbackReason = primaryErr.message?.includes("timeout") ? "timeout" : "server_error";

    if (modelConfig.fallback) {
      try {
        modelUsed = modelConfig.fallback;
        result = await callProvider(modelConfig.fallback, systemPrompt, userPrompt, modelConfig.maxOutputTokens, Math.round(modelConfig.timeout * 1.5));
      } catch (fallbackErr: any) {
        functions.logger.warn("Fallback model failed", { model: modelConfig.fallback, error: fallbackErr.message });

        if (modelConfig.tertiary) {
          modelUsed = modelConfig.tertiary;
          result = await callProvider(modelConfig.tertiary, systemPrompt, userPrompt, modelConfig.maxOutputTokens, modelConfig.timeout * 2);
        } else {
          throw fallbackErr;
        }
      }
    } else {
      throw primaryErr;
    }
  }

  const costUsd = calculateCost(modelUsed, result.tokensUsed);
  const latencyMs = Date.now() - startTime;

  // 5. Build response
  const aiResponse: AIResponse = {
    requestId: request.requestId,
    responseId,
    content: result.content,
    metadata: {
      modelUsed,
      language: request.parameters.language,
      tokensUsed: result.tokensUsed,
      costUsd,
      latencyMs,
      cached: false,
      wasFallback,
      fallbackReason,
      emotionalDepthScore: classification.emotionalDepth,
    },
  };

  // 6. Cache response (skip SOS -- never cached)
  if (request.requestType !== "sos_coaching" && request.requestType !== "sos_assessment") {
    await redis.setex(cacheKey, CONFIG.CACHE_TTL_DEFAULT, JSON.stringify(aiResponse));
  }

  // 7. Log cost asynchronously
  logCost(request.userId, modelUsed, costUsd, result.tokensUsed).catch(() => {});

  return aiResponse;
}

async function logCost(
  userId: string,
  model: string,
  costUsd: number,
  tokens: { input: number; output: number }
): Promise<void> {
  await db.collection("ai_cost_logs").add({
    userId,
    model,
    costUsd,
    tokensInput: tokens.input,
    tokensOutput: tokens.output,
    timestamp: new Date().toISOString(),
  });
}

// --- Streaming variant for SOS ---
export async function* streamAIResponse(
  request: AIRequest
): AsyncGenerator<{ event: string; data: string }> {
  const classification = classifyRequest(request);
  const modelConfig = selectModel(classification);
  const { systemPrompt, userPrompt } = buildPrompt(request, classification);

  yield { event: "coaching_start", data: JSON.stringify({ sessionId: request.requestId, stepNumber: 1 }) };

  try {
    const result = await callProvider(modelConfig.primary, systemPrompt, userPrompt, modelConfig.maxOutputTokens, modelConfig.timeout);

    const sections = parseCoachingResponse(result.content);
    for (const section of sections) {
      yield { event: section.event, data: JSON.stringify(section.data) };
    }

    yield { event: "coaching_complete", data: JSON.stringify({ isLastStep: false, nextStepPrompt: "What did she say?" }) };
  } catch {
    yield { event: "error", data: JSON.stringify({ message: "AI service temporarily unavailable" }) };
  }
}

function parseCoachingResponse(content: string): { event: string; data: any }[] {
  const sections: { event: string; data: any }[] = [];
  sections.push({ event: "say_this", data: { text: content } });
  sections.push({ event: "body_language", data: { text: "Face her directly, maintain gentle eye contact" } });
  return sections;
}
