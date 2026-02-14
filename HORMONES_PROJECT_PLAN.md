# LOLO - Comprehensive Project Plan
## AI-Powered Relationship Intelligence App for Men

---

# TABLE OF CONTENTS

1. [Executive Summary](#1-executive-summary)
2. [Product Vision & Features](#2-product-vision--features)
3. [Project Phases & Timeline](#3-project-phases--timeline)
4. [Team Structure](#4-team-structure)
5. [Job Descriptions](#5-job-descriptions)
6. [Qualifications & Experience Requirements](#6-qualifications--experience-requirements)
7. [Budget Estimation](#7-budget-estimation)
8. [Risk Matrix](#8-risk-matrix)
9. [Monetization Strategy](#9-monetization-strategy)
10. [Legal, Compliance & Privacy](#10-legal-compliance--privacy)
11. [MVP Success Criteria](#11-mvp-success-criteria)
12. [Appendix A: Hiring Priority Order](#appendix-a-hiring-priority-order)
13. [Appendix B: Alternative Lean Approach](#appendix-b-alternative-lean-approach-3-person-mvp)
14. [Appendix C: Team KPI Checklists & Accountability Tracker](#appendix-c-team-kpi-checklists--accountability-tracker)

---

# 1. EXECUTIVE SUMMARY

**Product Name:** LOLO
**Tagline:** "She won't know why you got so thoughtful. We won't tell."
**Category:** Lifestyle / Relationship Intelligence
**Platforms:** Android + iOS (simultaneous launch via Flutter), HarmonyOS / Huawei (Phase 3), Wear OS / WatchOS (Phase 4)
**Languages:** English, Arabic (with full RTL support), Bahasa Melayu — expandable to more languages post-launch
**Target Market:** Men aged 22-55 in committed relationships — initially targeting English-speaking, Arabic-speaking (GCC/MENA), and Malay-speaking (Malaysia/Brunei/Singapore) markets
**Business Model:** Freemium + Affiliate Revenue + In-App Purchases

**Unique Value Proposition:**
The first AI-powered relationship assistant that combines personality profiling (zodiac, love language, cultural background), smart reminders, AI-generated personalized messages, gift recommendations, and an emergency "SOS Mode" — all in one app designed specifically to help men become more thoughtful partners. Launches in 3 languages (English, Arabic, Bahasa Melayu) to serve a combined addressable market of 1.5+ billion people.

---

# 2. PRODUCT VISION & FEATURES

## 2.1 Core Feature Set

### Module 1: Smart Reminder Engine
- Important date tracking (birthday, anniversary, first date, etc.)
- Recurring reminders (weekly flowers, monthly date night)
- Life routine reminders (groceries, bills, doctor appointments)
- Family event reminders (in-law birthdays, gatherings)
- Escalating notification system (7 days, 3 days, 1 day, same day)
- Google Calendar / Outlook / Apple Calendar sync
- **Promise tracker** — log promises made to her, get reminded to follow through
- **Wish List Capture** — quick-log when she casually mentions wanting something ("she said she liked that bag"), app reminds him to buy it at the right moment

### Module 2: AI Message Generator
- AI-generated love messages tailored to her personality profile
- **Situational message modes** — user picks scenario, AI generates personalized message:
  - Appreciation & compliments
  - Apology & conflict repair
  - Reassurance & emotional support
  - Motivation & encouragement
  - Celebration & milestones
  - Flirting & romance
  - After-argument repair
  - Long-distance support
  - Good morning / good night rituals
  - "Just checking on you" care messages
  - Pregnancy/health support messages
- Tone adjustment (romantic, funny, poetic, casual, formal)
- **Humor tolerance calibration** — AI adjusts humor level based on her profile (from "no jokes please" to "make her laugh")
- **Multi-language support (English, Arabic, Bahasa Melayu):**
  - AI generates messages natively in user's chosen language (not translated — written from scratch per language)
  - Arabic messages use culturally appropriate endearments, Islamic occasion awareness, and formal/informal register
  - Bahasa Melayu messages use natural Malaysian expressions, cultural idioms, and Malay relationship norms
  - Language-specific emoji and formatting (RTL punctuation for Arabic)
  - User can switch output language per message (e.g., send her a message in Arabic even if app UI is English)
- Message scheduling and auto-send via SMS/WhatsApp integration
- Copy-to-clipboard for manual sending
- **Context-aware adaptation** — messages automatically adjust based on current context (see Module 9)

### Module 3: Her Profile Engine (Personality Intelligence)
- **Dual-input system:** zodiac sets smart defaults, user can manually override ANY trait
- Zodiac sign & compatibility analysis (AI-generated defaults)
- Love Language assessment (Words, Touch, Gifts, Acts, Quality Time)
- **Communication style preference** (romantic / playful / calm / formal / direct)
- **Conflict style** (needs space / wants to talk immediately / needs physical comfort / needs written words)
- **Stress triggers & coping style** (what overwhelms her, what calms her)
- **Humor tolerance level** (scale: serious <-> loves jokes, with type: sarcastic / wholesome / dark / silly)
- Age & relationship stage awareness
- Cultural background & tradition tracking
- **Preferred language** — which language she prefers for messages (English / Arabic / Bahasa Melayu)
- **Cultural-religious context** — Islamic holidays (Eid, Ramadan), Malay festivals (Hari Raya), Western holidays — app auto-adjusts events and suggestions
- Interests, hobbies, and favorites database
- Food preferences & dietary restrictions
- Fashion style & size tracking (for gift accuracy)
- **Sensitive topics list** — subjects to avoid (past trauma, insecurities, family issues)
- **Important stories vault** — meaningful memories, how they met, inside jokes, her proudest moments (AI references these in messages)
- **Wish list** — things she's mentioned wanting (items, experiences, places to visit)
- **Favorite things quick reference** — flowers, colors, scents, restaurants, music, movies
- Mood pattern tracking (optional)

### Module 4: Gift Recommendation Engine
- AI-powered gift suggestions based on:
  - Her full personality profile (zodiac + manual overrides + love language + interests)
  - Budget range (user-defined)
  - Location-based availability (local shops, online delivery)
  - Occasion type (birthday, anniversary, apology, "just because")
  - **Past gift performance** — "this gift worked" / "she didn't love it" feedback loop (AI learns over time)
  - **Her wish list items** — auto-suggest from things she's mentioned wanting
- Affiliate integration with e-commerce platforms
- Price comparison across vendors
- One-tap gift ordering
- Gift history tracking (avoid duplicates)
- **Complete gift package suggestion:**
  - The gift itself
  - **Presentation idea** ("wrap it in her favorite color", "hide it in her bag")
  - **Message to attach** (AI-generated card message matching the gift)
  - **Backup plan** (alternative if primary gift unavailable)
- **"Low Budget, High Impact" mode** — AI prioritizes emotional value over price tag:
  - Handwritten letter templates
  - DIY gift ideas
  - Free experience suggestions (sunset walk, home-cooked dinner, playlist)
  - "Under $20 that feels like $200" curated suggestions
- **Gift timing intelligence** — "Don't give it on her birthday (expected). Give it on a random Tuesday (unexpected)."

### Module 5: SOS Mode (Emergency Relationship Assist)
- "She's Upset" quick assessment wizard
- Situation-based AI response generator
- "I Forgot Our Anniversary" damage-control protocol
- Real-time conversation coach ("What should I say?")
- Instant gift/flower delivery integration
- Apology message generator with escalation levels
- **Context-aware SOS** — uses current context data (Module 9) to tailor emergency response

### Module 6: Gamification & Engagement
- Thoughtfulness Streak tracker
- Points system for completed relationship "missions"
- Levels: Rookie > Good Partner > Thoughtful Husband > Legend
- **Relationship Consistency Score** — weekly/monthly metric tracking:
  - Messages sent (thoughtful, not just "ok")
  - Events remembered (without last-minute panic)
  - Caring actions completed
  - **Promises kept** (from promise tracker)
  - Surprise gestures executed
  - Wish list items fulfilled
- **Improvement trend graph** — visual chart showing relationship effort over weeks/months
- **"Next Best Action" suggestion** — AI recommends the single most impactful thing to do today based on current context
- Weekly challenges ("Surprise her with breakfast this week")
- Achievement badges
- **Milestone celebrations** — "You've been consistently thoughtful for 30 days!" with shareable badge

### Module 7: Community (Phase 2)
- Anonymous tips board
- Success stories & testimonials
- Weekly curated relationship advice
- Expert Q&A sessions

### Module 8: Smartwatch Companion (Phase 4)
- Discreet wrist-tap notifications
- Quick-reply AI messages from watch
- Daily thoughtfulness streak display
- Wear OS + WatchOS support

### Module 9: Smart Action Cards (NEW — Proactive AI Suggestions)
Instead of passive reminders ("Anniversary tomorrow"), the app delivers **contextual action cards** that tell the user exactly what to do, say, buy, and where to go.

**Daily Context Check-In (5-second tap):**
- Quick mood/status input: "How's her day?" (Great / Normal / Stressed / Upset / Sick)
- Quick context tags: Travel mode / Busy week / Conflict happened / She's on her period / Pregnant
- AI remembers context and adjusts ALL suggestions across the entire app

**Smart Action Card Format:**
Each card provides a complete action plan:
```
┌─────────────────────────────────────────────┐
│  CONTEXT: She had a stressful work week     │
│  + Anniversary is in 3 days                 │
│─────────────────────────────────────────────│
│  SAY:  "I know this week was tough.         │
│         Let's do something low-key          │
│         this weekend — just us."            │
│                                             │
│  DO:   Plan a quiet home date night         │
│        (she's drained — skip the fancy      │
│         restaurant this time)               │
│                                             │
│  BUY:  Comfort gift under $40:              │
│        - Her favorite candle + bath bomb    │
│        - Available at [Store near you]      │
│                                             │
│  GO:   Skip loud venues. Suggest:           │
│        - Walk at [nearby park] at sunset    │
│        - Cozy café [3 min drive]            │
│                                             │
│  PHRASE IT: "No big plans needed.           │
│   I just want to be with you."             │
└─────────────────────────────────────────────┘
```

**Card Categories:**
- Daily proactive suggestions (1-2 per day)
- Event-triggered cards (birthday approaching + current context)
- Mood-reactive cards (she's stressed → adjust everything)
- Seasonal cards (Valentine's prep, holiday planning)
- Recovery cards (post-argument → step-by-step repair plan)
- "Random Act of Kindness" cards (unprompted surprise ideas)

**AI Adaptation Rules:**
- If she's sick → avoid activity suggestions, focus on care actions
- If conflict happened → avoid humor, focus on repair and space
- If she's in travel mode → suggest long-distance gestures
- If busy week → suggest low-effort but high-impact micro-actions
- If she's on her period → suggest comfort-focused actions, avoid demanding plans
- If she's pregnant → adjust per trimester (Psychiatrist-validated)

### Module 10: Relationship Memory Vault (NEW)
A searchable, AI-powered memory bank that stores everything meaningful about the relationship, making the AI deeply personal over time.

**What Gets Stored:**
- **Important stories** — how they met, first kiss, proposal story, funny incidents
- **Inside jokes** — AI can reference these in messages for authenticity
- **Sensitive topics** — subjects to never bring up (linked to Module 3)
- **Past conflicts & resolutions** — what went wrong, what fixed it (helps SOS Mode learn)
- **Gift history with ratings** — what was given, her reaction (1-5 stars), notes
- **Her casual mentions** — "I wish I could go to Paris", "I love that necklace" (auto-feeds wish list)
- **Milestone timeline** — visual relationship history (first date, moved in, engaged, etc.)
- **Favorite restaurants, places, activities** — auto-suggested for date planning
- **What works for HER specifically** — over time, AI learns: "For your wife, humor works best for apologies but sincerity works best for random love messages"

**How AI Uses the Vault:**
- Messages reference real memories: "Remember that rainy day in [place]? That's when I knew..."
- Gift suggestions avoid past failures and repeat past successes
- SOS Mode checks what resolution worked last time
- Action Cards use her actual favorite places and activities
- The longer the user uses the app, the smarter and more personal it becomes

**Privacy & Security:**
- All vault data encrypted at rest (AES-256) and in transit (TLS 1.3)
- Biometric lock option for vault access (fingerprint / Face ID)
- Data never shared with third parties
- User can export or delete all data at any time (GDPR compliant)

---

## 2.2 Technical Architecture Overview

```
+--------------------------------------------------+
|                  CLIENT LAYER                     |
|  Flutter App (Dart) ── Single Codebase            |
|    ├── Android (Google Play Store)                |
|    ├── iOS (Apple App Store)                      |
|    ├── HarmonyOS (Huawei AppGallery) [Phase 3]   |
|    └── Wear OS / WatchOS [Phase 4]               |
+--------------------------------------------------+
                        |
                    REST API / GraphQL
                        |
+--------------------------------------------------+
|                BACKEND LAYER                      |
|  API Gateway (Node.js TypeScript / Dart Shelf)    |
|  Authentication Service (Firebase Auth)           |
|  Notification Service (FCM + APNs)                |
|  Scheduling Engine (Cloud Functions / Cron)       |
+--------------------------------------------------+
                        |
+--------------------------------------------------+
|          AI LAYER — MULTI-MODEL ARCHITECTURE      |
|                                                    |
|  ┌──────────────────────────────────────────────┐ |
|  │         AI ROUTER / ORCHESTRATOR              │ |
|  │  Routes each request to optimal model based   │ |
|  │  on: task type, emotional depth needed,       │ |
|  │  cost budget, model availability              │ |
|  └──────┬──────┬──────────┬──────────┬──────────┘ |
|         │      │          │          │            |
|  ┌──────▼──┐┌──▼─────┐┌──▼──────┐┌──▼────────┐  |
|  │ CLAUDE  ││ GROK   ││ GEMINI  ││ GPT-5     │  |
|  │ Haiku/  ││ 4.1    ││ Flash   ││ Mini      │  |
|  │ Sonnet  ││ Fast   ││         ││           │  |
|  │         ││        ││         ││           │  |
|  │Emotional││Crisis  ││Data &   ││Fallback   │  |
|  │Messages ││SOS Mode││Gift     ││& General  │  |
|  │Action   ││Convo   ││Search   ││Tasks      │  |
|  │Cards    ││Coach   ││Location ││           │  |
|  │Zodiac   ││Humor   ││Memory   ││           │  |
|  └─────────┘└────────┘└─────────┘└───────────┘  |
|                                                    |
|  Shared Services:                                  |
|  - Prompt Engineering Service                      |
|  - Personality Analysis Engine                     |
|  - Smart Action Card Generator                     |
|  - Context Awareness Engine                        |
|  - **Localization Engine (EN/AR/MS)**              |
|  - Response Cache (Redis)                          |
|  - Content Safety Filter                           |
+--------------------------------------------------+
                        |
+--------------------------------------------------+
|                DATA LAYER                         |
|  Firebase Firestore (User Data)                   |
|  PostgreSQL (Relational Data)                     |
|  Redis (Caching & Sessions + AI Response Cache)   |
|  Cloud Storage (Media Assets)                     |
|  Relationship Memory Vault (AES-256 Encrypted)    |
|  Pinecone / Weaviate (Vector DB — personality     |
|    matching + memory retrieval)                    |
|  ARB Localization Files (EN/AR/MS translations)   |
+--------------------------------------------------+
                        |
+--------------------------------------------------+
|             THIRD-PARTY INTEGRATIONS              |
|  Google Calendar API + Apple Calendar (EventKit)  |
|  WhatsApp Business API                            |
|  E-commerce Affiliate APIs                        |
|  Payment Gateway (RevenueCat / Stripe)            |
|  Flower/Gift Delivery APIs                        |
|  Astrology/Zodiac Data API                        |
+--------------------------------------------------+
```

> **Why Flutter?** Single codebase deploys to Android + iOS simultaneously at launch. Eliminates the need for separate iOS development in Phase 2, saving $56K-$96K. Flutter's rendering engine (Impeller) provides 60fps animations critical for gamification features. HarmonyOS support via community port or ArkUI-X wrapper in Phase 3.

> **Why Multi-Model AI?** No single AI excels at everything. Claude leads in warmth and emotional depth, Grok has the highest EQ benchmark score (1586 Elo on EQ-Bench3) for crisis empathy, Gemini Flash is 20x cheaper for data tasks, and GPT-5 Mini provides reliable fallback. Multi-model reduces costs by 60-70% while delivering best-in-class quality per task.

### 2.3 Multi-Language Architecture (English, Arabic, Bahasa Melayu)

**Two-Layer Localization Strategy:**

| Layer | What It Covers | Technology | Notes |
|-------|---------------|------------|-------|
| **UI Localization** | All static text — buttons, labels, menus, onboarding, settings, error messages | Flutter `intl` + ARB files (`app_en.arb`, `app_ar.arb`, `app_ms.arb`) | Fully offline, instant switching |
| **AI Content Localization** | All dynamic text — AI messages, action cards, gift descriptions, SOS advice | Multi-model AI generates natively per language (not post-translated) | Each prompt includes `target_language` parameter |

**Arabic-Specific Requirements (RTL):**
- Full Right-to-Left (RTL) layout using Flutter's `Directionality` widget and `TextDirection.rtl`
- `EdgeInsetsDirectional` instead of `EdgeInsets` throughout (start/end, not left/right)
- Mirrored navigation, icons, and swipe gestures
- Arabic-optimized fonts: Noto Naskh Arabic (body), Cairo or Tajawal (headings)
- RTL-aware number formatting (Arabic-Indic numerals optional, user preference)
- `DateFormat` with Arabic locale (`ar`) for Hijri date support alongside Gregorian
- Bidirectional text handling for mixed Arabic-English content (names, brands)

**Bahasa Melayu Requirements:**
- Standard LTR layout (same as English)
- Bahasa Melayu-optimized fonts (Noto Sans covers Malay Latin script)
- Malay date formatting (`DateFormat` with `ms` locale)
- Support for Jawi script as optional future addition

**AI Multi-Language Generation Strategy:**
- All AI prompts include `language` and `cultural_context` parameters
- Prompts are NOT translated — separate prompt templates exist per language for cultural accuracy
- Arabic prompts include: Islamic greeting conventions, Arabic endearment terms (حبيبتي، يا عمري), formal vs. Egyptian/Gulf/Levantine dialect options
- Malay prompts include: Malaysian cultural norms, Malay endearments (sayang, cinta), respectful register for elders
- All 4 AI models (Claude, Grok, Gemini, GPT) support EN/AR/MS — Claude and GPT have strongest Arabic quality; Gemini has strong Malay support
- AI response caching is language-specific (separate cache keys per locale)

**Language Detection & Switching:**
- User selects app language during onboarding (can change anytime in settings)
- Her Profile includes "preferred message language" (can differ from app UI language)
- AI messages generate in her preferred language by default
- Quick toggle: user can override per message ("send this one in Arabic")

### 2.4 AI Model Task Routing Map

| App Feature | Primary Model | Fallback Model | Why This Model | Cost/1M Tokens (In/Out) |
|-------------|--------------|----------------|----------------|------------------------|
| **Daily love messages** (high volume) | Claude Haiku 4.5 | Grok 4.1 Fast | Warm, empathetic, cheapest for emotional content | $1 / $5 |
| **Special occasion messages** (premium) | Claude Sonnet 4.5 | Claude Haiku 4.5 | Deepest emotional intelligence, references memories beautifully | $3 / $15 |
| **SOS Mode — "She's upset"** (crisis) | Grok 4.1 Fast | Claude Sonnet 4.5 | Highest EQ-Bench3 score, most human-like crisis empathy | $0.20 / $0.50 |
| **Smart Action Cards** (daily proactive) | Claude Haiku 4.5 | Grok 4.1 Fast | Fast, warm, cheap enough for multiple daily cards | $1 / $5 |
| **Conversation coaching** (real-time) | Grok 4.1 Fast | Claude Haiku 4.5 | Most natural conversational tone, feels like a friend's advice | $0.20 / $0.50 |
| **After-argument repair** (delicate) | Grok 4.1 Fast | Claude Sonnet 4.5 | Best emotional awareness for sensitive situations | $0.20 / $0.50 |
| **Gift recommendations** (data/search) | Gemini Flash | GPT-5 Mini | Cheapest, fastest for structured data and location queries | $0.075 / $0.30 |
| **Gift presentation ideas** | Claude Haiku 4.5 | Grok 4.1 Fast | Creative, warm suggestions need emotional touch | $1 / $5 |
| **Memory Vault queries** (retrieval) | Gemini Flash | GPT-5 Mini | Fast retrieval, cheap, good at structured search | $0.075 / $0.30 |
| **Zodiac personality analysis** | Claude Sonnet 4.5 | Claude Haiku 4.5 | Best at nuanced, detailed personality writing | $3 / $15 |
| **Context awareness processing** | Gemini Flash | GPT-5 Mini | Fast inference for real-time context classification | $0.075 / $0.30 |
| **Humor-calibrated messages** | Grok 4.1 Fast | Claude Haiku 4.5 | Most natural humor, doesn't feel forced | $0.20 / $0.50 |
| **Pregnancy/health messages** | Claude Sonnet 4.5 | Claude Haiku 4.5 | Strongest safety guardrails for sensitive medical-adjacent content | $3 / $15 |
| **General fallback** (any model down) | GPT-5 Mini | Claude Haiku 4.5 | Most reliable uptime, decent emotional quality | ~$3 / $6 |

### 2.5 AI Router Decision Logic

```
User Request Arrives
        │
        ▼
┌───────────────────┐
│  CLASSIFY REQUEST  │
│  - Task type?      │
│  - Emotional depth │
│    needed? (1-5)   │
│  - Latency need?   │
│  - Cost tier?      │
│  - Language? (EN/  │
│    AR/MS)          │
└────────┬──────────┘
         │
    ┌────▼────┐
    │ Emotion  │──── depth >= 4 ──→ Is it crisis/SOS?
    │ Score?   │                         │
    └────┬────┘                    Yes ──▼──── GROK 4.1 FAST
         │                         No  ──▼──── CLAUDE SONNET 4.5
    depth 2-3 ──→ CLAUDE HAIKU 4.5
         │
    depth 1 (data only) ──→ GEMINI FLASH
         │
    ┌────▼──────────┐
    │ PRIMARY MODEL  │
    │ AVAILABLE?     │
    └────┬──────┬───┘
       Yes     No
         │      │
         ▼      ▼
      EXECUTE  ROUTE TO
      REQUEST  FALLBACK MODEL
         │
         ▼
    ┌─────────────┐
    │ SAFETY CHECK │ ← Content filter before returning to user
    └──────┬──────┘
           │
           ▼
    ┌──────────────┐
    │ LANGUAGE CHECK│ ← Verify output is in requested language (EN/AR/MS)
    └──────┬───────┘
           │
           ▼
    ┌─────────────┐
    │ CACHE RESULT │ ← Cache per language (separate keys for EN/AR/MS)
    └──────┬──────┘
           │
           ▼
      RETURN TO APP
```

### 2.6 Cost Optimization Strategies

| Strategy | How It Works | Savings |
|----------|-------------|---------|
| **Response caching** | Cache common message types (good morning for Scorpio + romantic tone). Serve cached response if <24hrs old. | 30-40% reduction |
| **Prompt compression** | Use efficient prompt templates. Include only relevant personality fields per request, not entire profile. | 20-30% token reduction |
| **Tiered model routing** | Use cheapest model (Gemini Flash) for data tasks, premium models only when emotional depth is needed. | 60-70% vs. single premium model |
| **Batch processing** | Pre-generate next-day's action cards overnight using batch API (50% discount). | 50% on batch-eligible tasks |
| **Smart fallback** | If primary model returns low-quality output (safety filter triggered), retry once with fallback model before serving template. | Avoids wasted retries |
| **Per-user monthly cap** | Free tier: 50 AI generations/month. Pro: 500. Legend: unlimited. Prevents abuse. | Predictable costs |

---

# 3. PROJECT PHASES & TIMELINE

## Phase 1: Discovery & Planning (Weeks 1-4)

| Week | Activity | Deliverables | Team Involved |
|------|----------|-------------|---------------|
| 1 | Market research deep-dive | Competitive analysis report | Product Manager |
| 1 | Define user personas & journeys | User persona documents (x3) | UX Designer, Product Manager, Female Consultant |
| 1 | Women's Emotional State Framework kickoff | Framework outline | Psychiatrist |
| 1 | Zodiac Master Profiles kickoff | 12-sign profile research begins | Astrologist |
| 1 | App concept female validation | "Would women support or oppose this app?" report | Female Consultant |
| 2 | Feature prioritization (MoSCoW) | Prioritized feature backlog | Product Manager, Tech Lead |
| 2 | Technical architecture design | Architecture document, tech stack decision | Tech Lead, Backend Developer |
| 2 | Women's Emotional State Framework delivery | Complete psychological framework document | Psychiatrist |
| 2-3 | "What She Actually Wants" document | 100+ real-world scenario cards | Female Consultant + Psychiatrist |
| 2-3 | 12 Zodiac Master Profiles delivery | Comprehensive personality profiles per sign | Astrologist |
| 3 | Wireframing (all screens) | Low-fidelity wireframes (30+ screens) | UX/UI Designer |
| 3 | AI prompt engineering research | AI strategy document | AI/ML Engineer |
| 3-4 | 144 Compatibility Pairing Guides | All zodiac x zodiac dynamics | Astrologist |
| 4 | Project plan finalization | Sprint plan, resource allocation | Product Manager, all leads |
| 4 | Design system creation | Color palette, typography, component library | UX/UI Designer |
| 4 | Cultural Sensitivity Guide | Cross-cultural emotional needs guide | Female Consultant |
| 4 | AI Content Guidelines | Do's/don'ts per emotional state | Psychiatrist + Female Consultant |
| 4 | Smart Action Card scenarios | 50+ contextual action card templates | Female Consultant + Psychiatrist |
| 4 | Gift feedback framework | Rating system design + "what worked/failed" criteria | Female Consultant |
| 3-4 | **Multi-language strategy kickoff** | Localization architecture document (ARB structure, RTL plan, AI prompt strategy per language) | Tech Lead + AI/ML Engineer |
| 3-4 | **Arabic cultural context guide** | Arabic endearment conventions, Islamic occasion calendar, Gulf vs. Levantine vs. Egyptian dialect strategy | Female Consultant + Psychiatrist |
| 3-4 | **Malay cultural context guide** | Malaysian relationship norms, Malay cultural expressions, Hari Raya and local festival calendar | Female Consultant |
| 4 | **UI string catalog (English master)** | Complete list of all UI strings for translation (~500-800 strings) | UX Designer + Product Manager |

**Milestone:** Approved architecture + wireframes + sprint backlog + domain expert frameworks + action card templates + localization strategy complete

---

## Phase 2: UI/UX Design (Weeks 5-8)

| Week | Activity | Deliverables | Team Involved |
|------|----------|-------------|---------------|
| 5-6 | High-fidelity UI design | All screen designs (Figma) — English (LTR) | UX/UI Designer |
| 5-6 | **Arabic RTL design variants** | RTL-mirrored layouts for all screens (Figma) — Arabic | UX/UI Designer |
| 5 | Brand identity finalization | Logo, icon, color system, typography (including Arabic + Malay fonts) | UX/UI Designer |
| 6 | Interactive prototype | Clickable prototype for user testing — English + Arabic RTL | UX/UI Designer |
| 6 | **Arabic UI string translation** | Professional Arabic translation of all ~500-800 UI strings | Arabic Translator (contract) |
| 6 | **Bahasa Melayu UI string translation** | Professional Malay translation of all ~500-800 UI strings | Malay Translator (contract) |
| 7 | User testing (10-15 men) | User feedback report — include Arabic and Malay speakers if possible | UX/UI Designer, Product Manager |
| 7 | Design iteration based on feedback | Revised designs (LTR + RTL) | UX/UI Designer |
| 8 | Design handoff to development | Annotated designs + RTL guidelines, asset export | UX/UI Designer |
| 8 | API contract definition | API documentation (Swagger/OpenAPI) — include locale parameter in all content endpoints | Tech Lead, Backend Developer |

**Milestone:** Final approved designs (LTR + RTL) + API contracts + translated UI strings (EN/AR/MS) ready

---

## Phase 3: MVP Development - Sprint 1-4 (Weeks 9-16)

### Sprint 1 (Weeks 9-10): Foundation
| Task | Owner |
|------|-------|
| Flutter project setup (Dart, Riverpod/Bloc, GoRouter, folder structure) | Flutter Tech Lead |
| **Flutter localization setup** — `flutter_localizations`, `intl` package, ARB file structure (`app_en.arb`, `app_ar.arb`, `app_ms.arb`), locale-aware widgets | Flutter Tech Lead |
| **RTL infrastructure** — `Directionality` widget, `EdgeInsetsDirectional` throughout, RTL-aware navigation/icons | Flutter Tech Lead |
| **Arabic font integration** — Noto Naskh Arabic, Cairo/Tajawal fonts bundled + fallback chain | Flutter Tech Lead |
| Firebase setup (Auth, Firestore, FCM) for both Android + iOS | Backend Developer |
| Navigation framework + base UI components + design system implementation (LTR + RTL variants) | Flutter Tech Lead |
| User authentication (email, Google, Apple Sign-In) | Backend Developer |
| **Language selection in onboarding** — user picks app language (EN/AR/MS), persisted locally | Flutter Tech Lead |
| CI/CD pipeline setup (GitHub Actions for Android APK + iOS IPA builds) | DevOps / Tech Lead |
| Database schema design (including Relationship Memory Vault encrypted storage + locale fields) | Backend Developer |
| Biometric lock service implementation (fingerprint / Face ID for vault) | Flutter Tech Lead |

### Sprint 2 (Weeks 11-12): Core Features Part 1
| Task | Owner |
|------|-------|
| Onboarding flow (user profile + her profile setup with dual-input: zodiac defaults + manual overrides) — **all 3 languages** | Flutter Developer |
| Her Profile Engine (zodiac, love language, communication style, conflict style, humor tolerance, stress triggers, **preferred language, cultural-religious context**) | Flutter Developer + Backend |
| Relationship Memory Vault — core data model + encrypted storage + CRUD operations | Backend Developer + Flutter |
| Wish List Capture feature (quick-log "she mentioned wanting X") | Flutter Developer |
| Smart Reminder Engine (date tracking, notifications, **promise tracker**) — **locale-aware date formatting (Gregorian + Hijri)** | Flutter Developer |
| Calendar sync integration (Google Calendar + Apple Calendar) | Backend Developer |
| Push notification system (FCM for Android + APNs for iOS) — **notification text pulled from ARB per user locale** | Backend Developer |
| **Integrate translated ARB files** — wire all 3 language files into onboarding, profile, reminders, settings | Flutter Developer |
| Unit + widget tests for core logic — **include RTL layout tests and locale switching tests** | QA Engineer |

### Sprint 3 (Weeks 13-14): Core Features Part 2 + Multi-Model AI Engine
| Task | Owner |
|------|-------|
| **AI Router / Orchestrator** — build routing service with model selection logic, failover, and caching | AI/ML Engineer + Backend |
| Integrate 4 AI providers: Claude API, Grok API, Gemini API, OpenAI API | AI/ML Engineer + Backend |
| Build model-specific prompt adapters (each model needs different prompting strategy) | AI/ML Engineer |
| AI Message Generator with **10 situational modes** routed to Claude Haiku/Sonnet | AI/ML Engineer |
| Prompt engineering: personality-based + context-aware + humor-calibrated (Grok for humor) — **language-specific prompt templates (EN/AR/MS)** | AI/ML Engineer |
| **Arabic AI prompt library** — separate prompt chains with Arabic cultural context, endearments, and Islamic occasion awareness | AI/ML Engineer |
| **Bahasa Melayu AI prompt library** — separate prompt chains with Malay cultural context, expressions, and festival awareness | AI/ML Engineer |
| **Daily Context Check-In UI** (5-second mood/status tap screen) | Flutter Developer |
| **Context Awareness Engine** — backend logic to feed context into all AI prompts | AI/ML Engineer + Backend |
| Message UI (situational mode picker, tone selection, copy/share) | Flutter Developer |
| Gift Recommendation Engine routed to **Gemini Flash** with **feedback loop** | AI/ML Engineer + Backend |
| **"Low Budget, High Impact" gift mode** + presentation ideas (Claude Haiku) + attached message | AI/ML Engineer |
| AI response cache (Redis) — cache common patterns for 30-40% cost savings — **language-specific cache keys** | Backend Developer |
| Per-model cost tracking dashboard — **include per-language cost breakdown** | AI/ML Engineer + Backend |
| Settings & preferences screens | Flutter Developer |
| Important stories + inside jokes + sensitive topics vault UI | Flutter Developer |
| Integration testing (both Android + iOS) + AI output quality testing across all 4 models **in all 3 languages** | QA Engineer |

### Sprint 4 (Weeks 15-16): Smart Actions + Gamification + Polish
| Task | Owner |
|------|-------|
| **Smart Action Cards engine** — contextual cards via Claude Haiku + Gemini Flash for location data | AI/ML Engineer + Backend |
| **Smart Action Cards UI** — swipeable cards with complete action plans | Flutter Developer |
| SOS Mode routed to **Grok 4.1 Fast** (highest EQ for crisis empathy) + context-aware response | AI/ML Engineer + Flutter |
| Batch processing pipeline — pre-generate next-day action cards overnight at 50% API discount | AI/ML Engineer + Backend |
| Gamification system: streaks, points, levels, **Relationship Consistency Score**, **improvement trend graph** | Flutter Developer |
| **"Next Best Action" AI suggestion** — single most impactful daily action | AI/ML Engineer |
| Milestone celebrations with shareable badges | Flutter Developer |
| Payment integration (RevenueCat for unified Android + iOS subscriptions) | Backend Developer + Flutter |
| Subscription management (Free / Pro tiers) | Backend Developer |
| Memory Vault — AI integration (messages reference stored memories, gifts use wish list) | AI/ML Engineer + Backend |
| End-to-end testing on both platforms **in all 3 languages** | QA Engineer |
| **RTL full regression testing** — verify all screens render correctly in Arabic (mirrored layout, fonts, punctuation) | QA Engineer |
| **Multi-language AI output quality review** — native speakers validate AI message quality in Arabic and Bahasa Melayu | QA Engineer + Arabic/Malay reviewers |
| Performance optimization (Impeller rendering, app size — account for Arabic font bundle) | Flutter Developer + Tech Lead |
| Platform-specific testing (iOS permissions, Android notifications) | QA Engineer |
| Bug fixes from QA | All developers |

**Milestone:** MVP feature-complete with all 10 modules in 3 languages, internal testing passed

---

## Phase 4: Testing & QA (Weeks 17-19)

| Week | Activity | Deliverables |
|------|----------|-------------|
| 17 | Comprehensive QA testing (all 3 languages) | Bug report + severity classification |
| 17 | Security audit (data privacy, encryption) | Security assessment report |
| 17 | **Multi-language QA** — native Arabic and Malay speakers test full app flow | Language-specific bug report |
| 17 | **RTL visual audit** — screenshot comparison of all screens in Arabic vs. English | RTL compliance report |
| 18 | Beta release (closed group: 50-100 users — include Arabic & Malay users) | Beta APK (Android) + TestFlight (iOS) distribution |
| 18 | Performance testing (load, battery, memory) | Performance benchmark report |
| 19 | Beta feedback collection & analysis — **per-language feedback segregation** | Feedback summary + priority fixes |
| 19 | Critical bug fixes + final polish (including translation fixes) | Release candidate build |

**Milestone:** Release candidate approved

---

## Phase 5: Launch (Weeks 20-22)

| Week | Activity | Deliverables |
|------|----------|-------------|
| 20 | App Store Optimization (ASO) | Store listings in EN/AR/MS for BOTH Google Play + Apple App Store |
| 20 | Google Play Store + Apple App Store submission | Published app on both stores (under review) — targeting US, UK, UAE, Saudi Arabia, Malaysia, Brunei |
| 21 | Marketing launch campaign — **region-specific:** English (global), Arabic (GCC/MENA), Malay (MY/BN/SG) | Social media, influencer outreach, PR in 3 languages |
| 21 | Monitor crash reports & analytics | Firebase Crashlytics dashboard (both platforms) |
| 22 | First patch release (based on launch feedback) | v1.0.1 update on both stores |
| 22 | Post-launch retrospective | Lessons learned document |

**Milestone:** Live on Google Play Store + Apple App Store with stable v1.0 in 3 languages (EN/AR/MS)

---

## Phase 6: Post-Launch Growth (Weeks 23-36)

| Period | Focus | Key Deliverables |
|--------|-------|-----------------|
| Weeks 23-26 | Iteration based on user feedback | v1.1 with top-requested improvements (both platforms) |
| Weeks 23-26 | Affiliate partnerships | Signed agreements with gift/flower vendors |
| Weeks 27-30 | Community features (anonymous tips, success stories) | v1.2 with social features |
| Weeks 27-30 | **HarmonyOS / Huawei port begins** | HarmonyOS native wrapper via ArkUI-X or Flutter OHOS port |
| Weeks 27-30 | Huawei AppGallery setup | Huawei developer account, HMS Core integration |
| Weeks 31-36 | Smartwatch companion app | Wear OS + WatchOS companion v1.0 |
| Weeks 31-36 | Advanced AI features | Enhanced personality engine, mood prediction |
| Weeks 31-36 | **HarmonyOS app launch** | Published on Huawei AppGallery |

---

## Timeline Summary (Visual)

```
Month 1       Month 2       Month 3       Month 4       Month 5       Month 6-9
[Discovery]   [UI/UX]       [Dev Sprint   [Dev Sprint   [QA &         [Post-Launch
 & Planning    Design        1 & 2]        3 & 4]        Launch]        & Growth]
    |             |             |             |             |              |
    v             v             v             v             v              v
 Research      Figma         Foundation    AI + Gifts    Beta Test     HarmonyOS
 Wireframes    Prototype     Reminders     SOS Mode      Go Live!      Huawei Port
 Architecture  User Tests    Her Profile   Gamification  Android+iOS   Watch Apps
 Domain Exp.   RTL Design    Flutter App   Payments      BOTH Stores   Community
 L10n Strategy Translations  EN/AR/MS      3-Lang AI     3-Lang QA     New Languages
```

**Total MVP Timeline: ~22 weeks (5.5 months) — Android + iOS simultaneously**
**Full Product (all 3 platforms + watch): ~9 months**

---

# 4. TEAM STRUCTURE

## 4.1 Organization Chart

```
                         +---------------------+
                         |    Product Owner     |
                         |    (You / Founder)   |
                         +----------+----------+
                                    |
                         +----------+----------+
                         |   Product Manager    |
                         +----------+----------+
                                    |
     +-------------+----------------+----------------+-------------+
     |              |                |                |             |
+----+----+  +------+------+  +-----+------+  +-----+------+  +---+---+
|Tech Lead|  |   UX/UI     |  |   AI/ML    |  |  Domain    |  |Market-|
|Sr.Flutter| |  Designer   |  |  Engineer  |  |  Experts   |  | ing   |
|Developer|  +-------------+  +------------+  |  Advisory   |  +-------+
+----+----+                                   |  Board     |
     |                                        +-----+------+
+----+----+                                         |
| Backend |                          +--------------+--------------+
|Developer|                          |              |              |
+----+----+                   +------+-----+ +-----+------+ +-----+------+
     |                        | Psychiatrist| | Astrologist | |  Female    |
+----+----+                   | (Women's   | | (Zodiac    | | Consultant |
|   QA    |                   | Psychology)| | Expert)    | | (Emotional |
| Engineer|                   +------------+ +------------+ | Intelligence|
+---------+                                                 +------------+
```

## 4.2 Team Roster

### Technical Team

| # | Role | Type | Phase Needed | Commitment |
|---|------|------|-------------|------------|
| 1 | **Product Manager** | Full-time | All phases | Weeks 1-36 |
| 2 | **Tech Lead / Senior Flutter Developer** | Full-time | Phase 2-6 | Weeks 5-36 |
| 3 | **UX/UI Designer** | Full-time then Part-time | Phase 1-5, then on-call | Weeks 1-22 FT, then PT |
| 4 | **Backend Developer** | Full-time | Phase 3-6 | Weeks 9-36 |
| 5 | **AI/ML Engineer** | Full-time | Phase 3-6 | Weeks 9-36 |
| 6 | **QA Engineer** | Full-time | Phase 3-5, then Part-time | Weeks 9-22 FT, then PT |
| 7 | **DevOps Engineer** | Part-time / Contractor | Phase 3, 5 | Weeks 9-12, 20-22 |
| 8 | **Marketing Specialist** | Part-time then Full-time | Phase 4-6 | Weeks 17-36 |

### Domain Expert Advisory Board

| # | Role | Type | Phase Needed | Commitment |
|---|------|------|-------------|------------|
| 9 | **Psychiatrist / Women's Psychology Expert** | Part-time Consultant | Phase 1-6 | Weeks 1-36 (8-12 hrs/week) |
| 10 | **Professional Astrologist** | Part-time Consultant | Phase 1, 3, then on-call | Weeks 1-4, 9-16 (10 hrs/week), then 4 hrs/week |
| 11 | **Female Consultant / Emotional Intelligence Advisor** | Part-time Consultant | Phase 1-6 | Weeks 1-36 (8-12 hrs/week) |

**Total Team Size: 8 technical + 3 domain experts = 11 members**
**Core Team Size: 6 full-time + 2 part-time technical + 3 domain consultants**
**MVP Team Size (minimum): 6 technical + 3 domain experts**

> **Why Domain Experts are Non-Negotiable:** Without these 3 specialists, the AI generates generic internet-level advice. With them, LOLO delivers clinically-informed, astrologically-accurate, and emotionally-authentic content that no competitor can replicate. They are the app's **unfair advantage**.

---

## 4.3 Team Phasing (When to Hire)

```
Week 1  ====> Product Manager + UX/UI Designer
Week 1  ====> Psychiatrist + Astrologist + Female Consultant (Domain Advisory Board)
Week 5  ====> Tech Lead / Senior Flutter Developer
Week 9  ====> Backend Developer + AI/ML Engineer + QA Engineer
Week 9  ====> DevOps Engineer (part-time contractor)
Week 17 ====> Marketing Specialist
```

> **Critical:** The 3 domain experts start on **Week 1** alongside the Product Manager. Their input shapes every feature from day one — the personality engine, message tone, zodiac logic, SOS mode scenarios, and content guidelines all depend on their expertise. Starting them later would mean expensive rework.

This staggered hiring reduces burn rate in early weeks when only planning and design work is happening.

---

# 5. JOB DESCRIPTIONS

---

## 5.1 Product Manager

**Job Title:** Product Manager - LOLO App
**Department:** Product
**Reports To:** Founder / Product Owner
**Employment Type:** Full-Time

### Role Summary
The Product Manager owns the product vision, roadmap, and backlog for the LOLO app. This person is the bridge between business goals, user needs, and the engineering team. They translate the founder's vision into actionable user stories, prioritize features, and ensure timely delivery of a product that users love.

### Key Responsibilities

**Product Strategy & Vision**
- Own and maintain the product roadmap aligned with business goals
- Conduct and maintain competitive analysis (Lovewick, Love Nudge, hip, Between, etc.)
- Define and track key product metrics (DAU, MAU, retention, conversion, ARPU)
- Make data-driven prioritization decisions using MoSCoW or RICE frameworks
- Define monetization strategy and pricing tiers

**User Research & Requirements**
- Conduct user interviews and surveys with target demographic (men 22-55)
- Create and maintain user personas and journey maps
- Write detailed user stories with clear acceptance criteria
- Validate features through prototype testing before development
- Analyze app store reviews (own app + competitors) for insights

**Agile Delivery Management**
- Lead sprint planning, daily standups, sprint reviews, and retrospectives
- Manage the product backlog in Jira/Linear/Notion
- Define sprint goals and ensure on-time delivery
- Remove blockers and make trade-off decisions
- Coordinate cross-functional communication between design, engineering, AI, and QA

**Stakeholder Management**
- Provide weekly progress reports to the founder
- Manage scope and expectations
- Coordinate with external partners (affiliate vendors, API providers)
- Plan and execute beta testing programs

**Go-to-Market**
- Collaborate with marketing on App Store Optimization (ASO)
- Define launch strategy and rollout plan
- Plan feature release communication
- Analyze post-launch metrics and drive iteration

### Tools & Methodologies
- Project Management: Jira, Linear, Notion, or Trello
- Analytics: Firebase Analytics, Mixpanel, or Amplitude
- Communication: Slack, Microsoft Teams
- Documentation: Confluence, Notion
- Methodology: Agile Scrum (2-week sprints)

---

## 5.2 Tech Lead / Senior Flutter Developer

**Job Title:** Tech Lead & Senior Flutter Developer
**Department:** Engineering
**Reports To:** Product Manager
**Employment Type:** Full-Time

### Role Summary
The Tech Lead is the technical authority on the project. They architect the cross-platform Flutter application, make technology decisions, write core code, conduct code reviews, and mentor the development team. This role owns the single codebase that ships to Android, iOS, and eventually HarmonyOS. This is a hands-on leadership role — expect 60% coding, 40% leadership.

### Key Responsibilities

**Technical Architecture**
- Design and own the overall Flutter application architecture (Clean Architecture + BLoC/Riverpod)
- Select and standardize the tech stack (Dart, state management, routing, DI, local storage)
- Design modular architecture with feature-first folder structure for scalability
- Define coding standards, branching strategy, and PR review process
- Architect offline-first data strategy with local caching (Hive/Isar + Firestore sync)
- Design the notification scheduling system (flutter_local_notifications + FCM + APNs)
- Define platform-specific abstraction layers (Android vs. iOS vs. future HarmonyOS)

**Hands-On Development**
- Build core UI framework using Flutter widgets + Material 3 / Cupertino adaptive design
- Implement navigation architecture (GoRouter or auto_route)
- Develop the Her Profile Engine and personality data models
- Build the Smart Reminder Engine with local + cloud scheduling
- Implement gamification system (streaks, points, levels) with Flutter animations (Rive/Lottie)
- Integrate payment system (RevenueCat for unified Android + iOS subscriptions)
- Handle platform channels for native functionality (calendar access, biometrics, etc.)

**Cross-Platform Excellence**
- Ensure pixel-perfect rendering on both Android and iOS
- Implement platform-adaptive UI (Material on Android, Cupertino on iOS where appropriate)
- Handle platform-specific permissions and behaviors (iOS photo library, Android notification channels)
- Manage Apple App Store and Google Play Store build configurations
- Optimize Impeller rendering engine performance for smooth 60fps animations
- Plan and architect HarmonyOS compatibility layer for Phase 3

**Multi-Language & RTL Implementation**
- Architect Flutter localization infrastructure using `flutter_localizations` + `intl` package
- Set up ARB file structure (`app_en.arb`, `app_ar.arb`, `app_ms.arb`) with CI validation for missing keys
- Implement full RTL support for Arabic: `Directionality` widget, `EdgeInsetsDirectional`, mirrored layouts
- Integrate Arabic fonts (Noto Naskh Arabic, Cairo/Tajawal) with proper fallback chains
- Build language switching mechanism (runtime locale change without app restart)
- Implement bidirectional text handling for mixed Arabic-English content (names, brands, numbers)
- Ensure all custom widgets respect `TextDirection` (swipe gestures, sliders, progress bars)
- Handle Arabic-Indic numeral option (٠١٢٣٤٥٦٧٨٩) vs Western numerals per user preference
- Test and optimize app performance with Arabic font rendering (larger glyph sets increase bundle size)

**Technical Leadership**
- Conduct code reviews for all PRs (enforce quality standards)
- Architect CI/CD pipeline (GitHub Actions + Codemagic/Fastlane for both platforms)
- Define testing strategy (unit, widget, integration, golden tests)
- Make buy-vs-build decisions for third-party packages (pub.dev evaluation)
- Manage technical debt and refactoring priorities
- Write and maintain technical documentation

**Performance & Security**
- Ensure app meets performance benchmarks (startup < 2s, smooth 60fps on both platforms)
- Implement encryption for sensitive user data (flutter_secure_storage for her profile data)
- Configure code obfuscation and tree shaking for release builds
- Monitor and optimize app size, memory usage, and battery consumption on both platforms
- Manage separate signing configurations (Android keystore + iOS certificates/provisioning)

**Collaboration**
- Translate UI designs from Figma into Flutter widget trees
- Work with AI/ML Engineer on API integration patterns
- Coordinate with Backend Developer on API contracts
- Estimate development effort for sprint planning

### Tech Stack Ownership
- **Language:** Dart (100%)
- **Framework:** Flutter 3.x with Impeller rendering engine
- **UI:** Material 3 + Cupertino adaptive widgets
- **State Management:** Riverpod or BLoC/Cubit
- **Architecture:** Clean Architecture + Repository Pattern
- **DI:** Riverpod / get_it + injectable
- **Local DB:** Hive / Isar (NoSQL) or Drift (SQL)
- **Networking:** Dio + Retrofit (dart) + Dart async/streams
- **Navigation:** GoRouter or auto_route
- **Payments:** RevenueCat (unified Android + iOS + future HarmonyOS)
- **Notifications:** flutter_local_notifications + Firebase Messaging
- **Animations:** Rive, Lottie, Flutter built-in animations
- **Localization:** flutter_localizations, intl, ARB files (EN/AR/MS), Directionality widget, EdgeInsetsDirectional
- **Arabic Fonts:** Noto Naskh Arabic (Google Fonts), Cairo, Tajawal
- **Testing:** flutter_test, mockito/mocktail, integration_test, golden tests
- **CI/CD:** GitHub Actions + Codemagic / Fastlane

---

## 5.3 UX/UI Designer

**Job Title:** Senior UX/UI Designer - Mobile
**Department:** Design
**Reports To:** Product Manager
**Employment Type:** Full-Time (Weeks 1-22), Part-Time (Weeks 23+)

### Role Summary
The UX/UI Designer creates the entire visual experience of LOLO — from first impression to daily interaction. This role requires someone who can craft a premium, masculine-yet-warm design language that men feel comfortable using. The app must feel like a "secret weapon," not a couples therapy tool.

### Key Responsibilities

**User Research & UX Strategy**
- Conduct user interviews and usability testing with target audience
- Build user personas: "The Forgetful Husband," "The New Boyfriend," "The Romantic Who Needs Help"
- Create user journey maps for all major flows
- Perform competitive UX audits (Lovewick, Between, Love Nudge, etc.)
- Design information architecture and app navigation structure

**UI Design**
- Create complete design system (colors, typography, spacing, components)
- Design all app screens in high-fidelity (estimated 50+ unique screens):
  - Onboarding & setup flow (8-10 screens)
  - Dashboard / home screen
  - Her Profile setup & edit screens
  - Reminder creation & management
  - AI Message generator interface
  - Gift recommendation browsing & filtering
  - SOS Mode interface
  - Gamification screens (streaks, levels, badges)
  - Settings & subscription management
  - Notification designs
- Design micro-interactions and animations
- Create app icon and store listing graphics

**Multi-Language & RTL Design**
- Design full RTL (Right-to-Left) variants of all screens for Arabic users
- Select and pair Arabic-optimized typography (Noto Naskh Arabic body + Cairo/Tajawal headings) with English typography
- Select Bahasa Melayu typography (Noto Sans covers Latin script)
- Design bidirectional layouts for mixed Arabic-English content (names, numbers, brands)
- Ensure icons and illustrations work in both LTR and RTL contexts (mirror where appropriate)
- Design language selector UI in onboarding and settings
- Create localized onboarding screens per language (culturally adapted, not just translated)
- Design Arabic and Malay store listing screenshots and feature graphics

**Brand Identity**
- Define visual brand identity for LOLO
- Design logo (primary + icon variants) — ensure logo works in LTR and RTL contexts
- Create marketing materials (store screenshots, feature graphics) — in EN, AR, MS
- Establish illustration and iconography style

**Prototyping & Testing**
- Build interactive prototypes in Figma for user testing
- Conduct A/B tests on critical flows (onboarding, paywall)
- Iterate designs based on data and user feedback
- Create design documentation for developer handoff

**Design Handoff**
- Prepare developer-ready designs with annotations
- Export all assets (icons, illustrations, images) in required formats
- Provide responsive specifications for different screen sizes
- Support developers during implementation with design QA

### Tools
- **Design:** Figma (primary), Adobe Creative Suite
- **Prototyping:** Figma Prototyping, Principle, or ProtoPie
- **Handoff:** Figma Dev Mode
- **User Testing:** Maze, UserTesting.com, or Lookback
- **Illustrations:** Figma, Illustrator, or Procreate

---

## 5.4 Backend Developer

**Job Title:** Backend Developer
**Department:** Engineering
**Reports To:** Tech Lead
**Employment Type:** Full-Time

### Role Summary
The Backend Developer builds and maintains the server-side infrastructure that powers LOLO. This includes user data management, notification scheduling, calendar synchronization, payment processing, third-party API integrations, and the API layer consumed by the mobile app.

### Key Responsibilities

**API Development**
- Design and implement RESTful APIs (or GraphQL) for all app features
- Create API documentation using Swagger/OpenAPI
- Implement API versioning strategy
- Build rate limiting and request validation
- Optimize API response times (target < 200ms for critical endpoints)

**Database & Data Management**
- Design and maintain database schema (PostgreSQL + Firebase Firestore)
- Implement data models for user profiles, partner profiles, reminders, messages, gifts
- **Relationship Memory Vault** — encrypted storage for stories, wish lists, sensitive topics, gift history
- **Promise Tracker** data model — log, track, remind, mark as fulfilled
- Build data migration scripts
- Implement Redis caching for frequently accessed data
- Design backup and recovery procedures
- GDPR data export and deletion endpoints

**Authentication & Security**
- Implement Firebase Authentication (email, Google, Apple Sign-In)
- Build role-based access control
- Implement data encryption at rest and in transit
- Ensure GDPR/privacy compliance for personal data
- Build secure API key management system
- Implement rate limiting and abuse prevention

**Notification System**
- Build scalable notification scheduling engine
- Integrate Firebase Cloud Messaging (FCM) for push notifications
- Implement escalating reminder logic (7-day, 3-day, 1-day, same-day)
- Build SMS notification fallback (Twilio integration)
- Handle timezone-aware scheduling across regions
- **Locale-aware notification content** — notification text served in user's language (EN/AR/MS) from server-side translation strings

**Multi-Language API Support**
- Include `Accept-Language` header handling in all API endpoints
- Return locale-specific content (event names, gift descriptions, category labels) based on user locale
- Design database schema to store translations for user-generated content labels
- Implement Hijri date support alongside Gregorian calendar for Arabic users
- Configure Twilio SMS for Arabic and Malay character encoding (UTF-8 / Unicode support)

**Third-Party Integrations**
- Google Calendar API integration (read/write sync)
- Payment processing (RevenueCat + Stripe for Android, iOS, and future HarmonyOS)
- WhatsApp Business API for message sending
- E-commerce affiliate APIs for gift recommendations
- Flower/gift delivery service APIs

**Infrastructure & DevOps**
- Set up cloud infrastructure (Firebase / Google Cloud / AWS)
- Configure CI/CD pipelines for backend deployment
- Implement logging, monitoring, and alerting (Cloud Logging, Sentry)
- Manage staging and production environments
- Implement auto-scaling for traffic spikes

### Tech Stack
- **Runtime:** Node.js (TypeScript) or Dart (Shelf/Serverpod)
- **Database:** PostgreSQL + Firebase Firestore
- **Cache:** Redis
- **Auth:** Firebase Authentication (supports Android + iOS + web)
- **Cloud:** Google Cloud Platform or AWS
- **Notifications:** Firebase Cloud Messaging (Android) + APNs (iOS) + Twilio (SMS fallback)
- **Payments:** RevenueCat (unified cross-platform subscriptions) + Stripe (web/direct)
- **Monitoring:** Sentry, Cloud Logging, Firebase Crashlytics (both platforms)

---

## 5.5 AI/ML Engineer

**Job Title:** AI/ML Engineer
**Department:** Engineering / AI
**Reports To:** Tech Lead
**Employment Type:** Full-Time

### Role Summary
The AI/ML Engineer is the brain behind what makes LOLO unique. This person designs and operates the **multi-model AI architecture** — orchestrating Claude, Grok, Gemini, and GPT across different tasks to deliver the best emotional intelligence at optimal cost. They build the AI Router that routes each request to the right model, design prompt templates per model, generate personalized messages, power Smart Action Cards, recommend gifts with feedback learning, drive the SOS mode, analyze personality profiles, and leverage the Relationship Memory Vault to make every output deeply personal. They work at the intersection of prompt engineering, multi-model orchestration, and data science.

### Key Responsibilities

**Multi-Model AI Router & Orchestration (Core Infrastructure)**
- Design and build the AI Router service that routes each request to the optimal model:
  - Classify incoming requests by task type, required emotional depth (1-5), latency requirements
  - Route emotional tasks (messages, action cards) → Claude Haiku/Sonnet
  - Route crisis/SOS tasks → Grok 4.1 Fast
  - Route data/search tasks (gifts, memory queries) → Gemini Flash
  - Route fallback (model unavailable) → GPT-5 Mini
- Implement automatic failover — if primary model is down, seamlessly route to fallback
- Build model-specific prompt adapters (each model has different prompting best practices)
- Implement unified response format — normalize outputs from 4 different models into consistent format
- Build cost tracking per model, per user, per task type
- Implement per-user monthly generation caps (Free: 50, Pro: 500, Legend: unlimited)
- Design response caching layer (Redis) — cache common patterns to reduce API calls by 30-40%
- Build batch processing pipeline — pre-generate next-day action cards overnight at 50% API discount
- Monitor model quality scores per task — if a model's output quality drops, re-route to alternative
- Manage API keys, rate limits, and billing across 4 providers (Anthropic, xAI, Google, OpenAI)

**AI Message Generation System (Module 2)**
- Design prompt engineering architecture per model (Claude, Grok, Gemini, GPT — each needs different prompt style)
- Build dynamic prompt templates that incorporate:
  - Partner personality profile (zodiac defaults + manual overrides + all profile fields)
  - Current context state (from Module 9 daily check-in: mood, conflict, sick, travel, etc.)
  - Tone preference (romantic, funny, poetic, casual) + **humor tolerance calibration**
  - Relationship Memory Vault data (inside jokes, important stories, her favorites)
  - Message history (avoid repetition)
- Build **10 situational message modes** with distinct prompt chains per mode
- Implement message quality scoring and filtering
- Build A/B testing framework for prompt variations
- Optimize API costs through prompt efficiency and caching
- Handle edge cases (inappropriate content filtering, cultural sensitivity)

**Personality Analysis Engine (Module 3)**
- Design the personality profiling algorithm combining:
  - Zodiac characteristics and compatibility scores (smart defaults)
  - **User manual overrides** (communication style, conflict style, humor tolerance, stress triggers)
  - Love Language assessment and scoring
  - Cultural background-specific patterns
  - Age-appropriate communication styles
- Build personality vector representations for recommendation matching
- Implement personality insight generation ("She values acts of service most")

**Smart Action Cards Engine (Module 9 — NEW)**
- Design the contextual action card generation system:
  - Input: current context (mood, events, conflicts, health) + her personality + calendar + memory vault
  - Output: complete action cards (what to say, do, buy, where to go, how to phrase it)
- Build context fusion logic — combine multiple signals into one recommendation:
  - "She's stressed" + "Anniversary in 3 days" + "She likes quiet places" → specific low-key plan
- Implement **daily proactive suggestion engine** (1-2 cards per day without user asking)
- Design mood-reactive card adjustment (conflict → no humor, sick → care-focused)
- Build "Random Act of Kindness" card generator for unprompted surprise ideas
- Create "Next Best Action" single-recommendation algorithm

**Gift Recommendation Engine with Learning (Module 4)**
- Design recommendation algorithm incorporating:
  - Personality profile matching (zodiac + manual inputs)
  - Budget constraints
  - Location-based availability
  - Occasion appropriateness
  - Gift history (avoid repeats)
  - **Past gift feedback ratings** ("worked" / "didn't work" with notes — AI learns over time)
  - **Her wish list items** (auto-prioritized by recency and occasion match)
  - Seasonal and trending items
- Build and maintain gift catalog data pipeline
- Integrate with e-commerce affiliate APIs for real-time pricing/availability
- Implement collaborative filtering (popular gifts for similar profiles)
- **Complete gift package generator**: gift + presentation idea + attached message + backup plan
- **"Low Budget, High Impact" mode** — special prompt chain for maximum emotional value per dollar

**SOS Mode AI System (Module 5)**
- Design the "She's Upset" assessment flow (quick diagnostic questions)
- Build situation classification model (forgot anniversary, argument, neglect, etc.)
- **Context-aware SOS**: use current Module 9 context data to tailor emergency response
- **Memory Vault integration**: check past conflict resolutions for what worked before
- Create response generation system with escalation levels
- Design real-time conversation coaching prompts
- Build damage-control action plan generator

**Relationship Memory Vault AI Integration (Module 10 — NEW)**
- Design how AI consumes vault data to personalize all outputs:
  - Messages reference real memories ("Remember when we [stored story]...")
  - Gift suggestions avoid past failures, repeat past successes
  - SOS Mode checks past conflict resolution patterns
  - Action Cards use her actual favorite places and activities
- Build the "learning loop" — the longer user uses app, the smarter AI becomes
- Implement personalization scoring (how much vault data is available per user)

**Multi-Language AI Generation (English, Arabic, Bahasa Melayu)**
- Design language-specific prompt templates — NOT translated prompts, but natively written per language:
  - **English prompts:** Standard emotional messaging with Western relationship norms
  - **Arabic prompts:** Include Islamic greeting conventions (السلام عليكم), Arabic endearment terms (حبيبتي، يا عمري، يا قلبي), awareness of Ramadan/Eid/Islamic occasions, Gulf vs. Levantine vs. Egyptian dialect options
  - **Bahasa Melayu prompts:** Include Malay endearments (sayang, cinta, kasih), Malaysian cultural norms, Hari Raya awareness, respectful register for elders, Malay humor style
- Implement `target_language` and `cultural_context` parameters in all AI prompts
- Build language-specific output validation — verify AI actually responds in requested language (not English fallback)
- Design Arabic dialect selector: Modern Standard Arabic (formal) vs. Gulf dialect (casual) vs. Egyptian dialect (humorous)
- Implement language-specific content safety filters (Arabic profanity filter, Malay cultural sensitivity)
- Build bilingual memory vault queries — user stores memories in any language, AI retrieves and references them correctly
- Test and rank each AI model's quality per language: Claude (strong Arabic), Gemini (strong Malay), Grok (variable), GPT (solid all-around)
- Optimize AI costs per language — Arabic tokens are longer (more characters per word), budget accordingly

**Optimization & Cost Management**
- Monitor and optimize AI API costs (token usage, caching strategies) — **per language breakdown**
- Implement response caching for common scenarios — **language-specific cache keys**
- Build fallback systems (if primary AI is down, serve cached/template responses)
- Track AI output quality metrics (user ratings, message send rates) — **segmented by language**
- Implement content safety filters — **language-specific filters for Arabic and Malay**
- Optimize Smart Action Card generation to stay within cost targets

**Data & Analytics**
- Define and track AI-specific KPIs:
  - Message generation success rate
  - Message send-through rate (generated vs. actually sent)
  - **Gift feedback score** (average rating of suggested gifts)
  - Gift recommendation click-through rate
  - **Smart Action Card engagement rate** (cards shown vs. acted upon)
  - **Wish list fulfillment rate**
  - SOS Mode usage and satisfaction
  - AI cost per user per month
  - **Memory Vault depth** (avg data points per user — correlate with retention)
- Build analytics dashboards for AI performance
- Conduct regular prompt optimization based on data

### Tech Stack
- **AI APIs (Multi-Model):**
  - Claude API — Anthropic (Haiku 4.5 for daily, Sonnet 4.5 for premium)
  - Grok API — xAI (4.1 Fast for SOS, crisis, humor, conversation coaching)
  - Gemini API — Google (Flash for data tasks, gift search, memory queries)
  - OpenAI API — GPT-5 Mini (fallback and general tasks)
- **AI Orchestration:** Custom AI Router service or LiteLLM / OpenRouter for unified multi-model access
- **Language:** Python (prompt engineering, data pipelines, router logic) + Dart/TypeScript (service layer)
- **Prompt Management:** LangChain or custom prompt templating with model-specific adapters
- **Vector DB:** Pinecone or Weaviate (for personality matching + memory retrieval)
- **Caching:** Redis (AI response cache — 30-40% cost reduction)
- **Analytics:** Custom dashboards + Firebase Analytics + per-model cost tracking
- **Content Safety:** Custom filters + API-provided safety layers (all models pass through unified safety check) + language-specific filters (AR/MS)
- **Multi-Language:** Language-specific prompt template libraries (EN/AR/MS), language detection validation, Arabic dialect handling
- **Batch Processing:** Cloud Functions scheduled jobs for overnight action card pre-generation (per language)

---

## 5.6 QA Engineer

**Job Title:** QA Engineer (Mobile)
**Department:** Quality Assurance
**Reports To:** Tech Lead
**Employment Type:** Full-Time (Weeks 9-22), Part-Time (Weeks 23+)

### Role Summary
The QA Engineer ensures every feature of LOLO works flawlessly before it reaches users. Given the personal and sensitive nature of the app (partner data, reminders for important dates, AI messages), quality is non-negotiable — a missed anniversary reminder or an inappropriate AI message could directly damage a user's relationship.

### Key Responsibilities

**Test Strategy & Planning**
- Create comprehensive test strategy document
- Define test plans for each sprint and feature module
- Establish quality gates for each release
- Define and maintain test environments
- Determine test automation vs. manual testing split (target: 70% automated)

**Manual Testing**
- Execute functional testing for all features:
  - Reminder scheduling accuracy (timezone testing critical)
  - AI message generation quality and appropriateness
  - Gift recommendation relevance
  - Payment flow correctness
  - Notification delivery reliability
  - Calendar sync accuracy
- Perform exploratory testing
- Execute regression testing before each release
- Test across multiple Android devices and OS versions (Android 10-15)
- Test across multiple iOS devices and versions (iOS 15-18, iPhone + iPad)
- Validate edge cases (no internet, low battery, app killed by system) on BOTH platforms
- Verify platform-specific behaviors (iOS permissions, Android notification channels)

**Test Automation**
- Build and maintain automated test suite:
  - Unit tests (flutter_test + mockito/mocktail)
  - Widget tests (Flutter widget testing framework)
  - Integration tests (integration_test package for full app flows)
  - Golden tests (pixel-perfect screenshot comparison across platforms)
  - End-to-end tests (critical user journeys on both Android + iOS)
- Set up automated test runs in CI/CD pipeline
- Maintain test coverage metrics (target: 80%+ for core logic)

**Specialized Testing**
- **Notification testing:** Verify reminders fire at correct times across timezones
- **AI output testing:** Validate messages are appropriate, non-repetitive, and personality-aligned **in all 3 languages**
- **Payment testing:** Sandbox testing for all subscription flows
- **Security testing:** Basic penetration testing, data leak verification
- **Performance testing:** App startup time, memory usage, battery drain
- **Accessibility testing:** Screen reader compatibility, font scaling
- **Multi-Language & RTL Testing (Critical):**
  - Full RTL layout verification for Arabic — all screens, all flows, all components
  - Verify `EdgeInsetsDirectional` applied correctly (no hardcoded left/right)
  - Test bidirectional text rendering (mixed Arabic-English content)
  - Validate Arabic font rendering (Noto Naskh Arabic, Cairo) on all target devices
  - Test Arabic-Indic numeral display option
  - Verify Hijri date formatting alongside Gregorian dates
  - Test language switching (runtime switch between EN/AR/MS without restart)
  - Validate all UI strings translated (no missing keys — English fallback detection)
  - AI output language verification — ensure AI responds in requested language, not English
  - Native speaker review of Arabic AI outputs (grammar, tone, cultural appropriateness)
  - Native speaker review of Bahasa Melayu AI outputs (grammar, tone, cultural appropriateness)
  - Test cultural occasion triggers (Eid, Ramadan, Hari Raya) in each locale
  - Verify store listings display correctly in Arabic and Malay

**Bug Management**
- Document bugs with clear reproduction steps, screenshots, and severity levels
- Manage bug backlog and prioritize with Tech Lead
- Verify bug fixes and perform regression testing
- Track quality metrics (bug density, escape rate, fix rate)

**Beta Testing Coordination**
- Manage beta testing program (50-100 users)
- Create beta feedback collection surveys
- Analyze and prioritize beta user feedback
- Coordinate with Product Manager on feedback-driven changes

### Tools
- **Bug Tracking:** Jira, Linear, or GitHub Issues
- **Test Management:** TestRail, Zephyr, or Notion
- **Automation:** flutter_test, integration_test, mockito, Patrol (for native UI testing)
- **API Testing:** Postman, REST Assured
- **Performance:** Flutter DevTools, Firebase Performance (both platforms)
- **CI Integration:** GitHub Actions + Codemagic
- **Device Testing:** Firebase Test Lab (Android), Xcode Simulator (iOS), BrowserStack (cross-platform)

---

## 5.7 DevOps Engineer (Part-Time / Contractor)

**Job Title:** DevOps Engineer
**Department:** Engineering
**Reports To:** Tech Lead
**Employment Type:** Part-Time Contractor

### Role Summary
The DevOps Engineer sets up and maintains the infrastructure, CI/CD pipelines, and deployment processes that allow the team to ship fast and reliably. This is a part-time role focused on initial setup (Phase 3) and launch support (Phase 5).

### Key Responsibilities

**CI/CD Pipeline**
- Set up GitHub Actions + Codemagic for automated Flutter builds (Android + iOS)
- Configure automated testing on every PR (unit, widget, integration tests)
- Set up automated APK/AAB (Android) + IPA (iOS) generation for testing and release
- Configure Fastlane for automated Google Play Store + Apple App Store deployment
- Implement branch protection rules and merge requirements
- Set up code signing for both platforms (Android keystore + iOS certificates/profiles)

**Cloud Infrastructure**
- Provision and configure Google Cloud / AWS resources
- Set up Firebase project (Auth, Firestore, FCM, Cloud Functions, Hosting)
- Configure PostgreSQL database (Cloud SQL)
- Set up Redis caching (Cloud Memorystore)
- Configure CDN for static assets
- Implement infrastructure as code (Terraform or Pulumi)

**Monitoring & Alerting**
- Set up Firebase Crashlytics for crash reporting
- Configure server monitoring and alerting (Cloud Monitoring / Datadog)
- Set up log aggregation (Cloud Logging)
- Create dashboards for system health metrics
- Configure PagerDuty / OpsGenie for critical alerts

**Security Infrastructure**
- Configure SSL/TLS certificates
- Set up API key management (Secret Manager)
- Configure firewall rules and network security
- Implement DDoS protection
- Set up automated security scanning

### Tools
- **CI/CD:** GitHub Actions + Codemagic (Flutter builds), Fastlane (store deployment)
- **Cloud:** Google Cloud Platform / AWS
- **IaC:** Terraform or Pulumi
- **Containers:** Docker (if needed for backend)
- **Monitoring:** Firebase Crashlytics (both platforms), Cloud Monitoring, Sentry
- **Security:** Cloud Secret Manager, Cloud Armor
- **Code Signing:** Android keystore management + Apple Developer certificate/profile management

---

## 5.8 Marketing Specialist

**Job Title:** Digital Marketing Specialist - Mobile App
**Department:** Marketing
**Reports To:** Product Manager / Founder
**Employment Type:** Part-Time (Weeks 17-22), Full-Time (Weeks 23+)

### Role Summary
The Marketing Specialist is responsible for building awareness, driving downloads, and growing the user base for LOLO. This role requires someone who understands the male audience, can create viral-worthy content, and knows the mobile app marketing ecosystem inside out.

### Key Responsibilities

**App Store Optimization (ASO)**
- Optimize Google Play Store + Apple App Store listings (title, description, keywords)
- Create compelling store screenshots and feature graphics
- Write A/B tested app descriptions
- Monitor and respond to app store reviews
- Track keyword rankings and optimize continuously

**Content Marketing & Social Media**
- Develop content strategy targeting men (humor-driven, relatable)
- Create and manage social media accounts (Instagram, TikTok, Twitter/X, Reddit)
- Produce short-form video content (Reels, TikToks) showcasing app features
- Write blog posts on relationship topics (SEO-driven)
- Create meme-worthy content around relationship struggles

**Paid Acquisition**
- Manage paid campaigns (Google Ads, Meta Ads, TikTok Ads)
- Define target audience segments and create custom audiences
- A/B test ad creatives and copy
- Optimize CPI (cost per install) and ROAS (return on ad spend)
- Manage advertising budget

**Influencer & Partnership Marketing**
- Identify and partner with male lifestyle influencers
- Coordinate sponsored content and reviews
- Build affiliate partnerships with gift/flower delivery services
- Negotiate partnership terms and track ROI

**Analytics & Growth**
- Track acquisition metrics (installs, CPI, conversion rate)
- Monitor retention metrics (D1, D7, D30 retention)
- Analyze funnel metrics (free > trial > paid conversion)
- Create weekly marketing performance reports
- Implement referral program ("invite a friend who needs help")

**Multi-Market Launch Strategy (EN / AR / MS)**
- Develop region-specific marketing strategies:
  - **English markets (US, UK, Australia, Canada):** Humor-driven content, social media virality, influencer partnerships
  - **Arabic markets (UAE, Saudi Arabia, Kuwait, Qatar, Bahrain, Oman, Egypt):** Ramadan/Eid-themed campaigns, respect for cultural norms, Arabic influencer outreach, Huawei AppGallery emphasis for GCC
  - **Malay markets (Malaysia, Brunei, Singapore):** Hari Raya campaigns, local influencer partnerships, Malay humor style, Grab/Shopee integration opportunities
- Create localized App Store and Play Store listings per language
- Manage region-specific social media accounts or content threads
- Adapt ad creatives and copy for cultural appropriateness per market

**Launch Campaign**
- Plan and execute pre-launch buzz campaign — **coordinated across 3 markets**
- Coordinate launch day activities
- Manage PR outreach (tech blogs, relationship media) — **include Arabic tech media and Malaysian tech outlets**
- Plan seasonal campaigns (Valentine's Day, Mother's Day, Christmas, **Eid al-Fitr, Eid al-Adha, Ramadan, Hari Raya Aidilfitri, Hari Raya Haji**)

### Tools
- **ASO:** AppFollow, Sensor Tower, or AppTweak
- **Analytics:** Firebase Analytics, Mixpanel, Adjust
- **Social Media:** Buffer, Hootsuite, or Later
- **Ad Platforms:** Google Ads, Meta Business Suite, TikTok Ads Manager
- **Email:** Mailchimp or SendGrid
- **Design:** Canva, Figma (basic), CapCut (video)

---

## 5.9 Psychiatrist / Women's Psychology Expert

**Job Title:** Women's Psychology Consultant
**Department:** Domain Expert Advisory Board
**Reports To:** Product Manager
**Employment Type:** Part-Time Consultant (8-12 hours/week)

### Role Summary
The Psychiatrist / Women's Psychology Expert is the scientific backbone of the LOLO app. This person ensures that all app content, AI responses, and feature behavior are grounded in real psychological understanding of women's emotional states across different life situations — menstrual cycles, pregnancy, postpartum, menopause, stress responses, grief, and daily emotional fluctuations. Their input directly trains the AI to respond with clinical accuracy rather than stereotypes.

### Key Responsibilities

**Psychological Framework Development**
- Design the core emotional state model that powers the AI engine:
  - Menstrual cycle phases (follicular, ovulation, luteal, menstruation) and their emotional/behavioral impact
  - Pregnancy trimesters: emotional changes, needs, sensitivities, and communication adjustments per trimester
  - Postpartum period: emotional vulnerability, support needs, warning signs for PPD
  - Menopause transition: mood changes, emotional needs, sensitivity triggers
  - General stress responses: work stress, family conflict, grief, health anxiety
- Create evidence-based emotional profiles for each life stage
- Define "emotional temperature" indicators the app can use to adjust message tone

**AI Content Validation & Training**
- Review and validate all AI-generated message templates for psychological accuracy
- Create "do's and don'ts" guidelines for each emotional state:
  - What to say when she's in her luteal phase (PMS) vs. what to absolutely avoid
  - How to communicate during pregnancy anxiety vs. pregnancy excitement
  - Appropriate vs. harmful responses when she's grieving
  - When to encourage, when to listen, when to give space
- Design the SOS Mode assessment questions (clinically informed)
- Validate SOS Mode response recommendations for psychological safety
- Flag content that could be emotionally harmful or manipulative

**Situation Mapping & Response Libraries**
- Build comprehensive situation database with recommended approaches:

  | Situation Category | Sub-Situations | Output |
  |-------------------|----------------|--------|
  | Menstrual Cycle | PMS, cramps, heavy flow, irregular | Tailored message tone + action suggestions |
  | Pregnancy | Each trimester, morning sickness, anxiety, nesting | Appropriate care messages + gift ideas |
  | Postpartum | Baby blues, sleep deprivation, body image, PPD signs | Support messages + when to seek help flags |
  | Menopause | Hot flashes, mood swings, self-image changes | Patience-focused guidance + comfort suggestions |
  | Emotional Crisis | Argument, betrayal feeling, work stress, family loss | De-escalation scripts + empathy coaching |
  | Daily Moods | Happy, tired, overwhelmed, lonely, anxious | Context-appropriate check-in messages |

- Define severity levels for each situation (1-5 scale)
- Create escalation protocols (when the app should suggest professional help vs. handle in-app)

**Content Ethics & Safety**
- Ensure all content avoids:
  - Reducing women to their biology (respectful framing)
  - Manipulative tactics disguised as "advice"
  - Medical advice (clear disclaimers — app provides emotional support, not medical diagnosis)
  - Stereotyping or generalizing female behavior
- Design content review checklist for ongoing AI output auditing
- Advise on mental health resource integration (crisis hotlines, therapy recommendations)
- Review app disclaimer and legal language around psychological content

**User Research Support**
- Advise on survey design for understanding male users' relationship pain points
- Interpret user behavior data through psychological lens
- Contribute to beta testing evaluation (is the app helping or creating dependency?)
- Consult on gamification psychology (ensure healthy engagement, not addiction)

**Ongoing Advisory**
- Weekly review sessions with AI/ML Engineer to refine prompt psychology
- Monthly content audit of AI-generated messages
- Quarterly update of psychological frameworks based on latest research
- On-call availability for edge case review during development sprints

### Deliverables
1. **Women's Emotional State Framework Document** (Week 2) — the master reference for all AI behavior
2. **Situation-Response Matrix** (Week 3) — comprehensive mapping of 50+ situations to recommended approaches
3. **AI Content Guidelines** (Week 4) — do's, don'ts, and tone rules for every emotional context
4. **SOS Mode Clinical Framework** (Week 10) — assessment logic and safe response protocols
5. **Monthly Content Audit Reports** (ongoing) — review of AI output quality and safety
6. **Pregnancy & Postpartum Module** (Week 12) — specialized content framework for expectant/new parents

---

## 5.10 Professional Astrologist

**Job Title:** Astrology & Zodiac Systems Consultant
**Department:** Domain Expert Advisory Board
**Reports To:** Product Manager
**Employment Type:** Part-Time Consultant (10 hrs/week in Phase 1 & 3, 4 hrs/week afterward)

### Role Summary
The Professional Astrologist transforms LOLO from a generic reminder app into a deeply personalized experience. This person builds the zodiac intelligence layer — defining how each sign thinks, loves, communicates, gets angry, and wants to be appreciated. Their work feeds directly into the AI message generator, gift recommendation engine, and personality profiling system, making every output feel eerily accurate to the user's partner.

### Key Responsibilities

**Zodiac Personality Engine Design**
- Create comprehensive personality profiles for all 12 zodiac signs covering:

  | Dimension | Per-Sign Detail |
  |-----------|----------------|
  | Love style | How she expresses and receives love |
  | Communication | Preferred communication style (direct, subtle, emotional, logical) |
  | Conflict behavior | How she acts when upset, what triggers her, de-escalation approach |
  | Gift preferences | What types of gifts resonate (sentimental vs. practical vs. luxury vs. experiential) |
  | Romance expectations | Grand gestures vs. small daily acts, public vs. private affection |
  | Jealousy & trust | Sensitivity levels, trust-building approaches |
  | Stress response | How she handles stress, what support she needs |
  | Celebration style | How she likes to celebrate (quiet dinner vs. surprise party vs. travel) |
  | Deal-breakers | What each sign considers unforgivable |
  | Peak emotional times | Moon phase sensitivity, seasonal patterns |

- Define compatibility dynamics between male and female sign pairings (144 combinations)
- Create "cheat sheets" for each sign: "The 5 Things a Scorpio Woman Needs to Hear"

**Zodiac-Based Message Calibration**
- Design message tone guidelines per zodiac sign:
  - Aries: direct, bold, confident compliments
  - Taurus: sensual, comfort-focused, stability-affirming
  - Gemini: witty, intellectually stimulating, playful
  - Cancer: deeply emotional, nurturing, home-centered
  - Leo: dramatic, admiring, public acknowledgment
  - Virgo: thoughtful, detail-oriented, practical appreciation
  - Libra: romantic, aesthetic, harmony-focused
  - Scorpio: intense, passionate, deeply personal
  - Sagittarius: adventurous, freedom-respecting, humor-driven
  - Capricorn: ambitious acknowledgment, respect-based, goal-supportive
  - Aquarius: unique, unconventional, intellectual connection
  - Pisces: dreamy, poetic, emotionally deep
- Create 20+ message templates per sign per occasion type (birthday, anniversary, apology, random love, etc.)
- Define "never say this to a [sign]" red flag content rules

**Gift Recommendation by Zodiac**
- Build zodiac-based gift preference matrices:
  - Budget tiers ($25, $50, $100, $250, $500+) per sign
  - Occasion types (birthday, anniversary, apology, Valentine's, "just because") per sign
  - Gift categories ranked by sign preference (jewelry, experiences, tech, books, fashion, home, wellness, food)
- Define seasonal gift recommendations (what a Cancer wants for Christmas vs. her birthday)
- Create "guaranteed hit" gift lists per sign (top 10 gifts that never fail)

**Compatibility & Relationship Dynamics**
- Design compatibility scoring algorithm inputs for all sign pairings
- Define relationship challenge predictions by pairing ("Aries man + Cancer woman: expect conflict around...")
- Create pairing-specific advice: "As a Taurus man with a Sagittarius woman, remember to..."
- Build monthly relationship forecast content framework

**Astrological Calendar Integration**
- Define zodiac-relevant dates and their significance:
  - Mercury retrograde periods (communication caution alerts)
  - Venus transits (romance peak windows)
  - Full moon emotional intensity warnings
  - Her sign's ruling planet transits
- Create astrological event notification content
- Design "cosmic timing" suggestions ("Best day this month to have a deep conversation with your Leo partner: [date]")

**AI Prompt Engineering Support**
- Work directly with AI/ML Engineer to embed zodiac logic into prompts
- Validate AI output accuracy for zodiac-specific content
- Refine prompts based on astrological nuance feedback
- Create zodiac "personality vectors" the AI can reference

### Deliverables
1. **12 Zodiac Master Profiles** (Week 2-3) — comprehensive personality documents per sign
2. **144 Compatibility Pairing Guides** (Week 3-4) — interaction dynamics for every combination
3. **Zodiac Message Tone Guide** (Week 10) — AI calibration rules per sign
4. **Gift Recommendation Matrix** (Week 11) — complete zodiac x budget x occasion mapping
5. **Astrological Calendar Events** (Week 12) — 12-month cosmic event calendar with content templates
6. **Monthly Content Refresh** (ongoing) — seasonal zodiac updates and new templates

---

## 5.11 Female Consultant / Emotional Intelligence Advisor

**Job Title:** Female Emotional Intelligence & Relationship Experience Consultant
**Department:** Domain Expert Advisory Board
**Reports To:** Product Manager
**Employment Type:** Part-Time Consultant (8-12 hours/week)

### Role Summary
The Female Consultant is the app's **reality check**. While the psychiatrist provides clinical accuracy and the astrologist provides zodiac depth, this role provides the raw, honest, lived female perspective. She answers the question every feature must pass: *"Would this actually make a real woman feel loved, or would it feel fake/creepy/tone-deaf?"* This person validates that every message, gift suggestion, and SOS response would genuinely resonate with women — not just sound good in theory.

### Key Responsibilities

**Authentic Female Perspective Validation**
- Review ALL AI-generated messages and rate them on a "Real Woman" scale:
  - Would she smile or cringe reading this?
  - Does this feel genuine or robotic?
  - Is this what she actually wants to hear, or what men think she wants to hear?
  - Would she suspect an app wrote this?
- Provide alternative phrasing that sounds more natural and human
- Identify messages that are technically correct but emotionally off
- Flag content that crosses from "sweet" to "creepy" or "trying too hard"

**Emotional Scenario Validation**
- For every situation the app handles, validate the recommended approach:

  | Scenario | What Men Think She Wants | What She Actually Wants | Gap Analysis |
  |----------|------------------------|------------------------|-------------|
  | She's upset after argument | Apologize immediately | Sometimes: space first, then acknowledge her feeling, THEN apologize | Timing matters |
  | She's stressed about work | Offer solutions | Listen first, validate, ask if she wants advice or just venting | Don't fix, empathize |
  | She says "I'm fine" | Take it at face value | Check in gently, notice body language cues | Read between lines |
  | She's on her period | Avoid the topic | Bring comfort without being asked (blanket, tea, chocolate) | Proactive care |
  | Pregnancy mood swing | Try to cheer her up | Validate that her feelings are real and okay | Don't minimize |
  | She's comparing to other couples | Reassure verbally | Show through action, not just words | Actions > words |

- Create 100+ real-world scenario cards with honest female-validated responses
- Define "the gap" between what men assume and what women actually feel (this becomes core app content)

**Gift Recommendation Reality Check**
- Review gift suggestions for each occasion and rate:
  - "She'll love this" / "She'll say she loves it but won't" / "She'll be disappointed" / "This is offensive"
- Add female-specific gift insights:
  - Size-related gifts: when it's safe vs. dangerous (never guess her size wrong)
  - Practical gifts: when appreciated (she asked for it) vs. insulting (you thought she needed a vacuum)
  - Surprise factor: what actually surprises vs. what feels forced
  - Timing: a gift on a random Tuesday can mean more than a birthday gift
- Create "Gifts That Seem Good But Aren't" red flag list

**Tone & Language Calibration**
- Define the language spectrum for each emotional context:
  - **Too cold:** "I acknowledge your frustration" (robotic)
  - **Just right:** "I can see you're having a rough day. What do you need from me?" (caring)
  - **Too much:** "My eternal queen, your divine emotions are a gift to this world" (cringe)
- Create a "Natural Language Filter" — rules to make AI messages sound like a real thoughtful man, not an AI
- Define cultural sensitivity guidelines:
  - What works in Western relationships vs. Middle Eastern vs. Asian vs. Latin cultures
  - **Arabic cultural norms:** modesty in public affection, family involvement in relationships, Islamic marriage dynamics, Ramadan emotional patterns, importance of family gatherings (العائلة)
  - **Malay cultural norms:** respect for elders, family-centric relationship decisions, Malay wedding customs, Hari Raya relationship expectations, Muslim Malay vs. non-Muslim differences
  - Religious considerations (modesty, public affection norms, halal gift considerations)
  - Generational differences (what a 25-year-old woman expects vs. 45-year-old)

**SOS Mode Female Validation**
- For every SOS scenario, provide the honest female perspective:
  - "He forgot our anniversary" — what she's actually feeling (not just anger, but: does he even care about us?)
  - "We had a big fight" — what would actually make her soften vs. what would make it worse
  - "She found out I lied" — the trust destruction hierarchy and what rebuilds it
- Rate SOS response recommendations: "This would work" / "This would backfire"
- Define the "too late" threshold — when no app can fix it and he needs real action

**Onboarding & UX Female Perspective**
- Review the onboarding flow for potential female backlash:
  - If his partner sees the app, would she be flattered or offended?
  - Is the app positioned as "help" or "manipulation"?
  - Would women recommend this app to their partners? (viral growth angle)
- Advise on app naming, tagline, and marketing from a female viewpoint
- Review promotional content for tone-deafness

**Focus Group Facilitation**
- Help recruit and moderate female focus groups (10-15 women, diverse ages/backgrounds)
- Conduct "Would You Feel Loved?" testing sessions with AI-generated content
- Gather honest feedback on app concept from women's perspective
- Translate female focus group insights into actionable product requirements

**Content Freshness & Trends**
- Advise on trending relationship dynamics and expectations
- Monitor social media (TikTok relationship content, Reddit relationship subs) for real female sentiment
- Identify new situations/scenarios to add to the app based on current culture
- Advise on seasonal emotional patterns (holiday stress, summer body image, back-to-school overwhelm)

### Deliverables
1. **"What She Actually Wants" Master Document** (Week 2-3) — honest female perspective on 100+ common situations
2. **AI Message Review Report** (Week 10-11) — rated review of all message templates with corrections
3. **Gift Red Flag List** (Week 11) — gifts that seem good but aren't, with explanations
4. **SOS Mode Reality Check** (Week 13) — female validation of all emergency response scripts
5. **Cultural Sensitivity Guide** (Week 4) — how emotional needs vary across cultures and ages
6. **Arabic Women's Perspective Guide** (Week 3-4) — relationship norms, endearment preferences, what resonates vs. offends in Arabic culture
7. **Malay Women's Perspective Guide** (Week 3-4) — Malaysian relationship norms, preferred expressions of love, cultural do's and don'ts
8. **Female Focus Group Report** (Week 18) — beta testing from the female perspective (**include Arabic and Malay women**)
9. **Monthly Authenticity Audit** (ongoing) — ongoing review that new content passes the "real woman" test

### Selection Criteria for This Role
This role is NOT about academic credentials alone. The ideal candidate:
- Is a woman aged 28-45 with diverse relationship experience
- Has professional experience in relationship counseling, coaching, or therapy
- Is brutally honest and comfortable giving critical feedback
- Understands multiple cultural contexts
- Active on social media and understands modern relationship dynamics
- Can articulate WHY something feels right or wrong emotionally (not just "I don't like it")
- Ideally: has experience in content creation or editorial roles

---

# DOMAIN EXPERT ADVISORY BOARD: HOW THEY WORK TOGETHER

```
+------------------+     +------------------+     +------------------+
|   PSYCHIATRIST   |     |   ASTROLOGIST    |     | FEMALE CONSULTANT|
|                  |     |                  |     |                  |
| "Here's what's   |     | "A Scorpio woman |     | "That message    |
|  happening in    |     |  processes anger  |     |  sounds great    |
|  her brain       |     |  by withdrawing.  |     |  on paper but    |
|  during PMS      |     |  Don't chase —   |     |  she'd roll her  |
|  from a clinical |     |  wait 24 hours   |     |  eyes. Say THIS  |
|  perspective"    |     |  then approach"  |     |  instead..."     |
+--------+---------+     +--------+---------+     +--------+---------+
         |                         |                        |
         +-------------------------+------------------------+
                                   |
                          +--------v---------+
                          |   AI/ML ENGINEER  |
                          |                  |
                          | Combines all 3   |
                          | inputs into      |
                          | prompt logic     |
                          | that generates   |
                          | perfect messages |
                          +------------------+
```

### Collaboration Model

| Activity | Frequency | Participants | Output |
|----------|-----------|-------------|--------|
| Content Strategy Session | Weekly (2 hrs) | All 3 experts + Product Manager | Content direction decisions |
| AI Prompt Review | Weekly (1 hr) | All 3 experts + AI/ML Engineer | Validated prompt templates |
| Message Quality Audit | Bi-weekly (2 hrs) | Female Consultant + AI/ML Engineer | Approved/rejected message batches |
| Zodiac Content Creation | Weekly (2 hrs) | Astrologist + AI/ML Engineer | New zodiac-specific content |
| Scenario Workshop | Bi-weekly (2 hrs) | Psychiatrist + Female Consultant | New situation-response mappings |
| Feature Validation | Per sprint | All 3 experts | Feature sign-off from domain perspective |
| Emergency Content Review | As needed | Relevant expert | Rapid review for sensitive content |

---

# 6. QUALIFICATIONS & EXPERIENCE REQUIREMENTS

## 6.1 Product Manager

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science, Business, Engineering, or related field. MBA is a plus. |
| **Min. Experience** | 3-5 years as Product Manager in mobile app development |
| **Industry Experience** | At least 1 app launched on Google Play Store or Apple App Store |
| **Domain Knowledge** | Experience with consumer/lifestyle apps (not enterprise) |
| **Technical Skills** | Understanding of mobile development lifecycle, API basics, and data analytics |
| **Tools Proficiency** | Jira/Linear, Figma (basic), Analytics platforms (Mixpanel/Amplitude/Firebase) |
| **Methodology** | Proven experience running Agile/Scrum with engineering teams |
| **Soft Skills** | Excellent communication, conflict resolution, stakeholder management |
| **Nice to Have** | Experience with AI/ML product features, subscription-based monetization, A/B testing |

### Must-Have Competencies
- Has shipped at least 1 consumer mobile app from 0 to launch
- Can write clear user stories with acceptance criteria
- Comfortable making data-driven prioritization decisions
- Experience managing a team of 5-8 people
- Understanding of mobile app monetization strategies

---

## 6.2 Tech Lead / Senior Flutter Developer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science, Software Engineering, or related field |
| **Min. Experience** | 5-7 years in mobile development, 3+ years with Flutter/Dart, 2+ years in a tech lead role |
| **Language Mastery** | Expert-level Dart. Kotlin or Swift knowledge is a strong plus for platform channels. |
| **Framework** | 3+ years with Flutter in production apps (not hobby projects) |
| **Architecture** | Proven experience with Clean Architecture + BLoC/Riverpod at scale |
| **Cross-Platform** | Has shipped at least 1 Flutter app on BOTH Google Play Store AND Apple App Store |
| **APIs** | Experience integrating REST APIs with Dio + Dart async/streams |
| **Database** | Proficient with Hive/Isar (local), Firebase Firestore (cloud) |
| **State Management** | Expert with Riverpod or BLoC/Cubit (not just setState or Provider) |
| **Testing** | Experience writing unit, widget, integration, and golden tests in Flutter |
| **CI/CD** | Experience setting up GitHub Actions or Codemagic for Flutter builds |
| **Published Apps** | At least 2 production Flutter apps on BOTH Google Play + App Store |
| **Leadership** | Experience conducting code reviews and mentoring junior developers |
| **Platform Channels** | Experience writing platform-specific code (MethodChannel) for native features |
| **Localization** | Experience implementing Flutter localization (`flutter_localizations`, `intl`, ARB files). RTL (Right-to-Left) layout experience strongly preferred. |
| **Nice to Have** | Experience with Wear OS / WatchOS Flutter plugins, HarmonyOS, Rive/Lottie animations, AI API integration, RevenueCat, **Arabic RTL implementation, bidirectional text handling** |

### Must-Have Competencies
- Has architected at least 1 Flutter app from scratch serving both Android + iOS
- Can design modular, scalable app architecture with feature-first folder structure
- Comfortable making buy-vs-build decisions (evaluating pub.dev packages)
- Strong understanding of Flutter performance optimization (Impeller, widget rebuilds, tree shaking)
- Experience with sensitive data handling and encryption (flutter_secure_storage)
- Can handle platform-specific edge cases (iOS permissions, Android notification channels, etc.)
- **Experience implementing RTL layouts for Arabic-language apps (Directionality, EdgeInsetsDirectional, mirrored navigation)**

### Technical Assessment
Candidates should demonstrate:
1. Build a small Flutter app with Clean Architecture + Riverpod/BLoC that runs on both Android + iOS — **must include locale switching (EN + AR) with RTL support** (take-home test)
2. Architecture whiteboard session (design the reminder scheduling system with cross-platform notifications)
3. Code review exercise (review a Flutter PR with intentional issues including platform-specific bugs **and RTL layout errors**)

---

## 6.3 UX/UI Designer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Design, HCI, Fine Arts, or related field. Self-taught with strong portfolio accepted. |
| **Min. Experience** | 3-5 years in mobile UX/UI design |
| **Portfolio** | Must include at least 2 shipped mobile apps (Android or iOS) |
| **Design Tools** | Expert-level Figma (non-negotiable) |
| **Design Systems** | Experience creating and maintaining design systems |
| **Prototyping** | Proficient in interactive prototyping |
| **User Research** | Experience conducting user interviews and usability testing |
| **Platform Knowledge** | Deep understanding of Material Design 3 + Apple Human Interface Guidelines (app must feel native on both platforms) |
| **RTL Design** | **Experience designing RTL (Right-to-Left) interfaces for Arabic-language apps — layout mirroring, Arabic typography, bidirectional content** |
| **Handoff** | Experience working closely with Flutter developers on cross-platform implementation |
| **Motion Design** | Ability to design micro-interactions and animations |
| **Nice to Have** | Experience with male-targeted consumer apps, illustration skills, Lottie animations, **Arabic typography pairing, multi-language design systems** |

### Must-Have Competencies
- Portfolio shows modern, clean, premium mobile designs (not web-converted-to-mobile)
- Can design end-to-end flows, not just individual screens
- Experience designing onboarding flows with high completion rates
- Understanding of accessibility standards (WCAG)
- Ability to design for emotion (the app should feel warm but not "girly")

### Design Challenge
Candidates should complete:
1. Design the LOLO onboarding flow (5-7 screens) in Figma — **in both English (LTR) and Arabic (RTL)**
2. Present design rationale and decisions — **including RTL layout decisions and Arabic typography choices**
3. Show how the design adapts to different screen sizes

---

## 6.4 Backend Developer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science or related field |
| **Min. Experience** | 3-5 years in backend development |
| **Primary Language** | Node.js (TypeScript) or Kotlin (Ktor) — production experience required |
| **Database** | Strong PostgreSQL experience + NoSQL (Firebase Firestore or MongoDB) |
| **API Design** | Experience designing and building RESTful APIs (GraphQL is a plus) |
| **Cloud** | 2+ years with Google Cloud Platform or AWS |
| **Auth** | Experience implementing Firebase Authentication or similar |
| **Caching** | Experience with Redis |
| **Notifications** | Experience with FCM (Firebase Cloud Messaging) or similar push notification services |
| **Payments** | Experience integrating Stripe or similar payment gateways |
| **Security** | Understanding of OWASP top 10, data encryption, secure API design |
| **Third-Party APIs** | Experience integrating multiple external APIs (Google Calendar, messaging APIs, etc.) |
| **Nice to Have** | Experience with WhatsApp Business API, Twilio, e-commerce APIs |

### Must-Have Competencies
- Has built and deployed at least 1 production API serving a mobile app
- Can design efficient database schemas for relational + document data
- Understanding of timezone-aware scheduling (critical for reminder system)
- Experience with webhook handling and event-driven architecture
- Familiarity with data privacy regulations (GDPR basics)

### Technical Assessment
1. Design the database schema for the reminder and notification system
2. Build a small REST API with authentication (take-home)
3. System design discussion: how to handle 100K scheduled notifications per day

---

## 6.5 AI/ML Engineer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's or Master's degree in Computer Science, AI/ML, Data Science, or related field |
| **Min. Experience** | 3-5 years in AI/ML engineering, 2+ years with LLM integration in production |
| **Multi-Model Experience** | **Hands-on experience with at least 2 of:** Claude API (Anthropic), OpenAI API, Gemini API (Google), Grok API (xAI). Must understand behavioral differences between models. |
| **Model Orchestration** | Experience building AI routing/orchestration systems that select models based on task type, cost, and quality requirements |
| **Prompt Engineering** | Proven experience designing complex prompt chains with dynamic variables. Must understand that different models require different prompting strategies. |
| **Python** | Strong Python skills for data processing, prompt engineering, and router logic |
| **NLP** | Understanding of natural language processing concepts and emotional tone analysis |
| **Recommendation Systems** | Experience building recommendation engines (collaborative or content-based filtering) |
| **API Integration** | Experience building AI service layers consumed by mobile/web apps across multiple providers |
| **Cost Optimization** | Experience managing and optimizing multi-model LLM API costs at scale (routing, caching, batching) |
| **Content Safety** | Experience implementing content moderation and safety filters across different model providers |
| **Caching** | Experience with Redis or similar for AI response caching |
| **Multi-Language AI** | Experience generating AI content in non-English languages, especially Arabic and/or Bahasa Melayu. Understanding of language-specific prompt engineering (Arabic dialects, Malay register). |
| **Nice to Have** | Experience with LiteLLM/OpenRouter (unified multi-model access), LangChain, vector databases (Pinecone/Weaviate), fine-tuning models, sentiment analysis, EQ-Bench evaluation, **Arabic NLP, Southeast Asian language support** |

### Must-Have Competencies
- Has built at least 1 production system using 2+ different LLM APIs
- Can design model-specific prompt templates (understands Claude vs. Grok vs. GPT prompting differences)
- Understands token optimization, response caching, and batch processing strategies
- Can build intelligent routing logic (classify request → select model → handle failover)
- Experience with A/B testing AI outputs across different models
- Ability to evaluate AI output quality systematically with emotional intelligence metrics
- **Experience generating AI content in Arabic and/or Bahasa Melayu — understanding that prompts must be culturally native, not translated**
- Understands cost-per-request modeling and can predict monthly AI costs at different user scales (accounting for language-specific token differences)

### Technical Assessment
1. **Multi-model task:** Given 3 relationship scenarios, design which model to use for each and write the prompt for each model — demonstrating understanding of model behavioral differences (take-home)
2. **Architecture whiteboard:** Design the AI Router — how to classify requests, route to models, handle failover, cache responses, and track costs
3. **Emotional quality evaluation:** Review 10 AI-generated messages (from different models, unlabeled) and rank them by emotional quality — demonstrating ability to evaluate EQ in AI outputs
4. **Discussion:** How to handle AI hallucinations, inappropriate outputs, and model-specific safety concerns in a relationship context

---

## 6.6 QA Engineer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science, Software Engineering, or related field |
| **Min. Experience** | 3-4 years in mobile app QA (cross-platform Flutter experience strongly preferred) |
| **Manual Testing** | Expert in writing and executing test cases for both Android AND iOS apps |
| **Automation** | Proficient with Flutter testing framework (flutter_test, integration_test, widget tests) |
| **API Testing** | Experience testing REST APIs with Postman or REST Assured |
| **CI/CD** | Experience integrating automated tests into CI/CD pipelines (GitHub Actions / Codemagic) |
| **Bug Management** | Proficient with Jira or similar bug tracking tools |
| **Device Testing** | Experience testing across multiple Android versions AND iOS versions/devices |
| **Performance** | Experience with Flutter DevTools and Firebase Performance monitoring |
| **Localization QA** | Experience testing multi-language apps, including RTL (Arabic) layout verification |
| **Nice to Have** | Experience with golden tests, Patrol, Firebase Test Lab, BrowserStack, accessibility testing, security testing basics, **Arabic RTL testing, multi-language AI output validation** |

### Must-Have Competencies
- Has QA'd at least 1 Flutter app through full release cycle on BOTH Android + iOS
- Can create comprehensive test plans from user stories
- Comfortable with both manual and automated testing
- Understands platform-specific behaviors (iOS vs. Android notification, permissions, UX patterns)
- Attention to detail (critical for notification timing, AI output quality)
- Experience with timezone-related testing
- Can identify platform-specific bugs (rendering differences, permission flows, etc.)
- **Experience testing RTL layouts and multi-language content (Arabic and/or Malay preferred)**

---

## 6.7 DevOps Engineer (Contractor)

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science or related field |
| **Min. Experience** | 3-5 years in DevOps / Cloud Infrastructure |
| **Cloud** | Strong GCP or AWS experience (certified preferred) |
| **CI/CD** | Expert with GitHub Actions + Codemagic, plus Fastlane for both Android + iOS deployment |
| **Flutter Builds** | Experience configuring Flutter CI/CD pipelines (Android APK/AAB + iOS IPA) |
| **Code Signing** | Experience managing Android keystores AND iOS certificates/provisioning profiles |
| **IaC** | Terraform or Pulumi experience |
| **Monitoring** | Experience setting up Crashlytics, Cloud Monitoring, Sentry |
| **Security** | SSL, secrets management, firewall configuration |
| **Firebase** | Experience configuring Firebase projects at scale (both Android + iOS) |
| **Nice to Have** | Docker, Kubernetes (if backend is containerized), GCP Professional certification, Apple Developer portal experience |

---

## 6.8 Marketing Specialist (unchanged — see above)

---

## 6.9 Psychiatrist / Women's Psychology Expert

| Requirement | Details |
|------------|---------|
| **Education** | MD in Psychiatry or PhD/PsyD in Clinical Psychology. Must hold a valid license. |
| **Min. Experience** | 7-10 years in clinical practice with focus on women's mental health |
| **Specialization** | Women's psychology, reproductive psychiatry, or perinatal mental health |
| **Required Expertise** | Deep clinical knowledge of hormonal impacts on mood and behavior (menstrual cycle, pregnancy, postpartum, perimenopause, menopause) |
| **Relationship Focus** | Experience in couples therapy or relationship counseling |
| **Communication** | Ability to translate clinical concepts into simple, actionable language for non-medical audiences |
| **Content Creation** | Experience writing for consumer audiences (articles, books, or digital content) |
| **Cultural Sensitivity** | Experience working with diverse populations across cultures and age groups |
| **Tech Comfort** | Comfortable collaborating with engineers and reviewing AI-generated content |
| **Nice to Have** | Published research in women's psychology, media appearances (podcast/TV), experience advising health/wellness apps or startups |

### Must-Have Competencies
- Can explain complex psychological states in plain language
- Understands the ethical boundary between "emotional support content" and "medical advice"
- Comfortable defining content safety guardrails (when the app should recommend professional help)
- Experience with mood/emotional assessment frameworks
- Strong opinions on what constitutes respectful vs. reductive portrayal of women's psychology

### Red Flags in Candidates
- Views women's emotions as purely hormonal (reductive approach)
- Cannot articulate nuance ("all women want X" generalizations)
- No practical experience with real patients (academic-only background)
- Uncomfortable with technology or AI concepts

---

## 6.10 Professional Astrologist

| Requirement | Details |
|------------|---------|
| **Education** | Certified by a recognized astrology school/organization (e.g., NCGR, AFA, ISAR, or equivalent international certification). Formal education in psychology, philosophy, or humanities is a strong plus. |
| **Min. Experience** | 5-8 years of professional astrology practice with paying clients |
| **Specialization** | Relationship/synastry astrology (compatibility readings between partners) |
| **Chart Reading** | Expert in natal chart interpretation, synastry charts, and transit analysis |
| **Zodiac Depth** | Can articulate detailed behavioral patterns for all 12 signs beyond surface-level horoscopes |
| **Content Creation** | Experience writing horoscope content, astrology blogs, or books |
| **Modern Approach** | Blends traditional astrology with modern psychological understanding (not purely mystical) |
| **Client-Facing** | Proven track record of satisfied clients (testimonials/reviews) |
| **Digital Presence** | Active online presence (blog, social media, YouTube, or podcast) demonstrating expertise |
| **Nice to Have** | Experience consulting for apps or digital products, understanding of moon phases and planetary transits for timing recommendations, Vedic astrology knowledge for broader cultural appeal |

### Must-Have Competencies
- Can create detailed, actionable personality profiles per sign (not generic horoscope fluff)
- Understands compatibility dynamics at a deep level (beyond "Scorpio and Leo don't match")
- Can provide specific, practical relationship advice per sign pairing
- Comfortable creating structured data (matrices, frameworks) from astrological knowledge
- Willing to work within an AI/tech context (translating astrology into prompt engineering inputs)

### Assessment
1. Provide a detailed personality profile for any 2 zodiac signs (demonstrating depth)
2. Describe the relationship dynamics between a specific pairing (e.g., Taurus man + Aquarius woman)
3. Create 5 personalized love message examples for a specific sign, varying by occasion

---

## 6.11 Female Consultant / Emotional Intelligence Advisor

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree minimum. Preferred: Psychology, Counseling, Communications, Social Work, Gender Studies, or related field. |
| **Min. Experience** | 5-8 years in relationship counseling, life coaching, content creation, or women's advocacy |
| **Age Range** | 28-45 preferred (broad enough to understand both younger and older women's perspectives) |
| **Relationship Experience** | Has navigated long-term relationships (can speak from lived experience, not just theory) |
| **Professional Background** | At least ONE of: licensed relationship counselor, certified life coach, published relationship content creator, women's wellness professional |
| **Communication Style** | Brutally honest, articulate, can explain emotional nuances clearly |
| **Cultural Awareness** | Has lived in or extensively worked with people from multiple cultural backgrounds. **Experience with Arabic/Middle Eastern AND/OR Malay/Southeast Asian relationship norms strongly preferred.** |
| **Digital Fluency** | Active on social media, understands modern relationship dynamics, memes, and trends |
| **Content Skills** | Can write, review, and edit emotional/relationship content |
| **Nice to Have** | Experience moderating focus groups, social media following in relationship/lifestyle space, **multilingual (Arabic and/or Bahasa Melayu is a major plus)**, experience with product testing or UX research |

### Must-Have Competencies
- Can articulate the difference between what women say and what they actually feel (emotional subtext)
- Comfortable providing critical feedback to a mostly-male team without filtering
- Understands generational differences in relationship expectations (Gen Z vs. Millennial vs. Gen X)
- Can evaluate AI-generated content for authenticity and emotional resonance
- Has empathy for the male user too (the app should help him, not shame him)
- Understands the fine line between "helpful" and "manipulative"

### Assessment
1. Review 10 AI-generated love messages and rate each: "Would work / Needs adjustment / Would backfire" — with explanations
2. Describe 3 common situations where men misread women's emotions, and what the right response actually is
3. Evaluate the LOLO app concept from a woman's perspective: would she be flattered or offended if her partner used it?

---

## 6.12 Marketing Specialist

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Marketing, Communications, or related field |
| **Min. Experience** | 3-5 years in digital marketing, 2+ years in mobile app marketing |
| **ASO** | Proven experience optimizing app store listings (keyword ranking improvements) |
| **Paid Ads** | Experience managing Google Ads + Meta Ads with measurable ROAS |
| **Social Media** | Track record growing social media accounts (especially TikTok and Instagram) |
| **Content** | Strong copywriting skills for male audience |
| **Analytics** | Proficient with Firebase Analytics, Adjust, or Appsflyer |
| **Budget** | Experience managing monthly ad budgets of $5K-$50K |
| **Nice to Have** | Influencer marketing experience, video content creation, experience with subscription app marketing |

### Must-Have Competencies
- Has marketed at least 1 consumer mobile app (not B2B)
- Understands mobile attribution and funnel analytics
- Can create content that resonates with men (humor, relatability)
- Experience with viral marketing tactics
- Understanding of App Store and Play Store ranking algorithms

---

# 7. BUDGET ESTIMATION

## 7.1 Monthly Team Cost (Estimated Ranges)

### Technical Team

| Role | Monthly Cost (USD) | Duration | Total Cost |
|------|-------------------|----------|------------|
| Product Manager | $5,000 - $8,000 | 9 months | $45,000 - $72,000 |
| Tech Lead / Sr. Flutter Dev | $7,000 - $12,000 | 8 months | $56,000 - $96,000 |
| UX/UI Designer | $4,000 - $7,000 | 5.5 months FT + 3.5 PT | $28,000 - $49,000 |
| Backend Developer | $5,000 - $8,000 | 7 months | $35,000 - $56,000 |
| AI/ML Engineer | $6,000 - $10,000 | 7 months | $42,000 - $70,000 |
| QA Engineer | $3,500 - $6,000 | 3.5 months FT + 3.5 PT | $16,000 - $30,000 |
| DevOps (Contractor) | $3,000 - $5,000 | 2 months (spread) | $6,000 - $10,000 |
| Marketing Specialist | $3,500 - $6,000 | 5 months | $17,500 - $30,000 |

**Technical Team Subtotal: $245,500 - $413,000**

### Domain Expert Advisory Board

| Role | Hourly Rate (USD) | Hours/Week | Duration | Total Cost |
|------|-------------------|------------|----------|------------|
| Psychiatrist / Women's Psychology Expert | $150 - $300/hr | 8-12 hrs | 9 months | $43,200 - $129,600 |
| Professional Astrologist | $75 - $150/hr | 10 hrs (Phase 1,3), 4 hrs (after) | 9 months | $21,600 - $54,000 |
| Female Consultant / EI Advisor | $75 - $150/hr | 8-12 hrs | 9 months | $21,600 - $64,800 |

**Domain Expert Subtotal: $86,400 - $248,400**

### Total Team Cost: $331,900 - $661,400

## 7.2 Additional Costs

| Item | Monthly Cost | 9-Month Total |
|------|-------------|---------------|
| **AI API costs (Multi-Model):** | | |
| — Claude API (Haiku + Sonnet) | $300 - $1,200 | $2,700 - $10,800 |
| — Grok API (4.1 Fast) | $50 - $300 | $450 - $2,700 |
| — Gemini API (Flash) | $20 - $100 | $180 - $900 |
| — OpenAI API (GPT-5 Mini fallback) | $50 - $200 | $450 - $1,800 |
| **AI API Subtotal** | **$420 - $1,800** | **$3,780 - $16,200** |
| Cloud infrastructure (GCP/AWS) | $200 - $1,000 | $1,800 - $9,000 |
| Third-party services (Twilio, RevenueCat, etc.) | $200 - $700 | $1,800 - $6,300 |
| Tools & licenses (Figma, Jira, Codemagic, etc.) | $300 - $600 | $2,700 - $5,400 |
| **Localization & Translation:** | | |
| — Arabic UI translation (professional translator) | One-time | $3,000 - $5,000 |
| — Bahasa Melayu UI translation (professional translator) | One-time | $2,000 - $3,500 |
| — Arabic AI prompt cultural consultant | $500 - $1,000 | $4,500 - $9,000 |
| — Malay AI prompt cultural consultant | $400 - $800 | $3,600 - $7,200 |
| — Arabic fonts license (if premium fonts used) | One-time | $0 - $500 |
| — Native speaker QA reviewers (Arabic + Malay, beta phase) | One-time | $2,000 - $4,000 |
| **Localization Subtotal** | | **$15,100 - $29,200** |
| Marketing ad budget — **3 markets (EN/AR/MS)** | $3,000 - $15,000 | $15,000 - $75,000 |
| Apple Developer Program | One-time $99/year | $99 |
| Google Play Store fee | One-time $25 | $25 |
| Huawei Developer account | One-time $0 (free) | $0 |
| HarmonyOS port contractor (Phase 3) | Fixed contract | $15,000 - $30,000 |
| **Subtotal** | | **$56,304 - $171,224** |

### Grand Total Estimated Budget: $388,204 - $832,624

### Multi-Model AI Cost Savings

| Approach | Monthly AI Cost (10K users) | Annual AI Cost |
|----------|---------------------------|----------------|
| **Single model (Claude Sonnet for everything)** | $4,500 - $15,000 | $54,000 - $180,000 |
| **Multi-model (our approach)** | $750 - $4,500 | $9,000 - $54,000 |
| **Savings** | **$3,750 - $10,500/mo** | **$45,000 - $126,000/yr** |

> The multi-model approach saves **60-70% on AI costs** while delivering **better quality per task** because each model is used for what it does best.

### Flutter Cost Savings vs. Native Android + iOS

| Item | Native (Android + iOS separate) | Flutter (single codebase) | Savings |
|------|-------------------------------|--------------------------|---------|
| iOS Developer (Phase 2) | $35,000 - $56,000 | $0 (included in Flutter) | $35,000 - $56,000 |
| Separate iOS QA testing | $8,000 - $15,000 | $0 (same QA covers both) | $8,000 - $15,000 |
| iOS CI/CD setup | $3,000 - $5,000 | Minimal extra config | $2,000 - $4,000 |
| Code maintenance (2 codebases) | Ongoing high cost | Single codebase | Ongoing savings |
| **Total Savings** | | | **$45,000 - $75,000** |

> **Note:** These are estimates for remote/international team hiring. Costs vary significantly by region. Hiring tech team in South Asia or Eastern Europe can reduce technical team costs by 40-60%. Domain experts (especially the psychiatrist) command higher rates in Western markets but may be sourced globally. US/Western Europe based teams could be 2-3x higher.

> **Cost Optimization Tip:** Domain experts can be engaged on a deliverable-based contract rather than hourly. For example, pay the Astrologist a fixed fee of $15,000-$25,000 for delivering the complete zodiac content package, then a $2,000-$4,000/month retainer for ongoing support. This can reduce domain expert costs by 30-40%.

---

# 8. RISK MATRIX

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| AI generates inappropriate messages | Medium | High | Multi-layer content filtering + human review for edge cases |
| Users perceive app as sexist/offensive | Medium | High | Careful branding, inclusive language, female beta testers |
| Low user retention after install | High | High | Gamification, streak rewards, valuable push notifications |
| AI API costs exceed budget | Low | Medium | Multi-model routing (cheapest model per task), Redis caching (30-40% savings), batch processing (50% discount), per-user caps |
| Single AI provider outage breaks app | Low | Low | Multi-model architecture with automatic failover — if Claude is down, route to Grok/GPT |
| AI model quality degrades after provider update | Medium | Medium | Automated quality scoring per model, A/B testing, can re-route to alternative model within hours |
| Prompt injection or misuse by users | Medium | High | Input sanitization, content safety filter on all 4 models, rate limiting per user |
| Competitor copies unique features | Medium | Medium | Move fast, build brand loyalty, continuous innovation |
| App Store rejection | Low | High | Follow all Play Store guidelines, privacy policy compliance |
| Key team member leaves | Medium | High | Document everything, cross-training, modular architecture |
| Calendar sync reliability issues | Medium | Medium | Extensive timezone testing, fallback to local reminders |
| Payment integration complications | Low | Medium | Use RevenueCat for unified cross-platform subscriptions |
| Flutter platform-specific bugs (Android vs. iOS) | Medium | Medium | Dedicated cross-platform QA, golden tests, platform channels |
| HarmonyOS Flutter port instability | Medium | Medium | Plan ArkUI-X native wrapper as fallback, delay until ecosystem matures |
| Apple App Store rejection | Medium | Medium | Follow Apple HIG guidelines, privacy labels, App Tracking Transparency |
| Data privacy breach | Low | Critical | Encryption, security audits, minimal data collection |
| AI content lacks emotional depth without domain experts | High | Critical | Engage Psychiatrist + Female Consultant from Week 1 |
| Zodiac content feels generic/shallow | Medium | High | Hire certified professional astrologist, not hobbyist |
| Women find the app offensive/manipulative | Medium | Critical | Female Consultant validates ALL content before release |
| Domain experts unavailable mid-project | Low | High | Document all frameworks early, create structured knowledge base |
| Psychiatrist content crosses into medical advice territory | Medium | High | Clear disclaimers, legal review, strict content boundaries |
| **Arabic AI output quality is unnatural or dialect-wrong** | Medium | High | Native Arabic speaker validates all AI outputs, offer dialect selector (MSA/Gulf/Egyptian), use Claude + GPT which have strongest Arabic |
| **Bahasa Melayu AI output sounds like Indonesian, not Malaysian** | Medium | Medium | Native Malaysian Malay speaker validates outputs, use Gemini (strong SE Asian support), explicit "Malaysian Malay" in prompts |
| **RTL layout bugs in Arabic** | High | Medium | Dedicated RTL testing phase, golden tests comparing EN vs. AR screenshots, use `EdgeInsetsDirectional` throughout, avoid hardcoded left/right |
| **Translation misses or inconsistencies** | Medium | Medium | CI validation for missing ARB keys, automated screenshot comparison across locales, native speaker review |
| **Cultural offense in Arabic/Malay markets** | Low | Critical | Domain experts review ALL content for cultural appropriateness, separate cultural guides per market, female consultant covers Arabic + Malay norms |
| **Arabic token costs higher than English** | Low | Low | Arabic text uses more tokens per word — budget 20-30% more for Arabic AI costs, offset with caching |
| **Accessibility rejection by Apple** | Medium | High | Implement VoiceOver/TalkBack from Sprint 1, WCAG AA contrast ratios, dynamic type support |
| **Offline data sync conflicts** | Medium | Medium | Conflict resolution strategy (server wins for shared data, client wins for drafts), queue offline actions |
| **Privacy law violation in target markets** | Low | Critical | Legal review before launch in each market, dedicated compliance checklist (GDPR, PDPA, PDPL) |
| **Users churn after Day 7** | High | High | Progressive onboarding, smart re-engagement notifications, "Next Best Action" keeps users coming back |

---

# 9. MONETIZATION STRATEGY

## 9.1 Subscription Tiers

| Feature | Free | Pro ($6.99/mo or $49.99/yr) | Legend ($12.99/mo or $99.99/yr) |
|---------|------|----------------------------|-------------------------------|
| Smart Reminders (dates, events) | Unlimited | Unlimited | Unlimited |
| AI Message Generator | 5 messages/month | 100 messages/month | Unlimited |
| Situational message modes | 3 modes (appreciation, good morning, celebration) | All 10 modes | All 10 modes |
| Smart Action Cards | 1 card/day (basic) | 3 cards/day (contextual) | Unlimited + premium cards |
| Her Profile Engine | Basic (zodiac + love language) | Full profile (all fields) | Full profile + multi-partner |
| Gift Recommendations | 3 suggestions/month | 20 suggestions/month | Unlimited + "Low Budget, High Impact" |
| SOS Mode | Locked | Full access | Full access + real-time coaching |
| Memory Vault | 10 entries | 100 entries | Unlimited |
| Gamification | Basic streaks | Full system + badges | Full + leaderboard + shareable |
| Wish List Capture | 5 items | 30 items | Unlimited |
| Promise Tracker | 3 active | 15 active | Unlimited |
| Community (Phase 2) | Read-only | Full access | Full + expert Q&A |
| Smartwatch (Phase 4) | Not included | Basic notifications | Full companion app |
| Ad-free experience | Ads in gift section | Ad-free | Ad-free |
| Language support | All 3 languages | All 3 languages | All 3 languages |

## 9.2 Regional Pricing

| Tier | US/UK/Europe | GCC (UAE, Saudi, etc.) | Malaysia/Brunei/Singapore |
|------|-------------|----------------------|--------------------------|
| **Pro Monthly** | $6.99 | $6.99 (AED 25.99) | $3.99 (MYR 17.99) |
| **Pro Annual** | $49.99 | $49.99 (AED 179.99) | $29.99 (MYR 129.99) |
| **Legend Monthly** | $12.99 | $12.99 (AED 47.99) | $7.99 (MYR 34.99) |
| **Legend Annual** | $99.99 | $99.99 (AED 369.99) | $59.99 (MYR 259.99) |

> **Pricing rationale:** GCC purchasing power is comparable to Western markets — keep same pricing. Malaysia/Southeast Asia pricing is 40-50% lower to match local purchasing power and competition. Language support is free across all tiers to maximize adoption.

## 9.3 Revenue Streams

| Stream | Description | Expected % of Revenue |
|--------|-------------|----------------------|
| **Subscriptions (Pro + Legend)** | Primary revenue — monthly/annual recurring | 60-70% |
| **Affiliate commissions** | Commission from gift/flower purchases via app links | 15-20% |
| **In-app purchases** | One-time purchases: premium zodiac report, detailed compatibility deep-dive | 5-10% |
| **Targeted ads (Free tier only)** | Non-intrusive ads in gift recommendation section only | 5-10% |

## 9.4 Free-to-Paid Conversion Strategy

- **7-day free trial** of Pro tier for all new users (no credit card required)
- **Soft paywall:** user hits Pro features naturally during onboarding (e.g., "Unlock all 10 message modes")
- **Event-triggered upgrade prompts:** "Your anniversary is in 5 days — unlock SOS Mode and AI-crafted gift packages"
- **Post-value upgrade:** let user experience 1 full Smart Action Card before asking to upgrade
- **"Gift for her" upgrade path:** partner's birthday approaching → "Unlock unlimited gift recommendations for $6.99/month"
- **Seasonal promotions:** 40% off annual plan during Valentine's Day, Eid, Hari Raya

---

# 10. LEGAL, COMPLIANCE & PRIVACY

## 10.1 Privacy & Data Protection by Region

| Region | Law | Key Requirements | Impact on App |
|--------|-----|-----------------|---------------|
| **EU / UK** | GDPR | Consent before data collection, right to erasure, data portability, DPO required if >5K EU users | Privacy policy, cookie consent, data export/delete endpoints, consent logs |
| **Saudi Arabia** | PDPL (Personal Data Protection Law) | Data processed in Saudi or with adequate protections, consent required, data localization preferences | May need GCC data residency option, Arabic privacy policy |
| **UAE** | Federal Data Protection Law | Consent, purpose limitation, data breach notification within 72 hours | Breach notification system, Arabic privacy policy |
| **Malaysia** | PDPA 2010 | Consent, access rights, data integrity, not applicable to data outside Malaysia processed by Malaysian entity | Malay-language privacy notice, data access request handling |
| **US** | CCPA (California), state laws | "Do Not Sell" option, disclosure of data practices | Privacy policy, opt-out mechanisms |

## 10.2 Required Legal Documents (Before Launch)

| Document | When Needed | Who Prepares |
|----------|-------------|-------------|
| **Privacy Policy** (EN/AR/MS) | Before beta launch | Legal counsel + Product Manager |
| **Terms of Service** (EN/AR/MS) | Before beta launch | Legal counsel |
| **Medical / Mental Health Disclaimer** | Before beta launch | Legal counsel + Psychiatrist |
| **App Content Moderation Policy** | Before community features (Phase 2) | Legal counsel + Product Manager |
| **Data Processing Agreements (DPAs)** | Before connecting AI providers | Legal counsel (with Anthropic, xAI, Google, OpenAI) |
| **Cookie / Tracking Consent** | Before launch | Tech Lead + Legal counsel |
| **Affiliate Disclosure** | Before gift feature launch | Legal counsel |
| **EULA (End-User License Agreement)** | Before store submission | Legal counsel |

## 10.3 Medical Disclaimer Requirements

The app must clearly state at every touchpoint involving psychological content:

> **"LOLO provides emotional support suggestions, not medical or psychological advice. If you or your partner are experiencing a mental health crisis, please contact a licensed professional or your local emergency services."**

- Disclaimer must appear in: onboarding, SOS Mode entry, settings, app store listing
- Translated into all 3 languages
- SOS Mode must include "Emergency Resources" link (localized crisis hotlines per region)
- Content must NEVER diagnose or prescribe — only suggest and support

## 10.4 Intellectual Property

| Item | Action | Status |
|------|--------|--------|
| **App name trademark** | File trademark for "LOLO" in target markets (US, GCC, Malaysia) | Before launch |
| **Domain name** | Secure primary domain + regional variants | Before marketing |
| **Social media handles** | Reserve @lolo on Instagram, TikTok, Twitter/X, YouTube | Before marketing |
| **AI-generated content ownership** | Clarify ownership of AI-generated messages in Terms of Service | Before launch |
| **Zodiac content IP** | Agreement with Astrologist on content ownership (work-for-hire) | At hiring |
| **Logo & brand assets** | Register copyright for logo and visual identity | Before launch |

## 10.5 Age Requirements

- **Minimum age: 18 years** (relationship app with mature content themes)
- Age gate during onboarding (date of birth or age confirmation)
- Comply with Apple's age rating guidelines (likely 17+ rating)
- No targeting of minors in advertising

---

# 11. MVP SUCCESS CRITERIA

## 11.1 Go / No-Go Launch Checklist

All items must be GREEN before submitting to app stores:

| # | Category | Criteria | Status |
|---|----------|----------|--------|
| 1 | **Core Features** | All 10 modules functional (at least MVP scope) | ☐ |
| 2 | **Languages** | EN/AR/MS fully localized — 0 missing strings, RTL verified | ☐ |
| 3 | **AI Quality** | Message quality > 7/10 in all 3 languages (domain expert approved) | ☐ |
| 4 | **Platforms** | Works on Android 10+ and iOS 15+ (tested on 8+ devices) | ☐ |
| 5 | **Performance** | Startup < 2s, 60fps, < 50MB APK | ☐ |
| 6 | **Security** | AES-256 encryption, 0 critical vulnerabilities, biometric lock works | ☐ |
| 7 | **Payments** | RevenueCat subscriptions work on both platforms, all tiers functional | ☐ |
| 8 | **Privacy** | Privacy policy live (EN/AR/MS), GDPR endpoints work, medical disclaimers in place | ☐ |
| 9 | **Beta Testing** | 50+ beta users tested, all P1 bugs resolved, NPS > 30 | ☐ |
| 10 | **Content** | All domain expert deliverables received and integrated | ☐ |
| 11 | **Store Listings** | ASO-optimized listings in EN/AR/MS with screenshots and descriptions | ☐ |
| 12 | **Monitoring** | Crashlytics, analytics, and alerting active | ☐ |
| 13 | **Accessibility** | VoiceOver/TalkBack basic support, WCAG AA contrast, dynamic type | ☐ |
| 14 | **Legal** | Terms of Service, Privacy Policy, Medical Disclaimer, EULA — all live | ☐ |

## 11.2 MVP Success Metrics (First 90 Days Post-Launch)

| Metric | 30-Day Target | 60-Day Target | 90-Day Target |
|--------|:------------:|:------------:|:------------:|
| **Total installs** | 2,000+ | 5,000+ | 10,000+ |
| **DAU / MAU ratio** | > 15% | > 20% | > 25% |
| **D1 retention** | > 35% | > 40% | > 45% |
| **D7 retention** | > 15% | > 18% | > 20% |
| **D30 retention** | — | > 8% | > 10% |
| **Free → Paid conversion** | > 2% | > 4% | > 5% |
| **App Store rating** | > 4.0 | > 4.2 | > 4.3 |
| **Crash-free rate** | > 99% | > 99.5% | > 99.5% |
| **AI message send-through rate** | > 40% | > 50% | > 60% |
| **NPS score** | > 20 | > 30 | > 40 |
| **Arabic user % of total** | > 15% | > 20% | > 20% |
| **Malay user % of total** | > 10% | > 15% | > 15% |

## 11.3 Accessibility Strategy

| Requirement | Implementation | Priority |
|-------------|---------------|----------|
| **Screen reader support** | VoiceOver (iOS) + TalkBack (Android) — all interactive elements labeled with `Semantics` widget | P1 (MVP) |
| **Dynamic type / font scaling** | Respect system font size settings, UI doesn't break at 200% font scale | P1 (MVP) |
| **Color contrast** | WCAG AA minimum (4.5:1 for text, 3:1 for large text) — verify in both LTR and RTL | P1 (MVP) |
| **Touch targets** | Minimum 48x48dp for all interactive elements | P1 (MVP) |
| **Motion sensitivity** | Respect "Reduce Motion" system setting for animations | P2 (v1.1) |
| **Color-blind friendly** | Don't rely on color alone for status (add icons/text to streaks, levels) | P2 (v1.1) |

## 11.4 Offline Mode Strategy

| Feature | Offline Behavior | Sync Strategy |
|---------|-----------------|---------------|
| **Reminders** | Fire locally (flutter_local_notifications) — no internet needed | Sync new/edited reminders when online |
| **Her Profile** | Fully accessible offline (cached locally via Hive/Isar) | Sync changes on reconnect |
| **AI Messages** | Show cached/previously generated messages. New generation requires internet. Show "You're offline — here's a saved message" | Queue generation request, execute on reconnect |
| **Gift Recommendations** | Not available offline (requires live API) | Show "Connect to internet for gift suggestions" |
| **Smart Action Cards** | Show pre-generated cards (batch processing generates next-day cards) | Refresh cards when online |
| **SOS Mode** | Show cached emergency tips + stored past resolutions from vault | Full AI mode requires internet |
| **Memory Vault** | Fully accessible offline (encrypted local storage) | Sync new entries on reconnect |
| **Gamification** | Streak count + points tracked locally | Sync with server on reconnect |
| **Notifications** | Local notifications always work | Push notifications require connectivity |

> **Conflict resolution:** Server wins for shared data (subscription status, profile). Client wins for drafts (unsent messages, vault entries). Last-write-wins with timestamps for reminders.

## 11.5 User Retention & Re-engagement Plan

**Progressive Onboarding (Don't overwhelm Day 1):**
1. **Day 1:** Set up profile + her profile (basic: name, birthday, zodiac). Get first AI message immediately. Show 1 Smart Action Card.
2. **Day 2:** Push notification: "How was your first message? Add more about her to get better results" → deepens Her Profile
3. **Day 3:** Push: "Your first Smart Action Card for today" → builds habit
4. **Day 5:** Push: "You've been thoughtful for 5 days! Keep your streak going" → gamification hook
5. **Day 7:** Push: "Unlock all 10 message modes — try Pro free for 7 days" → soft upsell

**Re-engagement Triggers:**

| Trigger | When | Notification | Goal |
|---------|------|-------------|------|
| **Streak about to break** | User missed 1 day | "Don't lose your 12-day streak! Quick — send her a goodnight message" | Prevent churn |
| **Important date approaching** | 7 days before event | "Her birthday is in 7 days. Start planning now — we have ideas" | Show value |
| **User inactive 3 days** | After 3 days silence | "She mentioned wanting [wish list item]. Want us to find it for you?" | Re-engage with personal data |
| **User inactive 7 days** | After 7 days silence | "A lot can change in a week. Quick check-in: how's she doing?" (leads to context update) | Re-engage with value |
| **User inactive 14 days** | After 14 days silence | "Your partner probably noticed you've been extra thoughtful lately. Don't stop now." | Emotional nudge |
| **Seasonal hook** | Before Valentine's / Eid / Hari Raya | "[Event] is coming. Men who use LOLO report 3x more appreciation from their partners" | Seasonal re-engagement |
| **After conflict context logged** | After user logs "conflict happened" | Next day: "Day after an argument is crucial. Here's what to do today." | High-value moment |

**Notification Frequency Rules:**
- Maximum 1 push notification per day (avoid spamming)
- User can customize frequency in settings (daily / 3x week / weekly / critical only)
- Smart timing: send notifications at user's local time, not UTC
- No notifications between 10 PM - 7 AM (user's timezone)
- Arabic users: pause casual notifications during prayer times if user opts in

---

# APPENDIX A: HIRING PRIORITY ORDER

If budget is constrained, hire in this order:

1. **Product Manager** (Week 1) — Cannot start without direction
2. **UX/UI Designer** (Week 1) — Design runs parallel to planning
3. **Female Consultant** (Week 1) — Validates concept from day one, prevents building the wrong thing
4. **Psychiatrist** (Week 1) — Shapes the psychological framework before any content is created
5. **Astrologist** (Week 1) — Zodiac engine design needed before development starts
6. **Tech Lead / Sr. Flutter Dev** (Week 5) — Needs designs to build from
7. **Backend Developer** (Week 9) — Backend work starts with dev sprints
8. **AI/ML Engineer** (Week 9) — AI features are the core differentiator
9. **QA Engineer** (Week 9) — Testing starts immediately with development
10. **DevOps** (Week 9) — Contract for initial setup, then on-call
11. **Marketing** (Week 17) — Ramp up before launch

> **Why domain experts rank higher than developers:** If you build the app without their input and retrofit their knowledge later, you'll rewrite 40-60% of the AI content. Their early involvement prevents costly rework.

---

# APPENDIX B: ALTERNATIVE LEAN APPROACH (3-Person MVP)

If budget is very limited, a bare-minimum MVP team could be:

| Role | Covers |
|------|--------|
| **You (Founder)** | Product Manager + Business decisions |
| **Full-Stack Flutter Developer** | Tech Lead + Backend (Firebase) + basic DevOps |
| **AI/ML Engineer** | AI features + prompt engineering |
| **Female Consultant** (contract) | Reality check + content validation |
| **Astrologist** (contract) | Zodiac content package (fixed deliverable) |

In this model:
- Use a freelance designer for UI (fixed contract — must have RTL experience)
- Skip dedicated QA (developers test + beta users — recruit Arabic + Malay beta testers)
- Use Firebase for most backend (reduce backend work)
- Marketing done by founder + social media
- Psychiatrist input: consult 2-3 sessions to build initial framework, then use published research
- Female Consultant: fixed contract for content review milestones (must cover Arabic + Malay cultural review)
- Astrologist: fixed deliverable contract for zodiac content package
- **Localization:** Hire freelance Arabic and Malay translators for UI strings (one-time $4K-$7K)
- **Estimated cost: $120,000 - $215,000**
- **Timeline: 7-9 months to MVP**

> **Even in the leanest approach, never skip the Female Consultant.** She is the cheapest hire and the highest ROI — one tone-deaf message going viral on social media can kill the app.

---

# APPENDIX C: TEAM KPI CHECKLISTS & ACCOUNTABILITY TRACKER

> **How to use this appendix:** Each team member has a phase-by-phase checklist with measurable KPIs. The Product Manager (or Founder) should review these weekly during standups. Items marked with a target metric (e.g., "> 80%") are quantitative KPIs — track them on a dashboard. Items without metrics are binary deliverables (done / not done).

---

## C.1 Product Manager — KPI Checklist

### Phase 1: Discovery & Planning (Weeks 1-4)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | Competitive analysis report completed | Report delivered by Week 1 | ☐ |
| 2 | User personas created (minimum 3) | 3 personas with journey maps | ☐ |
| 3 | Feature backlog created and prioritized (MoSCoW) | 100% of MVP features prioritized | ☐ |
| 4 | All domain experts onboarded and briefed | 3/3 experts active by Week 1 | ☐ |
| 5 | Sprint plan finalized for Phases 2-5 | Sprint plan approved by founder | ☐ |
| 6 | Architecture document reviewed and approved | Sign-off by end of Week 4 | ☐ |
| 7 | Multi-language strategy approved | EN/AR/MS localization plan signed off | ☐ |
| 8 | Wireframes reviewed and approved | All 30+ screens approved | ☐ |

### Phase 2: UI/UX Design (Weeks 5-8)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 9 | High-fidelity designs reviewed and approved | All screens (LTR + RTL) signed off | ☐ |
| 10 | User testing completed | 10-15 male users tested | ☐ |
| 11 | User testing satisfaction score | > 7/10 average rating | ☐ |
| 12 | API contract document reviewed | All endpoints documented | ☐ |
| 13 | Arabic + Malay UI translations reviewed | Native speakers approved translations | ☐ |
| 14 | Design handoff meeting completed | Dev team confirms readiness | ☐ |

### Phase 3: MVP Development (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 15 | Sprint velocity tracked | Story points completed per sprint | ☐ |
| 16 | Sprint goals met | > 85% of sprint goals delivered on time | ☐ |
| 17 | Backlog groomed weekly | 0 undefined stories entering sprint | ☐ |
| 18 | Blockers resolved within | < 24 hours average resolution time | ☐ |
| 19 | Stakeholder updates sent | Weekly report to founder — every Friday | ☐ |
| 20 | Feature acceptance testing done | PM signs off every completed feature | ☐ |

### Phase 4-5: Testing & Launch (Weeks 17-22)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 21 | Beta testing program launched | 50-100 beta users recruited (include AR/MS users) | ☐ |
| 22 | Beta feedback analyzed and prioritized | Report delivered within 5 days of beta close | ☐ |
| 23 | Store listings optimized (ASO) | EN/AR/MS listings published | ☐ |
| 24 | Launch day checklist completed | All items green before submission | ☐ |
| 25 | Post-launch crash rate | < 1% crash-free rate target | ☐ |

### Ongoing KPIs (Post-Launch)

| KPI | Target | Frequency |
|-----|--------|-----------|
| DAU / MAU ratio | > 25% | Weekly |
| D1 retention | > 40% | Weekly |
| D7 retention | > 20% | Weekly |
| D30 retention | > 10% | Monthly |
| Free → Paid conversion | > 5% | Monthly |
| App Store rating | > 4.3 stars (all markets) | Weekly |
| NPS score | > 40 | Monthly |
| Feature adoption rate | > 60% of users use 3+ modules | Monthly |

---

## C.2 Tech Lead / Senior Flutter Developer — KPI Checklist

### Phase 2: Pre-Development (Weeks 5-8)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | Architecture document finalized | Clean Architecture + BLoC/Riverpod documented | ☐ |
| 2 | Tech stack decided and documented | All packages selected from pub.dev | ☐ |
| 3 | Folder structure and coding standards defined | Standards doc shared with team | ☐ |
| 4 | Localization architecture designed | ARB file structure, RTL plan, font strategy documented | ☐ |
| 5 | CI/CD pipeline architecture planned | GitHub Actions + Codemagic plan ready | ☐ |

### Phase 3: MVP Development (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 6 | Flutter project scaffold completed | Project builds on Android + iOS by Week 9 end | ☐ |
| 7 | Localization infrastructure working | EN/AR/MS switching works, RTL renders correctly | ☐ |
| 8 | Arabic font rendering verified | Noto Naskh Arabic + Cairo display correctly on 5+ devices | ☐ |
| 9 | Code review turnaround time | < 4 hours per PR during business hours | ☐ |
| 10 | PR merge success rate | > 90% PRs pass CI on first or second attempt | ☐ |
| 11 | Test coverage (core logic) | > 80% unit + widget test coverage | ☐ |
| 12 | App startup time | < 2 seconds (cold start) on both platforms | ☐ |
| 13 | Frame rate | 60fps consistent (verified via Flutter DevTools) | ☐ |
| 14 | All 10 modules functional | 10/10 modules demo-ready by Week 16 | ☐ |
| 15 | RTL layout pass rate | 100% of screens render correctly in Arabic | ☐ |
| 16 | Platform parity | Zero platform-only bugs (Android feature works same on iOS) | ☐ |
| 17 | Technical debt log maintained | Debt items logged with priority and estimated effort | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| App crash rate | < 0.5% (Crashlytics) | Daily |
| App size (APK / IPA) | < 50MB (Android), < 80MB (iOS) | Per release |
| Build success rate | > 95% CI builds pass | Weekly |
| Code review coverage | 100% of PRs reviewed before merge | Per PR |
| Dependency updates | Monthly pub.dev audit for breaking changes | Monthly |

---

## C.3 UX/UI Designer — KPI Checklist

### Phase 1: Discovery (Weeks 1-4)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | User personas created | 3 detailed personas with journey maps | ☐ |
| 2 | Competitive UX audit completed | 5+ competitor apps analyzed | ☐ |
| 3 | Wireframes delivered (low-fidelity) | 30+ screens wireframed | ☐ |
| 4 | Design system foundations defined | Color palette, typography (EN + AR + MS), spacing, grid | ☐ |

### Phase 2: UI/UX Design (Weeks 5-8)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 5 | High-fidelity screens completed (English/LTR) | 50+ screens designed in Figma | ☐ |
| 6 | Arabic RTL screen variants completed | 50+ mirrored RTL screens in Figma | ☐ |
| 7 | Brand identity finalized | Logo + icon + color system + Arabic/Malay fonts | ☐ |
| 8 | Interactive prototype built | Clickable EN + AR prototypes | ☐ |
| 9 | User testing completed | 10-15 users tested | ☐ |
| 10 | User testing task completion rate | > 85% of testers complete core flows | ☐ |
| 11 | User testing satisfaction | > 7/10 average score | ☐ |
| 12 | Design iterations completed | All feedback-driven revisions done | ☐ |
| 13 | Developer handoff package ready | Annotated designs + RTL guidelines + exported assets | ☐ |
| 14 | Store listing graphics designed | EN/AR/MS screenshots and feature graphics | ☐ |

### Phase 3-4: Development Support (Weeks 9-19)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 15 | Design QA conducted per sprint | Every implemented screen reviewed vs. Figma | ☐ |
| 16 | Design QA pixel accuracy | > 95% match between Figma and implementation | ☐ |
| 17 | RTL design QA | All Arabic screens match RTL Figma designs | ☐ |
| 18 | Design change requests responded to | < 24-hour turnaround | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Onboarding completion rate | > 75% of new users complete setup | Weekly |
| User satisfaction (UI) | > 4/5 in-app feedback score | Monthly |
| A/B test win rate | > 50% of design variants win | Per test |

---

## C.4 Backend Developer — KPI Checklist

### Phase 3: MVP Development (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | Firebase setup completed | Auth + Firestore + FCM working on Android + iOS | ☐ |
| 2 | Database schema designed and reviewed | Schema approved by Tech Lead | ☐ |
| 3 | Locale fields in database | User locale, her preferred language stored correctly | ☐ |
| 4 | API response time | < 200ms for critical endpoints (p95) | ☐ |
| 5 | API documentation complete | Swagger/OpenAPI docs for all endpoints | ☐ |
| 6 | Authentication working | Email + Google + Apple Sign-In functional | ☐ |
| 7 | Notification system reliability | > 99% notification delivery rate | ☐ |
| 8 | Locale-aware notifications | Notifications sent in user's language (EN/AR/MS) | ☐ |
| 9 | Calendar sync working | Google Calendar + Apple Calendar read/write | ☐ |
| 10 | Hijri date support | Arabic users see Hijri dates alongside Gregorian | ☐ |
| 11 | Payment integration | RevenueCat subscriptions working on Android + iOS | ☐ |
| 12 | Redis caching implemented | AI response cache operational | ☐ |
| 13 | Memory Vault encryption | AES-256 encryption verified, biometric lock working | ☐ |
| 14 | GDPR endpoints | Data export and deletion APIs functional | ☐ |
| 15 | Accept-Language header handling | All content endpoints respect locale parameter | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| API uptime | > 99.5% | Daily |
| API error rate | < 1% of requests | Daily |
| Average response time | < 200ms (p95) | Daily |
| Database query performance | < 50ms average query time | Weekly |
| Notification delivery rate | > 99% | Daily |
| Cache hit ratio (Redis) | > 60% | Weekly |
| Data backup success | 100% daily backups verified | Daily |
| Security vulnerability scan | 0 critical/high vulnerabilities | Monthly |

---

## C.5 AI/ML Engineer — KPI Checklist

### Phase 3: MVP Development (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | AI Router / Orchestrator built and functional | Routes to correct model per task type | ☐ |
| 2 | All 4 AI providers integrated | Claude + Grok + Gemini + GPT APIs connected | ☐ |
| 3 | Automatic failover working | Model switch happens < 2 seconds on provider outage | ☐ |
| 4 | 10 situational message modes built | All modes generate quality output | ☐ |
| 5 | English prompt quality | > 8/10 average quality rating (internal review) | ☐ |
| 6 | Arabic prompt library built | Separate Arabic prompts (not translated) with cultural context | ☐ |
| 7 | Arabic output quality | > 7/10 average quality rating (native Arabic speaker review) | ☐ |
| 8 | Bahasa Melayu prompt library built | Separate Malay prompts with cultural context | ☐ |
| 9 | Malay output quality | > 7/10 average quality rating (native Malay speaker review) | ☐ |
| 10 | Language verification pass rate | > 98% of outputs in correct requested language | ☐ |
| 11 | Smart Action Cards generating daily | 1-2 contextual cards per user per day | ☐ |
| 12 | Gift recommendation relevance | > 70% positive feedback from test users | ☐ |
| 13 | SOS Mode response quality | > 8/10 quality rating (reviewed by Psychiatrist) | ☐ |
| 14 | Context Awareness Engine functional | Mood/status input correctly adjusts all AI outputs | ☐ |
| 15 | Batch processing pipeline operational | Next-day action cards pre-generated overnight | ☐ |
| 16 | Response cache (Redis) operational | Language-specific caching working | ☐ |
| 17 | Content safety filter active | 0 inappropriate messages pass through | ☐ |
| 18 | Per-model cost tracking dashboard | Real-time cost tracking per model, per language | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Message generation success rate | > 99% | Daily |
| Message send-through rate | > 60% of generated messages actually sent by user | Weekly |
| AI cost per user per month | < $0.50 (free tier), < $2.00 (pro tier) | Weekly |
| Cache hit ratio (AI responses) | > 30% | Weekly |
| Model routing accuracy | > 95% requests go to optimal model | Weekly |
| Content safety filter catch rate | 100% of harmful content blocked | Daily |
| Arabic output quality score | > 7/10 (monthly native speaker review) | Monthly |
| Malay output quality score | > 7/10 (monthly native speaker review) | Monthly |
| Smart Action Card engagement rate | > 40% of cards acted upon | Weekly |
| Gift recommendation click-through | > 30% | Weekly |
| SOS Mode satisfaction score | > 8/10 (user post-session rating) | Weekly |
| Memory Vault personalization depth | Avg data points per user increasing month-over-month | Monthly |
| Average AI response latency | < 3 seconds (p95) | Daily |
| Monthly AI API cost (total) | Within budget ($420-$1,800/month dev, scaled post-launch) | Monthly |

---

## C.6 QA Engineer — KPI Checklist

### Phase 3: Development (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | Test strategy document created | Approved by Tech Lead | ☐ |
| 2 | Test plans created per sprint | Plans ready before sprint starts | ☐ |
| 3 | Unit test coverage | > 80% of core business logic | ☐ |
| 4 | Widget test coverage | Key UI components covered | ☐ |
| 5 | Integration tests written | All critical user journeys automated | ☐ |
| 6 | RTL layout tests created | Golden tests for all screens in Arabic | ☐ |
| 7 | Locale switching tests | Verify EN ↔ AR ↔ MS switch works without restart | ☐ |
| 8 | Cross-platform testing | Tested on 5+ Android devices + 3+ iOS devices | ☐ |
| 9 | Notification timing accuracy | Reminders fire within ±1 minute of scheduled time | ☐ |
| 10 | AI output validation (English) | 100+ generated messages reviewed for quality | ☐ |
| 11 | AI output validation (Arabic) | 50+ Arabic messages reviewed by native speaker | ☐ |
| 12 | AI output validation (Malay) | 50+ Malay messages reviewed by native speaker | ☐ |

### Phase 4: Testing & QA (Weeks 17-19)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 13 | Full regression test completed | All features pass on Android + iOS | ☐ |
| 14 | RTL visual audit completed | All Arabic screens match design, no layout breaks | ☐ |
| 15 | Security testing completed | 0 critical/high vulnerabilities | ☐ |
| 16 | Performance benchmarks met | Startup < 2s, 60fps, memory < 200MB | ☐ |
| 17 | Beta build distributed | TestFlight (iOS) + APK (Android) to 50-100 users | ☐ |
| 18 | Beta bug report turnaround | All critical bugs reported within 24 hours | ☐ |
| 19 | Multi-language QA pass | Native Arabic + Malay speakers approve full app flow | ☐ |
| 20 | Release candidate approved | All quality gates passed, 0 P1 bugs open | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Bug escape rate (production) | < 2 P1/P2 bugs per release | Per release |
| Bug fix verification turnaround | < 24 hours after fix deployed | Per bug |
| Automated test pass rate | > 95% in CI | Per PR |
| Test coverage (core logic) | > 80% maintained | Weekly |
| Crash-free rate | > 99.5% (both platforms) | Daily |
| Translation completeness | 100% ARB keys translated (0 English fallbacks in AR/MS) | Per release |

---

## C.7 DevOps Engineer — KPI Checklist

### Phase 3: Setup (Weeks 9-12)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | CI/CD pipeline operational | GitHub Actions builds both Android + iOS automatically | ☐ |
| 2 | Automated testing in CI | Unit + widget tests run on every PR | ☐ |
| 3 | Firebase project configured | Auth, Firestore, FCM, Crashlytics — both platforms | ☐ |
| 4 | PostgreSQL + Redis provisioned | Cloud SQL + Memorystore running | ☐ |
| 5 | Code signing configured | Android keystore + iOS certificates managed securely | ☐ |
| 6 | Monitoring & alerting setup | Crashlytics + Cloud Monitoring + Sentry active | ☐ |
| 7 | Infrastructure as code | Terraform/Pulumi for all cloud resources | ☐ |
| 8 | Staging environment ready | Separate staging environment for testing | ☐ |

### Phase 5: Launch (Weeks 20-22)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 9 | Store deployment automated | Fastlane deploys to Play Store + App Store | ☐ |
| 10 | Production environment hardened | SSL, firewall, DDoS protection, secrets secured | ☐ |
| 11 | Auto-scaling configured | Handles 10x traffic spike without downtime | ☐ |
| 12 | Backup and recovery tested | Data recovery verified within 1 hour RTO | ☐ |
| 13 | Runbook documented | Incident response procedures for all critical services | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Infrastructure uptime | > 99.9% | Daily |
| CI/CD build time | < 15 minutes (full build + test) | Per build |
| Deployment frequency | Ability to deploy same-day hotfixes | As needed |
| Mean time to recovery (MTTR) | < 30 minutes for P1 incidents | Per incident |
| Security scan results | 0 critical vulnerabilities | Monthly |
| Cloud cost efficiency | Within budget ± 10% | Monthly |

---

## C.8 Marketing Specialist — KPI Checklist

### Phase 4: Pre-Launch (Weeks 17-19)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | Marketing strategy document delivered | EN/AR/MS market plans approved | ☐ |
| 2 | Social media accounts created | Instagram, TikTok, Twitter/X — per market | ☐ |
| 3 | Pre-launch content calendar created | 4-week launch calendar with 3+ posts/week | ☐ |
| 4 | Influencer outreach initiated | 10+ influencers contacted per market | ☐ |
| 5 | Store listings optimized (ASO) | Title, description, keywords, screenshots — EN/AR/MS | ☐ |
| 6 | Pre-launch email list | > 500 signups before launch | ☐ |

### Phase 5: Launch (Weeks 20-22)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 7 | Launch campaign executed | Coordinated launch across 3 markets | ☐ |
| 8 | First-week installs | > 1,000 installs across all markets | ☐ |
| 9 | PR coverage secured | 3+ tech/lifestyle media mentions | ☐ |
| 10 | App Store reviews managed | All 1-2 star reviews responded to within 24 hours | ☐ |
| 11 | Paid ad campaigns launched | Google Ads + Meta Ads running in EN/AR/MS | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Cost per install (CPI) | < $2.00 (EN), < $1.50 (AR), < $1.00 (MS) | Weekly |
| Organic vs. paid install ratio | > 40% organic | Monthly |
| Social media follower growth | 10%+ month-over-month | Monthly |
| Content engagement rate | > 3% average | Weekly |
| Free → Paid conversion (attributed) | > 5% | Monthly |
| ROAS (Return on Ad Spend) | > 2.0x | Monthly |
| App Store keyword ranking | Top 10 for 5+ target keywords per market | Monthly |
| Influencer campaign ROI | > 1.5x per partnership | Per campaign |
| Seasonal campaign uplift | > 30% increase during Eid/Valentine's/Hari Raya | Per campaign |

---

## C.9 Psychiatrist / Women's Psychology Expert — KPI Checklist

### Phase 1: Framework Development (Weeks 1-4)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | Women's Emotional State Framework delivered | Document approved by PM by Week 2 | ☐ |
| 2 | Situation-Response Matrix created | 50+ situations mapped with approaches | ☐ |
| 3 | AI Content Guidelines delivered | Do's/don'ts per emotional state — Week 4 | ☐ |
| 4 | Smart Action Card scenarios reviewed | 50+ card templates clinically validated | ☐ |
| 5 | Cultural sensitivity input provided | Emotional patterns across Arabic + Malay cultures included | ☐ |

### Phase 3: Development Support (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 6 | SOS Mode clinical framework delivered | Assessment logic + safe response protocols — Week 10 | ☐ |
| 7 | AI-generated messages reviewed | 100+ messages validated for psychological accuracy | ☐ |
| 8 | Arabic AI messages reviewed | Arabic emotional content validated for cultural appropriateness | ☐ |
| 9 | Pregnancy & postpartum module delivered | Trimester-specific content framework — Week 12 | ☐ |
| 10 | Weekly sessions with AI/ML Engineer | Attended every week (no skips without rescheduling) | ☐ |
| 11 | Content flagged as harmful | 0 harmful messages pass review | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Monthly content audit completed | 100% — every month without fail | Monthly |
| AI message clinical accuracy | > 90% of reviewed messages pass validation | Monthly |
| SOS Mode safety compliance | 0 responses that could cause harm | Monthly |
| Framework update frequency | Quarterly review against latest research | Quarterly |
| Response turnaround for edge cases | < 48 hours for urgent content review requests | As needed |
| Professional help escalation accuracy | 100% of severe cases trigger "seek professional help" message | Ongoing |

---

## C.10 Professional Astrologist — KPI Checklist

### Phase 1: Content Creation (Weeks 1-4)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | 12 Zodiac Master Profiles delivered | All 12 signs — comprehensive and deep | ☐ |
| 2 | 144 Compatibility Pairing Guides delivered | All sign x sign combinations covered | ☐ |
| 3 | Per-sign "cheat sheets" created | "5 Things a [Sign] Woman Needs to Hear" x 12 | ☐ |
| 4 | Content depth validation | Each profile covers all 10 dimensions (love style, conflict, gifts, etc.) | ☐ |

### Phase 3: AI Integration (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 5 | Zodiac Message Tone Guide delivered | Per-sign AI calibration rules — Week 10 | ☐ |
| 6 | Gift Recommendation Matrix delivered | Zodiac x budget x occasion mapping — Week 11 | ☐ |
| 7 | Astrological Calendar Events delivered | 12-month cosmic event calendar — Week 12 | ☐ |
| 8 | 20+ message templates per sign per occasion | Total: 240+ templates minimum | ☐ |
| 9 | "Never say this" red flag rules created | Per-sign content restrictions defined | ☐ |
| 10 | AI output zodiac accuracy validated | Native zodiac expertise confirms AI gets personalities right | ☐ |
| 11 | Compatibility scoring inputs provided | Algorithm inputs for all 144 pairings | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Monthly content refresh delivered | New seasonal templates and updates | Monthly |
| User zodiac satisfaction score | > 7/10 ("Does the app understand your partner's sign?") | Monthly |
| Zodiac content uniqueness | 0 generic horoscope-level content — everything must be specific and actionable | Per review |
| Astrological event calendar updated | All significant transits/retrogrades/moon phases logged 30 days in advance | Monthly |
| Response turnaround for content requests | < 72 hours for new zodiac content needs | As needed |

---

## C.11 Female Consultant / Emotional Intelligence Advisor — KPI Checklist

### Phase 1: Concept Validation (Weeks 1-4)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 1 | App concept female validation report delivered | "Would women support or oppose this app?" — Week 1 | ☐ |
| 2 | "What She Actually Wants" document delivered | 100+ real-world scenario cards — Weeks 2-3 | ☐ |
| 3 | Cultural Sensitivity Guide delivered | Cross-cultural emotional needs guide — Week 4 | ☐ |
| 4 | Arabic Women's Perspective Guide delivered | Arabic/Middle Eastern relationship norms and preferences | ☐ |
| 5 | Malay Women's Perspective Guide delivered | Malaysian relationship norms and preferences | ☐ |
| 6 | Gift feedback framework designed | Rating system + "what worked/failed" criteria | ☐ |
| 7 | Smart Action Card scenarios validated | 50+ card templates pass "real woman" test | ☐ |

### Phase 3: Content Validation (Weeks 9-16)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 8 | AI Message Review Report delivered | All message templates rated and corrected — Weeks 10-11 | ☐ |
| 9 | Arabic AI messages reviewed | Arabic outputs pass cultural + emotional authenticity test | ☐ |
| 10 | Malay AI messages reviewed | Malay outputs pass cultural + emotional authenticity test | ☐ |
| 11 | Gift Red Flag List delivered | "Gifts that seem good but aren't" documented — Week 11 | ☐ |
| 12 | SOS Mode Reality Check delivered | All emergency scripts validated — Week 13 | ☐ |
| 13 | Message "cringe rate" | < 10% of reviewed messages rated as cringe/fake/creepy | ☐ |
| 14 | Message "would work" rate | > 75% of reviewed messages rated as "would work" | ☐ |

### Phase 4: Beta Validation (Weeks 17-19)

| # | Checklist Item | KPI / Target | Status |
|---|---------------|-------------|--------|
| 15 | Female Focus Group conducted | 10-15 women (diverse: Western, Arabic, Malay) | ☐ |
| 16 | Focus group satisfaction | > 70% of women say "I'd want my partner to use this" | ☐ |
| 17 | Female Focus Group Report delivered | Insights translated into product changes | ☐ |

### Ongoing KPIs

| KPI | Target | Frequency |
|-----|--------|-----------|
| Monthly authenticity audit completed | All new content passes "real woman" test | Monthly |
| Message authenticity score | > 8/10 average ("sounds like a real thoughtful man") | Monthly |
| Cultural appropriateness (Arabic) | 0 culturally offensive outputs pass review | Monthly |
| Cultural appropriateness (Malay) | 0 culturally offensive outputs pass review | Monthly |
| Trend awareness updates | New scenarios/situations added based on social media trends | Monthly |
| Response turnaround for urgent reviews | < 24 hours for content that's blocking development | As needed |

---

## C.12 Cross-Team KPI Dashboard (Founder's View)

> **Use this summary dashboard to get a 5-minute weekly health check of the entire project.**

### Weekly Health Check — Project Level

| Category | Key Metric | Target | Owner | Status |
|----------|-----------|--------|-------|--------|
| **Schedule** | Sprint goals completion rate | > 85% | Product Manager | ☐ |
| **Quality** | Open P1/P2 bugs | 0 P1, < 5 P2 | QA Engineer | ☐ |
| **Quality** | Crash-free rate (both platforms) | > 99.5% | Tech Lead | ☐ |
| **AI Quality** | Message quality score (EN) | > 8/10 | AI/ML Engineer | ☐ |
| **AI Quality** | Message quality score (AR) | > 7/10 | AI/ML Engineer | ☐ |
| **AI Quality** | Message quality score (MS) | > 7/10 | AI/ML Engineer | ☐ |
| **Performance** | API response time (p95) | < 200ms | Backend Developer | ☐ |
| **Performance** | App startup time | < 2 seconds | Tech Lead | ☐ |
| **Cost** | Monthly AI API spend | Within budget | AI/ML Engineer | ☐ |
| **Cost** | Monthly cloud infra spend | Within budget | DevOps | ☐ |
| **Localization** | RTL layout bugs open | 0 | QA Engineer | ☐ |
| **Localization** | Missing translation keys | 0 | Tech Lead | ☐ |
| **Content** | Domain expert deliverables on track | 100% on schedule | Product Manager | ☐ |
| **Content** | Female consultant approval rate | > 75% pass rate | Female Consultant | ☐ |

### Monthly Health Check — Business Level (Post-Launch)

| Category | Key Metric | Target | Owner |
|----------|-----------|--------|-------|
| **Growth** | Monthly installs (total) | Month-over-month increase | Marketing |
| **Growth** | Installs by market (EN/AR/MS) | Balanced across 3 markets | Marketing |
| **Retention** | D30 retention | > 10% | Product Manager |
| **Revenue** | Free → Paid conversion | > 5% | Product Manager |
| **Revenue** | Monthly recurring revenue (MRR) | Month-over-month increase | Product Manager |
| **Satisfaction** | App Store rating (all markets) | > 4.3 stars | Marketing + PM |
| **Satisfaction** | NPS score | > 40 | Product Manager |
| **AI** | AI cost per user/month | < $0.50 free, < $2.00 pro | AI/ML Engineer |
| **AI** | Message send-through rate | > 60% | AI/ML Engineer |
| **Engagement** | Smart Action Card engagement | > 40% acted upon | AI/ML Engineer |
| **Engagement** | Avg modules used per user | > 3 of 10 | Product Manager |
| **Localization** | Per-market retention parity | AR/MS within 80% of EN retention | Product Manager |

---

> **Tip for the Founder:** Print the C.12 dashboard and bring it to every weekly standup. Any cell that turns red for 2 consecutive weeks requires an action plan from the responsible team member within 48 hours. This is how you ensure nobody drops the ball.

---

*Document Version: 7.0*
*Created: February 14, 2026*
*Last Updated: February 14, 2026*
*Project: LOLO - AI Relationship Intelligence App*
*Languages: English, Arabic, Bahasa Melayu*
