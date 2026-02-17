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

    const systemPrompt = `You are LOLO, an AI relationship coach who truly understands how real men talk to their partners across different cultures. Generate a ${mode} message with a ${tone} tone.

Profile Context:
- The man's name is "${userName}" and his partner is "${partnerName}"
- Relationship status: ${relationshipStatus}${zodiacContext}${ageContext}

CRITICAL LENGTH RULE:
- ${lengthConfig.guide}

Other Rules:
- Write ONLY the message text, no quotes, no labels, no explanations
- Humor level: ${humor}/100 (0=serious, 100=very funny)
- ${includePartnerName !== false ? `Use the partner's name "${partnerName}" naturally in the message` : "Do NOT include any name"}
${culturalContext}
${relationshipContext}
- Never sound like a greeting card or generic AI — sound like a real person who genuinely loves their partner
- Vary sentence structure, use natural pauses, and match how real people text
- Make it feel like something he'd actually send, not something he'd read in a book`;

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
// Cultural context builders
// ============================================================

function buildCulturalContext(language: string, nationality: string): string {
  const nat = nationality.toLowerCase();

  if (language === "ar" || nat.includes("arab") || nat.includes("saudi") || nat.includes("emirati") || nat.includes("uae") || nat.includes("qatar") || nat.includes("kuwait") || nat.includes("bahrain") || nat.includes("oman") || nat.includes("iraqi") || nat.includes("jordan") || nat.includes("egypt") || nat.includes("lebane") || nat.includes("palestin") || nat.includes("morocc") || nat.includes("algeri") || nat.includes("tunis") || nat.includes("libya") || nat.includes("sudan") || nat.includes("yemen") || nat.includes("syria")) {
    const isGulf = nat.includes("saudi") || nat.includes("emirati") || nat.includes("uae") || nat.includes("qatar") || nat.includes("kuwait") || nat.includes("bahrain") || nat.includes("oman");
    const isLevantine = nat.includes("lebane") || nat.includes("jordan") || nat.includes("palestin") || nat.includes("syria");
    const isEgyptian = nat.includes("egypt");
    const isNorthAfrican = nat.includes("morocc") || nat.includes("algeri") || nat.includes("tunis") || nat.includes("libya");

    let dialectNote = "";
    if (isGulf) dialectNote = "Use Gulf Arabic dialect and expressions (e.g., عمري، حياتي، روحي). Reflect Khaleeji romantic culture — reserved but deeply passionate.";
    else if (isEgyptian) dialectNote = "Use Egyptian Arabic dialect and slang (e.g., يا قمر، يا عيوني، يا حبيبتي). Egyptian humor is warm, witty, and self-deprecating.";
    else if (isLevantine) dialectNote = "Use Levantine Arabic dialect (e.g., حياتي، قلبي، يا عمري). Levantine romance is poetic and expressive.";
    else if (isNorthAfrican) dialectNote = "Use North African Arabic dialect naturally. Blend French-Arabic expressions where culturally natural (e.g., mon amour mixed with حبيبتي).";
    else dialectNote = "Use Modern Standard Arabic with natural romantic terms (حبيبتي، يا قلبي، يا عمري).";

    return `Cultural & Language Guide (Arabic):
- Write the message in Arabic script
- ${dialectNote}
- Respect Islamic cultural values — express love passionately but with dignity
- Use terms of endearment naturally: حبيبتي، يا روحي، يا عمري، يا قلبي، نور عيني
- Reference shared cultural touchpoints (family, faith, honor, togetherness)
- Avoid anything that would feel culturally inappropriate or too Western
- The tone should feel like a real Arab man expressing love — not a translation from English`;
  }

  if (language === "ms" || nat.includes("malay") || nat.includes("malaysia") || nat.includes("indonesia") || nat.includes("brunei") || nat.includes("singapor")) {
    const isMalay = nat.includes("malay") || nat.includes("malaysia") || nat.includes("brunei");
    const isIndonesian = nat.includes("indonesia");

    let dialectNote = "";
    if (isIndonesian) dialectNote = "Use Bahasa Indonesia with natural Indonesian romantic expressions (sayang, cinta, sayangku).";
    else if (isMalay) dialectNote = "Use Bahasa Melayu with Malaysian expressions (sayang, abang-adik dynamic, manja culture).";
    else dialectNote = "Use Bahasa Melayu/Malaysia naturally.";

    return `Cultural & Language Guide (Malay):
- Write the message in Malay (Bahasa Melayu)
- ${dialectNote}
- Understand 'manja' culture — the playful, affectionate clinginess that's valued in Malay relationships
- Use natural terms of endearment: sayang, sayangku, cinta, bby, dear
- Respect Malay Muslim cultural values — loving but appropriate
- Reference cultural touchpoints (family bonds, balik kampung, makan together, jalan-jalan)
- Include natural Malay texting style (short forms like 'sy', 'awk', 'sygku' for casual tones)
- The tone should feel authentically Malay — not translated English`;
  }

  // English with nationality context
  let englishCulturalNote = "Write the message in English.";

  if (nat.includes("american") || nat.includes("usa") || nat.includes("us")) {
    englishCulturalNote = `Write in English with an American conversational style. Use casual, confident language. Terms like 'babe', 'baby', 'boo' are natural. Keep it real and direct.`;
  } else if (nat.includes("british") || nat.includes("uk") || nat.includes("english")) {
    englishCulturalNote = `Write in English with a British tone — warm but slightly understated. Dry humor works well. 'Darling', 'love', 'gorgeous' are natural terms.`;
  } else if (nat.includes("australian") || nat.includes("aussie")) {
    englishCulturalNote = `Write in English with an Australian vibe — laid-back, warm, and genuine. 'Babe', 'gorgeous', casual slang is natural. Keep it relaxed.`;
  } else if (nat.includes("indian") || nat.includes("india")) {
    englishCulturalNote = `Write in English but reflect Indian cultural warmth. Reference shared family values, festivals, food memories. 'Jaanu', 'baby', 'sweetheart' work naturally. Mix in a Hindi/Urdu endearment if it feels natural.`;
  } else if (nat.includes("filipin") || nat.includes("philippin")) {
    englishCulturalNote = `Write in English with Filipino warmth. 'Mahal ko', 'babe', 'love' are natural. Filipino romance is expressive and family-oriented. Taglish (Tagalog-English mix) is welcome for casual tones.`;
  } else if (nat.includes("african") || nat.includes("nigeria") || nat.includes("ghana") || nat.includes("kenya") || nat.includes("south africa")) {
    englishCulturalNote = `Write in English with warmth and directness. African romance values respect, commitment, and deep emotional bonds. Be genuine and heartfelt.`;
  } else if (nat.includes("pakist")) {
    englishCulturalNote = `Write in English but reflect Pakistani cultural values. Respect, family, and deep devotion are central. 'Jaanu', 'meri jaan' work as natural endearments.`;
  } else if (nat.includes("turk")) {
    englishCulturalNote = `Write in English but reflect Turkish romantic culture — passionate, protective, deeply devoted. 'Aşkım', 'canım', 'hayatım' can be sprinkled naturally.`;
  }

  return `Cultural & Language Guide:
- ${englishCulturalNote}
- Sound like a real person texting their partner, not a formal letter
- Match modern texting patterns — natural flow, occasional emphasis, authentic emotion
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
