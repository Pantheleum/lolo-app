// functions/src/ai/providers/grok.ts
// Grok uses OpenAI-compatible API via xAI

const GROK_BASE_URL = "https://api.x.ai/v1";

export async function callGrok(
  _modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const response = await fetch(`${GROK_BASE_URL}/chat/completions`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${process.env.XAI_API_KEY}`,
    },
    body: JSON.stringify({
      model: "grok-4.1-fast",
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: userPrompt },
      ],
      max_tokens: maxTokens,
      temperature: 0.7,
    }),
  });

  if (!response.ok) throw new Error(`Grok API error: ${response.status}`);
  const data = await response.json();

  return {
    content: data.choices[0]?.message?.content || "",
    tokensUsed: {
      input: data.usage?.prompt_tokens || 0,
      output: data.usage?.completion_tokens || 0,
    },
  };
}
