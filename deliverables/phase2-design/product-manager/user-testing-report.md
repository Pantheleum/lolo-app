# LOLO User Testing Report: Simulated Cognitive Walkthrough & Heuristic Evaluation

**Prepared by:** Sarah Chen, Product Manager
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Methodology:** Heuristic evaluation + cognitive walkthrough against 3 validated personas
**Evaluation Basis:** Wireframe Specifications v1.0, Design System v1.0, Feature Backlog MoSCoW v1.0

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Methodology & Evaluation Framework](#methodology--evaluation-framework)
3. [Flow 1: First-Time Onboarding](#flow-1-first-time-onboarding)
4. [Flow 2: Daily Dashboard Interaction](#flow-2-daily-dashboard-interaction)
5. [Flow 3: AI Message Generation](#flow-3-ai-message-generation)
6. [Flow 4: Creating a Reminder](#flow-4-creating-a-reminder)
7. [Flow 5: Building Her Profile](#flow-5-building-her-profile)
8. [Flow 6: SOS Mode Activation](#flow-6-sos-mode-activation)
9. [Flow 7: Gift Recommendation](#flow-7-gift-recommendation)
10. [Flow 8: Action Card Interaction](#flow-8-action-card-interaction)
11. [Flow 9: Subscription Upgrade](#flow-9-subscription-upgrade)
12. [Flow 10: Memory Vault Usage](#flow-10-memory-vault-usage)
13. [Summary: Overall Usability Score Prediction](#summary-overall-usability-score-prediction)
14. [Top 10 Critical Findings](#top-10-critical-findings)
15. [Priority Recommendations Matrix](#priority-recommendations-matrix)
16. [Flows Requiring Wireframe Revision Before Development](#flows-requiring-wireframe-revision)

---

## Executive Summary

This report presents a simulated cognitive walkthrough and heuristic evaluation of all 10 critical user flows in LOLO, evaluated against the three validated personas: Marcus Thompson (EN), Ahmed Al-Mansouri (AR), and Hafiz bin Ismail (MS). Since we are pre-development, this evaluation is based entirely on the wireframe specifications, design system, and feature backlog documentation.

**Overall predicted SUS (System Usability Scale) score: 74/100 (Good)**

The current wireframe design demonstrates strong fundamentals: clear information hierarchy, appropriate cultural awareness, and a well-structured progression from onboarding to daily engagement. However, 23 friction points were identified across the 10 flows, including 4 critical issues and 8 major issues that require wireframe revisions before development begins.

**Key findings at a glance:**

- The onboarding flow is 8 screens long, which exceeds the 5-screen target documented in the feature backlog. This creates a significant drop-off risk, particularly for Hafiz (price-sensitive, basic tech skill).
- The AI Message Generator presents 10 modes on a single grid, which may overwhelm all three personas with choice paralysis.
- SOS Mode requires a subscription for full access, creating a dangerous paywall during emotional crisis moments.
- RTL layout is well-specified but has 7 screen-specific issues that need attention before Arabic development.
- The subscription teaser during onboarding (Screen 8) contradicts the "no paywall before first value" principle established in the persona journey maps.

**Flows requiring immediate wireframe revision:** Flow 1 (Onboarding), Flow 3 (AI Messages), Flow 6 (SOS Mode), Flow 9 (Subscription Upgrade).

---

## Methodology & Evaluation Framework

### Cognitive Walkthrough Method

For each flow, the evaluation asks four questions at every step:

1. **Will the user try to achieve the right effect?** (Goal formation)
2. **Will the user notice that the correct action is available?** (Action visibility)
3. **Will the user associate the correct action with the desired effect?** (Mapping)
4. **If the correct action is performed, will the user see that progress is being made?** (Feedback)

### Personas Applied

| Persona | Key Characteristics for Walkthrough |
|---------|-------------------------------------|
| **Marcus (EN)** | Tech-savvy, iPhone user, privacy-conscious, metrics-driven, 34 years old, wants it to feel like a productivity tool |
| **Ahmed (AR)** | Android user, Arabic-first, RTL essential, culturally conservative, moderate tech skill, 27 years old, privacy critical |
| **Hafiz (MS)** | Android user, Malay-first, basic tech skill, price-sensitive, 31 years old, malu culture makes privacy paramount |

### Nielsen's 10 Usability Heuristics (Reference)

| # | Heuristic |
|---|-----------|
| H1 | Visibility of system status |
| H2 | Match between system and real world |
| H3 | User control and freedom |
| H4 | Consistency and standards |
| H5 | Error prevention |
| H6 | Recognition rather than recall |
| H7 | Flexibility and efficiency of use |
| H8 | Aesthetic and minimalist design |
| H9 | Help users recognize, diagnose, and recover from errors |
| H10 | Help and documentation |

---

## Flow 1: First-Time Onboarding

### Flow Diagram

```
Screen 1          Screen 2        Screen 3        Screen 4
Language    -->    Welcome    -->  Sign Up    -->  Your Profile
Selector          (Value           (Auth)          (Name, Age,
(EN/AR/MS)        Prop.)                           Status)

    Screen 5          Screen 6          Screen 7           Screen 8
--> Her Zodiac   --> Her Love     -->  Her Preferences --> Subscription
    (Zodiac          Language          (Comm Style,        Teaser
    Wheel)           (5 Options)        Interests)         (Free/Pro/Legend)

                                                     |
                                                     v
                                                Screen 9
                                                Home Dashboard
```

**Total screens: 8 (before reaching dashboard)**
**Documented target: 5 screens (from feature backlog M-02)**

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Screen | Experience | Friction? |
|------|--------|------------|-----------|
| 1 | Language Selector | Auto-detects English from device locale, pre-highlights English tile. Taps to confirm. Auto-advances after 300ms. | None. Smooth. The auto-detection is appreciated by a tech-savvy user. |
| 2 | Welcome | Reads tagline: "She won't know why you got so thoughtful. We won't tell." Sees 3 benefit cards. The positioning as a tool, not therapy, resonates. Taps "Get Started." | None. Tagline matches his discovery context (Reddit thread). |
| 3 | Sign Up | Taps "Continue with Apple" (one tap, Face ID confirms). Account created in under 3 seconds. | None. Apple Sign-In is optimal for iPhone users. |
| 4 | Your Profile | Types "Marcus", enters age 34, selects "Married." Three fields only. Taps "Continue." | Minor: "Your Age" field uses numeric keyboard -- good. But no explanation of why age matters. Marcus might question this. |
| 5 | Her Zodiac | Sees zodiac wheel. He knows Jessica is Libra. Taps Libra, sees detail card with traits. Taps "Continue." | Minor: The zodiac wheel is visually engaging but might feel "non-scientific" to an engineer. The fallback "Enter her birthday instead" partially mitigates this. |
| 6 | Her Love Language | Recognizes the 5 Love Languages framework. Selects "Quality Time" for Jessica. Taps "Continue." | None. Familiar framework. Single-select is clear. |
| 7 | Her Preferences | Selects "Calm & reassuring" communication style. Toggles 4 interest chips. | Minor: 16 interest chips on one screen is a lot of cognitive load. Marcus might rush through this. |
| 8 | Subscription Teaser | Sees Free/Pro/Legend comparison. Sees "Continue with Free plan" link. Taps it to skip. | **Major:** Marcus expects his first value moment by now. The persona journey map says the "aha moment" should happen at Screen 5. Instead, he is still in data-collection mode at Screen 8. The subscription teaser before any value delivery feels premature and could trigger "this is a money grab" skepticism. |
| 9 | Home Dashboard | Finally sees dashboard. First action card is generated. | Relief. But it took 8 screens to get here. Target was 5. |

**Marcus completion prediction: 82%** -- Tech-savvy users tolerate onboarding, but the 8-screen length exceeds expectations set by his app benchmarks (Duolingo: 4 screens, Spotify: 3 screens).

#### Ahmed Al-Mansouri (AR)

| Step | Screen | Experience | Friction? |
|------|--------|------------|-----------|
| 1 | Language Selector | Device locale is Arabic. Arabic tile pre-highlighted with Saudi Arabia flag. Taps. RTL layout flips immediately. | **Minor RTL issue:** The wireframe specifies SA flag for Arabic. Ahmed is in Dubai (UAE). While Saudi Arabic is linguistically similar, the flag choice may feel exclusionary for UAE/Qatari/Kuwaiti users. Consider a generic Arabic symbol or multiple GCC flags. |
| 2 | Welcome (RTL) | All text right-aligned. Benefit card icons move to right side. Reads naturally in Arabic. The tagline in Arabic should be Gulf-inflected. | None if localization quality is high. The RTL transition is well-specified in wireframes. |
| 3 | Sign Up | Taps "Continue with Google" (Samsung user, Google account is primary). Text fields accept Arabic input. | Minor: Password field placeholder is likely English ("you@example.com"). For Arabic users, this should be localized or use an Arabic example email format. |
| 4 | Your Profile | Types name in Arabic. Age: 27. Status: Selects "Dating" -- but Ahmed is actually engaged. The wireframe options are: Dating, Engaged, Married, Long-distance, Complicated. | **Positive:** "Engaged" option exists. The wireframe is culturally aware. Ahmed selects it. |
| 5 | Her Zodiac | Zodiac wheel is circular, not directionally biased. Detail card text aligns right. Date range uses DD/MM/YYYY. "Skip" is on the left side (RTL). | **Minor RTL issue:** "Skip" placement on the left in RTL is correct per spec, but the back arrow also appears on the right. Two navigation elements on opposite sides may confuse users in RTL. The visual weight of the page is unbalanced. |
| 6 | Her Love Language | 5 love language cards. Ahmed selects "Receiving Gifts" for Noura. All cards render in Arabic. | None. The concept of love languages translates well to Gulf culture. |
| 7 | Her Preferences | Communication style: Ahmed selects "Formal & respectful" (appropriate for his engagement-stage relationship). Interests: Chip grid flows right-to-left as specified. | None. The "Formal & respectful" option is culturally relevant for Gulf engagement context. |
| 8 | Subscription Teaser | Ahmed sees prices in USD ($6.99/$12.99). | **Critical:** Prices should display in AED for UAE users. The wireframe mentions "locale-appropriate" pricing but the mock shows USD. GCC users expect AED pricing. Showing USD creates a disconnect and may trigger distrust ("Is this even available in my country?"). |
| 9 | Home Dashboard | Dashboard loads in full RTL Arabic. | Ahmed has invested significant time in onboarding. The RTL experience is comprehensive but the 8-screen journey is long for someone driven by Eid urgency. |

**Ahmed completion prediction: 78%** -- Ahmed's Eid urgency drives him forward, but the lengthy onboarding and potential pricing display issues create friction. The lack of a "first value" moment before Screen 9 is a notable gap.

#### Hafiz bin Ismail (MS)

| Step | Screen | Experience | Friction? |
|------|--------|------------|-----------|
| 1 | Language Selector | Device language may be English (common for Malaysian Android). Malay option "Bahasa Melayu" with MY flag is clear. Taps it. | None. Straightforward. |
| 2 | Welcome (BM) | Full Bahasa Melayu interface. Tagline localized. Benefits are clear. | None if localization is natural (colloquial BM, not textbook formal). |
| 3 | Sign Up | Taps "Continue with Google" (standard Android flow). | None. |
| 4 | Your Profile | Types "Hafiz", age 31, selects "Married." Simple. | None. |
| 5 | Her Zodiac | Hafiz may not know Aisyah's zodiac sign immediately. Taps "Enter her birthday instead" -- types Aisyah's birthday. Zodiac auto-calculated. | **Minor:** The auto-calculation is helpful, but the date picker may default to a Western calendar. Malaysian users are accustomed to DD/MM/YYYY format but the wireframe does not specify locale-aware date picker defaults. |
| 6 | Her Love Language | Hafiz may not be familiar with the "5 Love Languages" concept. No explanation is provided beyond the card title and brief description. | **Major:** For users with basic tech skill and limited exposure to Western relationship frameworks, the Love Languages concept needs more context. A "What is this?" help link would reduce confusion. Hafiz might tap "Skip" out of uncertainty, losing valuable personalization data. |
| 7 | Her Preferences | 16 interest chips. Hafiz is on a mid-range phone (Galaxy A55 with smaller screen). | **Major:** On a 6.4-inch screen with potentially larger text settings, the chip grid, radio group, and "Continue" button may require significant scrolling. The "Continue" button could be pushed below the fold, making it invisible without scrolling. This is a critical issue for basic-tech-skill users who may think the screen is "stuck." |
| 8 | Subscription Teaser | Hafiz sees pricing. If regional pricing is implemented (RM 14.90/mo), this is reasonable. If USD is shown ($6.99), it feels expensive (approximately RM 32, more than double his comfort threshold). | **Critical:** Regional pricing display is essential. The wireframe mentions "locale-appropriate" but the mockup shows USD. For Hafiz, seeing USD could trigger immediate distrust and abandonment. The "Continue with Free plan" link must be prominently visible so he does not feel trapped. |
| 9 | Home Dashboard | Arrives at dashboard. Exhausted from 8 screens. | Hafiz is the most likely persona to abandon during onboarding due to length and unfamiliar concepts (zodiac, love languages). |

**Hafiz completion prediction: 68%** -- The longest onboarding of any persona due to unfamiliarity with zodiac/love language concepts, potential scrolling issues on mid-range device, and price sensitivity anxiety at the subscription screen.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Confidence |
|---------|--------------------------|------------|
| Marcus (EN) | 82% | High |
| Ahmed (AR) | 78% | Medium |
| Hafiz (MS) | 68% | Medium |
| **Weighted Average** | **76%** | -- |

### Friction Points

| # | Severity | Description | Screen | Personas Affected |
|---|----------|-------------|--------|-------------------|
| F1.1 | **Critical** | Onboarding is 8 screens, exceeding the 5-screen target. Every additional screen increases drop-off by approximately 8-12%. Three extra screens could cost 24-36% of potential users. | All | All |
| F1.2 | **Critical** | Subscription teaser (Screen 8) appears before the user receives any value. The documented "first value moment" (AI-generated action card) should occur at Screen 5 per persona journey maps. Current flow delays this to Screen 9. | Screen 8 | All |
| F1.3 | **Critical** | Regional pricing may display in USD for non-US users. Ahmed sees USD instead of AED; Hafiz sees USD instead of MYR. This triggers abandonment in price-sensitive markets. | Screen 8 | Ahmed, Hafiz |
| F1.4 | **Major** | Love Language concept is not explained for users unfamiliar with the framework. No "What is this?" affordance. | Screen 6 | Hafiz |
| F1.5 | **Major** | Interest chip grid (16 chips) + radio group + button may require extensive scrolling on mid-range Android screens. CTA button could be below the fold. | Screen 7 | Hafiz |
| F1.6 | **Minor** | Arabic flag uses Saudi Arabia symbol. UAE/Qatar/Kuwait users may feel excluded. | Screen 1 | Ahmed |
| F1.7 | **Minor** | No explanation of why age is collected on Your Profile screen. Privacy-conscious users may hesitate. | Screen 4 | Marcus, Ahmed |
| F1.8 | **Minor** | Zodiac wheel may feel "unscientific" to analytical/engineering-minded users. | Screen 5 | Marcus |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H1: Visibility of system status** | No progress indicator across the 8 onboarding screens. Users have no idea how many screens remain. | Major |
| **H2: Match between system and real world** | Love Languages framework assumed as universal knowledge. Not all cultures use this framework. | Major |
| **H3: User control and freedom** | "Skip" is available on Screens 5-7 (good), but not on Screen 8 -- the subscription teaser has "Continue with Free plan" but it is styled as secondary text, not a prominent skip. | Minor |
| **H5: Error prevention** | Auto-advance on language selection (300ms delay) could cause accidental selection. No confirmation. | Minor |
| **H7: Flexibility and efficiency of use** | No "fast track" option for returning users or users who want minimal setup. The onboarding is linear with no branching. | Major |
| **H8: Aesthetic and minimalist design** | Screen 7 (Preferences) has too much content. Radio group + 16 chips + button on one screen violates minimalism for small-screen devices. | Major |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R1.1 | **Reduce onboarding to 5 screens.** Merge "Her Zodiac" and "Her Love Language" into a single screen. Move "Her Preferences" to post-onboarding (progressive disclosure via Her Profile). Remove subscription teaser from onboarding entirely -- introduce it after the first paywall trigger, not before. New flow: Language -> Welcome -> Sign Up -> Your Profile (name + age + status + her name) -> First Value Moment (AI card). | High | Medium |
| R1.2 | **Add a progress indicator.** A horizontal step indicator or dot pagination showing current position out of total steps. Reduces uncertainty and gives users a sense of how much more time is needed. | High | Low |
| R1.3 | **Move subscription teaser to a natural paywall moment.** Instead of showing pricing at Screen 8, show it when the user first hits a free-tier limit (e.g., 6th AI message attempt). This aligns with the persona journey maps' documented conversion triggers. | High | Low |
| R1.4 | **Add "What is this?" tooltip to Love Language cards.** A small (i) icon that expands to a 2-sentence explanation of the concept. Critical for Hafiz and Arabic users who may not be familiar with this Western framework. | Medium | Low |
| R1.5 | **Implement locale-aware currency display from day one.** AED for GCC, MYR for Malaysia, USD for US. This is a development-blocking requirement for any screen showing pricing. | High | Medium |
| R1.6 | **Use a generic Arabic/GCC symbol instead of Saudi flag.** A crescent and star, or a composite GCC symbol, would be more inclusive for the entire Arabic-speaking user base. | Low | Low |

### RTL-Specific Issues (Ahmed's Flow)

| # | Issue | Screen | Recommendation |
|---|-------|--------|----------------|
| RTL1.1 | Saudi Arabia flag may not represent all GCC users | Screen 1 | Use generic Arabic symbol |
| RTL1.2 | "Skip" (left) and back arrow (right) create dual navigation points on opposite sides in RTL | Screen 5-7 | Standardize: place Skip as text under the Continue button, not in the AppBar |
| RTL1.3 | Email placeholder text may not be localized for Arabic input | Screen 3 | Use Arabic-localized placeholder |
| RTL1.4 | Date picker format must default to DD/MM/YYYY for Arabic locale | Screen 5 | Verify locale-aware date formatting |

### Accessibility Issues

| # | Issue | WCAG Level | Recommendation |
|---|-------|------------|----------------|
| A1.1 | Auto-advance on language selection (300ms) does not allow sufficient time for users with motor disabilities to correct an accidental tap. | AA | Add a "Confirm" button or extend auto-advance to 800ms with a visual countdown indicator. |
| A1.2 | Zodiac wheel is a custom circular component. Screen readers may not announce the 12 options clearly. | A | Provide a linear fallback list (accessible alternative to the wheel) for screen reader users. |
| A1.3 | Color-coded selection state (accent border + 10% opacity fill) may be insufficient for color-blind users on the interest chips. | AA | Add a checkmark icon to selected chips in addition to color change. |

---

## Flow 2: Daily Dashboard Interaction

### Flow Diagram

```
Push              Screen 9          Action Card        XP Gain
Notification -->  Home          --> Detail View   -->  Animation
(discreet)        Dashboard         (SAY/DO/            (+15 XP)
                  (Streak,          BUY/GO)
                   Cards,                          --> Streak
                   Score)                              Update
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Receives morning notification | Lock screen shows "LOLO" with no content preview. Marcus taps to open. |
| 2 | Sees dashboard | Greeting: "Good morning, Marcus." Streak: 12 days with fire icon. Score: 847 pts. Level: "Good Partner." All at a glance in under 2 seconds. |
| 3 | Sees mood check-in | "How is she today?" with 4 options (Great/Ok/Stressed/Upset). Marcus taps "Ok" -- it was a normal morning. |
| 4 | Reads action card | SAY card: "She had a long day. Send her this: 'I know today was...'" with Copy and Send buttons. |
| 5 | Acts on card | Taps "Copy." Pastes into iMessage to Jessica. |
| 6 | Sees XP gain | "+15 XP" animation. Streak counter increments if this is his first action today. |

**Marcus experience:** Excellent. The dashboard is information-dense but well-organized. The productivity-tool feel (metrics, scores, action items) aligns perfectly with his mental model. The entire interaction takes under 60 seconds.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Receives notification | "LOLO" only on lock screen. No Arabic content visible. Good for privacy. |
| 2 | Sees dashboard (RTL) | Avatar on right, bell icon on left. Greeting right-aligned in Arabic. Streak card content right-aligned with fire icon on left. |
| 3 | Mood check-in | "How is she today?" in Arabic. Mood buttons flow right-to-left. |
| 4 | Reads action card | SAY card with Arabic message for Noura. Card type badge in top-right. |
| 5 | Acts on card | Taps "Copy." Opens WhatsApp (primary messaging app for GCC). Pastes Arabic message. |
| 6 | XP gain | Arabic numeral display. Animation plays. |

**Ahmed experience:** Good. The RTL dashboard is well-specified. One concern: the mood check-in options (Great/Ok/Stressed/Upset/Sick) are Western emotional categories. Arabic emotional expression has different granularity. "Stressed" (as a standalone category) may not map perfectly to Gulf Arabic emotional vocabulary.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Receives notification | Discreet notification. Critical for malu culture. |
| 2 | Sees dashboard | Dashboard in Bahasa Melayu. Streak and score visible. |
| 3 | Mood check-in | Taps "Stressed" -- Aisyah is having pregnancy discomfort. |
| 4 | Reads action card | DO card: "Aisyah ada cravings? Tanya dia apa dia nak makan hari ni." (pregnancy-aware card). |
| 5 | Acts on card | Reads the suggestion. Decides to ask Aisyah during lunch break. Does not use "Copy" (it is a DO, not a SAY). Taps "Complete" after he does it. |
| 6 | XP gain | +20 XP. Streak at 5 days. |

**Hafiz experience:** Good. The pregnancy-aware content is highly relevant. The main concern is that Hafiz's mid-range phone (Galaxy A55) may render the action card list slowly if 3+ cards are loaded simultaneously with images.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 95% | Dashboard is his ideal interaction pattern |
| Ahmed (AR) | 90% | RTL is solid; mood categories slightly misaligned |
| Hafiz (MS) | 88% | Content is relevant; device performance is the concern |
| **Weighted Average** | **91%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F2.1 | **Major** | Mood check-in categories (Great/Ok/Stressed/Upset/Sick) are Western-centric. Arabic and Malay cultures express emotions differently. "Stressed" may not capture the nuance Ahmed needs, and "Upset" may feel too direct for Hafiz's indirect communication culture. | Ahmed, Hafiz |
| F2.2 | **Minor** | The dashboard shows 2-4 action cards (per wireframe). Free users get only 1 card/day. The visual expectation (seeing 3 cards) conflicts with the actual free-tier limit, which could feel misleading. | All (free tier) |
| F2.3 | **Minor** | The "How is she today?" check-in has a "Period" quick tag. This may feel culturally insensitive for Ahmed (Gulf context -- menstruation is a very private topic in conservative Gulf culture). | Ahmed |
| F2.4 | **Minor** | Pull-to-refresh regenerates action cards. If a user pulls accidentally, they might lose a card they intended to complete, with no way to retrieve it. | All |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H2: Match between system and real world** | Mood categories do not match Arabic/Malay emotional vocabularies. | Major |
| **H3: User control and freedom** | No undo for card dismiss/refresh. Cards disappear with no retrieval. | Minor |
| **H4: Consistency and standards** | Dashboard wireframe shows 3 cards, but free tier only provides 1. Visual mismatch between design and actual state. | Minor |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R2.1 | **Localize mood check-in categories per culture.** Arabic: use culturally appropriate emotional states (e.g., include "Worried about family" and "Under pressure" instead of generic "Stressed"). Malay: include "Senyap" (quiet/silent) as a mood state reflecting indirect communication. | High | Medium |
| R2.2 | **Remove "Period" tag for conservative cultural contexts.** Or replace with euphemistic phrasing. In Arabic/Malay contexts, replace with "Not feeling well" or "Needs extra care today." | Medium | Low |
| R2.3 | **Add card history/recovery.** If a card is dismissed or refreshed away, store it in a "Recent cards" accessible from the action card section. | Medium | Low |
| R2.4 | **Adjust free-tier dashboard to show only 1 card placeholder.** Do not show 3 card slots with 2 locked. Show 1 active card + a subtle "Upgrade for more daily suggestions" note below. | Low | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL2.1 | Swipe to dismiss cards reverses in RTL. Users need to swipe right to dismiss instead of left. This must be explicitly implemented and tested. | Implement and test RTL swipe gesture direction |
| RTL2.2 | Bottom navigation tab order reverses in RTL. Home should be rightmost for Arabic users. Confirm this with native Arabic UX testers. | Validate tab order with Arabic users |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A2.1 | Action card swipe-to-dismiss has no accessible alternative. Screen reader users cannot swipe. | Add a "Dismiss" button within the card for accessibility |
| A2.2 | Streak fire icon is decorative but carries meaning. Screen readers should announce "12-day streak" not just the number. | Add content description to streak icon |

---

## Flow 3: AI Message Generation

### Flow Diagram

```
Screen 19         Screen 20          Screen 21
Mode Picker  -->  Message       -->  Message Result
(10 modes,        Config             (Generated text,
 2-column         (Tone, Humor,       Copy, Share,
 grid)            Length, Context)     Edit, Rate)

                                  --> Share to WhatsApp/
                                      iMessage/etc.
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Opens AI Messages (bottom nav) | Sees 10 mode cards in a 2-column grid. Reads labels: Appreciation, Apology, Reassurance, Motivate, Celebration, Flirting, After Argument, Long Distance, Good AM/PM, Checking on You. |
| 2 | Selects "Appreciation" | Navigates to config screen. Tone pre-selected: "Romantic." Humor slider at 30%. Length: "Medium." |
| 3 | Adds context | Types: "She just got promoted at work." |
| 4 | Generates | Taps "Generate Message." Waits 3-5 seconds. Message appears. |
| 5 | Reviews message | Reads: "I just wanted you to know that watching you grow in your career makes me so proud..." |
| 6 | Copies and sends | Taps "Copy." Opens iMessage. Sends to Jessica. |
| 7 | Rates | Taps 4 stars. Closes. |

**Marcus experience:** Good once he is in the flow. But the 10-mode grid is dense. Marcus is a power user who will learn the modes, but on first use, the distinction between "Appreciation" and "Checking on You" or between "Reassurance" and "Motivate" may feel unclear.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Opens AI Messages | 10 modes in RTL grid. Modes 5-10 show lock icons (free tier). Ahmed upgraded to Pro on Day 1, so all modes are unlocked. Labels are in Arabic. |
| 2 | Selects "Celebration" (for Eid message) | Config screen. Tone: "Formal" (for her father). Language: Arabic (pre-selected). |
| 3 | Adds context | Types in Arabic: "Eid al-Fitr message for her father. He likes football and is traditional." |
| 4 | Generates | Message generated in Gulf Arabic. |
| 5 | Reviews | Reads the message. It uses appropriate formal Arabic for an elder. References Eid specifically. |
| 6 | Shares | Taps "Share." Selects WhatsApp. |

**Ahmed experience:** The critical question is Arabic generation quality. If the message sounds like MSA (Modern Standard Arabic) instead of Gulf dialect, Ahmed will rate it poorly and potentially stop using the feature. The wireframe cannot test this -- it depends on AI engineering quality. The flow itself is well-structured for Ahmed's use case.

**Concern:** Ahmed needs to generate messages for multiple recipients (Noura, her father, her mother, her sisters). The current flow does not have a "recipient" selector. He must re-enter context each time, manually adjusting tone from "Casual" (Noura) to "Formal" (her father). This is repetitive.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Opens AI Messages | 10 modes. Free tier: modes 5-10 locked. Hafiz sees lock icons. |
| 2 | Wants "Reassurance" (mode 4) for Aisyah's bad pregnancy day | Mode 4 is borderline -- wireframe says "Comfort & Reassurance" is a Pro-only mode. |
| 3 | Hits paywall | **"Upgrade to Pro for this mode."** Hafiz feels frustrated. He needs this message NOW for his wife who is having a bad day. |

**Hafiz experience:** **Critical friction.** The free-tier mode restriction creates a painful gap at the exact moment of highest emotional need. Hafiz's trigger for downloading LOLO was Aisyah's comment about feeling alone. When he reaches for "Comfort & Reassurance" and hits a paywall, the app fails him at the moment of truth.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 90% | Config screen has many options but manageable for tech-savvy user |
| Ahmed (AR) | 85% | Flow works if Arabic quality is high; no recipient selector is a gap |
| Hafiz (MS) | 60% | Paywall on emotional modes blocks his primary use case |
| **Weighted Average** | **78%** | Dragged down by Hafiz's paywall collision |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F3.1 | **Critical** | "Comfort & Reassurance" mode is Pro-only, but this is the #1 use case for Hafiz (and a top-3 use case for Marcus during arguments). Paywalling emotional support modes creates a trust-breaking moment at the highest-need time. | Hafiz, Marcus |
| F3.2 | **Major** | 10 modes on one screen creates choice paralysis. No categorization, grouping, or "suggested for you" prioritization. Users must parse all 10 before selecting. | All |
| F3.3 | **Major** | No recipient selector. Users generating messages for multiple people (Ahmed's family use case) must manually adjust tone/context each time with no "profile" linking. | Ahmed |
| F3.4 | **Major** | Configuration screen has 6 inputs (tone, humor, language, context, length, name inclusion). This is overwhelming for a user in an emotional state who just wants a quick message. | Hafiz, Marcus (during SOS-adjacent scenarios) |
| F3.5 | **Minor** | "Uses 1 of 2 daily free messages" counter creates anxiety about "wasting" a message on an imperfect generation. Users may hesitate to tap "Generate" fearing a bad result will consume their quota. | Hafiz |
| F3.6 | **Minor** | The "Regenerate" button on the result screen consumes another message credit. This is not clearly communicated before tapping. | All (free tier) |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H3: User control and freedom** | Paywalled emotional modes with no alternative. "Comfort" should not be behind a wall. | Critical |
| **H6: Recognition rather than recall** | 10 modes require memorization of distinctions. No grouping or contextual suggestion. | Major |
| **H7: Flexibility and efficiency of use** | No quick-generate shortcut for power users. Always must go through Mode Picker -> Config -> Generate. | Major |
| **H8: Aesthetic and minimalist design** | Config screen has 6 configurable inputs. Many users will not understand or care about "Humor Level" slider. | Major |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R3.1 | **Make "Comfort & Reassurance" available on the free tier.** Move it from Pro-only to free. Replace it in the Pro tier with a different differentiator (e.g., "Advanced Customization" or "Multiple Regenerations"). Emotional support should never be paywalled -- it is both ethically important and strategically wise (a great comfort message converts free users to paid better than blocking them). | Critical | Low |
| R3.2 | **Group the 10 modes into 3 categories.** (1) Daily (Good Morning, Appreciation, Checking on You, Just Because), (2) Emotional (Reassurance, Apology, After Argument, Missing You), (3) Special (Celebration, Flirting). Display as 3 expandable sections instead of a flat 10-item grid. | High | Medium |
| R3.3 | **Add a "Quick Generate" flow.** From the home screen action card, a SAY card already has a "Copy" button with a pre-generated message. Add a "Customize" link that opens the Message Config pre-filled with the card's context. This shortcut bypasses the Mode Picker entirely. | High | Medium |
| R3.4 | **Add a recipient selector.** For Ahmed's family use case: "Who is this message for?" dropdown on the Config screen (populated from Her Profile + family member profiles). Tone and formality auto-adjust based on recipient relationship (e.g., "her father" = Formal, "her" = Casual). | High | Medium |
| R3.5 | **Simplify Config screen with progressive disclosure.** Show only Tone and Context by default. Put Humor, Length, Language, and Name behind an "Advanced options" expandable section. Most users only need Tone + Context. | Medium | Low |
| R3.6 | **Clarify regeneration credit cost.** Before the user taps "Regenerate," show "This will use 1 message credit. Continue?" or make the first regeneration free. | Medium | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL3.1 | Mode grid flows right-to-left (first card top-right). Ensure reading order matches Arabic scanning pattern (right-to-left, top-to-bottom). | Validate with Arabic UX testers |
| RTL3.2 | Humor slider: "None" on right, "Max" on left in RTL. This is counterintuitive because progress bars universally fill left-to-right, even in RTL contexts (like star ratings). | Consider keeping slider direction LTR or adding clearer labels |
| RTL3.3 | Generated Arabic message text must handle mixed-direction content (Arabic text with embedded English brand names or phrases). | Test BiDi text rendering in message card |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A3.1 | Mode cards rely on icon + short label. Some icons (hug, muscle) may not be universally understood. | Add descriptive text or longer labels visible to screen readers |
| A3.2 | Humor slider is a continuous slider (0-100). Screen readers may not announce position meaningfully. | Use a discrete 5-step slider with labeled stops |

---

## Flow 4: Creating a Reminder

### Flow Diagram

```
Screen 9          Screen 16         Screen 17
Home         -->  Reminders    -->  Create/Edit
Dashboard         List (Calendar     Reminder
(Tap "Remind-     or List view)      (Title, Category,
 ers" in nav                         Date, Recurrence,
 or card link)                       Escalation, Notes)

                                 --> Save
                                 --> Return to
                                     Reminders List
                                 --> Later: Receive
                                     push notification
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Navigates to Reminders | Taps the reminder notification or navigates via a reminder-linked action card. |
| 2 | Sees Reminders List | Calendar view showing February 2026. Dots on dates with reminders. Below: "Upcoming" list sorted chronologically. Clear, informative. |
| 3 | Taps "+" to create | Create Reminder form. Title: "Jessica's Birthday." Category: taps "Bday" chip. Date: March 21 via date picker. |
| 4 | Configures escalation | Pre-checked: 7 days, 3 days, 1 day, same day. Marcus leaves defaults (good defaults reduce cognitive load). |
| 5 | Toggles "Auto-suggest gifts" | Checks it. Expects LOLO to link to Gift Engine as the date approaches. |
| 6 | Saves | Taps "Save Reminder." Toast: "Reminder saved!" Returns to list. |
| 7 | Later: receives notification | 7 days before: "Jessica's birthday is in 7 days. Start planning her gift." Taps notification -- opens Gift Engine. |

**Marcus experience:** Excellent. This is his #1 use case and the flow is clean, efficient, and well-integrated with the Gift Engine. The escalating notification system directly addresses his core pain point (forgetting dates).

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1-2 | Same navigation | RTL calendar. Week starts Saturday (Arabic locale default). |
| 3 | Creates Eid reminder | Title: "عيد الفطر" (Eid al-Fitr). Category: no "Eid" category chip exists. Options are: Bday, Anniv, Date, Promise, Custom. Must select "Custom." |
| 4 | Configures | Date: Islamic calendar date. The date picker may show Gregorian calendar by default. |

**Ahmed experience concern:** The category chips do not include "Religious Holiday" or "Eid." Ahmed must use "Custom" for the most important date on his calendar. This feels like a Western-centric oversight. Additionally, the Hijri calendar integration is mentioned in the feature backlog but the wireframe's date picker does not show Hijri support.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1-2 | Same flow in Malay | |
| 3 | Creates reminder: "Aisyah mentioned cafe in Bangsar" | Category: "Promise" -- good fit. |
| 4 | Date: sets it for Saturday | Recurring: OFF (one-time). |
| 5 | Saves | Simple, quick. |
| 6 | Later | Gets notification on Saturday morning: "Reminder: Aisyah mentioned cafe in Bangsar." Hafiz asks Aisyah to go. She is surprised and happy. |

**Hafiz experience:** Good. The Promise Tracker is the killer feature for Hafiz. The main friction is getting him to remember to log promises in the moment (when Aisyah mentions something casually).

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 95% | Core use case, clean flow |
| Ahmed (AR) | 82% | Missing Islamic holiday category and Hijri calendar |
| Hafiz (MS) | 88% | Good flow; capture-in-the-moment is the real challenge |
| **Weighted Average** | **88%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F4.1 | **Major** | Reminder category chips (Bday, Anniv, Date, Promise, Custom) do not include "Religious Holiday" or "Eid/Raya." This forces Ahmed and Hafiz to use "Custom" for their most important dates, which loses semantic meaning and prevents automatic behavior linking (e.g., auto-triggering Gift Engine for Eid). | Ahmed, Hafiz |
| F4.2 | **Major** | Date picker does not appear to support Hijri calendar display. Ahmed may need to convert Islamic dates to Gregorian manually, which is error-prone. | Ahmed |
| F4.3 | **Minor** | The escalation settings (7d, 3d, 1d, same day) are pre-checked but not explained. First-time users may not understand what "escalation" means in this context. | Hafiz |
| F4.4 | **Minor** | "Auto-suggest gifts before this date" checkbox is buried at the bottom. This powerful feature may go unnoticed. | All |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H2: Match between system and real world** | Category chips use Western date categories only. No religious/cultural holiday option. | Major |
| **H6: Recognition rather than recall** | "Notification Escalation" is jargon. Users must infer meaning from the checkboxes. | Minor |
| **H10: Help and documentation** | No tooltip or help text explaining what each escalation level does. | Minor |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R4.1 | **Add "Religious Holiday" and "Family Event" category chips.** For Islamic contexts, auto-populate with Eid al-Fitr, Eid al-Adha, Ramadan, etc. For Malaysian contexts, add Hari Raya. | High | Low |
| R4.2 | **Add Hijri calendar toggle to date picker.** When cultural context is set to Islamic, offer a Hijri/Gregorian toggle in the date picker. Auto-convert between the two. | High | Medium |
| R4.3 | **Rename "Notification Escalation" to "Reminder Schedule."** Use plain language: "When should we remind you?" with checkboxes labeled "4 weeks before," "2 weeks before," "1 week before," "3 days before," "Day of." | Medium | Low |
| R4.4 | **Promote "Auto-suggest gifts" toggle.** Move it above the Notes field and add a brief description: "We'll suggest gift ideas as this date approaches." | Low | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL4.1 | Calendar week starts on Saturday for Arabic locale. Verify the calendar widget supports configurable week-start day. | Implement locale-aware week-start configuration |
| RTL4.2 | Calendar swipe direction reverses in RTL. Ensure left-swipe = previous month (not next) in Arabic. | Test RTL calendar navigation thoroughly |
| RTL4.3 | Escalation checkboxes: checkbox on right, label on left. Ensure adequate touch target spacing. | Verify 48dp touch targets in RTL checkbox layout |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A4.1 | Calendar widget may not be accessible to screen readers (day grid is complex). | Provide a "List view" as the default for screen reader users, with dates announced as a flat list |

---

## Flow 5: Building Her Profile

### Flow Diagram

```
Screen 9         Screen 12          Screen 13
Home        -->  Profile        --> Edit Zodiac &
Dashboard        Overview           Personality
                 (Summary card,     (Zodiac wheel,
                  section tiles)     trait sliders,
                                     conflict style)
             --> Screen 14      --> Screen 15
                 Edit              Cultural &
                 Preferences       Religious
                 (Comm style,      Settings
                  interests,       (Background,
                  triggers)         holidays,
                                    dietary)
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Taps "Her" in bottom nav | Profile Overview loads. Shows summary card with Libra icon, "Quality Time" love language, "Calm & reassuring" style. Profile completion: 45%. |
| 2 | Sees incomplete sections | "Personality Traits" shows "Not set" with "Add" link. Taps it. |
| 3 | Edit Zodiac & Personality | Zodiac: Libra (pre-filled from onboarding). Trait sliders: pre-populated from zodiac data. Romantic: 70. Adventurous: 50. Emotional: 60. Social: 70. Spontaneous: 80. Marcus reviews: "Jessica is actually less spontaneous than Libra defaults suggest." Adjusts Spontaneous to 40. |
| 4 | Saves | Taps "Save." Brief checkmark animation. Returns to overview. |
| 5 | Continues filling | Taps "Communication & Preferences." Adds stress triggers ("work deadlines, family conflict"). Adds sensitive topics ("past relationships"). |

**Marcus experience:** Good. The zodiac defaults give him a starting point that he can override. The progressive disclosure (overview first, then detail screens) reduces overwhelm. His main question: "How does this data actually improve what LOLO suggests?" -- No feedback loop explanation is given.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1-2 | Same flow, RTL | Profile overview in Arabic. |
| 3 | Cultural & Religious Settings | Selects "Arab" background, "Muslim" religion, "High" observance. Islamic holidays auto-checked: Eid al-Fitr, Eid al-Adha, Ramadan. |
| 4 | Adds dietary restrictions | "Halal" and "No alcohol" pre-selected (smart defaults based on religion). Ahmed appreciates this. |
| 5 | Notes gap | There is no "Family Members" section on the profile overview (S-01 is a Should Have, Sprint 4). Ahmed cannot yet add profiles for Um Noura or her sisters. This is a significant gap for his use case. |

**Ahmed experience:** Mixed. The cultural-religious settings are well-designed and demonstrate cultural awareness. But the lack of family member profiles at MVP is a meaningful gap. Ahmed's #2 pain point is managing her family -- and the profile has no place to store this data yet.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1-2 | Same flow in Malay | |
| 3 | Zodiac & Personality | Sees default traits for Pisces. Hafiz may not understand what "trait sliders" mean or how they affect the app's behavior. |
| 4 | Adjusts sliders | Moves "Emotional" higher (Aisyah is emotional, especially during pregnancy). Moves "Adventurous" lower. |
| 5 | Conflict style | Selects "Needs space first" -- he has learned this about Aisyah through experience. |
| 6 | Saves | But wonders: "Will LOLO actually use this? Or did I just waste my time filling forms?" |

**Hafiz experience:** Functional but unclear value. Hafiz, with basic tech skill, is less likely to invest time in filling out detailed profiles unless he can see an immediate cause-and-effect between profile data and LOLO's suggestions. The wireframe does not show a before/after comparison.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 92% | Enjoys the data-driven approach |
| Ahmed (AR) | 80% | Missing family profiles is a notable gap |
| Hafiz (MS) | 72% | Unclear ROI on time investment; trait sliders may confuse |
| **Weighted Average** | **81%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F5.1 | **Major** | No visible feedback loop explaining how profile data improves LOLO's output. Users fill sliders and fields with no demonstration of impact. This undermines motivation to complete the profile, especially for Hafiz. | Hafiz, Ahmed |
| F5.2 | **Major** | Family member profiles are not available at MVP (Sprint 4 Should Have). Ahmed's core use case involves tracking her mother's preferences, father's conversation topics, and sisters' birthdays. | Ahmed |
| F5.3 | **Minor** | Trait sliders (0-100 continuous) are imprecise. Users cannot tell if "Romantic: 70" means something different from "Romantic: 75." Discrete steps would be clearer. | All |
| F5.4 | **Minor** | Zodiac defaults risk feeling "creepy" if they are too accurate. A user who has not set zodiac but sees "She tends to need space during conflict" might feel surveilled. The disclaimer "This is based on her zodiac sign -- adjust if needed" partially mitigates this, but the wording could be stronger. | All |
| F5.5 | **Minor** | The "Sensitive Topics" text area has no examples in the placeholder. Users may not know what to enter. | Hafiz |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H1: Visibility of system status** | No demonstration of how profile data changes LOLO's output. Users cannot see the system responding to their input. | Major |
| **H2: Match between system and real world** | Continuous sliders (0-100) do not match how people think about personality traits. People think in categories (low/medium/high), not percentages. | Minor |
| **H7: Flexibility and efficiency of use** | No "quick fill" option. Users must navigate to individual edit screens for each section. A single scrollable form would be more efficient. | Minor |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R5.1 | **Add a "Profile Impact Preview."** After saving profile changes, show a brief comparison: "Before: generic suggestions. After: personalized to her Pisces traits and calm communication style." This 3-second animation demonstrates value and motivates further completion. | High | Medium |
| R5.2 | **Prioritize Family Member Profiles to MVP.** Move S-01 from Should Have (Sprint 4) to Must Have. Ahmed's core workflow requires this. Even a basic version (name + relationship + birthday) would suffice for MVP. | High | Medium |
| R5.3 | **Replace continuous sliders with discrete 5-point scales.** Instead of a 0-100 slider, use 5 labeled options: Very Low, Low, Medium, High, Very High. Clearer mental model, easier to use on touch screens. | Medium | Low |
| R5.4 | **Add placeholder examples to "Sensitive Topics."** E.g., "e.g., past relationships, weight, family conflicts..." | Low | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL5.1 | Trait sliders reverse in RTL (low on right, high on left). This is counterintuitive for sliders. Even in RTL contexts, progress/increase typically reads left-to-right. | Consider keeping sliders LTR with RTL labels, or use the discrete 5-point scale which avoids directionality issues |
| RTL5.2 | Profile completion percentage bar fills left-to-right. Should this reverse in RTL? Percentage bars are typically LTR universally. | Keep LTR for progress bars; this is a standard exception |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A5.1 | Trait sliders lack accessible labels at each position. Screen readers announce only "slider at 70%" with no context for what 70% means. | Add accessible labels: "Romantic level: High" |
| A5.2 | Profile overview has icon-heavy section tiles. Icons alone may not communicate section purpose. | Ensure all icons have text labels (they do per wireframe -- verify implementation) |

---

## Flow 6: SOS Mode Activation

### Flow Diagram

```
Screen 26          Screen 27           Screen 28
SOS Entry    -->   Assessment     -->  SOS Response
("She's Upset"      Wizard             (Action Plan:
 button, Quick       (3 steps:          SAY/DO/BUY/GO,
 Scenarios)          What/Severity/     Copy, Coach)
                     Context)

OR (quick path):
Screen 26    -->   Screen 28
Quick           -->  Response
Scenario             (pre-filled)
(skip wizard)
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Jessica is upset after a disagreement | Marcus opens LOLO. Taps SOS in bottom nav. |
| 2 | SOS Entry screen | Sees large red "SHE'S UPSET" button. Below: quick scenarios. "We had a fight" is listed. |
| 3 | Taps "We had a fight" | Quick scenario bypasses assessment wizard. Goes directly to response. |
| 4 | Response in < 10 seconds | SAY: "I've been thinking about what you said, and you're right..." DO: "1. Give her 2 hours space. 2. Make her favorite tea. 3. Sit next to her (not across)." |
| 5 | Uses the advice | Copies the SAY message. Follows DO steps. |

**Marcus experience:** The quick scenario path is excellent -- under 60 seconds from crisis to coaching. The one concern: Marcus is on the free tier and SOS is limited to 1 use/month. If this is his second SOS situation in a month, he hits a paywall during a crisis.

**Time to coaching:** < 15 seconds via quick scenario path. Meets the < 60 second target.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Noura is upset about a wedding planning disagreement | Ahmed opens SOS Mode. |
| 2 | No quick scenario matches | Quick scenarios: "I forgot our anniversary," "We had a fight," "She's not talking to me." None of these match "disagreement about wedding planning with family involvement." Ahmed must use the main SOS button. |
| 3 | Assessment wizard | Step 1: "We had an argument" (closest option). Step 2: Severity 2 (clearly upset). Step 3: Adds context in Arabic: "Wedding venue disagreement. Her mother has different opinion." Tags: "Family." |
| 4 | Generates response | Response includes Arabic text. SAY card in formal/respectful tone for an engagement-stage relationship. |

**Ahmed experience:** The quick scenarios are too generic for his specific cultural context. "Wedding planning disagreement" with family involvement is a common GCC crisis scenario that is not represented. The assessment wizard adds 30-45 seconds to the flow. The AI response quality depends heavily on cultural calibration.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Aisyah is crying after a bad pregnancy day | Hafiz reaches for LOLO in a panic. |
| 2 | Opens SOS | Sees "SHE'S UPSET" button. But wait -- wireframe says free tier sees "SOS Mode requires Pro" overlay. |
| 3 | **Paywall.** | Hafiz, in the middle of his wife's emotional crisis, is shown an upgrade prompt. |

**Hafiz experience:** **Catastrophic.** This is the single worst UX moment in the entire app. A man reaches for help while his pregnant wife is crying, and the app says "pay $3.20/month first." This is not just a UX problem; it is an ethical issue and a reputation risk. If even one user tweets about this experience, it could damage LOLO's brand.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 90% | Quick scenario path is fast; free-tier limit is a risk |
| Ahmed (AR) | 78% | Quick scenarios do not match his cultural context; wizard adds time |
| Hafiz (MS) | 35% | Paywall blocks the entire flow for free users |
| **Weighted Average** | **68%** | Severely dragged down by Hafiz's paywall collision |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F6.1 | **Critical** | SOS Mode is paywalled for free-tier users. The wireframe shows "SOS Mode requires Pro" overlay on Screen 26 for free users. This creates an ethically problematic barrier during emotional crises. | Hafiz (and all free-tier users) |
| F6.2 | **Major** | Quick scenarios are limited to 3 generic options. They do not cover culturally specific crisis types: wedding planning disputes (Ahmed), pregnancy-related emotional breakdowns (Hafiz), mother-in-law conflicts (Hafiz, Ahmed). | Ahmed, Hafiz |
| F6.3 | **Major** | Assessment wizard (3 steps) adds 30-60 seconds when the user is in emotional distress. Step 3 (free-text context + tag selection) is particularly high-friction during a crisis. | All |
| F6.4 | **Minor** | The "How bad is it? (1-5)" severity scale labels are Western-centric. "Considering leaving" (level 5) is an extremely loaded phrase in Gulf culture where engagement dissolution has family-wide implications. | Ahmed |
| F6.5 | **Minor** | One-hand usability: The SOS button is centered at mid-screen height. If the user is holding their phone in one hand (during a conversation), the button should be in the lower thumb zone. | All |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H3: User control and freedom** | Paywall during crisis = zero user control. The user cannot access help they need. | Critical |
| **H5: Error prevention** | If a free user accidentally taps a quick scenario, they see a paywall instead of a gentle redirect. No error prevention for this dead end. | Major |
| **H7: Flexibility and efficiency of use** | Assessment wizard does not offer a "skip to advice" option. Even the quick scenarios are limited to 3 options. | Major |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R6.1 | **Make SOS Mode free for all users, always.** Remove the paywall entirely from SOS entry, assessment, and basic coaching. Monetize the follow-up features: real-time coaching chat (Pro), premium AI analysis (Legend), and unlimited SOS sessions (Pro+). The first SOS response should always be free. This is both ethical and strategic: a powerful SOS experience converts free users to paid users out of gratitude, not desperation. | Critical | Low (just changing tier gates) |
| R6.2 | **Expand quick scenarios to 6-8 options, culturally segmented.** Add: "Wedding/family planning dispute," "She's having a hard pregnancy day," "Mother-in-law conflict," "I forgot a promise," "Financial disagreement." Contextually show relevant options based on user's profile (e.g., pregnancy scenario only if pregnancy is indicated). | High | Medium |
| R6.3 | **Reduce assessment wizard to 2 steps.** Merge Step 1 (what happened) and Step 3 (context/tags) into a single screen. Remove the severity scale (Step 2) -- the AI can infer severity from the description. This saves 15-20 seconds during crisis. | High | Low |
| R6.4 | **Move SOS button to lower-third of screen.** Place it in the thumb zone (bottom 33% of screen) for one-hand usability during active conversations. | Medium | Low |
| R6.5 | **Reword severity level 5.** Replace "Considering leaving" with "Very serious -- may need professional help." Include a helpline reference at severity 4-5 as a safety measure. | Medium | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL6.1 | Severity scale: 1 (mild) on right, 5 (severe) on left in RTL. Like star ratings, number scales are universally LTR. | Keep severity scale LTR even in RTL context, or use vertical layout |
| RTL6.2 | Quick scenario tiles: chevrons flip to left. Verify adequate touch targets in RTL. | Test with Arabic users |
| RTL6.3 | Progress bar in assessment wizard fills from right to left in RTL. Verify this behavior. | Implement RTL-aware progress bar |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A6.1 | SOS button relies on pulsing glow animation for attention. Users with vestibular disorders or reduced motion preferences may miss or be distressed by this. | Respect system "reduce motion" preference; provide a high-contrast static alternative |
| A6.2 | Severity scale is visual (numbered circles). No screen reader annotation for the labels. | Announce: "Severity 3 of 5: Very angry" |

---

## Flow 7: Gift Recommendation

### Flow Diagram

```
Screen 23          Screen 24          External
Gift Browser  -->  Gift Detail   -->  Purchase Link
(Occasion &        (Image, Price,      (Amazon, Noon,
 Budget filters,    Why, Present-       Shopee)
 Gift cards with    ation, Message,
 match %)           Backup, Buy links)

OR:
Screen 25
Low Budget Mode
(Free experiences,
 Under $20,
 DIY ideas)
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Taps "Gifts" in bottom nav | Gift Browser loads. Occasion: selects "Bday." Budget: selects "$50-100." |
| 2 | Browses recommendations | 3 gift cards appear with match percentages. "Personalized Necklace - $35 - 95% match." "Spa Gift Card - $45 - 88% match." "Custom Photo Album - $28 - 85% match." |
| 3 | Taps "Personalized Necklace" | Detail view: image, price, "Why this gift?" explanation referencing Her Profile data, presentation idea, message to attach, backup plan, Amazon link. |
| 4 | Taps "Go" on Amazon link | Opens browser/Amazon app. Purchases. |

**Marcus experience:** Excellent. The match percentage gives him data-driven confidence. The "Why this gift?" section directly references things he logged in Her Profile, validating the time he spent building it. The backup plan addresses his anxiety about items being unavailable.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Navigates to Gifts for Eid shopping | Occasion filter: No "Eid" option in the wireframe chips. Options: Any, Bday, Anniv, Apology, Just because. |
| 2 | Frustration | **"Where is Eid?"** Ahmed must select "Any" or "Just because" -- neither of which captures the cultural significance of Eid gift-giving. |
| 3 | Budget: selects "$100-200" | Results load. But Ahmed also needs separate gift sets for Noura, her mother, and her sisters. The Gift Browser does not have a "recipient" filter. |
| 4 | Concern about cultural appropriateness | If the AI suggests lingerie, alcohol-adjacent items, or culturally inappropriate gifts, Ahmed's trust is permanently broken. The wireframe mentions cultural filtering in the feature backlog but does not show how it manifests in the UI. |

**Ahmed experience:** The Gift Engine has critical gaps for Gulf culture. No Eid occasion, no multi-recipient workflow, and no visible cultural filter guarantee. The "Where to Buy" links should include Noon.com (GCC e-commerce), not just Amazon.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Navigates to Gifts | Sees "Low Budget Mode" link at the bottom. This is his entry point. |
| 2 | Taps "Low Budget Mode" | Screen 25: "The best gifts don't have price tags." Three sections: Free Experiences, Under $20, DIY Ideas. |
| 3 | Reads suggestions | "Sunset walk at nearby park," "Home-cooked dinner -- her favorite pasta recipe," "Custom playlist of 'our songs.'" Under $20: "Single rose with handwritten note ~$5." DIY: "Love letter template." |
| 4 | Taps "Love letter template" | Sees a Malay-language love letter template he can customize. |

**Hafiz experience:** The Low Budget Mode is the killer feature for Hafiz. It validates that thoughtfulness is not about money. The Malay-localized suggestions (kuih from specific stalls, handwritten surat cinta) would make this deeply personal. Currency in MYR is essential.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 92% | Clean flow, data-driven confidence |
| Ahmed (AR) | 70% | Missing Eid occasion, no recipient filter, cultural safety uncertainty |
| Hafiz (MS) | 88% | Low Budget Mode is perfect for his needs |
| **Weighted Average** | **83%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F7.1 | **Major** | Occasion filter does not include "Eid," "Hari Raya," or any religious occasion. These are the highest-stakes gifting events for 2 of 3 personas. | Ahmed, Hafiz |
| F7.2 | **Major** | No recipient selector. Ahmed needs to buy gifts for 4-5 people (Noura, her mother, her father, her sisters). The current flow generates gifts for "her" only. | Ahmed |
| F7.3 | **Major** | No visible cultural filter guarantee. Ahmed needs assurance that haram items (alcohol, inappropriate clothing) will never be suggested. No UI element communicates this safety. | Ahmed |
| F7.4 | **Minor** | Budget filter uses USD ranges ($0-25, $25-50, etc.). For Malaysian users, these need to be in MYR ranges (RM 0-50, RM 50-100, etc.). | Hafiz |
| F7.5 | **Minor** | "Low Budget Mode" is buried as a text link at the bottom of the Gift Browser. It should be more prominent for the Malay market where it is the primary use case. | Hafiz |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H2: Match between system and real world** | Occasion categories are Western-centric (no Eid, no Raya). | Major |
| **H5: Error prevention** | No cultural safety filter visible in UI. Users have no confidence that haram items are excluded. | Major |
| **H7: Flexibility and efficiency of use** | No multi-recipient workflow for users who need to buy gifts for an entire family. | Major |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R7.1 | **Add "Eid," "Hari Raya," and "Ramadan" to occasion filter.** Auto-show when user's cultural context includes Islamic observance. These should be top-level filter chips, not hidden under "Custom." | High | Low |
| R7.2 | **Add a recipient selector.** "Who is this gift for?" with options populated from Her Profile and Family Member profiles. Adjust gift style, budget, and cultural appropriateness per recipient. | High | Medium |
| R7.3 | **Add a visible "Halal/Culturally Appropriate" badge on all gift suggestions.** When cultural context is Islamic, show a green "Culturally Appropriate" badge on each gift card. This communicates that filtering has been applied and builds trust. | High | Low |
| R7.4 | **Elevate Low Budget Mode for Malaysian market.** In Malay locale, show "Low Budget, High Impact" as the first/primary tab, not a buried link. | Medium | Low |
| R7.5 | **Implement locale-aware budget ranges.** MYR: RM 0-30, RM 30-80, RM 80-150, RM 150+. AED: AED 0-100, AED 100-300, AED 300-500, AED 500+. | Medium | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL7.1 | Gift cards: "View" button moves to left in RTL. Ensure it remains in the natural end-aligned position for the language. | Verify button positioning |
| RTL7.2 | Match percentage badge (e.g., "95% match") moves to top-left in RTL. Ensure it does not overlap with the gift title text. | Test layout overlap in RTL |
| RTL7.3 | Vendor tiles on Gift Detail: icon swaps sides. Verify "Go" button remains tappable with adequate spacing. | Test touch targets |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A7.1 | Gift images are placeholder-only in wireframe. Ensure all gift images have meaningful alt text when real images are implemented. | Add descriptive alt text for every gift image |
| A7.2 | Match percentage uses color (green) to indicate quality. | Add text: "95% match - Excellent fit" |

---

## Flow 8: Action Card Interaction

### Flow Diagram

```
Push              Screen 9          Card Detail        Completion
Notification -->  Dashboard    -->  (Expanded card -->  Animation
(discreet)        (See card          with full           (+XP,
                   in feed)          instructions)       streak update)

                                                    --> Next Card
                                                        (if Pro/Legend)
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Morning notification | "LOLO" notification. Taps to open. |
| 2 | Sees SAY card | "Tell her something specific you noticed about her today." Pre-generated message: "Hey Jess, the way you organized Lily's playdate schedule was impressive. You make it look easy." |
| 3 | Reads, adjusts | The message is almost right but Marcus wants to tweak it. Taps "Edit" -- but there is no inline edit on the dashboard card. He would need to go to AI Messages to customize. |
| 4 | Copies anyway | Taps "Copy." Sends via iMessage. Comes back and taps "Complete." |
| 5 | XP gain | +15 XP. Streak: 13 days. Brief animation. |

**Marcus experience:** Good. The SAY card is specific and actionable. The missing inline edit is a minor friction -- he has to choose between the pre-generated message or navigating to the full AI Messages module to customize.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1-2 | Same flow, Arabic | Card in Gulf Arabic. |
| 3 | BUY card | "Eid in 5 days. Get a gift for Noura's mother (Um Noura). Suggestion: premium dates box." |
| 4 | Acts | Taps "Browse" to see gift detail. Links to Gift Engine. |
| 5 | Completes | After purchasing, returns and taps "Complete." |

**Ahmed experience:** The card is culturally aware (references Um Noura, suggests culturally appropriate gift). But it depends on Family Member Profiles being available (Sprint 4 feature). Without it, the card cannot reference "Um Noura" by name.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1-2 | Same flow, Malay | |
| 3 | DO card | "Aisyah ada check-up esok. Offer untuk hantar dia." (Aisyah has a checkup tomorrow. Offer to drive her.) |
| 4 | Acts | Hafiz texts Aisyah to offer. She says yes. |
| 5 | Completes | +20 XP. Streak at 6 days. |
| 6 | Sees locked cards | Free tier: 1 card/day. The remaining 2 card slots show lock icons. |

**Hafiz experience:** The DO card is practical, pregnancy-aware, and budget-friendly (free action). The locked card slots create FOMO but also validate that the app has more to offer.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 93% | Clear and actionable; minor edit friction |
| Ahmed (AR) | 85% | Depends on family profile availability |
| Hafiz (MS) | 90% | Pregnancy-aware cards are highly relevant |
| **Weighted Average** | **89%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F8.1 | **Minor** | No inline editing of SAY card messages on the dashboard. Users must navigate to AI Messages to customize. This breaks the quick-action flow. | Marcus |
| F8.2 | **Minor** | SAY/DO/BUY/GO categorization may not be intuitive to all users on first encounter. No explanation of what the categories mean. | Hafiz |
| F8.3 | **Minor** | "Skip" button captures reason (too busy, not relevant, etc.) but does not explain that this feedback improves future cards. Users may not understand why they are being asked. | All |
| F8.4 | **Minor** | Card completion psychology: there is no "partial credit." A user who attempted a DO card but did not fully complete it has no way to log partial effort. | All |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H3: User control and freedom** | No inline edit on SAY cards from dashboard. Must navigate away. | Minor |
| **H10: Help and documentation** | SAY/DO/BUY/GO labels have no onboarding explanation. | Minor |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R8.1 | **Add inline edit to SAY card messages.** Tapping the message text in the card should make it editable directly. No need to navigate to AI Messages for minor tweaks. | Medium | Low |
| R8.2 | **Add a one-time tooltip explaining SAY/DO/BUY/GO.** On first action card view, show a brief overlay: "SAY = something to tell her, DO = an action to take, BUY = a gift to get, GO = somewhere to take her." | Medium | Low |
| R8.3 | **Explain skip feedback.** Add a micro-line: "This helps us give you better suggestions." | Low | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL8.1 | Card type badge (SAY/DO/BUY/GO) moves to top-right in RTL. Verify it does not overlap with the card's action buttons. | Check layout overlap |
| RTL8.2 | Action buttons (Copy/Send/Complete) move to bottom-left in RTL. Thumb reach for right-handed users (majority) may be affected. | Consider keeping action buttons on the right side regardless of layout direction |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A8.1 | Card type is communicated by color-coded badge. Color-blind users need text label. | Ensure SAY/DO/BUY/GO text is always visible, not color-only |

---

## Flow 9: Subscription Upgrade

### Flow Diagram

```
Trigger           Paywall Screen      Payment
(Hit free    -->  (Feature            Flow
 limit:            comparison,    -->  (Google Play /
 messages,         3 tiers,            Apple IAP)
 SOS, cards)       regional pricing)

                                  --> Confirmation
                                      ("Welcome to Pro!")
                                  --> Return to
                                      original flow
```

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Hits 5 message/month limit on Day 9 | Tries to generate a 6th message. Button disabled. Sees: "You've used all 5 free messages this month. Upgrade to Pro for 30 messages/month." |
| 2 | Paywall screen | Feature comparison: Free vs Pro ($6.99/mo) vs Legend ($12.99/mo). Pro highlighted as "Most Popular." "Start Pro Free Trial" CTA prominent. "7-day free trial, cancel anytime." |
| 3 | Evaluates | Marcus sees the value: he has already sent 5 messages that worked. $6.99/mo is less than his YouTube Premium subscription. The 7-day trial reduces risk. |
| 4 | Subscribes | Taps "Start Pro Free Trial." Apple IAP sheet appears. Confirms with Face ID. "Welcome to Pro!" toast. |
| 5 | Returns to flow | Message generator is now unlocked with 30 messages/month. Generates his message. |

**Marcus experience:** Smooth. The paywall appears at a natural friction point (he has already received value from 5 messages). The 7-day trial reduces hesitation. Pricing is fair for his income level.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Hits message limit on Day 1 | Ahmed sends messages to Noura, her father, and her mother within hours. 5 messages gone in one sitting. |
| 2 | Paywall | Sees pricing. If displayed in AED, the conversion is clear. If in USD, he has to mentally convert. |
| 3 | No hesitation | $6.99/mo is negligible for Ahmed's income (AED 25,000/mo). Upgrades immediately. Continues to Legend by Week 1 when he needs the full Gift Engine for Eid. |

**Ahmed experience:** The friction is in currency display, not price sensitivity. If AED pricing is implemented correctly, this is a frictionless conversion.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Hits message limit on Day 11 | Needs a comfort message for Aisyah's bad day. Cannot generate one. |
| 2 | Paywall | Sees pricing. If RM 14.90/month is displayed: he hesitates. This is more than his Spotify family plan. If USD $6.99 is displayed: he is shocked (RM ~32, way over his threshold). |
| 3 | Deliberates for 2 days | On Day 13, Aisyah has another bad day. Hafiz needs the message. Upgrades to Pro at RM 14.90. |
| 4 | Ongoing concern | Will check monthly if the subscription is "worth it." If action cards feel repetitive, he will churn. |

**Hafiz experience:** The conversion happens but is painful. The 2-day deliberation period is a retention risk -- if the free tier experience is poor during those 2 days, Hafiz may churn entirely instead of upgrading.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 88% | Natural conversion point; trial reduces friction |
| Ahmed (AR) | 95% | Price insensitive; converts immediately if currency is correct |
| Hafiz (MS) | 55% | Price-sensitive; 2-day deliberation, risk of abandonment |
| **Weighted Average** | **79%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F9.1 | **Critical** | Regional pricing display is not guaranteed in the wireframe. If Hafiz sees USD instead of MYR, the perceived price doubles and conversion likelihood drops dramatically. | Hafiz |
| F9.2 | **Major** | No annual plan option is shown on the paywall screen. The persona analysis predicts 50%+ of Malaysian users would choose annual billing (RM 119/year = RM 9.90/mo). This option is absent from the wireframe. | Hafiz |
| F9.3 | **Major** | The paywall blocks the current action. When Hafiz hits the message limit, he cannot even see a preview of what the message would look like. A "blurred preview" showing a teaser of the message would significantly increase conversion. | All (free tier) |
| F9.4 | **Minor** | Feature comparison table on the paywall (Screen 8/paywall trigger) shows 6 rows of features. On small screens, the full comparison requires scrolling, with the CTA button potentially below the fold. | Hafiz |
| F9.5 | **Minor** | No "restore purchase" option visible on the paywall screen. Users who reinstall the app need to recover their subscription. | All |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H2: Match between system and real world** | USD pricing in MYR market does not match user's financial context. | Critical |
| **H3: User control and freedom** | Paywall completely blocks the flow with no preview or alternative. | Major |
| **H7: Flexibility and efficiency of use** | No annual plan = no flexibility for price-sensitive users. | Major |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R9.1 | **Implement locale-aware pricing from Day 1.** This is a blocking requirement. MYR for Malaysia, AED for GCC, USD for US. Use platform billing APIs for automatic currency display. | Critical | Medium |
| R9.2 | **Add annual plan option to paywall screen.** Show monthly and annual side by side. Highlight annual savings: "Save 30% with annual plan." For Hafiz: "RM 9.90/bulan dengan pelan tahunan" (RM 9.90/month with annual plan). | High | Low |
| R9.3 | **Show a blurred message preview before paywall.** Generate the message, show it blurred with a "Unlock this message" overlay. The user sees that the AI produced something specific and personal -- this dramatically increases perceived value and conversion. | High | Medium |
| R9.4 | **Add "Restore Purchase" link on paywall screen.** Small text link below the CTA buttons. | Low | Low |
| R9.5 | **Make the CTA sticky (fixed to bottom of screen).** Ensure the "Start Free Trial" button is always visible regardless of scroll position on the feature comparison. | Medium | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL9.1 | Feature comparison table: column order should reverse in RTL (Legend on left, Free on right). | Verify table layout direction |
| RTL9.2 | Price formatting: AED symbol placement may differ. Verify locale-specific currency formatting (e.g., "AED 25.99" vs "25.99 AED"). | Implement locale-aware currency formatting |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A9.1 | Feature comparison table is complex for screen readers. | Provide a "Compare plans" accessible list view as an alternative to the table |

---

## Flow 10: Memory Vault Usage

### Flow Diagram

```
Screen 35          Screen 36          Screen 37
Memory Vault  -->  Add Memory    -->  Memory Detail
(Entries list,      (Title, Desc,      (Full entry,
 Wish List tab,     Date, Photo,       Edit, Delete)
 Search/Filter)     Tags)

Wish List path:
Screen 35          Screen 36          Gift Engine
Wish List Tab -->  Add Wish      -->  Auto-surfaced
                    (Item, Price,      before gifting
                     Priority)          occasion
```

**Note:** Memory Vault wireframes (Screens 35-38) are referenced in the wireframe spec table of contents but their detailed wireframes were not fully included in the pages reviewed. This evaluation is based on the feature backlog specifications (M-33, M-34) and the interaction patterns established by other modules.

### Per-Persona Walkthrough

#### Marcus Thompson (EN)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Date night at a restaurant Jessica loved | Marcus opens Memory Vault from bottom nav. |
| 2 | Taps "+" to add | Title: "Italian restaurant in downtown." Description: "Jessica loved the truffle pasta. Said she wants to come back." Date: auto-fills today. Tags: "Date Night." |
| 3 | Saves | Quick. Under 30 seconds. |
| 4 | Later (3 weeks before anniversary) | LOLO surfaces this memory in a GO card: "Take her back to that Italian restaurant downtown -- she loved the truffle pasta." Marcus is impressed. |
| 5 | Wish List usage | Adds: "Jessica mentioned wanting that candle from the farmers market." Priority: "Really wants." |

**Marcus experience:** The capture is fast and the retrieval is where the magic happens. The 30-second capture leads to a highly personalized GO card weeks later. This is the "How did you know?" moment the persona journey map describes.

#### Ahmed Al-Mansouri (AR)

| Step | Action | Experience |
|------|--------|------------|
| 1 | After family dinner with Noura's family | Opens Memory Vault. |
| 2 | Adds memory | Title: "Abu Noura likes Al Ahli football team." Tags: "Family." |
| 3 | Wish List | Adds: "Noura mentioned a specific oud perfume brand -- Ajmal." |
| 4 | Free tier limit | Memory Vault: 10 entries max (free). Ahmed's family tracking needs exceed this quickly (7 family members with multiple observations each). |

**Ahmed experience:** The concept is perfect for his "family intelligence gathering" use case. But 10 entries on the free tier is severely limiting. He will need Pro (50 entries) immediately. The lack of family member profile linking means memories about Um Noura are mixed in with memories about Noura, with no structured way to filter by person.

#### Hafiz bin Ismail (MS)

| Step | Action | Experience |
|------|--------|------------|
| 1 | Aisyah mentions wanting curtains | Hafiz is at work. Aisyah texts about needing curtains for the baby's room. |
| 2 | Quick capture challenge | Hafiz needs to log this NOW before he forgets. Opens LOLO, navigates to Memory Vault, taps "+", types "Curtains for baby room", saves. |
| 3 | Speed assessment | This took approximately 15-20 seconds from app open. Acceptable if Hafiz is already in the LOLO habit. But if he is not in the habit, he might just think "I'll remember" and forget. |
| 4 | Missing quick-capture | There is no home-screen widget or quick-add shortcut. Every capture requires: open app -> navigate to Vault -> tap "+" -> fill form -> save. That is 4-5 steps. |

**Hafiz experience:** The Memory Vault is conceptually strong but the capture friction (4-5 steps to log a single item) risks under-usage. Hafiz's memories are most valuable when captured in the moment -- during a conversation, while reading a text from Aisyah, or during family gatherings. The current flow is too slow for in-the-moment capture.

### Predicted Task Completion Rates

| Persona | Predicted Completion Rate | Notes |
|---------|--------------------------|-------|
| Marcus (EN) | 85% | Good flow; retrieval value is high |
| Ahmed (AR) | 75% | Free tier limit is restrictive; no person-linking |
| Hafiz (MS) | 65% | Capture friction (4-5 steps) reduces usage; no quick-add |
| **Weighted Average** | **75%** | -- |

### Friction Points

| # | Severity | Description | Personas Affected |
|---|----------|-------------|-------------------|
| F10.1 | **Major** | Memory capture requires 4-5 steps (open app, navigate, tap +, fill form, save). This is too many steps for in-the-moment capture. Most memories are valuable precisely because they are captured in the moment. | Hafiz, All |
| F10.2 | **Major** | No person-linking for memories. Memories about Noura, her mother, and her sister are all in one undifferentiated list. Ahmed cannot filter by "Um Noura's memories" to prepare for her birthday. | Ahmed |
| F10.3 | **Minor** | Free tier limit of 10 memories is too restrictive for power users. Ahmed will exceed this within the first week. Hafiz may accumulate 10 entries within a month. | Ahmed, Hafiz |
| F10.4 | **Minor** | The Wish List auto-surfacing feature (S-02) is a Should Have, not a Must Have. If it does not ship at MVP, the Wish List becomes a passive storage tool with no proactive value. | All |
| F10.5 | **Minor** | No voice-to-text capture option (C-03 is a Could Have). This would dramatically reduce capture friction for users who are driving, cooking, or otherwise unable to type. | All |

### Usability Heuristic Violations

| Heuristic | Violation | Severity |
|-----------|-----------|----------|
| **H7: Flexibility and efficiency of use** | No quick-capture shortcut. Every memory requires full navigation + form. | Major |
| **H6: Recognition rather than recall** | No person-linking means users must remember which memories are about whom. | Major |

### Recommendations

| # | Recommendation | Impact | Effort |
|---|----------------|--------|--------|
| R10.1 | **Add a quick-capture FAB (Floating Action Button) on the home screen.** Tapping the FAB opens a minimal bottom sheet: Title + optional tag + Save. No navigation needed. Reduces capture to 2 steps. | High | Low |
| R10.2 | **Add "Person" tag to Memory Vault entries.** Allow tagging memories with a person (Her, Her Mother, Her Father, etc.). Enable filtering by person. | High | Medium |
| R10.3 | **Promote Wish List auto-surfacing (S-02) to Must Have.** Without proactive surfacing, the Wish List is a passive list. The auto-surfacing before gifting occasions is what transforms it into a "How did you know?" moment. | High | Low (priority change, not development change) |
| R10.4 | **Increase free tier memory limit from 10 to 20.** 10 is too restrictive for early engagement. Users who invest in Memory Vault data become locked in -- increasing the limit increases lock-in and retention, which drives eventual conversion. | Medium | Low |

### RTL-Specific Issues

| # | Issue | Recommendation |
|---|-------|----------------|
| RTL10.1 | Memory entries with Arabic text must align right. Mixed-language entries (Arabic title, English tag) need proper BiDi handling. | Test BiDi text rendering in memory entries |
| RTL10.2 | Tags should flow right-to-left in the entry form. | Verify chip layout in RTL |

### Accessibility Issues

| # | Issue | Recommendation |
|---|-------|------------|
| A10.1 | Photo attachments in memories need alt text. Auto-generated descriptions or user-provided alt text should be available. | Add alt text field for photo uploads |

---

## Summary: Overall Usability Score Prediction

### System Usability Scale (SUS) Prediction

Based on the cognitive walkthrough across all 10 flows, evaluating learnability, efficiency, memorability, errors, and satisfaction:

| Dimension | Score (0-100) | Rationale |
|-----------|---------------|-----------|
| Learnability | 72 | Onboarding is too long; some concepts (love languages, trait sliders) need explanation |
| Efficiency | 78 | Most daily tasks (dashboard, action cards) are quick; AI message generation has too many config steps |
| Memorability | 80 | Module structure is clear; bottom nav is standard; returning users can find things |
| Error rate | 68 | Several dead-end paywalls; no undo for card dismissal; SOS paywall is critical |
| Satisfaction | 76 | High for Marcus, moderate for Ahmed (cultural gaps), mixed for Hafiz (paywall frustrations) |

**Overall SUS Prediction: 74/100 (Grade: B / Adjective: Good)**

| Persona | Individual SUS Prediction | Primary Blocker |
|---------|---------------------------|-----------------|
| Marcus (EN) | 80 (Good-Excellent) | Minor: config screen complexity |
| Ahmed (AR) | 72 (Good) | Cultural feature gaps (Eid, family, Hijri) |
| Hafiz (MS) | 65 (OK-Good) | Paywall collisions, onboarding length, capture friction |

**Benchmark comparison:** Competitor apps in the relationship space average SUS scores of 60-70 (based on UX audit findings). LOLO's predicted 74 is above average, but the goal should be 80+ (Excellent) before launch. Closing the 7 critical and major issues identified in this report would raise the predicted SUS to 80-82.

---

## Top 10 Critical Findings

Ranked by severity and breadth of impact:

| Rank | Finding | Severity | Flows Affected | Personas Affected | Root Cause |
|------|---------|----------|----------------|-------------------|------------|
| **1** | **SOS Mode is paywalled for free users.** A user in emotional crisis is shown a payment screen instead of help. | Critical | Flow 6 | All (free tier), especially Hafiz | Monetization over empathy in feature gating |
| **2** | **Onboarding is 8 screens, exceeding the 5-screen target.** Each extra screen loses 8-12% of users. | Critical | Flow 1 | All, especially Hafiz (68% predicted completion) | Scope creep from original 5-screen plan |
| **3** | **Regional pricing not guaranteed in wireframes.** Malaysian and GCC users may see USD, dramatically reducing trust and conversion. | Critical | Flows 1, 9 | Ahmed, Hafiz | Wireframe mockup uses hardcoded USD |
| **4** | **"Comfort & Reassurance" message mode is paywalled.** Emotional support locked behind Pro tier at the moment of highest need. | Critical | Flow 3 | Hafiz, Marcus (during crises) | Monetization conflicting with core value delivery |
| **5** | **No Islamic holiday categories in Gifts and Reminders.** Eid, Ramadan, and Hari Raya are absent from occasion filters. | Major | Flows 4, 7 | Ahmed, Hafiz | Western-centric default categories |
| **6** | **No progress indicator in onboarding.** Users have no idea how many screens remain. | Major | Flow 1 | All | Missing navigation UX element |
| **7** | **AI Message Generator shows 10 modes in a flat grid with no grouping.** Choice paralysis reduces engagement. | Major | Flow 3 | All | Information architecture issue |
| **8** | **Memory Vault capture requires 4-5 steps.** Too slow for in-the-moment logging. | Major | Flow 10 | Hafiz, All | Missing quick-capture shortcut |
| **9** | **Family member profiles are not in MVP.** Ahmed cannot track her family's preferences. | Major | Flows 5, 7, 8 | Ahmed | Feature prioritization (Should Have, Sprint 4) |
| **10** | **Mood check-in and severity labels are Western-centric.** Arabic and Malay emotional vocabularies differ. | Major | Flows 2, 6 | Ahmed, Hafiz | Insufficient cultural localization of emotional categories |

---

## Priority Recommendations Matrix

### Impact vs. Effort Grid

```
                         HIGH IMPACT
                             |
    R6.1 SOS Free       R1.1 Reduce onboarding
    R3.1 Comfort free   R3.2 Group modes
    R9.1 Regional $     R3.4 Recipient selector
    R7.1 Eid occasion   R5.2 Family profiles MVP
    R9.3 Blurred msg    R10.1 Quick-capture FAB
           |                    |
LOW EFFORT +--------------------+---- HIGH EFFORT
           |                    |
    R1.2 Progress bar   R4.2 Hijri calendar
    R1.4 Love Lang help R2.1 Cultural moods
    R7.3 Halal badge    R3.3 Quick Generate
    R8.2 SAY/DO tooltip
    R9.2 Annual plan
    R10.4 Memory limit
           |
                         LOW IMPACT
```

### Priority Tiers

#### Tier 1: Do Immediately (Before Development Starts)

These are wireframe-level changes that must be resolved before Sprint 1 begins.

| # | Recommendation | Effort | Owner |
|---|----------------|--------|-------|
| R6.1 | Make SOS Mode free for all users | Low | PM (tier gate change) |
| R3.1 | Make Comfort & Reassurance free tier | Low | PM (tier gate change) |
| R1.1 | Reduce onboarding to 5 screens | Medium | UX Designer |
| R1.2 | Add progress indicator to onboarding | Low | UX Designer |
| R9.1 | Implement locale-aware pricing display | Medium | Backend + Frontend |
| R7.1 | Add Eid/Raya to occasion filters | Low | UX Designer + Backend |

#### Tier 2: Do During Sprint 1-2

| # | Recommendation | Effort | Owner |
|---|----------------|--------|-------|
| R3.2 | Group 10 message modes into 3 categories | Medium | UX Designer |
| R5.2 | Promote Family Member Profiles to MVP | Medium | PM + Backend |
| R10.1 | Add quick-capture FAB to home screen | Low | UX Designer + Frontend |
| R2.1 | Localize mood categories per culture | Medium | Cultural Advisors |
| R4.1 | Add Religious Holiday category to reminders | Low | UX Designer |
| R1.4 | Add "What is this?" to Love Language screen | Low | UX Designer |

#### Tier 3: Do During Sprint 3-4

| # | Recommendation | Effort | Owner |
|---|----------------|--------|-------|
| R3.4 | Add recipient selector to Message Config | Medium | UX Designer + Backend |
| R3.3 | Add Quick Generate shortcut | Medium | Frontend |
| R4.2 | Add Hijri calendar toggle to date picker | Medium | Frontend |
| R3.5 | Simplify Message Config with progressive disclosure | Low | UX Designer |
| R9.2 | Add annual plan option to paywall | Low | UX Designer + Backend |
| R7.3 | Add Halal/Culturally Appropriate badge | Low | Frontend |

#### Tier 4: Post-MVP Enhancement

| # | Recommendation | Effort | Owner |
|---|----------------|--------|-------|
| R10.2 | Add person-tagging to Memory Vault | Medium | Backend |
| R9.3 | Show blurred message preview before paywall | Medium | Frontend |
| R6.2 | Expand quick scenarios to 6-8 culturally segmented | Medium | AI Engineer |
| R6.3 | Reduce SOS assessment to 2 steps | Low | UX Designer |

---

## Flows Requiring Wireframe Revision Before Development

Based on the critical and major findings, the following flows require wireframe revisions before Sprint 1 development begins:

### Flow 1: First-Time Onboarding -- REVISION REQUIRED

**Changes needed:**
1. Reduce from 8 screens to 5 screens
2. Remove subscription teaser (Screen 8) from onboarding entirely
3. Add progress indicator (dot pagination or step counter)
4. Move Her Preferences (Screen 7) to post-onboarding progressive disclosure
5. Merge Her Zodiac (Screen 5) and Her Love Language (Screen 6) into a single screen
6. Add "What is this?" tooltip to Love Language section
7. Deliver first value moment (AI-generated card) at Screen 5 (not Screen 9)

**Revised flow:**
```
Screen 1: Language Select (unchanged)
Screen 2: Welcome (unchanged)
Screen 3: Sign Up (unchanged)
Screen 4: About You & Her (Name, Her Name, Status, Her Zodiac + Love Language combined)
Screen 5: First Value Moment (AI-generated action card with Copy/Share + CTA to dashboard)
```

### Flow 3: AI Message Generation -- REVISION REQUIRED

**Changes needed:**
1. Move "Comfort & Reassurance" to free tier
2. Group 10 modes into 3 categories (Daily, Emotional, Special)
3. Add progressive disclosure to Config screen (basic vs advanced options)
4. Add recipient selector for family member use cases
5. Clarify regeneration credit cost

### Flow 6: SOS Mode -- REVISION REQUIRED

**Changes needed:**
1. Remove paywall from SOS Mode entry (make basic SOS always free)
2. Expand quick scenarios from 3 to 6-8 with cultural segmentation
3. Reduce assessment wizard from 3 steps to 2
4. Move SOS button to lower-third thumb zone
5. Reword severity level 5 ("Considering leaving" -> "Very serious")

### Flow 9: Subscription Upgrade -- REVISION REQUIRED

**Changes needed:**
1. Implement locale-aware currency in all pricing displays
2. Add annual plan option
3. Add blurred message preview before paywall
4. Add "Restore Purchase" link
5. Make CTA button sticky (fixed to bottom)

### Flows That Are Good as Designed (Minor Issues Only)

- **Flow 2: Daily Dashboard** -- Minor mood category localization needed
- **Flow 4: Creating a Reminder** -- Add religious holiday category and Hijri calendar
- **Flow 5: Building Her Profile** -- Add value feedback loop; consider family profiles promotion
- **Flow 7: Gift Recommendation** -- Add Eid occasion and cultural safety badge
- **Flow 8: Action Card Interaction** -- Minor inline edit addition
- **Flow 10: Memory Vault** -- Add quick-capture FAB

---

## Appendix A: Cross-Flow RTL Issue Summary

| # | RTL Issue | Flows Affected | Priority |
|---|-----------|----------------|----------|
| 1 | Saudi flag may not represent all GCC Arabic users | Flow 1 | Low |
| 2 | Slider direction (trait sliders, humor slider, severity scale) reverses counterintuitively in RTL | Flows 3, 5, 6 | Medium |
| 3 | Calendar week-start must be Saturday for Arabic locale | Flow 4 | High |
| 4 | Swipe gestures (card dismiss, notification dismiss) must reverse direction | Flows 2, 8 | High |
| 5 | Mixed BiDi text (Arabic + English brand names) needs rendering testing | Flows 3, 10 | Medium |
| 6 | Progress bars: some should stay LTR (like star ratings), others should reverse | Flows 1, 6 | Medium |
| 7 | Bottom nav tab order reversal needs user validation | Flow 2 | High |

**Recommendation:** Conduct a dedicated RTL design review session with the UX designer and an Arabic-speaking tester before Sprint 1 development. Create an RTL checklist that every screen must pass before being marked as development-ready.

---

## Appendix B: Accessibility Summary

| # | Accessibility Issue | WCAG Level | Flows Affected | Priority |
|---|---------------------|------------|----------------|----------|
| 1 | Auto-advance on language selection (300ms) insufficient for motor disabilities | AA | Flow 1 | Medium |
| 2 | Zodiac wheel not screen-reader friendly | A | Flow 1 | High |
| 3 | Color-only state communication on chips and badges | AA | Flows 1, 7, 8 | High |
| 4 | Continuous sliders lack meaningful screen reader labels | AA | Flows 3, 5 | Medium |
| 5 | Complex tables (paywall, calendar) challenging for screen readers | A | Flows 4, 9 | Medium |
| 6 | Swipe-to-dismiss has no button alternative | AA | Flows 2, 8, 10 | High |
| 7 | SOS pulsing animation may trigger vestibular issues | AAA | Flow 6 | Low |
| 8 | Gift images need alt text | A | Flow 7 | Medium |

**Recommendation:** Ensure all custom components (zodiac wheel, trait sliders, card swipe) have accessible fallback interactions. Test with TalkBack (Android) and VoiceOver (iOS) before each sprint sign-off.

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | February 14, 2026 | Sarah Chen, Product Manager | Initial cognitive walkthrough and heuristic evaluation across 10 flows and 3 personas |

---

*Sarah Chen, Product Manager*
*LOLO -- "She won't know why you got so thoughtful. We won't tell."*

---

### References

- LOLO Wireframe Specifications v1.0 (Lina Vazquez, February 2026)
- LOLO Design System v1.0 (Lina Vazquez, February 2026)
- LOLO User Personas & Journey Maps v1.0 (Sarah Chen, February 2026)
- LOLO Feature Backlog MoSCoW v1.0 (Sarah Chen, February 2026)
- LOLO Cultural Sensitivity Guide (Nadia Khalil, February 2026)
- Nielsen Norman Group: 10 Usability Heuristics for User Interface Design
- System Usability Scale (SUS) -- Brooke, J. (1996)
- Cognitive Walkthrough Method -- Lewis, Polson, Wharton & Rieman (1990)
