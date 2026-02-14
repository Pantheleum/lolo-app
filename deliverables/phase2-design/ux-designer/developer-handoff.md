# LOLO Developer Handoff Document v1.0

### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0
### Classification: Internal -- Confidential
### Status: FINAL -- Phase 2 Deliverable
### Dependencies: Design System v1.0, High-Fidelity Specs (Parts 1, 2A, 2B), Brand Identity Guide v2.0, RTL Guidelines v2.0, UI String Catalog v1.0, Wireframe Specs v1.0

---

## Table of Contents

1. [Section 1: Implementation Overview](#section-1-implementation-overview)
2. [Section 2: Component Catalog](#section-2-component-catalog)
3. [Section 3: Screen-to-Component Mapping](#section-3-screen-to-component-mapping)
4. [Section 4: Animation Implementation Guide](#section-4-animation-implementation-guide)
5. [Section 5: RTL Implementation Checklist](#section-5-rtl-implementation-checklist)
6. [Section 6: Asset Export List](#section-6-asset-export-list)
7. [Section 7: Responsive & Adaptive Design](#section-7-responsive--adaptive-design)
8. [Section 8: Accessibility Specifications](#section-8-accessibility-specifications)
9. [Section 9: Design QA Checklist](#section-9-design-qa-checklist)

---

## Section 1: Implementation Overview

### 1.1 Screen Count Summary

| Metric | Count |
|--------|:-----:|
| Total screens | 43 |
| Total modules | 10 + Settings + Supplementary |
| Total sprints | 4 (Weeks 9-16) |
| Reusable components | 24 |
| UI strings (ARB-ready) | 652 |
| Supported languages | 3 (EN, AR, MS) |
| Theme modes | 2 (Dark default, Light) |

### 1.2 Module-to-Screen Breakdown

| Module | Screens | Screen Numbers | Sprint |
|--------|:-------:|----------------|:------:|
| Onboarding | 8 | 1-8 | Sprint 1 |
| Dashboard / Home | 3 | 9-11 | Sprint 1 |
| Her Profile | 4 | 12-15 | Sprint 1-2 |
| Smart Reminders | 3 | 16-18 | Sprint 2 |
| AI Message Generator | 4 | 19-22 | Sprint 2-3 |
| Gift Recommendation Engine | 3 | 23-25 | Sprint 4 |
| SOS Mode | 4 | 26-29 | Sprint 3 |
| Gamification | 3 | 30-32 | Sprint 2-3 |
| Smart Action Cards | 2 | 33-34 | Sprint 3 |
| Memory Vault | 4 | 35-38 | Sprint 3 |
| Settings | 3 | 39-41 | Sprint 2 |
| Supplementary (Paywall, Empty States) | 2 | 42-43 | Sprint 1-4 |

### 1.3 Implementation Priority Order

Build screens in this order, matching the sprint plan. Each sprint builds upon the previous.

**Sprint 1 -- Foundation (Weeks 9-10):**

| Priority | Screen | Route | Reason |
|:--------:|--------|-------|--------|
| 1 | Language Selector | `/onboarding/language` | Entry point; establishes locale and RTL |
| 2 | Welcome | `/onboarding/welcome` | Value proposition; first impression |
| 3 | Sign Up | `/onboarding/signup` | Auth gate |
| 4 | Login | `/login` | Returning users |
| 5 | Onboarding Steps (3-8) | `/onboarding/step/*` | Data collection flow |
| 6 | Home Dashboard | `/home` | App shell; placeholder widgets |
| 7 | Bottom Navigation Shell | N/A (persistent) | Navigation skeleton for all tabs |
| 8 | Basic Her Profile | `/profile/her` | Partner data entry |
| 9 | Paywall | `/paywall` | Subscription infrastructure |

**Sprint 2 -- Core Features (Weeks 11-12):**

| Priority | Screen | Route | Reason |
|:--------:|--------|-------|--------|
| 10 | Her Profile Detail | `/profile/her/detail` | Zodiac + preferences |
| 11 | Her Profile Preferences | `/profile/her/preferences` | Interests + cultural context |
| 12 | Reminder List | `/reminders` | Core value feature |
| 13 | Add/Edit Reminder | `/reminders/new` | Reminder creation |
| 14 | Reminder Detail | `/reminders/:id` | Reminder management |
| 15 | Message Generator Home | `/messages` | AI message entry point |
| 16 | Message Mode Select | `/messages/mode` | Mode selection UI |
| 17 | Gamification Dashboard | `/gamification` | XP + streak display |
| 18 | Settings Main | `/settings` | User preferences |
| 19 | Settings Notifications | `/settings/notifications` | Notification controls |
| 20 | Settings Account | `/settings/account` | Account management |

**Sprint 3 -- AI Engine (Weeks 13-14):**

| Priority | Screen | Route | Reason |
|:--------:|--------|-------|--------|
| 21 | Message Result | `/messages/result` | AI output display |
| 22 | Message History | `/messages/history` | Past messages |
| 23 | Action Card Feed | `/action-cards` | Daily card stack |
| 24 | Action Card Detail | `/action-cards/:id` | Expanded card view |
| 25 | SOS Mode Entry | `/sos` | Crisis entry point |
| 26 | SOS Assessment | `/sos/assess` | 2-step wizard |
| 27 | SOS Coaching | `/sos/coaching` | AI coaching cards |
| 28 | SOS Resolution | `/sos/resolution` | Follow-up guidance |
| 29 | Memory Vault List | `/memories` | Timeline view |
| 30 | Add Memory | `/memories/new` | Memory creation |
| 31 | Memory Detail | `/memories/:id` | Memory view |
| 32 | Wish List | `/memories/wishes` | Wish tracking |
| 33 | Badge Collection | `/gamification/badges` | Achievement gallery |
| 34 | Level Detail | `/gamification/level` | Level progress detail |

**Sprint 4 -- Smart Actions + Polish (Weeks 15-16):**

| Priority | Screen | Route | Reason |
|:--------:|--------|-------|--------|
| 35 | Gift Browse | `/gifts` | Gift grid + filters |
| 36 | Gift Detail | `/gifts/:id` | Individual gift view |
| 37 | Gift Saved | `/gifts/saved` | Saved gift list |
| 38-43 | Empty States (all modules) | Per module | Polish pass |

### 1.4 Component Reuse Map

Components appearing on 3+ screens, ranked by reuse frequency:

| Component | Screens Used On | Count |
|-----------|----------------|:-----:|
| `LoloBottomNav` | All screens except Onboarding (1-8) and Paywall (42) | 35 |
| `LoloAppBar` | All screens except Language Selector (1), Welcome (2) | 41 |
| `LoloPrimaryButton` | Every screen with a CTA | 38 |
| `LoloTextField` | Sign Up, Login, Profile, Reminders, Memories, Settings, SOS | 18 |
| `LoloToast` | XP gain, copy confirm, save confirm, error feedback | 28 |
| `LoloSkeleton` | Dashboard, Reminders, Messages, Gifts, Memories, Action Cards | 12 |
| `LoloEmptyState` | Reminders, Messages, Memories, Gifts, Action Cards, Wishes | 9 |
| `LoloChipGroup` | Profile, Messages, Gifts, Action Cards, SOS | 10 |
| `LoloDialog` | Delete confirm, logout, discard, subscription | 14 |
| `ActionCard` | Dashboard, Action Card Feed, Action Card Detail | 3 |
| `ReminderTile` | Dashboard, Reminder List, Reminder Detail | 3 |
| `LoloProgressBar` | Dashboard, Gamification, Profile, Level Detail | 5 |
| `LoloStreakDisplay` | Dashboard, Gamification Dashboard | 2 |
| `LoloAvatar` | Dashboard, Her Profile, Memories, Settings | 6 |
| `LoloBadge` | Gamification, Dashboard, Profile | 4 |
| `StatCard` | Dashboard, Gamification, Profile | 4 |
| `SOSCoachingCard` | SOS Coaching screen (3 variants) | 1 |
| `GiftCard` | Gift Browse, Gift Saved, Dashboard (optional) | 3 |
| `MemoryCard` | Memory Vault List, Memory Detail | 2 |
| `BadgeCard` | Badge Collection, Gamification Dashboard | 2 |

### 1.5 Design System Implementation Checklist

Complete these foundation tasks before building any screens:

- [ ] **Theme tokens file** -- Create `lib/core/theme/lolo_tokens.dart` with all color, spacing, radius, duration, and icon size constants (see Appendix A of Design System v1.0)
- [ ] **Dark theme** -- Create `lib/core/theme/lolo_dark_theme.dart` using `ThemeData` with dark palette tokens
- [ ] **Light theme** -- Create `lib/core/theme/lolo_light_theme.dart` using `ThemeData` with light palette tokens
- [ ] **Typography theme** -- Create `lib/core/theme/lolo_typography.dart` with English/Arabic/Malay text theme variants
- [ ] **Gradient definitions** -- Create `lib/core/theme/lolo_gradients.dart` with all 6 gradient `LinearGradient` objects
- [ ] **Spacing extension** -- Create spacing extension or constants accessible via `LoloSpacing.spaceMd` etc.
- [ ] **Locale-aware text theme** -- Wire typography switching based on active locale (Inter for EN/MS, Cairo+Noto Naskh for AR)
- [ ] **ARB scaffold** -- Initialize `app_en.arb`, `app_ar.arb`, `app_ms.arb` with 652 strings from UI String Catalog
- [ ] **RTL wrapper** -- Confirm `MaterialApp` uses `Directionality` derived from locale; verify `EdgeInsetsDirectional` compiles in all layouts
- [ ] **Icon library** -- Import Phosphor Icons Flutter package; create custom icon registry for LOLO-specific icons
- [ ] **Font files** -- Bundle Inter (400, 500, 600, 700), Cairo (600, 700), Noto Naskh Arabic (400, 500), Noto Sans (400, 500) in `assets/fonts/`

---

## Section 2: Component Catalog

Each component below includes: props, sizing, color tokens, states, RTL behavior, and suggested Flutter widget composition.

---

### 2.1 Navigation Components

#### LoloBottomNav

**Description:** 5-tab bottom navigation bar. Persistent across all non-onboarding screens.

| Property | Value |
|----------|-------|
| Height | 64dp (excluding safe area inset) |
| Background (dark) | `#161B22` (`darkBgSecondary`) |
| Background (light) | `#F6F8FA` (`lightBgSecondary`) |
| Top border | 1dp `#21262D` (dark) / `#EAEEF2` (light) |
| Tab count | 5 |
| Icon size | 24dp |
| Label font | 12sp Medium (Inter 500) |
| Active color | `#4A90D9` (`colorPrimary`) |
| Inactive color | `#484F58` (dark) / `#8C959F` (light) |
| Active indicator | Pill: 56w x 32h dp, `#4A90D9` at 12%, radius 16dp |
| Touch target | screen_width / 5 x 64dp per tab |

**Tabs:**

| Index | Label (EN) | Icon (Inactive) | Icon (Active) | Route |
|:-----:|------------|-----------------|---------------|-------|
| 0 | Home | `PhosphorIcons.house` | `PhosphorIcons.houseFill` | `/home` |
| 1 | Reminders | `PhosphorIcons.bell` | `PhosphorIcons.bellFill` | `/reminders` |
| 2 | Messages | `PhosphorIcons.chatCircle` | `PhosphorIcons.chatCircleFill` | `/messages` |
| 3 | Gifts | `PhosphorIcons.gift` | `PhosphorIcons.giftFill` | `/gifts` |
| 4 | More | `PhosphorIcons.dotsThree` | `PhosphorIcons.dotsThreeFill` | `/more` |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `currentIndex` | `int` | Yes | -- | Active tab index |
| `onTabChanged` | `Function(int)` | Yes | -- | Tab selection callback |
| `badgeCounts` | `Map<int, int>` | No | `{}` | Badge count per tab index |

**States:**

| State | Visual |
|-------|--------|
| Default | Inactive icons + labels in tertiary color |
| Active tab | Icon filled variant + label in `colorPrimary`; pill indicator behind icon |
| Badge | Red dot (8dp) or count badge (16dp min-width, 12sp Bold white on `colorError`) top-end of icon |

**RTL:** Tab order visually reverses. Home appears rightmost. Flutter `BottomNavigationBar` handles this automatically when `Directionality` is RTL. Code `items` list stays the same.

**Flutter composition:**
```dart
// Use Scaffold.bottomNavigationBar with BottomNavigationBar
// Do NOT use custom Row -- BottomNavigationBar handles RTL, accessibility, and touch targets
BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: currentIndex,
  onTap: onTabChanged,
  selectedItemColor: LoloColors.colorPrimary,
  unselectedItemColor: LoloColors.darkTextTertiary,
  backgroundColor: LoloColors.darkBgSecondary,
  selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  items: [...],
);
```

---

#### LoloAppBar

**Description:** Top app bar with back navigation, title, and up to 2 trailing actions.

| Property | Value |
|----------|-------|
| Height | 56dp |
| Background (dark) | `#161B22` (`darkBgSecondary`) |
| Background (light) | `#F6F8FA` (`lightBgSecondary`) |
| Bottom border | 1dp `#21262D` (dark) / `#EAEEF2` (light) |
| Elevation | 0dp |
| Title font | 18sp SemiBold (Inter 600), `textPrimary` |
| Leading icon | 24dp in 48dp touch target |
| Trailing actions | Up to 2 icon buttons, 48dp each, 8dp gap |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `title` | `String` | Yes | -- | Screen title |
| `showBackButton` | `bool` | No | `true` | Show leading back arrow |
| `onBack` | `VoidCallback?` | No | `Navigator.pop` | Custom back action |
| `actions` | `List<Widget>` | No | `[]` | Trailing action buttons (max 2) |
| `titleAlignment` | `AlignmentDirectional` | No | `centerStart` | Title alignment |
| `showLogo` | `bool` | No | `false` | Show LOLO mark instead of back arrow |

**States:**

| State | Visual |
|-------|--------|
| With back arrow | Arrow icon at leading position, title after |
| With logo | LOLO compass mark at leading position (home screens) |
| With search | Search icon in trailing actions; expands to full-width search field on tap |
| Scrolled | Optional: add 1dp border or slight background darken to indicate scroll state |

**RTL:** Leading icon moves to end (right side). Trailing actions move to start (left side). Back arrow icon flips direction (points right in RTL). Title alignment mirrors. All automatic with Flutter `AppBar`.

**Flutter composition:**
```dart
AppBar(
  leading: showBackButton ? IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack) : null,
  title: Text(title, style: LoloTypography.headingSm),
  centerTitle: false,
  actions: actions,
  backgroundColor: Theme.of(context).colorScheme.surface,
  elevation: 0,
  bottom: PreferredSize(
    preferredSize: Size.fromHeight(1),
    child: Divider(height: 1, color: Theme.of(context).dividerColor),
  ),
);
```

---

### 2.2 Card Components

#### ActionCard

**Description:** Swipeable SAY/DO/BUY/GO action card with type badge, action text, context, and difficulty indicator.

| Property | Value |
|----------|-------|
| Width | Screen width - 32dp |
| Min height | 320dp (feed), 160dp (dashboard compact) |
| Max height | 400dp (feed) |
| Padding | 20dp all sides (feed), 16dp (compact) |
| Border radius | 12dp |
| Background (dark) | `#21262D` |
| Background (light) | `#EAEEF2` |
| Border | 1dp `#30363D` (dark) / `#D0D7DE` (light) |
| Elevation | `elevation.2` |

**Type Badge Colors:**

| Type | Badge BG (dark) | Badge Text (dark) | Badge BG (light) | Badge Text (light) |
|------|----------------|-------------------|------------------|-------------------|
| SAY | `#4A90D9` at 15% | `#4A90D9` | `#4A90D9` at 10% | `#4A90D9` |
| DO | `#3FB950` at 15% | `#3FB950` | `#1A7F37` at 10% | `#1A7F37` |
| BUY | `#C9A96E` at 15% | `#C9A96E` | `#C9A96E` at 10% | `#956D2E` |
| GO | `#8957E5` at 15% | `#8957E5` | `#8957E5` at 10% | `#6E40C9` |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `type` | `ActionCardType` (SAY/DO/BUY/GO) | Yes | -- | Card category |
| `title` | `String` | Yes | -- | Action headline |
| `body` | `String` | Yes | -- | Action description |
| `contextText` | `String?` | No | `null` | e.g. "Based on her Pisces profile" |
| `difficulty` | `int` (1-3) | Yes | -- | Difficulty dots |
| `xpValue` | `int` | Yes | -- | XP reward amount |
| `status` | `ActionCardStatus` | No | `pending` | pending/completed/skipped |
| `onComplete` | `VoidCallback` | No | -- | Mark done callback |
| `onSkip` | `VoidCallback` | No | -- | Skip callback |
| `onSave` | `VoidCallback` | No | -- | Bookmark callback |
| `isCompact` | `bool` | No | `false` | Dashboard compact variant |

**States:**

| State | Visual |
|-------|--------|
| Default/Pending | Standard card with action buttons below |
| Completed | Green border (`#3FB950`), checkmark overlay at 20% opacity, "Done" replaces buttons |
| Skipped | 50% opacity, strikethrough on title |
| Swiping right | Card tilts 5deg, green tint appears at right edge |
| Swiping left | Card tilts -5deg, skip tint appears at left edge |
| Loading | Skeleton shimmer variant |

**RTL:** Full mirror. Badge moves to top-end. XP moves to top-start. Text right-aligned. Swipe directions reverse semantically: swipe-left = complete in RTL.

**Flutter composition:**
```dart
// Use Card + Column for structure, NOT ListTile
// Wrap in GestureDetector + AnimatedBuilder for swipe physics
Card(
  child: Padding(
    padding: EdgeInsetsDirectional.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [TypeBadge(type), Spacer(), XpLabel(xpValue)]),
        SizedBox(height: 12),
        Text(title, style: LoloTypography.headingSm),
        SizedBox(height: 8),
        Text(body, style: LoloTypography.bodyMd, maxLines: 4),
        SizedBox(height: 12),
        Text(contextText, style: LoloTypography.bodySm),
        Spacer(),
        DifficultyDots(difficulty),
      ],
    ),
  ),
);
```

---

#### ReminderTile

**Description:** Compact reminder list item with urgency accent bar, icon, title/date, and countdown badge.

| Property | Value |
|----------|-------|
| Width | Screen width - 32dp |
| Height | 80dp |
| Padding | 12dp horizontal, 12dp vertical |
| Border radius | 12dp |
| Background (dark) | `#21262D` |
| Background (light) | `#EAEEF2` |
| Start accent bar | 4dp wide, colored by urgency |

**Urgency Colors:**

| Urgency | Accent Color | Text Weight | Badge |
|---------|-------------|------------|-------|
| Future (7+ days) | `#3FB950` (success) | Regular | Days count (gray) |
| Approaching (3-6 days) | `#D29922` (warning) | Medium | Days count (amber) |
| Imminent (1-2 days) | `#F85149` (error) | SemiBold | Days count (red) |
| Today | `#F85149` (error) + pulse | Bold | "TODAY" badge (red) |
| Overdue | `#F85149` (error) | Bold, red text | "OVERDUE" badge (red) |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `title` | `String` | Yes | -- | Reminder title |
| `date` | `DateTime` | Yes | -- | Target date |
| `category` | `ReminderCategory` | Yes | -- | Birthday/Anniversary/Holiday/Custom |
| `icon` | `IconData` | No | Category default | Leading icon |
| `onTap` | `VoidCallback` | No | -- | Navigation to detail |
| `onDismiss` | `VoidCallback` | No | -- | Swipe-to-dismiss |

**States:** Default, Pressed (scale 0.98), Overdue (red text), Completed (strikethrough, muted).

**RTL:** Accent bar moves to end (right side). Icon moves to end. Text right-aligned. Countdown badge at start (left).

**Flutter composition:**
```dart
// Use Container with BorderRadiusDirectional + Row, NOT ListTile
Container(
  decoration: BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(12),
    border: BorderDirectional(start: BorderSide(width: 4, color: urgencyColor)),
  ),
  child: Row(children: [
    SizedBox(width: 12),
    Icon(icon, size: 32),
    SizedBox(width: 12),
    Expanded(child: Column(children: [title, date])),
    CountdownBadge(daysUntil),
    SizedBox(width: 12),
  ]),
);
```

---

#### MemoryCard

**Description:** Memory vault entry with optional thumbnail, title, preview text, and timeline connector.

| Property | Value |
|----------|-------|
| Width | Screen width - 32dp |
| Min height | 96dp |
| Padding | 16dp |
| Border radius | 12dp |
| Background (dark) | `#21262D` |
| Background (light) | `#EAEEF2` |
| Timeline connector | 2dp vertical line, `#30363D`, centered on left edge (LTR) |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `title` | `String` | Yes | -- | Memory title |
| `date` | `DateTime` | Yes | -- | When it happened |
| `preview` | `String?` | No | `null` | First 2 lines of description |
| `thumbnail` | `ImageProvider?` | No | `null` | Optional photo thumbnail |
| `tags` | `List<String>` | No | `[]` | Category tags |
| `onTap` | `VoidCallback` | No | -- | Navigate to detail |

**States:** Default, Pressed (scale 0.98), With image (shows 72dp square thumbnail at start), Without image (text-only).

**RTL:** Timeline connector moves to right edge. Thumbnail moves to end. Text right-aligned.

**Flutter composition:**
```dart
// Use Card + Row + Column
// Timeline connector: CustomPainter or positioned Container
Row(children: [
  TimelineConnector(),
  SizedBox(width: 12),
  if (thumbnail != null) ClipRRect(child: Image(image: thumbnail, width: 72, height: 72)),
  SizedBox(width: 12),
  Expanded(child: Column(children: [title, date, preview, TagRow(tags)])),
]);
```

---

#### GiftCard

**Description:** Gift recommendation card with image, name, price, and save action.

| Property | Value |
|----------|-------|
| Width (grid) | (screen_width - 48dp) / 2 |
| Width (list) | Screen width - 32dp |
| Height (grid) | 200dp |
| Height (list) | 96dp |
| Image area (grid) | Full width x 120dp |
| Image area (list) | 72dp x 72dp square |
| Border radius | 12dp |
| Background (dark) | `#21262D` |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `name` | `String` | Yes | -- | Gift name (max 2 lines) |
| `priceRange` | `String` | Yes | -- | e.g. "$25-50" |
| `imageUrl` | `String?` | No | `null` | Product image URL |
| `reasoning` | `String?` | No | `null` | "Why she'll love it" |
| `isSaved` | `bool` | No | `false` | Bookmark state |
| `onSave` | `VoidCallback` | No | -- | Toggle save |
| `onTap` | `VoidCallback` | No | -- | Navigate to detail |
| `variant` | `GiftCardVariant` | No | `grid` | grid or list layout |

**States:** Default, Pressed (scale 0.98), Saved (heart icon filled red), Loading (shimmer).

**RTL:** Text right-aligned. Heart icon position mirrors. List variant: image moves to end.

**Flutter composition:**
```dart
// Grid variant: Column with AspectRatio image + text + price
// List variant: Row with square image + Expanded text column
// Do NOT use GridTile -- use custom Card + Column
```

---

#### SOSCoachingCard

**Description:** SOS mode coaching card with colored side border. Three variants: Say This (green), Don't Say (red), Do This (blue).

| Property | Value |
|----------|-------|
| Width | Screen width - 32dp |
| Min height | Auto (content-driven) |
| Padding | 16dp |
| Border radius | 12dp |
| Background (dark) | `#21262D` |
| Start border | 4dp wide, colored by variant |

**Variant Colors:**

| Variant | Border Color | Header Icon | Header Color |
|---------|-------------|-------------|-------------|
| `sayThis` | `#3FB950` (success) | `PhosphorIcons.chatCircleCheck` | `#3FB950` |
| `dontSay` | `#F85149` (error) | `PhosphorIcons.chatCircleX` | `#F85149` |
| `doThis` | `#4A90D9` (primary) | `PhosphorIcons.lightbulb` | `#4A90D9` |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `variant` | `SOSCardVariant` | Yes | -- | sayThis/dontSay/doThis |
| `header` | `String` | Yes | -- | e.g. "Say This" |
| `content` | `String` | Yes | -- | Coaching text |
| `example` | `String?` | No | `null` | Example phrase in quotes |

**States:** Default only (static coaching content).

**RTL:** Border moves to end (right side). Text right-aligned. Icon mirrors if directional.

**Flutter composition:**
```dart
Container(
  decoration: BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(12),
    border: BorderDirectional(start: BorderSide(width: 4, color: variantColor)),
  ),
  child: Padding(
    padding: EdgeInsetsDirectional.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(headerIcon, color: variantColor), SizedBox(width: 8), Text(header)]),
      SizedBox(height: 12),
      Text(content, style: LoloTypography.bodyMd),
      if (example != null) ...[SizedBox(height: 8), Text('"$example"', style: italic)],
    ]),
  ),
);
```

---

#### StatCard

**Description:** Compact stat display with icon, numeric value, and label.

| Property | Value |
|----------|-------|
| Width | Flexible (typically 1/3 of screen or 1/2) |
| Height | 80dp |
| Padding | 12dp |
| Border radius | 12dp |
| Background (dark) | `#21262D` |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `icon` | `IconData` | Yes | -- | Stat icon |
| `value` | `String` | Yes | -- | Numeric value display |
| `label` | `String` | Yes | -- | Stat description |
| `iconColor` | `Color` | No | `colorPrimary` | Icon tint |
| `onTap` | `VoidCallback?` | No | `null` | Optional navigation |

**Flutter composition:**
```dart
// Use Column centered inside a Card
Card(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  Icon(icon, size: 24, color: iconColor),
  SizedBox(height: 4),
  Text(value, style: LoloTypography.headingSm),
  Text(label, style: LoloTypography.bodySm),
]));
```

---

#### BadgeCard

**Description:** Achievement badge with shield icon, name, and earned/locked states.

| Property | Value |
|----------|-------|
| Size (standard) | 64dp x 64dp |
| Size (detail) | 96dp x 96dp |
| Shape | Hexagonal/shield outline |
| Background (unlocked) | `gradientAchievement` |
| Background (locked) | `#21262D` (dark) / `#EAEEF2` (light) |
| Border (unlocked) | 2dp `#C9A96E` |
| Border (locked) | 1dp `#30363D` |
| Icon size | 32dp (standard), 48dp (detail) |
| Label below | Caption SemiBold, centered, max 2 lines |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `name` | `String` | Yes | -- | Badge name |
| `icon` | `IconData` | Yes | -- | Badge icon |
| `isEarned` | `bool` | Yes | -- | Earned vs locked state |
| `earnedDate` | `DateTime?` | No | `null` | When earned |
| `size` | `BadgeSize` | No | `standard` | standard (64dp) or detail (96dp) |
| `onTap` | `VoidCallback?` | No | `null` | Open detail view |

**States:**

| State | Visual |
|-------|--------|
| Earned | Gold gradient background, gold border, full-color icon, name below |
| Locked | Gray background, gray border, lock icon overlay at 50% opacity, muted name |
| Earning animation | Scale from 0.5 + gold burst + elasticOut curve, 800ms |

**RTL:** No mirroring needed (badges are symmetrical). Label text alignment follows locale.

---

### 2.3 Input Components

#### LoloTextField

| Property | Value |
|----------|-------|
| Height | 52dp |
| Horizontal padding | 16dp |
| Border radius | 8dp |
| Border (default) | 1dp `#30363D` (dark) / `#D0D7DE` (light) |
| Border (focused) | 2dp `#4A90D9` |
| Border (error) | 2dp `#F85149` |
| Background (dark) | `#21262D` |
| Background (light) | `#EAEEF2` |
| Text | 16sp Regular, `textPrimary` |
| Label (floating) | 12sp Medium, `textSecondary` (unfocused) / `colorPrimary` (focused) |
| Placeholder | 16sp Regular, `textTertiary` |
| Error text | 12sp Regular, `colorError`, 4dp below field |
| Helper text | 12sp Regular, `textTertiary`, 4dp below field |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `label` | `String` | Yes | -- | Floating label text |
| `hint` | `String?` | No | `null` | Placeholder text |
| `errorText` | `String?` | No | `null` | Error message (shows error state) |
| `helperText` | `String?` | No | `null` | Helper text below field |
| `prefixIcon` | `IconData?` | No | `null` | Leading icon |
| `suffixIcon` | `Widget?` | No | `null` | Trailing icon/button |
| `obscureText` | `bool` | No | `false` | Password mode |
| `keyboardType` | `TextInputType` | No | `text` | Keyboard type |
| `maxLines` | `int` | No | `1` | Multi-line support |
| `controller` | `TextEditingController` | Yes | -- | Text controller |
| `enabled` | `bool` | No | `true` | Enabled state |

**States:**

| State | Border | Background | Label Color |
|-------|--------|-----------|------------|
| Default (empty) | 1dp `borderDefault` | `bgTertiary` | `textTertiary` (as placeholder) |
| Focused (empty) | 2dp `colorPrimary` | `bgTertiary` | `colorPrimary` (floated) |
| Focused (filled) | 2dp `colorPrimary` | `bgTertiary` | `colorPrimary` (floated) |
| Filled (unfocused) | 1dp `borderDefault` | `bgTertiary` | `textSecondary` (floated) |
| Error | 2dp `colorError` | `bgTertiary` | `colorError` (floated) |
| Disabled | 1dp `borderMuted` | `bgSecondary` at 50% | `textDisabled` |

**RTL:** Text input direction follows content language. Floating label animates to top-end. Helper/error text aligns to start. Prefix icon moves to end, suffix to start.

**Flutter composition:**
```dart
TextFormField(
  decoration: InputDecoration(
    labelText: label,
    hintText: hint,
    errorText: errorText,
    helperText: helperText,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
  ),
);
```

---

#### LoloChipGroup

| Property | Value |
|----------|-------|
| Chip height | 32dp |
| Chip horizontal padding | 12dp |
| Chip border radius | 16dp (pill) |
| Chip border | 1dp `borderDefault` |
| Gap horizontal | 8dp |
| Gap vertical | 8dp |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `items` | `List<ChipItem>` | Yes | -- | Chip data list |
| `selectedIndices` | `Set<int>` | Yes | -- | Currently selected |
| `onSelectionChanged` | `Function(Set<int>)` | Yes | -- | Selection callback |
| `selectionMode` | `ChipSelectionMode` | No | `single` | single or multi |
| `scrollable` | `bool` | No | `false` | Horizontal scroll mode |

**Chip States:**

| State | Background (dark) | Text Color (dark) | Border |
|-------|------------------|------------------|--------|
| Unselected | Transparent | `#8B949E` | 1dp `#30363D` |
| Selected | `#4A90D9` at 12% | `#4A90D9` | 1dp `#4A90D9` |
| Pressed | `#4A90D9` at 8% | `#8B949E` | 1dp `#30363D` |

**Category Chip variant** (for Action Card filters): Uses type-specific colors instead of `colorPrimary`.

**RTL:** Chip order reverses in wrap layout. Scroll starts from right in horizontal mode. Icon + close icon swap positions.

---

#### LoloSlider

| Property | Value |
|----------|-------|
| Track height | 4dp |
| Active track | `#4A90D9` |
| Inactive track | `#30363D` (dark) / `#D0D7DE` (light) |
| Thumb | 20dp circle, `#4A90D9`, 2dp white border |
| Value tooltip | `darkSurfaceElevated2`, Body 2 text |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `value` | `double` | Yes | -- | Current value |
| `min` | `double` | No | `0.0` | Minimum |
| `max` | `double` | No | `1.0` | Maximum |
| `label` | `String?` | No | `null` | Label above slider |
| `valueDisplay` | `String?` | No | `null` | Formatted value text |
| `onChanged` | `Function(double)` | Yes | -- | Value change callback |

**RTL:** Slider direction reverses. Min at end (right), max at start (left). Flutter `Slider` handles this automatically with `Directionality`.

---

#### LoloDatePicker

| Property | Value |
|----------|-------|
| Style | Inline calendar (Material 3) |
| Header BG | `colorPrimary` |
| Selected date | `colorPrimary` circle |
| Today | `colorPrimary` outlined circle |
| Calendar grid text | `textPrimary` for active month, `textTertiary` for other months |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `selectedDate` | `DateTime?` | No | `null` | Currently selected |
| `firstDate` | `DateTime` | Yes | -- | Earliest selectable |
| `lastDate` | `DateTime` | Yes | -- | Latest selectable |
| `onDateChanged` | `Function(DateTime)` | Yes | -- | Selection callback |

**RTL:** Calendar supports Hijri option for Arabic. Date format: DD/MM/YYYY. Week starts Saturday (configurable). Flutter `showDatePicker` auto-mirrors.

---

#### LoloToggle

| Property | Value |
|----------|-------|
| Track size | 52dp x 32dp |
| Thumb size | 24dp circle |
| Track (off, dark) | `#30363D` |
| Track (on) | `#4A90D9` |
| Thumb (off) | `#6E7681` |
| Thumb (on) | `#FFFFFF` |
| Animation | 200ms ease-out |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `value` | `bool` | Yes | -- | On/off state |
| `onChanged` | `Function(bool)` | Yes | -- | Toggle callback |
| `label` | `String` | Yes | -- | Toggle label |
| `description` | `String?` | No | `null` | Explanatory text below label |

**RTL:** Label and toggle swap sides. On/off thumb direction does NOT mirror (on is always visually right).

**Flutter composition:**
```dart
Row(children: [
  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: LoloTypography.labelLg),
    if (description != null) Text(description, style: LoloTypography.bodySm),
  ])),
  Switch(value: value, onChanged: onChanged, activeColor: LoloColors.colorPrimary),
]);
```

---

#### LoloDropdown

| Property | Value |
|----------|-------|
| Trigger height | 52dp (same as text field) |
| Trigger | Same styling as `LoloTextField` with chevron-down at end |
| Menu background (dark) | `#30363D` |
| Menu border radius | 8dp |
| Menu elevation | 4dp |
| Menu max height | 280dp (scrollable) |
| Menu item height | 48dp |
| Menu item padding | 16dp horizontal |
| Selected item | Checkmark icon at end |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `label` | `String` | Yes | -- | Floating label |
| `items` | `List<DropdownItem>` | Yes | -- | Dropdown options |
| `selectedValue` | `dynamic` | No | `null` | Currently selected |
| `onChanged` | `Function(dynamic)` | Yes | -- | Selection callback |
| `icon` | `IconData?` | No | `null` | Leading icon |
| `errorText` | `String?` | No | `null` | Error message |

**RTL:** Chevron stays at end. Leading icon swaps to start side (right in RTL). Selected checkmark stays at end. Menu items right-aligned.

---

### 2.4 Feedback Components

#### LoloToast

**Description:** Transient notification overlay. Auto-dismisses after 4 seconds.

| Property | Value |
|----------|-------|
| Min height | 56dp |
| Width | Screen width - 16dp (8dp margin each side) |
| Position | Top of screen, 8dp below status bar |
| Background (dark) | `#30363D` |
| Border radius | 12dp |
| Padding | 12dp |
| Animation | Slide down 300ms, auto-dismiss 4s, swipe-up to dismiss |

**Variants:**

| Variant | Accent (3dp start border) | Icon | Icon Color |
|---------|--------------------------|------|-----------|
| `xpGain` | `#C9A96E` | `lolo_xp_star` | `#C9A96E` |
| `success` | `#3FB950` | `PhosphorIcons.checkCircle` | `#3FB950` |
| `error` | `#F85149` | `PhosphorIcons.xCircle` | `#F85149` |
| `info` | `#58A6FF` | `PhosphorIcons.info` | `#58A6FF` |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `variant` | `ToastVariant` | Yes | -- | xpGain/success/error/info |
| `title` | `String` | Yes | -- | Toast title |
| `message` | `String?` | No | `null` | Optional detail text |
| `duration` | `Duration` | No | `4s` | Auto-dismiss time |

**RTL:** Accent border moves to end. Icon moves to end. Text right-aligned.

---

#### LoloEmptyState

| Property | Value |
|----------|-------|
| Layout | Centered vertically in available space |
| Illustration | 120dp x 120dp |
| Title | H4, `textPrimary`, centered |
| Description | Body 2, `textSecondary`, centered, max 3 lines, 8dp below title |
| CTA button | Primary or Secondary, 16dp below description |
| Padding | 32dp horizontal |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `illustration` | `Widget` | Yes | -- | SVG/Lottie illustration |
| `title` | `String` | Yes | -- | Empty state headline |
| `description` | `String` | Yes | -- | Explanatory text |
| `ctaLabel` | `String?` | No | `null` | Button text |
| `onCtaTap` | `VoidCallback?` | No | `null` | Button callback |

**Per-Screen Empty States:**

| Screen | Title | CTA |
|--------|-------|-----|
| Reminders | "No reminders yet" | "Add Your First Reminder" |
| Messages | "No messages yet" | "Generate Your First Message" |
| Memory Vault | "Your vault is empty" | "Add a Memory" |
| Gift History | "No gifts tracked yet" | "Get Gift Ideas" |
| Action Cards | "No cards today" | "Check back tomorrow" (no button) |
| Wish List | "No wishes captured yet" | "Add to Wish List" |

**RTL:** Center alignment is direction-neutral. Text reflows naturally. CTA button stays centered.

---

#### LoloSkeleton

| Property | Value |
|----------|-------|
| Background | `#21262D` (dark) / `#EAEEF2` (light) |
| Shimmer gradient | `linear-gradient(90deg, #21262D, #30363D, #21262D)` |
| Shimmer duration | 1500ms loop, linear easing |
| Text line height | 12dp, 4dp vertical gap |
| Title width | 60% of container |
| Body lines | 100% first two, 80% last |
| Avatar | Circle matching avatar size |
| Card shape | Rounded rect matching card radius (12dp) |

**Skeleton Templates:**

| Template | Usage |
|----------|-------|
| `SkeletonDashboard` | Dashboard home: action card + reminders + streak |
| `SkeletonCardList` | 3 stacked card skeletons |
| `SkeletonMessage` | Message bubble with 3 text lines |
| `SkeletonProfile` | Avatar circle + 3 text lines |
| `SkeletonGiftGrid` | 2x2 grid of image + text line |

**RTL:** Shimmer animation direction reverses (sweeps right-to-left in LTR, left-to-right in RTL).

---

#### LoloDialog

| Property | Value |
|----------|-------|
| Width | Screen width - 48dp (max 400dp) |
| Background (dark) | `#282E36` |
| Background (light) | `#FFFFFF` |
| Border radius | 16dp |
| Padding | 24dp all sides |
| Title | 18sp SemiBold, `textPrimary` |
| Body | 14sp Regular, `textSecondary`, 8dp below title |
| Actions | End-aligned, 12dp gap, 16dp above bottom |
| Scrim | `#0D1117` at 70% |
| Animation | Fade + scale from 0.95, 200ms |

**Variants:**

| Variant | Confirm Button Style | Usage |
|---------|---------------------|-------|
| `confirmation` | Primary button | General confirmations |
| `destructive` | Error-colored button (`#F85149` bg) | Delete, cancel subscription |
| `info` | Primary button ("OK") | Informational alerts |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `variant` | `DialogVariant` | No | `confirmation` | Visual variant |
| `title` | `String` | Yes | -- | Dialog title |
| `body` | `String` | Yes | -- | Dialog message |
| `confirmLabel` | `String` | Yes | -- | Confirm button text |
| `cancelLabel` | `String` | No | `"Cancel"` | Cancel button text |
| `onConfirm` | `VoidCallback` | Yes | -- | Confirm action |
| `onCancel` | `VoidCallback?` | No | `Navigator.pop` | Cancel action |

**RTL:** Button order stays the same (affirmative at end per Material convention). Title and body right-aligned.

---

### 2.5 Display Components

#### LoloProgressBar

**Linear variant:**

| Property | Value |
|----------|-------|
| Height | 8dp |
| Border radius | 4dp |
| Track BG | `#30363D` (dark) / `#D0D7DE` (light) |
| Fill | `gradientPremium` (blue to gold) for XP; `colorPrimary` for generic |
| Label above | "Level {n}: {title}" (H6) at start; "{current}/{needed} XP" (Caption) at end |
| Animation | Fill animates on change, 500ms ease-out |

**Circular gauge variant (Relationship Consistency Score):**

| Property | Value |
|----------|-------|
| Size | 120dp x 120dp |
| Track stroke | 8dp, `#30363D` |
| Fill stroke | 8dp, color by score: 0-39 `#F85149`, 40-69 `#D29922`, 70-100 `#3FB950` |
| Center label | Score (H1 Bold) + "/100" (Caption) |
| Animation | Clockwise fill from top, 800ms ease-out |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `value` | `double` (0.0-1.0) | Yes | -- | Progress value |
| `variant` | `ProgressVariant` | No | `linear` | linear or circular |
| `label` | `String?` | No | `null` | Descriptive label |
| `valueLabel` | `String?` | No | `null` | Formatted value text |
| `color` | `Color?` | No | `null` | Override fill color |
| `useGradient` | `bool` | No | `false` | Use premium gradient fill |

**RTL:** Linear progress fills from right to left. Circular gauge fills counter-clockwise. Label alignment mirrors.

---

#### LoloStreakDisplay

| Property | Value |
|----------|-------|
| Layout | Horizontal: flame icon (24dp) + count (H3 Bold) + "day streak" (Body 2) |
| Flame color (active) | Orange gradient (`#D29922` to `#F85149`) |
| Flame color (broken) | `#484F58` (gray) |
| Count color (active) | `#C9A96E` (gold) |
| Count color (zero) | `#484F58` |
| Container (optional) | `#21262D`, 12dp radius, 12dp padding |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `count` | `int` | Yes | -- | Streak day count |
| `isActive` | `bool` | Yes | -- | Active vs broken |
| `showContainer` | `bool` | No | `true` | Wrap in container |
| `onTap` | `VoidCallback?` | No | `null` | Navigate to streak detail |

**Milestones:** At 7, 14, 30, 60, 100 days: gold glow pulse 600ms on flame icon.

**RTL:** Layout mirrors naturally with `Row`. Flame icon stays at start.

---

#### LoloBadge (Plan Badge)

**Description:** Small label badge indicating subscription tier or category.

| Property | Value |
|----------|-------|
| Height | 20dp |
| Padding | 8dp horizontal |
| Border radius | 10dp (pill) |
| Font | 11sp SemiBold |

**Variants:**

| Variant | Background | Text Color |
|---------|-----------|-----------|
| Free | `#30363D` | `#8B949E` |
| Pro | `#4A90D9` at 15% | `#4A90D9` |
| Legend | `gradientAchievement` | `#FFFFFF` |
| Category | Varies by category | Matches badge type color |

---

#### LoloAvatar

| Property | Value |
|----------|-------|
| Sizes | 24dp (inline), 40dp (list), 64dp (profile header), 96dp (profile edit) |
| Shape | Circle |
| Border | 2dp white (on image backgrounds), none on surface |
| Placeholder | First letter centered, `colorPrimary` bg, white text |
| Placeholder font | 12sp (24dp), 16sp (40dp), 24sp (64dp), 32sp (96dp) |
| Edit overlay | Camera icon 24dp, circular dark overlay 50% at bottom-end |

**Props:**

| Prop | Type | Required | Default | Description |
|------|------|:--------:|---------|-------------|
| `imageUrl` | `String?` | No | `null` | Avatar image URL |
| `name` | `String` | Yes | -- | For initials fallback |
| `size` | `AvatarSize` | No | `medium` (40dp) | Size variant |
| `zodiacBadge` | `IconData?` | No | `null` | Zodiac overlay icon |
| `showEditOverlay` | `bool` | No | `false` | Camera overlay |
| `onEditTap` | `VoidCallback?` | No | `null` | Edit photo callback |

**RTL:** Edit overlay moves to bottom-start (left in RTL). Zodiac badge overlay position mirrors.

---

## Section 3: Screen-to-Component Mapping

| # | Screen | Route | Components Used |
|:-:|--------|-------|----------------|
| 1 | Language Selector | `/onboarding/language` | LoloLogo, LanguageTile (custom) |
| 2 | Welcome | `/onboarding/welcome` | LoloLogo, BenefitRow (custom), LoloPrimaryButton, TextLink |
| 3 | Sign Up | `/onboarding/signup` | LoloAppBar, LoloLogo, SocialButton (custom), LoloTextField x3, LoloPrimaryButton |
| 4 | Login | `/login` | LoloAppBar, LoloLogo, LoloTextField x2, LoloPrimaryButton, TextLink |
| 5 | Onboarding Name | `/onboarding/step/1` | LoloAppBar, LoloTextField, LoloProgressBar (linear), LoloPrimaryButton |
| 6 | Onboarding Partner | `/onboarding/step/2` | LoloAppBar, LoloTextField, LoloChipGroup (zodiac), LoloProgressBar, LoloPrimaryButton |
| 7 | Onboarding Relationship | `/onboarding/step/3` | LoloAppBar, LoloChipGroup (status), LoloProgressBar, LoloPrimaryButton |
| 8 | Onboarding Date + First Card | `/onboarding/step/4-5` | LoloAppBar, LoloDatePicker, ActionCard (template), LoloProgressBar, LoloPrimaryButton |
| 9 | Home Dashboard | `/home` | LoloAppBar (with logo), LoloBottomNav, ActionCard (compact), ReminderTile, LoloStreakDisplay, StatCard x3, LoloProgressBar (circular + linear), LoloSkeleton |
| 10 | Dashboard Detail | `/home/detail` | LoloAppBar, LoloBottomNav, StatCard, LoloProgressBar |
| 11 | Notifications Center | `/home/notifications` | LoloAppBar, NotificationTile (custom), LoloEmptyState |
| 12 | Her Profile | `/profile/her` | LoloAppBar, LoloBottomNav, LoloAvatar (64dp), LoloProgressBar (linear), LoloBadge (zodiac), StatCard, LoloPrimaryButton |
| 13 | Her Profile Edit | `/profile/her/edit` | LoloAppBar, LoloAvatar (96dp, editable), LoloTextField x5+, LoloDropdown x2, LoloChipGroup, LoloPrimaryButton |
| 14 | Her Preferences | `/profile/her/preferences` | LoloAppBar, LoloChipGroup (multi), LoloTextField (notes), LoloPrimaryButton |
| 15 | Her Profile Zodiac Detail | `/profile/her/zodiac` | LoloAppBar, ZodiacWheel (custom), StatCard, LoloChipGroup |
| 16 | Reminder List | `/reminders` | LoloAppBar, LoloBottomNav, ReminderTile xN, LoloChipGroup (filter tabs), LoloEmptyState, LoloSkeleton, FAB |
| 17 | Add/Edit Reminder | `/reminders/new` | LoloAppBar, LoloTextField x2, LoloDatePicker, LoloDropdown (category), LoloToggle (recurring), LoloPrimaryButton |
| 18 | Reminder Detail | `/reminders/:id` | LoloAppBar, ReminderTile (expanded), LoloDialog (delete confirm) |
| 19 | Message Generator Home | `/messages` | LoloAppBar, LoloBottomNav, LoloChipGroup (mode selection), MessageModeCard (custom), LoloEmptyState, LoloSkeleton |
| 20 | Message Tone/Length | `/messages/customize` | LoloAppBar, LoloChipGroup (tone), LoloSlider (length), LoloPrimaryButton |
| 21 | Message Result | `/messages/result` | LoloAppBar, MessageCard (custom), LoloPrimaryButton (copy), LoloToast (copied), IconButton (share, regenerate, rate) |
| 22 | Message History | `/messages/history` | LoloAppBar, LoloBottomNav, MessageCard xN, LoloChipGroup (filter), LoloEmptyState, LoloSkeleton |
| 23 | Gift Browse | `/gifts` | LoloAppBar, LoloBottomNav, LoloTextField (search), LoloChipGroup (categories), LoloToggle (budget filter), GiftCard xN (grid), LoloSkeleton, LoloEmptyState |
| 24 | Gift Detail | `/gifts/:id` | LoloAppBar, GiftCard (expanded), LoloPrimaryButton (save), LoloToast |
| 25 | Gift Saved | `/gifts/saved` | LoloAppBar, LoloBottomNav, GiftCard xN (list), LoloEmptyState |
| 26 | SOS Mode Entry | `/sos` | LoloAppBar, SOSButton (custom gradient), ScenarioTile (custom) x6, LoloDialog (confirm) |
| 27 | SOS Assessment | `/sos/assess` | LoloAppBar, LoloChipGroup (severity), LoloSlider (intensity), LoloProgressBar, LoloPrimaryButton |
| 28 | SOS Coaching | `/sos/coaching` | LoloAppBar, SOSCoachingCard x3 (sayThis, dontSay, doThis), LoloPrimaryButton |
| 29 | SOS Resolution | `/sos/resolution` | LoloAppBar, SOSCoachingCard (follow-up), LoloTextField (notes), LoloPrimaryButton, LoloToast |
| 30 | Gamification Dashboard | `/gamification` | LoloAppBar, LoloBottomNav, LoloStreakDisplay, LoloProgressBar (linear + circular), StatCard x4, BadgeCard (preview row), LoloBadge (plan) |
| 31 | Badge Collection | `/gamification/badges` | LoloAppBar, BadgeCard xN (grid, 3 columns), LoloChipGroup (category filter) |
| 32 | Level Detail | `/gamification/level` | LoloAppBar, LoloProgressBar (linear), LevelCard (custom), BadgeCard (earned at level) |
| 33 | Action Card Feed | `/action-cards` | LoloAppBar, LoloBottomNav, ActionCard (full), PeekCard (behind), ActionButtonRow (custom), LoloToast (XP) |
| 34 | Action Card Detail | `/action-cards/:id` | LoloAppBar, ActionCard (expanded), LoloPrimaryButton, LoloToast |
| 35 | Memory Vault List | `/memories` | LoloAppBar, LoloBottomNav, MemoryCard xN (timeline), LoloChipGroup (filter), LoloEmptyState, LoloSkeleton, FAB |
| 36 | Add Memory | `/memories/new` | LoloAppBar, LoloTextField x2, LoloDatePicker, LoloChipGroup (tags), ImagePicker (custom), LoloPrimaryButton |
| 37 | Memory Detail | `/memories/:id` | LoloAppBar, MemoryCard (expanded), ImageGallery (custom), LoloDialog (delete) |
| 38 | Wish List | `/memories/wishes` | LoloAppBar, WishTile (custom) xN, LoloEmptyState, FAB |
| 39 | Settings Main | `/settings` | LoloAppBar, SettingsGroup (custom), LoloToggle, LoloBadge (plan), LoloAvatar (40dp) |
| 40 | Settings Notifications | `/settings/notifications` | LoloAppBar, LoloToggle xN, LoloSlider (quiet hours) |
| 41 | Settings Account | `/settings/account` | LoloAppBar, LoloTextField (email), LoloPrimaryButton (logout), LoloDialog (delete account, destructive) |
| 42 | Paywall | `/paywall` | LoloLogo, PlanComparisonTable (custom), LoloPrimaryButton (subscribe), LoloBadge (tier labels), LoloToggle (annual/monthly) |
| 43 | Empty State Templates | N/A | LoloEmptyState (9 variants per module) |

---

## Section 4: Animation Implementation Guide

### 4.1 Page Transitions

| Transition | Usage | Duration | Easing | Flutter Implementation |
|-----------|-------|:--------:|--------|----------------------|
| Shared Axis Horizontal | Tab switches, card browsing | 300ms | `Curves.easeInOutCubic` | `SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal)` |
| Shared Axis Vertical | List to detail, dashboard to module | 300ms | `Curves.easeInOutCubic` | `SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.vertical)` |
| Fade Through | Settings sections, onboarding steps | 300ms | `Curves.easeOutCubic` | `FadeThroughPageTransitionsBuilder()` |
| Container Transform | Card to full-screen detail | 300ms | `Curves.easeInOutCubic` | `OpenContainer` from `animations` package |
| Bottom Sheet Slide | All bottom sheets | 300ms enter / 250ms exit | Enter: `Curves.decelerate`, Exit: `Curves.easeInCubic` | `showModalBottomSheet` with custom `AnimationController` |
| Dialog Fade+Scale | All dialogs | 200ms | `Curves.easeOutCubic` | `showDialog` with `FadeTransition` + `ScaleTransition(begin: 0.95)` |

**RTL:** Horizontal transitions reverse direction automatically when using `SharedAxisPageTransitionsBuilder` with `Directionality`.

### 4.2 Micro-Interactions

| Interaction | Trigger | Animation | Duration | Curve | Haptic |
|------------|---------|-----------|:--------:|-------|--------|
| Button press | `onTapDown` | Scale to 0.97 | 100ms | `Curves.easeOutCubic` | `HapticFeedback.lightImpact` |
| Button release | `onTapUp` | Scale to 1.00 | 150ms | `Curves.easeOutCubic` | -- |
| Chip select | `onTap` | Background fill 0% to 12% + border color | 150ms | `Curves.easeOutCubic` | `HapticFeedback.selectionClick` |
| Toggle slide | `onTap` | Thumb slides + track color change | 200ms | `Curves.easeOutCubic` | `HapticFeedback.selectionClick` |
| Card press | `onTapDown` | Scale to 0.98 | 100ms | `Curves.easeOutCubic` | -- |
| FAB press | `onTapDown` | Scale to 0.95, elevation 6dp to 2dp | 100ms | `Curves.easeOutCubic` | `HapticFeedback.lightImpact` |
| Toast appear | Trigger event | Slide down from -56dp to 0dp + fade 0 to 1 | 300ms | `Curves.decelerate` | -- |
| Toast dismiss | 4s timer or swipe-up | Slide up + fade out | 250ms | `Curves.easeInCubic` | -- |
| Icon morph (copy to check) | Copy action | Icon cross-fade + color green flash | 200ms | `Curves.easeOutCubic` | `HapticFeedback.lightImpact` |

### 4.3 Feature Animations

| Animation | Trigger | Description | Duration | Curve |
|-----------|---------|-------------|:--------:|-------|
| **Streak flame** | Daily first action | Flame scales 1.0 > 1.3 > 1.0; count rolls up; gold glow pulse | 500ms (scale), 600ms (glow) | `Curves.easeInOutCubic` |
| **Streak milestone** | 7/14/30/60/100 days | Extended gold particle burst from flame | 800ms | `Curves.elasticOut` |
| **XP toast float** | Any XP-awarding action | "+{n} XP" text floats 40dp upward, fading out; level bar fills | 500ms | `Curves.easeOutCubic` |
| **Card swipe** | Horizontal drag on action card | Card slides + rotates 5deg; next card scales 0.95 > 1.0 | 300ms | Exit: `Curves.easeInCubic`, Enter: `Curves.decelerate` |
| **Card swipe cancel** | Release below 40% threshold | Spring back to center | 200ms | `Curves.easeOutCubic` |
| **Level up** | XP crosses threshold | Full-screen overlay; badge scale from 0.5 + elasticOut; name typewriter; gold sweep | 800ms (badge), 50ms/char (text) | `Curves.elasticOut` |
| **Typewriter text** | AI message generation | Text appears character by character | 50ms per character | Linear |
| **Score ring fill** | Screen entry | Ring fills clockwise from top | 800ms | `Curves.easeOutCubic` |
| **Consistency score ring (RTL)** | Screen entry (Arabic) | Ring fills counter-clockwise from top | 800ms | `Curves.easeOutCubic` |
| **Message copied** | Tap copy button | Icon morphs copy > checkmark; green border flash; revert after 2s | 200ms (morph), 300ms (flash) | `Curves.easeOutCubic` |
| **Pull to refresh** | Pull down gesture | LOLO compass spins on pull, snaps to spinner on release | 300ms threshold | `Curves.decelerate` |
| **AI generating** | Waiting for AI response | Three dots with wave motion (150ms stagger per dot) | 1200ms loop | `Curves.easeInOut` |

### 4.4 Loading Patterns

| Pattern | Implementation | Duration |
|---------|---------------|:--------:|
| Skeleton shimmer | Gradient sweep across skeleton shapes, direction-aware | 1500ms loop, linear |
| Button loading | Text fade out (100ms), spinner fade in (100ms), within button bounds | 200ms |
| Full screen loading | LOLO compass pulse (scale 0.9 to 1.1) centered on `bgPrimary` | 800ms loop |
| Infinite scroll | 3-dot pulsing indicator, 32dp height, below last item | 600ms loop |
| Pull to refresh | Compass spin during pull, determinate spinner on release | 300ms |

### 4.5 Easing Curves Quick Reference

| Token | Flutter Curve | Usage |
|-------|--------------|-------|
| `easeDefault` | `Curves.easeOutCubic` | Default for all animations |
| `easeEnter` | `Curves.decelerate` | Elements entering screen |
| `easeExit` | `Curves.easeInCubic` | Elements leaving screen |
| `easeEmphasis` | `Curves.easeInOutCubic` | Tab switch, mode change, card flip |
| `easeBounce` | `Curves.elasticOut` | Gamification ONLY: XP pop, level-up badge |

### 4.6 Duration Standards

| Token | Duration | Usage |
|-------|:--------:|-------|
| `durationInstant` | 100ms | Toggle, checkbox, small icon transitions |
| `durationFast` | 150ms | Button press, chip select, tab indicator |
| `durationQuick` | 200ms | Tooltip, hover, icon button ripple |
| `durationNormal` | 300ms | Page transitions, bottom sheet, card expand, modal |
| `durationSlow` | 500ms | Celebration pulse, progress fill, XP float |
| `durationCinematic` | 800ms | Level-up, achievement unlock, score ring |
| `durationExtended` | 1500ms | Skeleton shimmer cycle, full-screen loading pulse |

---

## Section 5: RTL Implementation Checklist

Condensed from RTL Design Guidelines v2.0 into an actionable checklist per developer.

### 5.1 Widget-Level Rules

| Rule | Implementation | Priority |
|------|---------------|:--------:|
| Use `EdgeInsetsDirectional` for all padding/margin | Replace every `EdgeInsets.only(left:, right:)` with `EdgeInsetsDirectional.only(start:, end:)` | P0 |
| Use `AlignmentDirectional` for alignment | Replace `Alignment.centerLeft/Right` with `AlignmentDirectional.centerStart/End` | P0 |
| Use `TextAlign.start/end` instead of `left/right` | All `Text` widgets use `start`/`end`, never `left`/`right` | P0 |
| Use `BorderRadiusDirectional` where asymmetric | Replace `BorderRadius.only(topLeft:)` with `BorderRadiusDirectional.only(topStart:)` | P1 |
| Use `Positioned.directional` for absolute positioning | Replace `Positioned(left:)` with `PositionedDirectional(start:)` | P1 |
| Use `CrossAxisAlignment.start` (not `.left`) | Already default, but verify in all `Column`/`Row` widgets | P1 |
| Phone numbers always LTR | Wrap phone fields in `Directionality(textDirection: TextDirection.ltr)` | P1 |
| Brand logos never mirror | Wrap LOLO logo in `Directionality(textDirection: TextDirection.ltr)` | P1 |

### 5.2 Icon Mirroring Rules

**Icons that MUST have `matchTextDirection: true`:**

| Icon | Reason |
|------|--------|
| `Icons.arrow_back` / `arrow_forward` | Directional navigation |
| `Icons.chevron_left` / `chevron_right` | Directional progression |
| `Icons.send` / `reply` | Directional action |
| `Icons.redo` / `undo` | Directional action |
| `Icons.format_indent_increase/decrease` | Text direction |
| `Icons.exit_to_app` / `logout` | Directional metaphor |

**Icons that must NOT mirror (force LTR if needed):**

Search, checkmark, close (X), add (+), clock, play/pause, volume, lock, camera, heart, star, download/upload, sort/filter, settings gear, LOLO compass, zodiac symbols.

### 5.3 Navigation Rules

| Element | RTL Behavior | Implementation |
|---------|-------------|---------------|
| Bottom nav tab order | Visually reverses (Home at right) | Automatic with `BottomNavigationBar` |
| App bar leading/trailing | Swap sides | Automatic with `AppBar` |
| Back arrow direction | Points right in RTL | Automatic with `Icons.arrow_back` |
| Drawer anchor | Opens from right | Automatic with `Scaffold.drawer` |
| Swipe back gesture | Swipe left = back in RTL | Use `DismissDirection.startToEnd/endToStart` |
| Page push transition | New page slides from left in RTL | Use directional `PageRouteBuilder` |
| Tab bar order | First tab at right | Automatic with `TabBar` |
| Horizontal scroll start | Starts at right | Automatic with `ListView` |

### 5.4 Typography Rules (Arabic)

| Property | English/Malay | Arabic | Action |
|----------|:------------:|:------:|--------|
| Body font size | 16sp | 17sp | Locale-aware `TextTheme` with +1sp for AR body styles |
| Heading font size | As defined | +2sp | Locale-aware `TextTheme` with +2sp for AR heading styles |
| Body line height | 1.50x | 1.65x | Adjust `height` property in AR `TextStyle` |
| Heading line height | 1.25x-1.40x | 1.40x-1.50x | Adjust `height` property in AR `TextStyle` |
| Minimum body size | 14sp | 16sp | Enforce in AR text theme |
| Letter spacing | Varies | Never negative | Set `letterSpacing: 0` for all AR styles |
| Heading font | Inter | Cairo | Switch `fontFamily` based on locale |
| Body font | Inter | Noto Naskh Arabic | Switch `fontFamily` based on locale |
| UPPERCASE/overline | Supported | Not applicable | Conditional: no `toUpperCase()` on AR strings |

### 5.5 Testing Procedure Per Screen

For every screen, execute this RTL test checklist:

- [ ] Switch app locale to Arabic
- [ ] Verify all text is right-aligned
- [ ] Verify `Row` children are reversed (first child at right)
- [ ] Verify leading/trailing icons are swapped
- [ ] Verify directional icons (arrows, chevrons) point correctly
- [ ] Verify `EdgeInsetsDirectional` spacing (no clipped text, no overlap)
- [ ] Verify horizontal scroll starts from right
- [ ] Verify swipe gestures work in mirrored direction
- [ ] Verify page transitions slide from correct direction
- [ ] Verify embedded English text (brand names, numbers) renders correctly via BiDi
- [ ] Verify Arabic text meets minimum 16sp body size
- [ ] Verify no negative letter-spacing on Arabic text
- [ ] Test screen reader announcement order (right-to-left for Arabic)

---

## Section 6: Asset Export List

### 6.1 App Icon

| Asset | Sizes | Format | Platform |
|-------|-------|--------|----------|
| `ic_launcher_background` | 108x108dp | XML Vector Drawable | Android Adaptive |
| `ic_launcher_foreground` | 108x108dp | XML Vector Drawable | Android Adaptive |
| `ic_launcher_monochrome` | 108x108dp | XML Vector Drawable | Android 13+ Themed |
| `ic_launcher` (legacy) | 36, 48, 72, 96, 144, 192 dp | PNG (per density) | Android Legacy |
| App Icon Master | 1024x1024px | PNG (no alpha) | iOS App Store |
| App Icon (@2x) | 120x120px | PNG | iOS iPhone |
| App Icon (@3x) | 180x180px | PNG | iOS iPhone |
| Play Store Icon | 512x512px | PNG | Google Play |
| Favicon | 16, 32, 48px | ICO + SVG | Web |
| Notification Icon | 24dp (mdpi through xxxhdpi) | Vector + PNG | Android |

### 6.2 Logo Variants

| Asset | Sizes | Format | Usage |
|-------|-------|--------|-------|
| `logo_compass_full_color` | 48dp, 32dp, 24dp, 16dp | SVG | In-app (dark bg) |
| `logo_compass_mono_white` | 48dp, 32dp, 24dp | SVG | Over photography |
| `logo_compass_mono_dark` | 48dp, 32dp, 24dp | SVG | Light mode |
| `logo_compass_mono_blue` | 48dp, 32dp | SVG | Links, email |
| `logo_wordmark_horizontal` | 140dp wide | SVG | Splash, marketing |
| `logo_wordmark_stacked` | 48dp wide | SVG | Splash, onboarding |
| `logo_gradient_premium` | 80dp, 64dp, 48dp | SVG | Splash animation, onboarding hero |

### 6.3 Module Icons

| Icon | Name | Sizes | Format |
|------|------|-------|--------|
| Home | `ic_module_home` | 24dp, 32dp | SVG |
| Reminders | `ic_module_reminders` | 24dp, 32dp | SVG |
| Messages | `ic_module_messages` | 24dp, 32dp | SVG |
| Gifts | `ic_module_gifts` | 24dp, 32dp | SVG |
| SOS | `ic_module_sos` | 24dp, 32dp | SVG |
| Gamification | `ic_module_gamification` | 24dp, 32dp | SVG |
| Action Cards | `ic_module_action_cards` | 24dp, 32dp | SVG |
| Memory Vault | `ic_module_memories` | 24dp, 32dp | SVG |
| Her Profile | `ic_module_profile` | 24dp, 32dp | SVG |
| Settings | `ic_module_settings` | 24dp, 32dp | SVG |

### 6.4 Action Card Type Icons

| Icon | Name | Size | Color Token |
|------|------|:----:|-------------|
| SAY | `ic_action_say` (speech bubble + wave) | 24dp | `#4A90D9` |
| DO | `ic_action_do` (checkmark in gear) | 24dp | `#3FB950` |
| BUY | `ic_action_buy` (shopping bag + sparkle) | 24dp | `#C9A96E` |
| GO | `ic_action_go` (location pin + arrow) | 24dp | `#8957E5` |

### 6.5 Gamification Assets

| Asset | Name | Size | Format |
|-------|------|------|--------|
| Streak flame | `ic_streak_flame` | 24dp, 32dp | SVG (with gradient fill) |
| XP star | `ic_xp_star` | 16dp, 24dp | SVG |
| Level badge shield | `ic_level_badge` | 32dp, 64dp | SVG |
| Achievement badges (12+) | `ic_badge_{name}` | 64dp, 96dp | SVG |
| Lock overlay | `ic_badge_lock` | 16dp | SVG |
| Plan badge: Free | `ic_plan_free` | 20dp | SVG |
| Plan badge: Pro | `ic_plan_pro` | 20dp | SVG |
| Plan badge: Legend | `ic_plan_legend` | 20dp | SVG |

### 6.6 Empty State Illustrations

| Illustration | Name | Size | Screens |
|-------------|------|:----:|---------|
| Calendar with dots | `il_empty_reminders` | 120dp | Reminder List |
| Message bubble outline | `il_empty_messages` | 120dp | Message History |
| Vault/box outline | `il_empty_memories` | 120dp | Memory Vault |
| Gift box outline | `il_empty_gifts` | 120dp | Gift Saved |
| Card stack outline | `il_empty_action_cards` | 120dp | Action Card Feed |
| Star outline | `il_empty_wishes` | 120dp | Wish List |
| Shield outline | `il_empty_badges` | 120dp | Badge Collection |
| Chart outline | `il_empty_stats` | 120dp | Stats (if empty) |
| Person outline | `il_empty_profile` | 120dp | Profile (no partner) |

Style: Abstract geometric, line-based, monochrome with `colorPrimary` accent. NOT cute characters. Dark-optimized variants (lighter strokes) and light-optimized variants (darker strokes).

### 6.7 Lottie/Rive Animations

| Animation | Name | Format | Duration | Trigger |
|-----------|------|--------|:--------:|---------|
| Streak flame (active) | `anim_streak_flame` | Rive | Loop | Displayed while streak active |
| Streak milestone burst | `anim_streak_milestone` | Lottie | 800ms | Milestone day |
| Level up celebration | `anim_level_up` | Lottie | 3000ms | Level threshold crossed |
| XP gain float | `anim_xp_gain` | Lottie | 500ms | XP awarded |
| Badge unlock | `anim_badge_unlock` | Lottie | 800ms | Badge earned |
| Confetti burst | `anim_confetti` | Lottie | 1500ms | Celebration moments |
| LOLO compass loading | `anim_compass_loading` | Rive | Loop | Full-screen loading |
| Pull-to-refresh compass | `anim_compass_refresh` | Rive | Gesture-driven | Pull down to refresh |
| AI typing dots | `anim_typing_dots` | Lottie | Loop | AI generating |

### 6.8 Font Files

| Font | Weights | Files | Usage |
|------|---------|-------|-------|
| Inter | 400, 500, 600, 700 | `Inter-Regular.ttf`, `Inter-Medium.ttf`, `Inter-SemiBold.ttf`, `Inter-Bold.ttf` | English/Malay headings + body |
| Cairo | 600, 700 | `Cairo-SemiBold.ttf`, `Cairo-Bold.ttf` | Arabic headings |
| Noto Naskh Arabic | 400, 500 | `NotoNaskhArabic-Regular.ttf`, `NotoNaskhArabic-Medium.ttf` | Arabic body |
| Noto Sans | 400, 500 | `NotoSans-Regular.ttf`, `NotoSans-Medium.ttf` | Malay fallback |
| JetBrains Mono | 400, 500 | `JetBrainsMono-Regular.ttf`, `JetBrainsMono-Medium.ttf` | Monospace (debug, codes) |

### 6.9 Flag Assets

| Flag | Name | Size | Format |
|------|------|:----:|--------|
| US/UK | `flag_en.png` | 32x24dp (4:3 ratio) | PNG with 4dp border radius |
| Saudi Arabia | `flag_ar.png` | 32x24dp | PNG with 4dp border radius |
| Malaysia | `flag_ms.png` | 32x24dp | PNG with 4dp border radius |

---

## Section 7: Responsive & Adaptive Design

### 7.1 Breakpoints

LOLO is phone-first. Tablet and foldable modes are supported but not primary targets.

| Breakpoint | Width Range | Layout Adjustments |
|-----------|:----------:|-------------------|
| Compact (phone) | 0-599dp | Single column, full-width cards, 16dp horizontal padding, bottom nav |
| Medium (tablet/foldable) | 600-839dp | Two-column card grid, 24dp horizontal padding, bottom nav |
| Expanded (large tablet) | 840dp+ | Three-column grid, navigation rail replaces bottom nav, max content width 840dp centered |

### 7.2 Safe Area Handling

| Area | Rule |
|------|------|
| Top (status bar/notch) | Always use `SafeArea` or `MediaQuery.of(context).padding.top`. App bar handles this automatically. |
| Bottom (home indicator) | Always use `SafeArea` bottom, especially for bottom nav and bottom-aligned CTAs. Add 16dp extra padding above bottom safe area for content. |
| Left/Right (display cutouts) | Use `SafeArea` left/right on landscape or edge-to-edge screens. |

### 7.3 Keyboard-Visible Layout Adjustments

| Rule | Implementation |
|------|---------------|
| Active field visible | Use `SingleChildScrollView` + `Scaffold(resizeToAvoidBottomInset: true)`. Active text field must remain visible with 16dp clearance above keyboard. |
| CTA button above keyboard | Bottom-anchored buttons should use `MediaQuery.of(context).viewInsets.bottom` to stay above keyboard. |
| Bottom nav hidden | When keyboard is visible, bottom navigation should be hidden (automatic with `Scaffold`). |
| Bottom sheet content | Bottom sheets with input fields should resize to accommodate keyboard. |

### 7.4 Landscape Mode Handling

| Screen Group | Landscape Support | Notes |
|-------------|:-----------------:|-------|
| Onboarding (1-8) | Not supported | Lock to portrait. Show "Please rotate" prompt. |
| Dashboard (9-11) | Supported | Reflow to 2-column layout for stat cards. |
| Her Profile (12-15) | Supported | Scrollable single column. |
| Reminders (16-18) | Supported | Standard list layout. |
| Messages (19-22) | Supported | Standard layout. |
| Gifts (23-25) | Supported | 3-column grid in landscape. |
| SOS (26-29) | Not supported | Lock to portrait (crisis context, simplicity). |
| Gamification (30-32) | Supported | Stat cards reflow. |
| Action Cards (33-34) | Not supported | Lock to portrait (swipe-oriented). |
| Memories (35-38) | Supported | Timeline reflows. |
| Settings (39-41) | Supported | Standard list layout. |
| Paywall (42) | Not supported | Lock to portrait. |

### 7.5 Text Scaling Behavior

| Scale | Layout Behavior | Testing Required |
|:-----:|----------------|:----------------:|
| 100% (default) | All designs pixel-perfect | Baseline |
| 125% | Minor spacing adjustments, no layout breaks | Yes |
| 150% | Some text may truncate with ellipsis; card heights expand | Yes |
| 175% | Significant layout stretch; accept graceful degradation | Yes |
| 200% | Accept layout degradation but maintain functionality; buttons remain tappable; navigation works | Yes |

**Rules for text scaling:**
- All text uses `sp` units (automatic scaling).
- Never hardcode text container heights -- use `minHeight` or flexible containers.
- Use `maxLines` + `TextOverflow.ellipsis` as safety nets.
- Test critical flows (onboarding, SOS) at 200% to ensure core functionality.
- Arabic at 200% is the most challenging case (already +1-2sp larger) -- test thoroughly.

---

## Section 8: Accessibility Specifications

### 8.1 Semantic Tree Structure

**Dashboard (Screen 9) Example:**

```
Scaffold
  AppBar (semanticLabel: "LOLO Home")
    Logo (decorative, excludeSemantics: true)
    NotificationBell (semanticLabel: "Notifications, {count} new")
  Body
    StreakDisplay (semanticLabel: "{count} day streak, {status}")
    StatCard (semanticLabel: "Consistency score: {score} out of 100")
    StatCard (semanticLabel: "Level: {level}")
    StatCard (semanticLabel: "XP: {current} of {needed}")
    ActionCard (semanticLabel: "{type} card. {title}. {body}. Difficulty: {n} of 3. Worth {xp} XP.")
    ReminderTile (semanticLabel: "{title}. {days} days away.")
  BottomNav (semanticLabel: "Navigation. {currentTab} selected.")
```

### 8.2 Screen Reader Announcement Patterns

| Event | Announcement |
|-------|-------------|
| Screen navigation | "{Screen name}" (auto-announced by `AppBar` title) |
| Tab switch | "{Tab name} tab, {n} of 5" |
| Action card completed | "Card completed. Plus {xp} XP earned." |
| Action card skipped | "Card skipped." |
| Streak updated | "Streak updated. {count} day streak." |
| Level up | "Congratulations! You reached level {n}: {title}." |
| XP gain | "Plus {xp} experience points." |
| Toast notification | "{variant}: {title}. {message}" |
| Message copied | "Message copied to clipboard." |
| Error | "Error: {message}" |
| Reminder due | "Reminder: {title}. Due {urgency}." |

### 8.3 Focus Order for Complex Screens

**SOS Mode (Screens 26-29):**
1. Back button
2. SOS title and description
3. Scenario tiles (top-to-bottom, start-to-end)
4. Custom scenario text field
5. Primary CTA button

**Action Card Feed (Screen 33):**
1. Back button / app bar
2. Card counter ("3 of 8 cards today")
3. Current action card (full content read)
4. Skip button
5. Save button
6. Complete button
7. Bottom navigation

### 8.4 Contrast Ratios (Verified)

| Foreground | Background | Ratio | Pass |
|-----------|-----------|:-----:|:----:|
| `#F0F6FC` (text primary) | `#0D1117` (bg primary) | 15.4:1 | AAA |
| `#F0F6FC` (text primary) | `#21262D` (card bg) | 10.9:1 | AAA |
| `#8B949E` (text secondary) | `#0D1117` (bg primary) | 5.6:1 | AA |
| `#8B949E` (text secondary) | `#21262D` (card bg) | 3.9:1 | AA (large) |
| `#4A90D9` (primary) | `#0D1117` (bg primary) | 5.1:1 | AA |
| `#C9A96E` (accent) | `#0D1117` (bg primary) | 6.3:1 | AA |
| `#F85149` (error) | `#0D1117` (bg primary) | 5.5:1 | AA |
| `#3FB950` (success) | `#0D1117` (bg primary) | 6.8:1 | AA |
| `#FFFFFF` (on primary) | `#4A90D9` (button bg) | 3.4:1 | AA (large) |
| `#1F2328` (light text) | `#FFFFFF` (light bg) | 16.0:1 | AAA |

Note: `#484F58` (text tertiary) on `#0D1117` is 2.7:1 -- intentionally below AA for decorative hints and placeholders only (WCAG-exempt).

### 8.5 Touch Target Compliance

| Component | Actual Size | Meets 48dp? | Notes |
|-----------|:----------:|:-----------:|-------|
| Primary button | 52dp height | Yes | |
| Secondary button | 52dp height | Yes | |
| Text button | 40dp height | No | Expand tap area to 48dp with padding |
| Icon button | 48dp x 48dp | Yes | |
| Chip | 32dp height | No | 48dp touch target via padding (8dp above + below) |
| Toggle | 52dp x 32dp | No | 48dp touch target via row height and padding |
| Bottom nav tab | (width/5) x 64dp | Yes | |
| Tab bar tab | 48dp height | Yes | |
| Language tile | 56dp height | Yes | |
| Reminder tile | 80dp height | Yes | |
| Action card | 320dp+ height | Yes | |
| FAB | 56dp x 56dp | Yes | |
| Close (X) button | 48dp x 48dp | Yes | |

### 8.6 Reduce Motion Preferences

When the system `AccessibilityFeatures.reduceMotion` is `true` or the LOLO "Reduce Motion" setting is enabled:

| Category | Normal | Reduced |
|----------|--------|---------|
| Page transitions | Slide/fade, 300ms | Instant cut (0ms) |
| Button press scale | Scale to 0.97 | Opacity to 0.7 |
| Skeleton shimmer | Animated gradient sweep | Static gray placeholder |
| Streak flame | Animated Rive | Static flame icon |
| Level up animation | Full celebration sequence | Simple dialog with text |
| XP float text | Float up + fade | Static toast notification |
| Card swipe | Physics-based animation | Instant swap |
| Score ring fill | Animated fill, 800ms | Instant fill |
| Pull to refresh | Spinning compass | Standard circular indicator |
| Toast slide-in | Slide from top, 300ms | Instant appear |

---

## Section 9: Design QA Checklist

### 9.1 Per-Screen QA Checklist

For each of the 43 screens, verify all items before marking the screen as design-complete:

**Visual Fidelity:**
- [ ] Background color matches token exactly (dark + light)
- [ ] All text uses correct typography token (size, weight, line height)
- [ ] All spacing follows 8dp grid (verify with layout inspector)
- [ ] Card backgrounds, borders, and radii match spec
- [ ] Icons are correct Phosphor variant (outlined default, filled active)
- [ ] Icon sizes match spec (16, 20, 24, 32, or 48dp)
- [ ] Gradients render correctly (direction, color stops)
- [ ] Elevation shadows render correctly (dark: border-based, light: shadow-based)

**Dark Mode:**
- [ ] Background layers: primary > secondary > tertiary hierarchy correct
- [ ] Text colors: primary / secondary / tertiary used correctly per spec
- [ ] No pure white (#FFFFFF) used for text (should be #F0F6FC)
- [ ] Semantic colors (success/warning/error/info) correct for dark palette

**Light Mode:**
- [ ] All token values switched to light equivalents
- [ ] Shadows visible and correctly sized
- [ ] Text colors meet contrast requirements on light backgrounds
- [ ] Accent color (#C9A96E) adjusted to #9A7B4F where specified

**RTL (Arabic):**
- [ ] Layout fully mirrored (text right-aligned, icons swapped)
- [ ] Directional icons (arrows, chevrons) point correctly
- [ ] Non-directional icons (search, check, close) do NOT mirror
- [ ] Arabic font sizes apply (+1sp body, +2sp headings)
- [ ] Arabic line heights apply (1.65x body, 1.40x+ headings)
- [ ] No negative letter-spacing on Arabic text
- [ ] Swipe directions reversed semantically
- [ ] Page transitions reverse direction
- [ ] Embedded English text (brand names, numbers) renders correctly

**Animations:**
- [ ] Page transition matches spec (type, duration, curve)
- [ ] Micro-interactions present (button press, card press, chip select)
- [ ] Feature animations play correctly (streak, XP, level-up)
- [ ] Loading state uses skeleton (not spinner)
- [ ] Reduce motion preference disables all animations

**Accessibility:**
- [ ] All interactive elements have semantic labels
- [ ] Focus order is logical (top-to-bottom, start-to-end)
- [ ] Screen reader announces screen name on navigation
- [ ] Touch targets meet 48dp minimum
- [ ] Color is never the sole indicator of state (always paired with icon/label)
- [ ] Text scales to 150% without layout breakage
- [ ] Images have `semanticLabel`

### 9.2 Cross-Screen QA Checklist

Verify these once across the entire app:

- [ ] Bottom nav state correct on every screen (active tab matches current route)
- [ ] Bottom nav badge count updates in real time
- [ ] App bar style consistent across all screens (height, font, border)
- [ ] Back navigation works correctly from every screen (no dead ends)
- [ ] Theme switching (dark/light) applies to all screens without restart
- [ ] Language switching applies to all screens without restart
- [ ] Pull-to-refresh available on all list screens
- [ ] Empty states display on all list screens when data is empty
- [ ] Error states display on all data-loading screens when API fails
- [ ] Toast notifications appear consistently across all screens
- [ ] XP gain toast appears from any XP-awarding action regardless of screen
- [ ] Streak display on dashboard updates after qualifying actions on any screen
- [ ] Keyboard does not obscure input fields on any screen
- [ ] Safe areas respected on all screens (notch, home indicator)
- [ ] No string overflow in any language (EN, AR, MS) on any screen
- [ ] Deep links resolve to correct screens with proper back stack

---

## Appendix A: Design Token Quick Reference (Flutter Constants)

```dart
// File: lib/core/theme/lolo_tokens.dart

// === COLORS ===
abstract class LoloColors {
  // Brand
  static const colorPrimary = Color(0xFF4A90D9);
  static const colorAccent = Color(0xFFC9A96E);

  // Semantic
  static const colorSuccess = Color(0xFF3FB950);
  static const colorWarning = Color(0xFFD29922);
  static const colorError = Color(0xFFF85149);
  static const colorInfo = Color(0xFF58A6FF);

  // Dark Backgrounds
  static const darkBgPrimary = Color(0xFF0D1117);
  static const darkBgSecondary = Color(0xFF161B22);
  static const darkBgTertiary = Color(0xFF21262D);
  static const darkSurfaceElevated1 = Color(0xFF282E36);
  static const darkSurfaceElevated2 = Color(0xFF30363D);

  // Light Backgrounds
  static const lightBgPrimary = Color(0xFFFFFFFF);
  static const lightBgSecondary = Color(0xFFF6F8FA);
  static const lightBgTertiary = Color(0xFFEAEEF2);

  // Dark Text
  static const darkTextPrimary = Color(0xFFF0F6FC);
  static const darkTextSecondary = Color(0xFF8B949E);
  static const darkTextTertiary = Color(0xFF484F58);
  static const darkTextDisabled = Color(0xFF30363D);

  // Light Text
  static const lightTextPrimary = Color(0xFF1F2328);
  static const lightTextSecondary = Color(0xFF656D76);
  static const lightTextTertiary = Color(0xFF8C959F);
  static const lightTextDisabled = Color(0xFFAFB8C1);

  // Borders (Dark)
  static const darkBorderDefault = Color(0xFF30363D);
  static const darkBorderMuted = Color(0xFF21262D);
  static const darkBorderAccent = Color(0xFF4A90D9);

  // Borders (Light)
  static const lightBorderDefault = Color(0xFFD0D7DE);
  static const lightBorderMuted = Color(0xFFEAEEF2);
  static const lightBorderAccent = Color(0xFF4A90D9);

  // Action Card Type Colors
  static const actionSay = Color(0xFF4A90D9);
  static const actionDo = Color(0xFF3FB950);
  static const actionBuy = Color(0xFFC9A96E);
  static const actionGo = Color(0xFF8957E5);
}

// === SPACING ===
abstract class LoloSpacing {
  static const space2xs = 4.0;
  static const spaceXs = 8.0;
  static const spaceSm = 12.0;
  static const spaceMd = 16.0;
  static const spaceLg = 20.0;
  static const spaceXl = 24.0;
  static const space2xl = 32.0;
  static const space3xl = 40.0;
  static const space4xl = 48.0;
  static const space5xl = 64.0;
}

// === RADII ===
abstract class LoloRadii {
  static const radiusSm = 4.0;
  static const radiusMd = 8.0;
  static const radiusLg = 12.0;
  static const radiusXl = 16.0;
  static const radiusPill = 24.0;
  static const radiusFull = 999.0;
}

// === DURATIONS ===
abstract class LoloDurations {
  static const instant = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 150);
  static const quick = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
  static const cinematic = Duration(milliseconds: 800);
  static const extended = Duration(milliseconds: 1500);
}

// === ICON SIZES ===
abstract class LoloIconSizes {
  static const iconSm = 16.0;
  static const iconMd = 20.0;
  static const iconStd = 24.0;
  static const iconLg = 32.0;
  static const iconXl = 48.0;
}

// === CURVES ===
abstract class LoloCurves {
  static const easeDefault = Curves.easeOutCubic;
  static const easeEnter = Curves.decelerate;
  static const easeExit = Curves.easeInCubic;
  static const easeEmphasis = Curves.easeInOutCubic;
  static const easeBounce = Curves.elasticOut; // Gamification only
}
```

## Appendix B: Gradient Definitions

```dart
// File: lib/core/theme/lolo_gradients.dart

abstract class LoloGradients {
  static const premium = LinearGradient(
    begin: Alignment(-0.7, -0.7), // 135 degrees
    end: Alignment(0.7, 0.7),
    colors: [Color(0xFF4A90D9), Color(0xFFC9A96E)],
  );

  static const sos = LinearGradient(
    begin: Alignment(-0.7, -0.7),
    end: Alignment(0.7, 0.7),
    colors: [Color(0xFFF85149), Color(0xFFD29922)],
  );

  static const achievement = LinearGradient(
    begin: Alignment(-0.7, -0.7),
    end: Alignment(0.7, 0.7),
    colors: [Color(0xFFC9A96E), Color(0xFFE8D5A3)],
  );

  static const cool = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF161B22), Color(0xFF0D1117)],
  );

  static const success = LinearGradient(
    begin: Alignment(-0.7, -0.7),
    end: Alignment(0.7, 0.7),
    colors: [Color(0xFF3FB950), Color(0xFF56D364)],
  );

  static const shimmer = LinearGradient(
    colors: [Color(0xFF21262D), Color(0xFF30363D), Color(0xFF21262D)],
    stops: [0.0, 0.5, 1.0],
  );
}
```

---

**End of Developer Handoff Document**

*This document consolidates all Phase 2 design decisions into a single implementation-ready reference. For detailed per-screen specifications, refer to the High-Fidelity Screen Specs (Parts 1, 2A, 2B). For full design system details, refer to Design System v1.0. For complete RTL guidance, refer to RTL Design Guidelines v2.0.*

*-- Lina Vazquez, Senior UX/UI Designer, LOLO*
