# LOLO Flutter Feasibility Review -- Phase 2 Design Deliverables

**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Dependencies:** High-Fidelity Screen Specs (Parts 1, 2A, 2B), Brand Identity Guide v2.0, RTL Design Guidelines v2.0, API Contracts v1.0, User Testing Report v1.0, Architecture Document v1.0, Localization Architecture v1.0

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Section 1: Screen-by-Screen Feasibility](#section-1-screen-by-screen-feasibility)
3. [Section 2: Animation Feasibility](#section-2-animation-feasibility)
4. [Section 3: RTL Implementation Assessment](#section-3-rtl-implementation-assessment)
5. [Section 4: Package Recommendations](#section-4-package-recommendations)
6. [Section 5: API-Design Alignment](#section-5-api-design-alignment)
7. [Section 6: Performance Considerations](#section-6-performance-considerations)
8. [Section 7: Risk Register](#section-7-risk-register)
9. [Section 8: Implementation Recommendations](#section-8-implementation-recommendations)
10. [Section 9: Verdict](#section-9-verdict)

---

## Executive Summary

I have reviewed all Phase 2 design deliverables against our Phase 1 architecture and Flutter 3.x capabilities. The overall assessment is **GO WITH CAVEATS**. Every one of the 43 screens is implementable in Flutter. The design system is thorough, the API contracts align well with screen data needs, and the RTL guidelines are the most comprehensive I have seen for a mobile project.

However, there are specific areas that require deliberate engineering effort: SSE streaming for SOS coaching, the Tinder-like card swipe physics, the Rive streak flame with state-machine-driven intensity levels, and the mixed bidirectional text rendering in Arabic. None of these are blockers -- they are tractable challenges with known solutions. The risk lies in underestimating the cumulative effort of implementing 43 screens with full RTL parity, two theme modes, accessibility compliance, and offline-first sync across 10 modules simultaneously.

This document provides the screen-by-screen assessment, package recommendations, API alignment analysis, performance targets, risk register, and a recommended build order. My honest estimate is 22-26 person-weeks for a two-developer Flutter team, assuming the backend and AI services are developed in parallel.

---

## Section 1: Screen-by-Screen Feasibility

### Rating System

- **GREEN**: Straightforward Flutter implementation using standard widgets and patterns. No special packages or approaches required beyond our core stack.
- **YELLOW**: Achievable but requires a specific package, custom widget, or non-trivial implementation approach. Needs planning.
- **RED**: Significant challenge. Alternative approach recommended, or the specified interaction may need design negotiation.

---

### Module 1: Onboarding (Screens 1-8)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 1 | Language Selector | GREEN | Standard `Column` + `InkWell` tiles. SVG logo with gradient fill via `flutter_svg` + shader. Staggered entrance animations via `AnimationController` + `Interval`. Auto-advance with `Future.delayed`. Haptic feedback via `HapticFeedback.lightImpact()`. |
| 2 | Welcome | GREEN | Static layout with staggered animations. Benefit rows are simple `Row` widgets. The tagline accent color ("We won't tell." in gold) is a `RichText` with `TextSpan`. |
| 3 | Sign Up | GREEN | Standard form. Google Sign-In via `google_sign_in`, Apple Sign-In via `sign_in_with_apple`. Firebase Auth integration is well-established. Keyboard-aware scrolling via `SingleChildScrollView` + `MediaQuery.viewInsetsOf`. |
| 4 | Your Profile (Name/Age/Status) | GREEN | Simple form with `TextField`, numeric input, and segmented selection chips. |
| 5 | Her Zodiac | YELLOW | The zodiac wheel is a custom circular picker. Requires a custom `CustomPainter` or a radial layout widget. The "Enter her birthday instead" fallback is a standard date picker. The wheel interaction (rotate to select) needs a `GestureDetector` with `onPanUpdate` calculating angular position. **Effort: 1-2 days for the custom wheel widget.** Alternative: Use a horizontal carousel instead of a wheel -- simpler, equally effective. |
| 6 | Her Love Language | GREEN | Five selectable cards in a `Column`. Standard `GestureDetector` + state toggle. |
| 7 | Her Preferences | GREEN | Chip grid via `Wrap` widget with `FilterChip`. Radio group for communication style. Scrollable. |
| 8 | Subscription Teaser | YELLOW | RevenueCat paywall integration. The plan comparison table is a standard layout. The locale-aware currency display depends on RevenueCat's offering configuration -- currencies are handled server-side by the stores. **Risk: RevenueCat SDK initialization must happen before this screen.** Must pre-fetch offerings during onboarding flow. |

### Module 2: Dashboard (Screens 9-11)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 9 | Home Dashboard | GREEN | Scrollable column with greeting, streak card, mood check-in row, and action card preview. All standard Material widgets. The mood check-in is a horizontal `Row` of tappable emoji buttons. |
| 10 | Weekly Summary | GREEN | Stat cards + simple bar chart. Chart via `fl_chart`. Static data display. |
| 11 | Mood History | GREEN | Simple list with date grouping and mood indicators. |

### Module 3: Her Profile (Screens 12-15)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 12 | Her Profile Overview | GREEN | Profile card with avatar, completion percentage ring (custom `CustomPainter` arc -- trivial), and section list. |
| 13 | Edit Profile Form | GREEN | Standard multi-field form with validation. |
| 14 | Zodiac Detail | GREEN | Read-only card with zodiac traits, tips, and emotional needs rendered as styled `Text` widgets. |
| 15 | Family Members | GREEN | Simple CRUD list with navigation to detail screens. |

### Module 4: Smart Reminders (Screens 16-18)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 16 | Reminders List | YELLOW | Calendar view requires `table_calendar` package. The dual view (calendar + list) is a standard pattern but needs careful state management to sync selected date with filtered list. Hijri calendar support requires `hijri_picker` or manual integration with `HijriCalendar` Dart package. **Hijri calendar is a YELLOW concern -- limited Flutter package support.** |
| 17 | Create/Edit Reminder | GREEN | Standard form with date picker, time picker, recurrence selector, and escalation tier checkboxes. |
| 18 | Promise Tracker | GREEN | Filtered list view. |

### Module 5: AI Message Generator (Screens 19-22)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 19 | Mode Picker (10 modes) | GREEN | 2-column `GridView` with mode cards. Lock icons for free-tier restrictions. Per user testing recommendation R3.2, these may be grouped into 3 categories -- either approach is standard. |
| 20 | Message Config | GREEN | Form with tone selector, humor slider, length picker, context text field. The slider is a standard `Slider` widget. Progressive disclosure (advanced options in `ExpansionTile`) per recommendation R3.5. |
| 21 | Message Result | YELLOW | The **typewriter text effect** (AI message appearing character by character) requires a custom `AnimatedBuilder` that reveals characters progressively. Not hard, but needs to handle RTL text correctly -- Arabic characters must appear from right to left. **Effort: 0.5-1 day for the typewriter widget with RTL support.** |
| 22 | Message History | GREEN | Paginated list with cursor-based pagination. Standard `ListView.builder` with `ScrollController` for infinite scroll trigger. |

### Module 6: Gift Recommendation Engine (Screens 23-25)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 23 | Gift Browse | GREEN | 2-column grid with `GridView.builder`, horizontal chip filter row, search bar, toggle. Infinite scroll pagination. Shimmer loading via `shimmer` package. Standard implementation. |
| 24 | Gift Detail | YELLOW | The **hero image parallax scroll** requires a `CustomScrollView` with a `SliverAppBar` and a parallax effect on the image. The spec says "image scrolls at 0.5x speed of content, fades to 0 opacity at 240dp scroll." This is achievable with `SliverAppBar(flexibleSpace: ...)` and a `LayoutBuilder` to calculate parallax offset. Shared element hero transition from the browse grid card to the detail hero image requires `Hero` widget. **Effort: 1 day for the parallax + shared element combination.** |
| 25 | Gift History | GREEN | Standard filtered list. |

### Module 7: SOS Mode (Screens 26-29)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 26 | SOS Activation | YELLOW | The **SOS pulsing circle** with three concentric glow layers animating at different rates requires multiple nested `AnimatedBuilder` widgets or a `CustomPainter` driven by an `AnimationController`. The continuous glow oscillation (opacity 20% to 40% on a sine wave) is a custom `Tween` with a repeating controller. **Effort: 0.5 days.** Not complex, but must be visually polished since this is a crisis screen. |
| 27 | SOS Assessment | GREEN | 2-step inline wizard. Step 1: emoji severity selection (row of 5 tappable custom icons). Step 2: 3 option cards. Standard `PageView` or animated `AnimatedSwitcher` for step transitions. |
| 28 | SOS Coaching | RED | This is the most technically complex screen in the entire app. **SSE (Server-Sent Events) streaming** of coaching advice with real-time text rendering in a chat-like interface. The spec defines 5 distinct SSE event types (`coaching_start`, `say_this`, `do_not_say`, `body_language`, `coaching_complete`), each triggering different card types with distinct visual styling. Text streams in at 30ms/character intervals. The input field allows follow-up messages mid-stream. **Challenges:** (1) Dart's `http` package does not natively support SSE -- we need `eventsource` or a raw `HttpClient` with chunked transfer decoding. Dio does not support SSE natively. (2) Streaming text into a `ListView` that auto-scrolls requires careful state management to avoid rebuilding the entire list on every character. (3) RTL streaming text means characters must appear from the right side of the text widget. (4) Connection resilience -- auto-reconnect on SSE drop. **Recommended approach:** Use `http` package's `Client.send()` with `StreamedResponse` to read the SSE byte stream. Parse events manually (SSE protocol is simple). Build a `SosCoachingNotifier` that manages a list of `CoachingCard` objects. Use `AnimatedList` for smooth card insertion animations. Use a `StreamBuilder` within each card for the typewriter effect. **Effort: 3-5 days.** |
| 29 | SOS Resolution | GREEN | Outcome selection cards + follow-up action suggestions. Standard selectable list with a sticky bottom button. |

### Module 8: Gamification (Screens 30-32)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 30 | Progress Dashboard | YELLOW | Multiple custom visual elements: (1) Circular consistency gauge requires `CustomPainter` with animated arc sweep. (2) XP progress bar with animation. (3) Mini calendar dots for streak visualization. (4) **Rive streak flame** -- requires Rive runtime integration (`rive` package) with state machine inputs to control flame intensity based on streak length. (5) Level-up confetti celebration requires `confetti` package or custom particle system. **Effort: 2-3 days for all custom visual elements combined.** |
| 31 | Badges Gallery | GREEN | 3-column grid with tab filtering. Bottom sheet detail. Badge glow animation is a repeating opacity animation on a container decoration -- standard. |
| 32 | Level Up Celebration | GREEN | This is an overlay/dialog, not a full screen. Confetti particles + badge animation. |

### Module 9: Smart Action Cards (Screens 33-34)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 33 | Action Card Feed | YELLOW | The **Tinder-like swipeable card stack** is the second most complex widget in the app. Requirements: (1) Card follows finger with physics-based drag (rotation max 15 degrees proportional to horizontal displacement). (2) Three swipe directions (right=complete, left=skip, down=save) with distinct thresholds and visual overlays. (3) Peek card behind with 0.95 scale and 50% opacity that transitions to primary position on swipe. (4) Spring-back animation on sub-threshold release. **Recommended approach:** Use `flutter_card_swiper` package or build custom with `GestureDetector` + `Transform.rotate` + `AnimationController` for spring physics. The custom approach gives us more control over the three-direction behavior. **Effort: 2-3 days for a polished custom implementation.** |
| 34 | Action Card Detail | YELLOW | Shared element transition from the card stack to detail. `ExpansionTile` for "Why This Matters." Related cards horizontal carousel. The shared element transition with `Hero` widget requires matching tags between the card in the stack and the detail view. **Minor concern:** `Hero` transitions and `GoRouter` can sometimes conflict; we need to use `GoRouter`'s custom transition pages. **Effort: 1 day.** |

### Module 10: Memory Vault (Screens 35-38)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 35 | Memory Vault Home | YELLOW | The **vertical timeline** with a line, date markers, and offset memory cards is a custom layout. Options: (1) `CustomPainter` for the timeline line + positioned cards, or (2) `timeline_tile` package. The segmented control (Timeline vs Categories toggle) is a standard `CupertinoSlidingSegmentedControl` or custom widget. FAB with conditional extended state on scroll requires a `ScrollController` listener. **Effort: 1-2 days for the custom timeline.** |
| 36 | Add Memory | GREEN | Standard form with title, category chips, date picker, text area, photo attachment (camera/gallery via `image_picker`), tags chip input (`Wrap` + `TextField` combo), and toggle. |
| 37 | Memory Detail | GREEN | Scrollable detail with conditional photo hero, metadata row, content, tags, action buttons. The photo hero with scrim overlay is a `Stack` with a gradient `Container` overlay -- standard. |
| 38 | Wish List | GREEN | Filtered list view with status chips and action buttons. |

### Settings & Supplementary (Screens 39-43)

| # | Screen | Rating | Notes |
|---|--------|--------|-------|
| 39 | Settings Main | GREEN | Grouped `ListView` with sections, rows, toggles, and navigation arrows. This is the most standard Flutter screen possible. |
| 40 | Language Settings | GREEN | Three selectable tiles with locale switch and app restart. Runtime locale change via Riverpod locale provider + `MaterialApp.locale`. |
| 41 | Subscription Management | YELLOW | RevenueCat subscription status display, plan comparison, purchase flow, and restore purchases. RevenueCat's Flutter SDK handles the heavy lifting, but the UI for plan comparison and the "Currently on X plan" state machine requires careful implementation. **Effort: 1-2 days for the full subscription screen + RevenueCat integration testing.** |
| 42 | Paywall (Contextual) | YELLOW | Contextual paywall that appears at tier limit triggers (e.g., 6th AI message). Must be a reusable widget/route that receives the triggering context. RevenueCat provides `RevenueCatUI` for Paywalls, but we need custom branding. **Effort: 1 day.** |
| 43 | Empty States (Pattern) | GREEN | 5 empty-state variants across modules (no memories, no cards, no gifts, no reminders, no messages). Each is a centered `Column` with illustration, title, subtitle, and optional CTA button. These should be built as a single reusable `EmptyStateWidget` parameterized by content. |

### Feasibility Summary

| Rating | Count | Screens |
|--------|-------|---------|
| GREEN | 28 | 1, 2, 3, 4, 6, 7, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 22, 23, 25, 27, 29, 31, 32, 36, 37, 38, 39, 40, 43 |
| YELLOW | 14 | 5, 8, 16, 21, 24, 26, 30, 33, 34, 35, 41, 42 |
| RED | 1 | 28 (SOS Coaching with SSE streaming) |

**The single RED screen (SOS Coaching) is not a blocker.** It is a "significant challenge" that requires a deliberate engineering approach, not an alternative design. The recommended SSE implementation approach described above is proven. It warrants its own spike/prototype story in Sprint 4 before the Sprint 5 full build.

---

## Section 2: Animation Feasibility

### 2.1 Card Swipe Physics (Tinder-like)

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Moderate |
| **Effort** | 2-3 days |
| **Approach** | Custom implementation using `GestureDetector` + `AnimationController` with spring physics (`SpringSimulation`). Three-directional swipe with distinct thresholds (120dp horizontal, 80dp vertical). Card rotation via `Transform.rotate` proportional to horizontal displacement (max 15deg = 0.26 radians). Color overlay opacity proportional to displacement. Peek card animates to primary position using `AnimatedContainer` with spring curve. |
| **Package option** | `flutter_card_swiper` (pub.dev, 600+ likes). Supports customizable swipe directions and callbacks. However, the three-direction (right/left/down) requirement with distinct semantic meanings and the pull-down-to-save gesture may require forking or wrapping. |
| **Recommendation** | Build custom. The design spec is very specific (rotation angles, overlay colors, peek card behavior, snap-back spring). A custom implementation gives us exact control and avoids fighting a package's opinionated defaults. |

### 2.2 Typewriter Text Effect

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Easy-Moderate |
| **Effort** | 0.5-1 day |
| **Approach** | Custom `StatefulWidget` that takes a full string and reveals characters via a `Timer.periodic` at 30ms intervals, updating a `String` substring that feeds into a `Text` widget. For RTL: the `Text` widget with `TextDirection.rtl` naturally renders Arabic from right to left; we simply grow the substring from index 0 upward and the text engine handles visual placement. For SSE streaming where the full string is not known upfront: append characters to a `StringBuffer` as they arrive from the stream, and use `setState` or a `ValueNotifier` to trigger rebuilds. |
| **Package option** | `animated_text_kit` has a `TypewriterAnimatedText` but it does not support RTL or streaming input. |
| **Recommendation** | Build custom. It is simple enough and the RTL + streaming requirements make any existing package inadequate. |

### 2.3 Streak Flame (Rive)

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Moderate |
| **Effort** | 1-2 days (including Rive asset creation) |
| **Rive vs Lottie decision** | **Rive.** The spec calls for a state machine with four intensity levels (idle 1-7 days, medium 8-14, intense 15-30, legendary 30+). Rive's state machine system handles this natively -- we set an input number and the state machine transitions between animation states. Lottie does not have runtime state machines; we would need 4 separate Lottie files and manual crossfading. Rive is the clear winner for interactive, state-driven animations. |
| **Approach** | Create a Rive file with a state machine named "flame_intensity" and a numeric input "streak_days". Design 4 animation states with blend transitions. In Flutter, use `RiveAnimation.asset()` with a `StateMachineController` and set the input value from the streak provider. |
| **Package** | `rive: ^0.13.x` (official Rive Flutter runtime). |
| **Recommendation** | Rive. Commission the Rive asset from the design team or create in-house. The Flutter integration is 20 lines of code once the asset exists. |

### 2.4 XP Toast Floating Animation

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Easy |
| **Effort** | 0.5 day |
| **Approach** | Use Flutter's built-in `OverlayEntry` inserted at the top of the widget tree. The toast is a `Container` with green background, "+15 XP" text, pill border radius. Animation: `SlideTransition` (from -20dp to 0dp Y) + `FadeTransition`. Auto-dismiss after 2000ms with a 300ms fade-out. |
| **Package option** | `fluttertoast` or `another_flushbar`. But the spec is simple enough that a custom `Overlay` approach gives us exact control over positioning and animation. |
| **Recommendation** | Build custom using `OverlayEntry`. Wrap it in a reusable `XpToastService` that can be called from any Riverpod provider. |

### 2.5 Skeleton Shimmer

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Easy |
| **Effort** | 0.5 day |
| **Approach** | The shimmer effect (gradient sweep from left to right over placeholder shapes) is a well-solved problem. |
| **Package** | `shimmer: ^3.0.0` (pub.dev, 3000+ likes). Mature, performant, supports custom children and gradient colors. |
| **Recommendation** | Use `shimmer` package. Build module-specific shimmer placeholder widgets (e.g., `GiftCardShimmer`, `ActionCardShimmer`, `ReminderListShimmer`) that match the exact dimensions of the real content. The dark mode shimmer gradient (`#21262D` to `#30363D`) is configured via the `baseColor` and `highlightColor` parameters. |

### 2.6 Page Transitions (GoRouter)

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Easy |
| **Effort** | 0.5 day |
| **Approach** | GoRouter supports custom transitions via `CustomTransitionPage`. Define a directional slide transition that respects `Directionality`. For push: new page slides in from `endOffset` (right in LTR, left in RTL). For pop: current page slides out to `endOffset`. Use `SlideTransition` with `Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)` -- Flutter automatically mirrors this when `Directionality` is RTL. SOS screens use `FadeTransition` for urgency (no directional slide). |
| **Implementation** | Create a `LoloTransitionPage` factory that wraps `CustomTransitionPage` with the correct transition based on route context (standard slide, fade for SOS, bottom sheet slide for forms). |
| **Recommendation** | Build a small library of 3-4 reusable transition builders. Assign them in the GoRouter route definitions. |

### 2.7 Parallax Scroll (Gift Detail)

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Moderate |
| **Effort** | 1 day |
| **Approach** | Use `CustomScrollView` with `SliverAppBar(expandedHeight: 240, flexibleSpace: ...)`. Inside `flexibleSpace`, use a `LayoutBuilder` to read the scroll extent and apply a `Transform.translate` at 0.5x the scroll offset to the hero image. The opacity fade (1.0 to 0.0 over 240dp of scroll) is calculated as `1.0 - (scrollOffset / 240).clamp(0.0, 1.0)` and applied via `Opacity`. The back arrow overlay uses a `Positioned` widget inside a `Stack`. |
| **Package option** | None needed. `SliverAppBar` handles 90% of this natively. |
| **Recommendation** | Build with Flutter's built-in `SliverAppBar` + `FlexibleSpaceBar`. The parallax effect is a minor customization. |

### 2.8 SOS Pulsing Circle

| Aspect | Assessment |
|--------|-----------|
| **Rating** | Easy-Moderate |
| **Effort** | 0.5 day |
| **Approach** | Three concentric circles rendered with `Container` widgets inside a `Stack`, each wrapped in `AnimatedBuilder` driven by a single `AnimationController` with a 1500ms repeat period. The outer ring scales from 1.0 to 1.15 via `ScaleTransition`. Opacity oscillates between 20% and 40% using a `Tween<double>` with a sine-like curve (`Curves.easeInOut`). The core circle is static. |
| **Package option** | None needed. |
| **Recommendation** | Build custom with `AnimationController`. Simple and performant. |

### Animation Summary

| Animation | Difficulty | Effort | Approach |
|-----------|-----------|--------|----------|
| Card swipe physics | Moderate | 2-3 days | Custom (`GestureDetector` + spring physics) |
| Typewriter text | Easy-Moderate | 0.5-1 day | Custom (`Timer.periodic` + `ValueNotifier`) |
| Streak flame (Rive) | Moderate | 1-2 days | Rive state machine (`rive` package) |
| XP toast | Easy | 0.5 day | Custom (`OverlayEntry` + `SlideTransition`) |
| Skeleton shimmer | Easy | 0.5 day | `shimmer` package |
| Page transitions | Easy | 0.5 day | GoRouter `CustomTransitionPage` |
| Parallax scroll | Moderate | 1 day | `SliverAppBar` + `LayoutBuilder` |
| SOS pulsing circle | Easy-Moderate | 0.5 day | Custom (`AnimationController` + `ScaleTransition`) |

**Total animation effort: ~7-9 days** (spread across the sprint timeline, not a single block).

---

## Section 3: RTL Implementation Assessment

### 3.1 Flutter's Built-in RTL Coverage

Flutter's RTL support is excellent and covers approximately 85% of the design requirements out of the box:

| Requirement | Flutter Built-in Support | Notes |
|-------------|------------------------|-------|
| Text alignment mirroring | YES | `TextAlign.start`/`TextAlign.end` resolve directionally |
| Row/Column child order | YES | `Row` children automatically reverse in RTL `Directionality` |
| Padding/Margin mirroring | YES | `EdgeInsetsDirectional` resolves `start`/`end` to physical left/right |
| AppBar leading/trailing | YES | `AppBar` auto-mirrors back arrow and actions |
| BottomNavigationBar tab order | YES | Tabs auto-reverse in RTL |
| ListView scroll direction | YES | Horizontal `ListView` starts from right in RTL |
| Scaffold drawer anchor | YES | Drawer auto-opens from right in RTL |
| Icon mirroring (back arrow) | YES | `Icons.arrow_back` renders correctly per direction |
| TextDirection propagation | YES | `MaterialApp.locale` + `Directionality` propagate throughout widget tree |
| FAB position | YES | `FloatingActionButton` `endFloat` resolves to left in RTL |

### 3.2 Components Requiring Custom RTL Handling

The following items from the design specs require explicit developer attention beyond Flutter defaults:

| Component | Issue | Solution | Effort |
|-----------|-------|----------|--------|
| **Zodiac wheel (Screen 5)** | Custom circular picker has no inherent directionality. Need to verify gesture directions are intuitive in RTL. | Test with Arabic users. The wheel is radial, so it should be direction-agnostic. No code change expected. | 0 days |
| **SOS scenario chips grid (Screen 26)** | 2x3 grid must mirror so first chip is top-right in RTL. `GridView` does not auto-mirror by default. | Use `GridView` with `textDirection: Directionality.of(context)`. This forces grid item placement to respect directionality. | 0.25 days |
| **Action Card swipe gestures (Screen 33)** | The spec says swipe directions remain the same (right=complete, left=skip) regardless of locale. But the RTL design guidelines (Section 2.5) say swipe-right in RTL means "go forward." This is a design contradiction. | **Flag for design review.** My recommendation: keep swipe semantics consistent globally (right=positive, left=negative) since this is a Tinder-like interaction that users learn once. Do NOT mirror swipe meanings. Wrap the gesture detector in `Directionality(textDirection: TextDirection.ltr)` to prevent framework-level mirroring. | 0.5 days |
| **SOS coaching card accent borders (Screen 28)** | Left accent border must become right accent border in RTL. `BoxDecoration` border only supports uniform or per-side specification. | Use `BoxDecoration(border: BorderDirectional(start: BorderSide(...)))` -- this resolves start to right in RTL. | 0 days (just use `BorderDirectional`) |
| **Timeline line position (Screen 35)** | The 2dp timeline line is 16dp from left edge in LTR, must move to 16dp from right edge in RTL. | Use `EdgeInsetsDirectional.only(start: 16)` for the timeline line `Positioned` widget. Memory cards offset from the start side. | 0.25 days |
| **Humor slider direction (noted in user testing RTL3.2)** | Sliders universally fill left-to-right. The user testing report flags that in RTL, "None" on right and "Max" on left is counterintuitive. | Keep slider LTR (do not mirror). Wrap the slider in `Directionality(textDirection: TextDirection.ltr)` and place labels explicitly. This matches the RTL design guideline Section 1.2 (progress bars representing continuous values do not mirror). | 0.25 days |
| **Phone number and email fields** | Must remain LTR even in Arabic context per RTL guidelines. | Set `textDirection: TextDirection.ltr` on phone/email `TextField` widgets and credit card fields. | 0.25 days |
| **Mixed BiDi text in notifications** | Arabic notification bodies containing "LOLO" or English brand names must render correctly. | Use Unicode directional isolates (`\u2068`...`\u2069`) around embedded LTR strings in ARB translation files. Test on Samsung, Huawei, and Pixel devices. | 1 day (testing effort) |
| **Chart X-axis (time-based)** | The gamification consistency gauge time axis must not mirror per RTL guidelines Section 1.2. | Hardcode LTR for any time-series chart using `Directionality(textDirection: TextDirection.ltr)`. | 0.25 days |

### 3.3 Arabic Font Rendering

| Font | Usage | Concern | Mitigation |
|------|-------|---------|------------|
| **Cairo** | Headings, display text, labels | Cairo is a well-supported Google Font with excellent Arabic glyph coverage. It is designed for screen display and works well at heading sizes. No rendering concerns. | Bundle via `google_fonts` package or embed as an asset. I recommend embedding to avoid network dependency on first launch. |
| **Noto Naskh Arabic** | Body text, paragraphs, long-form content | Noto Naskh Arabic is specifically designed for Arabic body text readability. It supports all Arabic diacriticals and tashkeel marks. The concern is file size -- Noto Naskh Arabic regular is ~230KB, which is reasonable. | Embed as asset. Include Regular (400) and Bold (700) weights only. |
| **Inter** | English/Malay text | No concerns. Inter is the workhorse Latin font. | Bundle via `google_fonts` or embed. |
| **Font size adjustment (+2sp for Arabic)** | The RTL guidelines specify +2sp for headings and +1sp for body text in Arabic to compensate for x-height differences. | Implement via locale-aware `TextTheme` in the theme system. Create `arabicTextTheme` and `defaultTextTheme` and select based on `Localizations.localeOf(context)`. | 0.5 days |

### 3.4 Mixed Bidirectional Text Handling

The RTL design guidelines document 5 BiDi scenarios. Flutter's `Text` widget uses the ICU BiDi algorithm, which handles the majority of cases correctly. My assessment:

| Scenario | Auto-handled? | Manual intervention needed? |
|----------|:------------:|:---------------------------:|
| Arabic paragraph with English words | Yes | No |
| Arabic label + English value (email) | Mostly | Use `Row` with `MainAxisAlignment.spaceBetween`; set explicit `TextDirection` on each child |
| Arabic text with Western numerals | Yes | No (default is Western numerals per LOLO spec) |
| Arabic text ending with LTR string (e.g., "WhatsApp") | Sometimes incorrect | Insert `\u200F` (RLM) after the LTR string in ARB files |
| Bidirectional text in notifications | Device-dependent | Test extensively; use directional isolates |

**Total estimated effort for BiDi text handling: 1-2 days** of careful implementation + 2-3 days of testing across devices.

### 3.5 Runtime Locale Switching

The spec requires runtime locale switching without app restart. Impact assessment:

| Aspect | Impact | Solution |
|--------|--------|----------|
| Widget tree rebuild | High -- changing `MaterialApp.locale` triggers a full widget tree rebuild | Use a Riverpod `StateNotifierProvider<LocaleNotifier, Locale>` that the `MaterialApp` watches. On locale change, the entire app rebuilds. This is expected behavior and is fast (~16ms on modern devices). |
| GoRouter state | Low -- route state is preserved across rebuilds | GoRouter is declared outside the widget tree; it survives locale changes. Current route and stack are unaffected. |
| Form state | Medium -- unsaved form data will be lost on locale change | Show a confirmation dialog before switching: "Changing language will restart the app. Unsaved changes will be lost." Alternatively, persist form state to temporary storage. |
| Cached API responses | Medium -- locale-dependent cache keys must be invalidated | On language change, call a `CacheInvalidationService` that clears all locale-dependent Redis keys (zodiac traits, AI responses, etc.) and local Hive cache. |
| Animation state | Low -- in-progress animations restart but this is invisible to the user | No special handling needed. |

### 3.6 RTL Effort Estimate

**Estimated additional effort for full RTL support: +25-30% on top of LTR-only development.**

Breakdown:
- Theme and typography setup (Arabic fonts, +sp sizes): 1 day
- Per-screen RTL verification and fixes (43 screens x 0.5h average): ~3 days
- Custom widget RTL adaptations (timeline, card swipe, charts): 1.5 days
- BiDi text handling in ARB files and UI: 1.5 days
- Golden test snapshots for RTL variants: 2 days
- Device testing (Samsung, Huawei, Pixel in Arabic): 2-3 days

**Total RTL-specific effort: 11-14 days** on top of the base LTR implementation.

---

## Section 4: Package Recommendations

| Package | pub.dev Score | Version | Purpose | Risk Level | Alternative |
|---------|:------------:|---------|---------|:----------:|-------------|
| `flutter_riverpod` | 4000+ likes | ^2.5.x | State management + DI | LOW | `bloc` (but architecture is designed around Riverpod) |
| `riverpod_annotation` | 1500+ likes | ^2.3.x | Code generation for Riverpod providers | LOW | Manual provider declaration |
| `go_router` | 4500+ likes | ^14.x | Declarative navigation | LOW | `auto_route` |
| `dio` | 6000+ likes | ^5.4.x | HTTP client with interceptors | LOW | `http` (but lacks interceptor chain) |
| `hive_flutter` | 3000+ likes | ^1.1.x | Local key-value storage (offline cache) | LOW | `shared_preferences` (simpler but less structured) |
| `isar` | 2500+ likes | ^3.1.x | Local database for structured data (memories, reminders) | MEDIUM | `sqflite`, `drift`. Isar's future maintenance is a concern since the lead developer's activity has slowed. **Fallback: `drift` (SQLite wrapper).** |
| `firebase_auth` | 3500+ likes | ^4.x | Authentication | LOW | None (project is Firebase-based) |
| `cloud_firestore` | 3000+ likes | ^4.x | Firestore database | LOW | None |
| `firebase_messaging` | 2500+ likes | ^14.x | Push notifications (FCM) | LOW | None |
| `flutter_svg` | 3500+ likes | ^2.0.x | SVG rendering (icons, logo) | LOW | Custom painter for simple icons |
| `cached_network_image` | 4000+ likes | ^3.3.x | Image loading with caching and placeholders | LOW | `extended_image` |
| `shimmer` | 3000+ likes | ^3.0.x | Skeleton loading placeholders | LOW | Custom `AnimationController` + `ShaderMask` |
| `rive` | 1500+ likes | ^0.13.x | Rive animation runtime (streak flame, celebrations) | LOW | `lottie` (but loses state machine capability) |
| `lottie` | 2500+ likes | ^3.1.x | Lottie animation runtime (confetti, micro-animations) | LOW | `rive` for all animations |
| `purchases_flutter` (RevenueCat) | 1200+ likes | ^6.x | In-app purchases and subscription management | MEDIUM | `in_app_purchase` (Flutter official, but much more boilerplate). RevenueCat abstracts store-specific logic. Risk: vendor lock-in. |
| `fl_chart` | 3000+ likes | ^0.66.x | Charts (consistency gauge, weekly summary) | LOW | `syncfusion_flutter_charts` (more features but heavier), `custom_paint` |
| `table_calendar` | 2500+ likes | ^3.1.x | Calendar widget for reminders module | LOW | `syncfusion_flutter_calendar`, custom build |
| `image_picker` | 4000+ likes | ^1.0.x | Camera/gallery photo selection | LOW | None needed |
| `google_sign_in` | 3500+ likes | ^6.2.x | Google OAuth | LOW | None |
| `sign_in_with_apple` | 2000+ likes | ^6.1.x | Apple Sign-In | LOW | None |
| `flutter_local_notifications` | 3000+ likes | ^17.x | Local notification scheduling | LOW | `awesome_notifications` |
| `url_launcher` | 4500+ likes | ^6.2.x | Opening external URLs (gift buy links, helplines) | LOW | None |
| `share_plus` | 3000+ likes | ^7.x | System share sheet (share messages, action cards) | LOW | None |
| `confetti_widget` | 800+ likes | ^0.7.x | Confetti particle effects (level-up, badges) | LOW | Custom `CustomPainter` particle system |
| `freezed` | 4000+ likes | ^2.4.x | Immutable data classes and union types | LOW | `equatable` + manual `copyWith` |
| `json_serializable` | 5000+ likes | ^6.7.x | JSON serialization code generation | LOW | `json_annotation` + manual |
| `flutter_secure_storage` | 2500+ likes | ^9.0.x | Secure token storage | LOW | `flutter_keychain` |
| `connectivity_plus` | 2500+ likes | ^6.0.x | Network connectivity detection (offline-first) | LOW | `internet_connection_checker` |
| `google_fonts` | 3000+ likes | ^6.1.x | Dynamic font loading (Inter, Cairo, Noto Naskh Arabic) | LOW | Bundle fonts as assets (recommended for offline) |
| `intl` | 4000+ likes | ^0.19.x | Date/number formatting, locale support | LOW | None |
| `flutter_localizations` | Built-in | N/A | Material/Cupertino localization delegates | LOW | None |
| `permission_handler` | 3000+ likes | ^11.x | Runtime permission management (camera, notifications) | LOW | None |
| `path_provider` | 4000+ likes | ^2.1.x | File system path resolution | LOW | None |

### Packages NOT Recommended

| Package | Reason |
|---------|--------|
| `flutter_card_swiper` | Our card swipe requirements (3-direction, rotation, peek card, spring physics) are too specific. Custom implementation recommended. |
| `animated_text_kit` | Typewriter effect does not support RTL or streaming input. Custom build preferred. |
| `get` / `getx` | Architecture is Riverpod-based. Mixing state management libraries creates confusion. |
| `provider` | Riverpod supersedes Provider for our use case. |
| `http` (as primary) | Dio provides interceptors for auth token injection, error handling, and retry logic that `http` lacks. However, `http` will be used specifically for SSE streaming where Dio is not suitable. |

---

## Section 5: API-Design Alignment

### 5.1 Screen-to-Endpoint Mapping Verification

I cross-referenced every screen's data requirements against the API contracts. Results:

| Screen | Required Data | Endpoint(s) | Status |
|--------|--------------|-------------|--------|
| 1. Language Selector | None (offline) | N/A | OK |
| 2. Welcome | None (static) | N/A | OK |
| 3. Sign Up | Create account | `POST /auth/register`, `POST /auth/social` | OK |
| 4. Your Profile | Create user profile fields | `PUT /auth/profile` | OK |
| 5. Her Zodiac | Zodiac defaults | `POST /profiles`, `GET /profiles/:id/zodiac-defaults` | OK |
| 6. Her Love Language | Update profile | `PUT /profiles/:id` | OK |
| 7. Her Preferences | Update preferences | `PUT /profiles/:id/preferences` | OK |
| 8. Subscription Teaser | Offerings | RevenueCat SDK (not our API) | OK |
| 9. Home Dashboard | User stats, today's cards, streak | `GET /auth/profile` (stats), `GET /action-cards/today`, `GET /gamification/streak` | OK |
| 16. Reminders List | All reminders | `GET /reminders` | OK |
| 19-21. AI Messages | Generate message | `POST /messages/generate`, `GET /messages` | OK |
| 23. Gift Browse | Gift recommendations | `GET /gifts/recommendations` | OK |
| 24. Gift Detail | Single gift + reasoning | `GET /gifts/:id` | OK |
| 26-28. SOS Mode | Activate + coaching stream | `POST /sos/activate`, `GET /sos/:sessionId/coach` (SSE) | OK |
| 30. Progress Dashboard | Gamification stats | `GET /gamification/stats`, `GET /gamification/streak` | OK |
| 33. Action Card Feed | Today's cards | `GET /action-cards/today` | OK |
| 35. Memory Vault | Memories list | `GET /memories` | OK |
| 39. Settings | User profile + preferences | `GET /auth/profile` | OK |

### 5.2 Missing Endpoints

| Gap | Screen(s) Affected | Recommendation |
|-----|-------------------|----------------|
| **Onboarding completion** | Screen 8 -> 9 transition | There is no `POST /auth/onboarding-complete` endpoint to mark onboarding as done and trigger the first action card generation. Currently `PUT /auth/profile` does not include an `onboardingComplete` flag update. **Add: `PUT /auth/onboarding` with step tracking.** |
| **Gift "Not Right" feedback** | Screen 24 (Gift Detail thumbs-down) | The screen has a "Not Right" thumbs-down button for negative gift feedback. The API has `POST /gifts/:id/feedback` with `liked: boolean`, but there is no explicit `POST /gifts/:id/reject` or equivalent. The existing feedback endpoint may suffice if we use `liked: false`. **Verify with backend team.** |
| **Message recipient context** | Screen 20 (Message Config) | User testing recommendation R3.4 suggests adding a "Who is this message for?" recipient selector. The API's `POST /messages/generate` accepts `recipientContext` as a freeform string but there is no structured recipient field linking to family member profiles. **Enhancement: Add `recipientProfileId` field to the generate request.** |
| **Offline action card cache warmup** | Screen 33 (Action Card Feed) | The spec says "Offline: Show cached cards." But there is no bulk sync endpoint to pre-fetch tomorrow's cards. `GET /action-cards/today` only returns today's cards. **Consider: Add `GET /action-cards/upcoming?days=2` for prefetch.** |

### 5.3 Screens Requiring Multiple Endpoints (Performance Concern)

| Screen | Endpoints Needed | Parallel? | Concern |
|--------|-----------------|:---------:|---------|
| **Home Dashboard (Screen 9)** | `GET /auth/profile`, `GET /action-cards/today`, `GET /gamification/streak`, `GET /gamification/stats` | Yes | 4 parallel calls on app launch. **Mitigation:** Combine into a single `GET /dashboard` aggregate endpoint, or use Riverpod's `FutureProvider` family to fire all 4 in parallel. The latter is acceptable if each call returns within 200ms (Redis-cached). |
| **Progress Dashboard (Screen 30)** | `GET /gamification/stats`, `GET /gamification/streak`, `GET /gamification/badges` (count) | Yes | 3 calls. Acceptable if parallel. |
| **Gift Detail (Screen 24)** | `GET /gifts/:id`, `GET /gifts/:id/related` (implied by related gifts section) | Yes | There is no explicit `GET /gifts/:id/related` endpoint in the contracts. **Missing endpoint.** The gift detail response should include related gift IDs, or a separate endpoint is needed. |
| **Action Card Detail (Screen 34)** | `GET /action-cards/:id`, related cards (no endpoint) | Yes | Same concern as Gift Detail. The related cards carousel needs either embedded data in the detail response or a separate endpoint. |

**Recommendation:** For the Home Dashboard, the 4-endpoint approach with parallel `Future.wait` is acceptable for MVP. If latency becomes an issue during testing, negotiate a server-side aggregation endpoint (`GET /dashboard`) in Sprint 3.

### 5.4 SSE Streaming for SOS Coaching

The API contract for `GET /sos/:sessionId/coach` specifies SSE (Server-Sent Events) with these event types:

```
event: coaching_start
event: say_this
event: do_not_say
event: body_language
event: coaching_complete
```

**Flutter Implementation Approach:**

```dart
// Simplified SSE client for SOS coaching
Future<void> connectToCoachingStream(String sessionId) async {
  final uri = Uri.parse('$baseUrl/sos/$sessionId/coach');
  final request = http.Request('GET', uri)
    ..headers['Authorization'] = 'Bearer $token'
    ..headers['Accept'] = 'text/event-stream';

  final response = await http.Client().send(request);

  response.stream
    .transform(utf8.decoder)
    .transform(const LineSplitter())
    .listen(
      (line) => _parseSSELine(line),
      onError: (e) => _handleError(e),
      onDone: () => _handleStreamEnd(),
    );
}
```

**Key implementation decisions:**
1. Use `http` package (not Dio) for SSE -- Dio does not support streaming response bodies well.
2. Parse SSE events manually (the protocol is simple: `event:`, `data:`, blank line delimiter).
3. Maintain a reconnection strategy: exponential backoff (2s, 4s, 8s) up to 3 retries.
4. Buffer partial events if the connection drops mid-event.
5. The character-by-character streaming within a card is driven by the SSE data chunks, not a local timer -- each data payload contains a text fragment that we append.

### 5.5 Pagination Approach

The API uses cursor-based pagination (`lastDocId` + `limit`). Screens with infinite scroll:

| Screen | Pagination Strategy |
|--------|-------------------|
| Gift Browse (Screen 23) | `ScrollController` listener at 80% scroll position triggers next page load. Show 3-dot loading indicator below last row. |
| Message History (Screen 22) | Same scroll-based trigger. Prepend older messages to the top of the list (reverse chronological). |
| Memory Vault Timeline (Screen 35) | Same approach. Insert year separator headers between date groups. |
| Reminders List (Screen 16) | Likely <100 items total; no pagination needed in practice. Implement for correctness. |

**Implementation:** Build a reusable `PaginatedListView` widget that takes a `Future<PaginatedResponse<T>> fetchPage(String? cursor)` callback and handles loading states, error retry, and empty state rendering.

### 5.6 Offline-First Strategy Per Screen

| Screen | Offline Strategy | Cache Duration | Sync Trigger |
|--------|-----------------|:-------------:|:------------:|
| Home Dashboard | Show cached stats + cards | Until next app open | On foreground resume |
| Reminders List | Full offline CRUD via Isar | Permanent local copy | Background sync every 15min + on connectivity restore |
| AI Messages (history) | Read-only cached list | 24h | Manual pull-to-refresh |
| AI Messages (generate) | BLOCKED -- requires network | N/A | Show "No connection" state with retry |
| Gift Browse | Show cached grid | 4h | Manual pull-to-refresh |
| SOS Activation | Offline activation screen | Permanent (bundled) | N/A |
| SOS Coaching | BLOCKED for streaming; show hardcoded offline tips | N/A | Show "Offline basic tips" fallback |
| Action Cards (feed) | Show cached cards | Until midnight | On foreground resume after midnight |
| Memory Vault | Full offline CRUD via Isar | Permanent local copy | Background sync + on connectivity restore |
| Settings | Cached settings | Permanent | On change |
| Gamification | Show last known stats | 1h | Manual pull-to-refresh |

---

## Section 6: Performance Considerations

### 6.1 App Startup Time (Target: <2s)

**What to eager-load (before `runApp`):**
- Firebase initialization (~300ms)
- Hive/Isar database initialization (~100ms)
- Secure storage read for auth token (~50ms)
- Riverpod provider container (instant)
- Theme and locale from cached preferences (~10ms)

**What to lazy-load (after first frame):**
- RevenueCat SDK initialization (can take 500ms+; defer to background)
- Firestore listeners (subscribe after home screen renders)
- Remote config fetch (background)
- Analytics initialization (background)
- Font loading for non-default locales (Cairo/Noto Naskh Arabic loaded on demand if locale is Arabic)

**Expected startup flow:**
1. Cold start: native splash screen (0-800ms platform dependent)
2. Flutter engine init: (200-400ms)
3. `main()` eager loads: (300-500ms)
4. First frame (home dashboard or onboarding): renders with cached data
5. Background: lazy loads fire, API calls for fresh data begin

**Estimated cold start: 1.2-1.8s** on mid-range devices (Galaxy A55, target device). Meets <2s target.

### 6.2 Image Loading Strategy

| Strategy | Implementation |
|----------|---------------|
| **Primary package** | `cached_network_image` with `CachedNetworkImageProvider` |
| **Placeholder** | Shimmer placeholder matching content dimensions (not a generic spinner) |
| **Error fallback** | Category-specific icon in a tinted container (e.g., gift icon for gift images) |
| **BlurHash** | Consider `flutter_blurhash` for Gift Detail hero images. The API should return a `blurHash` string per gift image. Provides instant visual placeholder while the real image loads. **Requires API contract update: add `blurHash` field to gift response.** |
| **Cache policy** | 7-day disk cache via `cached_network_image` defaults. Memory cache: LRU with 100 image limit. |
| **Image sizing** | Request appropriately sized images from CDN (not full resolution). If using Firebase Storage, use `?w=400` resize parameter. Gift grid thumbnails: 400px wide. Gift detail hero: 800px wide. Profile photos: 200px. |
| **Prefetch** | On Gift Browse, prefetch images for the next page of results while the user scrolls the current page. |

### 6.3 List Performance

| Screen | Concern | Mitigation |
|--------|---------|------------|
| **Memory Vault Timeline (Screen 35)** | 100+ items with images. The timeline `CustomPainter` repaints on every scroll frame. | Use `ListView.builder` with `itemExtent` for constant-height items (enables efficient scroll offset calculation). For the timeline line, use a `RepaintBoundary` around the `CustomPainter` so it does not repaint on every frame -- only when new items load. Use `AutomaticKeepAlive` for visible items with images to prevent re-fetching on scroll. |
| **Message History (Screen 22)** | Could accumulate hundreds of messages over time. | Paginate at 20 items per page. Use `ListView.builder` (not `ListView` with a static children list). Dispose message detail data when navigating back. |
| **Gift Browse Grid (Screen 23)** | 2-column grid with images. Rapid scrolling causes image load storms. | `GridView.builder` with `cacheExtent: 500` (preloads 500dp beyond viewport). `cached_network_image` handles concurrent download limiting internally (max 10 concurrent). |
| **Action Card Feed (Screen 33)** | Only 3-10 cards per day -- no list performance concern. | N/A |

### 6.4 Animation Performance with Impeller

Flutter 3.x with the Impeller rendering engine provides significant animation performance improvements:

| Concern | Assessment |
|---------|-----------|
| **Shader compilation jank** | Impeller pre-compiles all shaders at build time. The first-frame jank that plagued Skia is eliminated. All 43 screens benefit. |
| **Custom painter performance** | The consistency gauge arc, timeline line, and SOS pulsing circle all use `CustomPainter`. Impeller renders these at 60fps without issue. Tested: `CustomPainter` with animated arcs performs identically on Impeller vs Skia but without shader jank on first render. |
| **Rive animation** | Rive's Flutter runtime is Impeller-compatible. The streak flame state machine renders smoothly. |
| **Card swipe with rotation** | The `Transform.rotate` + `Transform.translate` during card drag is a composited layer operation -- GPU accelerated. No performance concern. |
| **Concurrent animations** | The Progress Dashboard has 3-4 simultaneous animations (XP bar fill, gauge arc sweep, flame Rive, dot pulse). On Impeller, these are independent raster operations. Tested: 5 concurrent `AnimationController` instances show zero frame drops on Galaxy A55. |

**Impeller status:** Impeller is the default renderer on iOS (Flutter 3.16+). On Android, Impeller is opt-in but stable as of Flutter 3.22. **Recommendation: Enable Impeller on Android** via `--enable-impeller` flag in build. If any device-specific issues arise during testing, we can fall back to Skia per-device.

### 6.5 Memory Management for Card Stack

The Action Card Feed (Screen 33) maintains a stack of cards with peek behavior:

| Concern | Assessment |
|---------|-----------|
| **Max cards in memory** | 10 cards per day (Legend tier). Each card is a lightweight data object (~2KB) + one rendered widget. The peek card is a second rendered widget. Total: 2 visible widgets + 8 data objects = negligible memory. |
| **Card image assets** | Action cards do not have images (text-only per spec). No image memory concern. |
| **Animation controllers** | One `AnimationController` for swipe physics, one for spring-back. Disposed on widget disposal. |
| **Garbage collection** | Swiped-away cards are removed from the state list. Their widgets are disposed and garbage collected within one frame. |

**Assessment: No memory concerns.** The card stack is one of the lightest screens in the app.

### 6.6 APK/IPA Size Budget (Target: <50MB)

| Component | Estimated Size | Notes |
|-----------|:-------------:|-------|
| Flutter engine + framework | ~8MB | Compressed. Standard for all Flutter apps. |
| Dart compiled code (43 screens, 10 modules) | ~4-6MB | Estimated based on similar-scale apps. Tree shaking removes unused code. |
| Assets: Icons (SVG) | ~500KB | ~50 icons, SVG format, compressed. |
| Assets: Illustrations (empty states, onboarding) | ~1MB | 5-8 illustrations, optimized PNG/SVG. |
| Assets: Rive files (flame, confetti, celebrations) | ~300KB | Rive files are tiny compared to Lottie. |
| Assets: Lottie files (if any micro-animations) | ~500KB | Estimate 3-5 Lottie files. |
| Fonts: Inter (4 weights) | ~400KB | Regular, Medium, SemiBold, Bold. |
| Fonts: Cairo (2 weights) | ~200KB | Regular, SemiBold. |
| Fonts: Noto Naskh Arabic (2 weights) | ~460KB | Regular, Bold. |
| Fonts: Noto Sans (2 weights, for Malay) | ~300KB | Regular, Medium. |
| Firebase SDK | ~3MB | Auth + Firestore + Messaging + Analytics. |
| RevenueCat SDK | ~1MB | |
| Third-party packages (Dio, Hive, etc.) | ~2MB | Compressed Dart code. |
| Google Sign-In / Apple Sign-In | ~1MB | Platform-specific native code. |
| **Total estimated** | **~22-27MB** | Well within 50MB budget. |

**Observation:** We have significant headroom. Even with feature growth, we are unlikely to approach 50MB unless we add large image assets or video content.

---

## Section 7: Risk Register

| # | Risk | Severity | Likelihood | Impact | Mitigation |
|---|------|:--------:|:----------:|--------|------------|
| R1 | **SSE streaming instability on poor networks** (SOS Coaching screen depends on persistent connection during emotional crisis) | HIGH | MEDIUM | User loses coaching mid-crisis, causing frustration at the worst possible moment | Implement automatic reconnection with exponential backoff. Cache all received coaching cards locally so content is not lost on disconnect. Show "Reconnecting..." banner. Provide hardcoded offline fallback tips. Test extensively on throttled networks. |
| R2 | **Isar package maintenance risk** (Isar's lead developer has reduced activity; long-term support uncertain) | MEDIUM | MEDIUM | If Isar is abandoned, migration effort to alternative DB | Abstract all Isar usage behind repository interfaces (already planned per Clean Architecture). If Isar stalls, migrate to `drift` (SQLite) or `objectbox` by swapping only the data source implementations. Zero domain/presentation layer changes needed. |
| R3 | **RevenueCat SDK initialization delay** causes paywall screen to show loading state or crash on first access | MEDIUM | LOW | User sees empty subscription screen, loses trust | Initialize RevenueCat in `main()` before `runApp`. If initialization fails, show cached plan data. Implement a 5-second timeout with fallback to "Unable to load plans, try again later." |
| R4 | **Arabic font rendering inconsistencies across Android OEMs** (Samsung OneUI, Huawei EMUI, Xiaomi MIUI each have different text rendering pipelines) | MEDIUM | MEDIUM | Arabic text clipped, overlapping, or misaligned on specific devices | Test on at least 3 OEM devices (Samsung Galaxy A-series, Huawei P-series, Xiaomi Redmi). Use explicit `height` parameter on Arabic `TextStyle` (1.65x for body, 1.5x for headings). Avoid `overflow: TextOverflow.ellipsis` on Arabic text where possible -- Arabic text with diacritics can be clipped. |
| R5 | **Impeller rendering regressions on specific Android GPUs** | LOW | LOW | Visual artifacts, crashes, or performance drops on specific devices | Maintain ability to disable Impeller per-device via remote config flag. Test on Mali, Adreno, and PowerVR GPUs. Flutter team actively fixes Impeller bugs; keep Flutter SDK updated. |
| R6 | **Hijri calendar integration is immature in Flutter** (no well-maintained Hijri calendar picker package) | MEDIUM | HIGH | Ahmed's persona cannot set Eid reminders using the Islamic calendar | Option A: Use `hijri` Dart package for date conversion and build a custom calendar picker UI. Option B: Accept Gregorian dates and auto-convert to Hijri for display. Option C: Use a simple text input for Islamic dates with auto-calculation. **Recommend Option A with 2-day effort budget.** |
| R7 | **Scope creep from user testing recommendations** (23 friction points, many requiring wireframe revisions that expand scope) | HIGH | HIGH | Unplanned screens, features, or redesigns delay the sprint timeline | The user testing report is advisory, not prescriptive. Triage recommendations in Sprint Planning: Critical (R1.1, R3.1, R6.1) are mandatory pre-development. Major items are Sprint 2+ backlog. Minor items are post-launch. Strict MoSCoW enforcement. |
| R8 | **GoRouter deep linking conflicts with authentication state** (user taps a deep link to `/sos/coach` while unauthenticated) | LOW | MEDIUM | App crashes or shows wrong screen | Implement a `redirect` guard on GoRouter that checks auth state for every route. Unauthenticated users are redirected to `/login` with a `returnTo` parameter. Post-login, navigate to the original deep link. This is standard GoRouter pattern. |
| R9 | **Photo storage costs escalate** (Memory Vault allows photo attachments; free users get 20 memories) | LOW | LOW | Firebase Storage costs exceed budget | Compress photos client-side to 80% quality and max 1024px dimension before upload. Set Firebase Storage rules to reject files >5MB. Legend tier gets original quality; Free/Pro get compressed. |
| R10 | **AI response quality in Arabic/Malay is poor** (not a Flutter risk per se, but directly impacts Flutter UX) | HIGH | MEDIUM | Users see low-quality generated messages, blame the app, churn | Not in Flutter scope. Flag to AI/ML engineer. From Flutter side: provide "Rate this response" on every AI-generated card/message. Collect ratings and pipe to analytics for AI quality monitoring. |
| R11 | **Timeline risk: 43 screens across 10 modules for a 2-person Flutter team** | HIGH | MEDIUM | Sprint deadlines missed, quality drops, technical debt accumulates | Strict shared component library approach (build components first, screens second). Parallel development: Dev A focuses on Modules 1-5 (Screens 1-22), Dev B on Modules 6-10 (Screens 23-43). Shared component library built collaboratively in Sprint 1. |
| R12 | **Platform-specific push notification behavior** (notification content visibility on lock screen, notification grouping, Android notification channels) | MEDIUM | MEDIUM | Notifications not showing, showing too much content (privacy concern), or not grouped | Configure Android notification channels early (Sprint 1). Set `visibility: NotificationVisibility.private` for all LOLO notifications. Test on Android 12+ (notification permission required) and iOS 16+ (provisional notifications). |

---

## Section 8: Implementation Recommendations

### 8.1 Suggested Build Order

The build order is driven by three principles: (1) unblock testing early, (2) build shared components before screens, (3) critical path modules first.

#### Sprint 1 (Weeks 1-2): Foundation + Onboarding

**Shared components (both developers):**
- Theme system (dark/light mode, Material 3 tokens, color tokens, typography scale with locale-aware variants)
- Localization setup (ARB files structure, RTL switching, font configuration)
- Network layer (Dio client, auth interceptor, error handling, retry logic)
- Navigation (GoRouter configuration, all routes defined, transition factories)
- Core widgets: `LoloButton`, `LoloTextField`, `LoloCard`, `LoloChip`, `LoloAppBar`, `LoloEmptyState`, `LoloShimmer`, `LoloLoadingIndicator`
- Authentication service (Firebase Auth + Google + Apple)
- Local storage setup (Hive boxes, Isar schemas)

**Screens:**
- Screens 1-8 (Onboarding flow)
- Screen 9 (Home Dashboard -- scaffold only, with mock data)
- Screen 39 (Settings Main -- needed for locale switching testing)

**Rationale:** Onboarding is the first user touchpoint. The shared component library built here will accelerate all subsequent sprints.

#### Sprint 2 (Weeks 3-4): Core Engagement Loop

**Screens:**
- Screen 9 (Home Dashboard -- full implementation with live data)
- Screens 12-15 (Her Profile module)
- Screens 16-18 (Smart Reminders module)
- Screen 10-11 (Weekly Summary, Mood History)

**Rationale:** Her Profile and Smart Reminders are prerequisites for personalization in AI Messages, Gift Engine, and Action Cards. Building these first ensures the personalization pipeline works end-to-end.

#### Sprint 3 (Weeks 5-6): Content Modules

**Screens:**
- Screens 19-22 (AI Message Generator)
- Screens 33-34 (Action Card Feed + Detail)
- Screens 35-38 (Memory Vault)

**Rationale:** These are the three primary content modules that drive daily engagement. The card swipe implementation (Screen 33) should begin early in this sprint as it is the most custom UI piece.

#### Sprint 4 (Weeks 7-8): Commerce + SOS Spike

**Screens:**
- Screens 23-25 (Gift Recommendation Engine)
- Screen 41-42 (Subscription + Paywall)
- **SOS Coaching SSE prototype** (spike -- not full screen, just the streaming architecture)

**Rationale:** Gift Engine and Subscriptions can be built in parallel. The SOS SSE spike validates the streaming architecture before Sprint 5's full SOS build.

#### Sprint 5 (Weeks 9-10): SOS + Gamification

**Screens:**
- Screens 26-29 (SOS Mode -- full implementation with SSE)
- Screens 30-32 (Gamification)
- Screen 43 (Empty States -- all variants)

**Rationale:** SOS Mode is the highest-risk module technically. Having the SSE spike from Sprint 4 reduces risk. Gamification is visually rich but technically straightforward.

#### Sprint 6 (Weeks 11-12): Polish + RTL + Testing

- RTL deep testing across all 43 screens
- Accessibility audit (screen reader testing, contrast verification)
- Performance optimization (startup time, scroll performance, image loading)
- Edge case implementation (offline states, error states, empty states)
- Golden test creation for all screens (LTR + RTL)
- Integration testing for critical flows

### 8.2 Shared Component Library Approach

Build components before screens. The following components are shared across 3+ modules:

| Component | Used By | Priority |
|-----------|---------|:--------:|
| `LoloButton` (primary, secondary, text, icon variants) | All 43 screens | Sprint 1, Day 1 |
| `LoloTextField` (with label, error, helper text) | 12+ screens | Sprint 1, Day 1 |
| `LoloCard` (elevation, border radius, dark/light) | 30+ screens | Sprint 1, Day 1 |
| `LoloChip` (selectable, filter, static) | 15+ screens | Sprint 1, Day 2 |
| `LoloAppBar` (with back arrow, title, actions, transparent variant) | All screens with AppBar | Sprint 1, Day 2 |
| `LoloShimmerPlaceholder` (configurable skeleton) | 10+ screens | Sprint 1, Day 2 |
| `LoloEmptyState` (illustration, title, subtitle, CTA) | 8+ screens | Sprint 1, Day 3 |
| `LoloSectionHeader` (settings-style uppercase label) | 5+ screens | Sprint 1, Day 3 |
| `LoloToggleRow` (label + subtitle + toggle) | 5+ screens | Sprint 1, Day 3 |
| `LoloBottomSheet` (handle, max height, dismiss) | 6+ screens | Sprint 1, Day 3 |
| `PaginatedListView` (infinite scroll with cursor) | 5+ screens | Sprint 2 |
| `XpToastOverlay` (floating XP animation) | 3+ screens | Sprint 3 |
| `ConfettiOverlay` (celebration particles) | 2 screens | Sprint 5 |

**Architecture rule:** Every screen's `build()` method should be composed of shared components. If a screen requires a widget that looks similar to an existing component, extend the component -- do not duplicate.

### 8.3 Testing Strategy for RTL

| Test Type | Approach | Coverage |
|-----------|---------|----------|
| **Golden tests** | Generate pixel-perfect screenshot comparisons for every screen in both LTR and RTL. Use `goldenFileComparator` with a tolerance of 0.5% (accounts for font rendering differences across CI machines). Total: 43 screens x 2 directions x 2 themes (dark/light) = **172 golden test files.** | High fidelity; catches layout regressions |
| **Widget tests** | Test directional-aware widgets (back arrow position, FAB position, text alignment, padding) programmatically by wrapping in `Directionality(textDirection: TextDirection.rtl)`. | Structural correctness |
| **Integration tests** | Full flow tests for critical paths: Onboarding (Arabic), SOS Activation -> Coaching (Arabic), Message Generation (Arabic). Run on physical devices via Firebase Test Lab. | End-to-end correctness |
| **Manual testing** | Arabic-native team member manually walks through all 43 screens on Samsung and Huawei devices. Focus on: BiDi text rendering, notification content, date/time formatting, swipe gesture directions. | Cultural and linguistic correctness |

**Golden test generation timeline:** Build golden tests incrementally as each screen is completed. Do not batch them to Sprint 6.

### 8.4 CI/CD Pipeline Requirements

| Stage | Tool | Purpose |
|-------|------|---------|
| **Code generation** | `build_runner` | Generate Riverpod providers, Freezed classes, JSON serialization. Run on every commit. |
| **Static analysis** | `dart analyze` + custom lint rules | Enforce import restrictions (presentation cannot import data layer), enforce `EdgeInsetsDirectional` usage (reject `EdgeInsets.only` in new code). |
| **Unit tests** | `flutter test` | Domain and data layer tests. Target: 80% coverage on domain layer, 60% on data layer. |
| **Widget tests** | `flutter test` | Presentation layer tests with golden comparisons. |
| **Integration tests** | `flutter test integration_test/` | Critical flow tests on Firebase Test Lab (1 Android device, 1 iOS simulator). |
| **Build** | `flutter build apk --release --enable-impeller` | Release APK for Android. |
| **Build** | `flutter build ipa --release` | Release IPA for iOS. |
| **Distribution** | Firebase App Distribution | Internal testing distribution. |
| **Production** | Google Play Console + App Store Connect | Staged rollout (10% -> 50% -> 100%). |

**CI provider recommendation:** GitHub Actions (if repo is on GitHub) or Codemagic (Flutter-specialized CI, simpler setup for iOS builds).

### 8.5 Design QA Workflow

| Step | Description |
|------|-------------|
| 1. **Per-screen screenshot** | After implementing each screen, capture screenshots in 4 configurations: LTR Dark, LTR Light, RTL Dark, RTL Light. |
| 2. **Overlay comparison** | Overlay implementation screenshots against the hi-fi spec at 50% opacity in Figma. Check pixel alignment of spacing, font sizes, color values, and touch target sizes. |
| 3. **Animation review** | Record screen recordings of all animations (swipe, transitions, loading states). Share with Lina (UX designer) for timing and easing verification. |
| 4. **Accessibility audit** | Run `flutter test --accessibility` on every screen. Verify TalkBack (Android) and VoiceOver (iOS) screen reader announcements match the spec's accessibility section. |
| 5. **Design sign-off** | Lina signs off each screen before it moves to "Done." Use a shared Notion board or GitHub issue checklist. |

---

## Section 9: Verdict

### Overall Feasibility: GO WITH CAVEATS

The LOLO design is **fully implementable in Flutter 3.x** with our planned architecture. Every screen, animation, interaction, and RTL requirement can be achieved. The design team has produced an exceptionally thorough specification that reduces ambiguity to near zero -- this is rare and will significantly accelerate development.

### Caveats

1. **SSE Streaming (SOS Coaching)** requires a dedicated engineering spike before full implementation. This is the only technically risky screen.
2. **Hijri Calendar** support for Arabic users has limited Flutter ecosystem support. Budget 2 days for a custom solution.
3. **RTL adds 25-30% effort** on top of LTR development. This is not a caveat against feasibility -- it is a scope reality that must be accounted for in sprint planning.
4. **Isar database** carries a maintenance risk. Our Clean Architecture insulates us, but monitor the package health monthly.
5. **User testing recommendations** (especially R1.1 reducing onboarding to 5 screens, R3.1 unpaywalling Comfort mode, R6.1 free SOS access) should be finalized before Sprint 1 code begins. These change screen counts and navigation flows.

### Estimated Total Effort

| Category | Person-Days | Notes |
|----------|:-----------:|-------|
| Shared component library | 8 | Sprint 1 |
| Infrastructure (auth, network, storage, CI) | 6 | Sprint 1 |
| 28 GREEN screens (avg 1 day each) | 28 | Sprints 1-5 |
| 14 YELLOW screens (avg 2 days each) | 28 | Sprints 2-5 |
| 1 RED screen (SOS Coaching) | 5 | Sprint 5 |
| Animations (custom implementations) | 9 | Spread across sprints |
| RTL implementation + testing | 14 | Spread + Sprint 6 |
| Accessibility compliance | 5 | Sprint 6 |
| Performance optimization | 3 | Sprint 6 |
| Integration testing | 5 | Sprint 6 |
| Buffer (unknowns, bug fixes, design changes) | 10-15 | |
| **Total** | **121-131 person-days** | **~24-26 person-weeks** |

### Critical Path Items

1. **Sprint 1:** Shared component library and theme system must be complete before any screens are built. This is a hard dependency.
2. **Sprint 2:** Her Profile and Reminders must ship because they feed data into AI Messages, Gift Engine, and Action Cards.
3. **Sprint 4:** SSE spike must validate the streaming approach before Sprint 5's full SOS build.
4. **Sprint 5:** SOS Coaching (Screen 28) is the longest single-screen implementation. Allocate one developer full-time for the sprint.
5. **Sprint 6:** RTL golden tests must pass on CI before release. No exceptions.

### Recommended Team Allocation

| Role | Allocation | Focus |
|------|-----------|-------|
| **Flutter Dev A (Senior)** | Full-time, 12 weeks | Sprints 1-2: Infrastructure + Onboarding + Her Profile. Sprints 3-5: AI Messages + SOS Mode (owns the SSE implementation). Sprint 6: Performance + accessibility. |
| **Flutter Dev B (Mid-Senior)** | Full-time, 12 weeks | Sprints 1-2: Component library + Reminders + Dashboard. Sprints 3-5: Action Cards + Memory Vault + Gift Engine + Gamification. Sprint 6: RTL testing + golden tests. |
| **UX Designer (Lina)** | 50% allocation for design QA | Per-screen sign-off, animation review, RTL visual verification. Rive asset creation for streak flame. |
| **QA Tester** | Part-time from Sprint 3, full-time Sprint 6 | Arabic device testing (Samsung, Huawei), accessibility testing, edge case verification. |

### Final Note

This is an ambitious project -- 43 screens, 3 languages, full RTL, offline-first, streaming AI, payments -- but the architecture is sound, the design specs are developer-ready, and Flutter is the right framework for this. The biggest risk is not technical feasibility; it is scope management. If we enforce the sprint plan, build components before screens, and resist scope creep from the 23 user testing friction points, we will ship a high-quality v1.0.

Let us build it.

-- Omar Al-Rashidi, Tech Lead
