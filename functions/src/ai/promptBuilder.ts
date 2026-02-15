// functions/src/ai/promptBuilder.ts
import { AIRequest, AIClassification, SupportedLocale } from "../types";

const LANGUAGE_INSTRUCTIONS: Record<SupportedLocale, string> = {
  en: "Write in English. Use natural, conversational American English.",
  ar: "Write in Arabic. Use Modern Standard Arabic unless a dialect is specified. Right-to-left text.",
  ms: "Write in Bahasa Malaysia. Use standard Malaysian Malay with natural tone.",
};

const TONE_INSTRUCTIONS: Record<string, string> = {
  warm: "Use a warm, caring tone that feels genuine.",
  playful: "Keep it light and playful with subtle humor.",
  serious: "Be sincere and straightforward. No jokes.",
  romantic: "Be deeply romantic without being cheesy or over-the-top.",
  gentle: "Use a soft, gentle tone. She may be fragile right now.",
  confident: "Be confident and assured. Show strength with sensitivity.",
};

const LENGTH_INSTRUCTIONS: Record<string, string> = {
  short: "Keep it to 1-3 sentences. Punchy and impactful.",
  medium: "4-6 sentences. Well-developed but not rambling.",
  long: "A full paragraph or two. Take your time to express depth.",
};

export function buildPrompt(
  request: AIRequest,
  classification: AIClassification
): { systemPrompt: string; userPrompt: string } {
  const ctx = request.context;
  const params = request.parameters;

  const systemPrompt = `You are a relationship communication assistant helping a man communicate with his female partner. Your identity is never revealed.

CORE RULES:
1. ${LANGUAGE_INSTRUCTIONS[params.language]}
2. The message must sound like it came from HIM, not an AI.
3. Be specific. Reference her actual traits from the context.
4. Never use cliches: "you complete me," "you're my everything."
5. ${LENGTH_INSTRUCTIONS[params.length]}
6. ${TONE_INSTRUCTIONS[params.tone]}
7. Never mention AI, apps, or that this was generated.
8. Her love language is ${ctx.loveLanguage || "unknown"}. Weight accordingly.
9. Cultural context: ${ctx.culturalBackground || "general"}. Religious observance: ${ctx.religiousObservance || "moderate"}.
10. Emotional depth required: ${classification.emotionalDepth}/5.

PARTNER CONTEXT:
- Name: ${ctx.partnerName}
- Zodiac: ${ctx.zodiacSign || "unknown"}
- Relationship: ${ctx.relationshipStatus}, ${ctx.relationshipDurationMonths || "unknown"} months
- Communication style: ${ctx.communicationStyle || "mixed"}
- Current emotional state: ${ctx.emotionalState || "neutral"}
- Cycle phase: ${ctx.cyclePhase || "unknown"}
${ctx.isPregnant ? `- Pregnant, trimester ${ctx.trimester}` : ""}
${ctx.recentMemories?.length ? `- Recent memories: ${ctx.recentMemories.join("; ")}` : ""}`;

  let userPrompt: string;

  switch (request.requestType) {
    case "message":
      userPrompt = buildMessagePrompt(request);
      break;
    case "sos_coaching":
    case "sos_assessment":
      userPrompt = buildSOSPrompt(request);
      break;
    case "gift":
      userPrompt = buildGiftPrompt(request);
      break;
    case "action_card":
      userPrompt = buildActionCardPrompt(request);
      break;
    default:
      userPrompt = `Generate helpful relationship content for: ${request.requestType}`;
  }

  return { systemPrompt, userPrompt };
}

function buildMessagePrompt(request: AIRequest): string {
  const mode = request.mode || "checking_in";
  const ctx = request.context;

  const modePrompts: Record<string, string> = {
    good_morning: `Write a good morning message to ${ctx.partnerName}. Make it feel personal.`,
    checking_in: `Write a checking-in message to ${ctx.partnerName} showing you are thinking of her.`,
    appreciation: `Write an appreciation message to ${ctx.partnerName}. Be specific about what you value.`,
    motivation: `Write a motivational message to ${ctx.partnerName}. Acknowledge her struggles then uplift.`,
    celebration: `Write a celebration message to ${ctx.partnerName}. Be enthusiastic and genuine.`,
    flirting: `Write a flirty message to ${ctx.partnerName}. Playful but respectful.`,
    reassurance: `Write a reassurance message to ${ctx.partnerName}. She needs to feel safe and valued.`,
    long_distance: `Write a long-distance message to ${ctx.partnerName}. Bridge the gap emotionally.`,
    apology: `Write a sincere apology to ${ctx.partnerName}. Own responsibility. No "but" statements.`,
    after_argument: `Write a post-argument message to ${ctx.partnerName}. Validate her feelings first.`,
  };

  let prompt = modePrompts[mode] || modePrompts.checking_in;
  if (ctx.emotionalState && ctx.emotionalState !== "neutral") {
    prompt += ` She is currently feeling ${ctx.emotionalState}.`;
  }
  return prompt;
}

function buildSOSPrompt(request: AIRequest): string {
  const ctx = request.context;
  return `URGENT SOS: Scenario is "${ctx.sosScenario}". Provide immediate tactical advice.
Give: (1) exactly what to say now, (2) what NOT to say, (3) body language tip, (4) tone advice.
Keep it actionable and concise. He needs help RIGHT NOW.
${ctx.conversationHistory?.length ? `Recent exchange: ${JSON.stringify(ctx.conversationHistory.slice(-3))}` : ""}`;
}

function buildGiftPrompt(request: AIRequest): string {
  const ctx = request.context;
  return `Recommend 3-5 thoughtful gift ideas for ${ctx.partnerName}.
Zodiac: ${ctx.zodiacSign}. Love language: ${ctx.loveLanguage}.
Consider her personality and cultural background (${ctx.culturalBackground}).
Format as JSON array with: name, description, priceRange, whyShellLoveIt.`;
}

function buildActionCardPrompt(request: AIRequest): string {
  const ctx = request.context;
  return `Generate 3 personalized daily action cards for a man to strengthen his relationship with ${ctx.partnerName}.
Each card: { category: "say"|"do"|"buy"|"go", title, description, estimatedMinutes, xpReward }.
Consider: zodiac ${ctx.zodiacSign}, love language ${ctx.loveLanguage}, emotional state ${ctx.emotionalState}.`;
}
