// functions/src/scheduled/dailyCards.ts
import * as functions from "firebase-functions/v2";
import { db, redis } from "../config";
import { routeAIRequest } from "../ai/router";
import { sendTemplatedNotification } from "../services/notificationService";
import { AIRequest, SupportedLocale, CardCategory } from "../types";
import { v4 as uuidv4 } from "uuid";

// ============================================================
// Tier card limits
// ============================================================
const CARD_LIMITS: Record<string, number> = { free: 3, pro: 10, legend: 20 };

// ============================================================
// Card type definitions
// ============================================================
interface CardTemplate {
  id: string;
  type: CardCategory;
  titleTemplate: string;
  bodyTemplate: string;
  difficulty: "easy" | "medium" | "challenging";
  xpReward: number;
  tags: string[];
  locales: string[];
}

// ============================================================
// Fallback template library
// ============================================================
const FALLBACK_TEMPLATES: CardTemplate[] = [
  // SAY cards
  { id: "say_001", type: "say", titleTemplate: "Tell her one thing you admire", bodyTemplate: "Think of something specific you admire about {partnerName} -- her laugh, her determination, her kindness -- and tell her directly.", difficulty: "easy", xpReward: 10, tags: ["appreciation", "daily"], locales: ["en", "ar", "ms"] },
  { id: "say_002", type: "say", titleTemplate: "Send a midday check-in", bodyTemplate: "Send {partnerName} a thoughtful message in the middle of the day. Ask about something specific she mentioned recently.", difficulty: "easy", xpReward: 10, tags: ["communication", "daily"], locales: ["en", "ar", "ms"] },
  { id: "say_003", type: "say", titleTemplate: "Express gratitude for something small", bodyTemplate: "Thank {partnerName} for something she did recently that you may have overlooked. Small things matter most.", difficulty: "easy", xpReward: 10, tags: ["gratitude", "daily"], locales: ["en", "ar", "ms"] },
  // DO cards
  { id: "do_001", type: "do", titleTemplate: "Handle one of her chores today", bodyTemplate: "Take over one task that {partnerName} usually handles. Do it without being asked and without expecting praise.", difficulty: "easy", xpReward: 15, tags: ["acts_of_service", "daily"], locales: ["en", "ar", "ms"] },
  { id: "do_002", type: "do", titleTemplate: "Plan a surprise mini-date", bodyTemplate: "Organize something simple but thoughtful: coffee at her favorite spot, a sunset walk, or her favorite takeout with candles.", difficulty: "medium", xpReward: 20, tags: ["quality_time", "weekly"], locales: ["en", "ar", "ms"] },
  { id: "do_003", type: "do", titleTemplate: "Create a playlist for her", bodyTemplate: "Build a playlist of songs that remind you of {partnerName} or songs she loves. Share it with a personal note.", difficulty: "easy", xpReward: 15, tags: ["thoughtful", "creative"], locales: ["en", "ar", "ms"] },
  // BUY cards
  { id: "buy_001", type: "buy", titleTemplate: "Get her favorite snack", bodyTemplate: "Pick up {partnerName}'s favorite treat on your way home. No occasion needed -- just because.", difficulty: "easy", xpReward: 10, tags: ["gifts", "simple"], locales: ["en", "ar", "ms"] },
  { id: "buy_002", type: "buy", titleTemplate: "Order flowers for no reason", bodyTemplate: "Surprise {partnerName} with her favorite flowers. If you don't know her favorite, ask -- she will love that you cared to ask.", difficulty: "medium", xpReward: 20, tags: ["gifts", "romantic"], locales: ["en", "ar", "ms"] },
  // GO cards
  { id: "go_001", type: "go", titleTemplate: "Take a walk together tonight", bodyTemplate: "After dinner, suggest a walk together. Leave your phones behind. Just be present with {partnerName}.", difficulty: "easy", xpReward: 15, tags: ["quality_time", "health"], locales: ["en", "ar", "ms"] },
  { id: "go_002", type: "go", titleTemplate: "Visit somewhere she mentioned", bodyTemplate: "Remember that cafe, park, or shop {partnerName} mentioned wanting to visit? Take her there this weekend.", difficulty: "medium", xpReward: 25, tags: ["quality_time", "listening"], locales: ["en", "ar", "ms"] },
];

// ============================================================
// Context factor analysis
// ============================================================
interface UserContext {
  partnerName: string;
  zodiacSign: string | null;
  loveLanguage: string | null;
  culturalBackground: string | null;
  religiousObservance: string | null;
  currentStreak: number;
  recentCardTypes: CardCategory[];
  upcomingReminders: { title: string; daysUntil: number; type: string }[];
  locale: SupportedLocale;
  tier: string;
}

async function gatherUserContext(userId: string): Promise<UserContext | null> {
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists) return null;
  const userData = userDoc.data()!;

  // Get partner profile
  const profilesSnap = await db.collection("users").doc(userId)
    .collection("partnerProfiles")
    .where("deletedAt", "==", null).limit(1).get();

  let partnerName = "her";
  let zodiacSign = null;
  let loveLanguage = null;
  let culturalBackground = null;
  let religiousObservance = null;

  if (!profilesSnap.empty) {
    const profile = profilesSnap.docs[0].data();
    partnerName = profile.name || "her";
    zodiacSign = profile.zodiacSign || null;
    loveLanguage = profile.loveLanguage || null;
    culturalBackground = profile.culturalContext?.background || null;
    religiousObservance = profile.culturalContext?.religiousObservance || null;
  }

  // Get gamification data
  const gamDoc = await db.collection("gamification").doc(userId).get();
  const currentStreak = gamDoc.exists ? gamDoc.data()!.currentStreak || 0 : 0;

  // Get recent card types (last 7 days) for diversity
  const weekAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString();
  const recentCardsSnap = await db.collection("users").doc(userId)
    .collection("actionCards")
    .where("createdAt", ">=", weekAgo)
    .orderBy("createdAt", "desc").limit(20).get();

  const recentCardTypes = recentCardsSnap.docs.map((d) => d.data().type as CardCategory);

  // Get upcoming reminders (next 7 days)
  const now = new Date();
  const weekLater = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);
  const remindersSnap = await db.collection("users").doc(userId)
    .collection("reminders")
    .where("deletedAt", "==", null)
    .where("completed", "==", false)
    .where("date", ">=", now.toISOString().split("T")[0])
    .where("date", "<=", weekLater.toISOString().split("T")[0])
    .orderBy("date", "asc").limit(5).get();

  const upcomingReminders = remindersSnap.docs.map((d) => {
    const r = d.data();
    const daysUntil = Math.ceil((new Date(r.date).getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
    return { title: r.title, daysUntil, type: r.category };
  });

  return {
    partnerName, zodiacSign, loveLanguage,
    culturalBackground, religiousObservance,
    currentStreak, recentCardTypes, upcomingReminders,
    locale: userData.language || "en",
    tier: userData.tier || "free",
  };
}

// ============================================================
// AI-powered card generation
// ============================================================
async function generateCardsWithAI(
  userId: string, context: UserContext, count: number
): Promise<CardTemplate[]> {
  const aiRequest: AIRequest = {
    requestId: uuidv4(), userId, tier: context.tier as any,
    requestType: "action_card",
    parameters: { tone: "warm", length: "short", language: context.locale },
    context: {
      partnerName: context.partnerName,
      relationshipStatus: "married",
      zodiacSign: context.zodiacSign as any,
      loveLanguage: context.loveLanguage as any,
      culturalBackground: context.culturalBackground || undefined,
      religiousObservance: context.religiousObservance as any,
      emotionalState: "neutral",
    },
    timestamp: new Date().toISOString(),
  };

  try {
    const response = await routeAIRequest(aiRequest);

    // Parse AI response into card templates
    const parsed = parseAICardResponse(response.content, context.partnerName);
    return parsed.slice(0, count);
  } catch (err) {
    functions.logger.warn("AI card generation failed, using fallback", { userId, error: err });
    return [];
  }
}

function parseAICardResponse(content: string, partnerName: string): CardTemplate[] {
  try {
    // Try to parse JSON from AI response
    const jsonMatch = content.match(/\[[\s\S]*\]/);
    if (!jsonMatch) return [];

    const parsed = JSON.parse(jsonMatch[0]);
    return parsed.map((card: any, idx: number) => ({
      id: `ai_${Date.now()}_${idx}`,
      type: (card.category || card.type || "do").toLowerCase() as CardCategory,
      titleTemplate: card.title || "Daily action",
      bodyTemplate: (card.description || card.body || "").replace(/\{name\}/g, `{partnerName}`),
      difficulty: card.difficulty || "easy",
      xpReward: card.xpReward || 15,
      tags: card.tags || ["ai_generated"],
      locales: ["en", "ar", "ms"],
    }));
  } catch {
    return [];
  }
}

// ============================================================
// Cultural filtering
// ============================================================
function filterCardsByCulture(
  cards: CardTemplate[], context: UserContext
): CardTemplate[] {
  return cards.filter((card) => {
    // Check locale support
    if (!card.locales.includes(context.locale)) return false;

    // Cultural sensitivity filters
    if (context.religiousObservance === "high") {
      // During Ramadan-related periods, avoid food/drink BUY cards
      if (card.type === "buy" && card.tags.includes("food")) return false;
      // Avoid overly physical suggestions
      if (card.tags.includes("physical")) return false;
    }

    return true;
  });
}

// ============================================================
// Card type mix ensuring diversity
// ============================================================
function selectDiverseCards(
  available: CardTemplate[], count: number, recentTypes: CardCategory[]
): CardTemplate[] {
  const typeTargets: CardCategory[] = ["say", "do", "buy", "go"];
  const selected: CardTemplate[] = [];
  const used = new Set<string>();

  // First pass: ensure at least one of each underrepresented type
  const recentCounts: Record<string, number> = { say: 0, do: 0, buy: 0, go: 0 };
  recentTypes.forEach((t) => { if (recentCounts[t] !== undefined) recentCounts[t]++; });

  // Sort types by least recent usage
  const sortedTypes = typeTargets.sort((a, b) => recentCounts[a] - recentCounts[b]);

  for (const type of sortedTypes) {
    if (selected.length >= count) break;
    const candidates = available.filter((c) => c.type === type && !used.has(c.id));
    if (candidates.length > 0) {
      const pick = candidates[Math.floor(Math.random() * candidates.length)];
      selected.push(pick);
      used.add(pick.id);
    }
  }

  // Fill remaining slots
  const remaining = available.filter((c) => !used.has(c.id));
  while (selected.length < count && remaining.length > 0) {
    const idx = Math.floor(Math.random() * remaining.length);
    selected.push(remaining[idx]);
    remaining.splice(idx, 1);
  }

  return selected;
}

// ============================================================
// Main daily generation function (enhanced)
// ============================================================
export const dailyCardsGeneration = functions.scheduler.onSchedule(
  { schedule: "0 * * * *", timeoutSeconds: 300, memory: "1GiB" },
  async () => {
    const now = new Date();
    const currentHourUTC = now.getUTCHours();
    const todayStr = now.toISOString().split("T")[0];

    // Find users whose local midnight matches this UTC hour
    const targetOffset = -currentHourUTC;

    const usersSnap = await db.collection("users")
      .where("settings.timezoneOffset", "==", targetOffset).get();

    let generated = 0;
    let skipped = 0;
    let failed = 0;

    for (const userDoc of usersSnap.docs) {
      const userId = userDoc.id;

      try {
        // Check if cards already generated today
        const existing = await db.collection("users").doc(userId)
          .collection("actionCards")
          .where("date", "==", todayStr).limit(1).get();
        if (!existing.empty) { skipped++; continue; }

        const context = await gatherUserContext(userId);
        if (!context) { skipped++; continue; }

        const cardCount = Math.min(
          CARD_LIMITS[context.tier] || 3,
          8 // Max 8 cards per day even for Legend
        );

        // Step 1: Try AI generation for personalized cards
        let aiCards = await generateCardsWithAI(userId, context, cardCount);

        // Step 2: Cultural filtering
        aiCards = filterCardsByCulture(aiCards, context);

        // Step 3: Supplement with fallback templates if AI returned fewer cards
        let allCards = [...aiCards];
        if (allCards.length < cardCount) {
          const fallbacks = filterCardsByCulture(FALLBACK_TEMPLATES, context);
          const aiIds = new Set(allCards.map((c) => c.id));
          const availableFallbacks = fallbacks.filter((f) => !aiIds.has(f.id));
          allCards = [...allCards, ...availableFallbacks];
        }

        // Step 4: Select diverse mix
        const selectedCards = selectDiverseCards(allCards, cardCount, context.recentCardTypes);

        // Step 5: Store cards
        const batch = db.batch();
        const cardDocs: any[] = [];

        for (const card of selectedCards) {
          const cardId = uuidv4();
          const title = card.titleTemplate.replace(/\{partnerName\}/g, context.partnerName);
          const body = card.bodyTemplate.replace(/\{partnerName\}/g, context.partnerName);

          const cardData = {
            type: card.type.toUpperCase(),
            title, body,
            context: `Generated based on partner profile and relationship context`,
            difficulty: card.difficulty,
            status: "pending",
            xpReward: card.xpReward,
            date: todayStr,
            partnerProfileId: null,
            templateId: card.id,
            tags: card.tags,
            expiresAt: new Date(now.getTime() + 24 * 60 * 60 * 1000).toISOString(),
            createdAt: now.toISOString(),
            completedAt: null,
          };

          const ref = db.collection("users").doc(userId)
            .collection("actionCards").doc(cardId);
          batch.set(ref, cardData);
          cardDocs.push({ id: cardId, ...cardData });
        }

        await batch.commit();

        // Step 6: Send notification
        await sendTemplatedNotification(
          userId, "daily_action_cards",
          { partnerName: context.partnerName },
          context.locale,
          { type: "action_cards", date: todayStr }
        );

        // Step 7: Cache for quick retrieval
        await redis.setex(
          `action-cards:daily:${userId}:${todayStr}`,
          43200,
          JSON.stringify({ data: { date: todayStr, cards: cardDocs, summary: { totalCards: cardDocs.length, completedToday: 0, totalXpAvailable: cardDocs.reduce((sum, c) => sum + c.xpReward, 0) } } })
        );

        generated++;
      } catch (err) {
        functions.logger.error("Failed to generate cards for user", { userId, error: err });
        failed++;
      }
    }

    functions.logger.info("Daily cards generation complete", { generated, skipped, failed });
  }
);
