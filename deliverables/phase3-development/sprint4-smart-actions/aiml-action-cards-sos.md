# LOLO Sprint 4 -- Action Cards Engine, SOS Mode AI & Batch Processing

**Document ID:** LOLO-DEV-S4-002
**Author:** Dr. Aisha Mahmoud, AI/ML Engineer
**Date:** 2026-02-15
**Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 4 -- Smart Actions (Weeks 15-16)
**Dependencies:** AI Strategy (LOLO-AI-001), AI Router Client (LOLO-DEV-S3-002), API Contracts v1.0, Action Card Scenarios (PSY-003), Firebase Schema v1.0

---

> **Purpose:** Production-ready TypeScript backend implementation of the Smart Action Cards Engine, SOS Mode AI, and Batch Processing pipeline. All code runs as Firebase Cloud Functions behind the AI Router at `/api/v1/ai/route`. The Flutter client never calls AI models directly.

---

## Part 1: Smart Action Cards Engine

### 1.1 Context Fusion Types

```typescript
// FILE: functions/src/ai/action-cards/types.ts

export type CardCategory =
  | 'romantic_gesture'
  | 'practical_help'
  | 'quality_time'
  | 'words_of_affirmation'
  | 'physical_touch'
  | 'gift_suggestion'
  | 'conflict_resolution'
  | 'self_care';

export type CulturalContext = 'western' | 'gulf_arab' | 'levantine' | 'egyptian' | 'malay' | 'south_asian' | 'other';

export interface ActionCardContext {
  userId: string;
  tier: 'free' | 'pro' | 'legend';
  language: 'en' | 'ar' | 'ms';
  dialect?: 'msa' | 'gulf' | 'egyptian' | 'levantine';

  // Partner profile
  partnerName: string;
  zodiacSign?: string;
  loveLanguage?: 'words' | 'acts' | 'gifts' | 'time' | 'touch';
  communicationStyle?: 'direct' | 'indirect' | 'mixed';
  culturalBackground?: CulturalContext;
  religiousObservance?: 'high' | 'moderate' | 'low' | 'secular';

  // Mood signals
  partnerEmotionalState?: string;
  recentMoodTrend?: 'improving' | 'stable' | 'declining';
  cyclePhase?: string;
  isPregnant?: boolean;
  trimester?: number;

  // Event signals
  upcomingEvents: CalendarEvent[];
  isRamadan: boolean;
  isEid: boolean;
  isHariRaya: boolean;
  dayOfWeek: number; // 0=Sun
  timeOfDay: 'morning' | 'afternoon' | 'evening';
  isWeekend: boolean;

  // Conflict signals
  recentConflicts: ConflictSummary[];
  daysSinceLastConflict?: number;

  // History signals
  completedCardIds: string[];
  skippedCardIds: string[];
  recentCardCategories: string[];  // last 7 days
  cardCompletionRate: number;      // 0-1

  // Relationship
  relationshipStatus: 'dating' | 'engaged' | 'married';
  relationshipDurationMonths?: number;

  // Weather (optional enrichment)
  weather?: { condition: string; tempC: number };
}

export interface CalendarEvent {
  type: 'birthday' | 'anniversary' | 'eid' | 'hari_raya' | 'valentines' | 'custom';
  name: string;
  daysUntil: number;
}

export interface ConflictSummary {
  scenario: string;
  severity: number;
  daysAgo: number;
  resolved: boolean;
}

export interface ScoredCandidate {
  category: CardCategory;
  topic: string;
  score: number;
  scores: FusionScores;
  culturallyApproved: boolean;
}

export interface FusionScores {
  mood: number;
  event: number;
  conflict: number;
  personality: number;
  novelty: number;
  timing: number;
}

export interface GeneratedCard {
  id: string;
  type: 'say' | 'do' | 'buy' | 'go';
  category: CardCategory;
  title: string;
  titleLocalized?: string;
  description: string;
  descriptionLocalized?: string;
  personalizedDetail?: string;
  difficulty: 'easy' | 'medium' | 'challenging';
  estimatedTime: string;
  xpReward: number;
  contextTags: string[];
  qualityScore: number;
}
```

### 1.2 Context Fusion Algorithm

```typescript
// FILE: functions/src/ai/action-cards/context-fusion.ts

import {
  ActionCardContext, CardCategory, ScoredCandidate,
  FusionScores, CalendarEvent, ConflictSummary,
} from './types';

const FUSION_WEIGHTS = {
  mood: 0.25,
  event: 0.20,
  conflict: 0.20,
  personality: 0.15,
  novelty: 0.10,
  timing: 0.10,
};

const ALL_CATEGORIES: CardCategory[] = [
  'romantic_gesture', 'practical_help', 'quality_time',
  'words_of_affirmation', 'physical_touch', 'gift_suggestion',
  'conflict_resolution', 'self_care',
];

// Category-to-topic templates for candidate generation
const CATEGORY_TOPICS: Record<CardCategory, string[]> = {
  romantic_gesture: [
    'surprise_love_note', 'plan_date_night', 'recreate_first_date',
    'morning_coffee_bed', 'sunset_walk', 'cook_her_favorite',
  ],
  practical_help: [
    'handle_dinner_tonight', 'take_over_chore', 'run_her_errand',
    'prep_her_lunch', 'organize_shared_space', 'car_maintenance',
  ],
  quality_time: [
    'phone_free_hour', 'ask_about_her_day', 'watch_her_show',
    'learn_her_hobby', 'morning_walk_together', 'weekend_adventure',
  ],
  words_of_affirmation: [
    'specific_compliment', 'appreciation_text', 'proud_of_her',
    'write_short_letter', 'voice_note_love', 'public_acknowledgment',
  ],
  physical_touch: [
    'hold_hands_walking', 'forehead_kiss', 'shoulder_massage',
    'hug_from_behind', 'play_with_hair', 'cuddle_no_agenda',
  ],
  gift_suggestion: [
    'her_favorite_snack', 'flowers_not_roses', 'book_she_mentioned',
    'comfort_item', 'experience_voucher', 'handwritten_card',
  ],
  conflict_resolution: [
    'initiate_repair', 'acknowledge_your_part', 'ask_how_shes_feeling',
    'listen_without_fixing', 'apologize_specifically', 'follow_up_check',
  ],
  self_care: [
    'journal_reflection', 'process_your_feelings', 'identify_your_triggers',
    'practice_active_listening', 'set_phone_boundary', 'plan_solo_recharge',
  ],
};

export function generateCandidates(ctx: ActionCardContext): ScoredCandidate[] {
  const candidates: ScoredCandidate[] = [];

  for (const category of ALL_CATEGORIES) {
    // Skip conflict_resolution if no recent conflicts
    if (category === 'conflict_resolution' && ctx.recentConflicts.length === 0) {
      continue;
    }

    const topics = CATEGORY_TOPICS[category];
    for (const topic of topics) {
      const scores = scoreTopic(category, topic, ctx);
      const totalScore =
        scores.mood * FUSION_WEIGHTS.mood +
        scores.event * FUSION_WEIGHTS.event +
        scores.conflict * FUSION_WEIGHTS.conflict +
        scores.personality * FUSION_WEIGHTS.personality +
        scores.novelty * FUSION_WEIGHTS.novelty +
        scores.timing * FUSION_WEIGHTS.timing;

      const culturallyApproved = passesCulturalFilter(category, topic, ctx);

      candidates.push({
        category,
        topic,
        score: culturallyApproved ? totalScore : 0,
        scores,
        culturallyApproved,
      });
    }
  }

  // Sort descending by score
  candidates.sort((a, b) => b.score - a.score);
  return candidates;
}

function scoreTopic(
  category: CardCategory,
  topic: string,
  ctx: ActionCardContext,
): FusionScores {
  return {
    mood: calcMoodRelevance(category, ctx),
    event: calcEventRelevance(category, topic, ctx),
    conflict: calcConflictRelevance(category, ctx),
    personality: calcPersonalityFit(category, ctx),
    novelty: calcNovelty(category, topic, ctx),
    timing: calcTimingFit(category, topic, ctx),
  };
}

function calcMoodRelevance(cat: CardCategory, ctx: ActionCardContext): number {
  const state = ctx.partnerEmotionalState ?? 'neutral';
  const trend = ctx.recentMoodTrend ?? 'stable';

  const MOOD_MATRIX: Record<string, Record<string, number>> = {
    sad:          { practical_help: 0.9, words_of_affirmation: 0.8, physical_touch: 0.7, self_care: 0.5 },
    stressed:     { practical_help: 1.0, quality_time: 0.6, self_care: 0.8, romantic_gesture: 0.3 },
    angry:        { conflict_resolution: 1.0, self_care: 0.7, words_of_affirmation: 0.4 },
    anxious:      { words_of_affirmation: 0.9, physical_touch: 0.8, practical_help: 0.7 },
    happy:        { romantic_gesture: 0.9, quality_time: 0.8, gift_suggestion: 0.7 },
    excited:      { romantic_gesture: 1.0, quality_time: 0.9, gift_suggestion: 0.8 },
    tired:        { practical_help: 1.0, physical_touch: 0.6, self_care: 0.5, romantic_gesture: 0.2 },
    overwhelmed:  { practical_help: 1.0, self_care: 0.9, words_of_affirmation: 0.7 },
    neutral:      { quality_time: 0.6, romantic_gesture: 0.6, words_of_affirmation: 0.5 },
  };

  let base = MOOD_MATRIX[state]?.[cat] ?? 0.4;

  // Declining mood boosts comfort categories
  if (trend === 'declining') {
    if (['practical_help', 'words_of_affirmation', 'physical_touch'].includes(cat)) {
      base = Math.min(base + 0.2, 1.0);
    }
  }

  // Cycle phase adjustments
  if (ctx.cyclePhase === 'luteal_late' || ctx.cyclePhase === 'menstruation') {
    if (cat === 'practical_help' || cat === 'physical_touch') base = Math.min(base + 0.15, 1.0);
    if (cat === 'romantic_gesture') base = Math.max(base - 0.2, 0);
  }

  return base;
}

function calcEventRelevance(cat: CardCategory, topic: string, ctx: ActionCardContext): number {
  if (ctx.upcomingEvents.length === 0 && !ctx.isRamadan && !ctx.isEid && !ctx.isHariRaya) {
    return 0.3; // No events = neutral
  }

  let score = 0.3;

  for (const evt of ctx.upcomingEvents) {
    if (evt.daysUntil <= 3 && cat === 'gift_suggestion') score = Math.max(score, 1.0);
    if (evt.daysUntil <= 7 && cat === 'romantic_gesture') score = Math.max(score, 0.8);
    if (evt.type === 'anniversary' && cat === 'quality_time') score = Math.max(score, 0.9);
  }

  // Ramadan: boost practical_help, words_of_affirmation; reduce romantic_gesture
  if (ctx.isRamadan) {
    if (cat === 'practical_help') score = Math.max(score, 0.9);
    if (cat === 'words_of_affirmation') score = Math.max(score, 0.8);
    if (cat === 'romantic_gesture') score = Math.min(score, 0.3);
    if (cat === 'physical_touch') score = Math.min(score, 0.2);
  }

  // Eid/Hari Raya: boost gift, romantic, quality_time
  if (ctx.isEid || ctx.isHariRaya) {
    if (cat === 'gift_suggestion') score = Math.max(score, 0.9);
    if (cat === 'quality_time') score = Math.max(score, 0.8);
  }

  return score;
}

function calcConflictRelevance(cat: CardCategory, ctx: ActionCardContext): number {
  if (ctx.recentConflicts.length === 0) return cat === 'conflict_resolution' ? 0 : 0.3;

  const recent = ctx.recentConflicts.filter(c => c.daysAgo <= 3);
  const unresolved = ctx.recentConflicts.filter(c => !c.resolved);

  if (unresolved.length > 0 && cat === 'conflict_resolution') return 1.0;
  if (recent.length > 0 && cat === 'conflict_resolution') return 0.8;

  // Post-conflict: boost repair categories
  if (ctx.daysSinceLastConflict !== undefined && ctx.daysSinceLastConflict <= 2) {
    if (cat === 'words_of_affirmation') return 0.8;
    if (cat === 'practical_help') return 0.7;
    if (cat === 'romantic_gesture') return 0.3; // Too soon
  }

  return 0.3;
}

function calcPersonalityFit(cat: CardCategory, ctx: ActionCardContext): number {
  let score = 0.5;

  // Love language alignment
  const LL_MAP: Record<string, CardCategory[]> = {
    words: ['words_of_affirmation'],
    acts: ['practical_help'],
    gifts: ['gift_suggestion'],
    time: ['quality_time'],
    touch: ['physical_touch'],
  };
  if (ctx.loveLanguage && LL_MAP[ctx.loveLanguage]?.includes(cat)) {
    score += 0.3;
  }

  // Zodiac-based personality nudges
  const ZODIAC_PREFS: Record<string, CardCategory[]> = {
    aries: ['romantic_gesture', 'quality_time'],
    taurus: ['gift_suggestion', 'physical_touch'],
    gemini: ['words_of_affirmation', 'quality_time'],
    cancer: ['physical_touch', 'practical_help'],
    leo: ['romantic_gesture', 'words_of_affirmation'],
    virgo: ['practical_help', 'quality_time'],
    libra: ['romantic_gesture', 'gift_suggestion'],
    scorpio: ['quality_time', 'words_of_affirmation'],
    sagittarius: ['quality_time', 'romantic_gesture'],
    capricorn: ['practical_help', 'words_of_affirmation'],
    aquarius: ['quality_time', 'self_care'],
    pisces: ['romantic_gesture', 'physical_touch'],
  };
  const sign = ctx.zodiacSign?.toLowerCase();
  if (sign && ZODIAC_PREFS[sign]?.includes(cat)) {
    score += 0.15;
  }

  return Math.min(score, 1.0);
}

function calcNovelty(cat: CardCategory, topic: string, ctx: ActionCardContext): number {
  // Penalize categories seen in last 7 days
  const recentCatCount = ctx.recentCardCategories.filter(c => c === cat).length;
  if (recentCatCount === 0) return 1.0;
  if (recentCatCount === 1) return 0.7;
  if (recentCatCount === 2) return 0.4;
  return 0.1;
}

function calcTimingFit(cat: CardCategory, topic: string, ctx: ActionCardContext): number {
  let score = 0.5;

  // Weekend: boost quality_time, romantic_gesture
  if (ctx.isWeekend) {
    if (cat === 'quality_time' || cat === 'romantic_gesture') score += 0.3;
  } else {
    // Weekday: boost practical_help, words_of_affirmation
    if (cat === 'practical_help' || cat === 'words_of_affirmation') score += 0.2;
  }

  // Evening: boost physical_touch, quality_time
  if (ctx.timeOfDay === 'evening') {
    if (cat === 'physical_touch' || cat === 'quality_time') score += 0.15;
  }

  // Morning: boost words_of_affirmation
  if (ctx.timeOfDay === 'morning' && cat === 'words_of_affirmation') {
    score += 0.2;
  }

  return Math.min(score, 1.0);
}

// --- Cultural Filtering ---

function passesCulturalFilter(
  cat: CardCategory,
  topic: string,
  ctx: ActionCardContext,
): boolean {
  const culture = ctx.culturalBackground ?? 'western';
  const observance = ctx.religiousObservance ?? 'moderate';

  // Arabic / Islamic context
  if (['gulf_arab', 'levantine', 'egyptian'].includes(culture)) {
    if (ctx.isRamadan) {
      // No physical_touch or romantic_gesture during Ramadan fasting hours
      if (cat === 'physical_touch') return false;
      if (cat === 'romantic_gesture' && topic.includes('date_night')) return false;
    }
    if (observance === 'high') {
      // No public romantic gestures
      if (topic === 'public_acknowledgment') return false;
      // Physical touch kept private
      if (cat === 'physical_touch' && topic.includes('public')) return false;
    }
  }

  // Malay context
  if (culture === 'malay') {
    if (observance === 'high' || observance === 'moderate') {
      // Modest physical touch suggestions
      if (cat === 'physical_touch' && topic.includes('public')) return false;
    }
    if (ctx.isRamadan) {
      if (cat === 'physical_touch') return false;
    }
  }

  return true;
}
```

### 1.3 Card Generation Pipeline

```typescript
// FILE: functions/src/ai/action-cards/card-generator.ts

import * as admin from 'firebase-admin';
import { v4 as uuidv4 } from 'uuid';
import {
  ActionCardContext, GeneratedCard, ScoredCandidate, CardCategory,
} from './types';
import { generateCandidates } from './context-fusion';
import { callAiRouter } from '../router/ai-router-client';
import { scoreCardQuality } from './quality-scorer';

const CARDS_PER_TIER: Record<string, number> = {
  free: 1, pro: 2, legend: 3,
};

const CARD_TYPE_MAP: Record<CardCategory, string> = {
  romantic_gesture: 'do',
  practical_help: 'do',
  quality_time: 'go',
  words_of_affirmation: 'say',
  physical_touch: 'do',
  gift_suggestion: 'buy',
  conflict_resolution: 'say',
  self_care: 'do',
};

const XP_BY_DIFFICULTY: Record<string, number> = {
  easy: 15, medium: 25, challenging: 40,
};

export async function generateDailyCards(
  ctx: ActionCardContext,
): Promise<GeneratedCard[]> {
  const maxCards = CARDS_PER_TIER[ctx.tier] ?? 1;

  // Step 1: Generate and score candidates
  const candidates = generateCandidates(ctx);

  // Step 2: Filter for variety -- no two cards of same category
  const selected = selectWithVariety(candidates, maxCards);

  // Step 3: Generate content via AI
  const cards: GeneratedCard[] = [];
  for (const candidate of selected) {
    const card = await generateCardContent(candidate, ctx);
    if (card) {
      // Step 4: Quality check
      const quality = scoreCardQuality(card, ctx);
      if (quality >= 50) {
        card.qualityScore = quality;
        cards.push(card);
      } else {
        // Retry once with different prompt emphasis
        const retry = await generateCardContent(candidate, ctx, true);
        if (retry) {
          const retryQuality = scoreCardQuality(retry, ctx);
          if (retryQuality >= 50) {
            retry.qualityScore = retryQuality;
            cards.push(retry);
          }
        }
      }
    }
  }

  return cards;
}

function selectWithVariety(
  candidates: ScoredCandidate[],
  maxCards: number,
): ScoredCandidate[] {
  const selected: ScoredCandidate[] = [];
  const usedCategories = new Set<CardCategory>();

  for (const c of candidates) {
    if (selected.length >= maxCards) break;
    if (!c.culturallyApproved) continue;
    if (usedCategories.has(c.category)) continue;

    selected.push(c);
    usedCategories.add(c.category);
  }

  return selected;
}

async function generateCardContent(
  candidate: ScoredCandidate,
  ctx: ActionCardContext,
  isRetry = false,
): Promise<GeneratedCard | null> {
  const cardType = CARD_TYPE_MAP[candidate.category] ?? 'do';
  const difficulty = inferDifficulty(candidate.category, candidate.topic);

  const prompt = buildCardPrompt(candidate, ctx, cardType, isRetry);

  try {
    const response = await callAiRouter({
      requestType: 'action_card',
      parameters: {
        language: ctx.language,
        dialect: ctx.dialect,
      },
      prompt,
      maxOutputTokens: 300,
      timeout: 5000,
    });

    const parsed = parseCardResponse(response.content);
    if (!parsed) return null;

    return {
      id: uuidv4(),
      type: cardType as GeneratedCard['type'],
      category: candidate.category,
      title: parsed.title,
      titleLocalized: ctx.language !== 'en' ? parsed.title : undefined,
      description: parsed.description,
      descriptionLocalized: ctx.language !== 'en' ? parsed.description : undefined,
      personalizedDetail: parsed.personalizedDetail,
      difficulty,
      estimatedTime: parsed.estimatedTime ?? '15 min',
      xpReward: XP_BY_DIFFICULTY[difficulty],
      contextTags: buildContextTags(candidate, ctx),
      qualityScore: 0, // Set after quality check
    };
  } catch (err) {
    console.error(`Card generation failed for ${candidate.topic}:`, err);
    return null;
  }
}

function buildCardPrompt(
  candidate: ScoredCandidate,
  ctx: ActionCardContext,
  cardType: string,
  isRetry: boolean,
): string {
  const culturalNote = getCulturalNote(ctx);
  const retryNote = isRetry
    ? 'IMPORTANT: Previous attempt was too generic. Be MORE specific and personalized.'
    : '';

  return `Generate a relationship action card for a man to do for his partner.

CARD TYPE: ${cardType.toUpperCase()} card
CATEGORY: ${candidate.category}
TOPIC: ${candidate.topic}

PARTNER CONTEXT:
- Name: ${ctx.partnerName}
- Zodiac: ${ctx.zodiacSign ?? 'unknown'}
- Love Language: ${ctx.loveLanguage ?? 'unknown'}
- Relationship: ${ctx.relationshipStatus}, ${ctx.relationshipDurationMonths ?? '?'} months
- Emotional state: ${ctx.partnerEmotionalState ?? 'neutral'}
- Mood trend: ${ctx.recentMoodTrend ?? 'stable'}
${ctx.cyclePhase ? `- Health context: Be extra gentle and supportive` : ''}

${culturalNote}
${retryNote}

LANGUAGE: ${ctx.language}${ctx.dialect ? ` (${ctx.dialect} dialect)` : ''}

Respond in this JSON format:
{
  "title": "5-8 word title",
  "description": "2-3 sentence guidance. Be specific, actionable, warm.",
  "personalizedDetail": "1 sentence why this matters for her today",
  "estimatedTime": "e.g. 5 min, 30 min, 1 hour"
}

RULES:
1. Use her name (${ctx.partnerName}) in the description.
2. Be SPECIFIC, not generic. Reference her personality.
3. If SAY card, include an actual script he can use.
4. Keep it warm and genuine -- never manipulative.
5. For ${ctx.language === 'ar' ? 'Arabic' : ctx.language === 'ms' ? 'Malay' : 'English'}: write naturally in that language.`;
}

function getCulturalNote(ctx: ActionCardContext): string {
  const culture = ctx.culturalBackground;
  if (!culture) return '';

  if (['gulf_arab', 'levantine', 'egyptian'].includes(culture)) {
    let note = 'CULTURAL: Arabic/Islamic context. Respectful, family-oriented.';
    if (ctx.isRamadan) note += ' Currently Ramadan -- focus on spiritual connection, iftar gestures, acts of service.';
    if (ctx.isEid) note += ' Eid celebration -- festive, generous, family-focused gestures.';
    return note;
  }

  if (culture === 'malay') {
    let note = 'CULTURAL: Malay context. Modest, family-oriented, respectful.';
    if (ctx.isRamadan) note += ' Currently Ramadan -- focus on buka puasa gestures and spiritual support.';
    if (ctx.isHariRaya) note += ' Hari Raya -- festive preparations, family visits, baju raya.';
    return note;
  }

  return '';
}

function inferDifficulty(cat: CardCategory, topic: string): 'easy' | 'medium' | 'challenging' {
  const EASY: CardCategory[] = ['words_of_affirmation', 'self_care'];
  const HARD: CardCategory[] = ['conflict_resolution'];

  if (EASY.includes(cat)) return 'easy';
  if (HARD.includes(cat)) return 'challenging';
  if (topic.includes('plan') || topic.includes('cook') || topic.includes('recreate')) return 'medium';
  return 'medium';
}

function buildContextTags(c: ScoredCandidate, ctx: ActionCardContext): string[] {
  const tags: string[] = [c.category];
  if (ctx.isRamadan) tags.push('ramadan');
  if (ctx.isEid) tags.push('eid');
  if (ctx.isHariRaya) tags.push('hari_raya');
  if (ctx.upcomingEvents.some(e => e.daysUntil <= 7)) tags.push('event_soon');
  if (ctx.recentConflicts.some(c => !c.resolved)) tags.push('active_conflict');
  if (ctx.cyclePhase === 'luteal_late' || ctx.cyclePhase === 'menstruation') tags.push('comfort_mode');
  return tags;
}

function parseCardResponse(raw: string): {
  title: string; description: string;
  personalizedDetail?: string; estimatedTime?: string;
} | null {
  try {
    const cleaned = raw.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim();
    return JSON.parse(cleaned);
  } catch {
    return null;
  }
}

// --- Random Act of Kindness Generator ---

export async function generateRandomActOfKindness(
  ctx: ActionCardContext,
): Promise<GeneratedCard | null> {
  const prompt = `Generate a "Random Act of Kindness" action card for a man to surprise his partner ${ctx.partnerName}.

This should be unexpected, small, and heartfelt. NOT tied to any event or conflict.
The psychology: intermittent reinforcement through unpredictable kindness creates
stronger emotional bonds than predictable routines.

Partner: ${ctx.partnerName} (${ctx.zodiacSign ?? 'unknown'} sign, loves ${ctx.loveLanguage ?? 'quality time'})
Language: ${ctx.language}
${getCulturalNote(ctx)}

Respond in JSON: { "title": "...", "description": "...", "personalizedDetail": "...", "estimatedTime": "..." }

Make it specific to HER. Not generic.`;

  try {
    const response = await callAiRouter({
      requestType: 'action_card',
      parameters: { language: ctx.language, dialect: ctx.dialect },
      prompt,
      maxOutputTokens: 250,
      timeout: 5000,
    });

    const parsed = parseCardResponse(response.content);
    if (!parsed) return null;

    return {
      id: uuidv4(),
      type: 'do',
      category: 'romantic_gesture',
      title: parsed.title,
      description: parsed.description,
      personalizedDetail: parsed.personalizedDetail,
      difficulty: 'easy',
      estimatedTime: parsed.estimatedTime ?? '10 min',
      xpReward: 20,
      contextTags: ['random_kindness', 'surprise'],
      qualityScore: 0,
    };
  } catch {
    return null;
  }
}
```

### 1.4 Quality Scoring Pipeline

```typescript
// FILE: functions/src/ai/action-cards/quality-scorer.ts

import { GeneratedCard, ActionCardContext } from './types';

export function scoreCardQuality(
  card: GeneratedCard,
  ctx: ActionCardContext,
): number {
  let quality = 0;

  // Personalization depth (0-30 points)
  if (card.description.includes(ctx.partnerName)) quality += 10;
  if (ctx.zodiacSign && referencesZodiacTrait(card.description, ctx.zodiacSign)) quality += 10;
  if (card.personalizedDetail && card.personalizedDetail.length > 20) quality += 10;

  // Actionability (0-25 points)
  if (hasConcreteAction(card.description)) quality += 15;
  if (card.estimatedTime && card.estimatedTime !== '') quality += 10;

  // Cultural appropriateness (0-20 points)
  if (passesCulturalQualityCheck(card, ctx)) quality += 20;

  // Novelty -- checked externally, baseline pass (0-15 points)
  quality += 10; // Baseline; real dedup happens in candidate selection

  // Language quality (0-10 points)
  if (card.title.length >= 10 && card.title.length <= 60) quality += 5;
  if (card.description.length >= 50 && card.description.length <= 500) quality += 5;

  return quality; // Range: 0-100, minimum threshold: 50
}

function referencesZodiacTrait(text: string, sign: string): boolean {
  const ZODIAC_KEYWORDS: Record<string, string[]> = {
    aries: ['energy', 'adventure', 'bold', 'fire'],
    taurus: ['comfort', 'luxury', 'sensual', 'stable'],
    gemini: ['conversation', 'curious', 'variety', 'witty'],
    cancer: ['home', 'nurture', 'family', 'safe'],
    leo: ['admire', 'shine', 'confident', 'proud'],
    virgo: ['detail', 'organize', 'thoughtful', 'care'],
    libra: ['beauty', 'harmony', 'balance', 'elegant'],
    scorpio: ['deep', 'intense', 'loyal', 'passion'],
    sagittarius: ['freedom', 'explore', 'adventure', 'fun'],
    capricorn: ['ambition', 'respect', 'achieve', 'goal'],
    aquarius: ['unique', 'independent', 'creative', 'space'],
    pisces: ['dream', 'romantic', 'intuitive', 'gentle'],
  };

  const keywords = ZODIAC_KEYWORDS[sign.toLowerCase()] ?? [];
  const lower = text.toLowerCase();
  return keywords.some(k => lower.includes(k));
}

function hasConcreteAction(description: string): boolean {
  const ACTION_VERBS = [
    'send', 'tell', 'make', 'prepare', 'plan', 'buy', 'write',
    'cook', 'hold', 'take', 'bring', 'organize', 'ask', 'listen',
    'surprise', 'call', 'visit', 'create', 'set up',
  ];
  const lower = description.toLowerCase();
  return ACTION_VERBS.some(v => lower.includes(v));
}

function passesCulturalQualityCheck(card: GeneratedCard, ctx: ActionCardContext): boolean {
  const culture = ctx.culturalBackground ?? 'western';
  const lower = card.description.toLowerCase();

  if (['gulf_arab', 'levantine', 'egyptian'].includes(culture)) {
    // No alcohol references
    if (lower.includes('wine') || lower.includes('beer') || lower.includes('cocktail')) return false;
    // No pork references
    if (lower.includes('pork') || lower.includes('bacon') || lower.includes('ham')) return false;
    // During Ramadan, no food gifts during fasting hours
    if (ctx.isRamadan && card.category === 'gift_suggestion' && lower.includes('lunch')) return false;
  }

  if (culture === 'malay') {
    if (lower.includes('wine') || lower.includes('beer') || lower.includes('alcohol')) return false;
    if (lower.includes('pork')) return false;
  }

  return true;
}
```

### 1.5 Card Scoring & Ranking API Handler

```typescript
// FILE: functions/src/api/action-cards/get-daily-cards.ts

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { generateDailyCards, generateRandomActOfKindness } from '../../ai/action-cards/card-generator';
import { ActionCardContext, GeneratedCard } from '../../ai/action-cards/types';
import { buildCardContext } from '../../ai/action-cards/context-builder';

export const getDailyCards = functions.https.onRequest(async (req, res) => {
  const uid = req.user!.uid; // Set by auth middleware
  const date = (req.query.date as string) ?? todayISO();
  const forceRefresh = req.query.forceRefresh === 'true';

  const db = admin.firestore();

  // Check cache first (unless force refresh)
  if (!forceRefresh) {
    const cached = await getCachedCards(db, uid, date);
    if (cached) {
      res.json({ data: cached });
      return;
    }
  }

  // Build context from user data
  const ctx = await buildCardContext(db, uid);

  // Generate cards
  let cards = await generateDailyCards(ctx);

  // Inject Random Act of Kindness every 7-10 days
  if (shouldInjectRandomKindness(uid, date)) {
    const kindness = await generateRandomActOfKindness(ctx);
    if (kindness) {
      // Replace lowest-scored card
      cards.sort((a, b) => a.qualityScore - b.qualityScore);
      cards[0] = kindness;
    }
  }

  // Store cards in Firestore
  const batch = db.batch();
  const eod = endOfDay(date);
  for (const card of cards) {
    const ref = db.collection(`users/${uid}/actionCards`).doc(card.id);
    batch.set(ref, {
      ...card,
      status: 'pending',
      date,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt: admin.firestore.Timestamp.fromDate(eod),
    });
  }
  await batch.commit();

  const summary = {
    totalCards: cards.length,
    completedToday: 0,
    totalXpAvailable: cards.reduce((sum, c) => sum + c.xpReward, 0),
  };

  const responseData = { date, cards, summary };

  res.json({ data: responseData });
});

async function getCachedCards(
  db: admin.firestore.Firestore, uid: string, date: string,
) {
  const snap = await db.collection(`users/${uid}/actionCards`)
    .where('date', '==', date)
    .where('status', 'in', ['pending', 'completed', 'saved'])
    .get();

  if (snap.empty) return null;

  const cards = snap.docs.map(d => ({ id: d.id, ...d.data() }));
  const completed = cards.filter(c => (c as any).status === 'completed').length;

  return {
    date,
    cards,
    summary: {
      totalCards: cards.length,
      completedToday: completed,
      totalXpAvailable: cards.reduce((sum, c) => sum + ((c as any).xpReward ?? 0), 0),
    },
  };
}

function shouldInjectRandomKindness(uid: string, date: string): boolean {
  // Deterministic pseudo-random based on uid + date
  const hash = simpleHash(uid + date);
  return hash % 8 === 0; // ~12.5% chance per day, roughly every 7-10 days
}

function simpleHash(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = ((hash << 5) - hash) + str.charCodeAt(i);
    hash |= 0;
  }
  return Math.abs(hash);
}

function todayISO(): string {
  return new Date().toISOString().substring(0, 10);
}

function endOfDay(dateStr: string): Date {
  const d = new Date(dateStr + 'T23:59:59Z');
  return d;
}
```

---

## Part 2: SOS Mode AI

### 2.1 SOS Types & Crisis Assessment

```typescript
// FILE: functions/src/ai/sos/types.ts

export type SosScenario =
  | 'she_is_angry' | 'she_is_crying' | 'she_is_silent'
  | 'caught_in_lie' | 'forgot_important_date' | 'said_wrong_thing'
  | 'she_wants_to_talk' | 'her_family_conflict' | 'jealousy_issue' | 'other';

export type SosUrgency = 'happening_now' | 'just_happened' | 'brewing';

export type SeverityLabel = 'mild' | 'moderate' | 'serious' | 'severe' | 'critical';

export type HerState = 'calm' | 'upset' | 'very_upset' | 'crying' | 'furious' | 'silent';

export interface SosSession {
  sessionId: string;
  userId: string;
  scenario: SosScenario;
  urgency: SosUrgency;
  briefContext?: string;
  profileId?: string;
  severityScore: number;
  severityLabel: SeverityLabel;
  status: 'active' | 'coaching' | 'resolved' | 'abandoned';
  stepsCompleted: number;
  conversationHistory: ConversationTurn[];
  memoryMatches: MemoryMatch[];
  escalationTriggered: boolean;
  createdAt: Date;
  resolvedAt?: Date;
}

export interface ConversationTurn {
  role: 'system' | 'user_update' | 'her_response' | 'coaching';
  text: string;
  timestamp: Date;
}

export interface MemoryMatch {
  memoryId: string;
  description: string;
  resolution: string;
  wasSuccessful: boolean;
  similarity: number;
  daysAgo: number;
}

export interface AssessmentAnswers {
  howLongAgo: 'minutes' | 'hours' | 'today' | 'yesterday';
  herCurrentState: HerState;
  haveYouSpoken: boolean;
  isSheTalking: boolean;
  yourFault: 'yes' | 'no' | 'partially' | 'unsure';
  previousSimilar?: boolean;
  additionalContext?: string;
}

export interface CoachingStep {
  sayThis: string;
  whyItWorks: string;
  doNotSay: string[];
  bodyLanguageTip?: string;
  toneAdvice?: 'soft' | 'calm' | 'warm' | 'serious' | 'gentle';
  waitFor?: string;
}

export interface DamageControlPlan {
  immediate: ActionItem[];   // Do within 1 hour
  shortTerm: ActionItem[];   // Do within 24 hours
  longTerm: ActionItem[];    // Do within 1 week
  timeline: string;
}

export interface ActionItem {
  action: string;
  priority: 'critical' | 'important' | 'recommended';
  estimatedTime: string;
}

export interface SafetyCheckResult {
  safe: boolean;
  escalate: boolean;
  reason?: string;
  resources?: CrisisResource[];
}

export interface CrisisResource {
  name: string;
  phone?: string;
  url?: string;
  description: string;
}
```

### 2.2 Crisis Assessment Flow

```typescript
// FILE: functions/src/ai/sos/crisis-assessment.ts

import {
  SosScenario, SosUrgency, AssessmentAnswers,
  SeverityLabel, SafetyCheckResult, CrisisResource,
} from './types';

const SCENARIO_BASE_SEVERITY: Record<SosScenario, number> = {
  she_is_angry: 3,
  she_is_crying: 3,
  she_is_silent: 2,
  caught_in_lie: 4,
  forgot_important_date: 2,
  said_wrong_thing: 3,
  she_wants_to_talk: 2,
  her_family_conflict: 2,
  jealousy_issue: 3,
  other: 2,
};

const URGENCY_MODIFIER: Record<SosUrgency, number> = {
  happening_now: 1,
  just_happened: 0,
  brewing: -1,
};

// Hard escalation keywords -> immediate severity 5
const HARD_ESCALATION_KEYWORDS = [
  'self-harm', 'self harm', 'hurt herself', 'kill herself',
  'suicide', 'suicidal', 'end her life', 'end my life',
  'hit me', 'hit her', 'punch', 'slap', 'violence', 'violent',
  'knife', 'weapon', 'threaten to hurt', 'physically hurt',
];

// Soft escalation keywords -> severity +1 or +2
const SOFT_ESCALATION_KEYWORDS: { pattern: string; boost: number }[] = [
  { pattern: 'threatening to leave', boost: 2 },
  { pattern: 'break up', boost: 2 },
  { pattern: 'divorce', boost: 2 },
  { pattern: 'hasn\'t spoken in days', boost: 1 },
  { pattern: 'screaming', boost: 1 },
  { pattern: 'throwing things', boost: 1 },
  { pattern: 'crying for hours', boost: 1 },
  { pattern: 'locked herself', boost: 1 },
  { pattern: 'blocked me', boost: 1 },
  { pattern: 'told her family', boost: 1 },
  { pattern: 'packed her bags', boost: 2 },
];

export function classifySeverity(
  scenario: SosScenario,
  urgency: SosUrgency,
  answers: AssessmentAnswers,
  contextFlags?: { cyclePhase?: string; isPostpartum?: boolean; recentConflictCount?: number },
): { severity: number; label: SeverityLabel; escalate: boolean } {
  let severity = SCENARIO_BASE_SEVERITY[scenario] + URGENCY_MODIFIER[urgency];

  // Her current state modifiers
  const STATE_BOOST: Record<string, number> = {
    calm: -1, upset: 0, very_upset: 1, crying: 1, furious: 2, silent: 1,
  };
  severity += STATE_BOOST[answers.herCurrentState] ?? 0;

  // Fault acknowledgment
  if (answers.yourFault === 'yes') severity += 1;

  // She is not talking = escalation risk
  if (!answers.isSheTalking && answers.herCurrentState !== 'calm') severity += 1;

  // Repeated pattern
  if (answers.previousSimilar) severity += 1;

  // Recency
  if (answers.howLongAgo === 'minutes' && urgency === 'happening_now') severity += 1;

  // Context flags
  if (contextFlags?.cyclePhase === 'luteal_late') severity = Math.max(severity, 3);
  if (contextFlags?.isPostpartum) severity = Math.max(severity, 3);
  if (contextFlags?.recentConflictCount && contextFlags.recentConflictCount > 3) severity += 1;

  // Free-text escalation check
  const freeText = (answers.additionalContext ?? '').toLowerCase();
  const safetyCheck = checkSafetyKeywords(freeText);
  if (safetyCheck.escalate) {
    return { severity: 5, label: 'critical', escalate: true };
  }

  for (const kw of SOFT_ESCALATION_KEYWORDS) {
    if (freeText.includes(kw.pattern)) severity += kw.boost;
  }

  severity = Math.max(1, Math.min(5, severity));

  const label = severityToLabel(severity);
  return { severity, label, escalate: severity >= 5 };
}

function severityToLabel(s: number): SeverityLabel {
  if (s <= 1) return 'mild';
  if (s === 2) return 'moderate';
  if (s === 3) return 'serious';
  if (s === 4) return 'severe';
  return 'critical';
}

export function checkSafetyKeywords(text: string): SafetyCheckResult {
  const lower = text.toLowerCase();

  for (const keyword of HARD_ESCALATION_KEYWORDS) {
    if (lower.includes(keyword)) {
      return {
        safe: false,
        escalate: true,
        reason: `Safety concern detected: "${keyword}"`,
        resources: getCrisisResources(),
      };
    }
  }

  return { safe: true, escalate: false };
}

function getCrisisResources(): CrisisResource[] {
  return [
    {
      name: 'Emergency Services',
      phone: '911',
      description: 'If anyone is in immediate physical danger, call emergency services.',
    },
    {
      name: 'Crisis Text Line',
      phone: 'Text HOME to 741741',
      description: '24/7 crisis counselor via text message.',
    },
    {
      name: 'National Domestic Violence Hotline',
      phone: '1-800-799-7233',
      url: 'https://www.thehotline.org',
      description: 'Confidential support for domestic violence situations.',
    },
  ];
}

export function buildCoachingPlan(severity: number, scenario: SosScenario): {
  totalSteps: number; estimatedMinutes: number; approach: string; keyInsight: string;
} {
  const PLAN_MAP: Record<number, { steps: number; minutes: number }> = {
    1: { steps: 3, minutes: 10 },
    2: { steps: 4, minutes: 15 },
    3: { steps: 5, minutes: 20 },
    4: { steps: 6, minutes: 25 },
    5: { steps: 4, minutes: 15 }, // Shorter, focused on safety
  };

  const plan = PLAN_MAP[severity] ?? PLAN_MAP[3];

  const APPROACH_MAP: Record<SosScenario, string> = {
    she_is_angry: 'validate_then_listen',
    she_is_crying: 'comfort_first_talk_later',
    she_is_silent: 'gentle_presence_then_open_door',
    caught_in_lie: 'full_accountability_first',
    forgot_important_date: 'acknowledge_and_make_up',
    said_wrong_thing: 'apologize_specifically',
    she_wants_to_talk: 'active_listening_mode',
    her_family_conflict: 'support_without_taking_sides',
    jealousy_issue: 'reassure_with_transparency',
    other: 'empathetic_listening_first',
  };

  const INSIGHT_MAP: Record<SosScenario, string> = {
    she_is_angry: 'Her anger is usually protecting a deeper hurt. Address the hurt, not the anger.',
    she_is_crying: 'She does not need solutions right now. She needs to feel that her pain matters to you.',
    she_is_silent: 'Silence is not indifference -- it means she is processing or protecting herself from more pain.',
    caught_in_lie: 'Trust repair starts with full honesty. Partial truth will make it worse.',
    forgot_important_date: 'She is not upset about the date. She is upset about what forgetting it means to her.',
    said_wrong_thing: 'She heard the words, but she felt the meaning underneath. Address what she felt.',
    she_wants_to_talk: 'She has been thinking about this. Listen fully before responding.',
    her_family_conflict: 'She needs you on her team, even if you see the other side.',
    jealousy_issue: 'Jealousy is fear of loss. Reassure her value, do not dismiss the feeling.',
    other: 'Start by understanding what she is feeling before trying to fix anything.',
  };

  return {
    totalSteps: plan.steps,
    estimatedMinutes: plan.minutes,
    approach: APPROACH_MAP[scenario],
    keyInsight: INSIGHT_MAP[scenario],
  };
}
```

### 2.3 Real-time Coaching Engine

```typescript
// FILE: functions/src/ai/sos/coaching-engine.ts

import { SosSession, CoachingStep, ConversationTurn } from './types';
import { callAiRouter } from '../router/ai-router-client';
import { checkSafetyKeywords } from './crisis-assessment';

const SAFETY_PREAMBLE = `ABSOLUTE SAFETY RULES (non-negotiable):
1. NEVER suggest deceiving, manipulating, or gaslighting his partner.
2. NEVER suggest physical force, restraint, or intimidation.
3. NEVER minimize abuse if described (from either direction).
4. NEVER suggest alcohol or substance use as a coping mechanism.
5. NEVER role-play as the partner or impersonate her responses.
6. NEVER discourage professional help.
7. NEVER say "she's just being emotional" or attribute behavior to hormones.
8. If ANY description suggests abuse, prioritize SAFETY over relationship preservation.
9. NEVER encourage the user to track, spy on, or stalk his partner.`;

export async function generateCoachingStep(
  session: SosSession,
  stepNumber: number,
  userUpdate?: string,
  herResponse?: string,
  partnerProfile?: PartnerProfile,
): Promise<CoachingStep> {
  // Safety check on user input
  if (userUpdate) {
    const safety = checkSafetyKeywords(userUpdate);
    if (safety.escalate) {
      return buildEscalationStep(safety.reason);
    }
  }
  if (herResponse) {
    const safety = checkSafetyKeywords(herResponse);
    if (safety.escalate) {
      return buildEscalationStep(safety.reason);
    }
  }

  const prompt = buildCoachingPrompt(session, stepNumber, userUpdate, herResponse, partnerProfile);

  const response = await callAiRouter({
    requestType: 'sos_coaching',
    parameters: { language: 'en' }, // Will be overridden by user profile
    prompt,
    maxOutputTokens: 300,
    timeout: 3000, // Grok Fast, sub-3s
  });

  return parseCoachingResponse(response.content);
}

function buildCoachingPrompt(
  session: SosSession,
  stepNumber: number,
  userUpdate?: string,
  herResponse?: string,
  profile?: PartnerProfile,
): string {
  const historyStr = session.conversationHistory
    .slice(-6) // Last 6 turns for context window
    .map(t => `[${t.role}]: ${t.text}`)
    .join('\n');

  const memoryStr = session.memoryMatches.length > 0
    ? session.memoryMatches.map(m =>
        `Past situation (${m.daysAgo}d ago): "${m.description}" -> ` +
        `Resolution: "${m.resolution}" (${m.wasSuccessful ? 'worked' : 'did not work'})`
      ).join('\n')
    : 'No similar past situations found.';

  return `${SAFETY_PREAMBLE}

You are an emergency relationship coach. Step ${stepNumber} of ${session.stepsCompleted + 3}.
The user is navigating a live crisis with his partner.

SITUATION: ${session.scenario}
SEVERITY: ${session.severityScore}/5
URGENCY: ${session.urgency}

${profile ? `HER PROFILE:
- Name: ${profile.name}
- Zodiac: ${profile.zodiacSign ?? 'unknown'}
- Love language: ${profile.loveLanguage ?? 'unknown'}
- Communication: ${profile.communicationStyle ?? 'unknown'}
` : ''}

CONVERSATION HISTORY:
${historyStr}

${userUpdate ? `USER JUST REPORTED: ${userUpdate}` : ''}
${herResponse ? `SHE JUST SAID/DID: ${herResponse}` : ''}

PAST RESOLUTION DATA:
${memoryStr}

Respond in this JSON format:
{
  "sayThis": "Exact words he should say to her. Natural, not robotic.",
  "whyItWorks": "1-2 sentences explaining the psychology.",
  "doNotSay": ["phrase to avoid", "another phrase to avoid"],
  "bodyLanguageTip": "Physical positioning advice. 1 sentence.",
  "toneAdvice": "soft | calm | warm | serious | gentle",
  "waitFor": "What to observe before proceeding to next step."
}

RULES:
1. Keep "sayThis" SHORT -- he is reading this during a live conversation.
2. The script must sound like HIM, not a therapist.
3. Use her name if known.
4. If the situation is escalating, recommend a pause.
5. If past resolution worked, build on it. If it failed, suggest different approach.
6. Account for her zodiac conflict behavior and love language.`;
}

function parseCoachingResponse(raw: string): CoachingStep {
  try {
    const cleaned = raw.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim();
    const parsed = JSON.parse(cleaned);
    return {
      sayThis: parsed.sayThis ?? 'Take a breath. Tell her you want to understand.',
      whyItWorks: parsed.whyItWorks ?? 'Showing willingness to listen de-escalates tension.',
      doNotSay: parsed.doNotSay ?? [],
      bodyLanguageTip: parsed.bodyLanguageTip,
      toneAdvice: parsed.toneAdvice ?? 'calm',
      waitFor: parsed.waitFor,
    };
  } catch {
    // Fallback if parsing fails
    return {
      sayThis: 'I hear you, and I want to understand what you are feeling right now.',
      whyItWorks: 'Validation before problem-solving allows the emotional brain to de-escalate.',
      doNotSay: ['You are overreacting', 'Calm down', 'It is not a big deal'],
      bodyLanguageTip: 'Face her directly. Put your phone away. Maintain gentle eye contact.',
      toneAdvice: 'calm',
      waitFor: 'Wait for her to finish speaking before you respond.',
    };
  }
}

function buildEscalationStep(reason?: string): CoachingStep {
  return {
    sayThis: 'Your safety and her safety come first. Please reach out to a professional.',
    whyItWorks: 'This situation requires professional support beyond what LOLO can provide.',
    doNotSay: [],
    bodyLanguageTip: 'If anyone is in danger, create physical distance and call for help.',
    toneAdvice: 'serious',
    waitFor: 'Contact a professional before continuing this conversation.',
  };
}

interface PartnerProfile {
  name: string;
  zodiacSign?: string;
  loveLanguage?: string;
  communicationStyle?: string;
  culturalBackground?: string;
}
```

### 2.4 SSE Streaming Coach Handler

```typescript
// FILE: functions/src/api/sos/coach-stream.ts

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { generateCoachingStep } from '../../ai/sos/coaching-engine';
import { checkSafetyKeywords } from '../../ai/sos/crisis-assessment';

export const sosCoachStream = functions.https.onRequest(async (req, res) => {
  const uid = req.user!.uid;
  const { sessionId, stepNumber, userUpdate, herResponse, stream } = req.body;

  const db = admin.firestore();
  const sessionRef = db.doc(`users/${uid}/sosSessions/${sessionId}`);
  const sessionSnap = await sessionRef.get();

  if (!sessionSnap.exists) {
    res.status(404).json({ error: { code: 'SESSION_NOT_FOUND', message: 'SOS session not found' } });
    return;
  }

  const session = sessionSnap.data() as any;

  // Append user update to conversation history
  const updates: any = {};
  const history = session.conversationHistory ?? [];

  if (userUpdate) {
    history.push({ role: 'user_update', text: userUpdate, timestamp: new Date() });
  }
  if (herResponse) {
    history.push({ role: 'her_response', text: herResponse, timestamp: new Date() });
  }

  // Safety pre-check
  const safetyInput = `${userUpdate ?? ''} ${herResponse ?? ''}`;
  const safety = checkSafetyKeywords(safetyInput);
  if (safety.escalate) {
    updates.escalationTriggered = true;
    await sessionRef.update(updates);

    if (stream) {
      sendSSE(res, 'escalation', {
        reason: safety.reason,
        resources: safety.resources,
      });
      sendSSE(res, 'coaching_complete', { isLastStep: true });
      res.end();
      return;
    }

    res.json({
      data: {
        sessionId,
        stepNumber,
        totalSteps: stepNumber,
        coaching: {
          sayThis: 'Please prioritize safety. Contact a professional.',
          whyItWorks: 'This situation needs professional support.',
          doNotSay: [],
          bodyLanguageTip: 'Ensure physical safety first.',
          toneAdvice: 'serious',
        },
        isLastStep: true,
        escalation: { reason: safety.reason, resources: safety.resources },
      },
    });
    return;
  }

  // Generate coaching step
  const coaching = await generateCoachingStep(
    { ...session, conversationHistory: history },
    stepNumber,
    userUpdate,
    herResponse,
  );

  // Update session
  history.push({ role: 'coaching', text: coaching.sayThis, timestamp: new Date() });
  updates.conversationHistory = history;
  updates.stepsCompleted = stepNumber;
  await sessionRef.update(updates);

  const totalSteps = session.coachingPlan?.totalSteps ?? 5;
  const isLastStep = stepNumber >= totalSteps;

  if (stream) {
    // SSE streaming response
    res.writeHead(200, {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
    });

    sendSSE(res, 'coaching_start', { sessionId, stepNumber });
    await delay(100);
    sendSSE(res, 'say_this', { text: coaching.sayThis });
    await delay(100);

    if (coaching.bodyLanguageTip) {
      sendSSE(res, 'body_language', { text: coaching.bodyLanguageTip });
      await delay(100);
    }

    if (coaching.doNotSay.length > 0) {
      sendSSE(res, 'do_not_say', { phrases: coaching.doNotSay });
      await delay(100);
    }

    sendSSE(res, 'coaching_complete', {
      isLastStep,
      nextStepPrompt: isLastStep ? null : 'What did she say or do next?',
    });

    res.end();
    return;
  }

  // Standard JSON response
  res.json({
    data: {
      sessionId,
      stepNumber,
      totalSteps,
      coaching,
      isLastStep,
      nextStepPrompt: isLastStep ? null : 'What did she say or do next?',
    },
  });
});

function sendSSE(res: any, event: string, data: any): void {
  res.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`);
}

function delay(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}
```

### 2.5 Damage Control Plan Generator

```typescript
// FILE: functions/src/ai/sos/damage-control.ts

import { SosSession, DamageControlPlan, ActionItem } from './types';
import { callAiRouter } from '../router/ai-router-client';

export async function generateDamageControlPlan(
  session: SosSession,
  partnerName: string,
  language: string,
): Promise<DamageControlPlan> {
  const prompt = `Generate a damage control and recovery plan for this relationship situation.

SITUATION: ${session.scenario}
SEVERITY: ${session.severityScore}/5
WHAT HAPPENED: ${session.briefContext ?? 'See conversation history'}
PARTNER: ${partnerName}

CONVERSATION SUMMARY:
${session.conversationHistory.slice(-8).map(t => `[${t.role}]: ${t.text}`).join('\n')}

Generate a structured recovery plan in this JSON format:
{
  "immediate": [
    { "action": "What to do within the next hour", "priority": "critical", "estimatedTime": "10 min" }
  ],
  "shortTerm": [
    { "action": "What to do within 24 hours", "priority": "important", "estimatedTime": "30 min" }
  ],
  "longTerm": [
    { "action": "What to do within 1 week", "priority": "recommended", "estimatedTime": "1 hour" }
  ],
  "timeline": "Brief description of the recovery arc"
}

RULES:
1. Be SPECIFIC to the situation. No generic advice.
2. Use ${partnerName}'s name in the actions.
3. Immediate actions should be concrete and doable right now.
4. Long-term actions should prevent recurrence.
5. Never suggest manipulation. Focus on genuine repair.
6. If severity >= 4, include "consider couples counseling" in long-term.
7. Write in ${language}.`;

  try {
    const response = await callAiRouter({
      requestType: 'sos_coaching',
      parameters: { language },
      prompt,
      maxOutputTokens: 400,
      timeout: 5000,
    });

    const cleaned = response.content.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim();
    return JSON.parse(cleaned) as DamageControlPlan;
  } catch {
    return buildFallbackPlan(session, partnerName);
  }
}

function buildFallbackPlan(session: SosSession, name: string): DamageControlPlan {
  return {
    immediate: [
      { action: `Give ${name} space if she needs it. Do not force conversation.`, priority: 'critical', estimatedTime: '15 min' },
      { action: 'Take a few deep breaths and collect your thoughts.', priority: 'critical', estimatedTime: '5 min' },
    ],
    shortTerm: [
      { action: `Check in with ${name} tomorrow with a calm, non-pressuring message.`, priority: 'important', estimatedTime: '5 min' },
      { action: 'Reflect on your part in the situation and prepare a sincere acknowledgment.', priority: 'important', estimatedTime: '20 min' },
    ],
    longTerm: [
      { action: 'Identify the pattern that led to this situation and discuss it together when things are calm.', priority: 'recommended', estimatedTime: '30 min' },
      { action: 'Consider whether professional support (couples counseling) would help.', priority: 'recommended', estimatedTime: '1 hour' },
    ],
    timeline: 'Give it 24-48 hours for emotions to settle, then begin active repair.',
  };
}
```

### 2.6 Memory Vault Integration

```typescript
// FILE: functions/src/ai/sos/memory-integration.ts

import * as admin from 'firebase-admin';
import { MemoryMatch, SosScenario } from './types';

export async function findPastResolutions(
  db: admin.firestore.Firestore,
  userId: string,
  currentScenario: SosScenario,
  briefContext?: string,
): Promise<MemoryMatch[]> {
  // Fetch conflict-related memories from the Memory Vault
  const memoriesSnap = await db.collection(`users/${userId}/memories`)
    .where('type', 'in', ['conflict', 'milestone', 'sos_resolution'])
    .orderBy('createdAt', 'desc')
    .limit(20)
    .get();

  if (memoriesSnap.empty) return [];

  const candidates: MemoryMatch[] = [];
  const now = Date.now();

  for (const doc of memoriesSnap.docs) {
    const data = doc.data();
    const similarity = calculateSituationSimilarity(
      currentScenario,
      briefContext ?? '',
      data.scenario ?? '',
      data.description ?? '',
    );

    if (similarity >= 0.5) {
      const createdAt = data.createdAt?.toDate?.() ?? new Date();
      candidates.push({
        memoryId: doc.id,
        description: data.description ?? '',
        resolution: data.resolution ?? data.outcome ?? '',
        wasSuccessful: (data.resolutionRating ?? 0) >= 4,
        similarity,
        daysAgo: Math.floor((now - createdAt.getTime()) / (1000 * 60 * 60 * 24)),
      });
    }
  }

  // Sort: successful first, then by similarity
  candidates.sort((a, b) => {
    if (a.wasSuccessful !== b.wasSuccessful) return a.wasSuccessful ? -1 : 1;
    return b.similarity - a.similarity;
  });

  return candidates.slice(0, 3); // Top 3 matches
}

function calculateSituationSimilarity(
  currentScenario: string,
  currentContext: string,
  pastScenario: string,
  pastDescription: string,
): number {
  let score = 0;

  // Exact scenario match
  if (currentScenario === pastScenario) score += 0.5;

  // Scenario family match
  const SCENARIO_FAMILIES: Record<string, string[]> = {
    anger: ['she_is_angry', 'said_wrong_thing', 'caught_in_lie'],
    sadness: ['she_is_crying', 'forgot_important_date'],
    withdrawal: ['she_is_silent', 'she_wants_to_talk'],
    trust: ['caught_in_lie', 'jealousy_issue'],
    external: ['her_family_conflict'],
  };

  for (const family of Object.values(SCENARIO_FAMILIES)) {
    if (family.includes(currentScenario) && family.includes(pastScenario)) {
      score += 0.3;
      break;
    }
  }

  // Keyword overlap between current context and past description
  if (currentContext && pastDescription) {
    const currentWords = new Set(currentContext.toLowerCase().split(/\s+/).filter(w => w.length > 3));
    const pastWords = new Set(pastDescription.toLowerCase().split(/\s+/).filter(w => w.length > 3));
    const overlap = [...currentWords].filter(w => pastWords.has(w)).length;
    const maxWords = Math.max(currentWords.size, pastWords.size, 1);
    score += (overlap / maxWords) * 0.2;
  }

  return Math.min(score, 1.0);
}
```

### 2.7 Safety Guardrails

```typescript
// FILE: functions/src/ai/sos/safety-guardrails.ts

import { SosSession, SafetyCheckResult, CrisisResource } from './types';

// Abuse pattern detection -- monitors across sessions
export async function detectAbusePatterns(
  userId: string,
  sessions: SosSession[],
): Promise<{ detected: boolean; pattern?: string; recommendation?: string }> {
  // Pattern 1: Frequent "caught_in_lie" scenarios
  const lyingSessions = sessions.filter(s => s.scenario === 'caught_in_lie');
  if (lyingSessions.length >= 3) {
    return {
      detected: true,
      pattern: 'repeated_deception',
      recommendation: 'Repeated trust issues suggest a deeper pattern. A professional counselor can help both of you build a healthier foundation.',
    };
  }

  // Pattern 2: Escalating severity over time
  const recentSessions = sessions.slice(0, 5);
  if (recentSessions.length >= 3) {
    const avgSeverity = recentSessions.reduce((s, sess) => s + sess.severityScore, 0) / recentSessions.length;
    if (avgSeverity >= 4) {
      return {
        detected: true,
        pattern: 'escalating_conflict',
        recommendation: 'The frequency and intensity of conflicts has been increasing. Professional couples counseling is strongly recommended.',
      };
    }
  }

  // Pattern 3: User describes controlling behavior (their own)
  const controlKeywords = ['won\'t let her', 'checked her phone', 'followed her', 'told her she can\'t'];
  for (const session of recentSessions) {
    const allText = session.conversationHistory.map(t => t.text).join(' ').toLowerCase();
    for (const kw of controlKeywords) {
      if (allText.includes(kw)) {
        return {
          detected: true,
          pattern: 'controlling_behavior',
          recommendation: 'Some of the actions described may be harmful to your partner. Speaking with a counselor individually can help you develop healthier relationship patterns.',
        };
      }
    }
  }

  return { detected: false };
}

// Content validation for all SOS AI outputs
export function validateCoachingOutput(content: string): SafetyCheckResult {
  const lower = content.toLowerCase();

  const BLOCKED_PATTERNS = [
    'make her jealous',
    'give her the silent treatment',
    'guilt trip',
    'gaslight',
    'manipulate',
    'control her',
    'punish her',
    'threaten',
    'she deserves it',
    'it\'s her fault',
    'she\'s crazy',
    'she\'s overreacting',
    'hormones',
    'time of the month',
    'drink to calm down',
    'take a shot',
  ];

  for (const pattern of BLOCKED_PATTERNS) {
    if (lower.includes(pattern)) {
      return {
        safe: false,
        escalate: false,
        reason: `Output contained blocked pattern: "${pattern}"`,
      };
    }
  }

  return { safe: true, escalate: false };
}

// Localized crisis resources by region
export function getCrisisResourcesByRegion(region: string): CrisisResource[] {
  const RESOURCES: Record<string, CrisisResource[]> = {
    US: [
      { name: 'National Domestic Violence Hotline', phone: '1-800-799-7233', description: '24/7 confidential support' },
      { name: 'Crisis Text Line', phone: 'Text HOME to 741741', description: 'Text-based crisis support' },
    ],
    AE: [
      { name: 'Dubai Foundation for Women & Children', phone: '800-111', description: 'Confidential support in UAE' },
    ],
    SA: [
      { name: 'Family Safety Hotline', phone: '1919', description: 'Saudi Arabia family protection' },
    ],
    MY: [
      { name: 'Talian Kasih', phone: '15999', description: 'Malaysia crisis and support hotline' },
      { name: 'Women\'s Aid Organisation', phone: '03-7956-3488', description: 'Support for domestic violence' },
    ],
  };

  return RESOURCES[region] ?? RESOURCES['US'];
}
```

---

## Part 3: Batch Processing

### 3.1 Overnight Card Pre-generation

```typescript
// FILE: functions/src/batch/overnight-card-generator.ts

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { generateDailyCards } from '../ai/action-cards/card-generator';
import { buildCardContext } from '../ai/action-cards/context-builder';
import { ActionCardContext, GeneratedCard } from '../ai/action-cards/types';
import { logBatchMetrics } from './batch-monitor';

interface BatchJob {
  userId: string;
  tier: string;
  language: string;
  timezone: string;
}

// Triggered by Cloud Scheduler at midnight UTC
// Processes users whose local time is ~2am
export const overnightCardGeneration = functions
  .runWith({ timeoutSeconds: 540, memory: '1GB' })
  .pubsub.schedule('every 1 hours')
  .onRun(async () => {
    const db = admin.firestore();
    const now = new Date();

    // Find timezones where it is currently ~2am
    const targetTimezones = getTimezonesAt2AM(now);
    if (targetTimezones.length === 0) return;

    // Fetch active users in those timezones
    const users = await fetchActiveUsers(db, targetTimezones);
    console.log(`Batch: ${users.length} users to process for timezones: ${targetTimezones.join(', ')}`);

    // Group by language + tier for batch optimization
    const groups = groupUsers(users);

    const metrics = {
      totalUsers: users.length,
      successful: 0,
      failed: 0,
      totalCards: 0,
      totalCostUsd: 0,
      startTime: Date.now(),
    };

    // Process each group
    for (const [groupKey, groupUsers] of Object.entries(groups)) {
      const results = await processGroup(db, groupUsers);
      metrics.successful += results.successful;
      metrics.failed += results.failed;
      metrics.totalCards += results.totalCards;
      metrics.totalCostUsd += results.costUsd;
    }

    metrics.totalCostUsd = Math.round(metrics.totalCostUsd * 10000) / 10000;
    const duration = Date.now() - metrics.startTime;

    await logBatchMetrics(db, {
      ...metrics,
      durationMs: duration,
      timestamp: now,
    });

    console.log(`Batch complete: ${metrics.successful}/${metrics.totalUsers} users, ` +
      `${metrics.totalCards} cards, $${metrics.totalCostUsd}, ${duration}ms`);
  });

function getTimezonesAt2AM(now: Date): string[] {
  const utcHour = now.getUTCHours();
  // We want timezones where local time is 2am
  // If UTC is 18:00, then UTC+8 is 2:00 (Malaysia)
  // offset = 2 - utcHour (mod 24)
  const targetOffset = ((2 - utcHour) % 24 + 24) % 24;

  const TZ_MAP: Record<number, string[]> = {
    0: ['UTC'],
    3: ['Asia/Riyadh', 'Asia/Kuwait'],    // Gulf
    4: ['Asia/Dubai'],                      // UAE
    8: ['Asia/Kuala_Lumpur', 'Asia/Singapore'], // Malaysia
    [-5 + 24]: ['America/New_York'],        // EST
    [-8 + 24]: ['America/Los_Angeles'],     // PST
  };

  return TZ_MAP[targetOffset] ?? [];
}

async function fetchActiveUsers(
  db: admin.firestore.Firestore,
  timezones: string[],
): Promise<BatchJob[]> {
  const users: BatchJob[] = [];

  // Query in chunks to avoid Firestore 'in' limit of 30
  for (let i = 0; i < timezones.length; i += 10) {
    const chunk = timezones.slice(i, i + 10);
    const snap = await db.collection('users')
      .where('timezone', 'in', chunk)
      .where('isActive', '==', true)
      .where('onboardingComplete', '==', true)
      .limit(5000)
      .get();

    for (const doc of snap.docs) {
      const data = doc.data();
      users.push({
        userId: doc.id,
        tier: data.tier ?? 'free',
        language: data.language ?? 'en',
        timezone: data.timezone ?? 'UTC',
      });
    }
  }

  return users;
}

function groupUsers(users: BatchJob[]): Record<string, BatchJob[]> {
  const groups: Record<string, BatchJob[]> = {};
  for (const u of users) {
    const key = `${u.language}_${u.tier}`;
    if (!groups[key]) groups[key] = [];
    groups[key].push(u);
  }
  return groups;
}

async function processGroup(
  db: admin.firestore.Firestore,
  users: BatchJob[],
): Promise<{ successful: number; failed: number; totalCards: number; costUsd: number }> {
  let successful = 0;
  let failed = 0;
  let totalCards = 0;
  let costUsd = 0;

  // Process in parallel batches of 10
  const BATCH_SIZE = 10;
  for (let i = 0; i < users.length; i += BATCH_SIZE) {
    const batch = users.slice(i, i + BATCH_SIZE);
    const results = await Promise.allSettled(
      batch.map(user => processUser(db, user))
    );

    for (const result of results) {
      if (result.status === 'fulfilled' && result.value) {
        successful++;
        totalCards += result.value.cardCount;
        costUsd += result.value.costUsd;
      } else {
        failed++;
      }
    }
  }

  return { successful, failed, totalCards, costUsd };
}

async function processUser(
  db: admin.firestore.Firestore,
  job: BatchJob,
): Promise<{ cardCount: number; costUsd: number } | null> {
  try {
    const ctx = await buildCardContext(db, job.userId);
    const tomorrow = tomorrowISO();

    const cards = await generateDailyCards(ctx);
    if (cards.length === 0) return null;

    // Store pre-generated cards
    const batch = db.batch();
    const eod = new Date(tomorrow + 'T23:59:59Z');

    for (const card of cards) {
      const ref = db.collection(`users/${job.userId}/actionCards`).doc(card.id);
      batch.set(ref, {
        ...card,
        status: 'pending',
        date: tomorrow,
        preGenerated: true,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: admin.firestore.Timestamp.fromDate(eod),
      });
    }

    await batch.commit();

    // Estimated cost: ~$0.0004 per card via batch API
    const estimatedCost = cards.length * 0.0004;
    return { cardCount: cards.length, costUsd: estimatedCost };
  } catch (err) {
    console.error(`Batch failed for user ${job.userId}:`, err);
    return null;
  }
}

function tomorrowISO(): string {
  const d = new Date();
  d.setDate(d.getDate() + 1);
  return d.toISOString().substring(0, 10);
}
```

### 3.2 Cost Optimization & Tier-based Generation

```typescript
// FILE: functions/src/batch/cost-optimizer.ts

const COST_PER_CARD: Record<string, number> = {
  'claude-haiku-4.5-batch': 0.0004,   // 50% batch discount
  'claude-haiku-4.5': 0.0008,          // Real-time
  'claude-sonnet-4.5': 0.0030,         // Premium
  'grok-4.1-fast': 0.0005,             // SOS
};

const CARDS_PER_TIER: Record<string, number> = {
  free: 1,
  pro: 2,
  legend: 3,
};

export interface CostEstimate {
  cardsPerDay: number;
  costPerDay: number;
  costPerMonth: number;
  model: string;
  isBatch: boolean;
}

export function estimateCost(tier: string, useBatch: boolean): CostEstimate {
  const cards = CARDS_PER_TIER[tier] ?? 1;
  const model = useBatch ? 'claude-haiku-4.5-batch' : 'claude-haiku-4.5';
  const costPerCard = COST_PER_CARD[model];

  return {
    cardsPerDay: cards,
    costPerDay: cards * costPerCard,
    costPerMonth: cards * costPerCard * 30,
    model,
    isBatch: useBatch,
  };
}

export function calculateMonthlyCost(
  userCounts: Record<string, number>,
  batchPercentage: number, // 0-1, fraction using batch
): { totalMonthly: number; breakdown: Record<string, number> } {
  const breakdown: Record<string, number> = {};
  let total = 0;

  for (const [tier, count] of Object.entries(userCounts)) {
    const batchUsers = Math.floor(count * batchPercentage);
    const realtimeUsers = count - batchUsers;

    const batchCost = estimateCost(tier, true).costPerMonth * batchUsers;
    const realtimeCost = estimateCost(tier, false).costPerMonth * realtimeUsers;

    breakdown[tier] = batchCost + realtimeCost;
    total += breakdown[tier];
  }

  return { totalMonthly: Math.round(total * 100) / 100, breakdown };
}

// Quality-based retry with model escalation
export interface QualityRetryConfig {
  initialModel: string;
  retryModel: string;
  minQualityScore: number;
  maxRetries: number;
}

export function getRetryConfig(tier: string): QualityRetryConfig {
  if (tier === 'legend') {
    return {
      initialModel: 'claude-haiku-4.5',
      retryModel: 'claude-sonnet-4.5', // Escalate to premium on retry
      minQualityScore: 60, // Higher bar for Legend
      maxRetries: 2,
    };
  }

  return {
    initialModel: 'claude-haiku-4.5',
    retryModel: 'claude-haiku-4.5', // Same model, different prompt
    minQualityScore: 50,
    maxRetries: 1,
  };
}
```

### 3.3 Batch Monitoring & Quality Dashboard

```typescript
// FILE: functions/src/batch/batch-monitor.ts

import * as admin from 'firebase-admin';

export interface BatchMetrics {
  totalUsers: number;
  successful: number;
  failed: number;
  totalCards: number;
  totalCostUsd: number;
  durationMs: number;
  timestamp: Date;
}

export interface CardQualityMetrics {
  totalGenerated: number;
  passedQuality: number;
  failedQuality: number;
  retriedAndPassed: number;
  averageQualityScore: number;
  qualityByModel: Record<string, { count: number; avgScore: number }>;
  costPerCard: number;
}

export async function logBatchMetrics(
  db: admin.firestore.Firestore,
  metrics: BatchMetrics,
): Promise<void> {
  const dateKey = metrics.timestamp.toISOString().substring(0, 10);

  await db.collection('system/metrics/batchJobs').doc(dateKey).set({
    ...metrics,
    successRate: metrics.totalUsers > 0
      ? Math.round((metrics.successful / metrics.totalUsers) * 100) : 0,
    avgCardsPerUser: metrics.successful > 0
      ? Math.round((metrics.totalCards / metrics.successful) * 10) / 10 : 0,
    costPerCard: metrics.totalCards > 0
      ? Math.round((metrics.totalCostUsd / metrics.totalCards) * 10000) / 10000 : 0,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
}

export async function logCardQuality(
  db: admin.firestore.Firestore,
  cardId: string,
  metrics: {
    qualityScore: number;
    model: string;
    wasRetry: boolean;
    generationTimeMs: number;
    language: string;
    tier: string;
  },
): Promise<void> {
  await db.collection('system/metrics/cardQuality').add({
    cardId,
    ...metrics,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });
}

// Engagement correlation tracking
export async function logCardEngagement(
  db: admin.firestore.Firestore,
  cardId: string,
  action: 'completed' | 'skipped' | 'saved' | 'expired',
  metadata: {
    category: string;
    qualityScore: number;
    difficulty: string;
    userId: string;
    tier: string;
  },
): Promise<void> {
  await db.collection('system/metrics/cardEngagement').add({
    cardId,
    action,
    ...metadata,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });
}

// Aggregation query for monitoring dashboard
export async function getBatchHealthSummary(
  db: admin.firestore.Firestore,
  daysBack: number = 7,
): Promise<{
  avgSuccessRate: number;
  avgCostPerCard: number;
  totalCardsGenerated: number;
  totalCost: number;
  failureRate: number;
}> {
  const since = new Date();
  since.setDate(since.getDate() - daysBack);

  const snap = await db.collection('system/metrics/batchJobs')
    .where('timestamp', '>=', admin.firestore.Timestamp.fromDate(since))
    .orderBy('timestamp', 'desc')
    .get();

  if (snap.empty) {
    return { avgSuccessRate: 0, avgCostPerCard: 0, totalCardsGenerated: 0, totalCost: 0, failureRate: 0 };
  }

  let totalSuccessRate = 0;
  let totalCards = 0;
  let totalCost = 0;
  let totalFailed = 0;
  let totalUsers = 0;

  for (const doc of snap.docs) {
    const d = doc.data();
    totalSuccessRate += d.successRate ?? 0;
    totalCards += d.totalCards ?? 0;
    totalCost += d.totalCostUsd ?? 0;
    totalFailed += d.failed ?? 0;
    totalUsers += d.totalUsers ?? 0;
  }

  const count = snap.size;
  return {
    avgSuccessRate: Math.round(totalSuccessRate / count),
    avgCostPerCard: totalCards > 0 ? Math.round((totalCost / totalCards) * 10000) / 10000 : 0,
    totalCardsGenerated: totalCards,
    totalCost: Math.round(totalCost * 100) / 100,
    failureRate: totalUsers > 0 ? Math.round((totalFailed / totalUsers) * 100) : 0,
  };
}
```

### 3.4 Context Builder (Shared Utility)

```typescript
// FILE: functions/src/ai/action-cards/context-builder.ts

import * as admin from 'firebase-admin';
import { ActionCardContext, CalendarEvent, ConflictSummary } from './types';

export async function buildCardContext(
  db: admin.firestore.Firestore,
  userId: string,
): Promise<ActionCardContext> {
  // Parallel fetches for all context data
  const [userDoc, profileSnap, cardsSnap, conflictsSnap, remindersSnap] = await Promise.all([
    db.doc(`users/${userId}`).get(),
    db.collection(`users/${userId}/partnerProfiles`).limit(1).get(),
    db.collection(`users/${userId}/actionCards`)
      .where('date', '>=', daysAgoISO(30))
      .orderBy('date', 'desc')
      .limit(100)
      .get(),
    db.collection(`users/${userId}/sosSessions`)
      .where('createdAt', '>=', admin.firestore.Timestamp.fromDate(daysAgo(30)))
      .orderBy('createdAt', 'desc')
      .limit(10)
      .get(),
    db.collection(`users/${userId}/reminders`)
      .where('date', '>=', todayISO())
      .where('date', '<=', daysFromNowISO(30))
      .limit(10)
      .get(),
  ]);

  const user = userDoc.data() ?? {};
  const profile = profileSnap.empty ? {} : profileSnap.docs[0].data();

  // Build events from reminders
  const upcomingEvents: CalendarEvent[] = remindersSnap.docs.map(d => {
    const data = d.data();
    const eventDate = new Date(data.date);
    const daysUntil = Math.ceil((eventDate.getTime() - Date.now()) / (1000 * 60 * 60 * 24));
    return {
      type: mapReminderType(data.type),
      name: data.title ?? '',
      daysUntil,
    };
  });

  // Build conflict summaries from SOS sessions
  const recentConflicts: ConflictSummary[] = conflictsSnap.docs.map(d => {
    const data = d.data();
    const created = data.createdAt?.toDate?.() ?? new Date();
    return {
      scenario: data.scenario ?? 'other',
      severity: data.severityScore ?? 2,
      daysAgo: Math.floor((Date.now() - created.getTime()) / (1000 * 60 * 60 * 24)),
      resolved: data.status === 'resolved',
    };
  });

  // Recent card categories (last 7 days)
  const sevenDaysAgo = daysAgoISO(7);
  const recentCards = cardsSnap.docs
    .filter(d => (d.data().date ?? '') >= sevenDaysAgo)
    .map(d => d.data());

  const completedCardIds = cardsSnap.docs
    .filter(d => d.data().status === 'completed')
    .map(d => d.id);

  const skippedCardIds = cardsSnap.docs
    .filter(d => d.data().status === 'skipped')
    .map(d => d.id);

  const totalRecent = recentCards.length || 1;
  const completedRecent = recentCards.filter(c => c.status === 'completed').length;

  const now = new Date();
  const hour = now.getHours();
  const dayOfWeek = now.getDay();

  return {
    userId,
    tier: user.tier ?? 'free',
    language: user.language ?? 'en',
    dialect: user.dialect,
    partnerName: profile.name ?? 'her',
    zodiacSign: profile.zodiacSign,
    loveLanguage: profile.loveLanguage,
    communicationStyle: profile.communicationStyle,
    culturalBackground: profile.culturalBackground ?? user.culturalBackground,
    religiousObservance: profile.religiousObservance ?? user.religiousObservance,
    partnerEmotionalState: profile.currentEmotionalState,
    recentMoodTrend: profile.moodTrend,
    cyclePhase: profile.cyclePhase,
    isPregnant: profile.isPregnant ?? false,
    trimester: profile.trimester,
    upcomingEvents,
    isRamadan: isCurrentlyRamadan(),
    isEid: isCurrentlyEid(),
    isHariRaya: isCurrentlyHariRaya(),
    dayOfWeek,
    timeOfDay: hour < 12 ? 'morning' : hour < 17 ? 'afternoon' : 'evening',
    isWeekend: dayOfWeek === 0 || dayOfWeek === 6,
    recentConflicts,
    daysSinceLastConflict: recentConflicts.length > 0 ? recentConflicts[0].daysAgo : undefined,
    completedCardIds,
    skippedCardIds,
    recentCardCategories: recentCards.map(c => c.category ?? '').filter(Boolean),
    cardCompletionRate: completedRecent / totalRecent,
    relationshipStatus: profile.relationshipStatus ?? 'dating',
    relationshipDurationMonths: profile.relationshipDurationMonths,
  };
}

// --- Utility Helpers ---

function mapReminderType(type: string): CalendarEvent['type'] {
  const MAP: Record<string, CalendarEvent['type']> = {
    birthday: 'birthday', anniversary: 'anniversary',
    eid: 'eid', hari_raya: 'hari_raya', valentines: 'valentines',
  };
  return MAP[type] ?? 'custom';
}

function todayISO(): string { return new Date().toISOString().substring(0, 10); }

function daysAgoISO(n: number): string {
  const d = new Date(); d.setDate(d.getDate() - n);
  return d.toISOString().substring(0, 10);
}

function daysFromNowISO(n: number): string {
  const d = new Date(); d.setDate(d.getDate() + n);
  return d.toISOString().substring(0, 10);
}

function daysAgo(n: number): Date {
  const d = new Date(); d.setDate(d.getDate() - n); return d;
}

// Cultural calendar checks (simplified -- production would use a proper Hijri calendar library)
function isCurrentlyRamadan(): boolean {
  // Placeholder: integrate with hijri-date library for accurate detection
  // For 2026, Ramadan is approximately Feb 18 - Mar 19
  const now = new Date();
  const month = now.getMonth(); // 0-indexed
  const day = now.getDate();
  if (month === 1 && day >= 18) return true;  // Feb 18+
  if (month === 2 && day <= 19) return true;  // Mar 1-19
  return false;
}

function isCurrentlyEid(): boolean {
  const now = new Date();
  const month = now.getMonth();
  const day = now.getDate();
  // Eid al-Fitr 2026: ~Mar 20-22
  if (month === 2 && day >= 20 && day <= 22) return true;
  return false;
}

function isCurrentlyHariRaya(): boolean {
  // Hari Raya Aidilfitri follows Eid al-Fitr in Malaysia
  return isCurrentlyEid();
}
```

---

## Architecture Summary

### File Structure

```
functions/src/
  ai/
    action-cards/
      types.ts                    # Card types, context interfaces
      context-fusion.ts           # Scoring algorithm, cultural filter
      card-generator.ts           # Generation pipeline, random kindness
      quality-scorer.ts           # Card quality validation (50/100 min)
      context-builder.ts          # Firestore -> ActionCardContext assembly
    sos/
      types.ts                    # SOS types, session, crisis resources
      crisis-assessment.ts        # Severity classification, safety keywords
      coaching-engine.ts          # Real-time coaching with safety preamble
      damage-control.ts           # Multi-step recovery plan generator
      memory-integration.ts       # Memory Vault past resolution lookup
      safety-guardrails.ts        # Abuse detection, output validation
    router/
      ai-router-client.ts         # Internal AI Router call (from Sprint 3)
  api/
    action-cards/
      get-daily-cards.ts          # GET /action-cards handler
    sos/
      coach-stream.ts             # POST /sos/coach with SSE streaming
  batch/
    overnight-card-generator.ts   # Cloud Scheduler triggered batch job
    cost-optimizer.ts             # Cost estimation, tier-based generation
    batch-monitor.ts              # Metrics logging, health dashboard
```

### Data Flow

```
DAILY CARDS:
  Cloud Scheduler (2am local) -> overnight-card-generator
    -> buildCardContext (Firestore reads)
    -> context-fusion (score 48 candidates)
    -> card-generator (AI Router -> Claude Haiku batch)
    -> quality-scorer (reject < 50/100)
    -> Firestore write (users/{uid}/actionCards)
    -> Push notification at 8am

SOS MODE:
  POST /sos/activate -> crisis-assessment.classifySeverity()
    -> memory-integration.findPastResolutions()
    -> AI Router -> Grok Fast (3s timeout)
    -> Return immediateAdvice + coachingPlan

  POST /sos/coach (stream=true) -> coach-stream.ts
    -> safety-guardrails.checkSafetyKeywords()
    -> coaching-engine.generateCoachingStep()
    -> AI Router -> Grok Fast (SSE streaming)
    -> safety-guardrails.validateCoachingOutput()
    -> SSE events: say_this, body_language, do_not_say, coaching_complete
```

### Model Routing (from AI Strategy)

| Feature | Primary Model | Fallback | Timeout | Batch |
|---------|--------------|----------|---------|-------|
| Daily Cards | Claude Haiku 4.5 | GPT-5 Mini | 5s | Yes (50% discount) |
| SOS Activate | Grok 4.1 Fast | Claude Haiku 4.5 | 3s | No |
| SOS Coach | Grok 4.1 Fast | Claude Haiku 4.5 | 3s | No |
| Damage Control | Grok 4.1 Fast | Claude Haiku 4.5 | 5s | No |
| Random Kindness | Claude Haiku 4.5 | GPT-5 Mini | 5s | Yes |

### Cost Projections (10K Users)

| Tier | Users | Cards/Day | Batch Cost/Day | Monthly |
|------|-------|-----------|----------------|---------|
| Free | 7,000 | 7,000 | $2.80 | $84 |
| Pro | 2,500 | 5,000 | $2.00 | $60 |
| Legend | 500 | 1,500 | $0.60 | $18 |
| **Total** | **10,000** | **13,500** | **$5.40** | **$162** |

SOS mode cost (estimated 500 sessions/month at $0.0005/call, avg 5 calls): $1.25/month.

### Safety Guardrails Summary

1. **Pre-input validation** -- Client-side ContentSafetyFilter blocks manipulation/injection
2. **Keyword escalation** -- Hard escalation keywords trigger immediate severity 5 + crisis resources
3. **AI output validation** -- All coaching output scanned for blocked patterns before delivery
4. **Abuse pattern detection** -- Cross-session analysis flags repeated concerning patterns
5. **Professional escalation** -- Severity >= 4 mentions counseling; severity 5 shows crisis hotlines
6. **Never encourage** -- Manipulation, deception, stalking, substance use, minimizing her feelings

---

*Dr. Aisha Mahmoud, AI/ML Engineer -- Sprint 4 Action Cards Engine, SOS Mode AI & Batch Processing*
