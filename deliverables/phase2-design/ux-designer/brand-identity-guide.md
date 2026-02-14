# LOLO Brand Identity Guide v2.0

### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 2.0
### Classification: Internal -- Confidential
### Dependencies: Design System v1.0, Competitive UX Audit v1.0, Wireframe Specifications v1.0

---

## Table of Contents

1. [Logo System](#1-logo-system)
2. [App Icon](#2-app-icon)
3. [Color System Application](#3-color-system-application)
4. [Typography Application](#4-typography-application)
5. [Illustration & Photography Style](#5-illustration--photography-style)
6. [App Store Presence](#6-app-store-presence)
7. [Marketing Collateral](#7-marketing-collateral)

---

## 1. Logo System

### 1.1 Primary Mark: "The Compass"

The LOLO logo is an abstract geometric compass mark formed from two interlocking "L" letterforms. The overlapping region creates a directional arrow pointing upward-right, symbolizing forward progress, guidance, and intentionality -- the core promise of LOLO as a navigational tool for relationships.

**Symbolic Rationale:**
- **Compass** = guidance without control. LOLO guides men, it does not dictate.
- **Two L shapes** = two people in a relationship, interlocked.
- **Upward-right arrow** = forward progress, improvement, growth.
- **Geometric construction** = precision, reliability, masculine confidence.

### 1.2 Construction Grid & Proportions

The Compass mark is built on a **48 x 48 dp** master grid with 1dp subdivisions.

```
Construction Grid:
+------------------------------------------------+
|                                                |
|  Grid: 48 x 48 dp                             |
|  Sub-grid: 1dp increments                     |
|  Key structural lines at 12dp intervals        |
|                                                |
|     L1: First "L" shape                        |
|     - Vertical stroke: 3dp wide, 30dp tall     |
|     - Horizontal stroke: 3dp tall, 24dp wide   |
|     - Corner radius on terminals: 2dp          |
|     - Positioned: top-left quadrant             |
|                                                |
|     L2: Second "L" shape (rotated 180 deg)     |
|     - Same dimensions as L1                     |
|     - Positioned: bottom-right quadrant         |
|     - Overlap region: 9dp x 9dp diamond         |
|                                                |
|  Optical center: offset 1dp right and 1dp up   |
|  from geometric center (compensates for the     |
|  arrow directionality)                          |
|                                                |
+------------------------------------------------+
```

**Key Proportions:**
| Element | Measurement | Ratio to Full Mark |
|---------|-------------|-------------------|
| Full mark width | 48dp | 1:1 |
| Full mark height | 48dp | 1:1 |
| Stroke width | 3dp | 1:16 |
| Corner radius (terminals) | 2dp | 1:24 |
| Overlap/intersection region | 9dp x 9dp | 3:16 |
| L-shape vertical arm length | 30dp | 5:8 |
| L-shape horizontal arm length | 24dp | 1:2 |

**Minimum Sizes:**
| Variant | Minimum Size | Context |
|---------|-------------|---------|
| Mark only | 16dp | Favicon, very small UI elements |
| Mark only (recommended) | 24dp | App bar, loading indicators |
| Mark + wordmark (horizontal) | 120dp wide | Marketing materials, about screens |
| Mark + wordmark (stacked) | 48dp wide | Splash screen, onboarding |

Below 16dp, the mark loses its structural clarity. Never render the Compass mark below 16dp.

### 1.3 Logo + Wordmark Lockup

#### Horizontal Lockup

```
+--------+  12dp  +------------------+
|        |  gap   |                  |
| [Mark] |<------>|  L O L O         |
| 48dp   |        |  Inter Bold 32sp |
|        |        |  letter-spacing  |
+--------+        |  1.5px           |
                   +------------------+

Total width: ~140dp at standard scale
Vertical alignment: mark center aligns with wordmark x-height center
```

**Wordmark Specifications:**
- Font: Inter Bold (700)
- Size: 32sp at standard scale (proportional to mark height)
- Letter spacing: 1.5px (0.047em)
- Case: ALL CAPS
- Color: matches mark color (see Color Variants below)

#### Stacked Lockup

```
        +--------+
        |        |
        | [Mark] |
        | 48dp   |
        |        |
        +--------+
           8dp gap
      +------------+
      |  L O L O   |
      | Inter Bold  |
      |    24sp     |
      +------------+

Total height: ~84dp at standard scale
Horizontal alignment: mark and wordmark are center-aligned
```

**Stacked Wordmark Specifications:**
- Font: Inter Bold (700)
- Size: 24sp at standard scale
- Letter spacing: 1.5px
- Case: ALL CAPS

#### Ratio Rules
- In the horizontal lockup, the wordmark height must equal approximately 40% of the mark height.
- In the stacked lockup, the wordmark width must not exceed the mark width.
- The gap between mark and wordmark is always 25% of the mark height (12dp at 48dp mark, 8dp at 32dp mark).

### 1.4 Mark-Only Variant

The mark-only variant is used when the LOLO brand is already established in context (within the app, on branded materials, on social media profile images).

**Approved Sizes:**
| Size | Usage |
|------|-------|
| 48dp | Standard reference size, splash screen center |
| 32dp | App bar leading icon, watermarks on generated content |
| 24dp | Bottom navigation selected state, small badges |
| 16dp | Favicon, notification bar icon (monochrome only) |

**Construction at Small Sizes:**
- At 24dp and below, corner radius reduces to 1dp to maintain crispness.
- At 16dp, the mark is simplified: stroke width becomes 2dp and the overlap region is a solid fill rather than an intersection rendering.

### 1.5 Clear Space Rules

Clear space is the minimum unobstructed area around the logo that must remain free of other visual elements (text, images, other logos, UI borders, edges of containers).

```
Clear space unit (C) = 1/4 of mark height

At 48dp mark:  C = 12dp
At 32dp mark:  C = 8dp
At 24dp mark:  C = 6dp
At 16dp mark:  C = 4dp

+----C----+--------+----C----+
|         |        |         |
C         | [Mark] |         C
|         |        |         |
+----C----+--------+----C----+
```

**Clear Space Applies To:**
- All sides equally (top, right, bottom, left)
- Both the mark-only and the lockup variants
- In the lockup, clear space is measured from the outermost edges of the combined mark + wordmark unit

**Clear Space Exceptions:**
- Inside the app's own UI (app bar, navigation), the clear space may be reduced to 8dp minimum due to spatial constraints, but only with design team approval.
- The splash screen and onboarding hero may use generous clear space (2x C or greater).

### 1.6 Color Variants

#### Full Color (Primary)

The default logo presentation. Used on dark backgrounds (the default LOLO theme).

| Element | Color |
|---------|-------|
| L1 stroke | #4A90D9 (Steel Blue / Brand Primary) |
| L2 stroke | #C9A96E (Warm Gold / Brand Accent) |
| Intersection region | Premium Gradient -- linear-gradient(135deg, #4A90D9 0%, #C9A96E 100%) |
| Wordmark | #F0F6FC (Text Primary Dark) |

**Usage:** Splash screen, onboarding, dark marketing materials, app icon foreground.

#### Monochrome White

Single-color white variant for use on dark or photographic backgrounds where color reproduction is unreliable.

| Element | Color |
|---------|-------|
| Entire mark | #FFFFFF at 100% opacity |
| Wordmark | #FFFFFF at 100% opacity |

**Usage:** Over photography, on dark merchandise, in video overlays, on co-branded materials where LOLO is secondary.

#### Monochrome Dark

Single-color dark variant for use on light backgrounds.

| Element | Color |
|---------|-------|
| Entire mark | #1F2328 (Text Primary Light) |
| Wordmark | #1F2328 (Text Primary Light) |

**Usage:** Light-mode marketing, legal documents, black-and-white printing, fax (if ever needed), light-background social media posts.

#### Monochrome Brand Blue

Single-color variant using the primary brand color.

| Element | Color |
|---------|-------|
| Entire mark | #4A90D9 (Brand Primary) |
| Wordmark | #4A90D9 (Brand Primary) |

**Usage:** In-app monochrome contexts, link-style references, email footers on white background.

### 1.7 Logo Usage Rules

#### DO's

1. **DO** use the full-color variant as the default whenever the background is dark (#0D1117 or similar).
2. **DO** maintain the prescribed clear space around the logo at all times.
3. **DO** use the monochrome white variant when placing the logo over photography or complex backgrounds.
4. **DO** scale the logo proportionally -- always lock the aspect ratio.
5. **DO** use the provided logo files (SVG, PDF, PNG). Never recreate the mark manually.
6. **DO** center the stacked lockup on splash screens and centered layouts.
7. **DO** left-align (or right-align in RTL) the horizontal lockup in app bars and headers.
8. **DO** use the mark-only variant when brand context is already established (inside the app experience).
9. **DO** ensure the logo meets minimum size requirements (16dp mark-only, 120dp horizontal lockup).
10. **DO** test logo placement against the "glance test" -- at arm's length, the mark should appear as a premium utility icon, not a relationship app logo.

#### DON'Ts

1. **DON'T** rotate the logo. The directional arrow pointing upward-right is intentional.
2. **DON'T** stretch, squash, or distort the logo in any direction.
3. **DON'T** change the logo colors outside the approved variants listed above.
4. **DON'T** add drop shadows, outer glows, bevels, or other effects to the logo.
5. **DON'T** place the full-color logo on busy or multi-colored backgrounds without a solid container or scrim.
6. **DON'T** outline or stroke the logo -- it is already a stroke-based mark.
7. **DON'T** rearrange the mark and wordmark relationship (spacing, position, order).
8. **DON'T** use the logo at sizes below the minimum (16dp mark, 120dp horizontal lockup).
9. **DON'T** place other logos, text, or elements inside the clear space zone.
10. **DON'T** animate the logo outside of approved motion patterns (see Motion Guidelines in Design System v1.0).
11. **DON'T** use the LOLO wordmark in a different typeface. It is always Inter Bold, ALL CAPS, with 1.5px letter spacing.
12. **DON'T** add hearts, romantic imagery, or couple silhouettes near the logo. The brand is discreet.
13. **DON'T** crop any part of the logo mark.
14. **DON'T** use the logo as a pattern or repeating texture.

### 1.8 Logo on Different Backgrounds

| Background Type | Logo Variant | Notes |
|----------------|-------------|-------|
| #0D1117 (Dark Bg Primary) | Full Color | Default and preferred presentation |
| #161B22 (Dark Bg Secondary) | Full Color | Works well, sufficient contrast |
| #21262D (Dark Bg Tertiary) | Full Color | Acceptable, still clear |
| #FFFFFF (Light Bg Primary) | Monochrome Dark or Monochrome Blue | Full color not recommended on pure white |
| #F6F8FA (Light Bg Secondary) | Monochrome Dark or Monochrome Blue | Same as white |
| Photography (dark/moody) | Monochrome White | Add 60% dark scrim behind logo if photo is complex |
| Photography (light/bright) | Monochrome Dark | Add 60% light scrim behind logo if photo is complex |
| Gradient Background | Monochrome White | Do not place full-color logo on gradients |
| Partner/Co-brand Material | Monochrome White or Monochrome Dark | Depends on partner's background |
| Video (moving imagery) | Monochrome White with solid dark pill container | Container: #0D1117 at 80%, 8dp corner radius, 12dp padding |

**Contrast Requirements:**
- The logo must always maintain a minimum 3:1 contrast ratio against its background (WCAG AA for non-text graphical objects).
- When in doubt, use a scrim or container to guarantee contrast.

---

## 2. App Icon

### 2.1 Design Specification

The LOLO app icon follows a "premium utility" visual language. It must pass the glance test: when placed on a home screen alongside banking apps, fitness trackers, and productivity tools, it should appear to belong to the same category. It should never read as a "relationship app" or "dating app" at a distance.

**Core Specification:**
| Property | Value |
|----------|-------|
| Shape | Rounded square (platform-determined squircle) |
| Background color | #0D1117 (Background Primary Dark) |
| Foreground element | Compass mark |
| Foreground color | Premium Gradient: linear-gradient(135deg, #4A90D9 0%, #C9A96E 100%) |
| Mark size | 60% of safe area |
| Safe area padding | 20% on all sides |
| Shadow | None (platforms apply their own shadow systems) |
| Background pattern | None -- solid color only |

### 2.2 Android Adaptive Icon Layers

Android adaptive icons use a two-layer system (foreground + background) that the OS masks into platform-specific shapes (circle, squircle, rounded square, etc.).

**Background Layer:**
- Solid fill: #0D1117
- Format: `res/mipmap-anydpi-v26/ic_launcher_background.xml` (vector drawable) or PNG
- Size: 108 x 108 dp (the OS masks this down to 72dp visible, with 18dp on each side as bleed for motion effects)
- The background must extend the full 108dp to accommodate parallax/reveal animations

**Foreground Layer:**
- Compass mark centered in the 66dp safe zone (centered within the 108dp canvas)
- Mark rendered at approximately 40dp within the safe zone
- Format: `res/mipmap-anydpi-v26/ic_launcher_foreground.xml` (vector drawable for sharp rendering at all sizes)
- The gradient is applied as a shader on the vector paths
- The foreground has transparent background so the background layer shows through

**Adaptive Icon Declaration (`res/mipmap-anydpi-v26/ic_launcher.xml`):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
```

**Monochrome Layer (Android 13+ Themed Icons):**
- A single-color version of the Compass mark for themed icon support
- Color: system-derived (the OS applies the user's theme color)
- Format: `res/mipmap-anydpi-v26/ic_launcher_monochrome.xml`
- Design: simplified mark silhouette, no gradient, uniform fill
- Added to adaptive icon XML:
```xml
<monochrome android:drawable="@drawable/ic_launcher_monochrome" />
```

### 2.3 iOS Superellipse Format

iOS uses a fixed superellipse (squircle) mask. The icon is provided as a single flat image -- no layering system.

**Specifications:**
| Property | Value |
|----------|-------|
| Master size | 1024 x 1024 px |
| Format | PNG (no transparency, no alpha channel) |
| Color profile | sRGB |
| Corners | Do NOT include rounded corners (iOS applies the mask automatically) |
| Background | Solid #0D1117 fills the entire 1024 x 1024 canvas |
| Mark position | Centered, with the mark occupying ~60% of canvas width/height |
| Gradient rendering | Anti-aliased at 1024px for maximum quality |

**Export Sizes for iOS:**
| Size (px) | Scale | Usage |
|-----------|-------|-------|
| 20x20 | @1x | Notification (iPad) |
| 40x40 | @2x | Notification (iPhone, iPad) |
| 60x60 | @3x | Notification (iPhone) |
| 29x29 | @1x | Settings (iPad) |
| 58x58 | @2x | Settings (iPhone, iPad) |
| 87x87 | @3x | Settings (iPhone) |
| 40x40 | @1x | Spotlight (iPad) |
| 80x80 | @2x | Spotlight (iPhone, iPad) |
| 120x120 | @3x | Spotlight (iPhone) |
| 76x76 | @1x | App (iPad) |
| 152x152 | @2x | App (iPad) |
| 167x167 | @2x | App (iPad Pro) |
| 120x120 | @2x | App (iPhone) |
| 180x180 | @3x | App (iPhone) |
| 1024x1024 | @1x | App Store listing |

### 2.4 All Required Sizes (Cross-Platform)

| Size | Format | Platform | Usage |
|------|--------|----------|-------|
| 16x16 dp | Vector/PNG | Android | Favicon (WebView), notification bar |
| 16x16 px | ICO/PNG | Web | Browser favicon |
| 24x24 dp | Vector | Android | Small icon contexts |
| 32x32 px | ICO/PNG | Web | Browser favicon (@2x) |
| 36x36 dp | PNG | Android | ldpi launcher (legacy) |
| 48x48 dp | PNG | Android | mdpi launcher (legacy) |
| 48x48 px | PNG | Web | Favicon large |
| 72x72 dp | PNG | Android | hdpi launcher (legacy) |
| 96x96 dp | PNG | Android | xhdpi launcher (legacy) |
| 108x108 dp | Vector | Android | Adaptive icon layers |
| 144x144 dp | PNG | Android | xxhdpi launcher (legacy) |
| 180x180 px | PNG | iOS | App icon (@3x iPhone) |
| 192x192 dp | PNG | Android | xxxhdpi launcher (legacy) |
| 192x192 px | PNG | Web (PWA) | Manifest icon |
| 512x512 px | PNG | Android | Play Store listing hi-res icon |
| 512x512 px | PNG | Web (PWA) | Manifest icon large |
| 1024x1024 px | PNG | iOS | App Store listing |

### 2.5 Favicon

**Standard Favicon:**
- Size: 16x16 px, 32x32 px, 48x48 px (multi-resolution ICO file)
- Design: Compass mark only, monochrome white on #0D1117 background
- At 16px, use the simplified mark variant (2dp strokes, solid intersection)
- Format: `.ico` file containing all three sizes

**SVG Favicon (Modern Browsers):**
- Size: scalable
- Design: Compass mark, full-color gradient on transparent background
- Used in `<link rel="icon" type="image/svg+xml">`

**Apple Touch Icon:**
- Size: 180x180 px
- Design: Same as iOS app icon (mark on #0D1117 background)
- Format: PNG, no transparency

### 2.6 Notification Icon

**Android Notification Icon:**
- Must be monochrome white on transparent background
- Size: 24x24 dp (provided at mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
- The system tints this icon according to the notification channel color
- Design: Compass mark silhouette only -- no background fill, no gradient
- Stroke-based version of the mark, 2dp stroke width at 24dp
- Format: Vector drawable (XML) for sharpness at all densities

```
Notification icon structure:
res/
  drawable/
    ic_notification.xml          (24x24dp vector, monochrome white, transparent bg)
  mipmap-mdpi/
    ic_stat_lolo.png             (24x24 px)
  mipmap-hdpi/
    ic_stat_lolo.png             (36x36 px)
  mipmap-xhdpi/
    ic_stat_lolo.png             (48x48 px)
  mipmap-xxhdpi/
    ic_stat_lolo.png             (72x72 px)
  mipmap-xxxhdpi/
    ic_stat_lolo.png             (96x96 px)
```

**iOS Notification Icon:**
- iOS does not support custom notification icons -- it uses the app icon automatically.

**Notification Channel Color:**
- Android allows setting a notification accent color. Use #4A90D9 (Brand Primary) so the system tints the monochrome icon in steel blue.
- Notification content title: use app name "LOLO"
- Notification text: discreet language only ("Reminder: 3 days" -- never "Don't forget her birthday!")

---

## 3. Color System Application

### 3.1 Core Brand Colors

| Role | Name | Hex | RGB | HSL | Pantone (nearest) |
|------|------|-----|-----|-----|-------------------|
| **Primary** | Steel Blue | #4A90D9 | 74, 144, 217 | 211, 64%, 57% | 279 C |
| **Accent** | Warm Gold | #C9A96E | 201, 169, 110 | 39, 46%, 61% | 466 C |
| **Background Dark** | Midnight | #0D1117 | 13, 17, 23 | 216, 28%, 7% | Black 6 C |
| **Background Light** | White | #FFFFFF | 255, 255, 255 | 0, 0%, 100% | -- |

### 3.2 Color Application in UI Contexts

#### Primary (#4A90D9 Steel Blue) -- "Tap Here / This Is Active"

| UI Element | Application |
|------------|-------------|
| Primary CTA buttons | Filled button background with #FFFFFF text |
| Text links | Body text color for tappable text |
| Active bottom nav tab | Icon and label fill |
| Toggle (on state) | Track fill color |
| Active input field border | 2dp border on focused text field |
| Focus ring | 2dp outline on focused interactive element |
| Active tab indicator | Underline bar on selected tab |
| Checkbox/Radio (selected) | Fill color |
| Slider active track | Left side of slider thumb |
| Progress bar (determinate) | Filled portion |
| Pull-to-refresh spinner | Spinner color |
| App bar action icons | Active/enabled icon tint |
| Floating Action Button | Background fill (if used) |

#### Accent (#C9A96E Warm Gold) -- "You Earned This / This Is Special"

| UI Element | Application |
|------------|-------------|
| XP gain labels | "+15 XP" text color |
| Level badge | Badge background with gradient |
| Streak flame icon | Icon fill |
| Achievement unlock card | Border or accent stripe |
| Premium feature indicator | Star/crown icon, "PRO" label |
| Paywall CTA button | Filled button background (Premium Gradient) |
| Celebration confetti | Particle color (mixed with lighter #E8D5A3) |
| First-value-moment card | Top border accent |
| Gold trophy/medal icons | Icon fill |
| Action Card "reward" callout | XP/streak display text |
| Onboarding progress dots (completed) | Dot fill |

#### Premium Gradient (135deg #4A90D9 to #C9A96E) -- "Special Moment"

| UI Element | Application |
|------------|-------------|
| Level-up celebration banner | Full background gradient |
| Paywall hero section | Background gradient |
| Premium badge background | Gradient fill behind badge text |
| Splash screen mark | Logo mark gradient fill |
| App icon foreground | Compass mark gradient |
| Achievement card shimmer | Animated gradient sweep |
| First purchase/subscription confirmation | Background gradient |
| Milestone celebration screen | Background gradient with dark overlay for text |

### 3.3 Color Pairing Rules

**Rule 1: Never pair Primary and Accent as adjacent equal-weight elements.**
- Correct: Primary button next to outlined button with accent text.
- Incorrect: Primary filled button next to Accent filled button side-by-side.

**Rule 2: Accent never appears in error/warning contexts.**
- Gold is reserved for positive reinforcement. Never use #C9A96E for error states, warnings, or negative feedback.

**Rule 3: Primary on cards must use large text (16sp+).**
- #4A90D9 on #21262D (dark card background) has 3.5:1 contrast ratio, which only passes WCAG AA for large text (18sp bold or 24sp regular). For body-size text on cards, use Text Primary (#F0F6FC) instead and reserve Primary for headlines, labels, or buttons.

**Rule 4: Maximum two brand colors per component.**
- A single card or component should use at most one of Primary and one of Accent. Never add Accent stroke + Primary fill + Primary text to the same card.

**Rule 5: Gradient usage is event-driven only.**
- The Premium Gradient appears only during achievement moments, premium upsells, and the splash screen. It must never become a persistent decorative element in the standard UI flow.

**Rule 6: Semantic colors (Success, Warning, Error, Info) are never decorative.**
- They appear only when communicating a specific status or state change. They are always paired with a text label and/or icon.

### 3.4 Module-Specific Color Accents

Each LOLO module uses the same base color system but may feature a subtle color accent to help users orient within the app.

| Module | Accent Treatment | Token Suffix |
|--------|-----------------|-------------|
| Smart Reminders | Primary (#4A90D9) with clock/calendar iconography | Default -- no override |
| AI Messages | Primary (#4A90D9) with subtle gradient shimmer on generation | `moduleMessages` |
| Her Profile | Accent (#C9A96E) used more prominently for personality traits, zodiac | `moduleProfile` |
| Gift Intelligence | Accent (#C9A96E) for price tags, gift cards | `moduleGifts` |
| SOS Mode | Error gradient (#F85149 to #D29922) for urgency | `moduleSOS` |
| Gamification (XP/Levels) | Accent (#C9A96E) dominant -- gold theme throughout | `moduleGameification` |
| Insights Dashboard | Info (#58A6FF) for charts, data visualizations | `moduleInsights` |

These are accent treatments, not full recolors. The base palette remains consistent; only specific highlight elements adopt the module accent.

### 3.5 WCAG AA Accessibility -- Complete Contrast Ratio Matrix

#### Dark Mode (Default Theme)

| Foreground | Hex | Background | Hex | Ratio | WCAG AA (Normal) | WCAG AA (Large) | Usage |
|-----------|-----|-----------|-----|:-----:|:-:|:-:|-------|
| Text Primary | #F0F6FC | Bg Primary | #0D1117 | 15.4:1 | PASS | PASS | Body text on main canvas |
| Text Primary | #F0F6FC | Bg Secondary | #161B22 | 13.2:1 | PASS | PASS | Text on app bar, navigation |
| Text Primary | #F0F6FC | Bg Tertiary | #21262D | 10.9:1 | PASS | PASS | Text on cards, inputs |
| Text Primary | #F0F6FC | Surface Elevated 1 | #282E36 | 9.3:1 | PASS | PASS | Text on dialogs |
| Text Secondary | #8B949E | Bg Primary | #0D1117 | 5.6:1 | PASS | PASS | Captions on canvas |
| Text Secondary | #8B949E | Bg Secondary | #161B22 | 4.8:1 | PASS | PASS | Captions on app bar |
| Text Secondary | #8B949E | Bg Tertiary | #21262D | 3.9:1 | FAIL | PASS | Captions on cards (large only) |
| Text Tertiary | #484F58 | Bg Primary | #0D1117 | 2.7:1 | FAIL | FAIL | Placeholders, hints (decorative) |
| Primary | #4A90D9 | Bg Primary | #0D1117 | 5.1:1 | PASS | PASS | Links, active elements on canvas |
| Primary | #4A90D9 | Bg Tertiary | #21262D | 3.5:1 | FAIL | PASS | Buttons on cards (large text only) |
| Accent | #C9A96E | Bg Primary | #0D1117 | 6.3:1 | PASS | PASS | Gold text on canvas |
| Accent | #C9A96E | Bg Secondary | #161B22 | 5.4:1 | PASS | PASS | Gold text on surfaces |
| Accent | #C9A96E | Bg Tertiary | #21262D | 4.5:1 | PASS | PASS | Gold text on cards |
| Error | #F85149 | Bg Primary | #0D1117 | 5.5:1 | PASS | PASS | Error messages on canvas |
| Success | #3FB950 | Bg Primary | #0D1117 | 6.8:1 | PASS | PASS | Success indicators on canvas |
| Warning | #D29922 | Bg Primary | #0D1117 | 5.8:1 | PASS | PASS | Warning text on canvas |
| White | #FFFFFF | Primary | #4A90D9 | 3.4:1 | FAIL | PASS | White text on primary button (large) |
| White | #FFFFFF | Accent | #C9A96E | 2.1:1 | FAIL | FAIL | White text on gold (use #1F2328 instead) |
| Dark Text | #1F2328 | Accent | #C9A96E | 5.3:1 | PASS | PASS | Dark text on gold button |

#### Light Mode

| Foreground | Hex | Background | Hex | Ratio | WCAG AA (Normal) | WCAG AA (Large) | Usage |
|-----------|-----|-----------|-----|:-----:|:-:|:-:|-------|
| Text Primary | #1F2328 | Bg Primary | #FFFFFF | 16.0:1 | PASS | PASS | Body text on white |
| Text Primary | #1F2328 | Bg Secondary | #F6F8FA | 14.5:1 | PASS | PASS | Text on light surfaces |
| Text Primary | #1F2328 | Bg Tertiary | #EAEEF2 | 12.5:1 | PASS | PASS | Text on light cards |
| Text Secondary | #656D76 | Bg Primary | #FFFFFF | 5.3:1 | PASS | PASS | Captions on white |
| Text Secondary | #656D76 | Bg Secondary | #F6F8FA | 4.8:1 | PASS | PASS | Captions on surfaces |
| Text Tertiary | #8C959F | Bg Primary | #FFFFFF | 3.3:1 | FAIL | PASS | Placeholders (large only) |
| Primary (Light) | #0969DA | Bg Primary | #FFFFFF | 4.6:1 | PASS | PASS | Links on white |
| Error (Light) | #CF222E | Bg Primary | #FFFFFF | 5.9:1 | PASS | PASS | Error text on white |
| Success (Light) | #1A7F37 | Bg Primary | #FFFFFF | 4.9:1 | PASS | PASS | Success on white |
| White | #FFFFFF | Primary | #4A90D9 | 3.4:1 | FAIL | PASS | Button text (large only) |

**Key Accessibility Notes:**
1. White text on Primary buttons (#FFFFFF on #4A90D9) at 3.4:1 passes only for large text. Button text at 14sp SemiBold qualifies as large text under WCAG (bold >= 14pt = large).
2. **Never use white text on Accent gold (#C9A96E)**. The contrast ratio is only 2.1:1. Use #1F2328 (dark) text on gold backgrounds instead.
3. Text Tertiary is intentionally below AA for normal text. It is used exclusively for placeholder text and decorative hints, which are exempt per WCAG 2.1 guidelines.
4. Secondary text on dark cards (#8B949E on #21262D at 3.9:1) passes only for large text. Keep captions on cards at 14sp SemiBold or larger if using Text Secondary color.

---

## 4. Typography Application

### 4.1 Inter -- English & Bahasa Melayu

Inter is the primary typeface for all Latin-script content. It is a geometric sans-serif optimized for screen readability, with a neutral professional character that supports LOLO's masculine-premium positioning.

**Available Weights:**

| Weight Name | CSS Value | Flutter FontWeight | Usage in LOLO |
|------------|:---------:|:------------------:|---------------|
| Regular | 400 | `FontWeight.w400` | Body text, descriptions, input values, long-form content |
| Medium | 500 | `FontWeight.w500` | Overlines, emphasized body, subtitle text, input labels |
| SemiBold | 600 | `FontWeight.w600` | Section titles, buttons, tab labels, card titles, badges |
| Bold | 700 | `FontWeight.w700` | Display headlines (H1), hero text, streak counts, XP totals |

**Size Application by Use Case:**

| Use Case | Style | Size (sp) | Weight | Line Height | Letter Spacing |
|----------|-------|:---------:|:------:|:-----------:|:--------------:|
| Splash screen title | H1 / Display | 32 | Bold (700) | 1.25 (40sp) | -0.02em |
| Onboarding hero text | H1 / Display | 32 | Bold (700) | 1.25 (40sp) | -0.02em |
| Screen page title | H2 / Headline | 24 | SemiBold (600) | 1.33 (32sp) | -0.01em |
| Section header in a list | H2 / Headline | 24 | SemiBold (600) | 1.33 (32sp) | -0.01em |
| Card title | H3 / Title Large | 20 | SemiBold (600) | 1.40 (28sp) | 0em |
| Dialog title | H3 / Title Large | 20 | SemiBold (600) | 1.40 (28sp) | 0em |
| Module header | H3 / Title Large | 20 | SemiBold (600) | 1.40 (28sp) | 0em |
| Subsection title | H4 / Title Medium | 18 | Medium (500) | 1.44 (26sp) | 0em |
| List item title | H5 / Title Small | 16 | SemiBold (600) | 1.50 (24sp) | 0.01em |
| Tab label | H5 / Title Small | 16 | SemiBold (600) | 1.50 (24sp) | 0.01em |
| Input field label | H6 / Label Large | 14 | SemiBold (600) | 1.43 (20sp) | 0.01em |
| Small section header | H6 / Label Large | 14 | SemiBold (600) | 1.43 (20sp) | 0.01em |
| Primary body text | Body 1 | 16 | Regular (400) | 1.50 (24sp) | 0em |
| Card description | Body 2 | 14 | Regular (400) | 1.43 (20sp) | 0.01em |
| Timestamp / date label | Caption | 12 | Regular (400) | 1.33 (16sp) | 0.03em |
| Helper text below input | Caption | 12 | Regular (400) | 1.33 (16sp) | 0.03em |
| Category label | Overline | 11 | Medium (500) | 1.45 (16sp) | 0.08em |
| Section divider label | Overline | 11 | Medium (500) | 1.45 (16sp) | 0.08em |
| Button text (all sizes) | Button | 14 | SemiBold (600) | 1.14 (16sp) | 0.02em |

**Overline Case Rule:** Overline text in English and Bahasa Melay is displayed in UPPERCASE. In Arabic, there is no case distinction -- Overline is displayed normally with increased letter spacing.

### 4.2 Cairo -- Arabic Headings

Cairo is a modern geometric Arabic typeface that pairs well with Inter. It is used for all Arabic headings (H1-H6) and any display-size Arabic text.

**Weight Mapping to Inter:**

| Inter Weight | Inter Value | Cairo Equivalent | Cairo Value | Notes |
|-------------|:-----------:|-----------------|:-----------:|-------|
| Regular | 400 | -- | -- | Cairo is NOT used for body text |
| Medium | 500 | -- | -- | Cairo is NOT used for body text |
| SemiBold | 600 | SemiBold | 600 | Section titles, card titles |
| Bold | 700 | Bold | 700 | Display headlines, hero text |

**Size Adjustments (Arabic vs English):**

| Style | English Size | Arabic (Cairo) Size | Arabic Line Height | Reasoning |
|-------|:-----------:|:-------------------:|:------------------:|-----------|
| H1 / Display | 32sp | 34sp | 1.40 (48sp) | Arabic glyphs are denser; +2sp for legibility |
| H2 / Headline | 24sp | 26sp | 1.46 (38sp) | Consistent +2sp offset |
| H3 / Title Large | 20sp | 22sp | 1.50 (33sp) | |
| H4 / Title Medium | 18sp | 20sp | 1.50 (30sp) | |
| H5 / Title Small | 16sp | 18sp | 1.56 (28sp) | |
| H6 / Label Large | 14sp | 16sp | 1.50 (24sp) | Minimum size for Cairo heading use |

### 4.3 Noto Naskh Arabic -- Arabic Body Text

Noto Naskh Arabic is used for all Arabic body text, captions, button labels, and any text below heading level. The Naskh script style is the most familiar reading script for Arabic-speaking users, providing excellent readability at small sizes.

**Line Height Adjustments vs Latin:**

| Style | Latin Line Height | Arabic (Noto Naskh) Line Height | Absolute at Arabic Size |
|-------|:-----------------:|:-------------------------------:|:----------------------:|
| Body 1 | 1.50 (24sp at 16sp) | 1.65 (28sp at 17sp) | 28sp |
| Body 2 | 1.43 (20sp at 14sp) | 1.60 (24sp at 15sp) | 24sp |
| Caption | 1.33 (16sp at 12sp) | 1.54 (20sp at 13sp) | 20sp |
| Overline | 1.45 (16sp at 11sp) | 1.50 (18sp at 12sp) | 18sp |
| Button | 1.14 (16sp at 14sp) | 1.20 (18sp at 15sp) | 18sp |

**Critical Rules for Noto Naskh Arabic:**
1. **Minimum body size: 16sp.** Arabic body text must never go below 16sp. The connected cursive script becomes illegible at smaller sizes on mobile screens.
2. **Never apply negative letter-spacing.** Arabic letterforms connect horizontally. Negative spacing breaks glyph connections and makes text unreadable.
3. **Diacritical marks (tashkeel):** If diacritical marks are enabled (for Quranic quotes or formal text), increase line height by an additional 0.1x to prevent marks from overlapping adjacent lines.
4. **Maximum letter-spacing: 0.02em.** Even positive letter-spacing must be minimal to avoid unnatural glyph separation.

### 4.4 Noto Sans -- Bahasa Melayu Fallback

Bahasa Melayu uses the Latin script, so Inter is the primary typeface. Noto Sans serves as the fallback for any edge cases where extended Latin characters appear (loanwords from other languages).

**Differences from Inter:**

| Property | Inter | Noto Sans | Impact |
|----------|-------|-----------|--------|
| x-height | Slightly taller | Standard | Noto Sans may appear slightly smaller at the same sp size |
| Stroke terminals | Geometric, flat | Humanist, slightly rounded | Subtle visual difference |
| Weight availability | 100-900 | 100-900 | Both have full weight range |
| Letter spacing default | Tighter | Standard | Noto Sans at same size needs slightly tighter spacing |

**When Noto Sans Activates:**
- Only as a fallback when Inter cannot render a specific glyph
- In practice, this is rare for Bahasa Melayu since Inter covers all standard Malay characters
- If Noto Sans fallback is triggered, no visual adjustment is needed -- the differences are subtle enough to be acceptable

**Bahasa Melayu Text Length Note:**
Malay text runs 10-20% longer than equivalent English strings. All text containers must accommodate this expansion. Design with `maxLines` and `TextOverflow.ellipsis` as safety nets, but prefer flexible containers that grow to fit content.

### 4.5 Complete Type Scale Reference

| Style Token | EN Size | EN Weight | EN Line Height | EN Letter Sp. | AR Size | AR Weight | AR Line Height | AR Letter Sp. | MS Size | MS Weight | MS Line Height |
|------------|:-------:|:---------:|:--------------:|:-------------:|:-------:|:---------:|:--------------:|:-------------:|:-------:|:---------:|:--------------:|
| `displayLarge` | 32sp | 700 | 40sp | -0.02em | 34sp | 700 (Cairo) | 48sp | 0em | 32sp | 700 | 40sp |
| `headlineMedium` | 24sp | 600 | 32sp | -0.01em | 26sp | 600 (Cairo) | 38sp | 0em | 24sp | 600 | 32sp |
| `titleLarge` | 20sp | 600 | 28sp | 0em | 22sp | 600 (Cairo) | 33sp | 0em | 20sp | 600 | 28sp |
| `titleMedium` | 18sp | 500 | 26sp | 0em | 20sp | 500 (Cairo) | 30sp | 0em | 18sp | 500 | 26sp |
| `titleSmall` | 16sp | 600 | 24sp | 0.01em | 18sp | 600 (Cairo) | 28sp | 0em | 16sp | 600 | 24sp |
| `labelLarge` | 14sp | 600 | 20sp | 0.01em | 16sp | 600 (Cairo) | 24sp | 0em | 14sp | 600 | 20sp |
| `bodyLarge` | 16sp | 400 | 24sp | 0em | 17sp | 400 (Naskh) | 28sp | 0em | 16sp | 400 | 24sp |
| `bodyMedium` | 14sp | 400 | 20sp | 0.01em | 15sp | 400 (Naskh) | 24sp | 0em | 14sp | 400 | 20sp |
| `bodySmall` | 12sp | 400 | 16sp | 0.03em | 13sp | 400 (Naskh) | 20sp | 0em | 12sp | 400 | 16sp |
| `labelSmall` | 11sp | 500 | 16sp | 0.08em | 12sp | 500 (Naskh) | 18sp | 0.02em | 11sp | 500 | 16sp |
| `labelMedium` (Button) | 14sp | 600 | 16sp | 0.02em | 15sp | 600 (Naskh) | 18sp | 0em | 14sp | 600 | 16sp |

---

## 5. Illustration & Photography Style

### 5.1 Illustration Style Direction

LOLO illustrations follow a **geometric-minimal** style with warm undertones. They communicate concepts without being literal or childish.

**Style Properties:**

| Property | Specification |
|----------|--------------|
| Geometry | Predominantly geometric shapes -- circles, rectangles, triangles, clean arcs |
| Line quality | Clean, consistent weight (2px at standard scale) |
| Corners | Rounded (2-4dp radius), never sharp except for intentional angular accents |
| Color palette | Limited to brand palette: #4A90D9, #C9A96E, #0D1117, #F0F6FC, plus one or two semantic colors as needed |
| Fill style | Flat fills, no gradients within illustration elements (gradients reserved for background) |
| Shadow | None within illustrations. Depth communicated through overlapping shapes and opacity |
| Human figures | Abstract -- no detailed faces, no realistic proportions. Represented by simple geometric shapes (circle head, rectangle body) with a single brand color fill |
| Background | Transparent or matching the card/screen background |
| Emotion | Communicated through posture and spatial relationship of shapes, not facial expressions |
| Complexity | Maximum 8-10 distinct shapes per illustration. Simplicity is paramount |

**Illustration Categories:**

| Category | Usage | Style Notes |
|----------|-------|-------------|
| Empty states | No reminders, no messages, no data | Single centered illustration, 120x120dp, muted tones |
| Onboarding | Step illustrations | Larger (200x200dp), use brand colors more prominently |
| Achievement | Level-up, milestone | Include gold (#C9A96E) accent, subtle animation trigger |
| Error states | Network error, server error | Muted/desaturated palette, minimal complexity |
| Feature explanation | Module intro cards | Focused on the concept (calendar, message, gift) |
| SOS Mode | Emergency guidance | Red-toned (#F85149), angular shapes to convey urgency |

**What Illustrations Must NEVER Include:**
- Hearts, roses, or overtly romantic imagery
- Detailed human faces or realistic figures
- Gender-specific imagery that could feel patronizing
- Couple silhouettes or hand-holding imagery
- Pink or pastel color palettes
- Cartoon characters or mascots
- Stock illustration styles (generic corporate illustration)

### 5.2 Photography Guidelines (Marketing Only)

Photography is used exclusively in marketing materials (app store listings, social media, website). It does not appear in the app UI itself (the app uses illustrations and iconography).

**Photography Style:**

| Property | Guideline |
|----------|-----------|
| Subject matter | Men in confident, comfortable settings: at a desk, walking in a city, at a coffee shop. Never couple shots |
| Mood | Warm, confident, quiet thoughtfulness. The feeling of "having it together" |
| Color grading | Warm shadows, cool midtones. Slight desaturation. Must feel compatible with #0D1117 and #4A90D9 |
| Lighting | Natural or warm artificial. No harsh flash. Golden hour preferred for outdoor shots |
| Composition | Rule of thirds, generous negative space for text overlay |
| Text overlay zones | Every marketing photo must have at least 30% clear space for text overlay |
| Model diversity | Represent target demographics: English-speaking, Arab, Malay men aged 22-55 |
| What to avoid | Couple photos, ring/proposal imagery, flowers/hearts, cheesy poses, stock-photo-style forced smiles |
| Technical specs | Minimum 3000px on long edge, sRGB color profile, maximum 10MB per image |

**Photography + Logo Rules:**
- Logo is placed on a dark scrim (#0D1117 at 60-80% opacity) overlaying the photo
- Use Monochrome White logo variant on photo backgrounds
- Never place the full-color logo directly on a photograph without a scrim

### 5.3 Iconography Style

All icons in LOLO follow a consistent style that is distinct from the app icon mark.

**Icon Style Properties:**

| Property | Specification |
|----------|--------------|
| Style | Outlined (not filled) |
| Stroke weight | 2px (at 24dp icon size) |
| Corner treatment | Rounded caps, rounded joins |
| Grid | 24 x 24 dp with 2dp padding (20dp live area) |
| Optical alignment | Icons are optically centered, not geometrically (circles and triangles extend slightly beyond the grid for visual balance) |
| Color | Single color, inheriting from the text color context (Text Primary, Text Secondary, or Brand Primary depending on state) |
| Fill variant | Used only for selected/active states (e.g., bottom nav active tab uses filled icon) |

**Icon Sizes:**

| Size | Usage |
|------|-------|
| 16dp | Inline with body text, dense lists, badges |
| 20dp | Input field leading/trailing icons, chip icons |
| 24dp | Standard icon size -- app bar actions, list item leading icons, bottom nav |
| 32dp | Feature highlights, empty state accents |
| 48dp | Onboarding step icons, large feature callouts |

**Icon Categories and Examples:**

| Category | Icons | Notes |
|----------|-------|-------|
| Navigation | arrow_back, arrow_forward, menu, close, chevron_left/right | Direction-aware (mirror in RTL) |
| Actions | send, share, copy, edit, delete, save, add | send, share, reply mirror in RTL |
| Status | check_circle, warning, error, info, schedule | Do NOT mirror |
| Module | calendar, message, gift, heart_pulse, trophy, shield | Custom LOLO icons, do NOT mirror |
| Social | share, link, qr_code | share mirrors in RTL |
| Media | play, pause, skip_next, volume | Do NOT mirror |
| Utility | search, filter, sort, settings, notifications | search, filter, settings do NOT mirror |

---

## 6. App Store Presence

### 6.1 App Name Treatment

| Platform | Field | Content |
|----------|-------|---------|
| Google Play | App Name (30 chars max) | LOLO - Relationship Intelligence |
| App Store | App Name (30 chars max) | LOLO - Relationship Intelligence |
| Google Play | Developer Name | LOLO Technologies |
| App Store | Subtitle (30 chars max) | Be Thoughtful. Effortlessly. |

**App Name Rules:**
- "LOLO" is always in ALL CAPS
- The subtitle/tagline after the dash uses Title Case
- Never include emojis in the app name
- Never include "AI" in the visible app name (it appears in keywords/description)

### 6.2 Screenshot Templates

All screenshot templates follow a consistent layout system across all three languages.

**Screenshot Dimensions:**

| Platform | Size | Aspect Ratio |
|----------|------|-------------|
| Google Play (phone) | 1080 x 1920 px (minimum) or 1440 x 2560 px (recommended) | 9:16 |
| Google Play (tablet 7") | 1200 x 1920 px | 10:16 |
| Google Play (tablet 10") | 1800 x 2560 px | ~9:16 |
| App Store (iPhone 6.7") | 1290 x 2796 px | ~9:19.5 |
| App Store (iPhone 6.5") | 1242 x 2688 px | ~9:19.5 |
| App Store (iPad 12.9") | 2048 x 2732 px | 3:4 |

**Screenshot Template Layout:**

```
+----------------------------------+
|  [Status bar - 44px]             |
|                                  |
|  HEADLINE TEXT                   |
|  (Inter Bold 64px EN /           |
|   Cairo Bold 68px AR)            |
|                                  |
|  Subheading text                 |
|  (Inter Regular 36px EN /        |
|   Noto Naskh 38px AR)            |
|                                  |
|  +----------------------------+  |
|  |                            |  |
|  |     DEVICE MOCKUP          |  |
|  |     (showing actual app    |  |
|  |      screen at ~75%        |  |
|  |      of screenshot width)  |  |
|  |                            |  |
|  |                            |  |
|  +----------------------------+  |
|                                  |
|  [LOLO logo mark - 48px]        |
|                                  |
+----------------------------------+
```

**Background Colors for Screenshots:**
| Screenshot # | Background | Accent |
|:------------:|-----------|--------|
| 1 (Hero) | #0D1117 | Premium Gradient overlay at 10% |
| 2 | #161B22 | #4A90D9 accent elements |
| 3 | #0D1117 | #C9A96E accent elements |
| 4 | #161B22 | #4A90D9 accent elements |
| 5 | #0D1117 | Premium Gradient accent |
| 6 | Gradient (#0D1117 to #161B22) | #C9A96E accent elements |

**Screenshot Content Sequence (Recommended):**
1. **Hero/Overview** -- app name, tagline, key visual
2. **Smart Reminders** -- calendar view with reminder cards
3. **AI Messages** -- message generation interface with tone selector
4. **Her Profile** -- personality traits, zodiac, love language
5. **Gift Intelligence** -- gift recommendations with affiliate cards
6. **Gamification** -- level badge, XP progress, streak

**Language-Specific Screenshot Notes:**

| Language | Script Direction | Font Adjustments | Content Notes |
|----------|:----------------:|-----------------|---------------|
| English (EN) | LTR | Standard sizes | Default screenshot set |
| Arabic (AR) | RTL | +2sp headlines, +1sp body | Fully mirrored layout, Arabic text, RTL device mockup |
| Bahasa Melayu (MS) | LTR | Same as EN | Malay text (10-20% longer, verify no truncation) |

**Arabic Screenshot Specific Requirements:**
- All text is right-aligned
- Device mockup shows RTL app UI
- Navigation elements are mirrored
- Headlines use Cairo Bold
- Body text uses Noto Naskh Arabic
- Numbers may use Arabic-Indic numerals or Western numerals depending on market preference

### 6.3 Feature Graphic (Google Play)

**Specifications:**
| Property | Value |
|----------|-------|
| Dimensions | 1024 x 500 px |
| Format | PNG or JPEG (24-bit, no alpha) |
| Background | #0D1117 solid or subtle gradient to #161B22 |
| Content zone | Central 80% (avoid placing critical content in outer 10% margins) |

**Feature Graphic Layout:**

```
+--------------------------------------------------------------+
|                                                              |
|   [Compass Mark]    LOLO                                     |
|   64px              Inter Bold 96px, #F0F6FC                |
|   Premium Gradient  Letter-spacing 2px                       |
|                                                              |
|   She won't know why you got so thoughtful.                  |
|   We won't tell.                                             |
|   Inter Regular 36px, #8B949E                                |
|                                                              |
+--------------------------------------------------------------+
```

**Feature Graphic Rules:**
- Maximum 2 lines of text
- No app UI screenshots in the feature graphic (Google Play guidelines)
- Tagline is optional -- can be replaced with category descriptor
- Logo and text must maintain 4.5:1 contrast against the background
- Create localized versions for AR and MS markets

### 6.4 App Preview / Promotional Video Direction

**Video Specifications:**

| Property | Value |
|----------|-------|
| Duration | 15-30 seconds (App Store allows up to 30s) |
| Resolution | 1080 x 1920 px (portrait, 9:16) |
| Frame rate | 30fps or 60fps |
| Format | H.264, MP4 |
| Audio | Optional ambient music (no voiceover in MVP -- localizable later) |

**Video Storyboard Direction:**

| Time | Scene | Visual | Text Overlay |
|------|-------|--------|-------------|
| 0-3s | Logo reveal | Compass mark draws on with gradient, background #0D1117 | "LOLO" wordmark fades in |
| 3-8s | Problem statement | Subtle text animation | "Forgetting dates? Struggling with words?" |
| 8-13s | Reminders demo | Screen recording of reminder card being created | "Smart reminders that keep you ahead" |
| 13-18s | AI Messages demo | Screen recording of message generation | "AI-crafted messages. Her style." |
| 18-23s | Gift Intelligence | Screen recording of gift recommendations | "Gifts she'll actually love" |
| 23-27s | Gamification | Level-up animation, XP counter | "Level up as a partner" |
| 27-30s | Close | Logo + tagline on dark background | "She won't know why. We won't tell." |

**Video Style:**
- Transitions: clean cuts or subtle slide transitions (no wipes, no star transitions)
- Music: ambient electronic, warm and confident tone, similar to premium fintech app ads
- Text animation: fade in from bottom, 200ms duration, ease-out curve
- Screen recordings: use device frame mockup, show real app interactions
- Color: all on-screen text uses brand colors (#F0F6FC for primary, #8B949E for secondary)

### 6.5 Description Voice Guidelines

**Short Description (80 chars max -- Google Play):**

| Language | Short Description |
|----------|------------------|
| EN | "AI-powered reminders, messages & gifts. Be thoughtful, effortlessly." |
| AR | "تذكيرات وردسائل وهدايا بالذكاء الاصطناعي. كن مراعياً بسهولة." |
| MS | "Peringatan, mesej & hadiah dikuasakan AI. Jadi prihatin, tanpa usaha." |

**Long Description Voice:**
- **Tone:** Confident, direct, slightly conspiratorial (like a friend giving advice)
- **Structure:** Lead with the value prop, follow with features, close with social proof or CTA
- **Avoid:** Superlatives ("best," "amazing"), desperate language ("you NEED this"), relationship stereotypes
- **Include:** Specific feature names, clear benefit statements, the tagline
- **Keywords to naturally include:** relationship, reminders, AI messages, gift ideas, thoughtful, partner, anniversary, birthday

**Long Description Template (EN):**

```
You want to be more thoughtful. You just forget.

LOLO is your private relationship intelligence assistant. It remembers
what you don't, says what you can't, and finds what she actually wants.

SMART REMINDERS
Never miss a birthday, anniversary, or promise again. Escalating
alerts start 7 days before every date that matters.

AI MESSAGES
Personalized messages crafted for her personality. Romantic, funny,
or heartfelt -- in English, Arabic, or Bahasa Melayu.

GIFT INTELLIGENCE
AI-curated gift recommendations based on her interests, your budget,
and what she's actually hinted at.

HER PROFILE
Build a thoughtful understanding of who she is. Love language,
communication style, favorites, and wishes -- all in one place.

LEVEL UP
Track your growth as a partner. Earn XP, maintain streaks, and
unlock new relationship insights.

She won't know why you got so thoughtful. We won't tell.

Download LOLO. Be the partner she brags about.
```

---

## 7. Marketing Collateral

### 7.1 Social Media Templates

#### Instagram

**Post Sizes:**
| Format | Size | Usage |
|--------|------|-------|
| Feed Post (Square) | 1080 x 1080 px | Feature highlights, tips, quotes |
| Feed Post (Portrait) | 1080 x 1350 px | App screenshots, longer content |
| Story | 1080 x 1920 px | Daily tips, polls, quick updates |
| Reel Cover | 1080 x 1920 px | Reel thumbnail |
| Profile Picture | 320 x 320 px | Compass mark on #0D1117 |

**Instagram Post Template:**

```
Feed Post (1080 x 1080):
+----------------------------------+
|  Background: #0D1117             |
|                                  |
|  [Headline Text]                 |
|  Inter SemiBold 48px             |
|  #F0F6FC                         |
|  Left-aligned, max 2 lines       |
|                                  |
|  [Supporting text]               |
|  Inter Regular 28px              |
|  #8B949E                         |
|  Left-aligned, max 3 lines       |
|                                  |
|                                  |
|  [Visual element / illustration] |
|  or [App screen mockup]          |
|                                  |
|                                  |
|  [LOLO mark] 32px  [lolo.app]   |
|  Bottom-left         Bottom-right|
|  #F0F6FC             #8B949E     |
+----------------------------------+
Margin: 64px on all sides
```

**Instagram Story Template:**

```
Story (1080 x 1920):
+----------------------------------+
|  [Safe zone: 60px top for        |
|   profile pic/close button]      |
|                                  |
|  Background: #0D1117 or          |
|  gradient to #161B22             |
|                                  |
|  [LOLO mark] 48px               |
|  Top-left, 80px from edges       |
|                                  |
|  [Main visual / mockup /         |
|   text content]                  |
|  Center-aligned                  |
|                                  |
|                                  |
|  [CTA text or poll]              |
|  Inter SemiBold 32px             |
|  #4A90D9                         |
|                                  |
|  [Safe zone: 200px bottom for    |
|   reply bar / swipe up]          |
+----------------------------------+
```

#### Twitter (X)

**Post Sizes:**
| Format | Size | Usage |
|--------|------|-------|
| In-stream image | 1200 x 675 px (16:9) | Shared images, feature cards |
| Header | 1500 x 500 px | Profile header |
| Profile Picture | 400 x 400 px | Compass mark on #0D1117 |

**Twitter Card Template:**

```
In-stream (1200 x 675):
+------------------------------------------------------+
|  Background: #0D1117                                  |
|  Left half: text content                              |
|  Right half: app mockup or illustration               |
|                                                      |
|  [Headline] Inter SemiBold 40px #F0F6FC              |
|  [Subtext] Inter Regular 24px #8B949E                |
|  [LOLO mark + URL] bottom-left                       |
+------------------------------------------------------+
Margin: 48px on all sides
```

#### TikTok

**Sizes:**
| Format | Size | Usage |
|--------|------|-------|
| Video | 1080 x 1920 px | Content videos |
| Profile Picture | 200 x 200 px | Compass mark on #0D1117 |

**TikTok Content Direction:**
- Style: casual, authentic, slightly humorous
- Text overlay: Inter SemiBold, white with dark shadow for readability
- Avoid: polished ad style. TikTok rewards authenticity.
- Themes: "Things I never forget anymore," "What she doesn't know," "Upgrade yourself" angles
- Branding: subtle -- LOLO mark in corner, no full lockup in videos
- CTA: "Link in bio" with LOLO URL

### 7.2 Color & Typography for Marketing vs In-App

Marketing materials follow the same brand palette but with adjusted sizing for print/screen readability at distance.

| Property | In-App | Marketing |
|----------|--------|-----------|
| Primary font | Inter (all weights) | Inter (all weights) |
| Minimum body text | 12sp (Caption) | 24px (social), 10pt (print) |
| Headline size range | 16-32sp | 36-96px (social), 24-72pt (print) |
| Color palette | Full system (dark + light modes) | Dark mode palette only (brand consistency) |
| Background default | #0D1117 (dark) or #FFFFFF (light) | #0D1117 only (brand recognition) |
| Accent usage | Contextual (achievements, premium) | More liberal (visual interest in static designs) |
| Gradient usage | Event-driven only | May be used as background accent in headers |
| Arabic font | Cairo (headings), Noto Naskh (body) | Cairo (headings), Noto Naskh (body) -- same |
| Text alignment | Left (LTR) / Right (RTL) | Center or left depending on layout |

**Key Difference:** Marketing materials use the dark theme exclusively for brand consistency across all channels. The light mode is an in-app option only and does not appear in marketing.

### 7.3 Tagline Usage

**Primary Tagline:**
> "She won't know why you got so thoughtful. We won't tell."

**Tagline Rules:**

| Rule | Detail |
|------|--------|
| Placement | Always the last element in a marketing piece. Never a headline. |
| Typography | Inter Regular (400), #8B949E (Text Secondary). Not bold, not in brand color. |
| Size | Smaller than body text. 24px on social, 10pt on print. Whispered, not shouted. |
| Formatting | Two sentences. Period after each. No exclamation marks. |
| Line break | May be displayed as one line or two. If two: break after "thoughtful." |
| Translation | Translated equivalents must capture the conspiratorial tone |
| Frequency | Use in max 50% of marketing pieces. Overuse dilutes impact. |
| Where NOT to use | Inside the app UI (except onboarding screen 1 and About screen). Never in notifications. |

**Translated Taglines:**

| Language | Tagline |
|----------|---------|
| English | "She won't know why you got so thoughtful. We won't tell." |
| Arabic | "لن تعرف لماذا أصبحت مراعياً هكذا. لن نخبرها." |
| Bahasa Melayu | "Dia tak akan tahu kenapa awak jadi begitu prihatin. Kami tak akan bagitahu." |

**Secondary Taglines (for variety in campaigns):**

| Tagline | Usage |
|---------|-------|
| "Be the partner she brags about." | CTA-oriented marketing, app store description closer |
| "Thoughtful, on autopilot." | Feature-focused marketing, reminder module highlight |
| "Your relationship. Upgraded." | Gamification-focused marketing |
| "She mentioned it once. You remembered." | Wish list / gift intelligence marketing |
| "The right words. Every time." | AI message generator marketing |

**Secondary Tagline Rules:**
- Same typographic treatment as the primary tagline
- Never combine two taglines in the same piece
- Secondary taglines are more direct and feature-specific
- Primary tagline is preferred for brand-level marketing; secondary for feature-level

### 7.4 Marketing Collateral Checklist

For launch readiness, the following marketing assets must be produced:

| Asset | Dimensions | Variants Needed | Status |
|-------|-----------|----------------|--------|
| App Store screenshots (phone) | Per platform spec | EN, AR, MS x 6 screens = 18 | Pending |
| App Store screenshots (tablet) | Per platform spec | EN, AR, MS x 6 screens = 18 | Pending |
| Google Play feature graphic | 1024 x 500 px | EN, AR, MS = 3 | Pending |
| App preview video | 1080 x 1920 px, 30s | EN (subtitled AR, MS) = 1 + 2 subtitle variants | Pending |
| Instagram feed posts | 1080 x 1080 px | 10 initial posts (EN), 5 AR, 5 MS | Pending |
| Instagram stories | 1080 x 1920 px | 10 templates (reusable) | Pending |
| Twitter header | 1500 x 500 px | 1 (EN primary, swap for AR/MS campaigns) | Pending |
| Twitter card images | 1200 x 675 px | 6 feature cards x 3 languages = 18 | Pending |
| TikTok profile picture | 200 x 200 px | 1 | Pending |
| Press kit (logo files) | Multiple formats | SVG, PNG (@1x, @2x, @3x), PDF | Pending |
| Email header | 600px wide | 1 template (EN, AR, MS variants) | Pending |
| Open Graph image | 1200 x 630 px | EN, AR, MS = 3 | Pending |

---

## Appendix A: Logo File Naming Convention

```
lolo-logo-[variant]-[color]-[size].[format]

Examples:
lolo-logo-lockup-horizontal-fullcolor-standard.svg
lolo-logo-lockup-stacked-fullcolor-standard.svg
lolo-logo-mark-fullcolor-48dp.svg
lolo-logo-mark-mono-white-32dp.svg
lolo-logo-mark-mono-dark-24dp.svg
lolo-logo-mark-mono-blue-16dp.svg
lolo-logo-lockup-horizontal-mono-white-standard.svg
lolo-logo-wordmark-mono-dark.svg
```

## Appendix B: Brand Identity Checklist for Designers

Before shipping any branded asset, verify:

- [ ] Logo uses an approved variant and color scheme
- [ ] Clear space requirements are met on all sides
- [ ] Logo meets minimum size requirements
- [ ] Background contrast ratio is at least 3:1 for the logo
- [ ] Typography uses Inter (EN/MS) or Cairo/Noto Naskh (AR)
- [ ] Colors are from the approved brand palette only
- [ ] Accent color (#C9A96E) is not used for error or negative states
- [ ] Primary color (#4A90D9) is not paired adjacent to Accent in equal visual weight
- [ ] No hearts, couple imagery, or romantic stereotypes
- [ ] Tagline (if used) follows formatting rules
- [ ] Arabic content is right-aligned with appropriate font sizes
- [ ] Bahasa Melayu text fits within containers (10-20% expansion accounted for)
- [ ] All text meets WCAG AA contrast minimums for its size category
- [ ] The glance test passes: asset looks like premium utility, not a dating/relationship app

---

*Document maintained by Lina Vazquez, Senior UX/UI Designer*
*Last updated: February 14, 2026*
*Next review: Upon completion of Phase 2 visual design milestones*
