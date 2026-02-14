# HORMONES - Comprehensive Project Plan
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

---

# 1. EXECUTIVE SUMMARY

**Product Name:** Hormones
**Tagline:** "She won't know why you got so thoughtful. We won't tell."
**Category:** Lifestyle / Relationship Intelligence
**Platforms:** Android (primary), iOS (Phase 2), Wear OS / WatchOS (Phase 3)
**Target Market:** Men aged 22-55 in committed relationships
**Business Model:** Freemium + Affiliate Revenue + In-App Purchases

**Unique Value Proposition:**
The first AI-powered relationship assistant that combines personality profiling (zodiac, love language, cultural background), smart reminders, AI-generated personalized messages, gift recommendations, and an emergency "SOS Mode" — all in one app designed specifically to help men become more thoughtful partners.

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

### Module 2: AI Message Generator
- AI-generated love messages tailored to her personality profile
- Context-aware messages (morning, goodnight, random, apology, celebration)
- Tone adjustment (romantic, funny, poetic, casual, formal)
- Multi-language support
- Message scheduling and auto-send via SMS/WhatsApp integration
- Copy-to-clipboard for manual sending

### Module 3: Her Profile Engine (Personality Intelligence)
- Zodiac sign & compatibility analysis
- Love Language assessment (Words, Touch, Gifts, Acts, Quality Time)
- Age & relationship stage awareness
- Cultural background & tradition tracking
- Interests, hobbies, and favorites database
- Food preferences & dietary restrictions
- Fashion style & size tracking (for gift accuracy)
- Mood pattern tracking (optional)

### Module 4: Gift Recommendation Engine
- AI-powered gift suggestions based on:
  - Her personality profile (zodiac, interests, love language)
  - Budget range (user-defined)
  - Location-based availability (local shops, online delivery)
  - Occasion type (birthday, anniversary, apology, "just because")
- Affiliate integration with e-commerce platforms
- Price comparison across vendors
- One-tap gift ordering
- Gift history tracking (avoid duplicates)

### Module 5: SOS Mode (Emergency Relationship Assist)
- "She's Upset" quick assessment wizard
- Situation-based AI response generator
- "I Forgot Our Anniversary" damage-control protocol
- Real-time conversation coach ("What should I say?")
- Instant gift/flower delivery integration
- Apology message generator with escalation levels

### Module 6: Gamification & Engagement
- Thoughtfulness Streak tracker
- Points system for completed relationship "missions"
- Levels: Rookie > Good Partner > Thoughtful Husband > Legend
- Monthly thoughtfulness score with trends
- Weekly challenges ("Surprise her with breakfast this week")
- Achievement badges

### Module 7: Community (Phase 2)
- Anonymous tips board
- Success stories & testimonials
- Weekly curated relationship advice
- Expert Q&A sessions

### Module 8: Smartwatch Companion (Phase 3)
- Discreet wrist-tap notifications
- Quick-reply AI messages from watch
- Daily thoughtfulness streak display
- Wear OS + WatchOS support

---

## 2.2 Technical Architecture Overview

```
+--------------------------------------------------+
|                  CLIENT LAYER                     |
|  Android App (Kotlin + Jetpack Compose)           |
|  iOS App (Swift + SwiftUI) [Phase 2]              |
|  Wear OS / WatchOS App [Phase 3]                  |
+--------------------------------------------------+
                        |
                    REST API / GraphQL
                        |
+--------------------------------------------------+
|                BACKEND LAYER                      |
|  API Gateway (Node.js / Kotlin Ktor)              |
|  Authentication Service (Firebase Auth)           |
|  Notification Service (FCM + APNs)                |
|  Scheduling Engine (Cron / WorkManager)           |
+--------------------------------------------------+
                        |
+--------------------------------------------------+
|                 AI LAYER                          |
|  Claude API / OpenAI API                          |
|  Prompt Engineering Service                       |
|  Personality Analysis Engine                      |
|  Gift Recommendation ML Pipeline                  |
+--------------------------------------------------+
                        |
+--------------------------------------------------+
|                DATA LAYER                         |
|  Firebase Firestore (User Data)                   |
|  PostgreSQL (Relational Data)                     |
|  Redis (Caching & Sessions)                       |
|  Cloud Storage (Media Assets)                     |
+--------------------------------------------------+
                        |
+--------------------------------------------------+
|             THIRD-PARTY INTEGRATIONS              |
|  Google Calendar API                              |
|  WhatsApp Business API                            |
|  E-commerce Affiliate APIs                        |
|  Payment Gateway (Stripe / Google Pay)            |
|  Flower/Gift Delivery APIs                        |
|  Astrology/Zodiac Data API                        |
+--------------------------------------------------+
```

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

**Milestone:** Approved architecture + wireframes + sprint backlog + domain expert frameworks complete

---

## Phase 2: UI/UX Design (Weeks 5-8)

| Week | Activity | Deliverables | Team Involved |
|------|----------|-------------|---------------|
| 5-6 | High-fidelity UI design | All screen designs (Figma) | UX/UI Designer |
| 5 | Brand identity finalization | Logo, icon, color system, typography | UX/UI Designer |
| 6 | Interactive prototype | Clickable prototype for user testing | UX/UI Designer |
| 7 | User testing (10-15 men) | User feedback report | UX/UI Designer, Product Manager |
| 7 | Design iteration based on feedback | Revised designs | UX/UI Designer |
| 8 | Design handoff to development | Annotated designs, asset export | UX/UI Designer |
| 8 | API contract definition | API documentation (Swagger/OpenAPI) | Tech Lead, Backend Developer |

**Milestone:** Final approved designs + API contracts ready

---

## Phase 3: MVP Development - Sprint 1-4 (Weeks 9-16)

### Sprint 1 (Weeks 9-10): Foundation
| Task | Owner |
|------|-------|
| Project setup (Kotlin, Jetpack Compose, dependency injection) | Android Developer |
| Firebase setup (Auth, Firestore, FCM) | Backend Developer |
| Navigation framework + base UI components | Android Developer |
| User authentication (email, Google, Apple Sign-In) | Backend Developer |
| CI/CD pipeline setup | DevOps / Tech Lead |
| Database schema design & implementation | Backend Developer |

### Sprint 2 (Weeks 11-12): Core Features Part 1
| Task | Owner |
|------|-------|
| Onboarding flow (user profile + her profile setup) | Android Developer |
| Her Profile Engine (zodiac, love language, preferences) | Android Developer + Backend |
| Smart Reminder Engine (date tracking, notifications) | Android Developer |
| Calendar sync integration (Google Calendar) | Backend Developer |
| Push notification system | Backend Developer |
| Unit tests for core logic | QA Engineer |

### Sprint 3 (Weeks 13-14): Core Features Part 2
| Task | Owner |
|------|-------|
| AI Message Generator integration (Claude/OpenAI API) | AI/ML Engineer + Backend |
| Prompt engineering for personality-based messages | AI/ML Engineer |
| Message UI (categories, tone selection, copy/share) | Android Developer |
| Gift Recommendation Engine (basic version) | AI/ML Engineer + Backend |
| Settings & preferences screens | Android Developer |
| Integration testing | QA Engineer |

### Sprint 4 (Weeks 15-16): Polish & MVP Completion
| Task | Owner |
|------|-------|
| SOS Mode (basic: upset detection + message generation) | AI/ML Engineer + Android |
| Gamification system (streaks, points, levels) | Android Developer |
| Payment integration (Stripe / Google Play Billing) | Backend Developer |
| Subscription management (Free / Pro tiers) | Backend Developer |
| End-to-end testing | QA Engineer |
| Performance optimization | Android Developer + Tech Lead |
| Bug fixes from QA | All developers |

**Milestone:** MVP feature-complete, internal testing passed

---

## Phase 4: Testing & QA (Weeks 17-19)

| Week | Activity | Deliverables |
|------|----------|-------------|
| 17 | Comprehensive QA testing | Bug report + severity classification |
| 17 | Security audit (data privacy, encryption) | Security assessment report |
| 18 | Beta release (closed group: 50-100 users) | Beta APK distribution |
| 18 | Performance testing (load, battery, memory) | Performance benchmark report |
| 19 | Beta feedback collection & analysis | Feedback summary + priority fixes |
| 19 | Critical bug fixes + final polish | Release candidate build |

**Milestone:** Release candidate approved

---

## Phase 5: Launch (Weeks 20-22)

| Week | Activity | Deliverables |
|------|----------|-------------|
| 20 | App Store Optimization (ASO) | Store listing (screenshots, description, keywords) |
| 20 | Google Play Store submission | Published app (under review) |
| 21 | Marketing launch campaign | Social media, influencer outreach, PR |
| 21 | Monitor crash reports & analytics | Firebase Crashlytics dashboard |
| 22 | First patch release (based on launch feedback) | v1.0.1 update |
| 22 | Post-launch retrospective | Lessons learned document |

**Milestone:** Live on Google Play Store with stable v1.0

---

## Phase 6: Post-Launch Growth (Weeks 23-36)

| Period | Focus | Key Deliverables |
|--------|-------|-----------------|
| Weeks 23-26 | Iteration based on user feedback | v1.1 with top-requested improvements |
| Weeks 23-26 | Affiliate partnerships | Signed agreements with gift/flower vendors |
| Weeks 27-30 | Community features (anonymous tips, success stories) | v1.2 with social features |
| Weeks 27-30 | iOS development begins | iOS project setup + core module porting |
| Weeks 31-36 | Smartwatch companion app | Wear OS companion app v1.0 |
| Weeks 31-36 | Advanced AI features | Enhanced personality engine, mood prediction |

---

## Timeline Summary (Visual)

```
Month 1       Month 2       Month 3       Month 4       Month 5       Month 6-9
[Discovery]   [UI/UX]       [Dev Sprint   [Dev Sprint   [QA &         [Post-Launch
 & Planning    Design        1 & 2]        3 & 4]        Launch]        & Growth]
    |             |             |             |             |              |
    v             v             v             v             v              v
 Research      Figma         Foundation    AI + Gifts    Beta Test     iOS + Watch
 Wireframes    Prototype     Reminders     SOS Mode      Go Live!      Community
 Architecture  User Tests    Her Profile   Gamification  ASO           Affiliates
```

**Total MVP Timeline: ~22 weeks (5.5 months)**
**Full Product (all platforms): ~9 months**

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
|Sr.Android| |  Designer   |  |  Engineer  |  |  Experts   |  | ing   |
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
| 2 | **Tech Lead / Senior Android Developer** | Full-time | Phase 2-6 | Weeks 5-36 |
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

> **Why Domain Experts are Non-Negotiable:** Without these 3 specialists, the AI generates generic internet-level advice. With them, Hormones delivers clinically-informed, astrologically-accurate, and emotionally-authentic content that no competitor can replicate. They are the app's **unfair advantage**.

---

## 4.3 Team Phasing (When to Hire)

```
Week 1  ====> Product Manager + UX/UI Designer
Week 1  ====> Psychiatrist + Astrologist + Female Consultant (Domain Advisory Board)
Week 5  ====> Tech Lead / Senior Android Developer
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

**Job Title:** Product Manager - Hormones App
**Department:** Product
**Reports To:** Founder / Product Owner
**Employment Type:** Full-Time

### Role Summary
The Product Manager owns the product vision, roadmap, and backlog for the Hormones app. This person is the bridge between business goals, user needs, and the engineering team. They translate the founder's vision into actionable user stories, prioritize features, and ensure timely delivery of a product that users love.

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

## 5.2 Tech Lead / Senior Android Developer

**Job Title:** Tech Lead & Senior Android Developer
**Department:** Engineering
**Reports To:** Product Manager
**Employment Type:** Full-Time

### Role Summary
The Tech Lead is the technical authority on the project. They architect the Android application, make technology decisions, write core code, conduct code reviews, and mentor the development team. This is a hands-on leadership role — expect 60% coding, 40% leadership.

### Key Responsibilities

**Technical Architecture**
- Design and own the overall Android application architecture (MVVM + Clean Architecture)
- Select and standardize the tech stack (Kotlin, Jetpack Compose, Hilt, Room, Retrofit, etc.)
- Design modular architecture for scalability (feature modules)
- Define coding standards, branching strategy, and PR review process
- Architect offline-first data strategy with local caching
- Design the notification scheduling system (WorkManager + AlarmManager)

**Hands-On Development**
- Build core UI framework using Jetpack Compose
- Implement navigation architecture (Compose Navigation)
- Develop the Her Profile Engine and personality data models
- Build the Smart Reminder Engine with local + cloud scheduling
- Implement gamification system (streaks, points, levels)
- Integrate payment system (Google Play Billing Library)

**Technical Leadership**
- Conduct code reviews for all PRs (enforce quality standards)
- Architect CI/CD pipeline (GitHub Actions / Bitrise / Fastlane)
- Define testing strategy (unit, integration, UI tests)
- Make buy-vs-build decisions for third-party libraries
- Manage technical debt and refactoring priorities
- Write and maintain technical documentation

**Performance & Security**
- Ensure app meets performance benchmarks (startup < 2s, smooth 60fps)
- Implement encryption for sensitive user data (her profile data)
- Manage ProGuard/R8 configuration for release builds
- Monitor and optimize app size, memory usage, and battery consumption

**Collaboration**
- Translate UI designs into technical implementation plans
- Work with AI/ML Engineer on API integration patterns
- Coordinate with Backend Developer on API contracts
- Estimate development effort for sprint planning

### Tech Stack Ownership
- **Language:** Kotlin (100%)
- **UI:** Jetpack Compose + Material 3
- **Architecture:** MVVM + Clean Architecture + Repository Pattern
- **DI:** Hilt / Dagger
- **Local DB:** Room
- **Networking:** Retrofit + OkHttp + Kotlin Coroutines + Flow
- **Navigation:** Compose Navigation
- **Testing:** JUnit 5, MockK, Espresso, Compose Testing
- **CI/CD:** GitHub Actions / Fastlane

---

## 5.3 UX/UI Designer

**Job Title:** Senior UX/UI Designer - Mobile
**Department:** Design
**Reports To:** Product Manager
**Employment Type:** Full-Time (Weeks 1-22), Part-Time (Weeks 23+)

### Role Summary
The UX/UI Designer creates the entire visual experience of Hormones — from first impression to daily interaction. This role requires someone who can craft a premium, masculine-yet-warm design language that men feel comfortable using. The app must feel like a "secret weapon," not a couples therapy tool.

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

**Brand Identity**
- Define visual brand identity for Hormones
- Design logo (primary + icon variants)
- Create marketing materials (store screenshots, feature graphics)
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
The Backend Developer builds and maintains the server-side infrastructure that powers Hormones. This includes user data management, notification scheduling, calendar synchronization, payment processing, third-party API integrations, and the API layer consumed by the mobile app.

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
- Build data migration scripts
- Implement Redis caching for frequently accessed data
- Design backup and recovery procedures

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

**Third-Party Integrations**
- Google Calendar API integration (read/write sync)
- Payment processing (Stripe + Google Play Billing verification)
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
- **Runtime:** Node.js (TypeScript) or Kotlin (Ktor)
- **Database:** PostgreSQL + Firebase Firestore
- **Cache:** Redis
- **Auth:** Firebase Authentication
- **Cloud:** Google Cloud Platform or AWS
- **Notifications:** Firebase Cloud Messaging + Twilio
- **Payments:** Stripe + Google Play Billing Library
- **Monitoring:** Sentry, Cloud Logging, Firebase Crashlytics

---

## 5.5 AI/ML Engineer

**Job Title:** AI/ML Engineer
**Department:** Engineering / AI
**Reports To:** Tech Lead
**Employment Type:** Full-Time

### Role Summary
The AI/ML Engineer is the brain behind what makes Hormones unique. This person designs the AI systems that generate personalized messages, recommend gifts, power the SOS mode, and analyze personality profiles. They work at the intersection of prompt engineering, API integration, and data science to deliver genuinely personalized, emotionally intelligent AI outputs.

### Key Responsibilities

**AI Message Generation System**
- Design prompt engineering architecture for Claude/OpenAI API
- Build dynamic prompt templates that incorporate:
  - Partner personality profile (zodiac, love language, age, interests)
  - Context (occasion type, time of day, relationship stage)
  - Tone preference (romantic, funny, poetic, casual)
  - Message history (avoid repetition)
- Implement message quality scoring and filtering
- Build A/B testing framework for prompt variations
- Optimize API costs through prompt efficiency and caching
- Handle edge cases (inappropriate content filtering, cultural sensitivity)

**Personality Analysis Engine**
- Design the personality profiling algorithm combining:
  - Zodiac characteristics and compatibility scores
  - Love Language assessment and scoring
  - Cultural background-specific patterns
  - Age-appropriate communication styles
- Build personality vector representations for recommendation matching
- Implement personality insight generation ("She values acts of service most")

**Gift Recommendation Engine**
- Design recommendation algorithm incorporating:
  - Personality profile matching
  - Budget constraints
  - Location-based availability
  - Occasion appropriateness
  - Gift history (avoid repeats)
  - Seasonal and trending items
- Build and maintain gift catalog data pipeline
- Integrate with e-commerce affiliate APIs for real-time pricing/availability
- Implement collaborative filtering (popular gifts for similar profiles)

**SOS Mode AI System**
- Design the "She's Upset" assessment flow (quick diagnostic questions)
- Build situation classification model (forgot anniversary, argument, neglect, etc.)
- Create response generation system with escalation levels
- Design real-time conversation coaching prompts
- Build damage-control action plan generator

**Optimization & Cost Management**
- Monitor and optimize AI API costs (token usage, caching strategies)
- Implement response caching for common scenarios
- Build fallback systems (if primary AI is down, serve cached/template responses)
- Track AI output quality metrics (user ratings, message send rates)
- Implement content safety filters

**Data & Analytics**
- Define and track AI-specific KPIs:
  - Message generation success rate
  - Message send-through rate (generated vs. actually sent)
  - Gift recommendation click-through rate
  - SOS Mode usage and satisfaction
  - AI cost per user per month
- Build analytics dashboards for AI performance
- Conduct regular prompt optimization based on data

### Tech Stack
- **AI APIs:** Claude API (Anthropic) / OpenAI API
- **Language:** Python (prompt engineering, data pipelines) + Kotlin/TypeScript (service layer)
- **Prompt Management:** LangChain or custom prompt templating
- **Vector DB:** Pinecone or Weaviate (for personality matching)
- **Analytics:** Custom dashboards + Firebase Analytics
- **Content Safety:** Custom filters + API-provided safety layers

---

## 5.6 QA Engineer

**Job Title:** QA Engineer (Mobile)
**Department:** Quality Assurance
**Reports To:** Tech Lead
**Employment Type:** Full-Time (Weeks 9-22), Part-Time (Weeks 23+)

### Role Summary
The QA Engineer ensures every feature of Hormones works flawlessly before it reaches users. Given the personal and sensitive nature of the app (partner data, reminders for important dates, AI messages), quality is non-negotiable — a missed anniversary reminder or an inappropriate AI message could directly damage a user's relationship.

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
- Validate edge cases (no internet, low battery, app killed by system)

**Test Automation**
- Build and maintain automated test suite:
  - Unit tests (JUnit 5 + MockK)
  - Integration tests (API contract testing)
  - UI tests (Espresso + Compose Testing)
  - End-to-end tests (critical user journeys)
- Set up automated test runs in CI/CD pipeline
- Maintain test coverage metrics (target: 80%+ for core logic)

**Specialized Testing**
- **Notification testing:** Verify reminders fire at correct times across timezones
- **AI output testing:** Validate messages are appropriate, non-repetitive, and personality-aligned
- **Payment testing:** Sandbox testing for all subscription flows
- **Security testing:** Basic penetration testing, data leak verification
- **Performance testing:** App startup time, memory usage, battery drain
- **Accessibility testing:** Screen reader compatibility, font scaling
- **Localization testing:** Multi-language support validation

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
- **Automation:** JUnit 5, MockK, Espresso, Compose Test, Appium
- **API Testing:** Postman, REST Assured
- **Performance:** Android Profiler, Firebase Performance
- **CI Integration:** GitHub Actions
- **Device Testing:** Firebase Test Lab, BrowserStack

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
- Set up GitHub Actions (or Bitrise) for automated builds
- Configure automated testing on every PR
- Set up automated APK/AAB generation for testing and release
- Configure Fastlane for automated Play Store deployment
- Implement branch protection rules and merge requirements

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
- **CI/CD:** GitHub Actions, Fastlane
- **Cloud:** Google Cloud Platform / AWS
- **IaC:** Terraform or Pulumi
- **Containers:** Docker (if needed for backend)
- **Monitoring:** Firebase Crashlytics, Cloud Monitoring, Sentry
- **Security:** Cloud Secret Manager, Cloud Armor

---

## 5.8 Marketing Specialist

**Job Title:** Digital Marketing Specialist - Mobile App
**Department:** Marketing
**Reports To:** Product Manager / Founder
**Employment Type:** Part-Time (Weeks 17-22), Full-Time (Weeks 23+)

### Role Summary
The Marketing Specialist is responsible for building awareness, driving downloads, and growing the user base for Hormones. This role requires someone who understands the male audience, can create viral-worthy content, and knows the mobile app marketing ecosystem inside out.

### Key Responsibilities

**App Store Optimization (ASO)**
- Optimize Google Play Store listing (title, description, keywords)
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

**Launch Campaign**
- Plan and execute pre-launch buzz campaign
- Coordinate launch day activities
- Manage PR outreach (tech blogs, relationship media)
- Plan seasonal campaigns (Valentine's Day, Mother's Day, Christmas)

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
The Psychiatrist / Women's Psychology Expert is the scientific backbone of the Hormones app. This person ensures that all app content, AI responses, and feature behavior are grounded in real psychological understanding of women's emotional states across different life situations — menstrual cycles, pregnancy, postpartum, menopause, stress responses, grief, and daily emotional fluctuations. Their input directly trains the AI to respond with clinical accuracy rather than stereotypes.

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
The Professional Astrologist transforms Hormones from a generic reminder app into a deeply personalized experience. This person builds the zodiac intelligence layer — defining how each sign thinks, loves, communicates, gets angry, and wants to be appreciated. Their work feeds directly into the AI message generator, gift recommendation engine, and personality profiling system, making every output feel eerily accurate to the user's partner.

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
  - Religious considerations (modesty, public affection norms)
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
6. **Female Focus Group Report** (Week 18) — beta testing from the female perspective
7. **Monthly Authenticity Audit** (ongoing) — ongoing review that new content passes the "real woman" test

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

## 6.2 Tech Lead / Senior Android Developer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science, Software Engineering, or related field |
| **Min. Experience** | 5-7 years in Android development, 2+ years in a tech lead role |
| **Language Mastery** | Expert-level Kotlin (not Java-first developers) |
| **UI Framework** | 2+ years with Jetpack Compose (production apps) |
| **Architecture** | Proven experience with MVVM + Clean Architecture at scale |
| **APIs** | Experience integrating REST APIs with Retrofit + Coroutines + Flow |
| **Database** | Proficient with Room, Firebase Firestore |
| **DI** | Expert with Hilt or Dagger 2 |
| **Testing** | Experience writing unit, integration, and UI tests |
| **CI/CD** | Experience setting up GitHub Actions or Bitrise |
| **Published Apps** | At least 2 production apps on Google Play Store |
| **Leadership** | Experience conducting code reviews and mentoring junior developers |
| **Nice to Have** | Experience with Wear OS development, Kotlin Multiplatform, AI API integration |

### Must-Have Competencies
- Has architected at least 1 Android app from scratch using modern stack
- Can design modular, scalable app architecture
- Comfortable making buy-vs-build decisions
- Strong understanding of Android performance optimization
- Experience with sensitive data handling and encryption

### Technical Assessment
Candidates should demonstrate:
1. Build a small Compose app with MVVM + Hilt in a take-home test
2. Architecture whiteboard session (design the reminder scheduling system)
3. Code review exercise (review a PR with intentional issues)

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
| **Platform Knowledge** | Deep understanding of Material Design 3 guidelines |
| **Handoff** | Experience working closely with Android developers on implementation |
| **Motion Design** | Ability to design micro-interactions and animations |
| **Nice to Have** | Experience with male-targeted consumer apps, illustration skills, Lottie animations |

### Must-Have Competencies
- Portfolio shows modern, clean, premium mobile designs (not web-converted-to-mobile)
- Can design end-to-end flows, not just individual screens
- Experience designing onboarding flows with high completion rates
- Understanding of accessibility standards (WCAG)
- Ability to design for emotion (the app should feel warm but not "girly")

### Design Challenge
Candidates should complete:
1. Design the Hormones onboarding flow (5-7 screens) in Figma
2. Present design rationale and decisions
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
| **Min. Experience** | 3-5 years in AI/ML engineering, 1+ year with LLM integration |
| **LLM Experience** | Hands-on experience with Claude API or OpenAI API (production usage required) |
| **Prompt Engineering** | Proven experience designing complex prompt chains with dynamic variables |
| **Python** | Strong Python skills for data processing and prompt engineering |
| **NLP** | Understanding of natural language processing concepts |
| **Recommendation Systems** | Experience building recommendation engines (collaborative or content-based filtering) |
| **API Integration** | Experience building AI service layers consumed by mobile/web apps |
| **Cost Optimization** | Experience managing and optimizing LLM API costs at scale |
| **Content Safety** | Experience implementing content moderation and safety filters |
| **Nice to Have** | Experience with LangChain, vector databases (Pinecone/Weaviate), fine-tuning models, sentiment analysis |

### Must-Have Competencies
- Has built at least 1 production system using LLM APIs
- Can design prompt templates that produce consistent, high-quality outputs
- Understands token optimization and caching strategies
- Experience with A/B testing AI outputs
- Ability to evaluate AI output quality systematically

### Technical Assessment
1. Design a prompt system that generates personalized love messages based on personality inputs (take-home)
2. Whiteboard: architect the SOS Mode assessment and response system
3. Discussion: how to handle AI hallucinations and inappropriate outputs in a relationship context

---

## 6.6 QA Engineer

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science, Software Engineering, or related field |
| **Min. Experience** | 3-4 years in mobile app QA (Android required) |
| **Manual Testing** | Expert in writing and executing test cases for Android apps |
| **Automation** | Proficient with Espresso, JUnit, and at least one mobile automation framework |
| **API Testing** | Experience testing REST APIs with Postman or REST Assured |
| **CI/CD** | Experience integrating automated tests into CI/CD pipelines |
| **Bug Management** | Proficient with Jira or similar bug tracking tools |
| **Device Testing** | Experience testing across multiple Android versions and device types |
| **Performance** | Basic experience with Android Profiler and performance testing |
| **Nice to Have** | Experience with Compose Testing, Firebase Test Lab, accessibility testing, security testing basics |

### Must-Have Competencies
- Has QA'd at least 1 Android app through full release cycle
- Can create comprehensive test plans from user stories
- Comfortable with both manual and automated testing
- Attention to detail (critical for notification timing, AI output quality)
- Experience with timezone-related testing

---

## 6.7 DevOps Engineer (Contractor)

| Requirement | Details |
|------------|---------|
| **Education** | Bachelor's degree in Computer Science or related field |
| **Min. Experience** | 3-5 years in DevOps / Cloud Infrastructure |
| **Cloud** | Strong GCP or AWS experience (certified preferred) |
| **CI/CD** | Expert with GitHub Actions, plus experience with Fastlane for mobile |
| **IaC** | Terraform or Pulumi experience |
| **Monitoring** | Experience setting up Crashlytics, Cloud Monitoring, Sentry |
| **Security** | SSL, secrets management, firewall configuration |
| **Firebase** | Experience configuring Firebase projects at scale |
| **Nice to Have** | Docker, Kubernetes (if backend is containerized), GCP Professional certification |

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
| **Cultural Awareness** | Has lived in or extensively worked with people from multiple cultural backgrounds |
| **Digital Fluency** | Active on social media, understands modern relationship dynamics, memes, and trends |
| **Content Skills** | Can write, review, and edit emotional/relationship content |
| **Nice to Have** | Experience moderating focus groups, social media following in relationship/lifestyle space, multilingual, experience with product testing or UX research |

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
3. Evaluate the Hormones app concept from a woman's perspective: would she be flattered or offended if her partner used it?

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
| Tech Lead / Sr. Android Dev | $7,000 - $12,000 | 8 months | $56,000 - $96,000 |
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
| AI API costs (Claude/OpenAI) | $500 - $2,000 | $4,500 - $18,000 |
| Cloud infrastructure (GCP/AWS) | $200 - $1,000 | $1,800 - $9,000 |
| Third-party services (Twilio, etc.) | $100 - $500 | $900 - $4,500 |
| Tools & licenses (Figma, Jira, etc.) | $200 - $500 | $1,800 - $4,500 |
| Marketing ad budget | $2,000 - $10,000 | $10,000 - $50,000 |
| App Store fees | One-time $25 (Google) | $25 |
| **Subtotal** | | **$19,025 - $86,000** |

### Grand Total Estimated Budget: $351,000 - $747,400

> **Note:** These are estimates for remote/international team hiring. Costs vary significantly by region. Hiring tech team in South Asia or Eastern Europe can reduce technical team costs by 40-60%. Domain experts (especially the psychiatrist) command higher rates in Western markets but may be sourced globally. US/Western Europe based teams could be 2-3x higher.

> **Cost Optimization Tip:** Domain experts can be engaged on a deliverable-based contract rather than hourly. For example, pay the Astrologist a fixed fee of $15,000-$25,000 for delivering the complete zodiac content package, then a $2,000-$4,000/month retainer for ongoing support. This can reduce domain expert costs by 30-40%.

---

# 8. RISK MATRIX

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| AI generates inappropriate messages | Medium | High | Multi-layer content filtering + human review for edge cases |
| Users perceive app as sexist/offensive | Medium | High | Careful branding, inclusive language, female beta testers |
| Low user retention after install | High | High | Gamification, streak rewards, valuable push notifications |
| AI API costs exceed budget | Medium | Medium | Implement caching, optimize prompts, set per-user limits |
| Competitor copies unique features | Medium | Medium | Move fast, build brand loyalty, continuous innovation |
| App Store rejection | Low | High | Follow all Play Store guidelines, privacy policy compliance |
| Key team member leaves | Medium | High | Document everything, cross-training, modular architecture |
| Calendar sync reliability issues | Medium | Medium | Extensive timezone testing, fallback to local reminders |
| Payment integration complications | Low | Medium | Use well-documented libraries, sandbox testing |
| Data privacy breach | Low | Critical | Encryption, security audits, minimal data collection |
| AI content lacks emotional depth without domain experts | High | Critical | Engage Psychiatrist + Female Consultant from Week 1 |
| Zodiac content feels generic/shallow | Medium | High | Hire certified professional astrologist, not hobbyist |
| Women find the app offensive/manipulative | Medium | Critical | Female Consultant validates ALL content before release |
| Domain experts unavailable mid-project | Low | High | Document all frameworks early, create structured knowledge base |
| Psychiatrist content crosses into medical advice territory | Medium | High | Clear disclaimers, legal review, strict content boundaries |

---

# APPENDIX A: HIRING PRIORITY ORDER

If budget is constrained, hire in this order:

1. **Product Manager** (Week 1) — Cannot start without direction
2. **UX/UI Designer** (Week 1) — Design runs parallel to planning
3. **Female Consultant** (Week 1) — Validates concept from day one, prevents building the wrong thing
4. **Psychiatrist** (Week 1) — Shapes the psychological framework before any content is created
5. **Astrologist** (Week 1) — Zodiac engine design needed before development starts
6. **Tech Lead / Sr. Android Dev** (Week 5) — Needs designs to build from
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
| **Full-Stack Android Developer** | Tech Lead + Backend + basic DevOps |
| **AI/ML Engineer** | AI features + prompt engineering |
| **Female Consultant** (contract) | Reality check + content validation |
| **Astrologist** (contract) | Zodiac content package (fixed deliverable) |

In this model:
- Use a freelance designer for UI (fixed contract)
- Skip dedicated QA (developers test + beta users)
- Use Firebase for most backend (reduce backend work)
- Marketing done by founder + social media
- Psychiatrist input: consult 2-3 sessions to build initial framework, then use published research
- Female Consultant: fixed contract for content review milestones
- Astrologist: fixed deliverable contract for zodiac content package
- **Estimated cost: $110,000 - $200,000**
- **Timeline: 7-9 months to MVP**

> **Even in the leanest approach, never skip the Female Consultant.** She is the cheapest hire and the highest ROI — one tone-deaf message going viral on social media can kill the app.

---

*Document Version: 2.0*
*Created: February 14, 2026*
*Project: Hormones - AI Relationship Intelligence App*
