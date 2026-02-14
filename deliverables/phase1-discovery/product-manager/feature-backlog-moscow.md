# LOLO Feature Backlog -- MoSCoW Prioritization with RICE Scoring

**Prepared by:** Sarah Chen, Product Manager
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Dependencies:** Competitive Analysis (v1.0), User Personas & Journey Maps (v1.0), Competitive UX Audit (v1.0), App Concept Validation (v1.0), Emotional State Framework (v1.0), Zodiac Master Profiles (v1.0)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Part 1: MoSCoW Prioritization](#part-1-moscow-prioritization)
   - [Must Have (MVP)](#must-have-mvp--launch-blockers)
   - [Should Have (MVP)](#should-have-mvp--strongly-desired)
   - [Could Have (Post-MVP)](#could-have-post-mvp--nice-to-have)
   - [Won't Have (Not Now)](#wont-have-not-now--explicitly-deferred)
3. [Part 2: RICE Scoring](#part-2-rice-scoring)
4. [Part 3: Sprint Allocation](#part-3-sprint-allocation)
5. [Part 4: Monetization Feature Matrix](#part-4-monetization-feature-matrix)
6. [Part 5: Localization Priority](#part-5-localization-priority)
7. [Summary & Next Steps](#summary--next-steps)

---

## Executive Summary

This document translates LOLO's product vision into a structured, prioritized feature backlog that will guide engineering execution across Sprints 1-4 (Weeks 9-16). The backlog is informed by three validated user personas (Marcus/EN, Ahmed/AR, Hafiz/MS), a competitive analysis of 8 competitors revealing zero AI-first entrants and zero Arabic/Malay support, and the female consultant's validation framework ensuring features pass the authenticity test.

**Key decisions in this backlog:**

- **38 Must Have features** form the MVP launch baseline across 8 modules
- **18 Should Have features** significantly enhance MVP value but do not block launch
- **16 Could Have features** are deferred to v1.1 or v1.2
- **12 Won't Have features** are explicitly out of scope with documented reasoning
- **RICE scoring** ranks the top 30 features by quantitative priority
- **4 sprints** map features to a realistic 8-week development timeline
- **3-tier monetization** (Free/Pro/Legend) ensures clear value differentiation
- **Localization scope** defines what ships trilingual (EN/AR/MS) vs. English-first

The single most important takeaway: **AI Message Generator, Smart Action Cards, and Smart Reminders are the three highest-RICE-scored features and must be flawless at launch.** They map directly to the core pain points of all three personas and are the primary drivers of activation, retention, and monetization.

---

## Part 1: MoSCoW Prioritization

---

### Must Have (MVP -- Launch Blockers)

These 38 features MUST be in v1.0 or the app fails to deliver its core value proposition. Absence of any of these features would prevent activation of at least one persona or break a critical user flow.

---

#### Module 1: Onboarding & Account

##### M-01: Account Creation (Email / Google / Apple Sign-In)

- **Module:** Onboarding & Account
- **Description:** One-tap account creation via Google Sign-In, Apple Sign-In, or email/password. No forced social login. End-to-end encrypted credential storage.
- **User Story:** "As a new user, I want to create an account in under 30 seconds so that I can start using LOLO immediately without friction."
- **Acceptance Criteria:**
  - Google, Apple, and email sign-in all functional on iOS and Android
  - Account creation completes in under 3 taps
  - No email verification required before first use (verify in background)
  - Password stored with bcrypt hashing; all auth tokens encrypted at rest
  - Duplicate account detection (same email across providers)
- **Complexity:** M
- **Sprint:** Sprint 1

##### M-02: Core Onboarding Flow (5 Screens)

- **Module:** Onboarding & Account
- **Description:** 5-screen onboarding collecting: user name, partner name (+ optional zodiac sign), relationship status, key anniversary date, and first AI-generated action card as the "aha moment."
- **User Story:** "As a new user, I want to set up my profile in under 2 minutes so that LOLO can immediately provide personalized value."
- **Acceptance Criteria:**
  - 5 screens maximum before first value delivery
  - Screen 5 delivers an AI-generated SAY card personalized with partner name
  - Copy/share button on first message for immediate sending
  - Drop-off rate target: < 15% across all 5 screens
  - Onboarding data persists even if user closes app mid-flow
- **Complexity:** M
- **Sprint:** Sprint 1

##### M-03: Language Selection (EN/AR/MS)

- **Module:** Onboarding & Account
- **Description:** Language picker on first screen before any other interaction. Supports English, Arabic (full RTL), and Bahasa Melayu. All subsequent UI, AI content, and notifications render in the selected language.
- **User Story:** "As an Arabic-speaking user (Ahmed), I want to select Arabic during setup so that the entire app experience is in my native language with proper RTL layout."
- **Acceptance Criteria:**
  - Language picker appears before account creation screen
  - Arabic selection triggers full RTL layout across all screens
  - Bahasa Melayu renders all UI elements in natural Malaysian BM
  - Language can be changed post-onboarding in Settings
  - System language auto-detection with manual override
- **Complexity:** L
- **Sprint:** Sprint 1

##### M-04: Privacy & Notification Controls (Setup)

- **Module:** Onboarding & Account
- **Description:** Notification permission request with preview of discreet notification style. Option to enable biometric lock (Face ID / fingerprint). Notification content never displays relationship-related text on lock screen.
- **User Story:** "As a privacy-conscious user (Hafiz), I want to ensure LOLO notifications never reveal relationship content on my lock screen so that I avoid malu if someone sees my phone."
- **Acceptance Criteria:**
  - Notification preview shows a mock discreet notification during setup
  - Biometric lock option (Face ID, Touch ID, Fingerprint) available at setup
  - Lock screen notifications display only "LOLO" with no content preview by default
  - All notification content visible only after unlock
  - Privacy settings persist across app updates
- **Complexity:** S
- **Sprint:** Sprint 1

---

#### Module 2: Her Profile Engine

##### M-05: Basic Partner Profile Creation

- **Module:** Her Profile Engine
- **Description:** Structured profile for the user's partner capturing: name, zodiac sign, birthday, love language, communication style, and relationship status. Powers all AI personalization.
- **User Story:** "As a user (Marcus), I want to build a profile of Jessica so that LOLO's AI suggestions are personalized to her personality and preferences."
- **Acceptance Criteria:**
  - Fields: Name, birthday, zodiac sign (12 options + "I don't know"), love language (5 options), communication style (dropdown), relationship status
  - Profile completion percentage displayed (incentivizes completeness)
  - All fields optional except name -- progressive disclosure, not forced entry
  - Data encrypted at rest with user-specific key
  - Profile data feeds into AI prompt context for all modules
- **Complexity:** M
- **Sprint:** Sprint 1

##### M-06: Zodiac Sign Integration (Default Personality Traits)

- **Module:** Her Profile Engine
- **Description:** When a zodiac sign is selected, auto-populate default personality traits, communication preferences, and emotional tendencies based on the zodiac master profiles. User can override any default.
- **User Story:** "As a user who knows his partner's zodiac sign but not her communication style, I want LOLO to pre-fill personality insights based on her sign so that I get useful suggestions immediately."
- **Acceptance Criteria:**
  - All 12 zodiac signs mapped to personality trait defaults (from zodiac-master-profiles.md)
  - Default traits displayed with "This is based on her zodiac sign -- adjust if needed" disclaimer
  - Every auto-populated field has a manual override toggle
  - Zodiac data influences AI message tone and action card suggestions
  - "I don't know her sign" option skips zodiac defaults gracefully
- **Complexity:** M
- **Sprint:** Sprint 2

##### M-07: Partner Preferences & Interests

- **Module:** Her Profile Engine
- **Description:** Expandable sections for: favorite things (flowers, food, music, brands), dislikes, hobbies, stress coping style, and free-text notes. Feeds Gift Engine and Action Cards.
- **User Story:** "As a user (Marcus), I want to log that Jessica loves peonies and hates surprise parties so that LOLO never suggests the wrong gift or gesture."
- **Acceptance Criteria:**
  - Category-based entry: Favorites (flowers, food, music, movies, brands, colors), Dislikes, Hobbies, Stress Coping
  - Free-text notes field for unstructured observations
  - Search/filter within preferences
  - Preferences feed into Gift Engine filters and Action Card personalization
  - Import capability from notes/text (Phase 2 -- manual entry for MVP)
- **Complexity:** M
- **Sprint:** Sprint 2

##### M-08: Cultural & Religious Context Settings

- **Module:** Her Profile Engine
- **Description:** Optional fields for cultural background and religious observance level. Enables Islamic calendar integration, Ramadan-aware messaging, and culturally appropriate gift/action suggestions.
- **User Story:** "As Ahmed, I want to set Noura's cultural context as Gulf Arab and observant Muslim so that LOLO's suggestions respect our religious and cultural norms."
- **Acceptance Criteria:**
  - Cultural background options: Arab (Gulf/Levantine/Egyptian/North African), Malay, Western, South Asian, East Asian, Other
  - Religious observance: High / Moderate / Low / Secular
  - When Islamic context is set: Ramadan, Eid al-Fitr, Eid al-Adha, Maulidur Rasul auto-added to calendar
  - AI tone adjusts during Ramadan (spiritual, less romantic)
  - Gift suggestions exclude culturally inappropriate items
- **Complexity:** M
- **Sprint:** Sprint 2

---

#### Module 3: Smart Reminder Engine

##### M-09: Anniversary & Birthday Reminders

- **Module:** Smart Reminder Engine
- **Description:** Core date tracking with multi-tiered reminders: 30 days, 14 days, 7 days, 3 days, 1 day, and day-of for birthdays and anniversaries. Escalating urgency in notification copy.
- **User Story:** "As Marcus, I want to be reminded about Jessica's birthday starting 30 days out so that I never scramble for a last-minute gift again."
- **Acceptance Criteria:**
  - Support for: dating anniversary, wedding anniversary, partner birthday, custom dates
  - 6-tier escalating reminder schedule (30d, 14d, 7d, 3d, 1d, day-of)
  - Day-30 and Day-14 reminders include Gift Engine link ("Start planning her gift")
  - Day-3 and Day-1 reminders escalate urgency ("Her birthday is in 3 days -- have you ordered?")
  - Calendar sync (Google Calendar, Apple Calendar) for auto-import
  - Snooze and dismiss options on each reminder
- **Complexity:** M
- **Sprint:** Sprint 2

##### M-10: Islamic & Cultural Holiday Reminders

- **Module:** Smart Reminder Engine
- **Description:** Automatic tracking and reminders for Islamic holidays (Eid al-Fitr, Eid al-Adha, Ramadan start/end, Maulidur Rasul) and cultural events (Hari Raya Aidilfitri, Chinese New Year for Malaysian users). Tied to cultural context settings.
- **User Story:** "As Ahmed, I want LOLO to automatically remind me about Eid al-Fitr preparation 3 weeks before so that I have time to arrange gifts for Noura's entire family."
- **Acceptance Criteria:**
  - Islamic holidays auto-populated when cultural context includes Islamic observance
  - Hijri calendar date calculations accurate for current and next year
  - Reminders begin 21 days before major holidays (Eid, Ramadan)
  - Holiday reminders link to relevant Gift Engine and Message Generator suggestions
  - Malaysia-specific holidays (Hari Raya, Maulidur Rasul) included for Malay users
- **Complexity:** M
- **Sprint:** Sprint 2

##### M-11: Custom Reminder Creation

- **Module:** Smart Reminder Engine
- **Description:** User-created reminders for any date or recurring event. Supports one-time and recurring (weekly, monthly, yearly) reminders with custom notification text.
- **User Story:** "As Hafiz, I want to set a recurring weekly reminder to plan a small gesture for Aisyah every Friday so that I build a consistent habit."
- **Acceptance Criteria:**
  - One-time and recurring reminder types (daily, weekly, monthly, yearly)
  - Custom title and optional notes on each reminder
  - Recurring reminders with end date or "forever" option
  - Maximum 50 active reminders per user (free: 10, Pro: 30, Legend: 50)
  - Edit and delete existing reminders
  - Time-zone-aware delivery
- **Complexity:** S
- **Sprint:** Sprint 2

##### M-12: Promise Tracker

- **Module:** Smart Reminder Engine
- **Description:** Dedicated tracker for promises made to partner. User logs a promise ("Take her to that Thai restaurant"), sets a target date, and receives escalating reminders until marked complete.
- **User Story:** "As Marcus, I want to log promises I make to Jessica so that I actually follow through instead of forgetting them within a week."
- **Acceptance Criteria:**
  - Promise entry: title, description, target date, priority (low/medium/high)
  - Status tracking: Open, In Progress, Completed, Overdue
  - Escalating reminders as target date approaches (7d, 3d, 1d, overdue)
  - Overdue promises flagged with "This promise is overdue. Jessica may have noticed." messaging
  - Completion awards XP (gamification integration)
  - Maximum 20 active promises (free: 5, Pro: 15, Legend: 20)
- **Complexity:** S
- **Sprint:** Sprint 3

---

#### Module 4: AI Message Generator

##### M-13: Core AI Message Generation Engine

- **Module:** AI Message Generator
- **Description:** Multi-model AI engine that generates personalized messages for the user to send to their partner. Routes requests through the AI model best suited for emotional context. Outputs natural-language messages calibrated to partner profile, relationship stage, and cultural context.
- **User Story:** "As any user, I want to generate a thoughtful message for my partner in under 10 seconds so that I can express my feelings even when I struggle to find the right words."
- **Acceptance Criteria:**
  - Message generation completes in under 5 seconds
  - Messages incorporate partner name, relationship context, and recent interactions
  - Output is 2-5 sentences by default (adjustable: short/medium/long)
  - Copy-to-clipboard and share-to-app (WhatsApp, iMessage, etc.) buttons
  - "Regenerate" button produces a different message on same prompt
  - Rate message (thumbs up/down) feedback loop for model improvement
- **Complexity:** XL
- **Sprint:** Sprint 2

##### M-14: 3 Free Message Modes (Good Morning / Appreciation / Romance)

- **Module:** AI Message Generator
- **Description:** Three situational message modes available on the free tier. Good Morning messages, Appreciation & Compliments, and Romantic messages. Each mode adjusts tone, length, and vocabulary.
- **User Story:** "As a free-tier user, I want access to Good Morning, Appreciation, and Romance message modes so that I can experience LOLO's core value before deciding to upgrade."
- **Acceptance Criteria:**
  - Three modes selectable from message generation screen: Good Morning, Appreciation, Romance
  - Each mode has distinct prompt engineering for tone, vocabulary, and emotional register
  - Good Morning: warm, brief, start-of-day energy
  - Appreciation: specific, observation-based compliments
  - Romance: emotionally deep, intimate, partner-specific
  - Free tier limit: 5 messages per month across all 3 modes
- **Complexity:** L
- **Sprint:** Sprint 2

##### M-15: 7 Pro/Legend Message Modes

- **Module:** AI Message Generator
- **Description:** Seven additional situational modes unlocked at Pro/Legend tiers: Apology & Reconciliation, Missing You, Celebration, Comfort & Reassurance, Flirting & Playful, Deep Conversation Starters, and "Just Because."
- **User Story:** "As Marcus (Pro subscriber), I want access to the Apology mode so that when I mess up, I have help crafting a genuine, non-defensive apology that addresses Jessica's feelings."
- **Acceptance Criteria:**
  - 7 modes accessible from message generation screen for Pro/Legend users
  - Apology mode: non-defensive, accountability-first, empathetic language
  - Missing You: longing, warmth, distance-bridging
  - Celebration: milestone-specific, joyful, partner-centered
  - Comfort: empathetic, validating, "I'm here" focused
  - Flirting: playful, confident, culturally calibrated (more restrained for AR/MS)
  - Deep Conversation: thought-provoking, intimacy-building
  - "Just Because": spontaneous, no-occasion warmth
  - Pro: 30 messages/month; Legend: Unlimited
- **Complexity:** L
- **Sprint:** Sprint 3

##### M-16: Trilingual Message Generation (EN/AR/MS)

- **Module:** AI Message Generator
- **Description:** AI generates messages in English, Arabic (Gulf dialect priority, with MSA fallback), and Bahasa Melayu (Malaysian colloquial). Language selection matches app language setting but can be overridden per message.
- **User Story:** "As Ahmed, I want AI-generated messages in Gulf Arabic dialect so that the words sound natural to Noura and her family, not like machine translation."
- **Acceptance Criteria:**
  - English messages: natural, conversational American/British English
  - Arabic messages: Gulf dialect vocabulary and expressions by default; user can select Egyptian or Levantine
  - Malay messages: Malaysian colloquial BM with appropriate terms (Abang, Sayang, InsyaAllah)
  - Language override per message (e.g., Arabic user can generate one English message)
  - Arabic output renders properly in RTL with correct diacritics
  - Quality benchmark: >4.0/5.0 average user rating per language within first month
- **Complexity:** XL
- **Sprint:** Sprint 3

##### M-17: Message Tone & Length Controls

- **Module:** AI Message Generator
- **Description:** User-adjustable controls for tone (formal/casual/playful) and length (short/medium/long) on every generated message. Defaults set by Her Profile data.
- **User Story:** "As Ahmed, I want to set the tone to 'formal' when generating a message for Noura's father and 'casual' for Noura directly so that each message fits its context."
- **Acceptance Criteria:**
  - Tone slider or selector: Formal, Warm, Casual, Playful
  - Length selector: Short (1-2 sentences), Medium (3-4 sentences), Long (5+ sentences)
  - Defaults loaded from Her Profile (e.g., formal defaults for family, casual for partner)
  - Tone and length settings remembered per recipient type
  - Preview updates in real-time as controls are adjusted
- **Complexity:** S
- **Sprint:** Sprint 3

---

#### Module 5: Smart Action Cards (SAY/DO/BUY/GO)

##### M-18: Daily Action Card Generation

- **Module:** Smart Action Cards
- **Description:** Each day, LOLO generates one primary action card for the user, categorized as SAY (message/compliment), DO (physical action), BUY (gift/purchase), or GO (experience/outing). Cards are contextual based on Her Profile, calendar, and relationship stage.
- **User Story:** "As Hafiz, I want to receive one specific, actionable suggestion every morning so that I know exactly what to do for Aisyah today without decision paralysis."
- **Acceptance Criteria:**
  - One card generated daily at user-configured time (default: 8 AM local)
  - Card type rotates across SAY/DO/BUY/GO categories for variety
  - Card content references partner name, profile data, and current context (holidays, pregnancy, etc.)
  - Card includes a "Complete" button that logs the action and awards XP
  - "Skip" option with brief reason (too busy, not relevant, etc.) for algorithm improvement
  - Free: 1 card/day; Pro: 3 cards/day; Legend: 5 cards/day + custom card requests
- **Complexity:** L
- **Sprint:** Sprint 3

##### M-19: SAY Card Type

- **Module:** Smart Action Cards
- **Description:** SAY cards suggest a specific verbal message or compliment the user can say or text to their partner. Includes a pre-generated AI message that can be copied/customized.
- **User Story:** "As Marcus, I want a SAY card that tells me something specific to say to Jessica today so that I rebuild daily verbal affection without relying on my own initiative."
- **Acceptance Criteria:**
  - SAY card displays: category label, suggestion text, pre-generated message, copy button
  - Messages are specific and contextual ("Tell her you noticed how she handled Lily's tantrum")
  - Copy-to-clipboard integrates with message sharing
  - Links to AI Message Generator for customization
  - Completion awards +15 XP
- **Complexity:** M
- **Sprint:** Sprint 3

##### M-20: DO Card Type

- **Module:** Smart Action Cards
- **Description:** DO cards suggest a specific physical action or gesture. Examples: "Give her a 5-minute foot massage tonight," "Cook her favorite meal," "Take the kids for an hour so she can rest."
- **User Story:** "As Hafiz, I want DO cards that suggest budget-friendly gestures I can do for Aisyah during her pregnancy so that I show love through actions, not just words."
- **Acceptance Criteria:**
  - DO card displays: category label, action description, estimated time/effort, tips
  - Actions calibrated to relationship context (pregnancy-aware, budget-aware)
  - No actions requiring significant financial investment unless user profile indicates comfort
  - Cultural calibration: appropriate actions for each market
  - Completion awards +20 XP
- **Complexity:** M
- **Sprint:** Sprint 3

##### M-21: BUY Card Type

- **Module:** Smart Action Cards
- **Description:** BUY cards suggest a specific purchase or gift. Links to Gift Engine for full recommendations. Budget-aware based on user settings.
- **User Story:** "As Ahmed, I want BUY cards that suggest culturally appropriate gifts for Noura and her family so that I never show up empty-handed to a family gathering."
- **Acceptance Criteria:**
  - BUY card displays: category label, gift suggestion, estimated price range, link to Gift Engine
  - Budget filter applied based on user settings (or "Low Budget High Impact" mode)
  - Seasonal awareness (Eid, birthdays, holidays boost BUY card frequency)
  - Affiliate links where available (Amazon, Noon, Shopee)
  - Completion awards +25 XP
- **Complexity:** M
- **Sprint:** Sprint 3

##### M-22: GO Card Type

- **Module:** Smart Action Cards
- **Description:** GO cards suggest a specific outing, date, or experience. Examples: "Take her to the new cafe she mentioned in Bangsar," "Plan a sunset walk at the park near your house."
- **User Story:** "As Marcus, I want GO cards that suggest specific date ideas based on what Jessica has mentioned so that I plan quality time without the mental burden of ideation."
- **Acceptance Criteria:**
  - GO card displays: category label, experience suggestion, estimated cost, location hint
  - References Memory Vault / Wish List data when available ("She mentioned wanting to try Cafe Kopi Bangsar")
  - Budget-aware suggestions
  - Weather-appropriate when possible (outdoor vs. indoor)
  - Completion awards +25 XP
- **Complexity:** M
- **Sprint:** Sprint 3

---

#### Module 6: Gift Recommendation Engine

##### M-23: AI Gift Recommendation Core

- **Module:** Gift Recommendation Engine
- **Description:** AI-powered gift suggestion engine that generates personalized gift ideas based on Her Profile data, occasion, budget, and cultural context. Each recommendation includes gift name, description, estimated price, and why it fits her.
- **User Story:** "As Marcus, I want AI-generated gift suggestions for Jessica's birthday that reflect her actual interests so that my gift makes her feel truly seen."
- **Acceptance Criteria:**
  - Generates 5-10 gift suggestions per request
  - Inputs: occasion, budget range, Her Profile data, cultural context
  - Each suggestion includes: name, description, price range, reasoning ("She loves peonies and you logged that she wants new books")
  - Affiliate purchase links where available
  - Feedback mechanism: "She loved it" / "She didn't like it" / "Didn't buy it"
  - Free: 2 requests/month; Pro: 10/month; Legend: Unlimited
- **Complexity:** L
- **Sprint:** Sprint 3

##### M-24: Budget Filter & "Low Budget High Impact" Mode

- **Module:** Gift Recommendation Engine
- **Description:** Budget range selector ($0-25, $25-50, $50-100, $100-250, $250+, custom) and a dedicated "Low Budget High Impact" mode that suggests meaningful, inexpensive or free gifts (handwritten letters, home-cooked meals, DIY gifts).
- **User Story:** "As Hafiz, I want a 'Low Budget High Impact' mode that suggests gifts under RM 50 that feel like RM 500 so that I show love without breaking our tight budget."
- **Acceptance Criteria:**
  - Budget range selector with market-appropriate currency and ranges
  - "Low Budget High Impact" toggle generates gift ideas under $15 / RM 50 / AED 50
  - Low-budget suggestions include: handwritten letter templates, DIY ideas, experience gifts, homemade food
  - All suggestions include effort/time estimate alongside cost
  - Currency auto-set by locale (USD, AED, MYR) with manual override
- **Complexity:** M
- **Sprint:** Sprint 3

##### M-25: Occasion-Based Gift Packages

- **Module:** Gift Recommendation Engine
- **Description:** Pre-configured gift recommendation packages for major occasions: Birthday, Anniversary, Eid, Valentine's Day, "Just Because." Each package includes primary gift + complementary items + message + presentation idea.
- **User Story:** "As Ahmed, I want a complete Eid gift package for Noura that includes the gift, wrapping idea, and Eid message so that my presentation is as impressive as the gift itself."
- **Acceptance Criteria:**
  - Package includes: primary gift, 1-2 complementary items, AI-generated card message, presentation/wrapping suggestion
  - Occasion-specific packages: Birthday, Anniversary, Eid al-Fitr, Eid al-Adha, Hari Raya, Valentine's Day, "Just Because"
  - Islamic occasions include culturally appropriate gift norms (no alcohol, modest items)
  - Budget total for entire package displayed
  - "Order all" links where affiliate integration supports it
- **Complexity:** M
- **Sprint:** Sprint 4

---

#### Module 7: SOS Mode

##### M-26: SOS Mode Activation (2-Tap Access)

- **Module:** SOS Mode
- **Description:** Emergency relationship assistance accessible in 2 taps from any screen. A persistent, discreet SOS button launches a crisis-resolution interface with real-time AI coaching.
- **User Story:** "As Marcus, I want to access SOS Mode in 2 taps when I'm in the middle of an argument with Jessica so that I get real-time help de-escalating the situation."
- **Acceptance Criteria:**
  - SOS button visible on home screen and accessible via 2 taps from any screen
  - SOS icon is discreet (no alarm/siren imagery -- just a subtle shield or lifeline icon)
  - Launches within 1 second of tap
  - No loading screens, no ads, no paywall gate on entry (paywall on extended use)
  - Works offline with cached emergency response templates (online for AI coaching)
- **Complexity:** M
- **Sprint:** Sprint 4

##### M-27: Crisis Scenario Selection

- **Module:** SOS Mode
- **Description:** Quick-select screen for crisis type: "We're in an argument," "I forgot something important," "She's upset and I don't know why," "I need to apologize right now," "I said the wrong thing." Selection routes to scenario-specific AI coaching.
- **User Story:** "As Hafiz, I want to quickly select 'She's upset and I don't know why' so that LOLO gives me situation-specific guidance instead of generic advice."
- **Acceptance Criteria:**
  - 5-7 pre-defined crisis scenarios displayed as large, tappable buttons
  - Scenario selection triggers scenario-specific AI prompt
  - Free: 2 SOS uses/month; Pro: 5/month; Legend: Unlimited
  - Each scenario has a cached offline fallback (3-5 static tips) when AI is unavailable
  - Response time: AI coaching appears within 3 seconds of scenario selection
- **Complexity:** M
- **Sprint:** Sprint 4

##### M-28: Real-Time AI Coaching Response

- **Module:** SOS Mode
- **Description:** After scenario selection, AI provides step-by-step coaching: what to say, what NOT to say, body language tips, and de-escalation phrases. Calibrated to Her Profile and cultural context.
- **User Story:** "As Marcus, I want LOLO to tell me exactly what to say and what NOT to say during an argument with Jessica so that I stop defaulting to 'It'll be fine' and actually validate her feelings."
- **Acceptance Criteria:**
  - Response format: 3-5 actionable steps displayed sequentially (not a wall of text)
  - Includes "SAY THIS" and "DON'T SAY THIS" sections
  - Steps reference Her Profile data (her communication style, stress coping preferences)
  - Cultural calibration: Arabic responses respect family hierarchy; Malay responses account for indirect communication norms
  - Follow-up prompt after 5 minutes: "How did it go?" with quick-select outcomes
  - Pro tier: Standard AI model; Legend tier: Premium model with deeper emotional analysis
- **Complexity:** L
- **Sprint:** Sprint 4

---

#### Module 8: Gamification

##### M-29: Daily Streak Counter

- **Module:** Gamification
- **Description:** Tracks consecutive days the user opens LOLO and completes at least one action (action card, message, reminder check, profile update). Displays prominently on home screen. Streak breaks trigger re-engagement notification.
- **User Story:** "As Marcus, I want to see my daily streak on the home screen so that I feel motivated to not break it -- the same psychology that keeps me on Duolingo."
- **Acceptance Criteria:**
  - Streak increments when user completes at least 1 qualifying action per day
  - Qualifying actions: complete action card, send AI message, log memory, update profile, check reminders
  - Streak displays on home screen with flame/streak icon
  - Streak break triggers push notification within 24 hours ("Your 14-day streak ended. Start a new one today.")
  - Streak milestones (7, 14, 30, 60, 90 days) award bonus XP
  - "Streak freeze" available (Legend only): preserve streak for 1 missed day per month
- **Complexity:** S
- **Sprint:** Sprint 2

##### M-30: XP Points System

- **Module:** Gamification
- **Description:** Experience points awarded for every meaningful action in the app. XP feeds into level progression and Relationship Consistency Score.
- **User Story:** "As a user, I want to earn points for completing action cards and sending messages so that I feel a sense of progress and accomplishment."
- **Acceptance Criteria:**
  - XP awarded: Action card complete (+15-25), Message sent (+10), Reminder set (+5), Profile update (+5), Memory logged (+10), Promise completed (+20), Gift feedback (+10)
  - XP displayed on home screen alongside streak
  - XP history viewable in profile
  - No XP awarded for passive actions (just opening the app)
  - Daily XP cap of 100 to prevent gaming
- **Complexity:** S
- **Sprint:** Sprint 2

##### M-31: Level Progression System

- **Module:** Gamification
- **Description:** 10-level progression system based on cumulative XP. Each level has a name and unlocks a title. Levels: Beginner (1), Learner (2), Attentive (3), Thoughtful (4), Strategist (5), Devoted (6), Champion (7), Legend (8), Master (9), Soulmate (10).
- **User Story:** "As Marcus, I want to level up from 'Beginner' to 'Strategist' so that I can see concrete progress in my effort to be a better partner."
- **Acceptance Criteria:**
  - 10 levels with escalating XP thresholds (Level 2: 100 XP, Level 5: 1000 XP, Level 10: 10000 XP)
  - Level name displayed on home screen and profile
  - Level-up animation and congratulatory message on achievement
  - Each level unlocks a motivational insight about consistency
  - Level visible only to the user (not shared publicly by default)
- **Complexity:** S
- **Sprint:** Sprint 2

##### M-32: Relationship Consistency Score

- **Module:** Gamification
- **Description:** A composite 0-100 score reflecting the user's consistency in being thoughtful. Calculated from: action card completion rate, streak length, message frequency, reminder follow-through, and promise completion. Displayed prominently on home dashboard.
- **User Story:** "As Marcus, I want a Relationship Consistency Score on my home screen so that I have a single metric showing how consistent I am -- like a credit score for being a good partner."
- **Acceptance Criteria:**
  - Score: 0-100, updated daily
  - Inputs: action card completion (30%), streak (20%), messages sent (15%), reminders acknowledged (15%), promises completed (20%)
  - Weekly trend indicator (up/down arrow with percentage change)
  - Benchmark: "You're more thoughtful than X% of LOLO users" (percentile ranking)
  - Score visible on home dashboard, below-the-fold detail view shows component breakdown
  - No partner visibility -- this is the user's private metric
- **Complexity:** M
- **Sprint:** Sprint 3

---

#### Module 9: Memory Vault

##### M-33: Memory Entry Creation

- **Module:** Memory Vault
- **Description:** User can log relationship memories: moments, events, things she said, places visited. Each entry includes: title, description, date, optional photo, and tags. Encrypted storage.
- **User Story:** "As Marcus, I want to log the restaurant Jessica loved on our date night so that LOLO can reference it in future GO cards and gift suggestions."
- **Acceptance Criteria:**
  - Entry fields: title, description (free text), date, optional photo (1 per entry on free, 5 on Pro, unlimited on Legend), tags
  - Tags: predefined (Date Night, Gift, Conversation, Trip, Milestone) + custom
  - Entries sorted chronologically with search and filter
  - All entries encrypted at rest
  - Free: 10 memories max; Pro: 50; Legend: Unlimited
  - Quick-add: one-tap entry from home screen
- **Complexity:** M
- **Sprint:** Sprint 3

##### M-34: Wish List Capture

- **Module:** Memory Vault
- **Description:** Dedicated section within Memory Vault for logging things she has mentioned wanting. "She said she wants..." entries that feed directly into the Gift Engine.
- **User Story:** "As Marcus, I want to log that Jessica mentioned wanting 'that candle from the farmers market' so that LOLO reminds me to buy it before her birthday."
- **Acceptance Criteria:**
  - Wish list entry: item description, approximate price (optional), date mentioned, priority (nice-to-have / really wants), occasion link (optional)
  - Wish list items surfaced in Gift Engine recommendations ("She mentioned wanting...")
  - Notification when a gifting occasion approaches and wish list items exist
  - Free: 5 items; Pro: 20; Legend: Unlimited
  - Quick-add option from home screen or within any conversation/module
- **Complexity:** S
- **Sprint:** Sprint 3

---

#### Module 10: Core Infrastructure

##### M-35: Home Dashboard

- **Module:** Core Infrastructure
- **Description:** The primary screen users see after opening LOLO. Displays: today's action card, streak counter, XP, Relationship Consistency Score, next upcoming reminder, and quick-access to AI Messages and SOS.
- **User Story:** "As any user, I want a single home screen that shows me the most important information and actions so that I can engage meaningfully in under 60 seconds."
- **Acceptance Criteria:**
  - Visible elements: Today's Action Card (primary), Streak + XP (top bar), Consistency Score (secondary), Next Reminder (tertiary), Quick-access: Message Generator + SOS
  - Dark mode by default, light mode toggle in settings
  - Full RTL layout when Arabic is selected
  - All content localized in selected language
  - Load time: under 2 seconds on mid-range devices
  - Pull-to-refresh updates action card and score
- **Complexity:** L
- **Sprint:** Sprint 1

##### M-36: Bottom Navigation (5 Tabs)

- **Module:** Core Infrastructure
- **Description:** Bottom tab navigation with 5 tabs: Home, Messages, Gifts, Memories, Profile. Standard mobile pattern with RTL mirror for Arabic.
- **User Story:** "As any user, I want consistent bottom navigation so that I can move between LOLO's core modules without confusion."
- **Acceptance Criteria:**
  - 5 tabs: Home (house icon), Messages (chat icon), Gifts (gift icon), Memories (vault icon), Profile (person icon)
  - Active tab highlighted with brand accent color
  - RTL layout mirrors tab order for Arabic users
  - Badge indicator on Messages tab when new AI suggestion is available
  - Tab labels localized (EN/AR/MS)
  - Haptic feedback on tab selection (subtle)
- **Complexity:** S
- **Sprint:** Sprint 1

##### M-37: Push Notification System

- **Module:** Core Infrastructure
- **Description:** Notification engine for reminders, action cards, streak alerts, and system messages. All notifications are discreet (no relationship content visible on lock screen). Supports notification scheduling, quiet hours, and per-category toggles.
- **User Story:** "As Hafiz, I want notifications that are useful but never embarrassing so that I stay engaged without risking malu if someone glances at my phone."
- **Acceptance Criteria:**
  - Notification categories: Reminders, Action Cards, Streak Alerts, System Updates
  - Lock screen display: "LOLO" title only, no content preview (user can override in settings)
  - Quiet hours configurable (default: 10 PM - 7 AM)
  - Per-category toggle (e.g., disable Streak Alerts but keep Reminders)
  - Notification delivery via FCM (Android) and APNs (iOS)
  - Maximum 3 notifications per day (configurable)
- **Complexity:** M
- **Sprint:** Sprint 1

##### M-38: Subscription & Paywall System

- **Module:** Core Infrastructure
- **Description:** In-app subscription management for Free, Pro ($6.99/mo), and Legend ($12.99/mo) tiers. Paywall screens triggered at feature limits. Regional pricing support for Malaysia (RM 14.90 / RM 26.90). Subscription via Google Play Billing and Apple In-App Purchases.
- **User Story:** "As a free user hitting my 5-message monthly limit, I want a clear, non-aggressive paywall that shows me what Pro unlocks so that I can make an informed upgrade decision."
- **Acceptance Criteria:**
  - Three tiers: Free, Pro, Legend with feature gates per tier
  - Paywall trigger: when user hits a free-tier limit (messages, action cards, memories, etc.)
  - Paywall screen: feature comparison, price, and "Start Free Trial" (7-day trial for Pro)
  - Regional pricing: auto-detect locale for Malaysia (RM pricing)
  - Subscription management: upgrade, downgrade, cancel from Profile > Subscription
  - Revenue tracking: MRR, churn rate, upgrade triggers logged for analytics
  - Google Play Billing API and Apple StoreKit 2 integration
- **Complexity:** L
- **Sprint:** Sprint 1

---

### Should Have (MVP -- Strongly Desired)

These 18 features significantly enhance value and user experience but will not block launch if they slip to a fast-follow release (v1.0.1 or v1.0.2).

---

##### S-01: Family Member Profiles (Beyond Partner)

- **Module:** Her Profile Engine
- **Description:** Ability to add profiles for partner's family members (mother, father, siblings). Each profile stores: name, birthday, interests, health notes, relationship to partner. Powers Action Cards that reference family members.
- **User Story:** "As Ahmed, I want to store Um Noura's birthday and health concerns so that LOLO reminds me to ask about her knee and send her flowers on her birthday."
- **Complexity:** M
- **Sprint:** Sprint 4

##### S-02: Wish List Auto-Surfacing in Gift Engine

- **Module:** Memory Vault + Gift Engine
- **Description:** When a gifting occasion approaches, the Gift Engine automatically surfaces partner's Wish List items as top recommendations. "She mentioned wanting this 3 months ago."
- **Complexity:** S
- **Sprint:** Sprint 4

##### S-03: AI Message History & Favorites

- **Module:** AI Message Generator
- **Description:** Log of all generated messages with option to favorite and re-use. Searchable history filtered by mode, date, and language.
- **User Story:** "As Marcus, I want to see my message history so that I don't accidentally send a similar message twice and can reuse messages that worked well."
- **Complexity:** S
- **Sprint:** Sprint 4

##### S-04: Action Card Completion History

- **Module:** Smart Action Cards
- **Description:** Historical log of all completed and skipped action cards. Allows user to see patterns in engagement and missed opportunities.
- **Complexity:** S
- **Sprint:** Sprint 4

##### S-05: Weekly Summary Report

- **Module:** Gamification
- **Description:** End-of-week push notification and in-app summary showing: cards completed, messages sent, streak status, score change, and percentile ranking. "This week you completed 5/7 action cards. Your score rose from 72 to 78."
- **User Story:** "As Marcus, I want a weekly summary showing my progress so that I can track improvement over time and stay motivated."
- **Complexity:** M
- **Sprint:** Sprint 4

##### S-06: Gift Feedback Loop

- **Module:** Gift Recommendation Engine
- **Description:** After a gifting occasion passes, prompt user: "Did she like the gift?" with options: Loved it / Liked it / Neutral / Didn't like it. Feedback improves future recommendations.
- **Complexity:** S
- **Sprint:** Sprint 4

##### S-07: Ramadan Mode

- **Module:** Smart Action Cards + AI Messages
- **Description:** Global mode toggle during Ramadan that adjusts: AI message tone (spiritual, less romantic), action cards (iftar-focused, family-centered), gift suggestions (dates, prayer items, Quran accessories), and notification timing (post-iftar, pre-suhoor).
- **User Story:** "As Ahmed, I want LOLO to automatically adjust its tone and suggestions during Ramadan so that messages and actions are appropriate for the holy month."
- **Complexity:** M
- **Sprint:** Sprint 4

##### S-08: Pregnancy Mode

- **Module:** Smart Action Cards + AI Messages
- **Description:** When pregnancy is indicated in Her Profile, action cards and messages shift to pregnancy-aware content: physical comfort suggestions, emotional support messages, appointment reminders, body positivity affirmations.
- **User Story:** "As Hafiz, I want LOLO to adjust its suggestions for Aisyah's pregnancy so that cards like 'give her a foot massage' and 'remind her she's beautiful' appear when she needs them most."
- **Complexity:** M
- **Sprint:** Sprint 4

##### S-09: Offline Mode (Basic)

- **Module:** Core Infrastructure
- **Description:** Cached action cards, reminders, and recent message history accessible without internet. AI generation requires connectivity but cached emergency responses are available in SOS Mode offline.
- **Complexity:** M
- **Sprint:** Sprint 4

##### S-10: App Lock (Biometric + PIN)

- **Module:** Core Infrastructure
- **Description:** Biometric (Face ID / fingerprint) or PIN lock at app launch. Essential for privacy-sensitive markets (AR/MS).
- **User Story:** "As Ahmed, I want biometric lock on LOLO so that no one can open the app if they pick up my phone."
- **Complexity:** S
- **Sprint:** Sprint 2

##### S-11: Settings & Preferences Screen

- **Module:** Core Infrastructure
- **Description:** Settings screen with: language selection, notification preferences, subscription management, privacy controls, about, help, and account management (logout/delete).
- **Complexity:** S
- **Sprint:** Sprint 2

##### S-12: Onboarding Tooltips (First-Time Module Use)

- **Module:** Core Infrastructure
- **Description:** Contextual tooltips that appear the first time a user opens each module. Brief (1-2 sentences) with "Got it" dismiss button. Not a full tutorial -- just contextual hints.
- **Complexity:** S
- **Sprint:** Sprint 3

##### S-13: Calendar Sync (Google Calendar / Apple Calendar)

- **Module:** Smart Reminder Engine
- **Description:** Two-way sync with device calendar. Import existing anniversaries and birthdays. Export LOLO reminders to device calendar.
- **Complexity:** M
- **Sprint:** Sprint 3

##### S-14: Message Mode Quick-Switch

- **Module:** AI Message Generator
- **Description:** Ability to switch between message modes without navigating back to the mode selection screen. Swipe or tab interface for rapid mode changes.
- **Complexity:** S
- **Sprint:** Sprint 3

##### S-15: Gift Engine Regional Affiliate Links

- **Module:** Gift Recommendation Engine
- **Description:** Market-specific affiliate links: Amazon (EN markets), Noon.com (GCC/Arabic markets), Shopee/Lazada (Malaysian market). One-tap to purchase from gift suggestion.
- **Complexity:** M
- **Sprint:** Sprint 4

##### S-16: Action Card "Not Relevant" Feedback

- **Module:** Smart Action Cards
- **Description:** When user skips a card, offer quick reason: "Too busy," "Not relevant," "Too expensive," "Already did something similar." Feedback improves future card generation.
- **Complexity:** S
- **Sprint:** Sprint 3

##### S-17: Her Profile Completion Incentives

- **Module:** Her Profile Engine + Gamification
- **Description:** XP bonuses for completing Her Profile milestones (25%, 50%, 75%, 100%). "Complete her profile to unlock more personalized suggestions."
- **Complexity:** S
- **Sprint:** Sprint 3

##### S-18: Data Export (Privacy Compliance)

- **Module:** Core Infrastructure
- **Description:** User can export all personal data (profile, memories, messages, reminders) as a downloadable file. Required for GDPR / PDPA compliance.
- **Complexity:** M
- **Sprint:** Sprint 4

---

### Could Have (Post-MVP -- Nice to Have)

These 16 features would delight users and enhance the product but can wait for v1.1 or v1.2 without impacting launch viability.

---

| # | Feature | Module | Target Release | Rationale for Deferral |
|---|---------|--------|---------------|------------------------|
| C-01 | Stealth Mode (app rename + icon swap) | Core Infrastructure | v1.1 | High value for AR/MS privacy but complex to implement cross-platform. Privacy controls + biometric lock cover MVP needs. |
| C-02 | AI Memory Surfacing ("Remember when...") | Memory Vault | v1.1 | AI-triggered memory recalls at contextually appropriate moments. Requires significant AI context window and training. |
| C-03 | Voice-to-Text Memory Logging | Memory Vault | v1.1 | Speak a memory instead of typing. Reduces friction but requires speech-to-text in 3 languages. |
| C-04 | Photo Recognition in Memories | Memory Vault | v1.2 | AI identifies people, places, and objects in uploaded photos. Complex ML feature. |
| C-05 | Date Night Planner (Full Flow) | Smart Action Cards | v1.1 | End-to-end date planning: restaurant selection, reservation, outfit suggestion, conversation topics. GO cards cover basic need for MVP. |
| C-06 | Multi-Model AI Router (Visible) | AI Message Generator | v1.1 | User-facing model selection (Claude for deep emotional, Grok for quick wit, Gemini for analytical). MVP uses server-side routing invisibly. |
| C-07 | Message Template Library | AI Message Generator | v1.1 | Pre-written message templates users can browse and customize. AI generation covers this need for MVP. |
| C-08 | Relationship Timeline | Memory Vault | v1.2 | Visual chronological timeline of relationship milestones, memories, and achievements. Beautiful but non-essential. |
| C-09 | Seasonal Theme Packs | Gamification | v1.1 | Ramadan theme, Valentine's theme, Eid theme -- visual customization of app interface. Engagement enhancer but not functional. |
| C-10 | Achievement Badges | Gamification | v1.1 | Unlock badges for milestones: "First Apology Sent," "30-Day Streak," "Gift Guru." Visual rewards beyond XP/levels. |
| C-11 | Push Notification AI Personalization | Core Infrastructure | v1.2 | AI-crafted notification copy that varies daily instead of templated messages. Engagement lift but requires notification A/B testing infrastructure. |
| C-12 | In-App Gift Purchasing (Direct) | Gift Recommendation Engine | v1.2 | Buy gifts directly within LOLO instead of redirecting to affiliate sites. Requires payment processing, inventory, and fulfillment partnerships. |
| C-13 | Partner's Mood Tracker (User-Reported) | Her Profile Engine | v1.1 | User logs partner's apparent mood daily. AI analyzes patterns. Useful but risks feeling clinical/surveillance-like per female consultant feedback. |
| C-14 | Conversation Starters Library | AI Message Generator | v1.1 | Curated library of deep conversation questions organized by topic. Supplements AI generation for users who prefer browsing. |
| C-15 | Multiple Partner Profiles | Her Profile Engine | v1.2 | Support for users in early dating who may be seeing multiple people. Culturally sensitive -- needs careful UX. |
| C-16 | Widget (Home Screen) | Core Infrastructure | v1.1 | Home screen widget showing today's action card and streak. High engagement potential but platform-specific development needed. |

---

### Won't Have (Not Now -- Explicitly Deferred)

These 12 features are explicitly out of scope for MVP with documented reasoning. They are acknowledged as valuable but would delay launch, add unmanageable complexity, or require capabilities not yet built.

---

| # | Feature | Reasoning | Earliest Consideration |
|---|---------|-----------|----------------------|
| W-01 | Community / Forum Module | Requires content moderation in 3 languages, community guidelines, abuse prevention, and dedicated community management. Massive operational overhead. Cannot be done responsibly at launch scale. | v1.2 (Phase 2) |
| W-02 | Expert Q&A (Relationship Coaches) | Requires hiring, vetting, and managing relationship coaches across 3 languages and cultures. Operational complexity is not compatible with MVP speed. | v1.3 (Phase 2) |
| W-03 | Smartwatch Companion App | Requires separate app development for Apple Watch and Wear OS. Phase 4 as per project plan. MVP must prove core value on phone first. | v2.0 (Phase 4) |
| W-04 | Couples Finance Tracking | Different product category entirely. Would fragment LOLO's positioning. Honeydue already serves this niche (and is free). | Not planned |
| W-05 | Video/Voice AI Coaching | Real-time voice or video AI coaching during arguments. Technically complex (real-time speech processing in 3 languages), privacy-invasive, and legally risky. | v2.0+ evaluation |
| W-06 | Partner-Facing Features (Her View) | Any feature where the partner sees or interacts with LOLO data. Violates the core "solo use" positioning and the "she won't know" value prop. Per female consultant: if she discovers it, it must be because of results, not because the app reached out to her. | Never (architectural decision) |
| W-07 | Social Sharing / Leaderboards | Public sharing of relationship scores or achievements. Violates privacy-first positioning and creates toxic comparison dynamics. | Never (design principle) |
| W-08 | Third-Party App Integrations (Phase 1) | Integrations with Spotify (shared playlists), Uber (date ride booking), etc. Nice-to-have but adds integration maintenance burden with no core value. | v1.3+ |
| W-09 | AI-Powered Couple Compatibility Analysis | "How compatible are you based on your zodiac signs?" -- risks reducing relationships to algorithmic scores. Female consultant flagged this as potentially harmful if taken seriously. | v1.2 (carefully) |
| W-10 | Augmented Reality Gift Preview | AR preview of gifts in physical space. Technically impressive but zero evidence of user demand and massive development cost. | Not planned |
| W-11 | Indonesian Language Support | Bahasa Indonesia is similar to Bahasa Melayu but has enough differences to require separate localization. Indonesia is a massive market (50M+ addressable men) but requires dedicated cultural adaptation. | v1.2 (high priority) |
| W-12 | Web App / Desktop Version | LOLO is a mobile-first, in-the-moment tool. Desktop usage patterns do not align with core use cases (SOS mode, quick messages, action cards). Between has desktop but it is a messaging app. | v2.0 evaluation |

---

## Part 2: RICE Scoring

RICE = (Reach x Impact x Confidence) / Effort

**Scoring Definitions:**
- **Reach:** Estimated number of users per quarter who will use this feature. Based on projected 100K users at end of Year 1, with quarterly active user estimates.
- **Impact:** 3 = Massive (changes user behavior), 2 = High (significant value add), 1 = Medium (nice improvement), 0.5 = Low (minor benefit), 0.25 = Minimal
- **Confidence:** 100% = Data-backed certainty, 80% = Strong conviction, 50% = Educated guess, 30% = Speculation
- **Effort:** Person-weeks to implement (design + frontend + backend + QA)

### Top 30 Features Ranked by RICE Score

| Rank | ID | Feature | Reach (users/qtr) | Impact | Confidence | Effort (pw) | RICE Score |
|------|-----|---------|-------------------|--------|------------|-------------|------------|
| 1 | M-13 | Core AI Message Generation Engine | 25,000 | 3 | 90% | 6 | 11,250 |
| 2 | M-18 | Daily Action Card Generation | 25,000 | 3 | 85% | 5 | 12,750 |
| 3 | M-02 | Core Onboarding Flow (5 Screens) | 25,000 | 3 | 95% | 3 | 23,750 |
| 4 | M-09 | Anniversary & Birthday Reminders | 22,000 | 2 | 95% | 3 | 13,933 |
| 5 | M-35 | Home Dashboard | 25,000 | 2 | 90% | 4 | 11,250 |
| 6 | M-29 | Daily Streak Counter | 20,000 | 2 | 85% | 2 | 17,000 |
| 7 | M-14 | 3 Free Message Modes | 20,000 | 2 | 90% | 4 | 9,000 |
| 8 | M-32 | Relationship Consistency Score | 18,000 | 2 | 80% | 3 | 9,600 |
| 9 | M-05 | Basic Partner Profile Creation | 25,000 | 2 | 90% | 3 | 15,000 |
| 10 | M-38 | Subscription & Paywall System | 25,000 | 2 | 95% | 5 | 9,500 |
| 11 | M-26 | SOS Mode Activation | 8,000 | 3 | 80% | 3 | 6,400 |
| 12 | M-16 | Trilingual Message Generation | 15,000 | 3 | 70% | 6 | 5,250 |
| 13 | M-37 | Push Notification System | 25,000 | 1 | 95% | 3 | 7,917 |
| 14 | M-30 | XP Points System | 18,000 | 1 | 85% | 2 | 7,650 |
| 15 | M-03 | Language Selection (EN/AR/MS) | 25,000 | 2 | 90% | 4 | 11,250 |
| 16 | M-19 | SAY Card Type | 20,000 | 2 | 85% | 2 | 17,000 |
| 17 | M-12 | Promise Tracker | 12,000 | 2 | 75% | 2 | 9,000 |
| 18 | M-23 | AI Gift Recommendation Core | 15,000 | 2 | 75% | 5 | 4,500 |
| 19 | M-10 | Islamic & Cultural Holiday Reminders | 10,000 | 2 | 85% | 3 | 5,667 |
| 20 | M-28 | Real-Time AI Coaching (SOS) | 8,000 | 3 | 70% | 5 | 3,360 |
| 21 | M-24 | Budget Filter & Low Budget High Impact | 12,000 | 2 | 80% | 3 | 6,400 |
| 22 | M-06 | Zodiac Sign Integration | 18,000 | 1 | 80% | 3 | 4,800 |
| 23 | S-07 | Ramadan Mode | 8,000 | 2 | 80% | 3 | 4,267 |
| 24 | S-05 | Weekly Summary Report | 18,000 | 1 | 80% | 2 | 7,200 |
| 25 | S-08 | Pregnancy Mode | 5,000 | 2 | 75% | 3 | 2,500 |
| 26 | M-34 | Wish List Capture | 15,000 | 1 | 80% | 2 | 6,000 |
| 27 | S-10 | App Lock (Biometric + PIN) | 15,000 | 1 | 90% | 1.5 | 9,000 |
| 28 | M-33 | Memory Entry Creation | 12,000 | 1 | 80% | 3 | 3,200 |
| 29 | S-01 | Family Member Profiles | 8,000 | 2 | 75% | 3 | 4,000 |
| 30 | M-08 | Cultural & Religious Context Settings | 10,000 | 2 | 80% | 3 | 5,333 |

### RICE Insights

**Top 5 by RICE Score (sorted):**

1. **M-02 Core Onboarding Flow** (23,750) -- Highest score because it touches every user, has massive impact on activation, and is relatively low effort. This is the single most important feature to get right.
2. **M-29 Daily Streak Counter** (17,000) -- High reach, proven impact from Duolingo model, and very low implementation effort. Best effort-to-value ratio in the backlog.
3. **M-19 SAY Card Type** (17,000) -- Tied for second. SAY cards are the most frequently completed card type based on persona analysis, and implementation is lightweight since it extends the action card framework.
4. **M-05 Basic Partner Profile** (15,000) -- Powers all personalization. Without this, every other feature is generic.
5. **M-09 Anniversary & Birthday Reminders** (13,933) -- Universal need across all personas. Core pain point for Marcus. Straightforward implementation.

**Highest Impact (Score = 3):**
- M-13: Core AI Message Generation Engine
- M-18: Daily Action Card Generation
- M-02: Core Onboarding Flow
- M-26: SOS Mode Activation
- M-16: Trilingual Message Generation
- M-28: Real-Time AI Coaching

**Best Effort-to-Value Ratio (Impact/Effort):**
- M-29: Daily Streak Counter (2/2 = 1.0 impact per person-week)
- M-30: XP Points System (1/2 = 0.5)
- M-19: SAY Card Type (2/2 = 1.0)
- M-12: Promise Tracker (2/2 = 1.0)

---

## Part 3: Sprint Allocation

### Team Assumptions

- **Frontend Engineers:** 2 (1 Android/Kotlin, 1 iOS/Swift -- or 2 KMM/Flutter if cross-platform)
- **Backend Engineers:** 2 (API, AI integration, database)
- **AI/ML Engineer:** 1 (prompt engineering, model routing, message quality)
- **UX/UI Designer:** 1 (Lina Vazquez)
- **QA Engineer:** 1
- **Product Manager:** 1 (Sarah Chen)

Each sprint is 2 weeks. Capacity per sprint: ~14 person-weeks of engineering (7 engineers x 2 weeks, accounting for meetings/overhead at 80% utilization).

---

### Sprint 1 (Weeks 9-10) -- Foundation

**Sprint Goal:** "A new user can create an account, complete onboarding, see a personalized home dashboard, and receive their first AI-generated action card in under 2 minutes."

| Feature ID | Feature | Owner | Effort (pw) | Priority |
|------------|---------|-------|-------------|----------|
| M-01 | Account Creation (Email/Google/Apple) | Backend 1 | 2 | P0 |
| M-02 | Core Onboarding Flow (5 Screens) | Frontend 1 + UX | 3 | P0 |
| M-03 | Language Selection (EN/AR/MS) | Frontend 2 | 2 | P0 |
| M-04 | Privacy & Notification Controls | Frontend 1 | 1 | P0 |
| M-05 | Basic Partner Profile Creation | Backend 2 + Frontend 2 | 3 | P0 |
| M-35 | Home Dashboard | Frontend 1 + Frontend 2 | 3 | P0 |
| M-36 | Bottom Navigation (5 Tabs) | Frontend 1 | 1 | P0 |
| M-37 | Push Notification System | Backend 1 | 2 | P0 |
| M-38 | Subscription & Paywall System | Backend 2 | 3 | P0 |

**Total Effort:** ~20 person-weeks
**Capacity:** 14 person-weeks (engineering) + 2 person-weeks (UX)
**Risk Mitigation:** M-38 (Subscription) is the highest-risk item. Begin Google Play Billing / Apple StoreKit integration on Day 1. RTL layout (M-03) requires early frontend architecture decisions that affect all subsequent sprints.

**Sprint 1 Deliverable:** Working app shell with authentication, onboarding, home screen, navigation, and notification infrastructure. No AI features yet -- the onboarding "first action card" in Sprint 1 uses a templated (not AI-generated) message as a placeholder until the AI engine is built in Sprint 2.

**Dependencies:** None (Sprint 1 is foundational)

---

### Sprint 2 (Weeks 11-12) -- Core Features

**Sprint Goal:** "Users can build a detailed partner profile with zodiac integration, set up smart reminders for key dates, earn XP and track streaks, and generate their first AI-powered message."

| Feature ID | Feature | Owner | Effort (pw) | Priority |
|------------|---------|-------|-------------|----------|
| M-06 | Zodiac Sign Integration | Backend 2 | 2 | P0 |
| M-07 | Partner Preferences & Interests | Frontend 2 + Backend 2 | 3 | P0 |
| M-08 | Cultural & Religious Context | Backend 2 | 2 | P0 |
| M-09 | Anniversary & Birthday Reminders | Backend 1 | 2 | P0 |
| M-10 | Islamic & Cultural Holiday Reminders | Backend 1 | 2 | P0 |
| M-11 | Custom Reminder Creation | Frontend 1 + Backend 1 | 2 | P0 |
| M-13 | Core AI Message Generation Engine | AI Engineer + Backend 2 | 4 | P0 |
| M-14 | 3 Free Message Modes | AI Engineer | 2 | P0 |
| M-29 | Daily Streak Counter | Frontend 1 | 1 | P0 |
| M-30 | XP Points System | Backend 1 + Frontend 1 | 1.5 | P0 |
| M-31 | Level Progression System | Frontend 1 | 1 | P1 |
| S-10 | App Lock (Biometric + PIN) | Frontend 2 | 1 | P1 |
| S-11 | Settings & Preferences Screen | Frontend 2 | 1 | P1 |

**Total Effort:** ~24.5 person-weeks
**Capacity:** 14 person-weeks (engineering) + 2 (AI) + 2 (UX) = 18 person-weeks
**Risk Mitigation:** M-13 (AI Message Engine) is the highest-risk, highest-impact item. AI Engineer begins prompt engineering and model integration on Day 1. API latency target: <5 seconds per message generation. Backend 2 builds the API layer while AI Engineer tunes prompts in parallel.

**Sprint 2 Deliverable:** Partner profile with zodiac defaults, smart reminders with Islamic calendar, working AI message generator with 3 modes, gamification system with streaks/XP/levels. First end-to-end user flow: onboard -> build profile -> set reminder -> generate message -> earn XP.

**Dependencies on Sprint 1:**
- M-06/07/08 depend on M-05 (Partner Profile schema)
- M-09/10/11 depend on M-37 (Push Notification System)
- M-13/14 depend on M-05 (profile data for personalization)
- M-29/30/31 depend on M-35 (Home Dashboard for display)

---

### Sprint 3 (Weeks 13-14) -- AI Engine & Smart Actions

**Sprint Goal:** "Users receive daily personalized action cards across 4 types (SAY/DO/BUY/GO), can generate messages in all 10 modes and 3 languages, log memories and wishes, and see their Relationship Consistency Score."

| Feature ID | Feature | Owner | Effort (pw) | Priority |
|------------|---------|-------|-------------|----------|
| M-15 | 7 Pro/Legend Message Modes | AI Engineer | 3 | P0 |
| M-16 | Trilingual Message Generation | AI Engineer + Backend 1 | 4 | P0 |
| M-17 | Message Tone & Length Controls | Frontend 1 | 1 | P0 |
| M-18 | Daily Action Card Generation | AI Engineer + Backend 2 | 3 | P0 |
| M-19 | SAY Card Type | Frontend 1 | 1 | P0 |
| M-20 | DO Card Type | Frontend 1 | 1 | P0 |
| M-21 | BUY Card Type | Frontend 2 + Backend 2 | 2 | P0 |
| M-22 | GO Card Type | Frontend 2 | 1 | P0 |
| M-23 | AI Gift Recommendation Core | AI Engineer + Backend 2 | 3 | P0 |
| M-24 | Budget Filter & Low Budget High Impact | Frontend 2 + Backend 2 | 2 | P0 |
| M-12 | Promise Tracker | Backend 1 + Frontend 1 | 2 | P0 |
| M-32 | Relationship Consistency Score | Backend 1 | 2 | P0 |
| M-33 | Memory Entry Creation | Frontend 2 + Backend 1 | 2 | P0 |
| M-34 | Wish List Capture | Frontend 2 | 1 | P0 |
| S-12 | Onboarding Tooltips | Frontend 1 | 1 | P1 |
| S-13 | Calendar Sync | Backend 1 | 2 | P1 |
| S-14 | Message Mode Quick-Switch | Frontend 1 | 0.5 | P1 |
| S-16 | Action Card Feedback | Frontend 2 | 0.5 | P1 |
| S-17 | Profile Completion Incentives | Frontend 1 | 0.5 | P1 |

**Total Effort:** ~32 person-weeks
**Capacity:** 18 person-weeks
**Risk Mitigation:** This is the most ambitious sprint. Prioritize P0 items (Must Have) and allow P1 items (Should Have) to slip to Sprint 4 if needed. M-16 (Trilingual) is the highest-risk item -- Arabic and Malay message quality MUST be validated by native speakers before Sprint 3 ends. Schedule cultural advisor reviews on Days 8-10 of the sprint.

**Sprint 3 Deliverable:** Full action card system, complete AI message generator with all 10 modes in 3 languages, gift engine core, memory vault, and consistency score. The app is now feature-complete for its core value proposition.

**Dependencies on Sprint 2:**
- M-15/16/17 depend on M-13/14 (AI engine infrastructure)
- M-18-22 depend on M-05/06/07/08 (profile data for personalization)
- M-23/24 depend on M-07 (partner preferences for gift relevance)
- M-32 depends on M-29/30 (streak/XP data inputs)

---

### Sprint 4 (Weeks 15-16) -- SOS Mode, Polish & Launch Readiness

**Sprint Goal:** "SOS Mode is live and responsive in under 3 seconds. All remaining Must Have and Should Have features are complete. The app is polished, localized, and ready for closed beta."

| Feature ID | Feature | Owner | Effort (pw) | Priority |
|------------|---------|-------|-------------|----------|
| M-25 | Occasion-Based Gift Packages | AI Engineer + Frontend 2 | 3 | P0 |
| M-26 | SOS Mode Activation | Frontend 1 + Backend 1 | 2 | P0 |
| M-27 | Crisis Scenario Selection | Frontend 1 + AI Engineer | 2 | P0 |
| M-28 | Real-Time AI Coaching Response | AI Engineer + Backend 2 | 3 | P0 |
| S-01 | Family Member Profiles | Frontend 2 + Backend 2 | 2 | P1 |
| S-02 | Wish List Auto-Surfacing | Backend 2 | 1 | P1 |
| S-03 | AI Message History & Favorites | Frontend 1 + Backend 1 | 1.5 | P1 |
| S-04 | Action Card Completion History | Frontend 2 | 1 | P1 |
| S-05 | Weekly Summary Report | Backend 1 + Frontend 1 | 2 | P1 |
| S-06 | Gift Feedback Loop | Frontend 2 + Backend 2 | 1 | P1 |
| S-07 | Ramadan Mode | AI Engineer + Backend 1 | 2 | P1 |
| S-08 | Pregnancy Mode | AI Engineer + Backend 2 | 2 | P1 |
| S-09 | Offline Mode (Basic) | Backend 1 + Frontend 1 | 2 | P2 |
| S-15 | Gift Engine Regional Affiliates | Backend 2 | 2 | P2 |
| S-18 | Data Export (Privacy Compliance) | Backend 1 | 1.5 | P2 |
| -- | Bug fixes, performance optimization, localization QA | All | 4 | P0 |

**Total Effort:** ~32 person-weeks
**Capacity:** 18 person-weeks
**Risk Mitigation:** SOS Mode (M-26/27/28) is the P0 deliverable. If capacity is tight, P2 items (S-09, S-15, S-18) slip to v1.0.1 fast-follow release. Dedicate final 3 days of sprint to localization QA across all 3 languages with native speakers.

**Sprint 4 Deliverable:** Feature-complete MVP with SOS Mode, gift packages, and enhanced gamification. All Should Have features complete (or documented as fast-follow). App ready for closed beta deployment.

**Dependencies on Sprint 3:**
- M-25 depends on M-23/24 (Gift Engine core)
- M-26/27/28 depends on M-13 (AI engine) and M-05 (profile data)
- S-01 depends on M-05 (profile schema extensibility)
- S-07/08 depend on M-18 (action card system) and M-08 (cultural context)

---

### Sprint Capacity Summary

| Sprint | Planned Effort (pw) | Available Capacity (pw) | Overflow | Mitigation |
|--------|---------------------|-------------------------|----------|------------|
| Sprint 1 | 20 | 16 | +4 | Push M-38 paywall polish to Sprint 2. Use templated first action card instead of AI-generated. |
| Sprint 2 | 24.5 | 18 | +6.5 | M-31 (Level System) and S-11 (Settings) can be simplified. Levels can ship with basic UI. |
| Sprint 3 | 32 | 18 | +14 | P1 items (S-12 through S-17) may slip to Sprint 4. Core P0 items total ~26 pw -- still tight. Consider extending Sprint 3 by 2-3 days or reducing scope. |
| Sprint 4 | 32 | 18 | +14 | P2 items (S-09, S-15, S-18) slip to v1.0.1. SOS Mode is non-negotiable. Bug-fix buffer is essential. |

**Recommendation:** Sprints 3 and 4 are significantly over-capacity. Two options:
1. **Add 1-2 engineers** from Week 11 onward (contracted or moved from other projects)
2. **Move Should Have P1 items** from Sprints 3 and 4 to a dedicated Sprint 5 (Weeks 17-18) before closed beta

I recommend Option 2: add a Sprint 5 (Weeks 17-18) as a "Polish & Should Have" sprint, keeping Sprints 3-4 focused on Must Have delivery only. This preserves quality while extending the timeline by only 2 weeks.

---

## Part 4: Monetization Feature Matrix

### Feature-to-Tier Mapping

| Feature | Free | Pro ($6.99/mo) | Legend ($12.99/mo) |
|---------|:----:|:---------------:|:------------------:|
| **ONBOARDING & ACCOUNT** | | | |
| Account creation | Yes | Yes | Yes |
| Core onboarding | Yes | Yes | Yes |
| Language selection (EN/AR/MS) | Yes | Yes | Yes |
| Privacy controls | Yes | Yes | Yes |
| Biometric app lock | Yes | Yes | Yes |
| **HER PROFILE** | | | |
| Basic partner profile | Yes | Yes | Yes |
| Zodiac integration | Yes | Yes | Yes |
| Preferences & interests | Limited (5 fields) | Full | Full |
| Cultural & religious context | Yes | Yes | Yes |
| Family member profiles | -- | 3 members | Unlimited |
| **SMART REMINDERS** | | | |
| Anniversary & birthday reminders | 3 dates | 10 dates | Unlimited |
| Islamic/cultural holiday reminders | Yes | Yes | Yes |
| Custom reminders | 5 active | 15 active | 30 active |
| Promise tracker | 3 promises | 10 promises | 20 promises |
| Calendar sync | -- | Yes | Yes |
| **AI MESSAGE GENERATOR** | | | |
| Message generation | 5/month | 30/month | Unlimited |
| Good Morning mode | Yes | Yes | Yes |
| Appreciation mode | Yes | Yes | Yes |
| Romance mode | Yes | Yes | Yes |
| Apology & Reconciliation | -- | Yes | Yes |
| Missing You | -- | Yes | Yes |
| Celebration | -- | Yes | Yes |
| Comfort & Reassurance | -- | Yes | Yes |
| Flirting & Playful | -- | Yes | Yes |
| Deep Conversation | -- | Yes | Yes |
| "Just Because" | -- | Yes | Yes |
| Tone & length controls | Basic | Full | Full |
| Message history | Last 5 | Last 30 | Unlimited |
| Trilingual generation | Yes | Yes | Yes |
| **SMART ACTION CARDS** | | | |
| Daily action cards | 1/day | 3/day | 5/day + custom |
| SAY cards | Yes | Yes | Yes |
| DO cards | Yes | Yes | Yes |
| BUY cards | Basic | Full (with affiliate links) | Full |
| GO cards | Yes | Yes | Yes |
| Action card history | -- | Last 14 days | Unlimited |
| Card feedback ("Not relevant") | -- | Yes | Yes |
| **GIFT ENGINE** | | | |
| Gift recommendations | 2 requests/month | 10/month | Unlimited |
| Budget filter | Yes | Yes | Yes |
| Low Budget High Impact mode | Yes | Yes | Yes |
| Occasion-based packages | -- | Yes | Yes |
| Affiliate purchase links | -- | Yes | Yes |
| Gift feedback loop | -- | Yes | Yes |
| **SOS MODE** | | | |
| SOS activation | 1/month | 3/month | Unlimited |
| Crisis scenario selection | Yes | Yes | Yes |
| AI coaching response | Basic (cached tips) | Standard AI | Premium AI (deeper analysis) |
| **GAMIFICATION** | | | |
| Daily streak | Yes | Yes | Yes |
| XP points | Yes | Yes | Yes |
| Level progression | Yes | Yes | Yes |
| Relationship Consistency Score | Yes | Yes | Yes |
| Weekly summary report | -- | Yes | Yes |
| Streak freeze (1/month) | -- | -- | Yes |
| **MEMORY VAULT** | | | |
| Memory entries | 10 max | 50 max | Unlimited |
| Wish list items | 5 max | 20 max | Unlimited |
| Photos per memory | 1 | 5 | Unlimited |
| Wish list auto-surfacing | -- | Yes | Yes |

### Value Differentiation Analysis

**Free Tier Purpose:** Demonstrate core value and drive activation. The free tier must be generous enough that users experience the "aha moment" (first AI message, first action card, first streak) but limited enough that regular users hit walls within 1-2 weeks.

**Free-to-Pro Conversion Triggers:**
1. Hit 5 AI message monthly limit (Day 7-14 for active users)
2. Want Apology or Comfort modes during an emotional moment (urgency-driven)
3. Want more than 1 action card per day (engagement-driven)
4. Want more than 3 date reminders (utility-driven)

**Pro-to-Legend Conversion Triggers:**
1. Want unlimited AI messages (power user)
2. Want unlimited SOS Mode (anxiety-driven -- "I need this available whenever")
3. Want premium AI coaching in SOS Mode (quality-driven)
4. Want streak freeze (loss aversion -- protecting a long streak)
5. Want unlimited memories and family profiles (data investment -- lock-in)

**Pricing Psychology:**
- Free -> Pro: $6.99/mo is "less than a coffee date" -- framed as investment in relationship
- Pro -> Legend: $12.99/mo is "less than one mediocre gift" -- framed as ROI on thoughtfulness
- Annual Pro: $59.99/yr ($5/mo effective) -- positioned as "best value" for price-sensitive users
- Annual Legend: $109.99/yr ($9.17/mo effective) -- positioned for committed users

**Regional Pricing:**
| Tier | US / GCC | Malaysia |
|------|----------|----------|
| Pro Monthly | $6.99 / AED 25.99 | RM 14.90 |
| Pro Annual | $59.99 / AED 219.99 | RM 119 |
| Legend Monthly | $12.99 / AED 47.99 | RM 26.90 |
| Legend Annual | $109.99 / AED 399.99 | RM 219 |

---

## Part 5: Localization Priority

### Trilingual MVP Features (Must Ship in EN/AR/MS)

These features involve user-facing text, AI-generated content, or cultural context that MUST be localized for all three languages at launch.

| Feature | Localization Effort (EN) | Localization Effort (AR) | Localization Effort (MS) | Notes |
|---------|:------------------------:|:------------------------:|:------------------------:|-------|
| Core Onboarding Flow | Baseline | 2 days (RTL layout + translation) | 1 day (translation) | Arabic requires full RTL design review |
| Language Selection UI | Baseline | 0.5 day | 0.5 day | Simple picker -- minimal text |
| Home Dashboard | Baseline | 2 days (RTL layout) | 1 day | Dashboard layout inverts for RTL |
| Bottom Navigation | Baseline | 1 day (RTL mirror + labels) | 0.5 day (labels) | Tab order mirrors in RTL |
| AI Message Generator (all modes) | Baseline | 5 days (prompt engineering + dialect tuning + native review) | 4 days (prompt engineering + colloquial tuning + native review) | **Highest localization effort.** Message quality in AR/MS is the single biggest driver of success in those markets. |
| Smart Action Cards (all types) | Baseline | 3 days (cultural calibration + translation) | 2 days (cultural calibration + translation) | Cards must reference culturally appropriate actions per market |
| Smart Reminders (including Islamic calendar) | Baseline | 2 days (Hijri calendar integration + RTL) | 1.5 days (Hijri calendar + Malaysian holidays) | Islamic calendar logic is shared between AR and MS |
| Her Profile (including cultural context) | Baseline | 2 days (cultural options + RTL) | 1 day (cultural options) | Cultural dropdown values differ per market |
| Gift Engine | Baseline | 3 days (cultural gift norms + currency + affiliates) | 2 days (Malaysian gift norms + currency + affiliates) | Gift suggestions are heavily culture-dependent |
| SOS Mode | Baseline | 3 days (crisis coaching in Gulf Arabic + cultural norms) | 2 days (crisis coaching in Malay + indirect communication awareness) | SOS responses must reflect cultural communication styles |
| Gamification text | Baseline | 1 day | 1 day | Streak, XP, level names -- straightforward translation |
| Push Notifications | Baseline | 1 day | 1 day | Notification copy in each language |
| Subscription & Paywall screens | Baseline | 1 day (RTL + regional pricing) | 0.5 day (regional pricing) | Pricing displayed in local currency |
| **Total Localization Effort** | -- | **~26 days** | **~18 days** | Arabic is 40% more effort due to RTL requirements |

### Features That Can Launch English-Only First

These features are lower-priority for localization and can launch in English with AR/MS following in v1.0.1 or v1.0.2.

| Feature | Reason for EN-Only Launch | Target Localization Release |
|---------|--------------------------|----------------------------|
| Family Member Profiles (S-01) | Should Have, not Must Have. Arabic/Malay users can use the feature in English temporarily. | v1.0.1 |
| Weekly Summary Report (S-05) | Report format is standardized. Numbers and charts are language-agnostic. | v1.0.1 |
| Message History (S-03) | Historical messages are already in the user's language. UI chrome is minimal. | v1.0.1 |
| Action Card History (S-04) | Past cards are already localized. History UI is list-based with minimal new text. | v1.0.1 |
| Data Export (S-18) | Technical/compliance feature. Export format is data-centric, not language-centric. | v1.0.2 |
| Onboarding Tooltips (S-12) | Low text volume. Can ship EN-only and localize quickly. | v1.0.1 |
| Gift Feedback Loop (S-06) | Simple UI: "Did she like it?" with emoji reactions. Near-universal. | v1.0.1 |

### Localization Effort Estimates by Sprint

| Sprint | Total Localization Effort (AR) | Total Localization Effort (MS) | Localization Owner |
|--------|-------------------------------|-------------------------------|-------------------|
| Sprint 1 | 5.5 days (onboarding, dashboard, nav, notifications) | 3.5 days | UX Designer + Arabic Cultural Advisor |
| Sprint 2 | 8 days (profile, reminders, message engine, gamification) | 6 days | UX Designer + Malay Cultural Advisor |
| Sprint 3 | 8 days (action cards, gift engine, memory vault, trilingual AI) | 6 days | AI Engineer + Cultural Advisors |
| Sprint 4 | 4.5 days (SOS mode, gift packages, polish) | 2.5 days | AI Engineer + Cultural Advisors |
| **Total** | **26 days** | **18 days** | |

### Localization Quality Gates

1. **AI Message Quality:** Every AI-generated message in Arabic and Malay must be reviewed by a native speaker before the mode goes live. Minimum 20 sample messages per mode per language, rated on a 1-5 scale for naturalness, cultural appropriateness, and emotional tone. Pass threshold: average 4.0/5.0.

2. **RTL Layout Review:** Every screen must be reviewed in Arabic RTL mode by the UX designer and an Arabic-speaking tester. Checklist: text alignment, icon mirroring, number formatting, calendar direction, input field cursor position, scroll direction.

3. **Cultural Sensitivity Review:** Gift suggestions, action cards, and SOS coaching responses for Arabic and Malay markets must be reviewed by cultural advisors for: religious appropriateness, family hierarchy norms, gender role sensitivity, and dialect accuracy.

4. **Regression Testing:** Any localization change triggers a regression test in all 3 languages to ensure no string overflow, layout breakage, or encoding issues.

---

## Summary & Next Steps

### Key Takeaways

1. **38 Must Have features** across 10 modules define the MVP. The three highest-priority features by RICE score are: Core Onboarding Flow, Daily Streak Counter, and SAY Card Type. The three highest-effort features are: Trilingual Message Generation, Core AI Message Engine, and SOS Real-Time Coaching.

2. **Sprints 3 and 4 are over-capacity.** Recommend adding a Sprint 5 (Weeks 17-18) for Should Have features and localization polish, or adding 1-2 contract engineers from Week 11.

3. **Arabic localization is the largest non-engineering workload.** RTL layout, Gulf dialect AI tuning, Islamic calendar integration, and cultural gift/action calibration require dedicated cultural advisor time throughout all 4 sprints.

4. **The free tier is generous by design.** It must deliver enough value to create habit (streak, daily action card, limited messages) while creating natural paywall triggers (message limit, mode restrictions, SOS limits) that convert at 5-15% depending on market.

5. **SOS Mode is the "insurance policy" feature** -- most users will rarely use it, but the ones who do will consider it indispensable. Its existence drives Legend tier upgrades and word-of-mouth.

6. **Gift Engine is both a user feature and a revenue engine.** Affiliate links in gift recommendations are value-additive (not ad-like) and should be integrated from Sprint 4 at latest.

### Immediate Next Steps

| Action | Owner | Deadline |
|--------|-------|----------|
| Review backlog with engineering leads for effort validation | Sarah Chen + Tech Lead | Week 8, Day 3 |
| Finalize Sprint 1 tickets in project management tool | Sarah Chen | Week 8, Day 5 |
| Begin Arabic cultural advisor engagement | Sarah Chen | Week 8, Day 1 |
| Begin Malay cultural advisor engagement | Sarah Chen | Week 8, Day 1 |
| AI prompt engineering kickoff (message modes) | AI Engineer | Week 9, Day 1 |
| RTL architecture decision (Flutter/KMM approach) | Frontend Lead | Week 8, Day 3 |
| Affiliate partnership outreach (Amazon, Noon, Shopee) | Business Development | Week 10 |
| Closed beta user recruitment (50 users per market) | Marketing Lead | Weeks 12-14 |

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | February 14, 2026 | Sarah Chen, Product Manager | Initial MoSCoW backlog with RICE scoring, sprint allocation, monetization matrix, and localization priority |

---

*Sarah Chen, Product Manager*
*LOLO -- "She won't know why you got so thoughtful. We won't tell."*

---

### References

- LOLO Competitive Analysis Report (Sarah Chen, February 2026)
- LOLO User Personas & Journey Maps (Sarah Chen, February 2026)
- LOLO Competitive UX/UI Audit (Lina Vazquez, February 2026)
- LOLO App Concept Validation -- Female Perspective (Nadia Khalil, February 2026)
- LOLO Emotional State Framework (Dr. Elena Vasquez, February 2026)
- LOLO Zodiac Master Profiles (Astrologist Advisory, February 2026)
- RICE Prioritization Framework (Intercom, adapted)
- MoSCoW Method (DSDM Consortium)
