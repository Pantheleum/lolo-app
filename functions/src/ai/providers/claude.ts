// functions/src/ai/providers/claude.ts
import Anthropic from "@anthropic-ai/sdk";

let _client: Anthropic | null = null;
function getClient(): Anthropic {
  if (!_client) _client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY || "" });
  return _client;
}

const MODEL_MAP: Record<string, string> = {
  "claude-sonnet-4.5": "claude-sonnet-4-5-20250514",
  "claude-haiku-4.5": "claude-haiku-4-5-20250514",
};

export async function callClaude(
  modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const response = await getClient().messages.create({
    model: MODEL_MAP[modelId] || MODEL_MAP["claude-haiku-4.5"],
    max_tokens: maxTokens,
    system: systemPrompt,
    messages: [{ role: "user", content: userPrompt }],
  });

  const textBlock = response.content.find((b) => b.type === "text");
  return {
    content: textBlock?.text || "",
    tokensUsed: {
      input: response.usage.input_tokens,
      output: response.usage.output_tokens,
    },
  };
}
