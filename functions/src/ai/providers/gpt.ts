// functions/src/ai/providers/gpt.ts
import OpenAI from "openai";

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

export async function callGpt(
  _modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const response = await openai.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [
      { role: "system", content: systemPrompt },
      { role: "user", content: userPrompt },
    ],
    max_tokens: maxTokens,
    temperature: 0.7,
  });

  return {
    content: response.choices[0]?.message?.content || "",
    tokensUsed: {
      input: response.usage?.prompt_tokens || 0,
      output: response.usage?.completion_tokens || 0,
    },
  };
}
