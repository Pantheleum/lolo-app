# LOLO Design System v1.0

### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0
### Classification: Internal -- Confidential
### Dependencies: Competitive UX Audit (v1.0), Wireframe Specifications (v1.0), Localization Architecture (v1.0)

---

## Table of Contents

1. [Brand Identity](#section-1-brand-identity)
2. [Color System](#section-2-color-system)
3. [Typography](#section-3-typography)
4. [Spacing & Layout](#section-4-spacing--layout)
5. [Component Library](#section-5-component-library)
6. [Iconography](#section-6-iconography)
7. [Animation & Motion](#section-7-animation--motion)
8. [Dark Mode](#section-8-dark-mode)

---

## Section 1: Brand Identity

### 1.1 Brand Personality

LOLO communicates four core personality traits through every visual and verbal touchpoint:

| Trait | Expression | What It Is NOT |
|-------|-----------|----------------|
| **Masculine** | Dark palettes, geometric shapes, shield-like badges, confident typography | Not aggressive, not "bro culture," not exclusionary |
| **Premium** | Spacious layouts, restrained color use, gold accents, clean lines | Not flashy, not luxury-for-luxury-sake, not pretentious |
| **Warm** | Warm gold undertones, supportive copy, celebration animations, soft radii | Not cold, not clinical, not transactional |
| **Discreet** | Neutral app icon, professional notification text, "glance test" passing UI | Not secretive, not hidden, not ashamed |

### 1.2 Logo Concept

**Primary Mark: "The Compass"**

The LOLO logo is an abstract geometric compass mark formed from two interlocking "L" letterforms. The overlapping region creates a subtle directional arrow pointing upward-right, symbolizing forward progress and guidance. The compass metaphor aligns with LOLO's role as a navigator for the relationship journey.

**Construction:**
- Two "L" shapes rotated 180 degrees and overlapped at their corners
- The intersection forms a diamond/arrow shape
- Stroke weight: 3px at standard scale (48dp)
- Corner radius on L terminals: 2px (sharp but not aggressive)
- Color: monochrome (Text Primary) for standard use, Premium Gradient for feature moments

**Logo Variants:**
| Variant | Usage | Specification |
|---------|-------|--------------|
| **Full Mark + Wordmark** | Splash screen, onboarding, marketing | Compass mark (48dp) + "LOLO" wordmark (Inter Bold, 32sp) with 12dp gap |
| **Mark Only** | App bar, loading states, watermarks | Compass mark at 32dp, 24dp, or 16dp depending on context |
| **Wordmark Only** | Legal documents, footer text | "LOLO" in Inter Bold, all caps, 1.5px letter spacing |
| **Monochrome** | On photography, dark backgrounds | Single color (white or dark) without gradient |

**Clear Space:** Minimum 8dp (1/4 of mark height) on all sides.

**Minimum Size:** 16dp for mark only; 24dp for mark + wordmark.

### 1.3 App Icon Design Spec

**Design Direction:** Abstract geometric mark on a dark field. No hearts, no pink, no couple silhouettes.

**Specification:**
- **Shape:** Rounded square (Android adaptive icon format / iOS superellipse)
- **Background:** Solid #0D1117 (Background Primary dark)
- **Foreground:** Compass mark in Premium Gradient (linear-gradient 135deg from #4A90D9 to #C9A96E)
- **Mark Size:** 60% of icon safe area
- **Padding:** 20% on all sides within safe area
- **Shadow:** None on the icon itself (platforms apply their own)

**Platform Specs:**
| Platform | Size | Format | Notes |
|----------|------|--------|-------|
| Android Adaptive | 108x108dp (72dp safe) | Vector (XML) | Foreground + background layers |
| iOS | 1024x1024px master | PNG | Exported at @1x, @2x, @3x |
| Play Store | 512x512px | PNG | High-res listing icon |
| App Store | 1024x1024px | PNG | No transparency, no alpha |

**The Glance Test:** When placed on a home screen next to banking, fitness, and productivity apps, LOLO's icon should appear to be a premium utility or life-management tool. It should not read as a "relationship app" at a distance.

### 1.4 Brand Voice (UI Copy)

| Attribute | Description | Example |
|-----------|------------|---------|
| **Direct** | Short, clear, action-oriented | "Send this to her." not "Why not try sending this lovely message?" |
| **Confident** | Declarative, not hedging | "Here's your action card." not "We think you might want to try..." |
| **Supportive** | Encouraging without being patronizing | "Good move. +15 XP" not "Yay! You did it! So proud of you!" |
| **Discreet** | Professional in notifications and previews | "Reminder: 3 days" not "Don't forget her birthday!" |

---

## Section 2: Color System

### 2.1 Primary Palette

| Role | Token | Hex | Usage |
|------|-------|-----|-------|
| **Brand Primary** | `colorPrimary` | `#4A90D9` | Primary actions, links, active states, key UI elements |
| **Brand Accent** | `colorAccent` | `#C9A96E` | Achievement highlights, premium indicators, secondary CTAs, warmth touches |
| **Brand Background** | `colorBackground` | `#0D1117` (dark) / `#FFFFFF` (light) | App canvas, base layer |

### 2.2 Semantic Colors

| Semantic Role | Token | Hex (Dark) | Hex (Light) | Usage |
|---------------|-------|-----------|------------|-------|
| **Success** | `colorSuccess` | `#3FB950` | `#1A7F37` | Completed actions, positive confirmations, streak active |
| **Warning** | `colorWarning` | `#D29922` | `#BF8700` | Approaching deadlines, attention needed, overdue soon |
| **Error** | `colorError` | `#F85149` | `#CF222E` | Validation errors, failed actions, SOS mode accent |
| **Info** | `colorInfo` | `#58A6FF` | `#0969DA` | Informational banners, tips, helper text highlights |

### 2.3 Dark Mode Palette (Default)

| Role | Token | Hex | Opacity | Usage |
|------|-------|-----|---------|-------|
| Background Primary | `darkBgPrimary` | `#0D1117` | 100% | Main canvas |
| Background Secondary | `darkBgSecondary` | `#161B22` | 100% | Elevated surfaces (app bar, bottom nav) |
| Background Tertiary | `darkBgTertiary` | `#21262D` | 100% | Cards, input fields, bottom sheets |
| Surface Elevated 1 | `darkSurfaceElevated1` | `#282E36` | 100% | Elevated cards, dialogs |
| Surface Elevated 2 | `darkSurfaceElevated2` | `#30363D` | 100% | Tooltips, dropdown menus |
| Surface Overlay | `darkSurfaceOverlay` | `#0D1117` | 70% | Modal scrims, backdrop |
| Text Primary | `darkTextPrimary` | `#F0F6FC` | 100% | Headlines, body text, primary labels |
| Text Secondary | `darkTextSecondary` | `#8B949E` | 100% | Subtitles, captions, secondary labels |
| Text Tertiary | `darkTextTertiary` | `#484F58` | 100% | Placeholders, hints, disabled text |
| Text Disabled | `darkTextDisabled` | `#30363D` | 100% | Disabled labels, inactive elements |
| Border Default | `darkBorderDefault` | `#30363D` | 100% | Card borders, dividers, input outlines |
| Border Muted | `darkBorderMuted` | `#21262D` | 100% | Subtle separators |
| Border Accent | `darkBorderAccent` | `#4A90D9` | 100% | Focus rings, active borders |

### 2.4 Light Mode Palette

| Role | Token | Hex | Opacity | Usage |
|------|-------|-----|---------|-------|
| Background Primary | `lightBgPrimary` | `#FFFFFF` | 100% | Main canvas |
| Background Secondary | `lightBgSecondary` | `#F6F8FA` | 100% | Elevated surfaces |
| Background Tertiary | `lightBgTertiary` | `#EAEEF2` | 100% | Cards, input fields |
| Surface Elevated 1 | `lightSurfaceElevated1` | `#FFFFFF` | 100% | Cards with shadow |
| Surface Elevated 2 | `lightSurfaceElevated2` | `#FFFFFF` | 100% | Dialogs, popovers |
| Surface Overlay | `lightSurfaceOverlay` | `#1F2328` | 50% | Modal scrims |
| Text Primary | `lightTextPrimary` | `#1F2328` | 100% | Headlines, body text |
| Text Secondary | `lightTextSecondary` | `#656D76` | 100% | Subtitles, captions |
| Text Tertiary | `lightTextTertiary` | `#8C959F` | 100% | Placeholders, hints |
| Text Disabled | `lightTextDisabled` | `#AFB8C1` | 100% | Disabled labels |
| Border Default | `lightBorderDefault` | `#D0D7DE` | 100% | Card borders, dividers |
| Border Muted | `lightBorderMuted` | `#EAEEF2` | 100% | Subtle separators |
| Border Accent | `lightBorderAccent` | `#4A90D9` | 100% | Focus rings, active borders |

### 2.5 Neutral / Gray Scale (10 Shades)

| Step | Token | Hex (Dark Theme Usage) | Hex (Light Theme Usage) |
|------|-------|----------------------|------------------------|
| Gray 0 | `gray0` | `#F0F6FC` | `#1F2328` |
| Gray 1 | `gray1` | `#C9D1D9` | `#2C333A` |
| Gray 2 | `gray2` | `#B1BAC4` | `#3D444D` |
| Gray 3 | `gray3` | `#8B949E` | `#525A64` |
| Gray 4 | `gray4` | `#6E7681` | `#656D76` |
| Gray 5 | `gray5` | `#484F58` | `#818B98` |
| Gray 6 | `gray6` | `#30363D` | `#8C959F` |
| Gray 7 | `gray7` | `#21262D` | `#AFB8C1` |
| Gray 8 | `gray8` | `#161B22` | `#D0D7DE` |
| Gray 9 | `gray9` | `#0D1117` | `#EAEEF2` |

Gray 0 is lightest in dark mode (used for primary text) and darkest in light mode (used for primary text). The scale inverts between themes.

### 2.6 Gradient Definitions

| Gradient | Token | Definition | Usage |
|----------|-------|-----------|-------|
| **Premium** | `gradientPremium` | `linear-gradient(135deg, #4A90D9 0%, #C9A96E 100%)` | Level-up celebrations, premium badges, paywall CTA, first-value-moment card |
| **SOS** | `gradientSOS` | `linear-gradient(135deg, #F85149 0%, #D29922 100%)` | SOS mode activation, urgent alerts, danger pulse |
| **Achievement** | `gradientAchievement` | `linear-gradient(135deg, #C9A96E 0%, #E8D5A3 100%)` | Badge unlocks, milestone cards, gold accents |
| **Cool** | `gradientCool` | `linear-gradient(180deg, #161B22 0%, #0D1117 100%)` | Background subtle depth, app bar fade, onboarding backgrounds |
| **Success** | `gradientSuccess` | `linear-gradient(135deg, #3FB950 0%, #56D364 100%)` | Streak milestones, completion celebrations |
| **Card Shimmer** | `gradientShimmer` | `linear-gradient(90deg, #21262D 0%, #30363D 50%, #21262D 100%)` | Loading skeleton animation |

### 2.7 Color Usage Rules

**Rule 1: Primary for Actions, Accent for Rewards**
- `colorPrimary` (#4A90D9 steel blue) is used for interactive elements: buttons, links, toggles, active tab indicators, focus rings. It communicates "tap here" or "this is active."
- `colorAccent` (#C9A96E warm gold) is used for achievement and warmth: XP gains, level badges, streak flames, premium features, celebration moments. It communicates "you earned this" or "this is special."

**Rule 2: Semantic Colors Are Contextual Only**
- Success, warning, error, and info colors appear only in context -- never as decoration. A green badge means something was completed. A red border means something needs attention.

**Rule 3: Background Layering Creates Depth**
- Dark mode uses three background layers to create visual hierarchy without shadows:
  - `darkBgPrimary` (canvas) > `darkBgSecondary` (navigation, toolbars) > `darkBgTertiary` (cards, inputs)
- Light mode uses shadows in addition to background differentiation for the same hierarchy.

**Rule 4: Text Color Hierarchy Is Strict**
- Primary text for all headlines and body content that users must read.
- Secondary text for supporting information, timestamps, captions.
- Tertiary text for placeholders, hints, and disabled labels only.
- Never use tertiary text for content the user needs to read.

**Rule 5: Color Alone Never Communicates State**
- Always pair color with an icon, label, or pattern change. A red input border also shows an error message. A green checkmark also shows "Completed" text. This ensures accessibility for color-blind users.

### 2.8 Accessibility: WCAG AA Contrast Ratios

All text and interactive elements must meet WCAG AA minimum contrast ratios: 4.5:1 for normal text (under 18sp), 3:1 for large text (18sp+ bold or 24sp+ regular).

**Dark Mode Contrast Verification:**

| Foreground | Background | Contrast Ratio | WCAG AA | Usage |
|-----------|-----------|:--------------:|:-------:|-------|
| `#F0F6FC` (Text Primary) | `#0D1117` (Bg Primary) | **15.4:1** | Pass | Body text on canvas |
| `#F0F6FC` (Text Primary) | `#161B22` (Bg Secondary) | **13.2:1** | Pass | Text on app bar |
| `#F0F6FC` (Text Primary) | `#21262D` (Bg Tertiary) | **10.9:1** | Pass | Text on cards |
| `#8B949E` (Text Secondary) | `#0D1117` (Bg Primary) | **5.6:1** | Pass | Captions on canvas |
| `#8B949E` (Text Secondary) | `#21262D` (Bg Tertiary) | **3.9:1** | Pass (large) | Captions on cards |
| `#484F58` (Text Tertiary) | `#0D1117` (Bg Primary) | **2.7:1** | Fail (decorative only) | Hints, placeholders |
| `#4A90D9` (Primary) | `#0D1117` (Bg Primary) | **5.1:1** | Pass | Links on canvas |
| `#4A90D9` (Primary) | `#21262D` (Bg Tertiary) | **3.5:1** | Pass (large) | Buttons on cards |
| `#C9A96E` (Accent) | `#0D1117` (Bg Primary) | **6.3:1** | Pass | Gold text on canvas |
| `#F85149` (Error) | `#0D1117` (Bg Primary) | **5.5:1** | Pass | Error text on canvas |
| `#3FB950` (Success) | `#0D1117` (Bg Primary) | **6.8:1** | Pass | Success text on canvas |
| `#FFFFFF` (Button text) | `#4A90D9` (Primary) | **3.4:1** | Pass (large) | White text on primary button |

**Light Mode Contrast Verification:**

| Foreground | Background | Contrast Ratio | WCAG AA | Usage |
|-----------|-----------|:--------------:|:-------:|-------|
| `#1F2328` (Text Primary) | `#FFFFFF` (Bg Primary) | **16.0:1** | Pass | Body text on canvas |
| `#1F2328` (Text Primary) | `#F6F8FA` (Bg Secondary) | **14.5:1** | Pass | Text on surfaces |
| `#656D76` (Text Secondary) | `#FFFFFF` (Bg Primary) | **5.3:1** | Pass | Captions on canvas |
| `#0969DA` (Primary Light) | `#FFFFFF` (Bg Primary) | **4.6:1** | Pass | Links on canvas |
| `#CF222E` (Error Light) | `#FFFFFF` (Bg Primary) | **5.9:1** | Pass | Error text on canvas |
| `#FFFFFF` (Button text) | `#4A90D9` (Primary) | **3.4:1** | Pass (large) | White text on primary button |

**Notes:**
- Tertiary text (`#484F58` on dark, `#8C959F` on light) intentionally fails WCAG AA for normal text. It is used exclusively for decorative hints and placeholders, which do not require AA compliance per WCAG guidelines.
- All interactive elements using `colorPrimary` as text must be at least 16sp to qualify as "large text" on card surfaces.
- When `colorAccent` gold is used for text (e.g., XP labels), it must always be on `darkBgPrimary` or `darkBgSecondary` to maintain 4.5:1+ ratio.

---

## Section 3: Typography

### 3.1 English Fonts

| Role | Font Family | Weight | Fallback Stack |
|------|------------|--------|---------------|
| **Primary (Headings)** | Inter | SemiBold (600), Bold (700) | SF Pro Display, Roboto, system-ui, sans-serif |
| **Secondary (Body)** | Inter | Regular (400), Medium (500) | SF Pro Text, Roboto, system-ui, sans-serif |
| **Monospace** | JetBrains Mono | Regular (400), Medium (500) | SF Mono, Roboto Mono, Courier New, monospace |

**Why Inter:** Geometric sans-serif with excellent readability at small sizes, full character coverage for Bahasa Melayu (Latin Extended), open source, optimized for screens. Its neutral, professional character avoids "cute" or "playful" associations, aligning with LOLO's masculine-premium positioning.

### 3.2 Arabic Fonts

| Role | Font Family | Weight | Fallback Stack |
|------|------------|--------|---------------|
| **Headings** | Cairo | SemiBold (600), Bold (700) | Tajawal Bold, Noto Sans Arabic Bold, sans-serif |
| **Body** | Noto Naskh Arabic | Regular (400), Medium (500) | Noto Sans Arabic, Amiri, sans-serif |
| **Monospace** | Noto Sans Arabic Mono | Regular (400) | Courier New, monospace |

**Why This Combination:**
- **Cairo** for headings: Modern geometric Arabic typeface with strong vertical metrics and clear letterforms. It reads confidently at display sizes and pairs well with Inter for mixed-language UIs.
- **Noto Naskh Arabic** for body: The Naskh style is the most familiar reading script for Arabic users. Noto Naskh Arabic has excellent glyph coverage, proper diacritical mark (tashkeel) positioning, and is optimized for screen rendering at body sizes.
- **Tajawal** as first fallback for headings: A clean Arabic alternative with good weight range.

### 3.3 Bahasa Melayu Fonts

Bahasa Melayu uses the Latin script. It shares the English font stack:

| Role | Font Family | Notes |
|------|------------|-------|
| **Headings** | Inter | Same as English. Malay uses no special diacritics beyond standard Latin. |
| **Body** | Inter / Noto Sans | Noto Sans provides broader glyph coverage if any loanwords use extended characters. |
| **Monospace** | JetBrains Mono | Same as English. |

**Malay Text Length Note:** Bahasa Melayu text is approximately 10-20% longer than equivalent English strings. All text containers must accommodate this expansion. Design with `maxLines` and `overflow: TextOverflow.ellipsis` as safety nets, but prefer containers that flex to fit.

### 3.4 Type Scale

All sizes in `sp` (scale-independent pixels) for Flutter. Line heights are expressed as multipliers.

| Style | Size (sp) | Weight | Line Height | Letter Spacing | Usage |
|-------|:---------:|:------:|:-----------:|:--------------:|-------|
| **H1 / Display** | 32 | Bold (700) | 1.25 (40sp) | -0.02em | Splash screen title, onboarding hero text |
| **H2 / Headline** | 24 | SemiBold (600) | 1.33 (32sp) | -0.01em | Screen titles, section headers |
| **H3 / Title Large** | 20 | SemiBold (600) | 1.40 (28sp) | 0em | Card titles, dialog titles, module headers |
| **H4 / Title Medium** | 18 | Medium (500) | 1.44 (26sp) | 0em | Subsection titles, prominent labels |
| **H5 / Title Small** | 16 | SemiBold (600) | 1.50 (24sp) | 0.01em | List item titles, tab labels |
| **H6 / Label Large** | 14 | SemiBold (600) | 1.43 (20sp) | 0.01em | Input labels, small headers |
| **Body 1** | 16 | Regular (400) | 1.50 (24sp) | 0em | Primary body text, descriptions, messages |
| **Body 2** | 14 | Regular (400) | 1.43 (20sp) | 0.01em | Secondary body text, card descriptions |
| **Caption** | 12 | Regular (400) | 1.33 (16sp) | 0.03em | Timestamps, helper text, footnotes |
| **Overline** | 11 | Medium (500) | 1.45 (16sp) | 0.08em | Category labels, section dividers. UPPERCASE for English/Malay. |
| **Button** | 14 | SemiBold (600) | 1.14 (16sp) | 0.02em | Button text, all variants |

### 3.5 Arabic Type Scale Adjustments

Arabic text requires different sizing and spacing due to its cursive connected script and diacritical marks:

| Style | English Size (sp) | Arabic Size (sp) | Arabic Line Height | Notes |
|-------|:-----------------:|:-----------------:|:------------------:|-------|
| H1 / Display | 32 | 34 | 1.40 (48sp) | Arabic glyphs are denser; +2sp for legibility |
| H2 / Headline | 24 | 26 | 1.46 (38sp) | |
| H3 / Title Large | 20 | 22 | 1.50 (33sp) | |
| Body 1 | 16 | 17 | 1.65 (28sp) | Arabic body must never go below 16sp |
| Body 2 | 14 | 15 | 1.60 (24sp) | |
| Caption | 12 | 13 | 1.54 (20sp) | Minimum Arabic caption size |
| Overline | 11 | 12 | 1.50 (18sp) | No UPPERCASE for Arabic (no case distinction) |
| Button | 14 | 15 | 1.20 (18sp) | |

### 3.6 Line Height Rules

| Script | Minimum Line Height | Recommended | Maximum |
|--------|:-------------------:|:-----------:|:-------:|
| English / Malay (Latin) | 1.25x | 1.50x (body) | 1.75x |
| Arabic | 1.40x | 1.65x (body) | 1.85x |
| Mixed (Arabic with English inline) | 1.50x | 1.65x | 1.85x |

### 3.7 Letter Spacing

| Style | English/Malay | Arabic |
|-------|:------------:|:------:|
| Display/Headline | -0.02em to -0.01em (tighter) | 0em (never tighten Arabic) |
| Body | 0em to 0.01em | 0em |
| Caption/Overline | 0.03em to 0.08em (wider) | 0em to 0.02em |
| Button | 0.02em | 0em |

**Critical Arabic Rule:** Never apply negative letter-spacing to Arabic text. Arabic letterforms connect and negative spacing breaks the visual connection between glyphs, rendering text illegible.

### 3.8 Font Weight Usage

| Weight | Value | Usage |
|--------|:-----:|-------|
| **Regular** | 400 | Body text, descriptions, long-form content, input values |
| **Medium** | 500 | Overlines, emphasized body text, subtitle text, input labels |
| **SemiBold** | 600 | Section titles, button text, tab labels, card titles, badges |
| **Bold** | 700 | Display headlines (H1), hero text, impact numbers (streak count, XP totals), level names |

**Weight Hierarchy Rule:** Each screen should use no more than 3 weight variants. Typical pattern: Bold for the page title, SemiBold for section headers and buttons, Regular for body text.

---

## Section 4: Spacing & Layout

### 4.1 8px Grid System

All spacing, sizing, and positioning values snap to the 8px grid. The smallest unit is 4px (half-grid) for fine adjustments like icon padding and dense component internals.

```
Base unit: 8dp
Half unit: 4dp (used sparingly for fine-tuning)
```

### 4.2 Spacing Scale

| Token | Value (dp) | Usage |
|-------|:----------:|-------|
| `space2xs` | 4 | Inner icon padding, dense chip padding, hairline gaps |
| `spaceXs` | 8 | Between icon and label, between stacked chips, input inner padding |
| `spaceSm` | 12 | Between related elements (label and input), card inner element gap |
| `spaceMd` | 16 | Screen horizontal padding, card padding, between sections within a card |
| `spaceLg` | 20 | Between cards in a list, between form fields |
| `spaceXl` | 24 | Between major sections on a screen, before section headers |
| `space2xl` | 32 | Between module sections, top padding below app bar |
| `space3xl` | 40 | Large section separators, before CTAs |
| `space4xl` | 48 | Screen top/bottom padding for full-bleed layouts |
| `space5xl` | 64 | Hero section padding, onboarding vertical centering |

### 4.3 Screen Layout Rules

```
Screen Horizontal Padding: 16dp (EdgeInsetsDirectional.symmetric(horizontal: 16))
Screen Top Padding:        8dp below app bar (content area start)
Screen Bottom Padding:     16dp above bottom nav, 32dp on screens without bottom nav
Safe Area:                 Always respect system safe area insets (notch, home indicator)
```

### 4.4 Card Padding

```
Card Outer Margin:    16dp horizontal (from screen edges), 8dp vertical (between cards)
Card Inner Padding:   16dp all sides
Card Content Gap:     12dp between internal elements (title to subtitle, icon to text)
Card Action Area:     Separated by 1dp border or 8dp padding from content
Card Border Radius:   12dp
Card Border Width:    1dp (using borderDefault color)
Card Min Height:      None (content-driven)
```

### 4.5 Component Spacing Rules

| Context | Spacing Rule |
|---------|-------------|
| **Button in form** | 24dp above the button, separated from the last form field |
| **Button group (horizontal)** | 12dp between buttons |
| **Button group (vertical)** | 8dp between buttons |
| **Form fields (stacked)** | 20dp between fields |
| **Section header to content** | 12dp below the header |
| **List items** | 0dp gap (divider provides visual separation) or 8dp gap for card-style lists |
| **Bottom sheet content** | 24dp top padding, 16dp horizontal, 32dp bottom (above home indicator) |
| **Dialog content** | 24dp all sides |
| **Tab bar to content** | 16dp below tab bar |
| **Chip group** | 8dp horizontal gap, 8dp vertical gap (wrap layout) |
| **Avatar to text** | 12dp horizontal gap |
| **Icon to label** | 8dp horizontal gap |

### 4.6 RTL Layout: EdgeInsetsDirectional Values

All padding and margin values must use `EdgeInsetsDirectional` (not `EdgeInsets`) for automatic RTL mirroring.

```dart
// CORRECT: Adapts automatically for RTL
EdgeInsetsDirectional.only(start: 16, end: 8, top: 12, bottom: 12)
EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8)

// WRONG: Does not adapt for RTL
EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12)
```

**Key Directional Replacements:**

| LTR Property | Directional Equivalent |
|-------------|----------------------|
| `left` | `start` |
| `right` | `end` |
| `Alignment.centerLeft` | `AlignmentDirectional.centerStart` |
| `Alignment.centerRight` | `AlignmentDirectional.centerEnd` |
| `TextAlign.left` | `TextAlign.start` |
| `TextAlign.right` | `TextAlign.end` |
| `BorderRadius.only(topLeft:)` | `BorderRadiusDirectional.only(topStart:)` |

**Symmetric values** (`top`, `bottom`, `horizontal`, `vertical`) do not need directional variants -- they are the same in both LTR and RTL.

### 4.7 Responsive Breakpoints

LOLO is a mobile-first app. These breakpoints support tablet and foldable screen modes:

| Breakpoint | Width Range | Layout Adjustment |
|-----------|------------|-------------------|
| **Compact** | 0-599dp | Single column, full-width cards, standard spacing |
| **Medium** | 600-839dp | Two-column grid for cards, increased horizontal padding (24dp) |
| **Expanded** | 840dp+ | Three-column grid, navigation rail replaces bottom nav, max content width 840dp centered |

---

## Section 5: Component Library

Each component specifies: name, variants, specs, states, and RTL behavior.

---

### 5.1 Buttons

#### Primary Button

| Property | Value |
|----------|-------|
| **Height** | 52dp |
| **Min Width** | 120dp (or full-width where specified) |
| **Horizontal Padding** | 24dp |
| **Border Radius** | 12dp |
| **Background** | `colorPrimary` (#4A90D9) |
| **Text** | White (#FFFFFF), 14sp SemiBold, centered |
| **Icon (optional)** | 20dp, white, 8dp start margin before text |
| **Elevation** | 0dp (flat in dark mode), 2dp in light mode |

**States:**
| State | Specification |
|-------|--------------|
| Default | Background #4A90D9, text white |
| Hover/Focus | Background #5A9DE3 (lightened 10%), border: 2dp #4A90D9 focus ring |
| Pressed | Background #3A7BC8 (darkened 10%), scale 0.98, 100ms |
| Disabled | Background #30363D, text #484F58, no interaction |
| Loading | Background #4A90D9, text replaced with 20dp circular spinner (white) |

**RTL:** Icon moves to end (right in LTR, left in RTL). Text remains centered.

#### Secondary Button

| Property | Value |
|----------|-------|
| **Height** | 52dp |
| **Border** | 1.5dp solid `colorPrimary` |
| **Background** | Transparent |
| **Text** | `colorPrimary` (#4A90D9), 14sp SemiBold |
| **Border Radius** | 12dp |

**States:** Same pattern as Primary. Pressed: background fills at 10% opacity of colorPrimary.

#### Text Button

| Property | Value |
|----------|-------|
| **Height** | 40dp |
| **Background** | Transparent |
| **Text** | `colorPrimary` (#4A90D9), 14sp Medium |
| **Padding** | 8dp horizontal, 8dp vertical |

**States:** Hover shows underline. Pressed reduces opacity to 0.7. Disabled uses textTertiary color.

#### Icon Button

| Property | Value |
|----------|-------|
| **Size** | 48dp x 48dp (touch target) |
| **Icon Size** | 24dp |
| **Background** | Transparent |
| **Icon Color** | `textSecondary` default, `colorPrimary` for active |
| **Border Radius** | 24dp (circular) |

**States:** Hover/pressed shows circular 48dp background at 8% colorPrimary opacity. Focused shows focus ring.

#### Floating Action Button (FAB)

| Property | Value |
|----------|-------|
| **Size** | 56dp x 56dp |
| **Icon Size** | 24dp, white |
| **Background** | `colorPrimary` |
| **Border Radius** | 16dp |
| **Elevation** | 6dp |
| **Position** | 16dp from end edge, 16dp above bottom nav |

**States:** Pressed: scale 0.95, elevation 2dp. Extended FAB: 56dp height, auto-width, 16dp horizontal padding, icon + label.

**RTL:** FAB position mirrors. If positioned at bottom-end (right in LTR), it moves to bottom-start (left in RTL). In LOLO, FAB uses `endFloat` positioning which auto-mirrors.

#### SOS Button (Special Variant)

| Property | Value |
|----------|-------|
| **Height** | 52dp |
| **Background** | `gradientSOS` (linear-gradient #F85149 to #D29922) |
| **Text** | White, 14sp Bold |
| **Border Radius** | 12dp |
| **Icon** | 20dp alert-triangle icon, white, start position |
| **Animation** | Subtle pulse on border (1px red glow, 2s loop) when idle on SOS screen |

---

### 5.2 Cards

#### Action Card (SAY / DO / BUY / GO)

| Property | Value |
|----------|-------|
| **Width** | Full width minus 32dp (screen padding) |
| **Min Height** | 160dp |
| **Padding** | 16dp all sides |
| **Border Radius** | 12dp |
| **Background** | `darkBgTertiary` (#21262D) / `lightSurfaceElevated1` (#FFFFFF) |
| **Border** | 1dp `borderDefault` |
| **Category Badge** | Top-start corner, 8dp padding, 12sp SemiBold, colored per type |

**Category Badge Colors:**
| Type | Badge Background | Badge Text |
|------|:----------------:|:----------:|
| SAY | `#4A90D9` at 15% | `#4A90D9` |
| DO | `#3FB950` at 15% | `#3FB950` |
| BUY | `#C9A96E` at 15% | `#C9A96E` |
| GO | `#A371F7` at 15% | `#A371F7` |

**Layout:**
```
+--[Badge: SAY]----------------[XP: +15]--+
|                                          |
|  Action text (Body 1, textPrimary)       |
|  Supporting detail (Body 2, textSecondary)|
|                                          |
|  Based on: Words of Affirmation          |
|  Difficulty: Easy                        |
|                                          |
|  [Mark Done (Primary)]  [Get Help (Text)]|
+------------------------------------------+
```

**States:**
- Default: As specified above
- Completed: Green border, checkmark overlay at 20% opacity, "Done" label replaces buttons
- Skipped: Dimmed to 50% opacity, strikethrough on action text
- Expanded: Tap reveals additional detail section (slide-down, 300ms)

**RTL:** Full mirror. Badge moves to top-end. XP indicator moves to top-start. Text aligns end. Buttons mirror position.

#### Reminder Card

| Property | Value |
|----------|-------|
| **Width** | Full width minus 32dp |
| **Height** | 80dp |
| **Padding** | 12dp horizontal, 12dp vertical |
| **Border Radius** | 12dp |
| **Background** | `darkBgTertiary` |
| **Left/Start Accent** | 4dp wide bar, colored by urgency (green=future, amber=soon, red=today/overdue) |

**Layout:**
```
[Accent Bar] [Icon 32dp] [Title + Date]  [Days Badge]
```

**States:**
- Upcoming (7+ days): Green accent, normal text
- Approaching (3-6 days): Amber accent, medium weight title
- Imminent (1-2 days): Red accent, bold title
- Today: Red accent, pulsing, bold title, "TODAY" badge
- Overdue: Red accent, red text, "OVERDUE" badge

#### Message Card

| Property | Value |
|----------|-------|
| **Width** | Full width minus 32dp |
| **Padding** | 16dp |
| **Border Radius** | 12dp |
| **Background** | `darkBgTertiary` |

**Layout:**
```
[AI icon 24dp] [Generated for: Mode name]    [Time]
[Message text, Body 1, up to 4 lines with ellipsis]
[Copy button]  [Share button]  [Feedback: thumbs]
```

**States:** Default, copied (brief green checkmark flash), shared, rated.

#### Gift Card

| Property | Value |
|----------|-------|
| **Width** | 160dp (horizontal scroll) or full-width (list view) |
| **Height** | 200dp (scroll) or 96dp (list) |
| **Image Area** | 120dp height (scroll) or 72dp square (list) |
| **Border Radius** | 12dp |
| **Background** | `darkBgTertiary` |

**Layout (scroll):**
```
+----------------------------+
| [Image area, fill, 120dp]  |
| Gift name (Body 2, bold)   |
| Price range (Caption, gold) |
| [Why this gift] (link)     |
+----------------------------+
```

#### Profile Card (Her Profile Summary)

| Property | Value |
|----------|-------|
| **Width** | Full width minus 32dp |
| **Padding** | 20dp |
| **Border Radius** | 16dp |
| **Background** | Gradient from `darkBgSecondary` to `darkBgTertiary` |
| **Avatar** | 64dp, circular, centered or start-aligned |

**Layout:**
```
[Avatar 64dp]  [Name, H3]  [Zodiac icon + sign]
               [Love Language badge]
               [Relationship status]
[Profile completion progress bar, full width]
[65% complete -- finish her profile]
```

---

### 5.3 Input Fields

#### Text Input

| Property | Value |
|----------|-------|
| **Height** | 52dp |
| **Padding** | 16dp horizontal |
| **Border Radius** | 8dp |
| **Border** | 1dp `borderDefault`, 2dp `borderAccent` on focus |
| **Background** | `darkBgTertiary` / `lightBgTertiary` |
| **Text** | 16sp Regular, `textPrimary` |
| **Label** | 12sp Medium, `textSecondary`, floating above on focus/filled |
| **Placeholder** | 16sp Regular, `textTertiary` |

**States:**
| State | Border | Background | Label |
|-------|--------|-----------|-------|
| Default (empty) | `borderDefault` | `darkBgTertiary` | Placeholder visible |
| Focused (empty) | 2dp `borderAccent` | `darkBgTertiary` | Label floats up, colorPrimary |
| Focused (filled) | 2dp `borderAccent` | `darkBgTertiary` | Label floated, colorPrimary |
| Filled (unfocused) | `borderDefault` | `darkBgTertiary` | Label floated, textSecondary |
| Error | 2dp `colorError` | `darkBgTertiary` | Label floated, colorError |
| Disabled | `borderMuted` | `darkBgSecondary` at 50% | textDisabled |

**Error State Additional:** 4dp below the input, show error message in 12sp, colorError, with a 16dp error icon inline.

**RTL:** Text input direction follows the content language. Arabic text entry is RTL. Floating label animates to top-end. Helper/error text aligns to start.

#### Dropdown / Select

| Property | Value |
|----------|-------|
| **Height** | 52dp (trigger), variable (menu) |
| **Trigger** | Same as text input with chevron-down icon (20dp) at end |
| **Menu** | `darkSurfaceElevated2`, 8dp radius, 4dp elevation, max height 280dp (scrollable) |
| **Menu Item** | 48dp height, 16dp horizontal padding, Body 2 text |

**States:** Same as text input. Selected item shows checkmark at end.

#### Date Picker

Follows Material 3 DatePicker defaults with LOLO color tokens applied:
- Header background: `colorPrimary`
- Selected date: `colorPrimary` circle
- Today: `colorPrimary` outlined circle
- Calendar grid: `textPrimary` for days, `textTertiary` for other-month days

**Arabic Date Picker:** Supports Hijri calendar option. Date format: DD/MM/YYYY. Week starts on Saturday (configurable).

#### Slider

| Property | Value |
|----------|-------|
| **Track Height** | 4dp |
| **Active Track** | `colorPrimary` |
| **Inactive Track** | `borderDefault` |
| **Thumb** | 20dp circle, `colorPrimary`, 2dp white border |
| **Value Label** | Tooltip above thumb, `darkSurfaceElevated2`, Body 2 text |

**RTL:** Slider direction reverses. Min value at end (right), max at start (left).

#### Toggle / Switch

| Property | Value |
|----------|-------|
| **Track Size** | 52dp x 32dp |
| **Thumb Size** | 24dp circle |
| **Track Off** | `borderDefault` background |
| **Track On** | `colorPrimary` background |
| **Thumb Off** | `gray5` |
| **Thumb On** | White |
| **Animation** | 200ms ease-out slide |

**RTL:** On position moves to start (left in RTL). Off moves to end.

---

### 5.4 Navigation

#### Bottom Navigation Bar

| Property | Value |
|----------|-------|
| **Height** | 64dp (excluding safe area) |
| **Background** | `darkBgSecondary` / `lightBgSecondary` |
| **Top Border** | 1dp `borderMuted` |
| **Items** | 5 tabs: Home, Messages, Gifts, Memories, Profile |
| **Icon Size** | 24dp |
| **Label** | 12sp Medium |
| **Active Color** | `colorPrimary` (icon + label) |
| **Inactive Color** | `textTertiary` (icon + label) |
| **Active Indicator** | Pill shape behind icon, `colorPrimary` at 12% opacity, 32dp x 56dp, 16dp radius |
| **Touch Target** | Each tab = screen width / 5, full 64dp height |

**RTL:** Tab order reverses visually. Home is rightmost in RTL. Internal icon mirroring follows Section 6 rules.

#### App Bar

| Property | Value |
|----------|-------|
| **Height** | 56dp |
| **Background** | `darkBgSecondary` / `lightBgSecondary` |
| **Title** | 18sp SemiBold, `textPrimary`, centered or start-aligned (per screen) |
| **Leading Icon** | 48dp touch target, 24dp icon, back arrow or menu |
| **Trailing Actions** | Up to 2 icon buttons, 48dp each, 8dp gap |
| **Elevation** | 0dp (flat, border separates from content) |
| **Bottom Border** | 1dp `borderMuted` |

**RTL:** Leading icon moves to end (right). Trailing actions move to start (left). Title alignment mirrors. Back arrow icon reverses direction (points right in RTL).

#### Tabs (Horizontal)

| Property | Value |
|----------|-------|
| **Height** | 48dp |
| **Background** | Transparent (sits on app bar or surface) |
| **Active Tab Text** | 14sp SemiBold, `colorPrimary` |
| **Inactive Tab Text** | 14sp Medium, `textSecondary` |
| **Indicator** | 3dp bottom bar, `colorPrimary`, full tab width, 200ms slide animation |
| **Tab Padding** | 16dp horizontal |
| **Scrollable** | Yes, if more than 3 tabs |

**RTL:** Tab order reverses. Indicator animates in reverse direction.

---

### 5.5 Bottom Sheets

| Property | Value |
|----------|-------|
| **Background** | `darkSurfaceElevated1` / `lightSurfaceElevated1` |
| **Border Radius** | 16dp top-start, 16dp top-end, 0 bottom |
| **Handle** | 40dp x 4dp, `gray5` centered, 8dp from top |
| **Content Padding** | 24dp top (below handle), 16dp horizontal, 32dp bottom |
| **Scrim** | `surfaceOverlay` (70% opacity dark) |
| **Max Height** | 90% of screen height |
| **Animation** | Slide up 300ms, ease-out-cubic |
| **Drag** | Swipe down to dismiss, velocity threshold: 300px/s |

**RTL:** No directional change needed (bottom sheets are vertically oriented). Content inside mirrors per its own rules.

---

### 5.6 Dialogs / Modals

| Property | Value |
|----------|-------|
| **Width** | Screen width minus 48dp (24dp margin each side), max 400dp |
| **Background** | `darkSurfaceElevated1` / `lightSurfaceElevated1` |
| **Border Radius** | 16dp |
| **Padding** | 24dp all sides |
| **Title** | 18sp SemiBold, `textPrimary` |
| **Body** | 14sp Regular, `textSecondary`, 8dp below title |
| **Actions** | Right/end-aligned buttons, 12dp gap, 16dp above bottom edge |
| **Scrim** | `surfaceOverlay` |
| **Animation** | Fade in + scale from 0.95, 200ms |

**Standard Dialog Variants:**
- **Confirmation:** Title + body + Cancel (text) + Confirm (primary)
- **Destructive:** Title + body + Cancel (text) + Delete (error-colored primary)
- **Information:** Title + body + OK (primary)

**RTL:** Button order may reverse per platform conventions. In Material, the affirmative action stays at the end. Title and body text align to start (right in RTL).

---

### 5.7 Chips / Tags

| Property | Value |
|----------|-------|
| **Height** | 32dp |
| **Horizontal Padding** | 12dp |
| **Border Radius** | 16dp (pill shape) |
| **Border** | 1dp `borderDefault` |
| **Background** | Transparent (unselected), `colorPrimary` at 12% (selected) |
| **Text** | 13sp Medium, `textSecondary` (unselected), `colorPrimary` (selected) |
| **Icon (optional)** | 16dp, 4dp gap from text, at start position |
| **Close Icon (filter chips)** | 16dp x icon at end, 4dp gap |
| **Min Touch Target** | 32dp height already meets minimum with surrounding spacing |

**Variants:**
- **Filter Chip:** Toggleable, shows checkmark when selected
- **Input Chip:** Shows remove (x) icon. Used for tags in Memory Vault.
- **Suggestion Chip:** Text-only, outlined. Used for AI message mode selection.
- **Category Chip:** Colored per category. Used for action card type filters (SAY/DO/BUY/GO with respective colors).

**RTL:** Icon and close icon swap positions. Text aligns to start.

---

### 5.8 Progress Indicators

#### Streak Counter

| Property | Value |
|----------|-------|
| **Layout** | Horizontal: flame icon (24dp) + count (H3 Bold) + "day streak" label (Body 2) |
| **Flame Icon Color** | Orange gradient when active (#D29922 to #F85149), gray6 when broken |
| **Count Color** | `colorAccent` (gold) when active, `textTertiary` when zero |
| **Background** | Optional container: `darkBgTertiary`, 12dp radius, 12dp padding |
| **Milestone Glow** | At 7, 14, 30, 60, 100 days: gold glow pulse animation on the flame icon, 600ms |

#### Level Progress Bar

| Property | Value |
|----------|-------|
| **Height** | 8dp |
| **Border Radius** | 4dp |
| **Track Background** | `borderDefault` |
| **Fill** | `gradientPremium` (blue to gold) |
| **Label Above** | "Level {n}: {title}" (H6) start-aligned, "{current}/{needed} XP" (Caption) end-aligned |
| **Animation** | Fill animates on XP gain, 500ms ease-out |

#### Relationship Consistency Score Ring

| Property | Value |
|----------|-------|
| **Size** | 120dp x 120dp |
| **Track** | 8dp stroke, `borderDefault` |
| **Fill** | 8dp stroke, color varies by score: 0-39 `colorError`, 40-69 `colorWarning`, 70-100 `colorSuccess` |
| **Center Label** | Score number (H1 Bold), "/100" (Caption) below |
| **Animation** | Ring fills clockwise from top, 800ms ease-out on screen entry |

**RTL:** Ring fills counter-clockwise (from top, going left).

---

### 5.9 Avatar / Profile Image

| Property | Value |
|----------|-------|
| **Sizes** | 24dp (inline), 40dp (list), 64dp (profile header), 96dp (profile edit) |
| **Shape** | Circle |
| **Border** | 2dp white (on image backgrounds), none (on surface backgrounds) |
| **Placeholder** | First letter of name, centered, colorPrimary background, white text |
| **Placeholder Text Size** | 12sp (24dp), 16sp (40dp), 24sp (64dp), 32sp (96dp) |
| **Edit Overlay** | Camera icon, 24dp, circular dark overlay at 50% opacity on bottom-right |

**RTL:** Edit overlay moves to bottom-left in RTL.

---

### 5.10 Badge / Achievement Component

| Property | Value |
|----------|-------|
| **Size** | 64dp x 64dp (standard), 96dp x 96dp (detail view) |
| **Shape** | Shield/hexagonal outline (masculine, badge-like) |
| **Background** | `gradientAchievement` for unlocked, `gray7` for locked |
| **Icon** | 32dp centered custom icon per achievement |
| **Border** | 2dp `colorAccent` (unlocked), 1dp `borderDefault` (locked) |
| **Locked Overlay** | Lock icon 16dp centered, 50% dark overlay |
| **Label Below** | Achievement name, Caption SemiBold, centered, max 2 lines |

**Achievement Badge Layout (in grid):**
```
[Shield]  [Shield]  [Shield]
  Name      Name      Name
[Shield]  [Shield]  [Shield]
  Name      Name      Name
```

Grid: 3 columns, 16dp gap, center-aligned within each cell.

---

### 5.11 Notification Banner (In-App)

| Property | Value |
|----------|-------|
| **Height** | Auto (content-driven), min 56dp |
| **Width** | Full width minus 16dp (8dp margin each side) |
| **Position** | Top of screen, overlapping content, 8dp below status bar |
| **Background** | `darkSurfaceElevated2` with 1dp border |
| **Border Radius** | 12dp |
| **Padding** | 12dp |
| **Layout** | [Icon 24dp] [Title (Body 2 SemiBold) + Message (Caption)] [Close X 20dp] |
| **Animation** | Slide down from top, 300ms. Auto-dismiss after 4 seconds. Swipe up to dismiss. |

**Variants by severity:**
| Severity | Icon | Accent Color (left border 3dp) |
|----------|------|-------------------------------|
| Success | Checkmark circle | `colorSuccess` |
| Warning | Alert triangle | `colorWarning` |
| Error | X circle | `colorError` |
| Info | Info circle | `colorInfo` |

**RTL:** Layout mirrors. Icon at end, close at start. Left accent border becomes right border.

---

### 5.12 Empty State Component

| Property | Value |
|----------|-------|
| **Layout** | Centered vertically in available space |
| **Illustration** | 120dp x 120dp, abstract geometric (not cute characters) |
| **Title** | H4, `textPrimary`, centered, max 2 lines |
| **Description** | Body 2, `textSecondary`, centered, max 3 lines, 8dp below title |
| **CTA Button** | Primary or Secondary button, 16dp below description |
| **Padding** | 32dp horizontal |

**Per-Screen Empty States:**

| Screen | Illustration | Title | CTA |
|--------|-------------|-------|-----|
| Reminders | Calendar with dots | "No reminders yet" | "Add Your First Reminder" |
| Messages | Message bubble outline | "No messages yet" | "Generate Your First Message" |
| Memory Vault | Vault/box outline | "Your vault is empty" | "Add a Memory" |
| Gift History | Gift box outline | "No gifts tracked yet" | "Get Gift Ideas" |
| Action Cards | Cards stack outline | "No cards today" | "Check back tomorrow" (text, no button) |
| Wish List | Star outline | "No wishes captured yet" | "Add to Wish List" |

---

### 5.13 Loading Skeleton

| Property | Value |
|----------|-------|
| **Background** | `darkBgTertiary` / `lightBgTertiary` |
| **Shimmer Animation** | `gradientShimmer` sweeps left-to-right (or right-to-left for RTL), 1500ms loop |
| **Shape Match** | Skeleton shapes match the actual component shapes (text line = rounded rect, avatar = circle, card = rounded rect) |
| **Text Line Height** | 12dp (simulating body text), 4dp vertical gap |
| **Title Line Width** | 60% of container width |
| **Body Line Width** | 100% for first 2 lines, 80% for last line |
| **Border Radius** | 4dp for text lines, 12dp for card outlines, circular for avatars |

**RTL:** Shimmer animation direction reverses (sweeps right-to-left for LTR, left-to-right for RTL).

**Skeleton Templates Needed:**
- Dashboard home (action card skeleton + reminders skeleton + streak skeleton)
- Card list (3 stacked card skeletons)
- Message result (message bubble skeleton with 3 text lines)
- Profile card (avatar circle + 3 text lines)
- Gift grid (2x2 grid of image placeholder + text line skeletons)

---

## Section 6: Iconography

### 6.1 Icon Style

| Property | Specification |
|----------|--------------|
| **Style** | Outlined (default/inactive), Filled (active/selected) |
| **Stroke Weight** | 1.5px consistent across all icons |
| **Corner Radius** | 2px on stroke terminals |
| **Grid** | 24dp x 24dp base with 2dp optical padding |
| **Source** | Phosphor Icons (primary library) + custom LOLO icons for app-specific concepts |
| **Format** | SVG for design, Flutter `Icon` or custom SVG render for implementation |

**Style Rationale:** Outlined icons feel cleaner, more professional, and less "cute" than filled icons. Filled variants are reserved for active/selected states in navigation, creating a clear visual distinction.

### 6.2 Icon Sizes

| Size Token | Value (dp) | Usage |
|-----------|:----------:|-------|
| `iconSm` | 16 | Inline with caption text, chip icons, dense lists |
| `iconMd` | 20 | Inline with body text, input field trailing icons, small buttons |
| `iconStd` | 24 | Standard icon size: navigation, app bar actions, card icons, list leading icons |
| `iconLg` | 32 | Feature icons on cards, category icons, empty state supporting elements |
| `iconXl` | 48 | Onboarding feature icons, zodiac wheel icons, standalone feature callouts |

### 6.3 Custom LOLO Icons

These icons are needed beyond the standard Phosphor library:

| Icon Name | Description | Size(s) | Usage |
|-----------|------------|---------|-------|
| `lolo_compass` | Brand compass mark adapted as icon | 24, 32 | App bar logo, splash, loading |
| `lolo_sos_shield` | Shield with exclamation mark | 24, 32 | SOS mode trigger, SOS navigation |
| `lolo_streak_flame` | Stylized flame (not literal fire) | 24, 32 | Streak counter, gamification |
| `lolo_action_say` | Speech bubble with sound wave | 24 | SAY action card badge |
| `lolo_action_do` | Checkmark inside a gear/hand | 24 | DO action card badge |
| `lolo_action_buy` | Shopping bag with sparkle | 24 | BUY action card badge |
| `lolo_action_go` | Location pin with arrow | 24 | GO action card badge |
| `lolo_vault` | Locked box/safe | 24, 32 | Memory Vault icon |
| `lolo_zodiac_*` | 12 zodiac symbols (simplified, geometric) | 24, 40 | Her Profile zodiac selector, profile card |
| `lolo_love_lang_*` | 5 love language icons (words, acts, gifts, time, touch) | 24, 32 | Love language selector, profile card |
| `lolo_level_badge` | Shield outline for level display | 32, 64 | Gamification dashboard, profile |
| `lolo_xp_star` | Angular star (not rounded) | 16, 24 | XP gain indicators |
| `lolo_promise` | Handshake or pinky promise (abstract) | 24 | Promise tracker |
| `lolo_wish` | Star with trailing sparkle | 24 | Wish list |
| `lolo_gift_score` | Gift box with thumbs up/down | 24 | Gift feedback |

### 6.4 RTL Icon Mirroring Rules

**Icons That MUST Mirror in RTL:**

| Icon | Reason |
|------|--------|
| Arrow back / forward | Directional navigation |
| Chevron left / right | Directional progression |
| Send / reply | Directional action |
| Redo / undo | Directional action |
| Text indent / outdent | Directional formatting |
| Exit / logout | Directional metaphor (leaving) |
| Progress arrows | Directional progression |
| List bullet | Text direction indicator |

**Icons That Must NOT Mirror in RTL:**

| Icon | Reason |
|------|--------|
| Search (magnifying glass) | Handle direction is arbitrary, universally understood |
| Checkmark | Universal symbol, no directionality |
| Close (X) | Universal symbol |
| Add (+) / Remove (-) | Universal symbol |
| Clock / time | Clockwise is universal |
| Play / pause / stop | Media controls are universally LTR |
| Volume / speaker | Physical speaker orientation is universal |
| Lock / unlock | Physical object, no text direction |
| Camera / photo | Physical object |
| Heart / star / flag | Universal symbols |
| Download / upload | Vertical direction, not horizontal |
| Sort / filter | Abstract concept |
| Settings gear | Rotational symmetry |
| LOLO brand compass | Brand mark, never mirrors |
| Zodiac symbols | Universal astronomical symbols |

**Flutter Implementation:**
```dart
// Use matchTextDirection property on directional icons
Icon(Icons.arrow_back, textDirection: TextDirection.ltr) // Force LTR for non-mirroring
// Or use Directionality widget for automatic handling
```

---

## Section 7: Animation & Motion

### 7.1 Animation Philosophy

LOLO's motion language is **confident, purposeful, and restrained**. Animations serve three functions:

1. **Feedback** -- Confirming user actions (button press, card completion, message copied)
2. **Transition** -- Guiding attention between states (page change, bottom sheet reveal, card expansion)
3. **Celebration** -- Rewarding achievements (level up, streak milestone, first action card)

Animations must never feel "bouncy," "sparkly," or "cute." They should feel like a premium financial app or a fitness tracker -- smooth, fast, satisfying.

### 7.2 Duration Scale

| Token | Duration | Usage |
|-------|:--------:|-------|
| `durationInstant` | 100ms | Toggle state, checkbox, radio select, small icon transitions |
| `durationFast` | 150ms | Button press feedback (scale), chip select, tab indicator slide |
| `durationQuick` | 200ms | Icon button ripple, tooltip appear, hover state |
| `durationNormal` | 300ms | Page transitions, bottom sheet slide, card expand/collapse, modal appear |
| `durationSlow` | 500ms | Celebration pulse, progress bar fill, skeleton shimmer cycle element |
| `durationCinematic` | 800ms | Level-up animation, achievement unlock, first-value-moment card reveal |
| `durationExtended` | 1500ms | Skeleton shimmer full cycle, score ring fill on screen load |

### 7.3 Easing Curves

| Token | Curve | CSS Equivalent | Usage |
|-------|-------|---------------|-------|
| `easeDefault` | `Curves.easeOutCubic` | `cubic-bezier(0.33, 1, 0.68, 1)` | Default for all animations. Natural deceleration. |
| `easeEnter` | `Curves.decelerate` | `cubic-bezier(0, 0, 0.2, 1)` | Elements entering the screen (bottom sheet, dialog, notification) |
| `easeExit` | `Curves.easeInCubic` | `cubic-bezier(0.32, 0, 0.67, 0)` | Elements leaving the screen (dismiss, navigate away) |
| `easeEmphasis` | `Curves.easeInOutCubic` | `cubic-bezier(0.65, 0, 0.35, 1)` | Emphasis transitions: card flip, tab switch, mode change |
| `easeBounce` | `Curves.elasticOut` | Custom | Used ONLY for gamification rewards: XP pop, level-up badge scale. Never for UI navigation. |

### 7.4 Micro-Interactions

#### Button Press
```
Trigger:    onTapDown
Animation:  scale to 0.97, 100ms, easeDefault
Release:    scale to 1.00, 150ms, easeDefault
Haptic:     Light impact (HapticFeedback.lightImpact)
```

#### Card Swipe (Action Cards)
```
Gesture:    Horizontal swipe on action card stack
Threshold:  40% of card width to commit
Animation:  Card slides off-screen with rotation (5deg), 300ms, easeExit
Next card:  Scales from 0.95 to 1.00, fades from 0.8 to 1.0, 300ms, easeEnter
Cancel:     Card springs back to center, 200ms, easeDefault
Haptic:     Medium impact on commit (HapticFeedback.mediumImpact)
```

**RTL:** Swipe direction semantics reverse. "Next" is swipe-left in RTL (instead of swipe-right in LTR). The card flies off the opposite direction.

#### Streak Animation
```
Trigger:    Daily first action completion
Animation:  Flame icon scales 1.0 -> 1.3 -> 1.0, 500ms, easeEmphasis
            Count increments with a roll-up counter effect
            Gold glow pulse on the streak container, 600ms
            At milestones (7, 14, 30, 60, 100): extended gold particle burst, 800ms
Haptic:     Success notification (HapticFeedback.heavyImpact) at milestones
```

#### Level Up
```
Trigger:    XP crosses level threshold
Animation:  Full-screen overlay, darkSurfaceOverlay backdrop
            Shield badge scales in from 0.5, 800ms, easeBounce
            Level name types in letter-by-letter, 50ms per character
            Gold gradient sweep across badge, 500ms
            "+[New Title]" text fades up, 300ms
            Auto-dismiss after 3 seconds or tap
Haptic:     Heavy impact + success pattern
```

#### Message Copied
```
Trigger:    Tap copy button on AI message
Animation:  Button icon morphs from copy to checkmark, 200ms
            Button text changes "Copy" to "Copied!", colorSuccess
            Brief green flash on the message card border, 300ms
            Revert to copy icon after 2 seconds
Haptic:     Light impact
```

#### XP Gain
```
Trigger:    Any XP-awarding action
Animation:  "+{n} XP" text floats upward from the action point, fading out
            Duration: 500ms
            Movement: 40dp upward
            Level bar fills proportionally, 500ms, easeDefault
Haptic:     Selection feedback (HapticFeedback.selectionClick)
```

### 7.5 Page Transitions

| Transition Type | Usage | Animation |
|----------------|-------|-----------|
| **Shared Axis (Horizontal)** | Peer navigation: tab switches, card stack browsing | Outgoing fades + slides start, incoming fades + slides from end. 300ms, easeEmphasis |
| **Shared Axis (Vertical)** | Hierarchy navigation: list to detail, dashboard to module | Outgoing fades + slides up, incoming fades + slides from bottom. 300ms, easeEmphasis |
| **Fade Through** | Unrelated screens: settings sections, onboarding steps | Outgoing fades out, brief pause, incoming fades in. 300ms total, easeDefault |
| **Container Transform** | Card to full-screen: action card to detail, gift card to gift page | Card expands to fill screen, content cross-fades. 300ms, easeEmphasis |

**RTL:** Horizontal shared axis reverses direction. Vertical and fade transitions are direction-neutral.

### 7.6 Loading Animations

| Element | Animation |
|---------|-----------|
| **Skeleton Shimmer** | Gradient sweep across skeleton shapes. 1500ms loop, linear. Direction: start-to-end (reverses for RTL). |
| **Pull to Refresh** | Custom LOLO compass icon spins on pull, snaps to determinate spinner on release. 300ms pull threshold. |
| **Button Loading** | Text fades out (100ms), circular progress indicator fades in (100ms), all within button bounds. |
| **Full Screen Loading** | LOLO compass mark pulses (scale 0.9 to 1.1, 800ms loop), centered, darkBgPrimary background. |
| **AI Generating** | Three dots typing indicator with wave motion (each dot delays 150ms). Text below: "Crafting your message..." |

---

## Section 8: Dark Mode

### 8.1 Design Philosophy

Dark mode is the default theme for LOLO. This decision is driven by:
- Male users strongly prefer dark mode (65%+ preference in the 22-55 demographic per UX research)
- Dark mode passes the "glance test" more effectively (looks like a premium productivity tool)
- Better contrast ratios are naturally achieved with light text on dark backgrounds
- Evening/bedtime is prime relationship app usage time; dark mode reduces eye strain
- OLED screen battery savings

Light mode is available as a user preference but all designs are created dark-first.

### 8.2 Elevation-Based Surface Colors

In dark mode, Material Design 3 uses surface tint (a translucent overlay of the primary color) to indicate elevation. LOLO uses a simplified 3-tier system with distinct background colors instead of tint overlays, for clearer visual hierarchy:

| Elevation Level | Background | Usage | Material Equivalent |
|----------------|-----------|-------|-------------------|
| **Level 0 (Canvas)** | `#0D1117` | Main app background, scrollable content area | Surface |
| **Level 1 (Raised)** | `#161B22` | App bar, bottom nav, toolbars | Surface + tint level 1 |
| **Level 2 (Card)** | `#21262D` | Cards, input fields, list items, bottom sheet | Surface + tint level 2 |
| **Level 3 (Floating)** | `#282E36` | Dialogs, elevated cards, popovers | Surface + tint level 3 |
| **Level 4 (Overlay)** | `#30363D` | Tooltips, dropdown menus, temporary surfaces | Surface + tint level 4 |

**Shadows in Dark Mode:** Shadows are nearly invisible in dark mode. Rely on surface color differentiation and 1dp borders (`borderDefault`) to create visual separation between layers.

### 8.3 Text Color Adjustments

| Text Role | Dark Mode | Light Mode | Notes |
|-----------|-----------|-----------|-------|
| Primary | `#F0F6FC` (near-white) | `#1F2328` (near-black) | Never use pure #FFFFFF -- it creates excessive contrast and eye strain |
| Secondary | `#8B949E` (medium gray) | `#656D76` | Reduced emphasis but still legible |
| Tertiary | `#484F58` (dark gray) | `#8C959F` | Hints and placeholders only |
| On Primary (button text) | `#FFFFFF` | `#FFFFFF` | White on colorPrimary button in both modes |
| On Error (error button) | `#FFFFFF` | `#FFFFFF` | White on error-colored elements |
| Link | `#4A90D9` | `#0969DA` | Slightly different blue optimized per mode |
| Accent | `#C9A96E` | `#9A7B4F` | Gold darkened slightly for light mode contrast |

### 8.4 Image and Illustration Treatment

| Content Type | Dark Mode Treatment | Light Mode Treatment |
|-------------|-------------------|---------------------|
| **User Photos (avatar, memories)** | Display as-is. No filter. 2dp border for separation from dark background. | Display as-is. Subtle 1dp border or shadow. |
| **Illustrations (empty states, onboarding)** | Use dark-optimized variants: lighter strokes, reduced saturation, no pure white fills. | Use light-optimized variants: standard saturation, dark strokes. |
| **Icons** | Use `textPrimary` (#F0F6FC) or `textSecondary` (#8B949E) for icon colors. Never use pure white. | Use `textPrimary` (#1F2328) or `textSecondary` (#656D76). |
| **Charts/Graphs** | Use accent colors (#4A90D9, #C9A96E, #3FB950) against dark background. Grid lines in `borderMuted`. | Same accent colors. Grid lines in `borderDefault`. |
| **Achievement Badges** | Gold gradient remains the same (`gradientAchievement`). Locked badges use `gray7` (#21262D). | Gold gradient unchanged. Locked badges use `gray9` (#EAEEF2). |
| **Gift Product Images** | Display as-is, with 1dp border and 8dp radius clip for consistency. | Display as-is with subtle shadow. |

### 8.5 Accessibility in Dark Mode

| Concern | Solution |
|---------|---------|
| **Contrast on dark surfaces** | All text/background combinations verified to meet WCAG AA (see Section 2.8). Dark mode naturally achieves high contrast. |
| **Color-blind users** | Never rely on color alone. Pair every color indicator with an icon, label, or pattern. Test with protanopia, deuteranopia, and tritanopia filters. |
| **Motion sensitivity** | Provide a "Reduce Motion" toggle in Settings that: disables celebration animations, reduces page transitions to instant cuts, disables skeleton shimmer, and replaces the streak flame animation with a static icon. Respect system `prefers-reduced-motion`. |
| **Font scaling** | All text uses `sp` units. Layouts must remain functional up to 200% system font scale. Test at 100%, 150%, and 200%. At 200%, accept layout degradation but maintain functionality. |
| **Touch targets** | Minimum 48dp x 48dp for all interactive elements. In dark mode, ensure touch target boundaries are visible (use borders or distinct background colors, not just shadows). |
| **Screen reader support** | All images have `semanticLabel`. All buttons have `tooltip` or `Semantics` labels. Action cards read their full content including type, action text, difficulty, and XP value. Navigation announces screen names on transition. |
| **High contrast mode** | Support platform high-contrast mode by increasing border widths to 2dp and using pure #000000 / #FFFFFF when system accessibility settings request it. |

### 8.6 Theme Switching

Users can switch between dark and light mode in Settings. The switch is also available during onboarding.

**Options:**
1. **System (default)** -- Follow device system theme
2. **Dark** -- Always dark mode
3. **Light** -- Always light mode

**Transition:** When switching themes, apply a 300ms cross-fade animation on the entire app canvas. Do not use a harsh instant switch.

```dart
// Theme provider (simplified)
enum ThemeMode { system, dark, light }

// In MaterialApp
MaterialApp(
  themeMode: userThemePreference,
  theme: loloLightTheme,
  darkTheme: loloDarkTheme,
);
```

---

## Appendix A: Design Token Summary (Flutter Implementation)

```dart
// === LOLO Design Tokens ===
// File: lib/core/theme/lolo_tokens.dart

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

  // Light Backgrounds
  static const lightBgPrimary = Color(0xFFFFFFFF);
  static const lightBgSecondary = Color(0xFFF6F8FA);
  static const lightBgTertiary = Color(0xFFEAEEF2);
}

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

abstract class LoloRadii {
  static const radiusSm = 4.0;   // Text skeleton, small elements
  static const radiusMd = 8.0;   // Input fields, small cards
  static const radiusLg = 12.0;  // Cards, buttons, badges
  static const radiusXl = 16.0;  // Bottom sheets, dialogs, profile cards
  static const radiusPill = 24.0; // Chips, pill buttons, tags
  static const radiusFull = 999.0; // Circular: avatars, FAB
}

abstract class LoloDurations {
  static const instant = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 150);
  static const quick = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
  static const cinematic = Duration(milliseconds: 800);
  static const extended = Duration(milliseconds: 1500);
}

abstract class LoloIconSizes {
  static const iconSm = 16.0;
  static const iconMd = 20.0;
  static const iconStd = 24.0;
  static const iconLg = 32.0;
  static const iconXl = 48.0;
}
```

---

## Appendix B: Design Checklist for Every Screen

Before any screen is considered complete, verify:

- [ ] Dark mode renders correctly with proper elevation hierarchy
- [ ] Light mode renders correctly with proper shadows and borders
- [ ] Arabic (RTL) layout mirrors correctly with directional components
- [ ] Bahasa Melayu text fits within containers (10-20% longer than English)
- [ ] All text meets WCAG AA contrast ratios for its background
- [ ] All interactive elements have 48dp minimum touch targets
- [ ] Loading state has a skeleton screen (not a spinner)
- [ ] Empty state has an illustration, title, description, and CTA
- [ ] Error state provides clear recovery action
- [ ] Font scaling at 150% does not break layout
- [ ] Animations respect "Reduce Motion" preference
- [ ] All images have semanticLabel for screen readers
- [ ] Navigation announces screen name for accessibility
- [ ] Component spacing follows the 8dp grid
- [ ] Colors use design tokens, not hardcoded hex values

---

**End of Design System Document**

*Next deliverables: UI String Catalog (ARB-ready), High-Fidelity Figma Designs (LTR + RTL)*
