# LOLO Final Sprint Plan -- Phase 1 Completion & Development Roadmap (Weeks 9-16)

**Prepared by:** Sarah Chen, Product Manager
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Status:** FINAL -- All Phase 1 Discovery deliverables reviewed and cross-referenced

---

## Table of Contents

1. [Section 1: Phase 1 Completion Checklist](#section-1-phase-1-completion-checklist)
2. [Section 2: Sprint Plan (Weeks 9-16)](#section-2-sprint-plan-weeks-9-16)
   - [Sprint 1 (Weeks 9-10) -- Foundation](#sprint-1-weeks-9-10--foundation)
   - [Sprint 2 (Weeks 11-12) -- Core Features](#sprint-2-weeks-11-12--core-features)
   - [Sprint 3 (Weeks 13-14) -- AI Engine](#sprint-3-weeks-13-14--ai-engine)
   - [Sprint 4 (Weeks 15-16) -- Smart Actions + Polish](#sprint-4-weeks-15-16--smart-actions--polish)
3. [Section 3: Resource Allocation](#section-3-resource-allocation)
4. [Section 4: Risk Register](#section-4-risk-register)
5. [Section 5: Definition of Done](#section-5-definition-of-done)
6. [Section 6: Phase 2 Preview](#section-6-phase-2-preview)

---

## Section 1: Phase 1 Completion Checklist

### 1.1 Deliverable Review Status

All 23 Phase 1 Discovery deliverables have been reviewed, validated for completeness, and cross-referenced for internal consistency. The table below confirms the status of each deliverable and its downstream consumers.

| # | Deliverable | Author | Status | Consumed By |
|---|-------------|--------|--------|-------------|
| 1 | Competitive Analysis | Sarah Chen (PM) | COMPLETE | Feature Backlog, User Personas, Architecture |
| 2 | Competitive UX Audit | Lina Vazquez (UX) | COMPLETE | Design System, Wireframes, User Personas |
| 3 | Emotional State Framework | Dr. Elena Vasquez (PSY) | COMPLETE | AI Strategy, Prompt Templates, AI Content Guidelines, Situation-Response Matrix |
| 4 | Zodiac Master Profiles | Astrologist Advisory | COMPLETE | AI Strategy, Prompt Templates, Sign Cheat Sheets, Compatibility Pairings |
| 5 | App Concept Validation | Nadia Khalil (FC) | COMPLETE | Feature Backlog, User Personas |
| 6 | User Personas | Sarah Chen (PM) | COMPLETE | Feature Backlog, Wireframes, AI Strategy, Design System |
| 7 | Sign Cheat Sheets | Astrologist Advisory | COMPLETE | AI Prompt Templates, Action Card Validation |
| 8 | Situation-Response Matrix | Dr. Elena Vasquez (PSY) | COMPLETE | AI Strategy (SOS Mode), AI Content Guidelines, Action Card Validation |
| 9 | Feature Backlog (MoSCoW) | Sarah Chen (PM) | COMPLETE | Sprint Plan (this document), Architecture, Wireframes |
| 10 | Architecture Document | Omar Al-Rashidi (TL) | COMPLETE | Sprint Plan, Localization Architecture, AI Strategy |
| 11 | Localization Architecture | Omar Al-Rashidi (TL) | COMPLETE | Multi-Language Prompt Strategy, Design System, Wireframes |
| 12 | "What She Actually Wants" | Nadia Khalil (FC) | COMPLETE | AI Prompt Templates, Action Card Validation, Gift Feedback Framework |
| 13 | Arabic Women's Perspective | Nadia Khalil (FC) | COMPLETE | Multi-Language Prompt Strategy, Cultural Sensitivity Guide, Localization Architecture |
| 14 | Malay Women's Perspective | Nadia Khalil (FC) | COMPLETE | Multi-Language Prompt Strategy, Cultural Sensitivity Guide, Localization Architecture |
| 15 | Compatibility Pairings | Astrologist Advisory | COMPLETE | AI Prompt Templates (zodiac-aware messages) |
| 16 | Wireframe Specs | Lina Vazquez (UX) | COMPLETE | Design System, Sprint Plan, Architecture |
| 17 | AI Strategy | Dr. Aisha Mahmoud (AI/ML) | COMPLETE | Multi-Language Prompt Strategy, Architecture, Sprint Plan |
| 18 | Multi-Language Prompt Strategy | Dr. Aisha Mahmoud (AI/ML) | COMPLETE | Sprint Plan, Localization Architecture |
| 19 | Cultural Sensitivity Guide | Nadia Khalil (FC) | COMPLETE | AI Content Guidelines, Multi-Language Prompt Strategy, Action Card Validation |
| 20 | Gift Feedback Framework | Nadia Khalil (FC) | COMPLETE | Feature Backlog (Gift Engine), AI Strategy |
| 21 | Action Card Validation | Nadia Khalil (FC) | COMPLETE | Feature Backlog (Action Cards), AI Strategy |
| 22 | AI Content Guidelines | Dr. Elena Vasquez (PSY) | COMPLETE | AI Strategy, Multi-Language Prompt Strategy, Sprint Plan |
| 23 | Design System + UI String Catalog | Lina Vazquez (UX) | COMPLETE | Wireframes, Localization Architecture, Sprint Plan |

### 1.2 Dependency Map Validation

All inter-document dependencies have been verified. The dependency graph flows cleanly through four tiers:

```
TIER 1 -- Research & Analysis (Inputs)
  Competitive Analysis --> Feature Backlog, User Personas
  Competitive UX Audit --> Design System, Wireframes
  App Concept Validation --> Feature Backlog, User Personas
  Emotional State Framework --> AI Strategy, AI Content Guidelines

TIER 2 -- Domain Expert Frameworks (Intelligence Layer)
  Zodiac Master Profiles --> Sign Cheat Sheets, Compatibility Pairings, AI Prompts
  Situation-Response Matrix --> SOS Mode AI, Action Cards
  "What She Actually Wants" --> Action Card Validation, Gift Feedback Framework
  Arabic Women's Perspective --> Multi-Language Prompts, Cultural Sensitivity
  Malay Women's Perspective --> Multi-Language Prompts, Cultural Sensitivity

TIER 3 -- Product Definition (Blueprint Layer)
  User Personas --> Feature Backlog, Wireframes, AI Strategy
  Feature Backlog (MoSCoW) --> Sprint Plan, Architecture, Wireframes
  Architecture Document --> Localization Architecture, AI Strategy
  Design System --> Wireframes, UI String Catalog

TIER 4 -- Implementation Specs (Execution Layer)
  Wireframe Specs (43 screens) --> Sprint tasks
  AI Strategy (multi-model router) --> Sprint 3 AI engine work
  Multi-Language Prompt Strategy --> Sprint 3 trilingual generation
  Localization Architecture (ARB + RTL) --> Sprint 1 foundation
  AI Content Guidelines --> Sprint 3-4 content safety
  UI String Catalog (500+ strings) --> Sprint 1-4 localization
```

### 1.3 Gap Analysis

- [x] Each deliverable reviewed and cross-referenced -- all 23 confirmed complete
- [x] All dependencies mapped -- no orphan documents, no circular dependencies
- [x] No gaps between deliverables -- full coverage from research through implementation specs
- [x] Architecture supports all 10 modules -- Clean Architecture with Riverpod, 10 feature modules mapped to folder structure (confirmed in Architecture Document Section 3)
- [x] Localization supports all 3 languages -- ARB files, RTL layout system, two-layer localization (UI + AI native generation) confirmed in Localization Architecture
- [x] All domain expert frameworks complete -- Emotional State Framework (6 hormonal contexts, 10 emotional states), Zodiac (12 signs x 10 dimensions), Situation-Response Matrix (55+ situations), Cultural perspectives (Arabic + Malay), AI Content Guidelines (safety protocol), Action Card Validation (30+ validated scenarios)

**Gap Resolution Notes:**

| Potential Gap | Status | Resolution |
|---------------|--------|------------|
| Zodiac data coverage for all 12 signs | RESOLVED | 12 signs x 10 dimensions each confirmed in zodiac-master-profiles.md |
| 144 compatibility pairings | RESOLVED | 12 x 12 matrix complete in compatibility-pairings.md |
| Arabic dialect handling (Gulf vs. MSA vs. Egyptian) | RESOLVED | Multi-Language Prompt Strategy Section 13 defines Gulf as primary, MSA as fallback, Egyptian/Levantine as selectable options |
| AI safety for crisis/SOS content | RESOLVED | AI Content Guidelines Section 4 defines crisis protocol; no medical advice, no diagnostic language, mandatory professional referral triggers |
| Gift Engine cultural restrictions | RESOLVED | Cultural Sensitivity Guide + Arabic/Malay Women's Perspective documents define culturally inappropriate gift categories per market |
| Wireframe-to-Design-System consistency | RESOLVED | Design System tokens (colors, typography, spacing) match values used in all 43 wireframes |
| UI String Catalog completeness | RESOLVED | 500+ strings cover all 43 wireframe screens across 10 modules |

---

## Section 2: Sprint Plan (Weeks 9-16)

### Team Roster

| Role | Name | Availability | Primary Skills |
|------|------|-------------|----------------|
| Product Manager | Sarah Chen | Full-time | Product strategy, sprint management, stakeholder communication |
| Tech Lead / Flutter Dev | Omar Al-Rashidi | Full-time | Flutter, Dart, Clean Architecture, Riverpod, Firebase |
| Frontend Engineer 1 | TBD (FE-1) | Full-time | Flutter, UI components, animations, state management |
| Frontend Engineer 2 | TBD (FE-2) | Full-time | Flutter, RTL layout, platform integrations (billing, biometrics) |
| Backend Engineer 1 | TBD (BE-1) | Full-time | Firebase Cloud Functions, Firestore, FCM, authentication |
| Backend Engineer 2 | TBD (BE-2) | Full-time | API design, PostgreSQL, Redis, third-party integrations |
| AI/ML Engineer | Dr. Aisha Mahmoud | Full-time | Prompt engineering, multi-model routing, LLM API integration |
| UX/UI Designer | Lina Vazquez | Full-time | UI implementation support, design QA, localization review |
| QA Engineer | TBD (QA-1) | Full-time | Manual + automated testing, localization QA, RTL testing |

**Capacity per sprint (2 weeks):** 7 engineers x 2 weeks x 80% utilization = ~11.2 person-weeks of engineering + 2 pw (UX) + 2 pw (QA) = ~15.2 effective person-weeks per sprint.

---

### Sprint 1 (Weeks 9-10) -- Foundation

**Sprint Goal:** "A new user can download LOLO, select their language, create an account, complete onboarding, build a basic partner profile, and land on a personalized home dashboard with bottom navigation -- all within 2 minutes."

**Sprint Theme:** App shell, authentication, data layer, navigation skeleton, notification infrastructure, subscription plumbing.

---

#### Task S1-01: Project Scaffolding & Architecture Setup

| Field | Detail |
|-------|--------|
| **Owner** | Omar Al-Rashidi (Tech Lead) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | Architecture Document (v1.0), Localization Architecture (v1.0), Design System (v1.0) |
| **Acceptance Criteria** | (1) Flutter project initialized with Clean Architecture folder structure per Architecture Document Section 3. (2) Riverpod configured as sole state management solution. (3) GoRouter configured with all route stubs for 43 screens. (4) Dio HTTP client configured with interceptors (auth, logging, error handling). (5) Hive/Isar local storage initialized. (6) ARB localization infrastructure configured per Localization Architecture Section 2 with `app_en.arb`, `app_ar.arb`, `app_ms.arb` template files. (7) Theme system initialized with Design System tokens (colors, typography, spacing). (8) CI/CD pipeline configured (build, lint, test). |
| **Deliverable** | Buildable Flutter project with empty screens, routing, and infrastructure wired |

#### Task S1-02: Account Creation (Email / Google / Apple Sign-In)

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (backend) + FE-2 (frontend) |
| **Effort** | 8 story points / 24 hours |
| **Dependencies** | S1-01 (project scaffolding), Architecture Document Section 7 (Auth & Security) |
| **Acceptance Criteria** | (1) Firebase Auth integrated with email/password, Google Sign-In, and Apple Sign-In. (2) Account creation completes in under 3 taps. (3) No email verification required before first use (verify in background). (4) Password stored with bcrypt hashing; all auth tokens encrypted at rest. (5) Duplicate account detection (same email across providers). (6) Auth state persists across app restarts via secure token storage. (7) Logout clears all local auth state. |
| **Deliverable** | Working authentication flow with 3 sign-in methods |

#### Task S1-03: Language Selection Screen (EN/AR/MS)

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S1-01 (ARB infrastructure), Wireframe Spec Screen 1, Localization Architecture Section 1 |
| **Acceptance Criteria** | (1) Language picker appears as first screen before account creation. (2) Three options displayed: English, Arabic (with flag), Bahasa Melayu (with flag). (3) Selection triggers full locale change via `LocaleNotifier` (no app restart). (4) Arabic selection triggers RTL `Directionality` wrapper at MaterialApp root. (5) System language auto-detection with manual override. (6) Selected language persisted to Hive and Firestore user record. (7) Layout matches Wireframe Spec Screen 1 exactly. |
| **Deliverable** | Language selection screen with runtime locale switching |

#### Task S1-04: Core Onboarding Flow (5 Screens)

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + Lina Vazquez (UX support) |
| **Effort** | 8 story points / 28 hours |
| **Dependencies** | S1-02 (auth), S1-03 (language), Wireframe Specs Screens 2-6, Design System components |
| **Acceptance Criteria** | (1) 5 screens: user name, partner name + optional zodiac, relationship status, key anniversary date, first templated action card as "aha moment." (2) Screen 5 delivers a templated SAY card personalized with partner name (AI-generated version replaces this in Sprint 2). (3) Copy/share button on first message. (4) Onboarding data persists even if user closes app mid-flow (Hive local draft). (5) All screens render correctly in EN, AR (RTL), and MS. (6) Progress indicator shows 1/5 through 5/5. (7) Skip option available on optional fields (zodiac, anniversary). |
| **Deliverable** | End-to-end onboarding flow with data persistence |

#### Task S1-05: Privacy & Notification Controls (Setup)

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) |
| **Effort** | 3 story points / 10 hours |
| **Dependencies** | S1-04 (onboarding context), Wireframe Spec Screen 7 |
| **Acceptance Criteria** | (1) Notification permission request with preview of discreet notification style. (2) Biometric lock option (Face ID / fingerprint) presented during setup. (3) Lock screen notifications display only "LOLO" with no content preview by default. (4) Settings persisted to local storage and Firestore. (5) Trilingual UI strings from UI String Catalog. |
| **Deliverable** | Privacy/notification setup screen integrated into onboarding |

#### Task S1-06: Basic Partner Profile Creation

| Field | Detail |
|-------|--------|
| **Owner** | BE-2 (backend schema + API) + FE-2 (frontend UI) |
| **Effort** | 8 story points / 28 hours |
| **Dependencies** | S1-02 (auth for user context), Architecture Document Section 6 (Data Architecture), Wireframe Specs Screens 12-13 |
| **Acceptance Criteria** | (1) Firestore schema created for partner profile: name, birthday, zodiac sign (12 + "I don't know"), love language (5 options), communication style, relationship status. (2) Profile completion percentage calculated and displayed. (3) All fields optional except name -- progressive disclosure. (4) Data encrypted at rest with user-specific key. (5) Profile data accessible to all modules via `PartnerProfileRepository`. (6) RTL layout correct for Arabic. (7) All form labels from UI String Catalog. |
| **Deliverable** | Partner profile creation screen with Firestore persistence |

#### Task S1-07: Home Dashboard

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + Omar (architecture guidance) |
| **Effort** | 8 story points / 28 hours |
| **Dependencies** | S1-01 (theme + routing), Wireframe Spec Screen 9, Design System Section 5 (Components) |
| **Acceptance Criteria** | (1) Dashboard displays: placeholder for today's action card, placeholder for streak counter + XP, placeholder for consistency score, next upcoming reminder (empty state), quick-access buttons for Message Generator and SOS. (2) Dark mode by default with light mode toggle stub in settings. (3) Full RTL layout when Arabic is selected. (4) All content localized in selected language. (5) Load time under 2 seconds on mid-range devices. (6) Pull-to-refresh gesture wired (currently reloads placeholder data). |
| **Deliverable** | Home dashboard with placeholder widgets, ready for data integration in Sprint 2 |

#### Task S1-08: Bottom Navigation (5 Tabs)

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) |
| **Effort** | 3 story points / 10 hours |
| **Dependencies** | S1-01 (GoRouter), Wireframe Spec Navigation Map, Design System Section 6 (Iconography) |
| **Acceptance Criteria** | (1) 5 tabs: Home (house), Messages (chat), Gifts (gift), Memories (vault), Profile (person). (2) Active tab highlighted with accent color (#E94560). (3) RTL layout mirrors tab order for Arabic. (4) Tab labels localized (EN/AR/MS). (5) Haptic feedback on tab selection. (6) Badge indicator stub on Messages tab. (7) Each tab navigates to its module shell (empty screens for Sprints 2-4 features). |
| **Deliverable** | Bottom navigation bar with 5 functional tabs |

#### Task S1-09: Push Notification System

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (backend) |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | S1-02 (auth for device token), Architecture Document Section 8 (FCM) |
| **Acceptance Criteria** | (1) FCM (Android) and APNs (iOS) integration complete. (2) Device token registration on account creation. (3) Notification categories defined: Reminders, Action Cards, Streak Alerts, System Updates. (4) Lock screen display: "LOLO" title only, no content preview by default. (5) Quiet hours configurable (default: 10 PM - 7 AM). (6) Per-category toggle infrastructure. (7) Maximum 3 notifications per day enforced server-side. (8) Notification delivery confirmed on both platforms. |
| **Deliverable** | End-to-end push notification pipeline |

#### Task S1-10: Subscription & Paywall System

| Field | Detail |
|-------|--------|
| **Owner** | BE-2 (backend billing logic) + FE-2 (paywall UI) |
| **Effort** | 8 story points / 32 hours |
| **Dependencies** | S1-02 (auth), Architecture Document Section 8 (Third-Party Integrations), Wireframe Spec Screen 42 |
| **Acceptance Criteria** | (1) Three tiers defined: Free, Pro ($6.99/mo), Legend ($12.99/mo). (2) Google Play Billing API integrated. (3) Apple StoreKit 2 integrated. (4) Paywall screen: feature comparison, price, "Start Free Trial" (7-day for Pro). (5) Regional pricing auto-detected: Malaysia = RM 14.90 / RM 26.90. (6) Subscription status check middleware: all feature-gated endpoints verify tier. (7) Subscription management in Profile: upgrade, downgrade, cancel. (8) Revenue tracking: MRR and upgrade triggers logged to PostgreSQL analytics. |
| **Deliverable** | Subscription infrastructure with paywall UI and platform billing |

#### Task S1-11: Sprint 1 QA & Localization Verification

| Field | Detail |
|-------|--------|
| **Owner** | QA-1 + Lina Vazquez |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | All Sprint 1 tasks |
| **Acceptance Criteria** | (1) All screens tested in EN, AR (RTL), MS. (2) RTL layout audit: text alignment, icon mirroring, input cursor position, scroll direction verified per Localization Architecture Section 3. (3) Auth flow tested across Google, Apple, email on both platforms. (4) Onboarding data persistence verified (kill app mid-flow, reopen). (5) Notification delivery verified on Android + iOS. (6) No string overflow or encoding issues in any language. (7) Performance: app launch under 3 seconds, dashboard load under 2 seconds. |
| **Deliverable** | QA sign-off report for Sprint 1 milestone |

**Sprint 1 Total Effort:** ~66 story points / ~232 hours
**Sprint 1 Capacity:** ~15.2 person-weeks (~608 hours at 40hr/wk, but ~486 hours at 80% utilization)
**Sprint 1 Risk Level:** MODERATE -- Subscription billing integration is the highest-risk item. RTL infrastructure decisions in this sprint affect all future sprints.

---

### Sprint 2 (Weeks 11-12) -- Core Features

**Sprint Goal:** "Users can build a detailed partner profile with zodiac defaults and cultural context, set smart reminders for birthdays, anniversaries, and Islamic holidays, generate their first AI-powered message in 3 modes, and begin earning XP and tracking streaks."

**Sprint Theme:** Her Profile Engine, Smart Reminder Engine, AI Message Generator (core), Gamification foundation.

---

#### Task S2-01: Zodiac Sign Integration

| Field | Detail |
|-------|--------|
| **Owner** | BE-2 (data mapping) + FE-1 (UI) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S1-06 (partner profile schema), Zodiac Master Profiles (12 signs x 10 dimensions), Sign Cheat Sheets |
| **Acceptance Criteria** | (1) All 12 zodiac signs mapped to personality trait defaults from zodiac-master-profiles.md. (2) When sign is selected, auto-populate communication preferences, emotional tendencies, love language hint. (3) Disclaimer: "This is based on her zodiac sign -- adjust if needed." (4) Every auto-populated field has manual override. (5) "I don't know her sign" option skips gracefully. (6) Zodiac data stored in partner profile and accessible to AI prompts. |
| **Deliverable** | Zodiac-aware partner profile with auto-populated personality defaults |

#### Task S2-02: Partner Preferences & Interests

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) + BE-2 (API) |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | S1-06 (profile schema), Wireframe Spec Screens 14-15 |
| **Acceptance Criteria** | (1) Category-based entry: Favorites (flowers, food, music, movies, brands, colors), Dislikes, Hobbies, Stress Coping. (2) Free-text notes field. (3) Search/filter within preferences. (4) Preferences accessible to Gift Engine and Action Card personalization via repository. (5) Free tier: 5 preference fields; Pro/Legend: unlimited. (6) Trilingual UI labels. |
| **Deliverable** | Partner preferences screen with structured and free-text entry |

#### Task S2-03: Cultural & Religious Context Settings

| Field | Detail |
|-------|--------|
| **Owner** | BE-2 (backend) + FE-2 (frontend) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S1-06 (profile schema), Arabic Women's Perspective, Malay Women's Perspective, Cultural Sensitivity Guide |
| **Acceptance Criteria** | (1) Cultural background options: Arab (Gulf/Levantine/Egyptian/North African), Malay, Western, South Asian, East Asian, Other. (2) Religious observance: High / Moderate / Low / Secular. (3) Islamic context auto-adds Ramadan, Eid al-Fitr, Eid al-Adha, Maulidur Rasul to calendar. (4) Cultural context data fed into AI prompt context for all modules. (5) Gift suggestions exclude culturally inappropriate items when cultural context is set. |
| **Deliverable** | Cultural context settings integrated into partner profile |

#### Task S2-04: Anniversary & Birthday Reminders

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (scheduling engine) + FE-1 (reminder UI) |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | S1-09 (push notification system), Wireframe Spec Screens 16-17 |
| **Acceptance Criteria** | (1) Support: dating anniversary, wedding anniversary, partner birthday, custom dates. (2) 6-tier escalating schedule: 30d, 14d, 7d, 3d, 1d, day-of. (3) Day-30/14 reminders include Gift Engine link. (4) Day-3/1 reminders escalate urgency copy. (5) Snooze and dismiss options. (6) Free: 3 dates; Pro: 10; Legend: unlimited. (7) All reminder copy localized EN/AR/MS. |
| **Deliverable** | Birthday and anniversary reminder system with escalating notifications |

#### Task S2-05: Islamic & Cultural Holiday Reminders

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (Hijri calendar + scheduling) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S2-03 (cultural context), S1-09 (notifications) |
| **Acceptance Criteria** | (1) Islamic holidays auto-populated when cultural context includes Islamic observance. (2) Hijri calendar calculations accurate for current and next year. (3) Reminders begin 21 days before major holidays. (4) Holiday reminders link to Gift Engine and Message Generator. (5) Malaysia-specific: Hari Raya Aidilfitri, Maulidur Rasul included for Malay users. |
| **Deliverable** | Islamic and cultural holiday reminder system |

#### Task S2-06: Custom Reminder Creation

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + BE-1 (API) |
| **Effort** | 3 story points / 12 hours |
| **Dependencies** | S2-04 (reminder infrastructure), Wireframe Spec Screen 18 |
| **Acceptance Criteria** | (1) One-time and recurring types (daily, weekly, monthly, yearly). (2) Custom title and optional notes. (3) End date or "forever" option. (4) Free: 5 active; Pro: 15; Legend: 30. (5) Edit, delete, snooze. (6) Time-zone-aware delivery. |
| **Deliverable** | Custom reminder creation and management |

#### Task S2-07: Core AI Message Generation Engine

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) + BE-2 (API layer) |
| **Effort** | 13 story points / 48 hours |
| **Dependencies** | S1-06 (partner profile for context), AI Strategy Document (router, model selection, failover), AI Content Guidelines (safety rules), Emotional State Framework |
| **Acceptance Criteria** | (1) AI Router Cloud Function deployed: authenticate, rate-limit, cache-check, classify, select model, execute, validate, cache, log cost, return. (2) Classification algorithm operational across 5 dimensions (task type, emotional depth, latency, cost sensitivity, language). (3) Model selection decision tree implemented per AI Strategy Section 1.3. (4) Failover chain: primary -> retry with compressed prompt -> fallback model -> tertiary model -> cached response. (5) Message generation completes in under 5 seconds. (6) Messages incorporate partner name, zodiac data, and cultural context. (7) Copy-to-clipboard and share-to-app buttons. (8) "Regenerate" button produces different output. (9) Rate message (thumbs up/down) feedback. (10) Output validation layer blocks content violating AI Content Guidelines Section 1 (no medical advice, no diagnostic language, no manipulation). (11) Redis caching with locale-aware keys. (12) Cost tracking per request logged to PostgreSQL. |
| **Deliverable** | Production-ready AI message generation engine with multi-model routing |

#### Task S2-08: 3 Free Message Modes (Good Morning / Appreciation / Romance)

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | S2-07 (AI engine), Multi-Language Prompt Strategy Section 12 (prompt templates), Emotional State Framework |
| **Acceptance Criteria** | (1) Three modes selectable from message generation screen. (2) Each mode uses distinct prompt template per Multi-Language Prompt Strategy. (3) Good Morning: warm, brief, start-of-day energy. (4) Appreciation: specific, observation-based compliments. (5) Romance: emotionally deep, intimate, partner-specific. (6) English generation verified as natural and high-quality. (7) Free tier limit: 5 messages/month enforced. (8) Mode selection UI matches Wireframe Spec Screen 19. |
| **Deliverable** | Three working message modes with English prompt templates |

#### Task S2-09: Daily Streak Counter

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + BE-1 (tracking logic) |
| **Effort** | 3 story points / 12 hours |
| **Dependencies** | S1-07 (home dashboard for display) |
| **Acceptance Criteria** | (1) Streak increments when user completes at least 1 qualifying action per day. (2) Qualifying: complete action card, send AI message, log memory, update profile, check reminders. (3) Streak displays on home screen with streak icon. (4) Streak break triggers push notification within 24 hours. (5) Milestones (7, 14, 30, 60, 90 days) award bonus XP. (6) Legend-only streak freeze (1 missed day/month). |
| **Deliverable** | Daily streak system with home dashboard integration |

#### Task S2-10: XP Points System + Level Progression

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (XP logic) + FE-1 (UI) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S1-07 (home dashboard), S2-09 (streak for XP triggers) |
| **Acceptance Criteria** | (1) XP awarded per action: action card (+15-25), message sent (+10), reminder set (+5), profile update (+5), memory logged (+10), promise completed (+20), gift feedback (+10). (2) XP displayed on home screen alongside streak. (3) Daily XP cap of 100. (4) 10 levels: Beginner through Soulmate with escalating thresholds. (5) Level-up animation. (6) XP history viewable in profile. |
| **Deliverable** | XP and level progression system |

#### Task S2-11: App Lock (Biometric + PIN)

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) |
| **Effort** | 3 story points / 10 hours |
| **Dependencies** | S1-05 (privacy settings), S1-02 (auth) |
| **Acceptance Criteria** | (1) Biometric (Face ID / fingerprint) or PIN lock at app launch. (2) Configurable in Settings. (3) Lock screen appears on every cold start and after 5 minutes of background. (4) Essential for AR/MS privacy-sensitive markets per User Personas (Ahmed, Hafiz). |
| **Deliverable** | App lock with biometric and PIN support |

#### Task S2-12: Settings & Preferences Screen

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) |
| **Effort** | 3 story points / 12 hours |
| **Dependencies** | S1-03 (language), S1-05 (privacy), S1-10 (subscription), Wireframe Spec Screens 39-41 |
| **Acceptance Criteria** | (1) Sections: Language, Notifications, Subscription, Privacy, About, Help, Account (logout/delete). (2) Language change triggers runtime locale switch. (3) Subscription management links to platform billing. (4) Account deletion flow with confirmation. (5) Trilingual UI. |
| **Deliverable** | Settings screen with all preference controls |

#### Task S2-13: Sprint 2 QA & Localization Verification

| Field | Detail |
|-------|--------|
| **Owner** | QA-1 + Lina Vazquez + Cultural Advisors |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | All Sprint 2 tasks |
| **Acceptance Criteria** | (1) Partner profile tested with all zodiac signs and cultural context combinations. (2) Reminder scheduling tested across time zones. (3) Hijri calendar accuracy verified by Arabic cultural advisor. (4) AI message generation tested in English (20 sample messages per mode, rated 4.0+/5.0 for naturalness). (5) Gamification XP and streak logic verified with edge cases (midnight rollover, timezone changes). (6) RTL layout verified on all new screens. |
| **Deliverable** | QA sign-off report for Sprint 2 milestone |

**Sprint 2 Total Effort:** ~65 story points / ~244 hours
**Sprint 2 Capacity:** ~15.2 person-weeks (~486 effective hours)
**Sprint 2 Risk Level:** HIGH -- AI Message Generation Engine (S2-07) is the single highest-risk, highest-impact item. Begin prompt engineering and model integration on Day 1. API latency must hit <5s target.

---

### Sprint 3 (Weeks 13-14) -- AI Engine

**Sprint Goal:** "Users can generate messages in all 10 modes across 3 languages, receive daily personalized action cards (SAY/DO/BUY/GO), get AI-powered gift recommendations, log memories and wishes, track promises, and see their Relationship Consistency Score."

**Sprint Theme:** Full AI capability, trilingual generation, Smart Action Cards, Gift Engine, Memory Vault.

---

#### Task S3-01: 7 Pro/Legend Message Modes

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) |
| **Effort** | 8 story points / 32 hours |
| **Dependencies** | S2-07 (AI engine), S2-08 (mode framework), Multi-Language Prompt Strategy (all 10 mode templates) |
| **Acceptance Criteria** | (1) 7 modes: Apology & Reconciliation, Missing You, Celebration, Comfort & Reassurance, Flirting & Playful, Deep Conversation Starters, "Just Because." (2) Apology mode: non-defensive, accountability-first per Situation-Response Matrix severity 4-5 guidelines. (3) Flirting mode: culturally calibrated (more restrained for AR/MS per Cultural Sensitivity Guide). (4) Each mode has distinct English prompt template. (5) Pro: 30 messages/month; Legend: unlimited. (6) Mode selection UI updated with 10 total options. |
| **Deliverable** | All 10 message modes operational in English |

#### Task S3-02: Trilingual Message Generation (EN/AR/MS)

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) + BE-1 (language routing) |
| **Effort** | 13 story points / 48 hours |
| **Dependencies** | S3-01 (all modes), Multi-Language Prompt Strategy Sections 12-14, Arabic Women's Perspective, Malay Women's Perspective |
| **Acceptance Criteria** | (1) English: natural conversational American/British English. (2) Arabic: Gulf dialect primary, MSA fallback, Egyptian/Levantine selectable per prompt strategy. (3) Malay: Malaysian colloquial BM with appropriate terms (Abang, Sayang, InsyaAllah). (4) Language override per message (e.g., Arabic user generates one English message). (5) Arabic output renders properly in RTL with correct diacritics. (6) Language verification pipeline per Multi-Language Prompt Strategy Section 15: output language detection + dialect consistency check. (7) Quality benchmark: 20 sample messages per mode per language, rated by native speakers, average 4.0+/5.0. |
| **Deliverable** | Trilingual AI message generation across all 10 modes |

#### Task S3-03: Message Tone & Length Controls

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) |
| **Effort** | 3 story points / 10 hours |
| **Dependencies** | S2-07 (AI engine), Wireframe Spec Screen 20 |
| **Acceptance Criteria** | (1) Tone selector: Formal, Warm, Casual, Playful. (2) Length selector: Short (1-2 sentences), Medium (3-4), Long (5+). (3) Defaults loaded from Her Profile. (4) Settings remembered per recipient type. (5) Tone/length parameters injected into AI prompt. |
| **Deliverable** | Tone and length controls on message generation screen |

#### Task S3-04: Daily Action Card Generation Engine

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) + BE-2 (scheduling + API) |
| **Effort** | 8 story points / 32 hours |
| **Dependencies** | S2-07 (AI engine), S1-06 (partner profile), AI Strategy Section 5 (Smart Action Cards Engine), Action Card Validation (30+ validated scenarios) |
| **Acceptance Criteria** | (1) One card generated daily at user-configured time (default: 8 AM local). (2) Card type rotates across SAY/DO/BUY/GO for variety. (3) Card content references partner name, profile data, calendar events, and cultural context. (4) "Complete" button logs action and awards XP. (5) "Skip" with brief reason for algorithm improvement. (6) Free: 1 card/day; Pro: 3; Legend: 5 + custom requests. (7) Card generation prompts use validated scenarios from Action Card Validation document. |
| **Deliverable** | Daily action card generation with contextual personalization |

#### Task S3-05: SAY + DO + BUY + GO Card Types (UI)

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (SAY/DO) + FE-2 (BUY/GO) |
| **Effort** | 8 story points / 28 hours |
| **Dependencies** | S3-04 (card engine), Wireframe Spec Screens 33-34, Design System card components |
| **Acceptance Criteria** | (1) SAY card: category label, suggestion text, pre-generated AI message, copy button, link to Message Generator. (2) DO card: category label, action description, time/effort estimate, tips. (3) BUY card: category label, gift suggestion, price range, link to Gift Engine, affiliate link stub. (4) GO card: category label, experience suggestion, cost estimate, location hint. (5) Completion XP: SAY +15, DO +20, BUY +25, GO +25. (6) Culturally calibrated: action types appropriate per market (per Cultural Sensitivity Guide). |
| **Deliverable** | Four card type UIs with completion tracking |

#### Task S3-06: AI Gift Recommendation Core

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) + BE-2 (API) |
| **Effort** | 8 story points / 28 hours |
| **Dependencies** | S2-02 (partner preferences), S2-03 (cultural context), AI Strategy Section 6 (Gift Recommendation Algorithm), Gift Feedback Framework, "What She Actually Wants" |
| **Acceptance Criteria** | (1) Generates 5-10 gift suggestions per request via Gemini Flash (per AI Strategy routing). (2) Inputs: occasion, budget range, Her Profile data, cultural context. (3) Each suggestion: name, description, price range, reasoning referencing profile data. (4) Feedback mechanism: "She loved it" / "She didn't like it" / "Didn't buy it." (5) Free: 2 requests/month; Pro: 10; Legend: unlimited. (6) Islamic occasions exclude culturally inappropriate items per Arabic Women's Perspective. (7) Gift feedback data stored per Gift Feedback Framework (guaranteed winners/losers lists). |
| **Deliverable** | AI-powered gift recommendation engine |

#### Task S3-07: Budget Filter & Low Budget High Impact Mode

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) + BE-2 (budget logic) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S3-06 (gift engine), Wireframe Spec Screen 24 |
| **Acceptance Criteria** | (1) Budget selector: $0-25, $25-50, $50-100, $100-250, $250+, custom. (2) "Low Budget High Impact" toggle: gifts under $15 / RM 50 / AED 50. (3) Low-budget: handwritten letter templates, DIY ideas, experience gifts, homemade food. (4) Effort/time estimate alongside cost. (5) Currency auto-set by locale (USD, AED, MYR) with manual override. |
| **Deliverable** | Budget filtering and low-budget gift mode |

#### Task S3-08: Promise Tracker

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (backend) + FE-1 (frontend) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S1-09 (notifications for reminders), S2-09 (XP integration) |
| **Acceptance Criteria** | (1) Promise entry: title, description, target date, priority (low/medium/high). (2) Status: Open, In Progress, Completed, Overdue. (3) Escalating reminders: 7d, 3d, 1d, overdue. (4) Overdue messaging: "This promise is overdue. [Partner name] may have noticed." (5) Completion awards +20 XP. (6) Free: 5 promises; Pro: 15; Legend: 20. |
| **Deliverable** | Promise tracker with status tracking and escalating reminders |

#### Task S3-09: Relationship Consistency Score

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (scoring algorithm) + FE-1 (dashboard widget) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S2-09 (streak data), S2-10 (XP data), S3-04 (action card completion data) |
| **Acceptance Criteria** | (1) Score: 0-100, updated daily. (2) Inputs: action card completion (30%), streak (20%), messages sent (15%), reminders acknowledged (15%), promises completed (20%). (3) Weekly trend indicator (up/down arrow + percentage change). (4) Percentile ranking: "More thoughtful than X% of LOLO users." (5) Dashboard display with detail breakdown view. (6) Private metric -- no partner visibility. |
| **Deliverable** | Relationship Consistency Score with dashboard integration |

#### Task S3-10: Memory Entry Creation + Wish List

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) + BE-1 (storage + API) |
| **Effort** | 5 story points / 20 hours |
| **Dependencies** | S1-02 (auth for encryption), Wireframe Spec Screens 35-38 |
| **Acceptance Criteria** | (1) Memory entry: title, description, date, optional photo (1 on free, 5 on Pro, unlimited on Legend), tags (predefined + custom). (2) Entries sorted chronologically with search and filter. (3) All entries encrypted at rest. (4) Free: 10 memories; Pro: 50; Legend: unlimited. (5) Quick-add from home screen. (6) Wish list: item description, price estimate, date mentioned, priority, occasion link. (7) Wish list items accessible to Gift Engine. (8) Free: 5 wish items; Pro: 20; Legend: unlimited. |
| **Deliverable** | Memory Vault with entries and wish list |

#### Task S3-11: Onboarding Tooltips + Message Quick-Switch + Card Feedback + Profile Incentives

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (tooltips, quick-switch, incentives) + FE-2 (card feedback) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | All Sprint 2-3 module screens |
| **Acceptance Criteria** | (1) Contextual tooltips on first-time module open (1-2 sentences + "Got it" dismiss). (2) Message mode quick-switch: swipe or tab without navigating back. (3) Card skip reason: "Too busy," "Not relevant," "Too expensive," "Already did similar." (4) Profile completion XP bonuses at 25%, 50%, 75%, 100%. |
| **Deliverable** | UX enhancements across modules |

#### Task S3-12: Sprint 3 QA & Trilingual Content Review

| Field | Detail |
|-------|--------|
| **Owner** | QA-1 + Cultural Advisors (Arabic + Malay) + Lina Vazquez |
| **Effort** | 8 story points / 32 hours |
| **Dependencies** | All Sprint 3 tasks, Arabic Women's Perspective, Malay Women's Perspective |
| **Acceptance Criteria** | (1) Trilingual message quality review: 20 messages per mode per language, rated by native speakers, all modes pass 4.0/5.0 threshold. (2) Arabic dialect consistency: Gulf vocabulary and expressions dominant, no MSA-only output. (3) Malay colloquial verification: appropriate terms (Abang, Sayang, InsyaAllah) used naturally. (4) Action card cultural appropriateness verified per market. (5) Gift recommendations culturally filtered (no alcohol/pork-related gifts for Islamic context). (6) RTL layout verified on all new screens. (7) Content safety audit: 50 sample outputs checked against AI Content Guidelines -- zero violations on absolute prohibitions. |
| **Deliverable** | Trilingual QA sign-off + content safety audit report |

**Sprint 3 Total Effort:** ~81 story points / ~296 hours
**Sprint 3 Capacity:** ~15.2 person-weeks (~486 effective hours)
**Sprint 3 Risk Level:** HIGH -- This is the most feature-dense sprint. Trilingual AI quality (S3-02) is the single biggest risk. Schedule native speaker reviews on Days 8-10. If P1 items cannot complete, S3-11 defers to Sprint 4.

---

### Sprint 4 (Weeks 15-16) -- Smart Actions + Polish

**Sprint Goal:** "SOS Mode is live with crisis coaching in under 3 seconds. Occasion-based gift packages are available. All Should Have features that fit capacity are complete. The app is polished, performance-optimized, and ready for closed beta."

**Sprint Theme:** SOS Mode, gift packages, contextual modes (Ramadan/Pregnancy), Should Have features, bug fixes, performance optimization, beta readiness.

---

#### Task S4-01: SOS Mode Activation (2-Tap Access)

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + BE-1 (backend) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S1-07 (dashboard -- SOS button), Wireframe Spec Screens 26-27 |
| **Acceptance Criteria** | (1) SOS button visible on home screen, accessible in 2 taps from any screen. (2) Discreet icon (shield/lifeline, not alarm). (3) Launches within 1 second. (4) No loading screens, no ads, no paywall on entry (paywall on extended use). (5) Offline: cached emergency response templates available. (6) Free: 1 SOS/month; Pro: 3; Legend: unlimited. |
| **Deliverable** | SOS Mode entry point with 2-tap access |

#### Task S4-02: Crisis Scenario Selection

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + Dr. Aisha Mahmoud (AI prompts) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S4-01 (SOS activation), Situation-Response Matrix (55+ situations, severity 1-5), Wireframe Spec Screen 28 |
| **Acceptance Criteria** | (1) 5-7 pre-defined crisis scenarios as large tappable buttons: "We're in an argument," "I forgot something important," "She's upset and I don't know why," "I need to apologize right now," "I said the wrong thing." (2) Selection triggers scenario-specific AI prompt constructed from Situation-Response Matrix data. (3) Cached offline fallback: 3-5 static tips per scenario. (4) Trilingual scenario labels. |
| **Deliverable** | Crisis scenario selection screen with offline fallback |

#### Task S4-03: Real-Time AI Coaching Response

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI/ML) + BE-2 (API) |
| **Effort** | 8 story points / 32 hours |
| **Dependencies** | S4-02 (scenario selection), AI Strategy Section 7 (SOS Mode AI -- Grok routing), AI Content Guidelines Section 4 (Crisis Protocol), Emotional State Framework Section 8 (Emotional Escalation Protocol) |
| **Acceptance Criteria** | (1) Response format: 3-5 actionable steps displayed sequentially (not wall of text). (2) "SAY THIS" and "DON'T SAY THIS" sections. (3) Steps reference Her Profile data (communication style, stress coping). (4) Cultural calibration: Arabic responses respect family hierarchy per Arabic Women's Perspective; Malay responses account for indirect communication per Malay Women's Perspective. (5) AI response time under 3 seconds (Grok 4.1 Fast primary, Claude Haiku fallback per AI Strategy). (6) Follow-up prompt after 5 minutes: "How did it go?" (7) Pro: standard AI; Legend: premium model (Claude Sonnet for deeper analysis). (8) Content safety: zero tolerance for manipulation techniques, mandatory professional referral triggers per AI Content Guidelines Section 4. (9) Trilingual coaching responses. |
| **Deliverable** | Real-time AI crisis coaching with cultural calibration |

#### Task S4-04: Occasion-Based Gift Packages

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI prompts) + FE-2 (frontend) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S3-06 (gift engine core), S3-07 (budget filter), Wireframe Spec Screen 25 |
| **Acceptance Criteria** | (1) Package: primary gift + 1-2 complementary items + AI-generated card message + presentation/wrapping suggestion. (2) Occasions: Birthday, Anniversary, Eid al-Fitr, Eid al-Adha, Hari Raya, Valentine's Day, "Just Because." (3) Islamic occasions include culturally appropriate gift norms. (4) Budget total displayed. (5) Pro/Legend only feature. |
| **Deliverable** | Occasion-based gift packages with cultural variants |

#### Task S4-05: Family Member Profiles

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (frontend) + BE-2 (backend schema extension) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S1-06 (partner profile schema extensibility) |
| **Acceptance Criteria** | (1) Add profiles for partner's family: mother, father, siblings. (2) Fields: name, birthday, interests, health notes, relationship to partner. (3) Family data feeds Action Cards ("Ask about Um Noura's knee"). (4) Free: none; Pro: 3 members; Legend: unlimited. |
| **Deliverable** | Family member profile management |

#### Task S4-06: AI Message History & Favorites

| Field | Detail |
|-------|--------|
| **Owner** | FE-1 (frontend) + BE-1 (storage) |
| **Effort** | 3 story points / 12 hours |
| **Dependencies** | S2-07 (message generation), Wireframe Spec Screen 22 |
| **Acceptance Criteria** | (1) Log of all generated messages with favorite toggle. (2) Searchable by mode, date, language. (3) Free: last 5; Pro: last 30; Legend: unlimited. (4) Duplicate detection warning. |
| **Deliverable** | Message history with favorites |

#### Task S4-07: Weekly Summary Report

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (data aggregation) + FE-1 (UI) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S2-09 (streak), S2-10 (XP), S3-04 (action cards), S3-09 (consistency score) |
| **Acceptance Criteria** | (1) Weekly push notification + in-app summary. (2) Content: cards completed, messages sent, streak status, score change, percentile. (3) Pro/Legend only feature. (4) English-first, AR/MS in v1.0.1. |
| **Deliverable** | Weekly progress summary report |

#### Task S4-08: Ramadan Mode

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI prompts) + BE-1 (mode toggle) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S2-03 (Islamic context), S3-04 (action cards), S2-07 (AI engine), Arabic Women's Perspective |
| **Acceptance Criteria** | (1) Global mode toggle during Ramadan. (2) AI message tone: spiritual, less romantic. (3) Action cards: iftar-focused, family-centered. (4) Gift suggestions: dates, prayer items, Quran accessories. (5) Notification timing: post-iftar, pre-suhoor. (6) Auto-activate based on Hijri calendar dates. |
| **Deliverable** | Ramadan-aware AI content mode |

#### Task S4-09: Pregnancy Mode

| Field | Detail |
|-------|--------|
| **Owner** | Dr. Aisha Mahmoud (AI prompts) + BE-2 (mode toggle) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S1-06 (partner profile -- pregnancy indicator), S3-04 (action cards), Emotional State Framework Section 2 (Pregnancy by Trimester) |
| **Acceptance Criteria** | (1) Pregnancy indicator in Her Profile activates mode. (2) Action cards shift: physical comfort, emotional support, appointment reminders, body positivity. (3) AI messages: trimester-aware tone per Emotional State Framework. (4) No medical advice per AI Content Guidelines (absolute prohibition). |
| **Deliverable** | Pregnancy-aware AI content mode |

#### Task S4-10: Action Card History + Gift Feedback + Wish List Auto-Surfacing

| Field | Detail |
|-------|--------|
| **Owner** | FE-2 (card history, gift feedback) + BE-2 (wish list surfacing) |
| **Effort** | 5 story points / 16 hours |
| **Dependencies** | S3-04 (action cards), S3-06 (gift engine), S3-10 (wish list) |
| **Acceptance Criteria** | (1) Action card history: completed and skipped cards, filterable. Pro: 14 days; Legend: unlimited. (2) Gift feedback: post-occasion prompt "Did she like it?" with rating per Gift Feedback Framework. (3) Wish list auto-surfacing: Gift Engine shows wish list items as top recommendations when gifting occasion approaches. |
| **Deliverable** | Historical tracking and feedback loops |

#### Task S4-11: Offline Mode (Basic) + Data Export

| Field | Detail |
|-------|--------|
| **Owner** | BE-1 (caching) + FE-2 (offline UI) |
| **Effort** | 5 story points / 18 hours |
| **Dependencies** | S1-07 (dashboard), S3-04 (action cards), S4-01 (SOS) |
| **Acceptance Criteria** | (1) Cached action cards, reminders, recent messages accessible without internet. (2) SOS Mode cached emergency responses work offline. (3) Sync when connectivity restored. (4) Data export: all personal data downloadable as JSON (GDPR / PDPA compliance). |
| **Deliverable** | Basic offline mode + privacy-compliant data export |

#### Task S4-12: Sprint 4 QA, Performance Optimization & Beta Readiness

| Field | Detail |
|-------|--------|
| **Owner** | QA-1 + All engineers + Lina Vazquez + Cultural Advisors |
| **Effort** | 8 story points / 32 hours |
| **Dependencies** | All Sprint 4 tasks + cumulative regression |
| **Acceptance Criteria** | (1) Full regression test across all 10 modules in 3 languages. (2) SOS Mode response time: verified under 3 seconds in all scenarios. (3) Performance: app launch < 3s, dashboard < 2s, AI message < 5s on mid-range device. (4) Memory usage: < 200MB peak. (5) Crash rate: < 0.1% across 100 test sessions. (6) Localization QA: native speakers verify all AI-generated content in AR and MS (final review). (7) Content safety final audit: 100 sample outputs across all AI features, zero violations on absolute prohibitions. (8) Accessibility: minimum AA contrast ratios, touch targets >= 48dp. (9) Beta build signed and uploaded to TestFlight (iOS) and Google Play Internal Testing (Android). |
| **Deliverable** | Beta-ready builds for iOS and Android with QA sign-off |

**Sprint 4 Total Effort:** ~69 story points / ~230 hours
**Sprint 4 Capacity:** ~15.2 person-weeks (~486 effective hours)
**Sprint 4 Risk Level:** MODERATE -- SOS Mode AI coaching quality is the critical path item. If capacity is tight, S4-11 (Offline Mode + Data Export) defers to v1.0.1 fast-follow.

---

## Section 3: Resource Allocation

### 3.1 Team Member to Sprint Assignment Matrix

| Team Member | Sprint 1 | Sprint 2 | Sprint 3 | Sprint 4 |
|-------------|----------|----------|----------|----------|
| **Omar Al-Rashidi (TL)** | S1-01 Scaffolding, architecture oversight, code review | Architecture guidance, code review | Architecture guidance, performance review | Performance optimization, code review, beta prep |
| **FE-1** | S1-03 Language, S1-04 Onboarding, S1-07 Dashboard, S1-08 Nav | S2-04 Reminders UI, S2-06 Custom Reminders, S2-09 Streak, S2-10 XP/Levels | S3-03 Tone Controls, S3-05 SAY/DO Cards, S3-08 Promise Tracker, S3-09 Score UI, S3-11 Tooltips | S4-01 SOS Entry, S4-02 Crisis UI, S4-06 Msg History, S4-07 Weekly Report |
| **FE-2** | S1-02 Auth (frontend), S1-05 Privacy, S1-06 Profile UI, S1-10 Paywall UI | S2-01 Zodiac UI, S2-02 Preferences, S2-03 Cultural UI, S2-11 App Lock, S2-12 Settings | S3-05 BUY/GO Cards, S3-07 Budget Filter, S3-10 Memory/Wish UI, S3-11 Card Feedback | S4-04 Gift Packages UI, S4-05 Family Profiles, S4-10 Card History/Gift Feedback, S4-11 Offline UI |
| **BE-1** | S1-02 Auth (backend), S1-09 Notifications | S2-04 Reminders API, S2-05 Islamic Calendar, S2-06 Custom Reminders API, S2-09 Streak Logic, S2-10 XP Logic | S3-02 Language Routing, S3-08 Promise API, S3-09 Score Algorithm, S3-10 Memory API | S4-01 SOS API, S4-06 Msg History API, S4-07 Summary API, S4-08 Ramadan API, S4-11 Offline Cache/Export |
| **BE-2** | S1-06 Profile (backend), S1-10 Subscription (backend) | S2-01 Zodiac Data, S2-02 Preferences API, S2-03 Cultural API, S2-07 AI Engine API Layer | S3-04 Card Scheduling, S3-05 Card API, S3-06 Gift API, S3-07 Budget API | S4-03 SOS Coaching API, S4-04 Gift Packages API, S4-05 Family API, S4-09 Pregnancy API, S4-10 Wish Surfacing |
| **Dr. Aisha (AI/ML)** | -- (prompt engineering prep, model API access setup) | S2-07 AI Engine Core, S2-08 3 Message Modes | S3-01 7 Pro Modes, S3-02 Trilingual Gen, S3-04 Card Generation, S3-06 Gift Recommendation AI | S4-02 Crisis Prompts, S4-03 SOS Coaching AI, S4-04 Gift Package Prompts, S4-08 Ramadan Prompts, S4-09 Pregnancy Prompts |
| **Lina Vazquez (UX)** | S1-04 Onboarding support, S1-11 QA, design handoff | S2-13 QA, UI polish, RTL review | S3-12 Trilingual content review, UI polish | S4-12 Final design QA, beta UI polish |
| **QA-1** | S1-11 QA (auth, onboarding, notifications, RTL) | S2-13 QA (profile, reminders, AI messages, gamification) | S3-12 QA (trilingual content, action cards, gifts, safety audit) | S4-12 Full regression, performance testing, beta certification |

### 3.2 Workload Balancing Assessment

| Sprint | Highest Load | Load Level | Mitigation |
|--------|-------------|------------|------------|
| Sprint 1 | BE-2 (Profile + Subscription = ~60 hrs) | MANAGEABLE | Subscription billing is complex but well-documented with platform SDKs. Start on Day 1. |
| Sprint 2 | Dr. Aisha (AI Engine + 3 Modes = ~68 hrs) | HIGH | AI Engine is the critical path. BE-2 builds API layer in parallel while Aisha tunes prompts. Fail-fast: if model latency exceeds 5s by Day 5, escalate to alternative model. |
| Sprint 3 | Dr. Aisha (7 Modes + Trilingual + Cards + Gifts = ~140 hrs) | CRITICAL | Sprint 3 AI scope exceeds single-person capacity. Mitigation: Omar assists with prompt template implementation. BE-1 handles language routing infrastructure. Native speaker reviews scheduled proactively for Days 8-10. If 7 modes cannot all ship in Sprint 3, defer Deep Conversation and "Just Because" modes to Sprint 4. |
| Sprint 4 | Dr. Aisha (SOS + Ramadan + Pregnancy + Packages = ~84 hrs) | HIGH | SOS coaching AI is P0; Ramadan and Pregnancy modes are P1. If capacity is tight, Pregnancy mode defers to v1.0.1. |

### 3.3 Potential Bottlenecks and Mitigation

| Bottleneck | Likelihood | Impact | Mitigation |
|------------|-----------|--------|------------|
| **AI/ML Engineer is single point of failure** | HIGH | CRITICAL | Omar Al-Rashidi cross-trains on prompt engineering during Sprint 1 prep. Prompt templates are documented in Multi-Language Prompt Strategy and can be implemented by backend engineers. Dr. Aisha focuses on model tuning and quality assurance. |
| **Arabic RTL layout bugs cascade** | MEDIUM | HIGH | RTL architecture decisions made in Sprint 1 (S1-01, S1-03). Lina Vazquez performs RTL review at end of every sprint. Use Flutter's built-in Directionality + ARB system to minimize custom RTL code. |
| **Apple/Google billing API delays** | MEDIUM | MEDIUM | Start billing integration on Sprint 1 Day 1. Use RevenueCat SDK as abstraction layer to simplify cross-platform billing. Paywall UI can function as a stub (show upgrade screen, defer actual purchase) if billing APIs are not certified by end of Sprint 1. |
| **Trilingual AI quality does not meet 4.0/5.0 threshold** | MEDIUM | HIGH | Schedule native speaker reviews on Sprint 3 Days 8-10. If Arabic or Malay quality fails threshold, dedicate Sprint 4 capacity to prompt refinement. Worst case: launch Arabic/Malay AI content in "beta" label with user feedback mechanism. |
| **Sprint 3 scope exceeds capacity** | HIGH | MEDIUM | P1 items in Sprint 3 (S3-11: tooltips, quick-switch, card feedback, profile incentives) are explicitly deferrable to Sprint 4 without impacting MVP. |

---

## Section 4: Risk Register

### Top 10 Risks

| # | Risk | Likelihood | Impact | Risk Score | Mitigation Strategy |
|---|------|-----------|--------|------------|---------------------|
| 1 | **AI message quality in Arabic/Malay fails to feel natural** | HIGH (70%) | CRITICAL | 9/10 | Native speaker review panels built into Sprint 3 QA. Prompt templates pre-validated in Multi-Language Prompt Strategy. Dialect-specific vocabulary lists embedded in prompts. Fallback: launch with "beta" quality label and rapid iteration based on user feedback. |
| 2 | **AI/ML Engineer becomes bottleneck** | HIGH (75%) | HIGH | 8/10 | Cross-train Omar on prompt engineering. Document all prompt templates as deployable artifacts. Backend engineers can implement prompt assembly; Aisha focuses on quality tuning. Contingency: contract a second AI engineer for Sprints 3-4. |
| 3 | **AI model API latency exceeds 5-second target** | MEDIUM (50%) | HIGH | 7/10 | Multi-model router with failover chain (AI Strategy). Redis caching for repeated similar requests. Prompt compression for retries. SOS Mode uses Grok 4.1 Fast (optimized for speed). Monitor latency from Sprint 2 Day 1; if P95 > 5s, switch to faster model tiers. |
| 4 | **Apple/Google billing certification delays** | MEDIUM (40%) | MEDIUM | 5/10 | Use RevenueCat abstraction layer. Begin certification process during Sprint 1. Paywall UI functional as stub (shows upgrade screen) while certification is pending. Plan for 2-week certification buffer. |
| 5 | **RTL layout bugs in Arabic cause cascading UI issues** | MEDIUM (45%) | HIGH | 6/10 | RTL infrastructure established in Sprint 1. Flutter's built-in Directionality and MaterialApp RTL support minimize custom code. RTL review at end of every sprint. Dedicated Arabic layout test suite. |
| 6 | **AI content safety violation reaches user** | LOW (15%) | CRITICAL | 6/10 | Triple-layer safety: prompt-level rules, output validation filter, and human review for SOS content. AI Content Guidelines define absolute prohibitions enforced at all three layers. Content safety audit in Sprint 3 and Sprint 4 QA. Zero-tolerance policy: any violation blocks release. |
| 7 | **Scope creep from Should Have features pressuring Sprint capacity** | HIGH (65%) | MEDIUM | 6/10 | MoSCoW prioritization is final. Sprint goals focus exclusively on Must Have (P0) items. Should Have (P1) features are explicitly marked as deferrable. Sprint retrospectives enforce scope discipline. PM (Sarah Chen) has final scope authority. |
| 8 | **Hijri calendar date calculations are inaccurate** | LOW (20%) | HIGH | 4/10 | Use established Hijri calendar libraries (e.g., `hijri_calendar` Flutter package). Validate against known Hijri dates for 2026-2027. Arabic cultural advisor verifies Eid/Ramadan dates during Sprint 2 QA. |
| 9 | **User data privacy breach (partner profile, memories)** | LOW (10%) | CRITICAL | 5/10 | End-to-end encryption at rest (user-specific keys). Firebase Auth security rules. No partner-facing features (architectural decision W-06). Biometric app lock. GDPR/PDPA-compliant data export. Penetration testing before beta. |
| 10 | **Free tier is too generous, killing conversion** | MEDIUM (35%) | MEDIUM | 4/10 | Free tier limits calibrated per Feature Backlog: 5 messages/month, 1 card/day, 1 SOS/month, 10 memories. Monitor conversion triggers during beta. Adjustment levers documented: message limit (5->3), card limit (1->1 every other day). A/B test paywall triggers during beta. |

---

## Section 5: Definition of Done

### 5.1 Per-Sprint Milestones

#### Sprint 1 Milestone: "Walking Skeleton"

| Criterion | Measurement | Pass/Fail |
|-----------|-------------|-----------|
| User can create account via Google, Apple, or email | Manual test on iOS + Android | Binary |
| Language selection changes entire app locale including RTL | Visual verification in EN, AR, MS | Binary |
| Onboarding flow completes in under 2 minutes | Stopwatch test with 3 testers | < 2 min |
| Partner profile saved to Firestore and retrievable | API test + UI verification | Binary |
| Home dashboard loads in under 2 seconds | Performance profiling on mid-range device | < 2s |
| Bottom navigation works across all 5 tabs | Manual test | Binary |
| Push notification delivered on both platforms | FCM/APNs delivery confirmation | Binary |
| Paywall screen displays with correct regional pricing | Visual verification per locale | Binary |
| Zero crashes during 50-tap stress test | Crash monitoring | 0 crashes |

#### Sprint 2 Milestone: "Intelligent Foundation"

| Criterion | Measurement | Pass/Fail |
|-----------|-------------|-----------|
| Zodiac selection auto-populates personality traits | Test all 12 signs | Binary |
| Birthday reminder fires at correct escalation intervals | Schedule simulation test | Binary |
| Islamic holidays auto-populated for Gulf/Malay contexts | Calendar verification by cultural advisor | Binary |
| AI message generates in under 5 seconds | P95 latency measurement over 50 requests | < 5s |
| AI message references partner name and context | Sample 20 messages, verify personalization | 100% |
| 3 message modes produce distinct tone/content | Blind comparison test (5 reviewers) | Distinguishable |
| Streak counter increments and persists across sessions | Multi-day simulation | Binary |
| XP awards match defined values per action | Unit test coverage | 100% |
| App lock prevents unauthorized access | Test biometric + PIN + background timeout | Binary |

#### Sprint 3 Milestone: "Feature Complete Core"

| Criterion | Measurement | Pass/Fail |
|-----------|-------------|-----------|
| All 10 message modes operational | Generate 1 message per mode | Binary |
| Trilingual generation passes quality gate (4.0+/5.0) | Native speaker panel: 20 msgs/mode/language | Average >= 4.0 |
| Daily action card delivered at configured time | 3-day observation test | Binary |
| All 4 card types (SAY/DO/BUY/GO) display correctly | Visual + functional test | Binary |
| Gift Engine generates 5-10 suggestions per request | 10 test requests with varying inputs | Binary |
| Low Budget High Impact mode returns gifts under threshold | Budget filter verification | Binary |
| Promise tracker fires overdue reminders | Schedule simulation | Binary |
| Consistency Score calculates correctly from component data | Unit test with known inputs | Binary |
| Memory Vault entries encrypted and searchable | Encryption verification + search test | Binary |
| Content safety: zero violations in 50-sample audit | AI Content Guidelines checklist | 0 violations |

#### Sprint 4 Milestone: "Beta Ready"

| Criterion | Measurement | Pass/Fail |
|-----------|-------------|-----------|
| SOS Mode accessible in 2 taps from any screen | Navigation test from 10 different screens | < 2 taps |
| SOS AI coaching response in under 3 seconds | P95 latency over 20 crisis scenarios | < 3s |
| SOS "SAY THIS / DON'T SAY THIS" format correct | Visual + content review | Binary |
| Occasion gift packages include all components | Test 7 occasion types | Binary |
| Ramadan mode adjusts tone and suggestions | Content review during simulated Ramadan context | Binary |
| Full regression: all 38 Must Have features functional | Complete test suite | 100% pass |
| Performance: launch < 3s, dashboard < 2s, AI < 5s | Profiling on mid-range device | All pass |
| Crash rate < 0.1% across 100 test sessions | Crash monitoring | < 0.1% |
| Beta builds uploaded to TestFlight + Play Internal | Build verification | Binary |
| Trilingual final review: zero critical issues | Cultural advisor sign-off | Binary |

### 5.2 Quality Gates

Each sprint must pass these quality gates before the team advances:

| Gate | Criteria | Owner | Enforcement |
|------|----------|-------|-------------|
| **Code Review** | All PRs reviewed by at least 1 engineer + Tech Lead approval for architecture-impacting changes | Omar Al-Rashidi | PR merge blocked without approval |
| **Unit Test Coverage** | Domain layer: 90%+ coverage. Data layer: 80%+. Presentation layer: 60%+ (widget tests) | QA-1 + All engineers | CI pipeline blocks merge below threshold |
| **Localization Completeness** | Every user-facing string exists in all 3 ARB files. No hardcoded strings in Dart code | QA-1 + Lina Vazquez | Lint rule + manual audit |
| **RTL Layout** | Every new screen verified in Arabic RTL mode. No truncation, overlap, or misalignment | Lina Vazquez | RTL screenshot comparison |
| **AI Content Safety** | All AI output types audited against AI Content Guidelines absolute prohibitions | Dr. Elena Vasquez (PSY) | Written sign-off required |
| **Performance** | No regression on app launch time, dashboard load time, or AI response time | QA-1 | Automated performance test suite |
| **Accessibility** | Touch targets >= 48dp. Contrast ratios >= AA. Screen reader labels on interactive elements | Lina Vazquez | Accessibility audit checklist |

### 5.3 Go/No-Go Criteria Between Sprints

| Transition | Go Criteria | No-Go Trigger | Escalation Path |
|------------|-------------|---------------|-----------------|
| Sprint 1 -> Sprint 2 | Auth works on both platforms. Onboarding complete. Dashboard renders. Notifications deliver. RTL functional. | Auth fails on one platform. RTL layout fundamentally broken. Notification delivery < 90%. | Extend Sprint 1 by 3 days. Defer paywall polish to Sprint 2. |
| Sprint 2 -> Sprint 3 | AI message engine operational with < 5s latency. 3 modes generate distinct content. Reminders schedule correctly. Gamification tracks accurately. | AI engine latency > 8s at P95. AI output quality < 3.5/5.0. Reminder scheduling has > 5% failure rate. | Extend Sprint 2 by 3 days. Dedicate Sprint 3 first 2 days to AI latency optimization. |
| Sprint 3 -> Sprint 4 | All 10 modes work. Trilingual passes 4.0 threshold. Action cards generate daily. Gift engine returns relevant results. | Trilingual quality < 3.5/5.0 in any language. Action card generation fails > 10% of the time. | Extend Sprint 3 by 3 days. Defer 2 message modes to Sprint 4. Dedicate Sprint 4 to AI quality. |
| Sprint 4 -> Beta | SOS Mode works in < 3s. All 38 Must Have features pass regression. Crash rate < 0.1%. Content safety audit clean. | SOS coaching has content safety violation. Crash rate > 1%. Any Must Have feature non-functional. | Delay beta by 1 week. Emergency bug-fix sprint. No-launch on unresolved safety violations. |

---

## Section 6: Phase 2 Preview

### What Comes After Phase 1 Discovery (Weeks 1-8) and Development (Weeks 9-16)

Phase 1 Discovery (Weeks 1-8) produced 23 deliverables that define what LOLO is, who it serves, and how it works. The development sprints (Weeks 9-16) covered in this document turn those deliverables into a working beta application. Here is what follows.

### Phase 2: Closed Beta & Iteration (Weeks 17-20)

| Activity | Description | Owner |
|----------|-------------|-------|
| **Closed Beta Deployment** | Deploy beta to 50 users per market (150 total): 50 EN (US/UK), 50 AR (GCC), 50 MS (Malaysia). Recruited during Weeks 12-14. | Sarah Chen + Marketing |
| **User Feedback Collection** | In-app feedback widget, weekly survey, 1:1 interviews with 5 users per market. Focus: AI message quality, action card relevance, SOS Mode effectiveness, cultural appropriateness. | Sarah Chen |
| **AI Quality Iteration** | Rapid prompt refinement based on user feedback. Target: raise average message quality rating from 4.0 to 4.5/5.0. Focus on Arabic dialect naturalness and Malay colloquial tone. | Dr. Aisha Mahmoud |
| **Performance Optimization** | Address latency, memory, and crash issues identified during beta. Target: AI response P95 < 3s (from 5s), app size < 50MB. | Omar Al-Rashidi |
| **Should Have Feature Completion** | Any Should Have features deferred from Sprints 3-4 are completed: Calendar Sync (S-13), Gift Engine Regional Affiliates (S-15), remaining UI polish. | Engineering team |
| **Localization Polish** | Final round of native speaker reviews. Fix any dialectal or cultural issues identified by beta users. Complete AR/MS localization for any English-only Should Have features. | Lina Vazquez + Cultural Advisors |

### Phase 3: Launch Preparation (Weeks 21-24)

| Activity | Description |
|----------|-------------|
| **App Store Optimization (ASO)** | Keywords, screenshots, descriptions in EN/AR/MS. A/B test store listings. |
| **Marketing Campaign Prep** | Content marketing (blog, social media, influencer partnerships per market). Landing page. Press kit. |
| **Legal & Compliance** | Privacy policy (GDPR, PDPA), Terms of Service, app store compliance review. |
| **Monetization Finalization** | Confirm pricing, free trial flow, paywall trigger calibration based on beta data. |
| **Public Launch** | Phased rollout: EN market first (Week 23), AR market (Week 24), MS market (Week 24). |

### Phase 4: Post-Launch (Weeks 25+)

| Priority | Feature / Initiative |
|----------|---------------------|
| HIGH | Indonesian language support (W-11) -- 50M+ addressable market |
| HIGH | Home screen widget (C-16) -- high engagement potential |
| HIGH | Achievement badges (C-10) -- gamification depth |
| MEDIUM | Stealth Mode (C-01) -- app rename + icon swap for AR/MS privacy |
| MEDIUM | AI Memory Surfacing (C-02) -- "Remember when..." triggers |
| MEDIUM | Date Night Planner (C-05) -- end-to-end date flow |
| MEDIUM | Conversation Starters Library (C-14) -- browsable question bank |
| LOW | Relationship Timeline (C-08) -- visual milestone chronology |
| LOW | Voice-to-Text Memory Logging (C-03) -- speech-to-text in 3 languages |
| DEFERRED | Community / Forum (W-01) -- requires content moderation infrastructure |
| DEFERRED | Expert Q&A (W-02) -- requires coach recruitment and vetting |
| NEVER | Partner-Facing Features (W-06) -- architectural principle, not a deferral |
| NEVER | Social Sharing / Leaderboards (W-07) -- privacy-first design principle |

---

## Document Appendix: Deliverable Cross-Reference Matrix

This matrix maps each Phase 1 deliverable to the sprint tasks that consume it, ensuring no deliverable is orphaned and no sprint task lacks its required input.

| Deliverable | Sprint 1 Tasks | Sprint 2 Tasks | Sprint 3 Tasks | Sprint 4 Tasks |
|-------------|---------------|---------------|---------------|---------------|
| Competitive Analysis | S1-01 (market context) | -- | -- | -- |
| Competitive UX Audit | S1-01 (design patterns) | -- | -- | -- |
| Emotional State Framework | -- | S2-07, S2-08 | S3-01, S3-02, S3-04 | S4-03, S4-09 |
| Zodiac Master Profiles | -- | S2-01 | S3-04 | -- |
| App Concept Validation | S1-04 (onboarding tone) | -- | -- | -- |
| User Personas | S1-04, S1-05, S1-07 | S2-03, S2-04, S2-11 | S3-05, S3-06 | S4-01, S4-03 |
| Sign Cheat Sheets | -- | S2-01 | S3-04 | -- |
| Situation-Response Matrix | -- | -- | -- | S4-02, S4-03 |
| Feature Backlog (MoSCoW) | All tasks (scope) | All tasks (scope) | All tasks (scope) | All tasks (scope) |
| Architecture Document | S1-01, S1-02, S1-06, S1-09, S1-10 | S2-07 | -- | -- |
| Localization Architecture | S1-01, S1-03 | S2-05, S2-13 | S3-02, S3-12 | S4-12 |
| "What She Actually Wants" | -- | -- | S3-04, S3-06 | S4-04 |
| Arabic Women's Perspective | -- | S2-03, S2-05 | S3-02, S3-06, S3-12 | S4-03, S4-08 |
| Malay Women's Perspective | -- | S2-03 | S3-02, S3-06, S3-12 | S4-03 |
| Compatibility Pairings | -- | S2-01 | S3-02 | -- |
| Wireframe Specs | S1-03, S1-04, S1-07, S1-08 | S2-02, S2-04, S2-06, S2-12 | S3-03, S3-05, S3-10 | S4-01, S4-02, S4-04 |
| AI Strategy | -- | S2-07, S2-08 | S3-01, S3-02, S3-04, S3-06 | S4-03 |
| Multi-Language Prompt Strategy | -- | S2-08 | S3-01, S3-02 | S4-08, S4-09 |
| Cultural Sensitivity Guide | -- | S2-03 | S3-05, S3-06, S3-12 | S4-03, S4-08 |
| Gift Feedback Framework | -- | -- | S3-06 | S4-10 |
| Action Card Validation | -- | -- | S3-04, S3-05 | -- |
| AI Content Guidelines | -- | S2-07 | S3-01, S3-02, S3-12 | S4-03, S4-09, S4-12 |
| Design System + UI String Catalog | S1-01, S1-03, S1-04, S1-07, S1-08 | S2-01, S2-02, S2-12 | S3-03, S3-05, S3-10 | S4-01, S4-04, S4-12 |

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | February 14, 2026 | Sarah Chen, Product Manager | Initial final sprint plan. All 23 Phase 1 deliverables reviewed and cross-referenced. 4 sprints defined (Weeks 9-16). Resource allocation, risk register, quality gates, and Phase 2 preview included. |

---

*Sarah Chen, Product Manager*
*LOLO -- "She won't know why you got so thoughtful. We won't tell."*

---

### References

- LOLO Competitive Analysis (Sarah Chen, Feb 2026)
- LOLO Competitive UX Audit (Lina Vazquez, Feb 2026)
- LOLO Emotional State Framework (Dr. Elena Vasquez, Feb 2026)
- LOLO Zodiac Master Profiles (Astrologist Advisory, Feb 2026)
- LOLO App Concept Validation (Nadia Khalil, Feb 2026)
- LOLO User Personas & Journey Maps (Sarah Chen, Feb 2026)
- LOLO Sign Cheat Sheets (Astrologist Advisory, Feb 2026)
- LOLO Situation-Response Matrix (Dr. Elena Vasquez, Feb 2026)
- LOLO Feature Backlog MoSCoW (Sarah Chen, Feb 2026)
- LOLO Architecture Document (Omar Al-Rashidi, Feb 2026)
- LOLO Localization Architecture (Omar Al-Rashidi, Feb 2026)
- LOLO "What She Actually Wants" (Nadia Khalil, Feb 2026)
- LOLO Arabic Women's Perspective (Nadia Khalil, Feb 2026)
- LOLO Malay Women's Perspective (Nadia Khalil, Feb 2026)
- LOLO Compatibility Pairings (Astrologist Advisory, Feb 2026)
- LOLO Wireframe Specifications (Lina Vazquez, Feb 2026)
- LOLO AI Strategy Document (Dr. Aisha Mahmoud, Feb 2026)
- LOLO Multi-Language Prompt Strategy (Dr. Aisha Mahmoud, Feb 2026)
- LOLO Cultural Sensitivity Guide (Nadia Khalil, Feb 2026)
- LOLO Gift Feedback Framework (Nadia Khalil, Feb 2026)
- LOLO Action Card Validation (Nadia Khalil, Feb 2026)
- LOLO AI Content Guidelines (Dr. Elena Vasquez, Feb 2026)
- LOLO Design System + UI String Catalog (Lina Vazquez, Feb 2026)
