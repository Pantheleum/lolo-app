# LOLO RTL (Right-to-Left) Design Guidelines v2.0

### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 2.0
### Classification: Internal -- Confidential
### Dependencies: Design System v1.0, Brand Identity Guide v2.0, Localization Architecture v1.0

---

## Table of Contents

1. [Layout Mirroring Rules](#1-layout-mirroring-rules)
2. [Navigation](#2-navigation)
3. [Typography RTL](#3-typography-rtl)
4. [Component-Level RTL Specs](#4-component-level-rtl-specs)
5. [Icon Mirroring](#5-icon-mirroring)
6. [Testing Checklist](#6-testing-checklist)

---

## Preface: RTL in LOLO

LOLO supports Arabic as a first-class language. Arabic is a right-to-left (RTL) script, which means the entire UI layout mirrors horizontally compared to the English (LTR) layout. This is not optional styling -- it is a fundamental structural requirement for Arabic-speaking users.

**Key Principle:** RTL is not "flipping the screen." It is re-establishing the natural reading flow. Arabic readers scan from right to left, so the most important content, primary actions, and entry points must appear on the right side of the screen.

**Flutter Implementation:** LOLO is built with Flutter, which provides built-in RTL support through `Directionality`, `TextDirection`, and directional-aware widgets. This document specifies the design intent; developers should implement using Flutter's RTL primitives rather than manual mirroring.

**Supported RTL Locales:**
| Locale Code | Language | Script | Direction |
|-------------|----------|--------|:---------:|
| `ar` | Arabic (Modern Standard) | Arabic | RTL |
| `ar-SA` | Arabic (Saudi Arabia) | Arabic | RTL |
| `ar-AE` | Arabic (UAE) | Arabic | RTL |
| `ar-EG` | Arabic (Egypt) | Arabic | RTL |

**LTR Locales (for reference):**
| Locale Code | Language | Script | Direction |
|-------------|----------|--------|:---------:|
| `en` | English | Latin | LTR |
| `ms` | Bahasa Melayu | Latin | LTR |

---

## 1. Layout Mirroring Rules

### 1.1 What MIRRORS (Flips Horizontally in RTL)

The following elements reverse their horizontal position/direction when the app locale switches to Arabic:

| Element | LTR Behavior | RTL Behavior | Flutter Implementation |
|---------|-------------|-------------|----------------------|
| **Text alignment** | Left-aligned | Right-aligned | `TextAlign.start` (automatically resolves) |
| **Reading order** | Left to right | Right to left | Handled by `Directionality` widget |
| **Navigation flow** | Left = back, Right = forward | Right = back, Left = forward | Automatic with `MaterialApp` locale |
| **Horizontal padding/margin** | `left: X, right: Y` | `left: Y, right: X` | Use `EdgeInsetsDirectional.only(start: X, end: Y)` |
| **Row children order** | First child on left | First child on right | Automatic with `Row` when `Directionality` is RTL |
| **List item layout** | Icon on left, text on right | Icon on right, text on left | Use `ListTile` (auto-mirrors) |
| **Horizontal scroll initial position** | Starts at left | Starts at right | Automatic with `ListView` |
| **Icon + text pairs** | Icon left of text | Icon right of text | Use `TextDirection`-aware `Row` |
| **Checkbox/Radio + label** | Checkbox on left, label on right | Checkbox on right, label on left | Use `CheckboxListTile` (auto-mirrors) |
| **Leading/trailing icons** | Leading = left, Trailing = right | Leading = right, Trailing = left | `AppBar` leading/trailing auto-mirrors |
| **FAB position** | Bottom-right | Bottom-left | Use `FloatingActionButton` with `endFloat` (resolves directionally) |
| **Drawer anchor** | Opens from left | Opens from right | Automatic with `Scaffold.drawer` |
| **Tooltip arrow** | Points left or right contextually | Mirrors | Automatic with Flutter's `Tooltip` |
| **Stepper** | Steps progress left to right | Steps progress right to left | Use `Stepper` (auto-mirrors) |
| **Breadcrumbs/chevrons** | Home > Section > Page | Home < Section < Page (with mirrored chevrons) | Custom -- requires manual mirroring |
| **Swipe gestures** | Swipe right = back | Swipe left = back | Use `Directionality`-aware gesture detectors |
| **Card layout (horizontal)** | Image left, content right | Image right, content left | Use directional alignment |
| **Horizontal dividers with text** | Text left of divider | Text right of divider | Use `TextDirection`-aware layout |
| **Indent/nesting** | Indented from left | Indented from right | Use `EdgeInsetsDirectional.only(start: indent)` |

### 1.2 What Does NOT Mirror

These elements maintain their LTR-orientation regardless of the app locale:

| Element | Reason | Implementation Note |
|---------|--------|-------------------|
| **Media playback controls** | Play/pause/skip are universal. Users expect play to point right (>) everywhere. | Hardcode LTR for media control rows |
| **Phone number fields** | Phone numbers are always written left-to-right, even in Arabic contexts. The digits read 01234, not 43210. | Set `TextDirection.ltr` on phone input fields |
| **Clock faces (analog)** | Clocks are universally clockwise. | No mirroring needed |
| **Progress bars representing time** | Time moves forward (left to right) universally. A timeline, music playback progress, or video seek bar should not mirror. | Hardcode LTR for temporal progress indicators |
| **Brand logos** | The LOLO Compass mark and wordmark are never mirrored. Logos are fixed visual assets. | Wrap logos in `Directionality(textDirection: TextDirection.ltr)` |
| **Graphs/Charts with X-axis as time** | Time-series data reads left (past) to right (future) universally. | Hardcode LTR for time-axis charts |
| **Slashes in dates** | "14/02/2026" reads left-to-right even in Arabic. | BiDi algorithm handles this, but verify |
| **URLs and email addresses** | Always LTR, even when embedded in Arabic text. | BiDi algorithm handles this automatically |
| **Mathematical operators** | "2 + 3 = 5" reads left-to-right. | BiDi algorithm handles this |
| **Music notation** | If ever displayed, reads left-to-right. | N/A for LOLO currently |
| **Credit card number fields** | Always LTR. | Set `TextDirection.ltr` |
| **International currency codes** | "SAR 150" -- the code is always LTR. | BiDi isolation for currency |
| **Rating stars** | Stars fill from left to right (1 star on left, 5 on right) regardless of locale. | Hardcode LTR for star rating widgets |
| **Toggle switch animation** | The "on" position is always right, "off" is always left. | No mirroring for toggle thumb position |

### 1.3 Partial Mirroring -- Bidirectional Content

When Arabic text contains embedded English words, numbers, or LTR content, the Unicode Bidirectional Algorithm (BiDi) handles the display. However, certain cases require explicit design guidance.

**Case 1: Arabic Paragraph with English Words**

```
RTL rendering of: "أحبها أكثر من كل الـ love songs"

Visual display (what the user sees):
love songs أحبها أكثر من كل الـ
←——————  RTL  ——————→  ←LTR→
```

The English words "love songs" appear on the left side of the line, rendered in their natural LTR order, while the Arabic text flows from right to left. This is handled automatically by the BiDi algorithm.

**Design Rule:** Always use `TextDirection` from the locale context. Never force a single direction on mixed-content paragraphs.

**Case 2: Arabic Label + English Value**

```
LTR:  Email: ahmed@example.com
RTL:  ahmed@example.com :البريد الإلكتروني

The label is right-aligned (Arabic), the value is left-aligned (English email).
```

**Implementation:** Use a `Row` with `MainAxisAlignment.spaceBetween`. The label uses `TextDirection.rtl`, the value uses `TextDirection.ltr`. The Row itself follows the parent `Directionality`.

**Case 3: Mixed Number Formats in Arabic Text**

```
Arabic sentence with Western numerals:
"لديك 15 تذكيراً"  (You have 15 reminders)

Arabic sentence with Arabic-Indic numerals:
"لديك ١٥ تذكيراً"  (You have 15 reminders)
```

**LOLO's Decision:** Use **Western numerals (0123456789)** as the default for Arabic locales. Arabic-Indic numerals (٠١٢٣٤٥٦٧٨٩) are offered as a user preference toggle in Settings > Display. Rationale: Western numerals are standard in technology contexts across the Arab world, and mixing numeral systems creates cognitive friction.

**Case 4: Charts and Data Visualizations**

| Chart Type | Mirroring Rule |
|-----------|---------------|
| Bar chart (vertical bars, categories on X-axis) | Category order mirrors (first category on right) |
| Bar chart (horizontal bars) | Bars grow from right to left (longest bar extends leftward) |
| Line chart (time-series X-axis) | Does NOT mirror. Time is always left-to-right. |
| Pie/donut chart | Does NOT mirror. Reading order of legend mirrors. |
| Progress bar (completion %) | Mirrors. 0% on right, 100% on left. |
| Progress bar (time elapsed) | Does NOT mirror. Time is always left-to-right. |

**Case 5: Bidirectional Text in Notifications**

Notification text that mixes Arabic and English must be tested thoroughly. Example:

```
Notification title (Arabic): "تذكير: عيد ميلاد سارة"
Notification body (Arabic with app name): "LOLO يذكرك: 3 أيام متبقية"
```

The app name "LOLO" in the notification body is an LTR island within RTL text. The BiDi algorithm places it correctly, but QA must verify on actual devices (Samsung, Huawei, Pixel) since notification rendering varies by manufacturer.

---

## 2. Navigation

### 2.1 Bottom Navigation Bar

The bottom navigation bar is LOLO's primary navigation element. It contains 5 tabs.

**LTR Tab Order (English / Malay):**

```
+---------------------------------------------------+
| [Home]  [Reminders]  [Messages]  [Gifts]  [More] |
|   1st      2nd         3rd        4th       5th   |
+---------------------------------------------------+
← Reading direction: Left to Right →
Home is leftmost (first in reading order)
```

**RTL Tab Order (Arabic):**

```
+---------------------------------------------------+
| [More]  [Gifts]  [Messages]  [Reminders]  [Home] |
|  5th      4th       3rd         2nd         1st   |
+---------------------------------------------------+
← Reading direction: Right to Left →
Home is rightmost (first in reading order)
```

**Implementation:**
- Flutter's `BottomNavigationBar` automatically mirrors tab order when `Directionality` is RTL.
- The `items` list order in code remains the same; the framework handles visual reordering.
- Active tab indicator (underline or filled icon) follows the selected tab regardless of position.
- Tab press targets remain the same size and position relative to the visual tab.

### 2.2 App Bar

| Element | LTR | RTL | Notes |
|---------|-----|-----|-------|
| Back arrow icon | Left side, points left (←) | Right side, points right (→) | Use `Icons.arrow_back` (Flutter auto-mirrors to `arrow_back_ios` direction) |
| Title text | Left-aligned (after back arrow) | Right-aligned (after back arrow on right) | Use `AppBar` default alignment (auto-mirrors) |
| Action icons | Right side | Left side | Use `AppBar.actions` (auto-mirrors) |
| Logo mark (when shown) | Left side (replacing back arrow on home) | Right side | Use `AppBar.leading` |
| Search field | Expands left-to-right | Expands right-to-left | Use directional-aware animation |
| Overflow menu (3 dots) | Rightmost action | Leftmost action | Automatic |

**AppBar Example:**

```
LTR:
+---------------------------------------------------+
| [←]  Screen Title                    [🔍] [⋮]    |
+---------------------------------------------------+

RTL:
+---------------------------------------------------+
| [⋮] [🔍]                    عنوان الشاشة  [→]    |
+---------------------------------------------------+
```

### 2.3 Navigation Drawer

| Property | LTR | RTL |
|----------|-----|-----|
| Anchor edge | Left side of screen | Right side of screen |
| Open gesture | Swipe right from left edge | Swipe left from right edge |
| Close gesture | Swipe left or tap scrim | Swipe right or tap scrim |
| Menu items | Left-aligned with left icon | Right-aligned with right icon |
| Header content | Left-aligned | Right-aligned |
| Close button (X) | Top-right of drawer | Top-left of drawer |

**Implementation:**
- Use `Scaffold.drawer` for the primary drawer. Flutter automatically anchors it based on `Directionality`.
- Use `Scaffold.endDrawer` only for secondary drawers that should appear on the opposite side.
- The drawer width remains the same: 304dp (Material 3 specification).

### 2.4 Tab Bars (Horizontal)

Tab bars within screens (e.g., filter tabs, category tabs) follow the same mirroring principle as bottom navigation.

**LTR:**
```
+---------------------------------------------------+
| [All]  [Upcoming]  [Overdue]  [Completed]         |
+---------------------------------------------------+
  ^^^^
  First tab (selected by default)
```

**RTL:**
```
+---------------------------------------------------+
|         [مكتمل]  [متأخر]  [قادم]  [الكل]         |
+---------------------------------------------------+
                                      ^^^^
                            First tab (selected by default)
```

**Scrollable Tab Bars:**
- Initial scroll position in RTL: scrolled to the rightmost position (showing the first tab).
- Scroll direction inverts: swiping left reveals more tabs in RTL (vs swiping right in LTR).
- The tab indicator (underline) moves directionally under the selected tab.

### 2.5 Swipe Gestures

| Gesture | LTR Meaning | RTL Meaning |
|---------|------------|------------|
| Swipe right | Go back / dismiss | Go forward / reveal next |
| Swipe left | Go forward / reveal next | Go back / dismiss |
| Swipe right on list item | Primary action (e.g., complete) | Secondary action (e.g., delete) |
| Swipe left on list item | Secondary action (e.g., delete) | Primary action (e.g., complete) |
| Swipe right from screen edge | Open drawer | Close drawer (or navigate forward) |
| Swipe left from screen edge | Close drawer (or navigate forward) | Open drawer |

**Implementation:**
- Use `Dismissible` with `DismissDirection.startToEnd` and `DismissDirection.endToStart` -- these resolve directionally.
- Do NOT use `DismissDirection.horizontal` unless the action is the same in both directions.
- Page transitions: use `PageRouteBuilder` with directional slide animations. New pages slide in from the end (right in LTR, left in RTL).

### 2.6 Page Transitions

| Transition | LTR | RTL |
|-----------|-----|-----|
| Push (navigate forward) | New page slides in from right | New page slides in from left |
| Pop (navigate back) | Current page slides out to right | Current page slides out to left |
| Drawer open | Slides in from left | Slides in from right |
| Bottom sheet open | Slides up from bottom | Slides up from bottom (no horizontal change) |
| Dialog open | Fade in / scale up | Fade in / scale up (no horizontal change) |

---

## 3. Typography RTL

### 3.1 Arabic Text Properties

**Line Height:**
Arabic text requires taller line heights than Latin text due to diacritical marks (dots above/below letters, tashkeel marks) and the cursive connected nature of the script.

| Property | Latin (EN/MS) | Arabic (AR) | Difference |
|----------|:------------:|:-----------:|:----------:|
| Body line height | 1.50x | 1.65x | +0.15x |
| Heading line height | 1.25x - 1.40x | 1.40x - 1.50x | +0.10x to +0.15x |
| Caption line height | 1.33x | 1.54x | +0.21x |
| Minimum line height | 1.25x | 1.40x | +0.15x |

**Font Size Adjustments:**
Arabic text at the same sp value as Latin text appears smaller due to different x-height ratios and glyph density. LOLO compensates with a +2sp offset for body text and +2sp for headings.

| Style | English Size | Arabic Size | Delta |
|-------|:-----------:|:-----------:|:-----:|
| H1 / Display | 32sp | 34sp | +2sp |
| H2 / Headline | 24sp | 26sp | +2sp |
| H3 / Title Large | 20sp | 22sp | +2sp |
| H4 / Title Medium | 18sp | 20sp | +2sp |
| H5 / Title Small | 16sp | 18sp | +2sp |
| H6 / Label Large | 14sp | 16sp | +2sp |
| Body 1 | 16sp | 17sp | +1sp |
| Body 2 | 14sp | 15sp | +1sp |
| Caption | 12sp | 13sp | +1sp |
| Button | 14sp | 15sp | +1sp |
| Overline | 11sp | 12sp | +1sp |

**Minimum Arabic Body Size: 16sp.** Arabic body text must never be rendered below 16sp. The connected cursive script becomes illegible at smaller sizes on mobile screens. If the English equivalent is 14sp Body 2, the Arabic version is 15sp -- which still meets the 16sp minimum when rounded up for rendering.

### 3.2 Mixed Content: BiDi Algorithm Handling

When Arabic paragraphs contain English words, the Unicode Bidirectional Algorithm (BiDi, UAX #9) determines the visual ordering. However, developers and designers must understand the algorithm's behavior to avoid layout bugs.

**Base Direction:**
- Set the paragraph's base direction to RTL for Arabic content using `TextDirection.rtl`.
- The BiDi algorithm then correctly places LTR runs (English words, numbers, URLs) within the RTL flow.

**Common Scenarios:**

**Scenario 1: Arabic sentence with an English name**
```
Logical order (in code):  "مرحباً يا Sarah"
Visual display:           "Sarah مرحباً يا"
                          ←—RTL—→ ←LTR→
```

**Scenario 2: Arabic sentence with a number**
```
Logical order:  "لديك 7 رسائل جديدة"
Visual display: "لديك 7 رسائل جديدة"  (number stays in place -- European numbers are weak RTL)
```

**Scenario 3: Arabic sentence with an English phrase**
```
Logical order:  "قم بتفعيل Smart Reminders لتحسين تجربتك"
Visual display: "قم بتفعيل Smart Reminders لتحسين تجربتك"
                ←——RTL——→  ←———LTR———→   ←——RTL——→
```

**Scenario 4: Problematic case -- Arabic text ending with LTR**
```
Logical order:  "أرسل رسالة عبر WhatsApp"
Visual display: "WhatsApp أرسل رسالة عبر"  (WhatsApp moves to the visual start of the line)
```

To force the correct visual order when the algorithm produces unexpected results, use **Unicode directional markers:**
- `\u200F` (Right-to-Left Mark, RLM) -- forces RTL context
- `\u200E` (Left-to-Right Mark, LRM) -- forces LTR context
- `\u2068` (First Strong Isolate) -- isolates an embedded direction
- `\u2069` (Pop Directional Isolate) -- ends isolation

**Design Rule for LOLO:** All Arabic UI strings that contain embedded brand names (LOLO, WhatsApp, Google, etc.) must be tested for correct BiDi rendering. If the visual order is incorrect, the localization file should include appropriate directional markers.

### 3.3 Number Display

**Default: Western Numerals (0123456789)**

LOLO uses Western (European) numerals as the default for all Arabic locales. This decision is based on:
1. Western numerals are standard in technology, banking, and telecommunications across the Arab world
2. Mixing numeral systems creates cognitive friction
3. Most Arabic mobile OS keyboards default to Western numerals

**Optional: Arabic-Indic Numerals (٠١٢٣٤٥٦٧٨٩)**

Users can enable Arabic-Indic numerals via Settings > Display > Number Format. When enabled:

| Western | Arabic-Indic | Name |
|:-------:|:-----------:|------|
| 0 | ٠ | sifr |
| 1 | ١ | wahid |
| 2 | ٢ | ithnan |
| 3 | ٣ | thalatha |
| 4 | ٤ | arba'a |
| 5 | ٥ | khamsa |
| 6 | ٦ | sitta |
| 7 | ٧ | sab'a |
| 8 | ٨ | thamaniya |
| 9 | ٩ | tis'a |

**Number Display Contexts:**

| Context | Default (Western) | Arabic-Indic (if enabled) | Notes |
|---------|:-----------------:|:------------------------:|-------|
| Dates | 14/02/2026 | ١٤/٠٢/٢٠٢٦ | Slash separators remain |
| Times | 09:30 AM | ٠٩:٣٠ ص | AM/PM becomes ص/م |
| XP counts | +15 XP | +١٥ XP | "XP" stays Latin |
| Streak counts | 7 days | ٧ أيام | "days" in Arabic |
| Prices | SAR 150 | SAR ١٥٠ | Currency code stays Latin |
| Phone numbers | +966 55 123 4567 | +٩٦٦ ٥٥ ١٢٣ ٤٥٦٧ | Debatable -- may keep Western for clarity |
| Countdown | 3 days left | ٣ أيام متبقية | |
| Percentages | 85% | ٨٥٪ | Arabic percent sign ٪ (U+066A) |

**Phone Numbers Exception:** Phone number fields always display Western numerals regardless of user preference. Phone numbers are technical identifiers that must be unambiguous across systems.

### 3.4 Punctuation in Arabic

Arabic uses different punctuation characters than Latin text. The localization system must use the correct Unicode characters.

| Purpose | English | Arabic | Unicode | Notes |
|---------|:-------:|:------:|:-------:|-------|
| Comma | , (U+002C) | ، (U+060C) | Arabic Comma | Mirrored position |
| Semicolon | ; (U+003B) | ؛ (U+061B) | Arabic Semicolon | |
| Question mark | ? (U+003F) | ؟ (U+061F) | Arabic Question Mark | Mirrored direction |
| Period | . (U+002E) | . (U+002E) | Same | No Arabic-specific period |
| Exclamation | ! (U+0021) | ! (U+0021) | Same | No Arabic-specific exclamation |
| Colon | : (U+003A) | : (U+003A) | Same | No Arabic-specific colon |
| Quotation (open) | " (U+201C) | « (U+00AB) | Left Guillemet | Or use " |
| Quotation (close) | " (U+201D) | » (U+00BB) | Right Guillemet | Or use " |
| Parentheses | ( ) | ( ) | Same | BiDi algorithm handles mirroring |
| Ellipsis | ... | ... | Same | |
| Decimal point | . | ٫ (U+066B) | Arabic Decimal | When Arabic-Indic enabled |
| Thousands separator | , | ٬ (U+066C) | Arabic Thousands | When Arabic-Indic enabled |

**Punctuation Placement Rule:** In Arabic text, sentence-ending punctuation appears at the end of the text (which is the leftmost position visually, since Arabic reads right-to-left). The BiDi algorithm handles this automatically, but verify in testing.

---

## 4. Component-Level RTL Specs

### 4.1 Button

**Primary Button (Filled):**

```
LTR:                              RTL:
+---------------------------+     +---------------------------+
| [icon]  Button Label      |     |      تسمية الزر  [icon]  |
+---------------------------+     +---------------------------+
```

| Property | LTR Value | RTL Value | Flutter Widget Property |
|----------|-----------|-----------|------------------------|
| Text alignment | Center | Center | `TextAlign.center` (no change) |
| Icon position | Leading (left) | Leading (right) | `icon` parameter of `ElevatedButton.icon` (auto-mirrors) |
| Padding | `EdgeInsets.symmetric(h: 24, v: 12)` | Same | Symmetric padding does not mirror |
| Internal gap (icon to text) | 8dp | 8dp | No change |
| Full-width button | Stretches to container width | Same | No change |

**Button with trailing icon (e.g., "Next →"):**

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Icon | Right of text (→) | Left of text (←) | Use `Directionality`-aware Row. Icon mirrors (see Section 5). |
| Padding | `EdgeInsetsDirectional(start: 24, end: 16)` | Resolves to `(start: 24, end: 16)` = right 24, left 16 | `EdgeInsetsDirectional` |

### 4.2 Card

**Standard Card (Image + Content):**

```
LTR:
+---------------------------------------------------+
| +--------+  Card Title                             |
| |        |  Description text that may              |
| | Image  |  wrap to multiple lines                 |
| |        |  [Action Button]                        |
| +--------+                                         |
+---------------------------------------------------+

RTL:
+---------------------------------------------------+
|                             عنوان البطاقة  +--------+ |
|             نص الوصف الذي قد يمتد إلى     |        | |
|                      عدة أسطر             | صورة   | |
|                        [زر الإجراء]        |        | |
|                                           +--------+ |
+---------------------------------------------------+
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Image position | Left | Right | Use `Row` with `Directionality` |
| Text alignment | Start (left) | Start (right) | `TextAlign.start` |
| Content padding | `EdgeInsetsDirectional(start: 16, end: 12)` | Resolves to right 16, left 12 | `EdgeInsetsDirectional` |
| Action button alignment | Start (left) or end (right) | Mirrors | `Align(alignment: AlignmentDirectional.centerStart)` |
| Card corner radius | 12dp all corners | Same (symmetric) | `BorderRadius.circular(12)` |
| Card elevation/border | Same | Same | No directional change |

**Vertical Card (Image on top):**
Vertical cards do NOT mirror -- the image stays on top and content stays on bottom. Only the text alignment within the card mirrors.

### 4.3 Input Field (TextField)

```
LTR:
+---------------------------------------------------+
| [🔍]  Search reminders...                    [X]  |
+---------------------------------------------------+
  ↑ leading icon            placeholder        ↑ trailing icon (clear)

RTL:
+---------------------------------------------------+
| [X]  ...البحث في التذكيرات                   [🔍] |
+---------------------------------------------------+
  ↑ trailing icon (clear)   placeholder    ↑ leading icon
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Text direction | Left-to-right | Right-to-left | `TextDirection` from locale |
| Text alignment | Start (left) | Start (right) | `TextAlign.start` |
| Cursor position (initial) | Left edge | Right edge | Automatic |
| Leading icon (prefix) | Left | Right | `InputDecoration.prefixIcon` (auto-mirrors) |
| Trailing icon (suffix) | Right | Left | `InputDecoration.suffixIcon` (auto-mirrors) |
| Helper text | Below, start-aligned | Below, start-aligned (right) | `TextAlign.start` |
| Error text | Below, start-aligned | Below, start-aligned (right) | `TextAlign.start` |
| Label (floating) | Start-aligned | Start-aligned (right) | Automatic |
| Counter text | End-aligned (right) | End-aligned (left) | Automatic |
| Content padding | `EdgeInsetsDirectional(start: 16, end: 12)` | Resolves directionally | `EdgeInsetsDirectional` |

**Special Input Fields:**

| Field Type | RTL Behavior | Reason |
|-----------|-------------|--------|
| Phone number | Always LTR text direction | Phone numbers are universal LTR |
| Email address | Always LTR text direction | Email is universal LTR |
| URL | Always LTR text direction | URLs are universal LTR |
| Password | Always LTR text direction | Passwords are typically LTR |
| Name (Arabic) | RTL text direction | Arabic names are RTL |
| Search (Arabic) | RTL text direction | User input follows locale |
| Credit card | Always LTR text direction | Card numbers are universal LTR |

### 4.4 List Item

```
LTR:
+---------------------------------------------------+
| [Avatar]  Title Text                    [Chevron>] |
|           Subtitle / description text              |
+---------------------------------------------------+

RTL:
+---------------------------------------------------+
| [<Chevron]                    نص العنوان  [صورة]  |
|              نص العنوان الفرعي / الوصف             |
+---------------------------------------------------+
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Leading widget | Left | Right | `ListTile.leading` (auto-mirrors) |
| Trailing widget | Right | Left | `ListTile.trailing` (auto-mirrors) |
| Title alignment | Start (left) | Start (right) | Automatic |
| Subtitle alignment | Start (left) | Start (right) | Automatic |
| Content padding | `EdgeInsetsDirectional(start: 16, end: 16)` | Resolves | `EdgeInsetsDirectional` |
| Chevron direction | Points right (>) | Points left (<) | Use mirroring icon (see Section 5) |
| Swipe actions | Right swipe = primary | Left swipe = primary | `DismissDirection.startToEnd` |
| Divider indent | Start (left) indent | Start (right) indent | `EdgeInsetsDirectional.only(start: 72)` |

### 4.5 Bottom Sheet

```
LTR:
+---------------------------------------------------+
|                  [Drag Handle]                     |
|                                                    |
|  Sheet Title                                       |
|  Description or content text                       |
|                                                    |
|  +---------------------------------------------+  |
|  | Option 1                             [icon]  |  |
|  +---------------------------------------------+  |
|  | Option 2                             [icon]  |  |
|  +---------------------------------------------+  |
|                                                    |
|  [           Primary Action Button           ]     |
+---------------------------------------------------+

RTL:
+---------------------------------------------------+
|                  [مقبض السحب]                      |
|                                                    |
|                                   عنوان الورقة     |
|                          نص الوصف أو المحتوى       |
|                                                    |
|  +---------------------------------------------+  |
|  | [icon]                             الخيار ١  |  |
|  +---------------------------------------------+  |
|  | [icon]                             الخيار ٢  |  |
|  +---------------------------------------------+  |
|                                                    |
|  [           زر الإجراء الرئيسي              ]     |
+---------------------------------------------------+
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Drag handle | Center | Center | No change |
| Title alignment | Start (left) | Start (right) | `TextAlign.start` |
| Content alignment | Start (left) | Start (right) | `CrossAxisAlignment.start` |
| Close button (X) | Top-right | Top-left | `AlignmentDirectional.topEnd` |
| Option list items | Standard list item mirroring | See List Item spec | Use `ListTile` |
| Sheet enters from | Bottom | Bottom | No horizontal change |
| Sheet padding | `EdgeInsetsDirectional(start: 24, end: 24)` | Same (symmetric) | Symmetric = no visual change |
| Corner radius | Top-left and top-right: 16dp | Same | No change |

### 4.6 Dialog

```
LTR:
+---------------------------------------+
|                                       |
|  Dialog Title                         |
|                                       |
|  Dialog body text explaining the      |
|  action the user is about to take.    |
|                                       |
|              [Cancel]  [Confirm]      |
|                                       |
+---------------------------------------+

RTL:
+---------------------------------------+
|                                       |
|                         عنوان الحوار   |
|                                       |
|  نص الحوار الذي يشرح الإجراء الذي     |
|  سيقوم به المستخدم.                   |
|                                       |
|              [تأكيد]  [إلغاء]         |
|                                       |
+---------------------------------------+
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Title alignment | Start (left) | Start (right) | Automatic in `AlertDialog` |
| Body alignment | Start (left) | Start (right) | `TextAlign.start` |
| Action buttons order | Secondary (Cancel) left, Primary (Confirm) right | Secondary (Cancel) right, Primary (Confirm) left | Flutter `AlertDialog.actions` auto-mirrors; end = primary |
| Dialog padding | 24dp all sides | Same | Symmetric, no change |
| Dialog width | Min 280dp, max 560dp | Same | No change |
| Dialog corner radius | 28dp (Material 3) | Same | No change |
| Close button (X) if present | Top-right | Top-left | `AlignmentDirectional.topEnd` |

**Critical Dialog Rule:** The primary (destructive or confirmative) action button is always at the **end** position. In LTR, end = right. In RTL, end = left. This keeps the primary action in the "forward" direction of the reading flow.

### 4.7 Chip

```
LTR:
+---------------------------+
| [icon]  Chip Label   [X]  |
+---------------------------+

RTL:
+---------------------------+
| [X]   تسمية الشريحة [icon] |
+---------------------------+
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Avatar/leading icon | Left | Right | `Chip.avatar` (auto-mirrors) |
| Delete icon (X) | Right | Left | `Chip.onDeleted` / `deleteIcon` (auto-mirrors) |
| Label alignment | Center | Center | No change |
| Padding | `EdgeInsets.symmetric(h: 12, v: 6)` | Same | Symmetric, no change |
| Chip spacing in Wrap | Start-aligned | Start-aligned (right) | `WrapAlignment.start` (auto-mirrors) |

### 4.8 Toggle / Switch

```
LTR:
+---------------------------------------------------+
| Toggle Label                        [====( O )]   |
|                                      OFF    ON     |

RTL:
+---------------------------------------------------+
| [( O )====]                          تسمية التبديل |
|  ON    OFF                                         |
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Label position | Left of toggle | Right of toggle | `SwitchListTile` (auto-mirrors) |
| Toggle position | Right of label | Left of label | Automatic |
| Thumb position (ON) | Right side of track | Right side of track | Does NOT mirror -- ON is always right |
| Thumb position (OFF) | Left side of track | Left side of track | Does NOT mirror -- OFF is always left |
| Toggle animation | Slides right for ON | Slides right for ON | Does NOT mirror |

**Important:** The toggle switch itself (the track and thumb) does NOT mirror. The "on" position is universally on the right side of the track. Only the label-to-toggle spatial relationship mirrors.

### 4.9 Slider

```
LTR:
+---------------------------------------------------+
| Slider Label                                       |
| [Min]----=====(O)==================-------[Max]    |
|  0                                          100    |

RTL:
+---------------------------------------------------+
|                                    تسمية المنزلق    |
| [Max]-------==================(O)=====----[Min]    |
|  100                                          0    |
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Minimum position | Left | Right | Automatic with `Slider` and RTL `Directionality` |
| Maximum position | Right | Left | Automatic |
| Thumb drag direction | Right = increase | Left = increase | Automatic |
| Label alignment | Start | Start (right) | `TextAlign.start` |
| Value label position | Above thumb | Above thumb | No horizontal change |

**Exception -- Volume/Brightness Sliders:** If LOLO ever implements volume or brightness controls, these should NOT mirror. Increasing volume/brightness by sliding right is a universal convention.

### 4.10 Dropdown / Select Menu

```
LTR:
+---------------------------------------------------+
| Selected Value                              [▼]    |
+---------------------------------------------------+
| Option 1                                           |
| Option 2 (selected)                         [✓]    |
| Option 3                                           |
+---------------------------------------------------+

RTL:
+---------------------------------------------------+
| [▼]                                   القيمة المختارة |
+---------------------------------------------------+
|                                           الخيار ١  |
| [✓]                              الخيار ٢ (مختار)  |
|                                           الخيار ٣  |
+---------------------------------------------------+
```

| Property | LTR | RTL | Implementation |
|----------|-----|-----|---------------|
| Dropdown arrow | Right | Left | `DropdownButton` (auto-mirrors) |
| Selected value text | Start (left) | Start (right) | `TextAlign.start` |
| Option text alignment | Start (left) | Start (right) | Automatic |
| Check mark (selected) | Right | Left | Trailing position mirrors |
| Menu alignment | Aligns to start of button | Aligns to start of button (right) | Automatic |
| Padding | `EdgeInsetsDirectional(start: 16, end: 12)` | Resolves directionally | `EdgeInsetsDirectional` |

### 4.11 EdgeInsetsDirectional vs EdgeInsets Reference

**When to use `EdgeInsetsDirectional`:**
- Any padding or margin where left/right values differ
- Content padding in text containers
- List item indentation
- Card content offsets
- Any asymmetric horizontal spacing

**When `EdgeInsets` is fine (no directional difference):**
- Symmetric padding: `EdgeInsets.symmetric(horizontal: X, vertical: Y)`
- All-sides equal: `EdgeInsets.all(X)`
- Vertical-only: `EdgeInsets.symmetric(vertical: X)`

**Quick Reference Table:**

| Use Case | Widget Property | Use Directional? |
|----------|----------------|:----------------:|
| `Padding` around text content | `padding` | YES |
| `Container` margin | `margin` | YES (if asymmetric) |
| `ListTile` content padding | `contentPadding` | YES |
| `Card` margin | `margin` | YES (if asymmetric) |
| `AlertDialog` padding | `contentPadding` | Usually symmetric -- NO |
| `AppBar` title padding | `titleSpacing` | Automatic |
| `TextField` content padding | `contentPadding` | YES |
| `Chip` padding | `padding` | Usually symmetric -- NO |
| `BottomSheet` padding | Custom | YES (if asymmetric) |
| Global scaffold padding | `body` padding | YES |

### 4.12 TextDirection-Aware Alignment Reference

| Flutter Alignment | Directional Equivalent | Notes |
|------------------|----------------------|-------|
| `Alignment.centerLeft` | `AlignmentDirectional.centerStart` | Use directional version |
| `Alignment.centerRight` | `AlignmentDirectional.centerEnd` | Use directional version |
| `Alignment.topLeft` | `AlignmentDirectional.topStart` | Use directional version |
| `Alignment.topRight` | `AlignmentDirectional.topEnd` | Use directional version |
| `Alignment.bottomLeft` | `AlignmentDirectional.bottomStart` | Use directional version |
| `Alignment.bottomRight` | `AlignmentDirectional.bottomEnd` | Use directional version |
| `Alignment.center` | `AlignmentDirectional.center` | Same -- no directional difference |
| `Alignment.topCenter` | `AlignmentDirectional.topCenter` | Same -- no directional difference |
| `Alignment.bottomCenter` | `AlignmentDirectional.bottomCenter` | Same -- no directional difference |
| `CrossAxisAlignment.start` | Already directional | Auto-mirrors in RTL |
| `CrossAxisAlignment.end` | Already directional | Auto-mirrors in RTL |
| `MainAxisAlignment.start` | Already directional | Auto-mirrors in RTL |
| `MainAxisAlignment.end` | Already directional | Auto-mirrors in RTL |
| `TextAlign.left` | `TextAlign.start` | ALWAYS use `.start` instead of `.left` |
| `TextAlign.right` | `TextAlign.end` | ALWAYS use `.end` instead of `.right` |

**Critical Rule:** Never use `Alignment.centerLeft`, `Alignment.topRight`, etc. in production code. Always use `AlignmentDirectional` equivalents. The only exception is when an element explicitly must NOT mirror (e.g., a media player control bar).

---

## 5. Icon Mirroring

### 5.1 Icons That MUST Mirror in RTL

These icons have inherent directionality -- they point "forward" or "backward" and must flip to match the reading direction.

| Icon Name | LTR Appearance | RTL Appearance | Reason |
|-----------|:-------------:|:--------------:|--------|
| `arrow_back` | ← (points left) | → (points right) | "Back" is toward the start of reading |
| `arrow_forward` | → (points right) | ← (points left) | "Forward" is toward the end of reading |
| `arrow_back_ios` | < (chevron left) | > (chevron right) | iOS-style back arrow |
| `arrow_forward_ios` | > (chevron right) | < (chevron left) | iOS-style forward arrow |
| `chevron_left` | < | > | Navigation direction |
| `chevron_right` | > | < | Navigation direction |
| `send` | → (arrow right) | ← (arrow left) | Sending is "forward" |
| `reply` | ↰ (curves left) | ↱ (curves right) | Reply goes "back" |
| `reply_all` | ↰↰ | ↱↱ | Same as reply |
| `forward` (email) | ↱ (curves right) | ↰ (curves left) | Forward goes "ahead" |
| `undo` | ↺ (curves left) | ↻ (curves right) | Undo = backward |
| `redo` | ↻ (curves right) | ↺ (curves left) | Redo = forward |
| `list` (bulleted) | Bullets on left | Bullets on right | List indent follows reading |
| `format_list_bulleted` | Bullets on left | Bullets on right | Same |
| `format_list_numbered` | Numbers on left | Numbers on right | Same |
| `format_indent_increase` | Indent right | Indent left | Indent = forward |
| `format_indent_decrease` | Indent left | Indent right | Outdent = backward |
| `navigate_before` | < | > | Navigation direction |
| `navigate_next` | > | < | Navigation direction |
| `first_page` | |< | >| | Jump to start |
| `last_page` | >| | |< | Jump to end |
| `open_in_new` | ↗ (top-right) | ↖ (top-left) | "Out" goes to reading end |
| `launch` | ↗ | ↖ | Same as open_in_new |
| `exit_to_app` | → with line | ← with line | Exit direction |
| `trending_flat` | → | ← | Directional arrow |
| `keyboard_tab` | →| | |← | Tab direction |
| `subdirectory_arrow_right` | ↳ | ↲ | Sub-item direction |
| `text_rotation_none` | Horizontal L→R | Horizontal R→L | Text direction indicator |
| `wrap_text` | Lines left-aligned | Lines right-aligned | Text alignment indicator |
| `short_text` | Lines left-aligned | Lines right-aligned | Text alignment indicator |
| `notes` | Lines left-aligned | Lines right-aligned | Text/content indicator |
| `segment` | Left-to-right | Right-to-left | Directional |
| `assistant_direction` | Points right | Points left | Navigation |
| `call_made` | ↗ | ↖ | Outgoing call arrow |
| `call_received` | ↙ | ↘ | Incoming call arrow |
| `call_missed` | ↗ with line | ↖ with line | Missed call direction |

**Flutter Implementation:**
Flutter's Material Icons automatically mirror when using `Icon` within a `Directionality` RTL context -- but only if the icon is in the "auto-mirror" set. For custom icons, use `matchTextDirection: true` on the `Icon` widget:

```dart
Icon(
  Icons.arrow_forward,
  textDirection: Directionality.of(context),
)
// Or for custom icons:
ImageIcon(
  AssetImage('assets/icons/custom_arrow.png'),
  matchTextDirection: true,  // This enables auto-mirroring
)
```

### 5.2 Icons That Do NOT Mirror in RTL

These icons are either symmetric or represent universal concepts where the direction is fixed.

| Icon Name | Appearance | Reason for NOT Mirroring |
|-----------|:---------:|-------------------------|
| `search` | 🔍 | Search magnifying glass is universal |
| `close` / `clear` | X | Symmetric |
| `add` / `plus` | + | Symmetric |
| `remove` / `minus` | - | Symmetric |
| `delete` / `trash` | 🗑 | No directional meaning |
| `star` / `star_border` | ★ | Rating is universal |
| `favorite` / `heart` | ♡ | Symmetric |
| `play_arrow` | ▶ | Media play always points right |
| `pause` | ⏸ | Symmetric |
| `stop` | ⏹ | Symmetric |
| `skip_next` | ⏭ | Media control convention |
| `skip_previous` | ⏮ | Media control convention |
| `fast_forward` | ⏩ | Media control convention |
| `fast_rewind` | ⏪ | Media control convention |
| `volume_up` | 🔊 | Speaker shape is universal |
| `volume_down` | 🔉 | Speaker shape is universal |
| `volume_off` | 🔇 | Speaker shape is universal |
| `brightness_low` | ☀ (small) | Sun is symmetric |
| `brightness_high` | ☀ (large) | Sun is symmetric |
| `check` / `done` | ✓ | Checkmark is universal |
| `check_circle` | ✓ in circle | Symmetric |
| `error` | ! in circle | Symmetric |
| `warning` | ! in triangle | Symmetric |
| `info` | i in circle | Symmetric |
| `notifications` / `bell` | 🔔 | Symmetric |
| `settings` / `gear` | ⚙ | Symmetric |
| `home` | 🏠 | Symmetric |
| `person` / `account` | 👤 | Symmetric |
| `calendar` / `event` | 📅 | Symmetric |
| `lock` / `unlock` | 🔒 | Symmetric |
| `visibility` / `eye` | 👁 | Symmetric |
| `download` | ↓ | Vertical direction |
| `upload` | ↑ | Vertical direction |
| `expand_more` | ▼ (down chevron) | Vertical direction |
| `expand_less` | ▲ (up chevron) | Vertical direction |
| `refresh` | ↻ | Circular motion is universal |
| `sync` | ↻ | Circular motion |
| `sort` | ↕ | Vertical direction |
| `filter_list` | ≡ (decreasing lines) | Debatable but kept LTR per Material |
| `share` | Share symbol | Platform-dependent, but generally symmetric |
| `edit` / `pencil` | ✏ | Tool, no directionality |
| `copy` | ⎘ | Symmetric |
| `camera` | 📷 | Symmetric |
| `image` / `photo` | 🖼 | Symmetric |
| `attach_file` | 📎 | Symmetric |
| `link` | 🔗 | Symmetric |
| `qr_code` | QR | Symmetric |
| `emoji` / `smiley` | 😊 | Symmetric |
| `schedule` / `clock` | 🕐 | Clock is universal |
| `location` / `place` | 📍 | Symmetric |
| `map` | 🗺 | Not mirrored |
| `thumb_up` | 👍 | Debatable; keep LTR for consistency |
| `thumb_down` | 👎 | Debatable; keep LTR for consistency |

### 5.3 Custom LOLO Icons -- RTL Variant Requirements

LOLO uses custom icons for several unique features. Each custom icon must be evaluated for RTL mirroring.

| Custom Icon | Description | Needs RTL Variant? | Reason |
|------------|------------|:------------------:|--------|
| `ic_compass` (logo mark) | Interlocking L compass | NO | Brand logo -- never mirror |
| `ic_reminder_card` | Card with clock | NO | Symmetric composition |
| `ic_ai_message` | Chat bubble with sparkle | YES | Chat bubble tail points to "sender" side |
| `ic_gift_box` | Gift box with ribbon | NO | Symmetric |
| `ic_her_profile` | Abstract person silhouette | NO | Symmetric |
| `ic_sos_shield` | Shield with exclamation | NO | Symmetric |
| `ic_streak_flame` | Flame icon | NO | Symmetric |
| `ic_xp_star` | Star with "XP" text | NO | Symmetric |
| `ic_level_badge` | Shield/badge with number | NO | Symmetric |
| `ic_wish_list` | Sparkle/wand icon | NO | Symmetric |
| `ic_promise_tracker` | Handshake or pinky promise | YES | Hands have left/right orientation |
| `ic_calendar_sync` | Calendar with sync arrows | NO | Sync arrows are circular |
| `ic_copy_message` | Clipboard with arrow | YES | Arrow indicates "copy out" direction |
| `ic_send_whatsapp` | WhatsApp icon + arrow | YES | Arrow direction = sending |
| `ic_send_sms` | SMS bubble + arrow | YES | Arrow direction = sending |
| `ic_tone_slider` | Slider with labels | YES | Labels are left/right positioned |
| `ic_navigation_hint` | Hand with swipe direction | YES | Gesture direction must match locale |
| `ic_onboarding_step` | Step number with arrow | YES | Arrow indicates progression |
| `ic_action_card_arrow` | Forward arrow on action card | YES | Directional |
| `ic_expand_section` | Chevron for section expand | YES | Directional chevron |

**For icons marked YES**, provide two SVG/vector variants:
- `ic_[name].svg` -- LTR variant (default)
- `ic_[name]_rtl.svg` -- RTL variant (horizontally mirrored or redesigned)

Alternatively, use `matchTextDirection: true` in Flutter to auto-mirror, but verify each icon looks correct when flipped (some icons with text or asymmetric details may not flip cleanly and require a manually designed RTL variant).

---

## 6. Testing Checklist

### 6.1 RTL Layout Validation Checklist for QA

This checklist must be completed for every screen in LOLO before the Arabic locale is approved for release.

#### Global Layout Checks

- [ ] **App bar:** Back arrow appears on the right and points right (→)
- [ ] **App bar:** Title text is right-aligned
- [ ] **App bar:** Action icons appear on the left
- [ ] **Bottom navigation:** Tab order is reversed (Home on rightmost position)
- [ ] **Bottom navigation:** Active tab indicator is on the correct tab
- [ ] **Drawer:** Opens from the right side of the screen
- [ ] **Drawer:** Swipe-to-open gesture works from the right edge
- [ ] **Page transitions:** New pages slide in from the left (push forward in RTL)
- [ ] **Page transitions:** Pages slide out to the left when popping (back in RTL)
- [ ] **System status bar:** Time and status icons maintain system default positions
- [ ] **Keyboard:** Arabic keyboard appears when tapping Arabic text fields
- [ ] **Text selection handles:** Appear and function correctly in RTL

#### Per-Screen Checks

For each screen, verify:

- [ ] **Text alignment:** All body text is right-aligned
- [ ] **Text alignment:** All headings are right-aligned
- [ ] **Text alignment:** Numeric values are correctly positioned
- [ ] **Padding/margins:** Start padding is on the right side
- [ ] **Padding/margins:** End padding is on the left side
- [ ] **Icons:** Directional icons (arrows, chevrons) are mirrored
- [ ] **Icons:** Non-directional icons (search, settings, etc.) are NOT mirrored
- [ ] **Images:** Decorative images are NOT mirrored (unless they contain directional content)
- [ ] **Lists:** Leading elements (avatars, icons) appear on the right
- [ ] **Lists:** Trailing elements (chevrons, action buttons) appear on the left
- [ ] **Cards:** Horizontal card layouts are mirrored (image on right, content on left)
- [ ] **Buttons:** Icon buttons with directional icons are mirrored
- [ ] **Buttons:** Button text is correctly rendered in Arabic
- [ ] **Input fields:** Cursor starts at the right edge
- [ ] **Input fields:** Placeholder text is right-aligned
- [ ] **Input fields:** Leading icons appear on the right
- [ ] **Input fields:** Trailing icons appear on the left
- [ ] **Input fields:** Error/helper text is right-aligned
- [ ] **Dropdowns:** Arrow icon appears on the left (RTL end)
- [ ] **Dropdowns:** Selected value text is right-aligned
- [ ] **Toggles:** Label appears on the right of the toggle
- [ ] **Toggles:** Toggle thumb ON/OFF position is NOT mirrored
- [ ] **Sliders:** Min value is on the right, Max on the left
- [ ] **Dialogs:** Title and body are right-aligned
- [ ] **Dialogs:** Primary action button is on the left (RTL end)
- [ ] **Bottom sheets:** Content is right-aligned
- [ ] **Bottom sheets:** Close button (X) is on the top-left
- [ ] **Chips:** Avatar/icon appears on the right, delete (X) on the left
- [ ] **Tabs:** First tab is rightmost
- [ ] **Tabs:** Tab scroll starts from the right
- [ ] **Swipe gestures:** Swipe left to dismiss/go back works correctly
- [ ] **Empty states:** Illustration is centered (no mirroring needed)
- [ ] **Empty states:** Text is right-aligned
- [ ] **Loading states:** Shimmer animation direction is appropriate
- [ ] **Snackbars:** Text is right-aligned, action button is on the left

#### Typography Checks

- [ ] **Font:** Arabic headings use Cairo (SemiBold/Bold)
- [ ] **Font:** Arabic body text uses Noto Naskh Arabic (Regular/Medium)
- [ ] **Font size:** Arabic text is +1sp to +2sp larger than English equivalent
- [ ] **Line height:** Arabic line height is 1.6x or greater for body text
- [ ] **Letter spacing:** No negative letter-spacing on Arabic text
- [ ] **Minimum size:** No Arabic body text below 16sp
- [ ] **Overline:** Arabic overline is NOT uppercase (Arabic has no case distinction)
- [ ] **Number display:** Western numerals display correctly by default
- [ ] **Number display (if enabled):** Arabic-Indic numerals display correctly
- [ ] **Punctuation:** Arabic comma (،) used instead of Latin comma
- [ ] **Punctuation:** Arabic question mark (؟) used instead of Latin question mark
- [ ] **Mixed content:** English words in Arabic sentences render correctly (BiDi)
- [ ] **Mixed content:** Brand names (LOLO, WhatsApp) appear in correct position
- [ ] **Date format:** Dates display correctly in Arabic context
- [ ] **Time format:** AM/PM shows as ص/م when in Arabic

#### Special Screen Checks

- [ ] **Splash screen:** LOLO logo is centered (not mirrored)
- [ ] **Onboarding:** Step indicators progress right-to-left
- [ ] **Onboarding:** Swipe direction to advance is reversed (swipe left to go to next)
- [ ] **Login/Registration:** Phone number field is LTR
- [ ] **Login/Registration:** Email field is LTR
- [ ] **Login/Registration:** Password field is LTR
- [ ] **Profile setup:** Zodiac wheel/picker is not mirrored
- [ ] **Reminders list:** Date/time values are correctly formatted
- [ ] **AI Message generator:** Generated message text is right-aligned
- [ ] **AI Message generator:** Tone selector chips are right-to-left ordered
- [ ] **AI Message generator:** Copy button is appropriately positioned
- [ ] **Gift recommendations:** Price text with currency is correctly formatted
- [ ] **Gift recommendations:** Affiliate links open correctly
- [ ] **SOS Mode:** Urgent UI is correctly mirrored
- [ ] **Settings:** All settings rows are mirrored (label right, value/toggle left)
- [ ] **Settings:** Language selector functions correctly
- [ ] **Settings:** Number format toggle (Western/Arabic-Indic) works

### 6.2 Common RTL Bugs and How to Avoid Them

| # | Bug Description | Root Cause | Prevention |
|:-:|----------------|-----------|-----------|
| 1 | **Text overflows on one side** | Used `EdgeInsets.only(left: X)` instead of `EdgeInsetsDirectional.only(start: X)` | Global lint rule: ban `EdgeInsets.only` with left/right values. Use `EdgeInsetsDirectional` exclusively. |
| 2 | **Icons not mirroring** | Used `Icon(Icons.arrow_forward)` without `textDirection` context, or custom icon without `matchTextDirection: true` | Wrap directional icons with `Directionality` awareness. Use the mirroring checklist in Section 5. |
| 3 | **Drawer opens from wrong side** | Manually set drawer anchor to left | Never hardcode drawer anchor. Use `Scaffold.drawer` which respects `Directionality`. |
| 4 | **Text alignment stuck left** | Used `TextAlign.left` instead of `TextAlign.start` | Global lint rule: ban `TextAlign.left` and `TextAlign.right`. Use `.start` and `.end`. |
| 5 | **Toggle switch mirrored** | Applied RTL mirroring to the entire toggle widget including thumb position | Isolate the toggle control with `Directionality(textDirection: TextDirection.ltr)` while keeping the label in RTL context. Or use `SwitchListTile` which handles this. |
| 6 | **Phone number field RTL** | Did not set `TextDirection.ltr` on phone input | Always set `textDirection: TextDirection.ltr` on phone, email, URL, and password fields. |
| 7 | **Animation direction wrong** | Slide transition hardcoded to `Offset(1.0, 0.0)` | Use `Tween<Offset>(begin: Offset(Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0, 0.0), end: Offset.zero)` |
| 8 | **Swipe-to-dismiss wrong direction** | Used `DismissDirection.endToStart` for delete but did not account for RTL meaning change | Use semantic naming: `startToEnd` = primary action, `endToStart` = secondary. These auto-resolve. |
| 9 | **Logo mirrored** | Logo is inside a widget tree that mirrors all children | Wrap the logo with `Directionality(textDirection: TextDirection.ltr, child: Logo())` |
| 10 | **Progress bar/timeline mirrored** | Time-based progress bar inside RTL context | Wrap temporal progress indicators with `Directionality(textDirection: TextDirection.ltr)` |
| 11 | **Arabic text with English ending looks wrong** | BiDi algorithm reorders LTR run at end of RTL paragraph | Add RLM (`\u200F`) at the end of the Arabic string if needed, or use `\u2068...\u2069` isolates around the English portion |
| 12 | **Number format inconsistent** | Some screens use Western, others use Arabic-Indic | Centralize number formatting through a single `NumberFormatter` utility that reads the user preference |
| 13 | **Keyboard overlap** | Arabic keyboard height differs from English | Use `resizeToAvoidBottomInset: true` on `Scaffold` and test with Arabic keyboard on multiple devices |
| 14 | **Tab indicator on wrong tab** | Tab controller index does not account for RTL reordering | Flutter `TabBar` handles this automatically. Do not manually manage tab positions. |
| 15 | **Border radius asymmetry** | Used `BorderRadius.only(topLeft: 16)` instead of `BorderRadiusDirectional.only(topStart: 16)` | Use `BorderRadiusDirectional` for asymmetric border radii |
| 16 | **Horizontal scrollable starts at wrong end** | `ScrollController` starts at position 0 (left) in RTL when it should start at right | Flutter `ListView` handles this automatically. Do not set `initialScrollOffset` manually for horizontal lists. |
| 17 | **Date picker in wrong direction** | Calendar grid not mirroring | Use Flutter's `showDatePicker` which respects `Locale` and `Directionality` |
| 18 | **Gradient direction wrong** | Used `Alignment.centerLeft` to `Alignment.centerRight` for gradient | Use `AlignmentDirectional.centerStart` to `AlignmentDirectional.centerEnd` for gradients that should mirror |
| 19 | **Cropped Arabic text** | Container height too small for Arabic line height | Always test container heights with Arabic text. Arabic needs 10-15% more vertical space than English. |
| 20 | **Truncation with ellipsis on wrong side** | Ellipsis appears on the right (start of Arabic text) instead of the left (end) | `TextOverflow.ellipsis` with `TextDirection.rtl` handles this correctly. Verify on device. |

### 6.3 Screenshots Comparison Guide

For every screen in LOLO, QA must capture and compare LTR and RTL screenshots side by side. This ensures no layout element was missed during mirroring.

**Screenshot Naming Convention:**

```
[screen-name]-[locale]-[theme]-[state].png

Examples:
home-en-dark-default.png
home-ar-dark-default.png
home-en-dark-loading.png
home-ar-dark-loading.png
reminders-list-en-dark-empty.png
reminders-list-ar-dark-empty.png
reminders-list-en-dark-populated.png
reminders-list-ar-dark-populated.png
```

**Required Screenshot Pairs (LTR vs RTL):**

Every screen must be captured in the following states:

| State | Description | LTR File | RTL File |
|-------|------------|----------|----------|
| Default/Loaded | Normal state with data | `[screen]-en-dark-default.png` | `[screen]-ar-dark-default.png` |
| Empty | No data / empty state | `[screen]-en-dark-empty.png` | `[screen]-ar-dark-empty.png` |
| Loading | Skeleton/shimmer state | `[screen]-en-dark-loading.png` | `[screen]-ar-dark-loading.png` |
| Error | Error state displayed | `[screen]-en-dark-error.png` | `[screen]-ar-dark-error.png` |
| Interactive | Expanded/selected/active | `[screen]-en-dark-active.png` | `[screen]-ar-dark-active.png` |

**Screen List for Full RTL Screenshot Coverage:**

| # | Screen Name | Screen ID | Priority |
|:-:|-------------|-----------|:--------:|
| 1 | Splash | `splash` | P0 |
| 2 | Onboarding Step 1 | `onboarding-1` | P0 |
| 3 | Onboarding Step 2 | `onboarding-2` | P0 |
| 4 | Onboarding Step 3 | `onboarding-3` | P0 |
| 5 | Login | `login` | P0 |
| 6 | Registration | `registration` | P0 |
| 7 | Home (Dashboard) | `home` | P0 |
| 8 | Reminders List | `reminders-list` | P0 |
| 9 | Reminder Detail | `reminder-detail` | P0 |
| 10 | Create Reminder | `reminder-create` | P0 |
| 11 | AI Messages | `messages` | P0 |
| 12 | Message Generation | `message-generate` | P0 |
| 13 | Message Result | `message-result` | P0 |
| 14 | Her Profile Overview | `her-profile` | P0 |
| 15 | Her Profile Edit | `her-profile-edit` | P0 |
| 16 | Zodiac Selection | `zodiac-select` | P1 |
| 17 | Love Language Assessment | `love-language` | P1 |
| 18 | Gift Recommendations | `gifts` | P0 |
| 19 | Gift Detail | `gift-detail` | P1 |
| 20 | SOS Mode Activation | `sos-activate` | P0 |
| 21 | SOS Mode Active | `sos-active` | P0 |
| 22 | Gamification / Level | `gamification` | P1 |
| 23 | Achievements | `achievements` | P1 |
| 24 | Settings Main | `settings` | P0 |
| 25 | Settings > Display | `settings-display` | P0 |
| 26 | Settings > Notifications | `settings-notifications` | P1 |
| 27 | Settings > Language | `settings-language` | P0 |
| 28 | Settings > Account | `settings-account` | P1 |
| 29 | Paywall / Premium | `paywall` | P0 |
| 30 | About | `about` | P2 |
| 31 | Calendar View | `calendar` | P1 |
| 32 | Wish List | `wish-list` | P1 |
| 33 | Promise Tracker | `promises` | P1 |
| 34 | Action Card (expanded) | `action-card` | P0 |
| 35 | Notification Center | `notifications` | P1 |

**P0** = must be screenshot-verified before any Arabic release.
**P1** = must be verified before public launch.
**P2** = can be verified post-launch.

**Comparison Method:**

1. Capture LTR (English) and RTL (Arabic) screenshots on the same device and screen size.
2. Place them side by side in a comparison tool (or a simple two-column layout).
3. Verify that the RTL screenshot is a logical mirror of the LTR screenshot:
   - Text alignment flipped
   - Icon positions flipped
   - Navigation elements flipped
   - Non-directional elements (logos, media controls) NOT flipped
4. Document any discrepancy as a bug with:
   - Screenshot pair showing the issue
   - Element that is incorrect
   - Expected behavior
   - Severity (P0 = blocker, P1 = major, P2 = minor)

**Automated RTL Testing:**

In addition to manual screenshot comparison, implement automated RTL checks using Flutter's testing framework:

```dart
// Example: Widget test with RTL directionality
testWidgets('Reminders list mirrors correctly in RTL', (tester) async {
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        locale: Locale('ar'),
        home: RemindersListScreen(),
      ),
    ),
  );

  // Verify leading icon is on the right
  final leadingIcon = find.byIcon(Icons.calendar_today);
  final leadingPosition = tester.getTopRight(leadingIcon);
  expect(leadingPosition.dx, greaterThan(screenWidth / 2));

  // Verify title text is right-aligned
  final titleText = find.text('التذكيرات');
  final titleAlignment = tester.widget<Text>(titleText).textAlign;
  expect(titleAlignment, TextAlign.start); // start = right in RTL
});
```

Run RTL widget tests as part of the CI pipeline to catch regressions before they reach QA.

---

## Appendix A: RTL Decision Matrix Quick Reference

Use this matrix when deciding how to handle a specific UI element in RTL:

```
Is the element text-based?
├── YES → Does it contain Arabic text?
│         ├── YES → Set TextDirection.rtl, use .start/.end alignment
│         └── NO → Is it a phone/email/URL/password?
│                   ├── YES → Force TextDirection.ltr
│                   └── NO → Follow parent Directionality
└── NO → Is it an icon?
          ├── YES → Does it have directional meaning?
          │         ├── YES → Mirror it (use matchTextDirection: true)
          │         └── NO → Do NOT mirror
          └── NO → Is it a layout container?
                    ├── YES → Use EdgeInsetsDirectional, AlignmentDirectional
                    │         Does it represent time or media?
                    │         ├── YES → Force LTR
                    │         └── NO → Follow Directionality
                    └── NO → Is it the LOLO logo/brand mark?
                              ├── YES → NEVER mirror
                              └── NO → Evaluate case by case
```

## Appendix B: Flutter RTL Lint Rules

Add these custom lint rules to the project's `analysis_options.yaml` to catch common RTL mistakes at compile time:

**Banned Patterns:**
1. `EdgeInsets.only(left:` or `EdgeInsets.only(right:` -- Use `EdgeInsetsDirectional.only(start:` / `end:`
2. `TextAlign.left` -- Use `TextAlign.start`
3. `TextAlign.right` -- Use `TextAlign.end`
4. `Alignment.centerLeft` -- Use `AlignmentDirectional.centerStart`
5. `Alignment.centerRight` -- Use `AlignmentDirectional.centerEnd`
6. `Alignment.topLeft` -- Use `AlignmentDirectional.topStart`
7. `Alignment.topRight` -- Use `AlignmentDirectional.topEnd`
8. `Alignment.bottomLeft` -- Use `AlignmentDirectional.bottomStart`
9. `Alignment.bottomRight` -- Use `AlignmentDirectional.bottomEnd`
10. `BorderRadius.only(topLeft:` or `bottomRight:` -- Use `BorderRadiusDirectional`

**Exceptions (allowed LTR-only patterns):**
- Media player controls
- Phone/email/URL input fields
- Time-series charts and progress bars
- LOLO logo/brand mark containers
- Credit card/payment fields

---

*Document maintained by Lina Vazquez, Senior UX/UI Designer*
*Last updated: February 14, 2026*
*Next review: Upon completion of Phase 2 Arabic localization milestone*
