// functions/src/api/messages.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { callGpt } from "../ai/providers/gpt";

const router = Router();

// ============================================================
// POST /messages/generate — generate an AI message using GPT-4o-mini
// ============================================================
router.post("/generate", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const {
      mode,
      tone,
      length,
      language,
      includePartnerName,
      contextText,
      humorLevel,
    } = req.body;

    if (!mode || !tone) {
      throw new AppError(400, "MISSING_FIELDS", "mode and tone are required");
    }

    // Get user profile data for cultural context
    const userDoc = await db.collection("users").doc(uid).get();
    const userData = userDoc.data() || {};
    const partnerName = userData.partnerNickname || userData.partnerName || "her";
    const userName = userData.displayName || "King";
    const nationality = userData.partnerNationality || userData.nationality || "";
    const partnerZodiac = userData.partnerZodiac || "";
    const relationshipStatus = userData.relationshipStatus || "dating";

    // Calculate partner age from birthday
    let partnerAge = 0;
    if (userData.partnerBirthday) {
      const bday = userData.partnerBirthday.toDate ? userData.partnerBirthday.toDate() : new Date(userData.partnerBirthday);
      const today = new Date();
      partnerAge = today.getFullYear() - bday.getFullYear();
      const m = today.getMonth() - bday.getMonth();
      if (m < 0 || (m === 0 && today.getDate() < bday.getDate())) partnerAge--;
    }

    const msgLength = length || "medium";
    const msgLanguage = language || req.locale || "en";
    const humor = humorLevel || 50;

    // Explicit length constraints with word counts + token limits
    const lengthConfig = msgLength === "short"
      ? { guide: "MAXIMUM 1-2 short sentences. Keep it under 25 words total. Think text message — punchy, brief, impactful. Do NOT write more than 2 sentences.", maxTokens: 80 }
      : msgLength === "long"
        ? { guide: "Write 5-8 sentences, a full heartfelt paragraph. Aim for 80-150 words. Take your time, build emotion, let the feelings breathe. This should feel like a love letter.", maxTokens: 500 }
        : { guide: "Write 2-4 sentences. Aim for 30-60 words. Enough to express the feeling fully but still concise.", maxTokens: 200 };

    // Build rich cultural context based on language + nationality
    const culturalContext = buildCulturalContext(msgLanguage, nationality);
    const relationshipContext = buildRelationshipContext(relationshipStatus);
    const zodiacContext = partnerZodiac
      ? `\n- The partner's zodiac sign is ${partnerZodiac}. Subtly reflect traits they'd appreciate (e.g., Scorpio values depth, Leo loves being admired, Pisces craves emotional vulnerability).`
      : "";

    const ageContext = partnerAge > 0
      ? `\n- The partner is ${partnerAge} years old. Tailor the language, references, and cultural touchpoints to her generation (e.g., a 22-year-old uses different slang than a 35-year-old). Match her vibe.`
      : "";

    // Build tone guide with explicit descriptions
    const toneGuide = buildToneGuide(tone, humor);

    const systemPrompt = `You are LOLO, an AI relationship coach who truly understands how real men talk to their partners across different cultures.

TASK: Generate a ${mode} message.

=== CRITICAL RULES (MUST FOLLOW) ===

1. TONE — ${toneGuide}

2. HUMOR — Level ${humor}/100:
${humor <= 15 ? "- Zero humor. Completely serious, deep, and emotionally raw. No jokes, no playfulness, no wit." : humor <= 35 ? "- Mostly serious with warm sincerity. Very subtle warmth at most — no actual jokes or puns." : humor <= 65 ? "- Balanced. Mix sincerity with light playfulness. A gentle tease or warm joke is fine, but don't overdo it." : humor <= 85 ? "- Noticeably funny. Use wit, playful teasing, inside-joke energy, or clever wordplay. Make her laugh AND feel loved." : "- Maximum humor. Be hilarious — bold jokes, funny exaggeration, meme-worthy lines, playful sarcasm. Still loving, but entertainment first."}

3. LENGTH — ${lengthConfig.guide}

4. LANGUAGE — ${buildLanguageInstruction(msgLanguage, nationality)}

=== PROFILE CONTEXT ===
- The man's name is "${userName}" and his partner is "${partnerName}"
- Relationship status: ${relationshipStatus}${zodiacContext}${ageContext}
- ${includePartnerName !== false ? `Use the partner's name "${partnerName}" naturally` : "Do NOT include any name"}

${culturalContext}
${relationshipContext}

=== OUTPUT RULES ===
- Write ONLY the message text — no quotes, no labels, no explanations, no "Here's a message:"
- Never sound like a greeting card or generic AI
- Sound like a real person who genuinely loves their partner
- Vary sentence structure, use natural pauses, match how real people text`;

    const userPrompt = contextText
      ? `Generate a ${mode} message. Additional context: ${contextText}`
      : `Generate a ${mode} message for my partner.`;

    const startTime = Date.now();
    const result = await callGpt("gpt-4o-mini", systemPrompt, userPrompt, lengthConfig.maxTokens);
    const latencyMs = Date.now() - startTime;

    const messageId = uuidv4();
    const now = new Date().toISOString();

    const messageData = {
      mode,
      tone,
      length: msgLength,
      language: msgLanguage,
      content: result.content,
      isFavorite: false,
      rating: 0,
      status: "generated",
      metadata: {
        modelUsed: "gpt-4o-mini",
        tokensUsed: result.tokensUsed,
        latencyMs,
        cached: false,
      },
      createdAt: now,
      updatedAt: now,
    };

    await db
      .collection("users")
      .doc(uid)
      .collection("messages")
      .doc(messageId)
      .set(messageData);

    res.status(201).json({
      data: {
        id: messageId,
        content: result.content,
        mode,
        tone,
        length: msgLength,
        languageCode: msgLanguage,
        modelBadge: "GPT-4o mini",
        isFavorite: false,
        rating: 0,
        includePartnerName: includePartnerName !== false,
        createdAt: now,
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// GET /messages/history — returns message history with pagination
// ============================================================
router.get("/history", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { mode, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(uid)
      .collection("messages")
      .orderBy("createdAt", "desc");

    if (mode) {
      query = query.where("mode", "==", mode);
    }

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(uid)
        .collection("messages")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    const snapshot = await query.limit(limit + 1).get();
    const hasMore = snapshot.docs.length > limit;
    const docs = hasMore ? snapshot.docs.slice(0, limit) : snapshot.docs;

    const messages = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        mode: d.mode,
        tone: d.tone,
        content: d.content,
        language: d.language,
        feedbackRating: d.feedbackRating || null,
        createdAt: d.createdAt,
      };
    });

    const response = {
      data: messages,
      pagination: {
        hasMore,
        lastDocId: docs.length > 0 ? docs[docs.length - 1].id : null,
        count: messages.length,
      },
    };

    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /messages/:id/feedback — saves feedback rating for a message
// ============================================================
router.post("/:id/feedback", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const messageId = req.params.id;
    const { rating, comment } = req.body;

    if (rating === undefined || rating === null) {
      throw new AppError(400, "MISSING_FIELDS", "rating is required");
    }

    if (typeof rating !== "number" || rating < 1 || rating > 5) {
      throw new AppError(400, "INVALID_RATING", "rating must be a number between 1 and 5");
    }

    const messageRef = db
      .collection("users")
      .doc(uid)
      .collection("messages")
      .doc(messageId);

    const messageDoc = await messageRef.get();
    if (!messageDoc.exists) {
      throw new AppError(404, "MESSAGE_NOT_FOUND", "Message not found");
    }

    await messageRef.update({
      feedbackRating: rating,
      feedbackComment: comment || null,
      feedbackAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    });

    res.json({
      data: {
        messageId,
        rating,
        comment: comment || null,
        feedbackAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// Tone guide builder
// ============================================================
function buildToneGuide(tone: string, humor: number): string {
  const toneDescriptions: Record<string, string> = {
    heartfelt: "Deeply sincere and emotionally vulnerable. Speak from the heart — let her feel how much she means to you. Use intimate language, emotional depth, and genuine warmth.",
    playful: "Fun, flirty, and lighthearted. Tease her gently, use inside-joke vibes, be cheeky. Think texting her with a grin on your face.",
    direct: "Straightforward and confident. Say exactly what you mean — no metaphors, no beating around the bush. Bold, honest, and clear. Think 'I want you to know this' energy.",
    poetic: "Beautifully expressive and lyrical. Use vivid imagery, metaphors, and elegant language. Think love letters, moonlight comparisons, deep emotional symbolism. Make her feel like she's in a poem.",
    romantic: "Passionately romantic. Think stolen glances, 'you take my breath away' energy. Make her heart skip a beat.",
    apologetic: "Genuinely sorry and humble. Take full responsibility. No excuses — sincere remorse and commitment to do better.",
    supportive: "Encouraging and comforting. Be her rock. Lift her up with words that make her feel safe and empowered.",
    seductive: "Subtly alluring and magnetic. Build tension with carefully chosen words. Confident, suggestive but tasteful.",
    grateful: "Full of appreciation. Tell her specifically what she does that matters. Acknowledge things others might overlook.",
    missing: "Longing and missing her deeply. Express how incomplete things feel without her. Make her feel present in your thoughts.",
  };

  return toneDescriptions[tone] || `The tone should be ${tone}. Make every word reflect this mood clearly.`;
}

// ============================================================
// Language instruction builder (separate from cultural context)
// ============================================================
function buildLanguageInstruction(language: string, nationality: string): string {
  const nat = nationality.toLowerCase();

  if (language === "ar") {
    // Arabic language selected — determine dialect from nationality
    const isGulf = nat.includes("saudi") || nat.includes("emirati") || nat.includes("uae") || nat.includes("qatar") || nat.includes("kuwait") || nat.includes("bahrain") || nat.includes("oman");
    const isEgyptian = nat.includes("egypt");
    const isLevantine = nat.includes("lebane") || nat.includes("jordan") || nat.includes("palestin") || nat.includes("syria");
    const isNorthAfrican = nat.includes("morocc") || nat.includes("algeri") || nat.includes("tunis") || nat.includes("libya");

    let dialect = "Modern Standard Arabic";
    if (isGulf) dialect = "Gulf Arabic (Khaleeji) dialect";
    else if (isEgyptian) dialect = "Egyptian Arabic dialect";
    else if (isLevantine) dialect = "Levantine Arabic dialect";
    else if (isNorthAfrican) dialect = "North African Arabic dialect";

    return `WRITE THE ENTIRE MESSAGE IN ARABIC SCRIPT. Use ${dialect}. Do NOT write in English or any other language.`;
  }

  if (language === "ms") {
    const isIndonesian = nat.includes("indonesia");
    const dialect = isIndonesian ? "Bahasa Indonesia" : "Bahasa Melayu";
    return `WRITE THE ENTIRE MESSAGE IN ${dialect.toUpperCase()}. Do NOT write in English or any other language.`;
  }

  // English (default) — MUST be in English regardless of nationality
  return "WRITE THE ENTIRE MESSAGE IN ENGLISH. Even if the partner is from a non-English speaking country, the message MUST be in English. You may sprinkle 1-2 foreign endearments if culturally relevant, but the core message must be in English.";
}

// ============================================================
// Cultural context builder (provides cultural flavor, NOT language)
// ============================================================
function buildCulturalContext(language: string, nationality: string): string {
  const nat = nationality.toLowerCase();

  // Arabic cultural context
  const isArabNat = nat.includes("arab") || nat.includes("saudi") || nat.includes("emirati") || nat.includes("uae") || nat.includes("qatar") || nat.includes("kuwait") || nat.includes("bahrain") || nat.includes("oman") || nat.includes("iraqi") || nat.includes("jordan") || nat.includes("egypt") || nat.includes("lebane") || nat.includes("palestin") || nat.includes("morocc") || nat.includes("algeri") || nat.includes("tunis") || nat.includes("libya") || nat.includes("sudan") || nat.includes("yemen") || nat.includes("syria");

  if (isArabNat) {
    const isGulf = nat.includes("saudi") || nat.includes("emirati") || nat.includes("uae") || nat.includes("qatar") || nat.includes("kuwait") || nat.includes("bahrain") || nat.includes("oman");
    const isEgyptian = nat.includes("egypt");
    const isLevantine = nat.includes("lebane") || nat.includes("jordan") || nat.includes("palestin") || nat.includes("syria");
    const isNorthAfrican = nat.includes("morocc") || nat.includes("algeri") || nat.includes("tunis") || nat.includes("libya");

    let flavorNote = "";
    if (isGulf) flavorNote = "Khaleeji romantic culture — reserved but deeply passionate. Endearments: عمري، حياتي، روحي.";
    else if (isEgyptian) flavorNote = "Egyptian humor is warm, witty, and self-deprecating. Endearments: يا قمر، يا عيوني، يا حبيبتي.";
    else if (isLevantine) flavorNote = "Levantine romance is poetic and deeply expressive. Endearments: حياتي، قلبي، يا عمري.";
    else if (isNorthAfrican) flavorNote = "North African culture blends Arabic and French naturally. Mon amour mixed with حبيبتي is natural.";
    else flavorNote = "Arab romance values dignity, devotion, and family honor.";

    return `=== CULTURAL CONTEXT (Arab) ===
- ${flavorNote}
- Respect Islamic cultural values — express love passionately but with dignity
- Reference shared cultural touchpoints (family, faith, togetherness)
- Avoid anything culturally inappropriate or too Western
- The message should feel authentic to Arab culture, not a translation`;
  }

  // Malay/Indonesian cultural context
  const isMalayNat = nat.includes("malay") || nat.includes("malaysia") || nat.includes("indonesia") || nat.includes("brunei") || nat.includes("singapor");
  if (isMalayNat) {
    const isIndonesian = nat.includes("indonesia");

    return `=== CULTURAL CONTEXT (${isIndonesian ? "Indonesian" : "Malay"}) ===
- Understand 'manja' culture — playful, affectionate clinginess valued in relationships
- Natural endearments: sayang, sayangku, cinta${isIndonesian ? "" : ", abang-adik dynamic"}
- Respect Muslim cultural values — loving but appropriate
- Reference cultural touchpoints (family bonds, makan together, jalan-jalan)
- ${language === "ms" ? "Use natural texting style (short forms like 'sy', 'awk', 'sygku' for casual)" : "Sprinkle Malay endearments naturally into English"}`;
  }

  // English-speaking nationality context
  if (nat.includes("american") || nat.includes("usa")) {
    return `=== CULTURAL CONTEXT (American) ===
- Casual, confident language. 'Babe', 'baby', 'boo' are natural terms.
- Keep it real and direct — Americans value authenticity over formality.`;
  }
  if (nat.includes("british") || nat.includes("uk")) {
    return `=== CULTURAL CONTEXT (British) ===
- Warm but slightly understated. Dry humor works well.
- 'Darling', 'love', 'gorgeous' are natural terms.`;
  }
  if (nat.includes("indian") || nat.includes("india")) {
    return `=== CULTURAL CONTEXT (Indian) ===
- Reflect Indian cultural warmth — family values, festivals, food memories.
- 'Jaanu', 'baby', 'sweetheart' work naturally. Mix in Hindi/Urdu endearments.`;
  }
  if (nat.includes("pakist")) {
    return `=== CULTURAL CONTEXT (Pakistani) ===
- Reflect Pakistani cultural values — respect, family, deep devotion.
- 'Jaanu', 'meri jaan' are natural endearments.`;
  }
  if (nat.includes("turk")) {
    return `=== CULTURAL CONTEXT (Turkish) ===
- Turkish romance is passionate, protective, deeply devoted.
- 'Aşkım', 'canım', 'hayatım' can be sprinkled naturally.`;
  }
  if (nat.includes("filipin") || nat.includes("philippin")) {
    return `=== CULTURAL CONTEXT (Filipino) ===
- Filipino romance is expressive and family-oriented.
- 'Mahal ko', 'babe', 'love' are natural. Taglish welcome for casual tones.`;
  }

  // Generic
  return `=== CULTURAL CONTEXT ===
- Sound like a real person texting their partner
- Match modern texting patterns — natural flow, authentic emotion
- Avoid clichés that sound AI-generated`;
}

function buildRelationshipContext(status: string): string {
  switch (status) {
    case "married":
      return `Relationship Context:
- They are married — messages can reference deep history, shared life, growing together
- Tone can be more intimate and settled — the comfort of long love
- Reference "our home", "our life", "growing old together" naturally`;
    case "engaged":
      return `Relationship Context:
- They are engaged — excitement about the future, wedding anticipation
- Blend romantic depth with forward-looking joy
- "Future wife", "can't wait to marry you" type energy when appropriate`;
    default:
      return `Relationship Context:
- They are dating — messages should feel fresh, exciting, full of discovery
- The butterflies-in-stomach energy, wanting to impress, showing vulnerability
- Keep it passionate but not presumptuous about the future`;
  }
}

export default router;
