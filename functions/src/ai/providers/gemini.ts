// functions/src/ai/providers/gemini.ts
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GOOGLE_AI_API_KEY || "");

export async function callGemini(
  _modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const model = genAI.getGenerativeModel({
    model: "gemini-2.0-flash",
    systemInstruction: systemPrompt,
    generationConfig: { maxOutputTokens: maxTokens, temperature: 0.7 },
  });

  const result = await model.generateContent(userPrompt);
  const response = result.response;
  const usage = response.usageMetadata;

  return {
    content: response.text() || "",
    tokensUsed: {
      input: usage?.promptTokenCount || 0,
      output: usage?.candidatesTokenCount || 0,
    },
  };
}
