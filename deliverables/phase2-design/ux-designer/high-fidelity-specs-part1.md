# LOLO High-Fidelity Screen Specifications -- Part 1 (Modules 1-5)
### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0
### Status: Developer Handoff Ready

---

## Document Overview

This document provides pixel-perfect, developer-ready specifications for **22 screens** across Modules 1-5. Every color, spacing value, typography token, animation curve, and interaction state is defined. This builds upon the wireframe specifications from Phase 1 and applies the finalized LOLO Design System.

**Scope:** Screens 1-22 (Onboarding, Dashboard, Her Profile, Smart Reminders, AI Message Generator)

---

## Design System Quick Reference

### Color Tokens

| Token | Dark Mode | Light Mode |
|-------|-----------|------------|
| `bg.primary` | `#0D1117` | `#FFFFFF` |
| `bg.secondary` | `#161B22` | `#F6F8FA` |
| `bg.tertiary` / cards | `#21262D` | `#EAEEF2` |
| `text.primary` | `#F0F6FC` | `#1F2328` |
| `text.secondary` | `#8B949E` | `#656D76` |
| `text.tertiary` | `#484F58` | `#8C959F` |
| `brand.primary` | `#4A90D9` | `#4A90D9` |
| `brand.accent` | `#C9A96E` | `#C9A96E` |
| `status.success` | `#3FB950` | `#1A7F37` |
| `status.warning` | `#D29922` | `#BF8700` |
| `status.error` | `#F85149` | `#CF222E` |
| `border.default` | `#30363D` | `#D0D7DE` |
| `border.emphasis` | `#484F58` | `#8C959F` |

### Gradients

| Name | Value |
|------|-------|
| `gradient.premium` | `linear-gradient(135deg, #4A90D9, #C9A96E)` |
| `gradient.sos` | `linear-gradient(135deg, #F85149, #D29922)` |
| `gradient.achievement` | `linear-gradient(135deg, #C9A96E, #E8D5A3)` |
| `gradient.card.subtle` | `linear-gradient(180deg, bg.tertiary 0%, bg.secondary 100%)` |

### Typography Scale

| Token | Font | Weight | Size | Line Height |
|-------|------|--------|------|-------------|
| `display.lg` | Inter | 700 | 32sp | 40sp |
| `display.md` | Inter | 700 | 28sp | 36sp |
| `heading.lg` | Inter | 600 | 24sp | 32sp |
| `heading.md` | Inter | 600 | 20sp | 28sp |
| `heading.sm` | Inter | 600 | 18sp | 24sp |
| `body.lg` | Inter | 400 | 16sp | 24sp |
| `body.md` | Inter | 400 | 14sp | 20sp |
| `body.sm` | Inter | 400 | 12sp | 16sp |
| `label.lg` | Inter | 500 | 16sp | 24sp |
| `label.md` | Inter | 500 | 14sp | 20sp |
| `label.sm` | Inter | 500 | 12sp | 16sp |
| `button` | Inter | 600 | 16sp | 24sp |

For Arabic: Replace `Inter` with `Cairo` (headings) and `Noto Naskh Arabic` (body).
For Malay: Replace `Inter` with `Noto Sans` for all weights.

### Spacing & Layout

| Token | Value |
|-------|-------|
| `space.xs` | 4dp |
| `space.sm` | 8dp |
| `space.md` | 12dp |
| `space.lg` | 16dp |
| `space.xl` | 24dp |
| `space.2xl` | 32dp |
| `space.3xl` | 40dp |
| `space.4xl` | 48dp |
| `screen.padding` | 16dp horizontal |
| `bottom.nav.height` | 64dp |
| `status.bar.offset` | 24dp (system-dependent) |
| `min.touch` | 48x48dp |
| `radius.card` | 12px |
| `radius.input` | 8px |
| `radius.button` | 24px |
| `radius.chip` | 16px |
| `radius.sheet` | 16px (top corners) |

### Elevation (Dark Mode)

| Level | Shadow |
|-------|--------|
| `elevation.0` | none |
| `elevation.1` | `0 1px 3px rgba(0,0,0,0.24)` |
| `elevation.2` | `0 2px 8px rgba(0,0,0,0.32)` |
| `elevation.3` | `0 4px 16px rgba(0,0,0,0.40)` |

### Elevation (Light Mode)

| Level | Shadow |
|-------|--------|
| `elevation.0` | none |
| `elevation.1` | `0 1px 3px rgba(27,31,36,0.12)` |
| `elevation.2` | `0 2px 8px rgba(27,31,36,0.16)` |
| `elevation.3` | `0 4px 16px rgba(27,31,36,0.20)` |

### Animation Tokens

| Token | Duration | Easing |
|-------|----------|--------|
| `anim.instant` | 100ms | `ease-out` |
| `anim.fast` | 200ms | `ease-out` |
| `anim.normal` | 300ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` |
| `anim.slow` | 500ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` |
| `anim.spring` | 400ms | `cubic-bezier(0.175, 0.885, 0.32, 1.275)` |
| `anim.page.enter` | 300ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` |
| `anim.page.exit` | 250ms | `cubic-bezier(0.4, 0.0, 1, 1)` |
| `anim.sheet.enter` | 300ms | `cubic-bezier(0.0, 0.0, 0.2, 1)` |
| `anim.sheet.exit` | 250ms | `cubic-bezier(0.4, 0.0, 1, 1)` |

---

## MODULE 1: ONBOARDING

---

### Screen 1: Language Selector

| Property | Value |
|----------|-------|
| **Screen Name** | Language Selector |
| **Route** | `/onboarding/language` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Full-screen layout. No app bar, no bottom nav. Content vertically centered within safe area. Background is `bg.primary`. The LOLO compass logo sits in the upper third. Title text sits below the logo. Three language tiles are centered in the middle third with equal spacing. No explicit CTA button -- selection auto-advances.

**Structure (top to bottom):**
- Status bar area: system default, 24dp
- Spacer: flexible, minimum 48dp
- Logo: centered horizontally
- Spacer: 32dp
- Title text: centered
- Spacer: 40dp
- Language tile 1 (English)
- Spacer: 12dp
- Language tile 2 (Arabic)
- Spacer: 12dp
- Language tile 3 (Bahasa Melayu)
- Spacer: flexible, minimum 48dp

#### Component Breakdown

**1. LOLO Compass Logo**
- Size: 80x80dp
- Asset: `ic_logo_compass.svg` (vector, two interlocking L shapes forming directional arrow)
- Color: `gradient.premium` applied as fill (`#4A90D9` to `#C9A96E` at 135deg)
- Position: center horizontal, top third of screen
- Content description (a11y): "LOLO logo"
- Animation: On screen load, logo fades in (opacity 0 to 1, `anim.slow` 500ms) then rotates 360deg once (`anim.slow`, `cubic-bezier(0.4, 0.0, 0.2, 1)`)

**2. Title Text -- "Choose Your Language"**
- Typography: `heading.lg` -- Inter 600, 24sp, line-height 32sp
- Color (dark): `text.primary` (`#F0F6FC`)
- Color (light): `text.primary` (`#1F2328`)
- Alignment: center
- Max width: 280dp
- Content description (a11y): "Choose Your Language"
- Note: This text is displayed in all three languages stacked or just English on first load. Implementation: show in English initially since no language is selected yet.

**3. Language Tile (x3)**
- Width: screen width minus 32dp (16dp padding each side)
- Height: 56dp
- Background (dark default): `bg.tertiary` (`#21262D`)
- Background (light default): `bg.tertiary` (`#EAEEF2`)
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp horizontal
- Layout: Row -- flag icon left, language name right-of-flag, chevron right edge

  **Flag Icon:**
  - Size: 32x24dp (standard flag ratio 4:3)
  - Assets: `flag_us_uk.png` (EN), `flag_sa.png` (AR), `flag_my.png` (MS)
  - Border radius: 4px (rounded rectangle mask)
  - Position: 16dp from left edge, vertically centered

  **Language Name:**
  - Typography: `label.lg` -- Inter 500, 16sp, line-height 24sp
  - Color (dark): `text.primary` (`#F0F6FC`)
  - Color (light): `text.primary` (`#1F2328`)
  - Position: 12dp right of flag, vertically centered
  - Values: "English", "العربية", "Bahasa Melayu"

  **Chevron Icon:**
  - Size: 20x20dp
  - Asset: `ic_chevron_right.svg`
  - Color (dark): `text.tertiary` (`#484F58`)
  - Color (light): `text.tertiary` (`#8C959F`)
  - Position: 16dp from right edge, vertically centered

**States:**

| State | Background | Border | Text Color | Other |
|-------|-----------|--------|------------|-------|
| Default | `bg.tertiary` | 1px `border.default` | `text.primary` | -- |
| Pressed | `brand.primary` at 15% opacity | 1.5px `brand.primary` | `text.primary` | Scale 0.98x, `anim.instant` |
| Selected | `brand.primary` at 10% opacity | 2px `brand.primary` | `brand.primary` | Check icon replaces chevron |
| Focused (a11y) | `bg.tertiary` | 2px `brand.primary` | `text.primary` | Focus ring visible |

**Selection Behavior:**
- On tap: tile transitions to Selected state (`anim.fast` 200ms)
- Haptic feedback: light impact
- After 400ms delay, auto-navigate to Welcome screen
- If user taps a different tile during the 400ms window, selection switches immediately

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen background | `#0D1117` | `#FFFFFF` |
| Tile background | `#21262D` | `#EAEEF2` |
| Tile border | `#30363D` | `#D0D7DE` |
| Title text | `#F0F6FC` | `#1F2328` |
| Language name | `#F0F6FC` | `#1F2328` |
| Chevron | `#484F58` | `#8C959F` |
| Selected border | `#4A90D9` | `#4A90D9` |
| Selected bg | `#4A90D9` at 10% | `#4A90D9` at 10% |

#### RTL Notes

- If user selects Arabic, the layout engine switches to RTL **before** the navigation transition fires
- In RTL mode: flag icon moves to right edge, language name aligns right (right of nothing, since flag is rightmost), chevron flips to left-pointing and sits at left edge
- The page exit transition reverses: slide-to-left becomes slide-to-right
- Title text center alignment is unaffected by direction
- The three tiles maintain the same vertical order regardless of locale

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Logo entrance | Screen load | 500ms | `ease-out` | Fade in 0% to 100% opacity + 360deg rotation |
| Title entrance | After logo (200ms delay) | 300ms | `ease-out` | Fade in + translate Y from 16dp to 0dp |
| Tile entrance (staggered) | After title (100ms delay between each) | 300ms each | `anim.spring` | Fade in + translate Y from 24dp to 0dp, stagger 100ms |
| Tile press | On touch down | 100ms | `ease-out` | Scale to 0.98 |
| Tile select | On tap confirmed | 200ms | `ease-out` | Border color transition + bg fill |
| Page exit | After 400ms delay | 300ms | `anim.page.enter` | Slide out left (LTR) or right (RTL) |

#### Accessibility

- Minimum contrast ratio: title text on bg.primary = 15.2:1 (dark), 17.4:1 (light) -- exceeds WCAG AAA
- Each tile is a focusable button with role `button`
- Screen reader label: "Choose Your Language. Three options available. English. Arabic. Bahasa Melayu."
- Each tile label: "[Flag] English, button" / "[Flag] Arabic, button" / "[Flag] Bahasa Melayu, button"
- On selection: announce "English selected. Navigating to welcome screen."
- Touch targets: 56dp height exceeds 48dp minimum
- No timeout pressure -- the 400ms delay is purely for feel, the screen remains interactive

#### Edge Cases

- **Device locale detection:** On first load, if `Locale.getDefault().language` matches `en`, `ar`, or `ms`, pre-highlight (but do not select) the matching tile with a subtle border emphasis (`border.emphasis` color). User must still tap to confirm.
- **Very small screens (<320dp width):** Tiles shrink to 48dp height; flag icons reduce to 24x18dp; font reduces to 14sp. Minimum still meets touch target.
- **Screen reader active:** Disable auto-advance timer; require explicit double-tap to confirm selection and navigate.
- **Landscape orientation:** Lock to portrait for onboarding. If detected, show gentle prompt to rotate.
- **No internet:** This screen is fully offline. All assets bundled.

---

### Screen 2: Welcome

| Property | Value |
|----------|-------|
| **Screen Name** | Welcome |
| **Route** | `/onboarding/welcome` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Full-screen, no bottom nav. Optional top-left back arrow (subtle). Logo in upper section. Tagline prominently centered. Three benefit rows below. Primary CTA button near bottom. Secondary "Log in" text link below CTA. Scrollable if content overflows on small screens.

**Structure (top to bottom):**
- Status bar: 24dp
- Back arrow row: 48dp height (arrow 24dp, left-aligned, 16dp from left edge)
- Spacer: 16dp
- Logo: 64x64dp, centered
- Spacer: 24dp
- Tagline text: centered, multi-line
- Spacer: 32dp
- Benefit row 1
- Spacer: 16dp
- Benefit row 2
- Spacer: 16dp
- Benefit row 3
- Spacer: flexible (min 24dp)
- "Get Started" button: full width minus 32dp
- Spacer: 16dp
- "Already have account? Log in" text
- Spacer: 24dp (bottom safe area)

#### Component Breakdown

**1. Back Arrow**
- Size: 24x24dp inside 48x48dp touch target
- Asset: `ic_arrow_back.svg`
- Color (dark): `text.secondary` (`#8B949E`)
- Color (light): `text.secondary` (`#656D76`)
- Position: 16dp from left, vertically centered in 48dp row
- On tap: navigate back to `/onboarding/language`

**2. LOLO Compass Logo**
- Size: 64x64dp (slightly smaller than Screen 1)
- Same asset, same gradient fill
- Center aligned
- Content description: "LOLO"

**3. Tagline Text**
- Text: "She won't know why you got so thoughtful.\nWe won't tell."
- Typography: `heading.md` -- Inter 600, 20sp, line-height 28sp
- Color (dark): `text.primary` (`#F0F6FC`)
- Color (light): `text.primary` (`#1F2328`)
- Alignment: center
- Max width: 300dp
- Line 1: "She won't know why you got so thoughtful."
- Line 2: "We won't tell." (slightly emphasized)
- "We won't tell." styling: same font, but color `brand.accent` (`#C9A96E`) for warmth

**4. Benefit Row (x3)**
- Width: screen width minus 32dp
- Height: auto (minimum 64dp)
- Layout: Row with fixed icon area + text column
- Background: transparent (no card wrapper -- clean, open layout)
- Spacing: 12dp between icon and text

  **Icon Container:**
  - Size: 48x48dp
  - Background: `brand.primary` at 10% opacity
  - Border radius: 12px
  - Icon: 24x24dp centered within container
  - Icon color: `brand.primary` (`#4A90D9`)

  **Benefit 1:**
  - Icon: `ic_bell_ring.svg` (reminder bell)
  - Title: "Smart Reminders" -- `label.lg` 500, 16sp, `text.primary`
  - Subtitle: "Never forget what matters to her" -- `body.md` 400, 14sp, `text.secondary`

  **Benefit 2:**
  - Icon: `ic_message_sparkle.svg` (chat bubble with sparkle)
  - Title: "AI Messages" -- same styling
  - Subtitle: "Say the right thing every time"

  **Benefit 3:**
  - Icon: `ic_shield_heart.svg` (shield with heart)
  - Title: "SOS Mode" -- same styling
  - Subtitle: "Emergency help when she's upset"

**5. "Get Started" Button**
- Width: screen width minus 32dp (16dp padding each side)
- Height: 52dp
- Background: `brand.primary` (`#4A90D9`)
- Border radius: `radius.button` (24px)
- Text: "Get Started" -- `button` -- Inter 600, 16sp, `#FFFFFF`
- Text alignment: center
- Elevation: `elevation.1`

  **States:**

  | State | Background | Text | Elevation | Other |
  |-------|-----------|------|-----------|-------|
  | Default | `#4A90D9` | `#FFFFFF` | `elevation.1` | -- |
  | Pressed | `#3A7BC8` (darken 10%) | `#FFFFFF` | `elevation.0` | Scale 0.98, `anim.instant` |
  | Focused | `#4A90D9` | `#FFFFFF` | `elevation.1` | 2px focus ring `#C9A96E` |
  | Disabled | `#4A90D9` at 40% | `#FFFFFF` at 40% | none | -- |

**6. "Already have account? Log in" Text**
- Full text: "Already have account? Log in"
- "Already have account? " -- `body.md` 400, 14sp, `text.secondary`
- "Log in" -- `body.md` 500, 14sp, `brand.primary` (`#4A90D9`), underline decoration
- Alignment: center
- "Log in" is tappable with 48dp minimum touch target (expand tap area vertically)
- On tap: navigate to `/login`

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen background | `#0D1117` | `#FFFFFF` |
| Back arrow | `#8B949E` | `#656D76` |
| Tagline main | `#F0F6FC` | `#1F2328` |
| Tagline accent line | `#C9A96E` | `#C9A96E` |
| Icon container bg | `#4A90D9` at 10% | `#4A90D9` at 10% |
| Icon color | `#4A90D9` | `#4A90D9` |
| Benefit title | `#F0F6FC` | `#1F2328` |
| Benefit subtitle | `#8B949E` | `#656D76` |
| Button bg | `#4A90D9` | `#4A90D9` |
| Button text | `#FFFFFF` | `#FFFFFF` |
| Login link | `#4A90D9` | `#4A90D9` |

#### RTL Notes

- Back arrow flips to `ic_arrow_forward.svg`, positioned 16dp from right edge
- Logo stays centered
- Tagline text alignment stays center (text inherently reflows for Arabic)
- Benefit rows: icon container moves to right, text column left-aligns from icon (now text is right-aligned)
- Button stays centered (text centered within)
- "Log in" link stays centered
- Page entry animation: slide-from-left in RTL instead of slide-from-right

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation from language | 300ms | `anim.page.enter` | Slide in from right (LTR) or left (RTL) + fade in |
| Logo entrance | Page settle | 300ms | `ease-out` | Scale from 0.8 to 1.0 + fade in |
| Tagline entrance | 150ms after logo | 400ms | `ease-out` | Fade in + translate Y 16dp to 0 |
| Benefit 1 | 250ms after tagline | 300ms | `anim.spring` | Fade in + translate X from -24dp to 0 |
| Benefit 2 | 100ms after Benefit 1 | 300ms | `anim.spring` | Same, staggered |
| Benefit 3 | 100ms after Benefit 2 | 300ms | `anim.spring` | Same, staggered |
| Button entrance | 100ms after Benefit 3 | 300ms | `anim.spring` | Fade in + translate Y from 16dp to 0 |
| Button press | On touch down | 100ms | `ease-out` | Scale to 0.98 |
| Button release | On touch up | 150ms | `anim.spring` | Scale back to 1.0 |

#### Accessibility

- Back arrow: "Go back to language selection, button"
- Logo: "LOLO logo, decorative" (decorative, not announced prominently)
- Tagline: read as single paragraph
- Each benefit: "Smart Reminders. Never forget what matters to her." (title + subtitle combined)
- Button: "Get Started, button"
- Login link: "Already have account? Log in, button"
- Contrast: all text passes WCAG AA minimum (4.5:1 for body, 3:1 for large text)
- Reading order: back arrow, logo (skipped if decorative), tagline, benefits 1-2-3, button, login link

#### Edge Cases

- **Long tagline (Arabic/Malay translations):** Max 4 lines. If exceeds, reduce tagline to `heading.sm` (18sp). Arabic tagline verified to fit within 3 lines at 20sp.
- **Small screen (<360dp width):** Logo reduces to 48x48dp. Benefits reduce icon container to 40x40dp. Spacers compress by 25%.
- **Keyboard visible:** Not applicable (no input fields on this screen).
- **Already authenticated:** If user returns to this route while logged in, redirect to `/home` immediately.

---

### Screen 3: Sign Up

| Property | Value |
|----------|-------|
| **Screen Name** | Sign Up |
| **Route** | `/onboarding/signup` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Scrollable single-column layout. App bar with back arrow and title. Logo (smaller). Social sign-in buttons. Divider with "or". Email/password form. Primary CTA. Legal text at bottom. Keyboard-aware: when keyboard opens, scroll to keep active field visible with 16dp clearance above keyboard.

**Structure (top to bottom):**
- App bar: 56dp
- Spacer: 16dp
- Logo: 48x48dp, centered
- Spacer: 16dp
- Subtitle: "Create your account", centered
- Spacer: 24dp
- Google button: full width minus 32dp
- Spacer: 12dp
- Apple button: full width minus 32dp
- Spacer: 24dp
- Divider with "or"
- Spacer: 24dp
- Email label + field
- Spacer: 16dp
- Password label + field
- Spacer: 16dp
- Confirm Password label + field
- Spacer: 24dp
- "Create Account" button
- Spacer: 16dp
- Legal text
- Spacer: 24dp (bottom safe area)

#### Component Breakdown

**1. App Bar**
- Height: 56dp
- Background: transparent (same as screen bg)
- Elevation: none (flat)
- Back arrow: 24x24dp in 48x48dp target, 16dp from left, `text.secondary`
- Title: "Sign Up" -- `heading.sm` -- Inter 600, 18sp, `text.primary`, center-aligned
- No right action

**2. Logo**
- 48x48dp, same compass asset, `gradient.premium` fill
- Centered horizontally

**3. Subtitle**
- Text: "Create your account"
- Typography: `heading.sm` -- Inter 600, 18sp
- Color (dark): `text.primary`
- Color (light): `text.primary`
- Alignment: center

**4. Social Sign-In Button (Google)**
- Width: screen width minus 32dp
- Height: 52dp
- Background (dark): `bg.tertiary` (`#21262D`)
- Background (light): `#FFFFFF`
- Border: 1px solid `border.default`
- Border radius: `radius.button` (24px)
- Layout: Row -- Google "G" icon (20x20dp, full color) 16dp from left, text centered
- Text: "Continue with Google" -- `button` -- Inter 600, 16sp, `text.primary`

  **States:**
  | State | Background | Border |
  |-------|-----------|--------|
  | Default | `bg.tertiary` / `#FFFFFF` | `border.default` |
  | Pressed | darken 5% | `border.emphasis` |
  | Loading | same | same, with 20dp spinner replacing icon |
  | Disabled | opacity 50% | opacity 50% |

**5. Social Sign-In Button (Apple)**
- Same dimensions and styling as Google button
- Icon: Apple logo 20x20dp, monochrome (white in dark mode, black in light mode)
- Text: "Continue with Apple"
- Same states as Google button

**6. Divider with "or"**
- Full width minus 32dp
- Layout: horizontal line -- text -- horizontal line
- Line: 1px solid `border.default`, flexible width
- Text: "or" -- `body.sm` -- Inter 400, 12sp, `text.tertiary`, center
- Gap: 12dp between lines and text

**7. Email Text Field**
- Label: "Email" -- `label.md` -- Inter 500, 14sp, `text.secondary`, positioned above field with 4dp gap
- Field container:
  - Width: full width minus 32dp
  - Height: 48dp
  - Background (dark): `bg.secondary` (`#161B22`)
  - Background (light): `bg.secondary` (`#F6F8FA`)
  - Border: 1px solid `border.default`
  - Border radius: `radius.input` (8px)
  - Padding: 12dp horizontal
- Input text: `body.lg` -- Inter 400, 16sp, `text.primary`
- Placeholder: "you@example.com" -- `body.lg`, `text.tertiary`
- Keyboard type: `emailAddress`

  **States:**
  | State | Border | Label Color | Other |
  |-------|--------|-------------|-------|
  | Default | `border.default` | `text.secondary` | -- |
  | Focused | 2px `brand.primary` | `brand.primary` | -- |
  | Filled | `border.default` | `text.secondary` | -- |
  | Error | 2px `status.error` | `status.error` | Error text below |
  | Disabled | `border.default` at 50% | `text.tertiary` | bg opacity 50% |

  **Error Text:**
  - "Invalid email format" / "Email is required"
  - Typography: `body.sm` -- 12sp, `status.error`
  - Position: 4dp below field
  - Icon: `ic_error_circle.svg` 12x12dp inline before text

**8. Password Text Field**
- Same structure as email field
- Label: "Password"
- Placeholder: "Min 8 characters"
- Keyboard type: `visiblePassword` (with obscuring)
- Suffix icon: eye toggle, 24x24dp inside 48x48dp touch target, 8dp from right edge
  - `ic_eye_off.svg` (password hidden, default)
  - `ic_eye_on.svg` (password visible)
  - Color: `text.tertiary`
  - On tap: toggle password visibility
- Validation: minimum 8 characters, at least 1 letter and 1 number
- Error text: "Password must be at least 8 characters" / "Include at least 1 letter and 1 number"

**9. Confirm Password Text Field**
- Same as password field
- Label: "Confirm Password"
- Placeholder: "Re-enter your password"
- Validation: must match password field
- Error text: "Passwords don't match"

**10. "Create Account" Button**
- Same dimensions and base styling as "Get Started" on Welcome screen
- Text: "Create Account"
- Initially disabled until all 3 fields pass validation
- On tap: submit form, show loading state

  **States:**
  | State | Background | Text | Other |
  |-------|-----------|------|-------|
  | Disabled | `#4A90D9` at 40% | `#FFFFFF` at 40% | No tap response |
  | Default (enabled) | `#4A90D9` | `#FFFFFF` | Ready for tap |
  | Pressed | `#3A7BC8` | `#FFFFFF` | Scale 0.98 |
  | Loading | `#4A90D9` | Hidden | 24dp circular spinner, white, centered |
  | Success | `#3FB950` | `#FFFFFF` | Brief flash, then navigate |

**11. Legal Text**
- Text: "By signing up you agree to our Terms of Service and Privacy Policy"
- Typography: `body.sm` -- 12sp, `text.tertiary`
- "Terms of Service" -- `body.sm` 500, `brand.primary`, underline, tappable
- "Privacy Policy" -- same styling as Terms
- Alignment: center
- Max width: 280dp
- Touch target for links: minimum 48dp height (expand vertically)

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| App bar bg | transparent | transparent |
| Social button bg | `#21262D` | `#FFFFFF` |
| Social button border | `#30363D` | `#D0D7DE` |
| Input field bg | `#161B22` | `#F6F8FA` |
| Input border | `#30363D` | `#D0D7DE` |
| Divider line | `#30363D` | `#D0D7DE` |
| "or" text | `#484F58` | `#8C959F` |
| Error text | `#F85149` | `#CF222E` |

#### RTL Notes

- Back arrow flips to right side, becomes forward arrow
- "Sign Up" title stays centered
- Social buttons: brand icons move to right side, text stays centered
- Form labels align right
- Input text cursor starts from right, text aligns right
- Eye toggle icon moves to left side of password field
- Error text aligns right with error icon on right
- Legal text aligns right
- Divider "or" stays centered

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide from right + fade |
| Keyboard appear | Field focus | 250ms | `ease-out` | Scroll to active field, content shifts up |
| Field focus ring | On focus | 200ms | `ease-out` | Border color transition |
| Error shake | Validation fail | 300ms | `ease-in-out` | Translate X: 0, -8, 8, -4, 4, 0 (shake) |
| Button enable | All fields valid | 200ms | `ease-out` | Opacity 40% to 100% |
| Loading spinner | Form submit | continuous | linear | 360deg rotation loop |
| Success flash | Auth success | 300ms | `ease-out` | Button bg transitions to success green, then navigate |

#### Accessibility

- App bar: "Sign Up, navigation. Back button."
- Social buttons: "Continue with Google, button" / "Continue with Apple, button"
- Form fields: each announced with label, current value, and error state
- Password toggle: "Show password, toggle button" / "Hide password, toggle button"
- Create Account button: "Create Account, button, disabled" (updates to "Create Account, button" when enabled)
- Legal links: "Terms of Service, link" / "Privacy Policy, link"
- Error messages: announced immediately via live region when validation fails
- Form group: semantic form grouping for screen readers

#### Edge Cases

- **Email already registered:** Snackbar at bottom: "This email is already registered. Try logging in." with "Log In" action button. Snackbar: `bg.tertiary`, `text.primary`, action in `brand.primary`. Duration: 6000ms or until dismissed.
- **Network error during OAuth:** Snackbar: "Network error. Check your connection and try again." with "Retry" action.
- **Keyboard covers CTA:** Scroll container auto-scrolls. If "Create Account" button is below keyboard, a floating version appears above keyboard (same styling, 8dp above keyboard top edge, full width minus 32dp with rounded corners).
- **Very long email:** Field scrolls horizontally; text is single-line with horizontal scroll.
- **OAuth popup blocked:** Fallback to in-app webview for Google/Apple sign-in.
- **Paste into fields:** Supported. Confirm password validates on paste.

---

### Screen 4: Your Name

| Property | Value |
|----------|-------|
| **Screen Name** | Your Name |
| **Route** | `/onboarding/name` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Minimal screen focused on a single input: the user's first name. Clean and uncluttered. Warm supportive subtitle. Large input field. Progress indicator at top. Onboarding step indicator: 1 of 5 (excluding language, welcome, sign up as pre-onboarding). This is the first "data collection" screen.

**Structure (top to bottom):**
- App bar: 56dp
- Progress bar: 4dp height, full width
- Spacer: 32dp
- Headline text
- Spacer: 8dp
- Support text
- Spacer: 32dp
- Name label + field
- Spacer: flexible (min 40dp)
- "Continue" button
- Spacer: 16dp
- "Skip for now" link
- Spacer: 24dp (safe area)

#### Component Breakdown

**1. App Bar**
- Height: 56dp
- Background: transparent
- Back arrow: 24x24dp in 48x48dp, 16dp from left, `text.secondary`
- Title: "About You" -- `heading.sm`, `text.primary`, centered
- Right action: none

**2. Progress Bar**
- Width: full screen width
- Height: 4dp
- Background track: `border.default` at 30% opacity
- Fill: `gradient.premium` (left to right)
- Progress: 20% (step 1 of 5)
- Border radius: 2dp
- Position: directly below app bar, no gap

**3. Headline**
- Text: "What's your first name?"
- Typography: `heading.lg` -- Inter 600, 24sp, line-height 32sp
- Color: `text.primary`
- Alignment: left (right in RTL)
- Padding: 16dp horizontal

**4. Support Text**
- Text: "This helps us personalize your experience"
- Typography: `body.md` -- Inter 400, 14sp, line-height 20sp
- Color: `text.secondary`
- Alignment: left (right in RTL)
- Padding: 16dp horizontal

**5. Name Input Field**
- Label: "First Name" -- `label.md`, `text.secondary`, 4dp above field
- Field container:
  - Width: screen width minus 32dp
  - Height: 56dp (larger than standard for emphasis)
  - Background (dark): `bg.secondary`
  - Background (light): `bg.secondary`
  - Border: 1.5px solid `border.default`
  - Border radius: `radius.input` (8px)
  - Padding: 16dp horizontal
- Input text: `heading.sm` -- Inter 600, 18sp, `text.primary` (larger for name emphasis)
- Placeholder: "e.g. Ahmad" -- `heading.sm` 400, `text.tertiary`
- Keyboard type: `name` (auto-capitalize first letter)
- Max characters: 40
- Auto-focus: field receives focus on screen load with 300ms delay (keyboard slides up)

  **States:**
  | State | Border | Background |
  |-------|--------|------------|
  | Default | 1.5px `border.default` | `bg.secondary` |
  | Focused | 2px `brand.primary` | `bg.secondary` |
  | Filled | 1.5px `border.default` | `bg.secondary` |
  | Error | 2px `status.error` | `status.error` at 5% |

- Character counter: "0/40" -- `body.sm`, `text.tertiary`, right-aligned below field, shown only when field is focused
- Error text: "Please enter your name" (shown if user taps Continue with empty field)

**6. "Continue" Button**
- Same specs as "Get Started" button from Screen 2
- Text: "Continue"
- Disabled until name field has at least 1 character (after trimming whitespace)
- Position: pinned above keyboard when keyboard is visible, otherwise at natural position in layout

**7. "Skip for now" Link**
- Text: "Skip for now"
- Typography: `body.md` -- Inter 400, 14sp, `text.tertiary`
- Alignment: center
- Touch target: 48dp height
- On tap: navigate forward, store name as null (can be set later in settings)
- Hidden when keyboard is visible (only "Continue" button shown above keyboard)

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Progress track | `#30363D` at 30% | `#D0D7DE` at 30% |
| Progress fill | gradient `#4A90D9` to `#C9A96E` | same |
| Headline | `#F0F6FC` | `#1F2328` |
| Support text | `#8B949E` | `#656D76` |
| Input bg | `#161B22` | `#F6F8FA` |
| Input border | `#30363D` | `#D0D7DE` |
| Input text | `#F0F6FC` | `#1F2328` |
| Placeholder | `#484F58` | `#8C959F` |

#### RTL Notes

- Back arrow flips to right
- "About You" stays centered
- Progress bar fills from right to left in RTL
- Headline and support text align right
- Label aligns right
- Input text cursor starts from right, text aligns right
- Character counter moves to left-aligned below field
- Button and skip link stay centered

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide from right + fade |
| Progress fill | Page settle | 500ms | `ease-out` | Width animates from 0% to 20% |
| Headline entrance | Page settle | 300ms | `ease-out` | Fade + translate Y from 12dp |
| Support entrance | 100ms after headline | 200ms | `ease-out` | Fade in |
| Field focus | 300ms after page | 300ms | `ease-out` | Keyboard slides up, cursor blinks |
| Button enable | First char typed | 200ms | `ease-out` | Opacity transition |
| Keyboard shift | Field auto-focus | 250ms | `ease-out` | Content scrolls up, button repositions |

#### Accessibility

- App bar: "About You, step 1 of 5. Back button."
- Progress bar: "Progress: 20%, step 1 of 5"
- Headline: "What's your first name?"
- Input: "First Name, text field, required. 0 of 40 characters."
- On typing: character count updated in accessibility announcements every 10 characters
- Button: "Continue, button, disabled" / "Continue, button"
- Skip: "Skip for now, button. Your name can be added later in settings."

#### Edge Cases

- **Name with special characters:** Allow Unicode characters (Arabic names, accented Latin, etc.). Validate only for minimum 1 non-whitespace character.
- **Very long name:** Hard limit at 40 characters. Counter shows "40/40" and input stops accepting characters.
- **Keyboard types:** Arabic keyboard produces right-aligned Arabic text automatically. Malay uses Latin keyboard.
- **Name auto-fill:** Support autofill from device (Android `autofillHints: [AutofillHints.givenName]`).
- **Back while typing:** No discard dialog needed (single optional field). Simply navigate back.
- **Offensive content filter:** Not applied to names (cultural names may trigger false positives). Sanitize on server side for XSS only.

---

### Screen 5: Her Name + Zodiac

| Property | Value |
|----------|-------|
| **Screen Name** | Her Name + Zodiac |
| **Route** | `/onboarding/her-info` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Two-part data collection screen. Top half: her first name input. Bottom half: optional zodiac sign picker displayed as a horizontal scrollable carousel of 12 zodiac icons with labels. This combines the wireframe's "Your Profile" and "Her Zodiac" into a single streamlined screen to reduce onboarding friction. Progress bar at 40%.

**Structure (top to bottom):**
- App bar: 56dp
- Progress bar: 4dp (40% filled)
- Spacer: 24dp
- Headline: "Tell us about her"
- Spacer: 8dp
- Support text
- Spacer: 24dp
- Her Name label + field
- Spacer: 32dp
- Zodiac section header
- Spacer: 8dp
- Zodiac support text
- Spacer: 16dp
- Zodiac carousel (horizontal scroll)
- Spacer: 16dp
- Zodiac detail card (visible on selection)
- Spacer: 16dp
- "Don't know? Enter birthday" link + date picker
- Spacer: flexible (min 24dp)
- "Continue" button
- Spacer: 16dp
- "Skip zodiac" link
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + "About Her" title centered + no right action
- Same spec as Screen 4 app bar

**2. Progress Bar**
- Same spec as Screen 4, but filled to 40%

**3. Headline**
- Text: "Tell us about her"
- Typography: `heading.lg` -- 24sp, 600 weight
- Color: `text.primary`
- Alignment: start (left LTR, right RTL)
- Padding: 16dp horizontal

**4. Support Text**
- Text: "Her name and zodiac help us personalize everything"
- Typography: `body.md` -- 14sp, 400 weight
- Color: `text.secondary`

**5. Her Name Field**
- Label: "Her First Name"
- Same field spec as Screen 4's name field (56dp height, 18sp input text)
- Placeholder: "e.g. Sarah"
- Max: 40 chars
- Auto-focus: yes, 300ms delay
- Required for Continue (minimum 1 char after trim)

**6. Zodiac Section Header**
- Text: "Her Zodiac Sign"
- Typography: `heading.sm` -- 18sp, 600 weight
- Color: `text.primary`
- Optional badge: "(optional)" -- `body.sm`, `text.tertiary`, inline after header

**7. Zodiac Support Text**
- Text: "This sets smart personality defaults you can adjust later"
- Typography: `body.sm` -- 12sp, `text.secondary`

**8. Zodiac Carousel**
- Horizontal scrollable row
- Width: full screen width; items overflow and scroll
- Padding: 16dp on leading edge, 16dp trailing
- Gap between items: 12dp
- Scroll behavior: fling with snap-to-item

  **Zodiac Item (x12):**
  - Width: 72dp
  - Height: 88dp
  - Layout: Column -- icon top, label bottom
  - Background (dark default): `bg.tertiary` (`#21262D`)
  - Background (light default): `bg.tertiary` (`#EAEEF2`)
  - Border: 1px solid `border.default`
  - Border radius: `radius.card` (12px)
  - Padding: 8dp

  **Icon:**
  - Size: 36x36dp
  - Asset: `ic_zodiac_[sign].svg` (e.g., `ic_zodiac_aries.svg`)
  - Color (default, dark): `text.secondary` (`#8B949E`)
  - Color (default, light): `text.secondary` (`#656D76`)
  - Color (selected): `brand.accent` (`#C9A96E`)
  - Center aligned within card

  **Label:**
  - Typography: `label.sm` -- 12sp, 500 weight
  - Color (default): `text.secondary`
  - Color (selected): `brand.accent`
  - Center aligned
  - Single line, no truncation (all zodiac names fit at 12sp)

  **Zodiac Items Data:**
  | Sign | Icon Asset | Date Range |
  |------|-----------|------------|
  | Aries | `ic_zodiac_aries` | Mar 21 - Apr 19 |
  | Taurus | `ic_zodiac_taurus` | Apr 20 - May 20 |
  | Gemini | `ic_zodiac_gemini` | May 21 - Jun 20 |
  | Cancer | `ic_zodiac_cancer` | Jun 21 - Jul 22 |
  | Leo | `ic_zodiac_leo` | Jul 23 - Aug 22 |
  | Virgo | `ic_zodiac_virgo` | Aug 23 - Sep 22 |
  | Libra | `ic_zodiac_libra` | Sep 23 - Oct 22 |
  | Scorpio | `ic_zodiac_scorpio` | Oct 23 - Nov 21 |
  | Sagittarius | `ic_zodiac_sagittarius` | Nov 22 - Dec 21 |
  | Capricorn | `ic_zodiac_capricorn` | Dec 22 - Jan 19 |
  | Aquarius | `ic_zodiac_aquarius` | Jan 20 - Feb 18 |
  | Pisces | `ic_zodiac_pisces` | Feb 19 - Mar 20 |

  **Item States:**
  | State | Background | Border | Icon/Label Color |
  |-------|-----------|--------|-----------------|
  | Default | `bg.tertiary` | 1px `border.default` | `text.secondary` |
  | Pressed | darken 5% | 1px `border.emphasis` | `text.secondary` |
  | Selected | `brand.accent` at 10% | 2px `brand.accent` | `brand.accent` |
  | Focused (a11y) | `bg.tertiary` | 2px `brand.primary` | `text.secondary` |

**9. Zodiac Detail Card (conditional)**
- Visible only when a zodiac sign is selected
- Width: screen width minus 32dp
- Height: auto (approx 80dp)
- Background (dark): `bg.secondary`
- Background (light): `bg.secondary`
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp
- Layout: Row -- large icon left, text column right

  **Large Icon:** 48x48dp, `brand.accent` color
  **Sign Name:** `heading.sm` -- 18sp, 600 weight, `text.primary`
  **Date Range:** `body.sm` -- 12sp, `text.secondary`
  **Traits Preview:** `body.md` -- 14sp, `text.secondary`, italic. e.g. "Bold, passionate, confident"

- Entry animation: slide up from 16dp + fade in, `anim.fast` (200ms), `anim.spring`
- Exit animation (when switching signs): crossfade 150ms

**10. Birthday Fallback Link + Date Picker**
- Link text: "Don't know her sign? Enter her birthday"
- Typography: `body.md` -- 14sp, `brand.primary`, no underline
- Touch target: 48dp height
- On tap: reveal a date picker field below (animate in, `anim.normal` 300ms, slide down)
- Date picker field: same styling as text input fields, with calendar icon suffix
- On date selection: auto-calculate zodiac sign, scroll carousel to that sign, select it, show detail card
- Date format: locale-appropriate (MM/DD/YYYY for EN, DD/MM/YYYY for AR/MS)

**11. "Continue" Button**
- Same spec as Screen 4
- Enabled when: her name has 1+ characters (zodiac is optional)
- Position: pinned above keyboard when keyboard is visible

**12. "Skip zodiac" Link**
- Text: "Skip zodiac for now"
- Same styling as Screen 4's "Skip for now"
- Hidden when keyboard is visible
- Note: this only skips the zodiac; her name is still required for Continue

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Zodiac item bg | `#21262D` | `#EAEEF2` |
| Zodiac item border | `#30363D` | `#D0D7DE` |
| Selected item bg | `#C9A96E` at 10% | `#C9A96E` at 10% |
| Selected item border | `#C9A96E` | `#C9A96E` |
| Detail card bg | `#161B22` | `#F6F8FA` |
| Zodiac icon (default) | `#8B949E` | `#656D76` |
| Zodiac icon (selected) | `#C9A96E` | `#C9A96E` |

#### RTL Notes

- Back arrow flips
- All text aligns right
- Zodiac carousel scrolls from right; first item (Aries) appears rightmost
- Detail card: icon moves to right, text aligns right
- Birthday date picker uses DD/MM/YYYY format for Arabic
- Calendar icon in date field moves to left side

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Carousel entrance | Page settle (staggered) | 300ms | `anim.spring` | Each item fades in + scale from 0.9, 50ms stagger |
| Item select | Tap | 200ms | `ease-out` | Border + bg color transition |
| Detail card in | Selection | 200ms | `anim.spring` | Slide up 16dp + fade in |
| Detail card swap | New selection | 150ms | `ease-out` | Crossfade old to new |
| Birthday reveal | Link tap | 300ms | `anim.normal` | Date field slides down into view |
| Auto-scroll | Birthday date selected | 300ms | `ease-out` | Carousel scrolls to calculated sign |

#### Accessibility

- Carousel: "Zodiac sign selector. Horizontal list, 12 items. Swipe to browse."
- Each item: "Aries, March 21 to April 19, button" / "Aries, selected"
- Detail card: "Selected: Aries. March 21 to April 19. Bold, passionate, confident."
- Birthday link: "Don't know her sign? Enter her birthday instead, button"
- Date picker: standard platform date picker accessibility

#### Edge Cases

- **Her name in Arabic script:** Input accepts all Unicode. Placeholder changes to Arabic equivalent.
- **Zodiac carousel on small screens:** At 72dp width + 12dp gap, ~4 items visible at once. Sufficient for discovery with scroll hint (slight overflow of 5th item visible).
- **No zodiac selected + Continue:** Allowed. Zodiac stored as null. Dashboard shows gentle prompt to add zodiac later.
- **Date picker edge dates:** Feb 29 handled (leap year aware). Dates map correctly to zodiac boundaries.
- **Keyboard visible:** Zodiac section scrolls below fold. Keyboard dismisses on scroll or on tapping outside field.

---

### Screen 6: Relationship Status

| Property | Value |
|----------|-------|
| **Screen Name** | Relationship Status |
| **Route** | `/onboarding/relationship` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Single-purpose screen. Five status options displayed as selectable cards (not radio buttons for richer visual). Progress bar at 60%. Minimal text. Each card has an icon, title, and subtle description.

**Structure (top to bottom):**
- App bar: 56dp
- Progress bar: 4dp (60% filled)
- Spacer: 24dp
- Headline
- Spacer: 8dp
- Support text
- Spacer: 24dp
- Status card 1
- Spacer: 12dp
- Status card 2
- Spacer: 12dp
- Status card 3
- Spacer: 12dp
- Status card 4
- Spacer: 12dp
- Status card 5
- Spacer: flexible (min 24dp)
- "Continue" button
- Spacer: 16dp
- "Skip for now" link
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Same spec as Screen 4. Title: "About You"

**2. Progress Bar**
- 60% filled with `gradient.premium`

**3. Headline**
- Text: "What's your relationship status?"
- Typography: `heading.lg` -- 24sp, 600
- Color: `text.primary`

**4. Support Text**
- Text: "This helps LOLO tailor advice to your situation"
- Typography: `body.md` -- 14sp, `text.secondary`

**5. Status Cards (x5)**
- Width: screen width minus 32dp
- Height: 64dp
- Background (dark): `bg.tertiary`
- Background (light): `bg.tertiary`
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp horizontal
- Layout: Row -- icon (left), text column (center), radio indicator (right)

  **Icon:** 28x28dp, themed per status, color `text.secondary` (default), `brand.primary` (selected)
  **Title:** `label.lg` -- 16sp, 500, `text.primary`
  **Subtitle:** `body.sm` -- 12sp, `text.secondary`
  **Radio Indicator:** 20x20dp circle outline, right-aligned

  **Cards Data:**
  | Status | Icon | Subtitle |
  |--------|------|----------|
  | Dating | `ic_heart_outline` | "Getting to know each other" |
  | Engaged | `ic_ring` | "Planning your future together" |
  | Married | `ic_home_heart` | "Building a life together" |
  | Long-distance | `ic_airplane_heart` | "Love across the miles" |
  | It's complicated | `ic_puzzle_heart` | "Every relationship is unique" |

  **States:**
  | State | Background | Border | Radio |
  |-------|-----------|--------|-------|
  | Default | `bg.tertiary` | 1px `border.default` | Empty circle, `border.default` |
  | Pressed | darken 5% | 1px `border.emphasis` | -- |
  | Selected | `brand.primary` at 8% | 2px `brand.primary` | Filled circle `brand.primary` with white center dot |
  | Focused | `bg.tertiary` | 2px `brand.primary` | Focus ring |

**6. "Continue" Button**
- Same as previous screens
- Disabled until one status is selected

**7. "Skip for now" Link**
- Same spec as Screen 4

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Card bg | `#21262D` | `#EAEEF2` |
| Card border | `#30363D` | `#D0D7DE` |
| Selected card bg | `#4A90D9` at 8% | `#4A90D9` at 8% |
| Selected border | `#4A90D9` | `#4A90D9` |
| Icon default | `#8B949E` | `#656D76` |
| Icon selected | `#4A90D9` | `#4A90D9` |
| Radio outline | `#30363D` | `#D0D7DE` |
| Radio filled | `#4A90D9` | `#4A90D9` |

#### RTL Notes

- Icon moves to right side of card
- Text aligns right
- Radio indicator moves to left side
- Card order remains top-to-bottom (same conceptual order)
- Subtitle text reflows for Arabic

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Cards entrance | Page settle (staggered) | 300ms | `anim.spring` | Fade in + translate Y 16dp, 80ms stagger between cards |
| Card select | Tap | 200ms | `ease-out` | Border + bg color + radio fill transition |
| Card deselect | New selection | 150ms | `ease-out` | Previous card reverts to default |
| Radio fill | Selection | 200ms | `anim.spring` | Scale from 0 to 1 within radio circle |

#### Accessibility

- Screen: "What's your relationship status? Select one option."
- Each card: "Dating. Getting to know each other. Radio button, not selected." / "Dating. Getting to know each other. Radio button, selected."
- Cards form a radio group semantically
- Continue: "Continue, button, disabled" until selection made

#### Edge Cases

- **No selection + Continue tap:** Button is disabled. If somehow tapped, show inline hint: "Please select your relationship status"
- **Multiple rapid taps:** Only last selection registers. Debounce with 100ms window.
- **Screen reader:** Cards are navigable with swipe gestures in sequence.

---

### Screen 7: Key Date

| Property | Value |
|----------|-------|
| **Screen Name** | Key Date |
| **Route** | `/onboarding/keydate` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

Date picker screen for anniversary or birthday. Two tabs or toggle: "Anniversary" and "Her Birthday". A large date picker widget. Progress bar at 80%. Optional -- user can skip.

**Structure (top to bottom):**
- App bar: 56dp
- Progress bar: 4dp (80% filled)
- Spacer: 24dp
- Headline
- Spacer: 8dp
- Support text
- Spacer: 24dp
- Date type toggle (segmented control)
- Spacer: 24dp
- Date picker widget
- Spacer: 16dp
- Selected date display text
- Spacer: 16dp
- "Set reminder for this date" checkbox
- Spacer: flexible (min 24dp)
- "Continue" button
- Spacer: 16dp
- "Skip for now" link
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Title: "Important Date"
- Same spec pattern

**2. Progress Bar**
- 80% filled

**3. Headline**
- Text: "When is your special day?"
- Typography: `heading.lg` -- 24sp, 600, `text.primary`

**4. Support Text**
- Text: "We'll make sure you never forget"
- Typography: `body.md` -- 14sp, `text.secondary`

**5. Date Type Toggle (Segmented Control)**
- Width: screen width minus 32dp
- Height: 40dp
- Background: `bg.secondary`
- Border: 1px solid `border.default`
- Border radius: 20dp (pill shape)
- Two segments: "Anniversary" | "Her Birthday"
- Each segment: 50% width

  **Segment Text:** `label.md` -- 14sp, 500

  **States:**
  | State | Segment Bg | Text Color |
  |-------|-----------|------------|
  | Inactive | transparent | `text.secondary` |
  | Active | `brand.primary` | `#FFFFFF` |
  | Pressed | `brand.primary` at 80% | `#FFFFFF` |

  - Active segment has pill background that slides between segments (animated, `anim.normal` 300ms, `ease-out`)

**6. Date Picker Widget**
- Type: inline calendar picker (not a dialog)
- Width: screen width minus 32dp
- Height: auto (~300dp)
- Background (dark): `bg.secondary`
- Background (light): `bg.secondary`
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp

  **Month/Year Header:**
  - Layout: Row -- left arrow, month/year text, right arrow
  - Arrows: 24x24dp in 48x48dp touch targets, `text.secondary`
  - Text: "February 2026" -- `heading.sm` -- 18sp, 600, `text.primary`
  - Center aligned

  **Day-of-Week Headers:**
  - Row of 7 labels: Su Mo Tu We Th Fr Sa (EN) / locale-appropriate
  - Typography: `label.sm` -- 12sp, 500, `text.tertiary`
  - Height: 32dp
  - Center aligned per column

  **Day Cells:**
  - Size: 40x40dp each (7 columns fill width)
  - Typography: `body.md` -- 14sp, `text.primary`
  - Shape: circle for selected, none for default

  | State | Background | Text | Border |
  |-------|-----------|------|--------|
  | Default | transparent | `text.primary` | none |
  | Today | transparent | `brand.primary` | 1px `brand.primary` circle |
  | Selected | `brand.primary` | `#FFFFFF` | none |
  | Disabled (future for birthday) | transparent | `text.tertiary` at 40% | none |
  | Pressed | `brand.primary` at 15% | `text.primary` | none |

**7. Selected Date Display**
- Text: "March 21, 2024" (formatted per locale)
- Typography: `heading.md` -- 20sp, 600, `brand.primary`
- Alignment: center
- Subtext: "2 years and 11 months ago" or "in 35 days" (relative description)
- Sub typography: `body.md` -- 14sp, `text.secondary`

**8. Reminder Checkbox**
- Layout: Row -- checkbox left, text right
- Checkbox: 24x24dp, border radius 6px
- Unchecked: border `border.default`, transparent fill
- Checked: `brand.primary` fill, white checkmark icon 14x14dp
- Label: "Set automatic reminders for this date"
- Typography: `body.md` -- 14sp, `text.primary`
- Default: checked

**9. "Continue" Button**
- Enabled when a date is selected
- Same spec as previous screens

**10. "Skip for now" Link**
- Same spec as previous screens

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Calendar bg | `#161B22` | `#F6F8FA` |
| Calendar border | `#30363D` | `#D0D7DE` |
| Today indicator | `#4A90D9` | `#4A90D9` |
| Selected day bg | `#4A90D9` | `#4A90D9` |
| Selected day text | `#FFFFFF` | `#FFFFFF` |
| Toggle bg | `#161B22` | `#F6F8FA` |
| Active toggle bg | `#4A90D9` | `#4A90D9` |

#### RTL Notes

- Calendar navigation arrows: left arrow becomes "next month" in RTL, right arrow "previous month" (logic swap, icon directions stay)
- Week starts on Saturday for Arabic locale, Sunday for EN, Monday for MS
- Day-of-week headers update per locale
- Date format: "21 March 2024" for Arabic (day first)
- Segmented control: stays same visual layout, text reflows
- Checkbox: moves to right, label on left

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Calendar entrance | Page settle | 400ms | `anim.normal` | Fade in + scale from 0.95 |
| Month transition | Arrow tap | 300ms | `ease-out` | Slide old month out, new month in (direction matches arrow) |
| Day select | Tap | 200ms | `anim.spring` | Circle scales from 0 to 1 behind text |
| Toggle slide | Segment tap | 300ms | `ease-out` | Active indicator pill slides to new segment |
| Date display | Selection | 200ms | `ease-out` | Text fades in / crossfades on change |

#### Accessibility

- Segmented control: "Date type. Anniversary, selected. Her Birthday, not selected. Segmented control."
- Calendar: standard date picker accessibility; "February 2026. Select a date."
- Each day: "February 14, 2026. Double tap to select."
- Selected date: "Selected date: March 21, 2024. 2 years and 11 months ago."
- Checkbox: "Set automatic reminders for this date. Checkbox, checked."

#### Edge Cases

- **Anniversary in the future:** Allow it (user might be pre-planning). Show relative time as "in X days."
- **Birthday: allow only past dates up to 100 years ago.** Future dates disabled for birthday mode.
- **Feb 29 on non-leap year:** Calendar correctly handles. If user selected Feb 29 and next recurrence year is not leap, reminder adjusts to Feb 28.
- **Very old dates (pre-1970):** Supported. Calendar scrolls back. Performance OK as only one month rendered at a time.
- **No date selected + Continue:** Button disabled. If somehow tapped, show hint "Please select a date."

---

### Screen 8: First Action Card

| Property | Value |
|----------|-------|
| **Screen Name** | First Action Card |
| **Route** | `/onboarding/first-card` |
| **Module** | Onboarding |
| **Sprint** | Sprint 1 |

#### Layout Description

The "aha moment" screen. No app bar back arrow (deliberate -- this is a forward-only reveal). Full-screen experience. An AI-generated SAY action card animates in dramatically. This is designed to demonstrate LOLO's core value immediately. Progress bar at 100%. Confetti/sparkle animation on load.

**Structure (top to bottom):**
- Status bar: 24dp
- Spacer: 16dp
- Progress bar: 4dp (100% filled, triggers completion animation)
- Spacer: 24dp
- Celebration headline
- Spacer: 8dp
- Support text
- Spacer: 32dp
- Action Card (hero element)
- Spacer: 24dp
- Action buttons row (Copy / Share)
- Spacer: 16dp
- Tip text
- Spacer: flexible (min 24dp)
- "Go to Dashboard" button (primary)
- Spacer: 8dp
- "Customize first" link
- Spacer: 24dp

#### Component Breakdown

**1. Progress Bar (completion)**
- 100% filled with `gradient.premium`
- On reaching 100%: brief glow pulse animation (1 cycle, 600ms)
- The gradient intensifies then settles

**2. Celebration Headline**
- Text: "Your first action card is ready!"
- Typography: `heading.lg` -- 24sp, 600, `text.primary`
- Alignment: center
- Sparkle emoji or sparkle icon (16dp) inline at end -- or use a small sparkle animation overlay

**3. Support Text**
- Text: "LOLO analyzed her profile and crafted this for you"
- Typography: `body.md` -- 14sp, `text.secondary`
- Alignment: center

**4. Action Card (Hero)**
- Width: screen width minus 32dp
- Min height: 200dp (auto-expands based on content)
- Background: `gradient.card.subtle` (dark: `#21262D` to `#161B22`, light: `#EAEEF2` to `#F6F8FA`)
- Border: 1.5px solid `brand.accent` (`#C9A96E`) -- gold border for premium feel
- Border radius: 16px (larger than standard 12px for hero treatment)
- Elevation: `elevation.2`
- Padding: 20dp

  **Card Structure (top to bottom within card):**

  **Type Badge:**
  - Text: "SAY"
  - Background: `brand.primary` (`#4A90D9`)
  - Text color: `#FFFFFF`
  - Typography: `label.sm` -- 12sp, 600, all caps, letter-spacing 1.5px
  - Size: auto width, 24dp height
  - Border radius: 6px
  - Position: top-left of card content

  **Context Line:**
  - Text: varies, e.g. "She loves words of affirmation" or "Based on her Aries personality"
  - Typography: `body.sm` -- 12sp, `text.secondary`, italic
  - Position: below badge, 8dp gap

  **Message Content:**
  - Text: AI-generated message, e.g. "I know I don't say this enough, but I notice all the little things you do. The way you light up a room just by walking in. You make ordinary days feel special, and I never want you to doubt how much that means to me."
  - Typography: `body.lg` -- 16sp, 400, line-height 24sp, `text.primary`
  - Quotation styling: opening and closing curly quotes in `brand.accent` (`#C9A96E`), 24sp, 600 weight
  - Position: below context, 12dp gap

  **Card Accent:** Thin left border accent strip (4dp wide, full card height, `gradient.premium`) in addition to the full gold border. This creates a layered premium feel.

**5. Action Buttons Row**
- Layout: Row, centered, 16dp gap between buttons
- Each button: 56dp width (auto-expand to fit label), 40dp height

  **Copy Button:**
  - Icon: `ic_copy.svg` 20x20dp, `brand.primary`
  - Label: "Copy" -- `label.sm` -- 12sp, `brand.primary`
  - Background: transparent
  - Border: 1px solid `brand.primary`
  - Border radius: `radius.button` (24px)
  - On tap: copy message text to clipboard, show "Copied!" toast, icon briefly changes to checkmark (300ms)

  **Share Button:**
  - Icon: `ic_share.svg` 20x20dp, `brand.primary`
  - Label: "Share" -- `label.sm` -- 12sp, `brand.primary`
  - Same outlined styling
  - On tap: open native share sheet

**6. Tip Text**
- Icon: `ic_lightbulb.svg` 16x16dp, `brand.accent`
- Text: "Tip: Send this now for maximum impact. She won't know it's AI-powered."
- Typography: `body.sm` -- 12sp, `text.secondary`
- Layout: Row, icon left, text right
- Background: `brand.accent` at 5% opacity
- Padding: 12dp
- Border radius: 8px

**7. "Go to Dashboard" Button**
- Width: screen width minus 32dp
- Height: 52dp
- Background: `gradient.premium` (instead of flat primary -- special for onboarding completion)
- Text: "Go to Dashboard" -- `button`, `#FFFFFF`
- Border radius: `radius.button` (24px)
- Elevation: `elevation.2`
- On tap: navigate to `/home`, mark onboarding as complete

**8. "Customize first" Link**
- Text: "I want to customize her profile first"
- Typography: `body.md` -- 14sp, `brand.primary`
- Alignment: center
- On tap: navigate to `/her-profile`

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Card bg gradient | `#21262D` to `#161B22` | `#EAEEF2` to `#F6F8FA` |
| Card border | `#C9A96E` (gold) | `#C9A96E` (gold) |
| SAY badge bg | `#4A90D9` | `#4A90D9` |
| Message text | `#F0F6FC` | `#1F2328` |
| Quote marks | `#C9A96E` | `#C9A96E` |
| Button gradient | `#4A90D9` to `#C9A96E` | `#4A90D9` to `#C9A96E` |
| Tip bg | `#C9A96E` at 5% | `#C9A96E` at 5% |

#### RTL Notes

- Card type badge moves to top-right
- Left accent strip becomes right accent strip
- Message text aligns right for Arabic
- Quote marks: opening quote on right, closing on left (Arabic quotation convention)
- Copy/Share buttons stay centered
- Tip icon moves to right, text aligns right
- Buttons stay centered

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Progress completion | Page load | 500ms | `ease-out` | Fill animates to 100% + golden glow pulse |
| Sparkle overlay | After progress | 800ms | linear | Particle sparkles float up from card area, 8-12 particles, gold color, fade out |
| Headline entrance | 200ms after load | 300ms | `ease-out` | Fade in + translate Y from 16dp |
| Card entrance | 400ms after load | 500ms | `anim.spring` | Scale from 0.9 to 1.0 + fade in + slight rotation (2deg to 0deg) |
| Card accent glow | After card settles | 1500ms loop | `ease-in-out` | Subtle gold border opacity pulses between 60% and 100%, continuous |
| Type badge | 100ms after card | 200ms | `anim.spring` | Scale from 0 to 1 (pop in) |
| Message text | 200ms after card | 400ms | `ease-out` | Typewriter effect -- characters appear left-to-right (or right-to-left for Arabic) at 30ms per character, max 2 seconds total then instant-fill remainder |
| Buttons entrance | After message complete | 300ms | `anim.spring` | Fade in + translate Y from 12dp |
| Tip entrance | 100ms after buttons | 200ms | `ease-out` | Fade in |
| CTA entrance | 200ms after tip | 300ms | `anim.spring` | Fade in + translate Y from 16dp |

#### Accessibility

- Screen: "Congratulations! Your first action card is ready. LOLO analyzed her profile and crafted this for you."
- Card: "Action card, type: Say. Context: She loves words of affirmation. Message: [full message text]"
- Copy button: "Copy message to clipboard, button"
- Share button: "Share message, button"
- Tip: "Tip: Send this now for maximum impact."
- Dashboard button: "Go to Dashboard, button"
- Customize link: "I want to customize her profile first, button"
- Typewriter animation: screen reader reads full text immediately (animation is visual only)

#### Edge Cases

- **No zodiac / minimal profile:** AI generates a generic but still warm message. Context line: "A message to start your journey"
- **AI generation failure:** Show a pre-written fallback message from a curated library. Subtitle changes to "Here's something special to get you started." No error state visible to user.
- **Very long generated message:** Max 280 characters. Card height auto-expands. Scroll within card if needed (rare).
- **Share sheet empty:** If no share targets available, show toast: "Install a messaging app to share directly."
- **User returns to this screen:** If onboarding is complete and user navigates back here via deep link, redirect to `/home`.

---

## MODULE 2: DASHBOARD

---

### Screen 9: Home Dashboard

| Property | Value |
|----------|-------|
| **Screen Name** | Home Dashboard |
| **Route** | `/home` |
| **Module** | Dashboard |
| **Sprint** | Sprint 2 |

#### Layout Description

The main hub of LOLO. Vertically scrollable single-column layout. Custom app bar with avatar and notification bell. Streak/gamification card. Mood check-in row. Action cards feed (SAY/DO/BUY/GO). Bottom navigation bar pinned at bottom. Pull-to-refresh enabled. This is the most content-dense screen and must feel alive with smart daily updates.

**Structure (top to bottom):**
- Status bar: 24dp (transparent, content draws behind)
- Dashboard app bar: 64dp
- Spacer: 16dp
- Streak card: auto height (~80dp)
- Spacer: 16dp
- Mood check-in row: 48dp
- Spacer: 8dp
- Mood emoji buttons row: 48dp
- Spacer: 24dp
- "Today's Actions" section header: 24dp
- Spacer: 12dp
- Action card 1
- Spacer: 12dp
- Action card 2
- Spacer: 12dp
- Action card 3
- Spacer: 12dp
- (more cards, lazy loaded)
- Spacer: 80dp (clearance for bottom nav)
- **Bottom Nav Bar:** 64dp, pinned to bottom

#### Component Breakdown

**1. Dashboard App Bar**
- Height: 64dp
- Background: `bg.primary` (transparent blending into status bar)
- Layout: Row -- avatar (left), greeting column (center-left), notification bell (right)
- Padding: 16dp horizontal

  **Avatar:**
  - Size: 40x40dp
  - Shape: circle
  - Border: 2px solid `brand.primary`
  - Default: initials on `bg.tertiary` background (e.g. "A" for Ahmad), `text.primary`, `label.lg` 16sp 500
  - With photo: image fills circle, `object-fit: cover`
  - Touch target: 48x48dp
  - On tap: navigate to `/settings`

  **Greeting:**
  - Line 1: "Good morning," -- `body.md` -- 14sp, 400, `text.secondary`
  - Line 2: "Ahmad" -- `heading.sm` -- 18sp, 600, `text.primary`
  - Position: 12dp right of avatar
  - Greeting logic: "Good morning" (5am-12pm), "Good afternoon" (12pm-5pm), "Good evening" (5pm-9pm), "Good night" (9pm-5am)

  **Notification Bell:**
  - Icon: `ic_bell.svg` 24x24dp
  - Color: `text.secondary`
  - Touch target: 48x48dp
  - Position: 16dp from right edge
  - Badge dot: 8x8dp circle, `status.error` (`#F85149`), positioned top-right of bell icon (offset -2dp, -2dp), visible only when unread notifications exist
  - On tap: navigate to `/notifications`

**2. Streak Card**
- Width: screen width minus 32dp
- Height: auto (~80dp)
- Background: `gradient.premium` (135deg `#4A90D9` to `#C9A96E`)
- Border radius: `radius.card` (12px)
- Padding: 16dp
- Elevation: `elevation.2`
- Layout: Row -- streak info (left), level/points (right)

  **Streak Counter:**
  - Layout: Row -- fire icon + number
  - Fire icon: `ic_fire.svg` 24x24dp, `#FFFFFF`
  - Number: "12" -- `display.md` -- Inter 700, 28sp, `#FFFFFF`
  - Label: "day streak" -- `body.md` -- 14sp, 400, `#FFFFFF` at 80%
  - Layout is vertical: number + "day streak" stacked

  **Level & Points:**
  - Level: "Good Partner" -- `label.md` -- 14sp, 500, `#FFFFFF`
  - Points: "847 pts" -- `body.sm` -- 12sp, `#FFFFFF` at 80%
  - Alignment: right-aligned, vertically centered
  - Small progress bar to next level: 60dp wide, 4dp height, `#FFFFFF` at 30% track, `#FFFFFF` fill

  **States:**
  | State | Visual |
  |-------|--------|
  | Active streak | Full gradient, fire icon animated (subtle flicker) |
  | Broken streak | Background becomes `bg.tertiary` with `border.default` border, fire icon replaced with `ic_fire_out.svg` in `text.tertiary`, streak shows "0" |
  | New record | Sparkle particle overlay on card, "New record!" badge |

**3. Mood Check-In Section**

  **Label Row:**
  - Text: "How is she today?"
  - Typography: `label.lg` -- 16sp, 500, `text.primary`
  - Position: left-aligned (right in RTL), 16dp padding

  **Mood Button Row:**
  - Layout: Row, evenly spaced, 16dp horizontal padding
  - 4 mood buttons visible. On tap any button, opens full mood check-in bottom sheet (Screen 11 Quick Actions).

  **Mood Button (x4):**
  - Size: 64x40dp (wider for emoji + label)
  - Background: `bg.tertiary`
  - Border: 1px solid `border.default`
  - Border radius: 20dp (pill)
  - Layout: Row -- emoji (16dp) + label (12sp)
  - Gap: 4dp between emoji and label

  | Mood | Emoji | Label |
  |------|-------|-------|
  | Great | :) | "Great" |
  | Ok | :| | "Ok" |
  | Stressed | :S | "Stressed" |
  | Upset | :( | "Upset" |

  - Label: `label.sm` -- 12sp, 500, `text.secondary`
  - On tap: submit quick mood (if single tap) OR open full check-in sheet (long press or if "more options" desired)
  - Selected state (if already checked in today): selected mood button has `brand.primary` border and bg at 10%, label color `brand.primary`

**4. "Today's Actions" Section Header**
- Text: "Today's Actions"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`
- Padding: 16dp horizontal
- Right side: "See all" link -- `body.md`, `brand.primary`, on tap navigates to full action list

**5. Action Card (repeating, 2-4 per day)**
- Width: screen width minus 32dp
- Min height: 120dp (auto-expands)
- Background (dark): `bg.tertiary` (`#21262D`)
- Background (light): `bg.tertiary` (`#EAEEF2`)
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp
- Elevation: `elevation.1`

  **Card Structure:**

  **Type Badge (top-left):**
  - Same spec as Screen 8 type badge
  - Color-coded by type:
    | Type | Badge Color | Icon |
    |------|------------|------|
    | SAY | `brand.primary` (`#4A90D9`) | `ic_message` |
    | DO | `status.success` (`#3FB950`) | `ic_checkmark_circle` |
    | BUY | `brand.accent` (`#C9A96E`) | `ic_gift` |
    | GO | `status.warning` (`#D29922`) | `ic_location` |

  **Context Text:**
  - e.g. "She had a long day" / "Anniversary in 3 days" / "She mentioned wanting a new scarf"
  - Typography: `body.md` -- 14sp, 400, `text.secondary`
  - Position: below badge, 8dp gap

  **Message Preview (SAY cards only):**
  - Quoted text preview, max 2 lines with ellipsis
  - Typography: `body.md` -- 14sp, 400, `text.primary`, italic
  - Opening quote mark: `brand.accent`, 16sp

  **Action Description (DO/BUY/GO cards):**
  - Typography: `body.lg` -- 16sp, 400, `text.primary`
  - Max 3 lines

  **Card Action Buttons (bottom-right):**
  - Ghost/text buttons, `brand.primary` color
  - Typography: `label.md` -- 14sp, 500
  - Touch target: 48dp height
  - Examples: "Copy" / "Send" / "View Plan" / "Browse" / "Dismiss"
  - Layout: Row, 8dp gap, right-aligned (left-aligned in RTL)

  **Swipe Actions:**
  - Swipe right: "Done" / save (green background reveal with checkmark, `status.success`)
  - Swipe left: "Dismiss" (muted background reveal with X, `text.tertiary`)
  - Swipe threshold: 80dp
  - Behind-card action icon: 24x24dp, centered vertically, 24dp from edge

  **Card States:**
  | State | Visual |
  |-------|--------|
  | Default | Standard styling |
  | Pressed | Scale 0.98, `anim.instant` |
  | Completed | Muted opacity 60%, green check badge top-right, strikethrough on action text |
  | Dismissed | Animate out (slide + fade), removed from list |
  | Loading | Skeleton shimmer: 3 lines of varying width, pulsing bg |

**6. Bottom Navigation Bar**
- Height: 64dp
- Background (dark): `bg.secondary` (`#161B22`)
- Background (light): `#FFFFFF`
- Border top: 1px solid `border.default`
- Elevation: `elevation.2`
- Position: fixed to bottom, above system navigation bar
- Layout: Row, 5 equal tabs

  **Tab Item (x5):**
  - Width: 20% of screen width
  - Height: 64dp
  - Layout: Column -- icon (24dp) + label (10sp), centered, 4dp gap
  - Touch target: full tab area (minimum 48dp wide)

  | Tab | Icon (inactive) | Icon (active) | Label |
  |-----|----------------|---------------|-------|
  | Home | `ic_home_outline` | `ic_home_filled` | "Home" |
  | Messages | `ic_message_outline` | `ic_message_filled` | "Messages" |
  | Gifts | `ic_gift_outline` | `ic_gift_filled` | "Gifts" |
  | SOS | `ic_sos_outline` | `ic_sos_filled` | "SOS" |
  | Her | `ic_heart_outline` | `ic_heart_filled` | "Her" |

  **Tab States:**
  | State | Icon Color | Label Color | Other |
  |-------|-----------|-------------|-------|
  | Inactive | `text.tertiary` | `text.tertiary` | Outline icon variant |
  | Active | `brand.primary` | `brand.primary` | Filled icon variant, label bold (500) |
  | Pressed | `brand.primary` at 70% | same | Ripple effect on tab area |

  - Active indicator: pill shape behind active icon, `brand.primary` at 10%, 48x32dp, radius 16dp
  - Tab switch animation: icon crossfade 150ms, indicator slides 200ms `ease-out`

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| App bar bg | `#0D1117` | `#FFFFFF` |
| Streak card | gradient | gradient |
| Mood button bg | `#21262D` | `#EAEEF2` |
| Action card bg | `#21262D` | `#EAEEF2` |
| Action card border | `#30363D` | `#D0D7DE` |
| Bottom nav bg | `#161B22` | `#FFFFFF` |
| Bottom nav border | `#30363D` | `#D0D7DE` |
| Inactive tab icon | `#484F58` | `#8C959F` |

#### RTL Notes

- Avatar moves to right, bell to left
- Greeting text aligns right
- Streak card: fire icon + number on right, level/points on left
- Mood buttons: order reverses (Great rightmost)
- "Today's Actions" header aligns right, "See all" on left
- Action cards: type badge top-right, action buttons bottom-left
- Swipe directions reverse: swipe left = "Done", swipe right = "Dismiss"
- Bottom nav: Home is rightmost tab in RTL

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Pull-to-refresh | Pull down gesture | 500ms | `ease-out` | Custom LOLO spinner (compass icon rotating) |
| Streak card entrance | Page load | 400ms | `anim.spring` | Slide down from -24dp + fade in |
| Fire flicker | Continuous (streak active) | 2000ms loop | `ease-in-out` | Subtle scale oscillation 1.0 to 1.1, opacity 90%-100% |
| Mood button press | Tap | 200ms | `anim.spring` | Scale to 0.9 then 1.0 (bounce) |
| Action card entrance | Scroll into view | 300ms | `anim.normal` | Fade in + translate Y from 16dp |
| Card swipe dismiss | Swipe past threshold | 200ms | `ease-out` | Slide out fully + height collapse to 0 |
| Card completion | Tap "Done" | 400ms | `anim.spring` | Check icon pops in, card fades to 60% opacity |
| Bottom nav tab switch | Tab tap | 200ms | `ease-out` | Icon crossfade + indicator slide |

#### Accessibility

- App bar: "Dashboard. Good morning, Ahmad. Profile settings button. Notifications button, 3 unread."
- Streak card: "Thoughtfulness streak: 12 days. Level: Good Partner. 847 points."
- Mood section: "How is she today? 4 options: Great, Ok, Stressed, Upset."
- Each mood button: "Great, button" etc.
- Section header: "Today's Actions. See all, button."
- Action cards: "Say card. She had a long day. Message: [preview]. Copy button. Send button."
- Bottom nav: "Navigation bar. Home, selected. Messages. Gifts. SOS. Her Profile."
- Swipe actions: hidden from screen reader; use long-press context menu instead for a11y users

#### Edge Cases

- **New user (no data):** Streak card shows "0 day streak, Level: Rookie, 0 pts". Action cards area shows: illustration of compass + "Welcome to LOLO! Tell us about her to get personalized actions." + CTA button "Set Up Her Profile". Mood check-in hidden until profile has data.
- **No actions today:** "All caught up! You're doing great today." illustration with relaxed character. Below: "Check back tomorrow for new suggestions."
- **Offline:** Cached action cards shown with "Offline" banner at top (48dp, `status.warning` bg at 15%, warning icon + "You're offline. Some features need internet."). Mood check-in disabled. Streak card shows cached value.
- **Loading:** Skeleton UI: shimmer on streak card (single block), 3 skeleton action cards (rectangular blocks with pulsing animation). Mood buttons show but are not interactive until load completes.
- **Error:** "Couldn't load your dashboard" with "Retry" button centered in action area. Streak card and nav still shown.
- **Many action cards:** Lazy load. Show max 5 initially. "Show more" button at bottom loads next batch of 5. Skeleton shimmer while loading.
- **Quick action bar overlapping keyboard:** Bottom nav hides when keyboard is open (rare on dashboard since no text input).

---

### Screen 10: Notification Center

| Property | Value |
|----------|-------|
| **Screen Name** | Notification Center |
| **Route** | `/notifications` |
| **Module** | Dashboard |
| **Sprint** | Sprint 2 |

#### Layout Description

Full-screen list view with app bar. Notifications grouped by time period (Today, Yesterday, Earlier). Each notification is a tile with type icon, title, preview, timestamp, and optional action chevron. Unread items have visual distinction. Scrollable with pull-to-refresh and lazy pagination.

**Structure (top to bottom):**
- App bar: 56dp
- Spacer: 8dp
- "Mark all as read" action row (visible only if unread exist): 40dp
- Spacer: 8dp
- Date group header: "Today"
- Notification tiles for today
- Spacer: 16dp
- Date group header: "Yesterday"
- Notification tiles for yesterday
- Spacer: 16dp
- Date group header: "Earlier"
- Notification tiles for earlier
- Spacer: 80dp (bottom nav clearance)
- Bottom nav: 64dp

#### Component Breakdown

**1. App Bar**
- Back arrow + "Notifications" title centered + no right action
- Same base spec as other app bars

**2. "Mark all as read" Row**
- Text: "Mark all as read"
- Typography: `label.md` -- 14sp, 500, `brand.primary`
- Alignment: right (left in RTL)
- Padding: 16dp horizontal
- Touch target: 48dp height
- On tap: all notifications marked as read, visual unread indicators removed
- Visible only when 1+ unread notifications exist

**3. Date Group Header**
- Text: "Today" / "Yesterday" / "Earlier" / or specific date like "February 10"
- Typography: `label.md` -- 14sp, 500, `text.tertiary`
- Padding: 16dp horizontal
- Height: 32dp
- Sticky behavior: sticks to top when scrolled (sticky header)
- Background: `bg.primary` (to cover content beneath when sticky)

**4. Notification Tile**
- Width: full screen width
- Min height: 72dp
- Background: `bg.primary`
- Padding: 16dp horizontal, 12dp vertical
- Border bottom: 1px solid `border.default` at 50% opacity (subtle divider)
- Layout: Row -- type icon (left), content column (center), timestamp + chevron (right)

  **Type Icon Container:**
  - Size: 40x40dp
  - Background: type-color at 10% opacity
  - Border radius: 10dp
  - Icon: 20x20dp, centered, type-color

  | Type | Color | Icon |
  |------|-------|------|
  | Reminder | `brand.primary` (`#4A90D9`) | `ic_bell` |
  | Message | `status.success` (`#3FB950`) | `ic_message` |
  | Streak | `status.warning` (`#D29922`) | `ic_fire` |
  | Gift | `brand.accent` (`#C9A96E`) | `ic_gift` |
  | SOS | `status.error` (`#F85149`) | `ic_alert` |
  | System | `text.tertiary` | `ic_gear` |

  **Content Column:**
  - Title: `label.lg` -- 16sp, 500, `text.primary`. Single line, truncate with ellipsis.
  - Body: `body.md` -- 14sp, 400, `text.secondary`. Max 2 lines, ellipsis.
  - Gap: 2dp between title and body
  - Padding left: 12dp from icon container

  **Timestamp:**
  - Typography: `body.sm` -- 12sp, 400, `text.tertiary`
  - Position: top-right of tile
  - Format: "2h ago" / "4h ago" / "1d ago" / "3d ago" / "Feb 10"

  **Chevron (conditional):**
  - `ic_chevron_right.svg` 16x16dp, `text.tertiary`
  - Position: right edge, vertically centered
  - Visible only for actionable notifications (those that navigate somewhere)

  **Unread Indicator:**
  - Left border strip: 3dp wide, `brand.primary`, full tile height, 0dp from left edge
  - OR: 8dp dot, `brand.primary`, positioned right of title text
  - Title text: weight changes to 600 for unread

  **States:**
  | State | Visual |
  |-------|--------|
  | Unread | Left blue border strip + bold title |
  | Read | No left strip, normal weight title |
  | Pressed | bg darkens 3% |
  | Swiped (dismiss) | Slide right, muted bg reveal with check |

**5. Bottom Nav Bar**
- Same spec as Screen 9, "Home" tab NOT active (user is in notifications sub-screen)

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Tile bg | `#0D1117` | `#FFFFFF` |
| Tile divider | `#30363D` at 50% | `#D0D7DE` at 50% |
| Unread strip | `#4A90D9` | `#4A90D9` |
| Sticky header bg | `#0D1117` | `#FFFFFF` |
| Icon container bg | type-color at 10% | type-color at 10% |

#### RTL Notes

- Back arrow flips
- Icon container moves to right, content flows left from it
- Timestamp moves to top-left
- Chevron flips to left-pointing, moves to left edge
- Unread indicator strip moves to right edge
- "Mark all as read" aligns left
- Swipe to dismiss: swipe left in RTL
- Sticky headers text aligns right

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide from right + fade |
| Tiles entrance | Page settle (staggered) | 200ms each | `ease-out` | Fade in, 50ms stagger |
| Swipe dismiss | Swipe past 80dp | 200ms | `ease-out` | Slide out + height collapse |
| Mark all read | Tap | 300ms | `ease-out` | All unread strips fade out simultaneously |
| Pull-to-refresh | Pull gesture | 500ms | `ease-out` | Compass spinner animation |

#### Accessibility

- Screen: "Notifications. [count] unread."
- Mark all: "Mark all as read, button"
- Group header: "Today, section header"
- Each tile: "[Type] notification. [Title]. [Body]. [Timestamp]. [Unread/Read]."
- Actionable tiles: "Double tap to view details."
- Swipe action: alternative long-press menu for screen reader users: "Mark as read" / "Dismiss"

#### Edge Cases

- **No notifications:** Center illustration (envelope with sparkles) + "No notifications yet. We'll keep you posted!" `body.lg`, `text.secondary`, centered.
- **500+ notifications:** Paginate. Load 20 at a time. Spinner at bottom while loading more.
- **Notification while on this screen:** New notification appears at top of "Today" group with slide-down animation. Badge in app bar updates.
- **Error loading:** "Couldn't load notifications." + "Retry" button, centered in content area.
- **Discreet preview text:** Notification body text is intentionally vague (e.g. "A reminder is coming up" instead of "Anniversary with Sarah in 3 days") for privacy when screen is visible to others. Full detail shown only when tile is tapped.

---

### Screen 11: Quick Actions Bottom Sheet

| Property | Value |
|----------|-------|
| **Screen Name** | Quick Actions Bottom Sheet |
| **Route** | `/home` (overlay) |
| **Module** | Dashboard |
| **Sprint** | Sprint 2 |

#### Layout Description

Modal bottom sheet overlaying the Home Dashboard. Provides 4 quick-access shortcuts: Send a Message, Set a Reminder, Find a Gift, SOS Mode. Also includes the full mood check-in (5 moods + context tags). Drag handle at top. Dim overlay behind. Sheet occupies bottom ~55% of screen.

**Structure (top to bottom within sheet):**
- Drag handle: 4dp height, 36dp width, centered, 8dp from top
- Spacer: 16dp
- Sheet title: "Quick Actions"
- Spacer: 16dp
- Quick action grid (2x2)
- Spacer: 24dp
- Divider
- Spacer: 16dp
- Mood check-in section title
- Spacer: 12dp
- Mood grid (5 options, 3+2 layout)
- Spacer: 16dp
- Context tags (optional)
- Spacer: 16dp
- "Done" button
- Spacer: 8dp
- Yesterday hint text
- Spacer: 16dp (bottom safe area)

#### Component Breakdown

**1. Bottom Sheet Container**
- Max height: 75% of screen height
- Min height: 400dp
- Background (dark): `bg.secondary` (`#161B22`)
- Background (light): `#FFFFFF`
- Border radius: `radius.sheet` (16px) top-left and top-right, 0 bottom
- Elevation: `elevation.3`
- Scroll: internal scroll if content overflows

**2. Dim Overlay**
- Color: `#000000` at 50% opacity
- On tap: dismiss sheet
- Animation: fade in `anim.fast` (200ms)

**3. Drag Handle**
- Width: 36dp
- Height: 4dp
- Background (dark): `text.tertiary` (`#484F58`)
- Background (light): `text.tertiary` (`#8C959F`)
- Border radius: 2dp
- Center aligned
- Draggable: pull down to dismiss sheet

**4. Sheet Title**
- Text: "Quick Actions"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`
- Padding: 16dp horizontal

**5. Quick Action Grid (2x2)**
- Layout: 2-column grid, 12dp gap
- Padding: 16dp horizontal
- Each cell: (screen width - 32 - 12) / 2 = dynamic width, 80dp height

  **Quick Action Card (x4):**
  - Background (dark): `bg.tertiary` (`#21262D`)
  - Background (light): `bg.tertiary` (`#EAEEF2`)
  - Border: 1px solid `border.default`
  - Border radius: `radius.card` (12px)
  - Layout: Column -- icon (center-top), label (center-bottom)
  - Padding: 12dp

  | Action | Icon | Icon Color | Label |
  |--------|------|-----------|-------|
  | Send Message | `ic_message_plus` 28x28dp | `brand.primary` | "Message" |
  | Set Reminder | `ic_bell_plus` 28x28dp | `status.success` | "Reminder" |
  | Find Gift | `ic_gift_sparkle` 28x28dp | `brand.accent` | "Gift" |
  | SOS Mode | `ic_sos_shield` 28x28dp | `status.error` | "SOS" |

  - Label: `label.md` -- 14sp, 500, `text.primary`
  - Touch target: entire card (80dp height exceeds 48dp minimum)

  **States:**
  | State | Background | Border |
  |-------|-----------|--------|
  | Default | `bg.tertiary` | 1px `border.default` |
  | Pressed | darken 5% | 1px `border.emphasis` |
  | Focused | `bg.tertiary` | 2px `brand.primary` |

  - On tap: dismiss sheet + navigate to respective module

**6. Divider**
- Width: screen width minus 32dp, centered
- Height: 1px
- Color: `border.default`

**7. Mood Check-In Section Title**
- Text: "How is she today?"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`
- Padding: 16dp horizontal

**8. Mood Grid (5 options)**
- Layout: Row 1 = 3 items, Row 2 = 2 items (centered)
- Gap: 12dp horizontal, 12dp vertical
- Padding: 16dp horizontal

  **Mood Option:**
  - Size: 80x72dp
  - Background (dark): `bg.tertiary`
  - Background (light): `bg.tertiary`
  - Border: 1px solid `border.default`
  - Border radius: `radius.card` (12px)
  - Layout: Column -- emoji (top, 28dp), label (bottom, 12sp)
  - Padding: 8dp

  | Mood | Emoji Asset | Label |
  |------|------------|-------|
  | Great | `emoji_great.svg` (smiling) | "Great" |
  | Ok | `emoji_ok.svg` (neutral) | "Ok" |
  | Stressed | `emoji_stressed.svg` (grimacing) | "Stressed" |
  | Upset | `emoji_upset.svg` (frowning) | "Upset" |
  | Sick | `emoji_sick.svg` (ill) | "Sick" |

  - Emoji: 28x28dp, custom LOLO emoji style (not system emoji), monochrome matching type color
  - Label: `label.sm` -- 12sp, 500, `text.secondary`

  **States:**
  | State | Background | Border | Label |
  |-------|-----------|--------|-------|
  | Default | `bg.tertiary` | 1px `border.default` | `text.secondary` |
  | Selected | `brand.primary` at 10% | 2px `brand.primary` | `brand.primary` |
  | Pressed | darken 5% | 1px `border.emphasis` | `text.secondary` |

  - Single select. Tapping a selected mood deselects it.
  - Haptic feedback on selection: light impact

**9. Context Tags (optional)**
- Header: "Quick tags (optional)" -- `label.md` -- 14sp, 500, `text.secondary`
- Layout: wrap/flow layout (chips wrap to next line)
- Padding: 16dp horizontal
- Gap: 8dp horizontal, 8dp vertical

  **Tag Chip:**
  - Height: 32dp
  - Padding: 12dp horizontal
  - Background (unselected, dark): transparent
  - Border (unselected): 1px solid `border.default`
  - Background (selected): `brand.primary` at 10%
  - Border (selected): 1px solid `brand.primary`
  - Border radius: `radius.chip` (16dp)
  - Text: `label.sm` -- 12sp, 500
  - Text color (unselected): `text.secondary`
  - Text color (selected): `brand.primary`

  **Tags:** "Busy week", "Traveling", "Conflict", "Period", "Pregnant", "Sick", "Working late", "Family visiting"

  - Multi-select. Toggle on/off.

**10. "Done" Button**
- Width: full sheet width minus 32dp
- Height: 48dp
- Background: `brand.primary`
- Text: "Done" -- `button`, `#FFFFFF`
- Border radius: `radius.button` (24px)
- Disabled when no mood is selected
- On tap: submit mood + tags, close sheet, refresh dashboard action cards

**11. Yesterday Hint**
- Text: "Yesterday: Great" or "Last check-in: 2 days ago - Ok"
- Typography: `body.sm` -- 12sp, `text.tertiary`
- Alignment: center
- Provides continuity context

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Sheet bg | `#161B22` | `#FFFFFF` |
| Overlay | `#000000` at 50% | `#000000` at 50% |
| Drag handle | `#484F58` | `#8C959F` |
| Quick action card bg | `#21262D` | `#EAEEF2` |
| Mood option bg | `#21262D` | `#EAEEF2` |
| Tag chip border | `#30363D` | `#D0D7DE` |
| Divider | `#30363D` | `#D0D7DE` |

#### RTL Notes

- Drag handle stays centered
- Sheet title aligns right
- Quick action grid: items flow right-to-left (Message top-right, SOS bottom-left)
- Mood grid: items flow right-to-left (Great top-right)
- Context tags: wrap from right
- Yesterday hint stays centered
- Sheet swipe-to-dismiss direction is unchanged (downward)

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Sheet enter | Open trigger | 300ms | `anim.sheet.enter` | Slide up from bottom + dim overlay fades in |
| Sheet exit | Dismiss | 250ms | `anim.sheet.exit` | Slide down + overlay fades out |
| Quick action press | Tap | 100ms | `ease-out` | Scale to 0.95 |
| Mood select | Tap | 200ms | `anim.spring` | Border + bg transition, emoji bounces (scale 1.0 to 1.15 to 1.0) |
| Tag toggle | Tap | 150ms | `ease-out` | Border + bg color transition |
| Done submit | Tap | 200ms | `ease-out` | Button pulse then sheet dismisses |

#### Accessibility

- Sheet: "Quick Actions, modal dialog. Swipe down to dismiss."
- Quick actions: "Message, button. Opens AI message generator." etc.
- Mood options: "Mood selector. 5 options. Great, radio button." etc.
- Tags: "Context tags, optional. Busy week, toggle button, not selected." etc.
- Done: "Done, button, disabled" / "Done, button"
- Yesterday hint: read as informational text

#### Edge Cases

- **Sheet on small screen (<600dp height):** Content scrolls within sheet. Sheet max height = 85% screen.
- **Already checked in today:** Mood section shows pre-selected mood. Title changes to "Update check-in?" Tags show previous selections.
- **Sheet dismissed without completing:** No data saved. Dashboard mood row unchanged.
- **Rapid open/close:** Debounce sheet open with 300ms cooldown after close.
- **Gesture conflict:** Vertical scroll inside sheet vs. sheet drag-dismiss resolved by: if scroll position is at top, downward drag dismisses. If scrolled down, downward drag scrolls first.

---

## MODULE 3: HER PROFILE

---

### Screen 12: Profile Overview

| Property | Value |
|----------|-------|
| **Screen Name** | Profile Overview |
| **Route** | `/her-profile` |
| **Module** | Her Profile |
| **Sprint** | Sprint 2 |

#### Layout Description

Summary view of her complete personality profile. Hero card at top with avatar area, zodiac badge, love language, and communication style. Below: navigation tiles linking to detailed edit sub-screens. Quick Facts card at bottom. Bottom nav bar with "Her" tab active. Scrollable.

**Structure (top to bottom):**
- App bar: 56dp
- Spacer: 16dp
- Profile Hero Card: auto (~200dp)
- Spacer: 8dp
- Profile Completion Bar: 48dp
- Spacer: 24dp
- "Personality Traits" section header
- Spacer: 8dp
- Navigation tile 1: Zodiac & Personality
- Spacer: 1dp (tile divider)
- Navigation tile 2: Love Language
- Spacer: 1dp
- Navigation tile 3: Preferences & Interests
- Spacer: 1dp
- Navigation tile 4: Cultural Context
- Spacer: 24dp
- "Quick Facts" section header
- Spacer: 8dp
- Quick Facts Card
- Spacer: 80dp (bottom nav clearance)
- Bottom Nav: 64dp

#### Component Breakdown

**1. App Bar**
- Back arrow: left, navigates to `/home`
- Title: "Her Profile" -- `heading.sm`, `text.primary`, centered
- Right action: Edit icon (`ic_edit_pencil.svg` 24x24dp), `brand.primary`
- On edit tap: navigate to `/her-profile/edit` (full edit mode)

**2. Profile Hero Card**
- Width: screen width minus 32dp
- Min height: 200dp
- Background: `gradient.card.subtle` (vertical gradient from `bg.tertiary` to `bg.secondary`)
- Border: 1px solid `border.default`
- Border radius: 16px (larger for hero treatment)
- Padding: 24dp
- Elevation: `elevation.1`
- Layout: Column, center-aligned

  **Avatar Area:**
  - Size: 80x80dp
  - Shape: circle
  - Border: 3px solid `brand.accent` (`#C9A96E`)
  - Default (no photo): `bg.secondary` with `ic_woman_silhouette.svg` 40x40dp, `text.tertiary`
  - With photo: image fill, `object-fit: cover`
  - Center aligned

  **Zodiac Badge:**
  - Position: overlapping bottom-right of avatar (offset: right -4dp, bottom -4dp)
  - Size: 28x28dp
  - Background: `brand.accent` (`#C9A96E`)
  - Border radius: 14dp (circle)
  - Border: 2px solid `bg.primary` (creates cut-out effect)
  - Icon: zodiac sign icon 16x16dp, `#FFFFFF`
  - Visible only if zodiac is set

  **Name:**
  - Text: "Sarah" or "Not set yet" (if null)
  - Typography: `heading.md` -- 20sp, 600, `text.primary`
  - Center aligned
  - 8dp below avatar

  **Zodiac Label:**
  - Text: "Aries" or absent if not set
  - Typography: `body.md` -- 14sp, 400, `brand.accent`
  - Center aligned
  - Subtext: "Bold & passionate" (zodiac tagline) -- `body.sm`, 12sp, `text.secondary`, italic

  **Love Language Badge:**
  - Layout: Row -- heart icon 16dp + "Quality Time"
  - Icon color: `brand.primary`
  - Text: `label.md` -- 14sp, 500, `text.primary`
  - Background: `brand.primary` at 8%
  - Padding: 8dp horizontal, 4dp vertical
  - Border radius: `radius.chip` (16dp)
  - Position: 12dp below zodiac label
  - Visible only if love language is set

  **Communication Style:**
  - Text: "Calm & reassuring" (or equivalent)
  - Typography: `body.sm` -- 12sp, `text.secondary`
  - Center aligned, 4dp below love language badge
  - Visible only if set

**3. Profile Completion Bar**
- Width: screen width minus 32dp
- Height: auto (~48dp)
- Background: `bg.tertiary`
- Border radius: `radius.card` (12px)
- Padding: 12dp horizontal
- Layout: Row -- text column (left), circular progress (right)

  **Text:**
  - "Profile: 65% complete" -- `label.md`, 14sp, 500, `text.primary`
  - "Add zodiac and interests to improve suggestions" -- `body.sm`, 12sp, `text.secondary`

  **Circular Progress:**
  - Size: 36x36dp
  - Track: 3dp width, `border.default`
  - Fill: 3dp width, `brand.primary` (or `brand.accent` if >80%)
  - Center text: "65%" -- `label.sm`, 12sp, 600, `brand.primary`
  - Animated: fill draws clockwise on page load (500ms, `ease-out`)

  - On tap entire bar: navigate to the first incomplete section

**4. "Personality Traits" Section Header**
- Text: "Personality Traits"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`
- Padding: 16dp horizontal

**5. Navigation Tile (x4)**
- Width: full screen width
- Height: 56dp
- Background (dark): `bg.primary`
- Background (light): `#FFFFFF`
- Padding: 16dp horizontal
- Layout: Row -- icon container (left), title (center), value preview (right of title), chevron (right edge)
- Border bottom: 1px solid `border.default` at 50%

  **Icon Container:**
  - Size: 36x36dp
  - Background: icon-specific color at 10%
  - Border radius: 8dp
  - Icon: 20x20dp, centered

  **Tiles Data:**
  | Tile | Icon | Icon Color | Title | Preview Value |
  |------|------|-----------|-------|---------------|
  | Zodiac & Personality | `ic_zodiac_wheel` | `brand.accent` | "Zodiac & Personality" | "Aries" / "Not set" |
  | Love Language | `ic_heart_fill` | `status.error` | "Love Language" | "Quality Time" / "Not set" |
  | Preferences & Interests | `ic_sparkles` | `brand.primary` | "Preferences & Interests" | "8 interests" / "Not set" |
  | Cultural Context | `ic_globe_heart` | `status.success` | "Cultural & Religious" | "Muslim, Arab" / "Not set" |

  **Title:** `label.lg` -- 16sp, 500, `text.primary`
  **Preview:** `body.md` -- 14sp, 400, `text.secondary` (or `brand.primary` if "Not set" with "Add" prefix)
  **Chevron:** `ic_chevron_right.svg` 16x16dp, `text.tertiary`

  **States:**
  | State | Background |
  |-------|-----------|
  | Default | transparent |
  | Pressed | darken 3% |
  | Focused | 2px `brand.primary` outline |

  - On tap: navigate to respective sub-screen

**6. "Quick Facts" Section Header**
- Text: "Quick Facts"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`

**7. Quick Facts Card**
- Width: screen width minus 32dp
- Background (dark): `bg.tertiary`
- Background (light): `bg.tertiary`
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp
- Layout: Vertical list of key-value rows

  **Fact Row:**
  - Layout: Row -- label (left), value (right)
  - Height: 32dp
  - Label: `label.md` -- 14sp, 500, `text.secondary`
  - Value: `body.md` -- 14sp, 400, `text.primary`
  - Separator: 1px `border.default` at 30% between rows

  **Default Facts:**
  | Label | Example Value |
  |-------|--------------|
  | Interests | "Fashion, Travel, Cooking, Art" |
  | Humor level | "Loves jokes" |
  | Conflict style | "Needs space first" |
  | Preferred language | "Arabic" |

  - If value not set: show "Not set" in `text.tertiary`, italic
  - On tap card: navigate to `/her-profile/preferences`

**8. Bottom Nav**
- Same as Screen 9, with "Her" tab active

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Hero card bg | gradient `#21262D` to `#161B22` | gradient `#EAEEF2` to `#F6F8FA` |
| Hero border | `#30363D` | `#D0D7DE` |
| Avatar border | `#C9A96E` | `#C9A96E` |
| Nav tile bg | `#0D1117` | `#FFFFFF` |
| Nav tile divider | `#30363D` at 50% | `#D0D7DE` at 50% |
| Quick facts bg | `#21262D` | `#EAEEF2` |
| Completion bar bg | `#21262D` | `#EAEEF2` |

#### RTL Notes

- Back arrow flips, edit icon stays on opposite side
- Hero card: content center-aligned, no directional change
- Zodiac badge position: overlaps bottom-left of avatar in RTL
- Love language badge: heart icon moves to right of text
- Navigation tiles: icon container moves to right, chevron flips to left, text aligns right
- Quick facts: label right-aligned, value left-aligned
- Interests listed in RTL reading order

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide + fade |
| Hero card | Page settle | 400ms | `anim.spring` | Scale from 0.95 + fade |
| Completion circle | Page settle | 500ms | `ease-out` | Arc draws from 0 to percentage |
| Nav tiles | Staggered, after hero | 200ms each | `ease-out` | Fade in, 50ms stagger |
| Quick facts | After nav tiles | 300ms | `ease-out` | Fade in |

#### Accessibility

- App bar: "Her Profile. Back button. Edit button."
- Hero card: "Her profile summary. Name: Sarah. Zodiac: Aries, Bold and passionate. Love language: Quality Time. Communication style: Calm and reassuring."
- Completion: "Profile 65 percent complete. Add zodiac and interests to improve suggestions. Button."
- Nav tiles: "Zodiac and Personality, Aries. Button." etc.
- Quick facts: "Quick facts. Interests: Fashion, Travel, Cooking, Art. Humor level: Loves jokes." etc.

#### Edge Cases

- **Empty profile:** Hero card shows default silhouette, "Not set yet" for name, no badges visible. Completion: 0%. All nav tile previews show "Add" in `brand.primary`. Quick facts all show "Not set".
- **Long name:** Truncate at 20 characters with ellipsis in hero card.
- **Many interests (>6):** Show first 4 with "+N more" in Quick Facts.
- **Photo upload:** Avatar tap in edit mode opens image picker (camera or gallery). Crop to circle.

---

### Screen 13: Profile Edit

| Property | Value |
|----------|-------|
| **Screen Name** | Profile Edit |
| **Route** | `/her-profile/edit` |
| **Module** | Her Profile |
| **Sprint** | Sprint 2 |

#### Layout Description

Full edit form for zodiac and personality traits. Scrollable single-column form. Zodiac display card with change option. AI-generated trait sliders with manual override. Conflict style radio group. Humor level slider. Save button at bottom. Unsaved changes detection.

**Structure (top to bottom):**
- App bar: 56dp (title: "Zodiac & Personality" or "Edit Profile")
- Spacer: 16dp
- Zodiac display card: 72dp
- Spacer: 24dp
- "AI-Generated Traits" section + support text
- Spacer: 16dp
- Trait slider 1: Romantic
- Spacer: 16dp
- Trait slider 2: Adventurous
- Spacer: 16dp
- Trait slider 3: Emotional
- Spacer: 16dp
- Trait slider 4: Social
- Spacer: 16dp
- Trait slider 5: Spontaneous
- Spacer: 24dp
- Divider
- Spacer: 24dp
- "Conflict Style" radio group
- Spacer: 24dp
- "Humor Level" slider
- Spacer: 32dp
- "Save" button
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + "Zodiac & Personality" centered
- Right action: none (Save is inline button at bottom)
- Unsaved changes: if modified fields exist, back arrow shows discard dialog

**2. Zodiac Display Card**
- Width: screen width minus 32dp
- Height: 72dp
- Background (dark): `bg.tertiary`
- Background (light): `bg.tertiary`
- Border: 1px solid `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp
- Layout: Row -- zodiac icon (left), text column (center), "Change" button (right)

  **Icon:** 40x40dp, `brand.accent` color, zodiac sign asset
  **Sign Name:** `heading.sm` -- 18sp, 600, `text.primary`
  **Date Range:** `body.sm` -- 12sp, `text.secondary`
  **"Change" Button:** text button, `brand.primary`, `label.md` 14sp 500
  - On tap: opens zodiac wheel modal (bottom sheet with carousel, same component as Screen 5)

**3. Section Header: "AI-Generated Traits"**
- Text: "AI-Generated Traits"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`
- Support text: "(adjust to match her)" -- `body.sm`, 12sp, `text.secondary`

**4. Trait Slider (x5)**
- Width: screen width minus 32dp
- Height: auto (~56dp)
- Layout: Column -- label row (label left, value right), slider below

  **Label:** `label.lg` -- 16sp, 500, `text.primary`
  **Value:** current percentage or descriptive text -- `body.md`, 14sp, `brand.primary`
  **Slider:**
  - Track width: full container width
  - Track height: 4dp
  - Track background (inactive): `border.default`
  - Track fill (active): `brand.primary`
  - Track border radius: 2dp
  - Thumb: 24x24dp circle
  - Thumb fill: `brand.primary`
  - Thumb border: 2px solid `#FFFFFF` (dark) or 2px solid `bg.primary` (light)
  - Thumb elevation: `elevation.1`
  - Range: 0 to 100, continuous
  - Low label: "Low" -- `body.sm`, 12sp, `text.tertiary`, left-aligned
  - High label: "High" -- `body.sm`, 12sp, `text.tertiary`, right-aligned

  **Sliders Data (with zodiac-based defaults):**
  | Trait | Aries Default | Description |
  |-------|--------------|-------------|
  | Romantic | 70 | How romantic she is |
  | Adventurous | 85 | Openness to new experiences |
  | Emotional | 60 | Emotional expressiveness |
  | Social | 50 | Social energy level |
  | Spontaneous | 90 | Preference for spontaneity |

  **States:**
  | State | Visual |
  |-------|--------|
  | Default | Loaded from profile / zodiac defaults |
  | Dragging | Thumb scales to 28dp, haptic on 25/50/75 markers |
  | Modified | Value text changes to `brand.accent` to indicate user override |
  | Reset (long press label) | Reverts to zodiac default with animation |

**5. Divider**
- 1px, `border.default`, 16dp horizontal margin

**6. Conflict Style Radio Group**
- Header: "Conflict Style" -- `heading.sm`, 18sp, 600, `text.primary`
- 4 radio options, each in a row:

  **Radio Option:**
  - Height: 48dp
  - Layout: Row -- radio circle (left), label (right)
  - Radio circle: 20x20dp
  - Unselected: 2px border `border.default`, transparent fill
  - Selected: 2px border `brand.primary`, inner filled circle 10dp `brand.primary`
  - Label: `body.lg` -- 16sp, 400, `text.primary`

  | Option | Label |
  |--------|-------|
  | 1 | "Needs space first" |
  | 2 | "Wants to talk immediately" |
  | 3 | "Needs physical comfort" |
  | 4 | "Needs written words" |

**7. Humor Level Slider**
- Same slider component as trait sliders
- Label: "Humor Level"
- Low label: "Serious"
- High label: "Loves jokes"
- Range: 0 to 100
- Default: varies by zodiac

**8. "Save" Button**
- Width: screen width minus 32dp
- Height: 52dp
- Same primary button spec
- Text: "Save"
- Always enabled (even with no changes -- tapping just saves current state)

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Zodiac card bg | `#21262D` | `#EAEEF2` |
| Slider track inactive | `#30363D` | `#D0D7DE` |
| Slider track active | `#4A90D9` | `#4A90D9` |
| Slider thumb | `#4A90D9` | `#4A90D9` |
| Slider thumb border | `#FFFFFF` | `#FFFFFF` |
| Radio unselected | `#30363D` | `#D0D7DE` |
| Radio selected | `#4A90D9` | `#4A90D9` |

#### RTL Notes

- Slider direction reverses: "Low" on right, "High" on left
- Slider fill starts from right
- Thumb position maps inversely (value 80 appears at 20% from right)
- Radio circles move to right side, labels left
- "Change" button moves to left side of zodiac card
- Zodiac icon moves to right

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide + fade |
| Slider thumb drag | Drag | continuous | linear | Thumb follows finger |
| Haptic markers | Thumb crosses 25/50/75 | instant | -- | Light haptic tick |
| Value change | Slider move | 100ms | `ease-out` | Value text updates with brief fade |
| Modified indicator | First change | 200ms | `ease-out` | Value color transitions to `brand.accent` |
| Save success | Tap save | 400ms | `anim.spring` | Button flashes green, checkmark appears, then navigate back |
| Discard dialog | Back with changes | 200ms | `ease-out` | Dialog fades in with dim overlay |

#### Accessibility

- Zodiac card: "Her zodiac sign: Aries, March 21 to April 19. Change button."
- Each slider: "Romantic level. Current value: 70 out of 100. Adjustable. Double tap and hold, then slide to adjust."
- Radio group: "Conflict style. 4 options. Wants to talk immediately, selected."
- Save: "Save changes, button."
- Modified sliders: announce "Modified from default" after value

#### Edge Cases

- **No zodiac set:** Zodiac card shows "No zodiac selected" with "Add" button instead of "Change". Trait sliders show neutral defaults (all at 50).
- **Unsaved changes + back:** Dialog: "You have unsaved changes. Discard changes? [Discard] [Keep Editing]". Dialog bg: `bg.secondary`, elevation 3.
- **Slider precision:** Steps of 1 (0-100). For accessibility, keyboard arrows move in steps of 5.
- **Save failure:** Snackbar: "Couldn't save. Check connection and try again." with "Retry" action.
- **Zodiac change:** Changing zodiac sign resets all trait sliders to new zodiac defaults. Confirmation: "Changing zodiac will reset personality traits to new defaults. Continue? [Yes] [No]"

---

### Screen 14: Preferences & Interests

| Property | Value |
|----------|-------|
| **Screen Name** | Preferences & Interests |
| **Route** | `/her-profile/preferences` |
| **Module** | Her Profile |
| **Sprint** | Sprint 2 |

#### Layout Description

Scrollable form for editing communication style, love language, interests, stress triggers, sensitive topics, and preferred message language. Mix of radio groups, chip selectors, and text areas.

**Structure (top to bottom):**
- App bar: 56dp ("Her Preferences")
- Spacer: 16dp
- Communication Style section
- Spacer: 24dp
- Love Language section
- Spacer: 24dp
- Divider
- Spacer: 24dp
- Interests section
- Spacer: 24dp
- Divider
- Spacer: 24dp
- Stress Triggers text area
- Spacer: 24dp
- Sensitive Topics text area
- Spacer: 24dp
- Divider
- Spacer: 24dp
- Preferred Message Language
- Spacer: 32dp
- Save button
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + "Her Preferences" centered

**2. Communication Style**
- Header: "Communication Style" -- `heading.sm`, 18sp, 600, `text.primary`
- 5 radio options, same radio spec as Screen 13

  | Option |
  |--------|
  | "Romantic & poetic" |
  | "Playful & funny" |
  | "Calm & reassuring" |
  | "Direct & honest" |
  | "Formal & respectful" |

**3. Love Language**
- Header: "Love Language" -- `heading.sm`, 18sp, 600, `text.primary`
- 5 chip options, single select

  **Love Language Chip:**
  - Height: 40dp
  - Padding: 16dp horizontal
  - Border radius: 20dp (pill)
  - Gap between chips: 8dp
  - Wrap layout (flow to next line)

  | State | Background | Border | Text |
  |-------|-----------|--------|------|
  | Unselected | transparent | 1px `border.default` | `text.secondary` |
  | Selected | `brand.primary` at 12% | 1.5px `brand.primary` | `brand.primary` |

  | Chip | Icon (16dp, inline) |
  |------|-----|
  | "Words of Affirmation" | `ic_heart_small` |
  | "Acts of Service" | `ic_hands` |
  | "Receiving Gifts" | `ic_gift_small` |
  | "Quality Time" | `ic_clock` |
  | "Physical Touch" | `ic_hand_holding` |

**4. Interests**
- Header: "Her Interests" -- `heading.sm`, 18sp, 600
- Subtext: "(select all that apply)" -- `body.sm`, 12sp, `text.secondary`
- Chip grid: wrap/flow layout, multi-select

  **Interest Chip:**
  - Height: 36dp
  - Padding: 12dp horizontal
  - Border radius: 18dp (pill)
  - Gap: 8dp horizontal, 8dp vertical

  | State | Background | Border | Text |
  |-------|-----------|--------|------|
  | Unselected | transparent | 1px `border.default` | `text.secondary` |
  | Selected | `brand.primary` | none | `#FFFFFF` |

  **Interest Options:** "Fashion", "Travel", "Food", "Books", "Music", "Fitness", "Art", "Nature", "Movies", "Tech", "Cooking", "Pets", "Photography", "Gaming", "Spirituality", "Sports", "DIY", "Gardening"

  **"+More" Chip:** Last chip, dashed border, `text.tertiary`, on tap opens text field to add custom interest

**5. Stress Triggers**
- Header: "Stress Triggers" -- `heading.sm`, 18sp, 600
- Subtext: "What stresses her out?" -- `body.sm`, 12sp, `text.secondary`
- Text area:
  - Width: screen width minus 32dp
  - Min height: 80dp (expandable)
  - Max height: 160dp
  - Background: `bg.secondary`
  - Border: 1px `border.default`
  - Border radius: `radius.input` (8px)
  - Padding: 12dp
  - Text: `body.lg`, 16sp, `text.primary`
  - Placeholder: "e.g. Work deadlines, family conflict, health worries..."
  - Max chars: 200
  - Counter: "0/200" bottom-right when focused

**6. Sensitive Topics**
- Same component as Stress Triggers
- Header: "Sensitive Topics (avoid)"
- Subtext: "Topics the AI should never bring up"
- Placeholder: "e.g. Past relationships, weight discussions..."
- Max chars: 200

**7. Preferred Message Language**
- Header: "Preferred Message Language" -- `heading.sm`
- Subtext: "Language for AI-generated messages to her"
- 3 chips, single select: "English", "Arabic", "Bahasa Melayu"
- Same chip styling as Love Language section

**8. Save Button**
- Same primary button spec, text "Save"

#### Dark Mode / Light Mode

Same pattern as Screen 13. Text areas use `bg.secondary` for background.

#### RTL Notes

- All radio buttons: circle moves to right, label left
- All chip groups: flow right-to-left
- Text areas: cursor starts right, text aligns right
- Section headers align right
- Character counters move to bottom-left

#### Animation Specs

Standard form animations: field focus transitions (200ms border color), chip toggle (150ms bg transition), save success (400ms green flash + navigate back).

#### Accessibility

- Each section has semantic heading role
- Radio groups: standard radio group semantics
- Chips: "Words of Affirmation, toggle button, selected" / "Acts of Service, toggle button, not selected"
- Interest chips: same pattern, multi-select announced
- Text areas: "Stress triggers, text field, optional. 0 of 200 characters."
- "+More" chip: "Add custom interest, button"

#### Edge Cases

- **No selections + Save:** Allowed. All fields are optional.
- **Many custom interests:** Max 30 interests total (predefined + custom).
- **Long text in text areas:** Scrolls vertically within area.
- **Keyboard covers Save:** Save button floats above keyboard when text area is focused.
- **Unsaved changes + back:** Same discard dialog as Screen 13.

---

### Screen 15: Cultural Context

| Property | Value |
|----------|-------|
| **Screen Name** | Cultural Context |
| **Route** | `/her-profile/cultural` |
| **Module** | Her Profile |
| **Sprint** | Sprint 3 |

#### Layout Description

Scrollable form for cultural background, religious observance, holiday preferences, and dietary restrictions. Dropdown selectors, checkbox lists, and multi-select chips. Sensitive content handled with care -- all fields explicitly optional.

**Structure (top to bottom):**
- App bar: 56dp ("Cultural & Religious")
- Spacer: 16dp
- Privacy note card: auto (~56dp)
- Spacer: 24dp
- Cultural Background dropdown
- Spacer: 24dp
- Religious Observance dropdown
- Spacer: 24dp
- Divider
- Spacer: 24dp
- Holiday Preferences section
- Spacer: 24dp
- Divider
- Spacer: 24dp
- Dietary Restrictions chips
- Spacer: 32dp
- Save button
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + "Cultural & Religious" centered

**2. Privacy Note Card**
- Width: screen width minus 32dp
- Background: `brand.primary` at 5%
- Border: 1px solid `brand.primary` at 20%
- Border radius: `radius.card` (12px)
- Padding: 12dp
- Layout: Row -- info icon + text
- Icon: `ic_info_circle.svg` 20x20dp, `brand.primary`
- Text: "All cultural and religious information is optional and kept private. It helps LOLO suggest culturally appropriate messages and gifts."
- Typography: `body.sm` -- 12sp, `text.secondary`

**3. Cultural Background Dropdown**
- Label: "Cultural Background" -- `label.md`, 14sp, 500, `text.secondary`, 4dp above
- Field container:
  - Width: screen width minus 32dp
  - Height: 48dp
  - Background: `bg.secondary`
  - Border: 1px `border.default`
  - Border radius: `radius.input` (8px)
  - Padding: 12dp horizontal
  - Layout: Row -- selected value text (left), dropdown chevron (right)
  - Text: `body.lg`, 16sp, `text.primary` (or placeholder: "Select" in `text.tertiary`)
  - Chevron: `ic_chevron_down.svg` 16x16dp, `text.tertiary`

- On tap: opens bottom sheet picker

  **Dropdown Bottom Sheet:**
  - Same sheet container as Screen 11 (drag handle, dim overlay)
  - Title: "Cultural Background"
  - List of options, each 48dp height, full width, left-aligned text
  - Selected option: `brand.primary` text + checkmark right
  - Options: "Arab", "Malay", "Western", "South Asian", "East Asian", "African", "Latin American", "Mixed / Other"

**4. Religious Observance Dropdown**
- Same component as Cultural Background
- Label: "Religious Observance"
- Options: "Muslim", "Christian", "Hindu", "Buddhist", "Jewish", "None / Secular", "Prefer not to say", "Other"

**5. Holiday Preferences**
- Header: "Holiday Preferences" -- `heading.sm`, 18sp, 600
- Subtext: "(which holidays matter to her?)" -- `body.sm`, `text.secondary`

  **Holiday Checkbox List:**
  - Grouped by category
  - Each checkbox row: 44dp height

  **Checkbox:**
  - Size: 22x22dp
  - Unchecked: 2px border `border.default`, transparent fill, border radius 4dp
  - Checked: `brand.primary` fill, white checkmark 14x14dp, border radius 4dp
  - Indeterminate: not used

  **Checkbox Row:**
  - Layout: Row -- checkbox (left), label (right)
  - Label: `body.lg`, 16sp, `text.primary`
  - Gap: 12dp

  **Holiday Groups:**

  *Islamic Holidays:*
  | Holiday | Default (if Muslim selected) |
  |---------|-----|
  | Eid al-Fitr | checked |
  | Eid al-Adha | checked |
  | Ramadan | checked |
  | Israk Mikraj | unchecked |

  *Malay/Regional:*
  | Holiday | Default (if Malay selected) |
  |---------|-----|
  | Hari Raya Aidilfitri | checked |
  | Hari Raya Haji | checked |
  | Malaysia Day | unchecked |

  *Western/Global:*
  | Holiday | Default |
  |---------|---------|
  | Christmas | unchecked |
  | Valentine's Day | unchecked |
  | New Year's Day | unchecked |
  | Mother's Day | unchecked |

  *Other:*
  | Holiday | Default |
  |---------|---------|
  | Chinese New Year | unchecked |
  | Diwali | unchecked |
  | National Day | unchecked |

  **"+Add custom holiday" Button:**
  - Text button: "+ Add custom holiday"
  - Typography: `label.md`, 14sp, 500, `brand.primary`
  - On tap: inline text field appears below with "Holiday name" placeholder and "Add" button

  **Smart Defaults:** When religious observance is changed, holidays auto-check based on religion. User confirmation: "Auto-select [religion] holidays? [Yes] [No]"

**6. Dietary Restrictions**
- Header: "Dietary Restrictions" -- `heading.sm`
- Chip grid: multi-select, same chip spec as Screen 14 interests
- Chips: "Halal", "Vegetarian", "Vegan", "No Pork", "No Alcohol", "Gluten-free", "Kosher", "No Shellfish"
- "+Custom" chip: dashed border, opens text input to add custom restriction

**7. Save Button**
- Same primary button spec

#### Dark Mode / Light Mode

Same pattern as previous edit screens. Privacy note uses `brand.primary` at 5% bg in both modes.

#### RTL Notes

- Dropdown chevron moves to left
- Dropdown text aligns right
- Checkbox moves to right side, labels left
- Holiday group headers align right
- Chips flow right-to-left
- Bottom sheet picker: options right-aligned, checkmark on left

#### Animation Specs

Standard form + bottom sheet animations. Smart defaults: when religion changes, checkboxes animate (check icons pop in with `anim.spring`, 200ms, 50ms stagger).

#### Accessibility

- Privacy note: read in full as informational text
- Dropdowns: "Cultural Background. Current value: Arab. Double tap to change."
- Bottom sheet: "Select cultural background. List of 8 options."
- Checkboxes: "Eid al-Fitr. Checkbox, checked." etc.
- Custom holiday: "Add custom holiday. Button."
- Dietary chips: same as interest chips

#### Edge Cases

- **No religion selected:** Holiday preferences show all holidays unchecked, no auto-grouping.
- **Religion change with existing holidays:** Confirmation before overriding manually selected holidays.
- **Many custom holidays:** Max 10 custom holidays.
- **Very long custom holiday name:** Truncate at 40 characters.
- **Cultural sensitivity:** No imagery tied to specific religions. Icons are neutral (calendar, gift). No assumptions -- all fields completely optional.

---

## MODULE 4: SMART REMINDERS

---

### Screen 16: Reminders List

| Property | Value |
|----------|-------|
| **Screen Name** | Reminders List |
| **Route** | `/reminders` |
| **Module** | Smart Reminders |
| **Sprint** | Sprint 3 |

#### Layout Description

Dual-view screen: toggle between calendar view and list view. Calendar view shows a month grid with colored dots on dates that have reminders. Below the calendar (or as the primary content in list view), upcoming reminders are listed chronologically. App bar has a "+" button for creating new reminders. Color-coded by category. Bottom nav visible.

**Structure -- Calendar View (top to bottom):**
- App bar: 56dp
- Spacer: 8dp
- View toggle: 40dp
- Spacer: 12dp
- Calendar widget: ~280dp
- Spacer: 16dp
- "Upcoming" section header
- Spacer: 8dp
- Reminder tiles (scrollable list)
- Spacer: 80dp (bottom nav clearance)
- Bottom Nav: 64dp

**Structure -- List View (top to bottom):**
- App bar: 56dp
- Spacer: 8dp
- View toggle: 40dp
- Spacer: 16dp
- Overdue section (if any)
- Monthly group headers + reminder tiles
- Spacer: 80dp
- Bottom Nav: 64dp

#### Component Breakdown

**1. App Bar**
- Back arrow: left, navigates to `/home`
- Title: "Reminders" -- `heading.sm`, centered
- Right action: "+" icon (`ic_plus.svg` 24x24dp) in circle background
  - Circle: 32x32dp, `brand.primary` bg, icon `#FFFFFF` 18x18dp
  - Touch target: 48x48dp
  - On tap: navigate to `/reminders/create`

**2. View Toggle (Segmented Control)**
- Width: screen width minus 32dp, centered
- Height: 36dp
- Background: `bg.secondary`
- Border: 1px solid `border.default`
- Border radius: 18dp (pill)
- Two segments: "Calendar" (with `ic_calendar_small` 14dp icon) | "List" (with `ic_list_small` 14dp icon)
- Each segment: icon + label
- Label: `label.sm` -- 12sp, 500

  **States:**
  | Segment | Background | Icon+Text Color |
  |---------|-----------|----------------|
  | Inactive | transparent | `text.secondary` |
  | Active | `brand.primary` | `#FFFFFF` |

  - Animated pill indicator slides between segments (`anim.normal`, 300ms)

**3. Calendar Widget (Calendar View only)**
- Same base spec as Screen 7's inline calendar picker
- Width: screen width minus 32dp
- Background: `bg.secondary`
- Border: 1px `border.default`
- Border radius: `radius.card` (12px)

  **Additions beyond Screen 7:**

  **Reminder Dots (below day numbers):**
  - Position: 4dp below day number
  - Size: 6x6dp each
  - Max 3 dots per day (if >3 reminders, show 3 dots)
  - Spacing: 2dp between dots
  - Colors by category:
    | Category | Dot Color |
    |----------|----------|
    | Anniversary/Birthday | `status.error` |
    | Recurring | `brand.primary` |
    | Promise | `brand.accent` |
    | Custom | `text.tertiary` |

  **Selected Day:**
  - Background circle: `brand.primary`
  - Text: `#FFFFFF`
  - Dots below still visible on selected day

  **Today:**
  - Text: `brand.primary`, bold
  - No fill (only outline ring if not selected)

  **Locale-Specific Week Start:**
  | Locale | Week Starts |
  |--------|------------|
  | English | Sunday |
  | Arabic | Saturday |
  | Malay | Monday |

**4. "Upcoming" Section Header (Calendar View)**
- Text: "Upcoming"
- Typography: `heading.sm` -- 18sp, 600, `text.primary`
- Padding: 16dp horizontal
- Divider line below: 1px, `border.default`

**5. Overdue Section (List View, conditional)**
- Header: "Overdue" with warning icon
- Header background: `status.error` at 8%
- Header text: `heading.sm`, 18sp, 600, `status.error`
- Only visible if overdue reminders exist
- Tiles within have red-tinted left border

**6. Reminder Tile**
- Width: full screen width
- Min height: 72dp
- Background: `bg.primary`
- Padding: 16dp horizontal, 12dp vertical
- Border bottom: 1px solid `border.default` at 40%
- Layout: Row -- category icon container (left), content column (center), meta column (right)

  **Category Icon Container:**
  - Size: 40x40dp
  - Background: category-color at 10%
  - Border radius: 10dp
  - Icon: 20x20dp, category-color

  | Category | Color | Icon |
  |----------|-------|------|
  | Anniversary | `status.error` | `ic_heart` |
  | Birthday | `#E88DA1` (pink) | `ic_cake` |
  | Recurring | `brand.primary` | `ic_repeat` |
  | Promise | `brand.accent` | `ic_handshake` |
  | Custom | `text.secondary` | `ic_calendar` |

  **Content Column:**
  - Title: `label.lg` -- 16sp, 500, `text.primary`
  - Date: `body.md` -- 14sp, 400, `text.secondary`
  - Padding left: 12dp from icon container

  **Meta Column (right-aligned):**
  - Countdown: "in 3 days" -- `label.md`, 14sp, 500
    - Color: `status.error` if <3 days, `status.warning` if <7 days, `text.secondary` otherwise
  - Escalation indicator: `body.sm`, 12sp
    - "Active" (green dot 6dp + text `status.success`) if escalation notifications are firing
    - "Scheduled" (`text.tertiary`) if future
  - Chevron: `ic_chevron_right` 16dp, `text.tertiary`

  **Overdue Tile Variant:**
  - Left border: 3dp solid `status.error`
  - Countdown text: "2 days overdue" in `status.error`
  - Background tint: `status.error` at 3%

  **States:**
  | State | Visual |
  |-------|--------|
  | Default | Standard |
  | Pressed | bg darken 3% |
  | Overdue | Red left border + red countdown |
  | Completed | Strikethrough title, muted 50% opacity |

  **Swipe Actions:**
  - Swipe left: Delete (red bg, trash icon). Requires confirmation dialog.
  - Swipe right: Complete (green bg, check icon). Mark as done with animation.
  - Threshold: 80dp

**7. Monthly Group Headers (List View)**
- Text: "February 2026" / "March 2026"
- Typography: `label.md` -- 14sp, 500, `text.tertiary`
- Sticky behavior on scroll
- Height: 32dp
- Background: `bg.primary`

**8. Empty State Illustration**
- Centered illustration: calendar with sparkles (`il_empty_reminders.svg`)
- Size: 120x120dp
- Title: "No reminders yet"
- Typography: `heading.sm`, 18sp, 600, `text.primary`
- Subtitle: "Never miss what matters to her"
- Typography: `body.md`, 14sp, `text.secondary`
- CTA button: "Create Your First Reminder" -- secondary button style (outlined)

**9. Bottom Nav**
- Same spec, no tab is explicitly active for Reminders (it's accessed via Home or deep link)
- Home tab active if navigated from Home

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Calendar bg | `#161B22` | `#F6F8FA` |
| Calendar border | `#30363D` | `#D0D7DE` |
| Tile bg | `#0D1117` | `#FFFFFF` |
| Overdue tint | `#F85149` at 3% | `#CF222E` at 3% |
| View toggle bg | `#161B22` | `#F6F8FA` |

#### RTL Notes

- Calendar: week starts Saturday for Arabic (columns reorder)
- Day names: localized abbreviations
- Month navigation arrows: logic swaps (left = next in RTL)
- Reminder tiles: icon right, content flows right, meta on left, chevron flips
- Swipe directions reverse
- Countdown text aligns to start (right in RTL)
- View toggle: same visual layout

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| View toggle | Segment tap | 300ms | `ease-out` | Content crossfades between calendar and list |
| Calendar month change | Arrow tap | 300ms | `ease-out` | Slide old month out, new in |
| Day select | Tap | 200ms | `ease-out` | Circle bg appears |
| Tile entrance | Scroll into view | 200ms | `ease-out` | Fade in |
| Swipe complete | Past threshold | 200ms | `ease-out` | Slide out + confetti burst (3 particles) |
| Swipe delete | Past threshold + confirm | 200ms | `ease-out` | Slide out + height collapse |

#### Accessibility

- View toggle: "View mode. Calendar selected. List. Segmented control."
- Calendar: "February 2026 calendar. 14th selected. 3 reminders on this day."
- Reminder tile: "Anniversary. February 17th. In 3 days. Escalation active. Button."
- Overdue section: "Overdue reminders. 1 item."
- Swipe actions: long-press alternative menu for screen readers
- Empty state: "No reminders yet. Create your first reminder, button."

#### Edge Cases

- **100+ reminders:** Paginate in list view. Calendar dots cap at 3 per day.
- **All reminders overdue:** Overdue section prominently at top, gentle but firm visual treatment.
- **Calendar navigation far past/future:** Allow +-5 years from today.
- **Filter by category:** Calendar view dots filter. List view only shows matching category. Filter accessible via app bar filter icon (stretch goal).
- **Loading:** Skeleton: calendar shimmer block + 3 tile shimmers.

---

### Screen 17: Create Reminder

| Property | Value |
|----------|-------|
| **Screen Name** | Create Reminder |
| **Route** | `/reminders/create` |
| **Module** | Smart Reminders |
| **Sprint** | Sprint 3 |

#### Layout Description

Scrollable form for creating or editing a reminder. Fields: title, category, date, time (optional), recurrence, notification escalation, notes, gift suggestion link. In edit mode, pre-fills fields and shows delete option. Keyboard-aware scrolling.

**Structure (top to bottom):**
- App bar: 56dp ("New Reminder" / "Edit Reminder")
- Spacer: 16dp
- Title input field
- Spacer: 20dp
- Category chips
- Spacer: 20dp
- Date picker field
- Spacer: 16dp
- Time picker field (optional)
- Spacer: 20dp
- Recurrence chips
- Spacer: 24dp
- Divider
- Spacer: 20dp
- Notification Escalation section
- Spacer: 24dp
- Divider
- Spacer: 20dp
- Notes text area
- Spacer: 20dp
- Gift suggestion toggle
- Spacer: 32dp
- Save button
- Spacer: 16dp
- Delete button (edit mode only)
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + title centered
- Title: "New Reminder" (create) / "Edit Reminder" (edit)
- Right action: checkmark save icon (`ic_check.svg` 24dp, `brand.primary`)
  - Same action as Save button. Provides quick save without scrolling.

**2. Title Input**
- Label: "Title" -- `label.md`, 14sp, 500, `text.secondary`
- Same text input spec as Screen 4 name field (but standard 48dp height, 16sp text)
- Placeholder: "e.g. Her Birthday, Anniversary, Weekly flowers..."
- Max: 60 chars
- Auto-focus in create mode
- Required field

**3. Category Chips**
- Header: "Category" -- `label.md`, 14sp, 500, `text.secondary`
- Single-select chip row, horizontal scroll
- Gap: 8dp

  **Chips:**
  | Category | Icon (16dp inline) | Default Selected |
  |----------|-----|------|
  | "Birthday" | `ic_cake` | -- |
  | "Anniversary" | `ic_heart` | -- |
  | "Date Night" | `ic_stars` | -- |
  | "Promise" | `ic_handshake` | -- |
  | "Recurring" | `ic_repeat` | -- |
  | "Custom" | `ic_calendar` | yes (fallback) |

  - Chip styling: same as Screen 14 love language chips (40dp height, pill shape)
  - Category selection affects icon and color in reminders list

**4. Date Picker Field**
- Label: "Date" -- `label.md`
- Container: same text field spec, 48dp height
- Display: formatted date "Mar 21, 2026" (or locale equivalent)
- Suffix icon: `ic_calendar.svg` 20dp, `text.tertiary`
- On tap: opens platform date picker dialog
- Required field

**5. Time Picker Field**
- Label: "Time (optional)" -- `label.md`
- Same container as date field
- Display: "9:00 AM" or "09:00" (24h format per locale)
- Suffix icon: `ic_clock.svg` 20dp, `text.tertiary`
- Placeholder: "Add time"
- On tap: opens platform time picker dialog
- Optional: clear button appears when time is set

**6. Recurrence Chips**
- Header: "Recurring" -- `label.md`
- Single-select chip row
- Chips: "Off", "Daily", "Weekly", "Monthly", "Yearly"
- "Off" is default selected
- Chip spec: same 40dp pill chips
- When "Weekly" selected: additional day picker appears (Su Mo Tu We Th Fr Sa chips)
- When "Monthly" selected: shows "Same date each month" label

**7. Notification Escalation**
- Header: "Notification Escalation" -- `heading.sm`, 18sp, 600
- Subtext: "When should we remind you?" -- `body.sm`, 12sp, `text.secondary`

  **Checkbox List:**
  - Same checkbox spec as Screen 15
  - Each row: 44dp height

  | Option | Default |
  |--------|---------|
  | "7 days before" | checked |
  | "3 days before" | checked |
  | "1 day before" | checked |
  | "Same day morning (9 AM)" | checked |
  | "Custom time" | unchecked |

  - "Custom time": when checked, reveals time picker inline (same time picker component)

**8. Notes Text Area**
- Header: "Notes (optional)" -- `label.md`
- Same text area spec as Screen 14 (80dp min height, 300 max chars)
- Placeholder: "Any details to remember..."

**9. Gift Suggestion Toggle**
- Layout: Row -- text (left), switch toggle (right)
- Text: "Auto-suggest gifts before this date"
- Typography: `body.lg`, 16sp, 400, `text.primary`
- Subtext: "LOLO will recommend gifts as the date approaches"
- Typography: `body.sm`, 12sp, `text.secondary`

  **Switch Toggle:**
  - Size: 48x24dp
  - Track off: `border.default` bg, 24dp height, 48dp width, radius 12dp
  - Track on: `brand.primary` bg
  - Thumb: 20x20dp circle, `#FFFFFF`, `elevation.1`
  - Thumb position: left (off) / right (on)
  - Animation: thumb slides + track color transition, 200ms, `ease-out`

**10. Save Button**
- Width: screen width minus 32dp
- Same primary button spec
- Text: "Save Reminder"
- Disabled when title or date is empty

**11. Delete Button (edit mode only)**
- Width: screen width minus 32dp
- Height: 48dp
- Background: transparent
- Border: 1px solid `status.error`
- Border radius: `radius.button` (24px)
- Text: "Delete Reminder" -- `button`, `status.error`
- On tap: confirmation dialog

  **Delete Confirmation Dialog:**
  - Overlay: `#000000` at 50%
  - Dialog card: 280dp width, auto height
  - Background (dark): `bg.secondary`
  - Background (light): `#FFFFFF`
  - Border radius: 16px
  - Padding: 24dp
  - Title: "Delete Reminder?" -- `heading.sm`, 18sp, 600, `text.primary`
  - Body: "This action cannot be undone." -- `body.md`, 14sp, `text.secondary`
  - Buttons (right-aligned row):
    - "Cancel" -- text button, `text.secondary`
    - "Delete" -- text button, `status.error`, 600 weight
  - 8dp gap between buttons

#### Dark Mode / Light Mode

Standard form screen pattern. Delete button border and text use dark/light error colors respectively.

#### RTL Notes

- All labels right-aligned
- Calendar/clock suffix icons move to left side
- Chip rows flow right-to-left
- Checkboxes move to right
- Switch toggle: label right, switch left
- Day picker for weekly: Sa is rightmost in RTL
- Date format: locale-appropriate

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide + fade |
| Weekly day picker | "Weekly" selected | 200ms | `anim.normal` | Slide down reveal |
| Custom time reveal | Checkbox checked | 200ms | `anim.normal` | Slide down reveal |
| Switch toggle | Tap | 200ms | `ease-out` | Thumb slide + track color |
| Delete dialog | Tap delete | 200ms | `ease-out` | Fade in overlay + scale dialog from 0.95 |
| Save success | Tap save | 300ms | `ease-out` | Button flashes success green, then navigate back |
| Delete success | Confirm delete | 300ms | `ease-out` | Dialog dismisses, navigate back with toast |

#### Accessibility

- Title field: "Reminder title, required text field."
- Category chips: "Category selector. Birthday. Anniversary. Date Night. Promise. Recurring. Custom, selected."
- Date: "Date, required. March 21, 2026. Double tap to change."
- Time: "Time, optional. Not set. Double tap to add."
- Escalation checkboxes: "Notification escalation. 7 days before, checkbox, checked." etc.
- Switch: "Auto-suggest gifts before this date. Switch, off."
- Save: "Save Reminder, button, disabled" / "Save Reminder, button"
- Delete: "Delete Reminder, button. Warning: this cannot be undone."

#### Edge Cases

- **Edit mode pre-fill:** All fields populated from existing reminder data. Title has current text, category chip selected, date set, etc.
- **Past date:** Allowed for edit mode (historical records). For create mode, show warning: "This date is in the past. Set reminders for future dates." but allow save.
- **Recurring + specific date:** "Yearly" auto-uses selected date's month/day. "Monthly" uses day of month. "Weekly" uses day of week.
- **Keyboard covers fields:** Form auto-scrolls to keep focused field visible with 16dp clearance.
- **Rapid save taps:** Debounce with 500ms. Show loading state.

---

### Screen 18: Reminder Detail

| Property | Value |
|----------|-------|
| **Screen Name** | Reminder Detail |
| **Route** | `/reminders/detail` |
| **Module** | Smart Reminders |
| **Sprint** | Sprint 3 |

#### Layout Description

Read-only detail view of a single reminder with action buttons. Shows all reminder info in a card layout. Quick actions: Edit, Snooze, Complete, Delete. If reminder is associated with a gift suggestion, show gift link card. Escalation timeline visualization.

**Structure (top to bottom):**
- App bar: 56dp
- Spacer: 16dp
- Reminder hero card: auto (~180dp)
- Spacer: 16dp
- Quick actions row: 64dp
- Spacer: 24dp
- Escalation timeline section
- Spacer: 24dp
- Notes section (if notes exist)
- Spacer: 24dp
- Linked gift card (if gift suggestion enabled)
- Spacer: 24dp
- History section (past completions for recurring)
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + title: reminder title (e.g. "Her Birthday") -- `heading.sm`, truncate if long
- Right action: overflow menu (`ic_more_vert.svg` 24dp, `text.secondary`)
  - Menu items: "Edit", "Duplicate", "Delete"

**2. Reminder Hero Card**
- Width: screen width minus 32dp
- Background: category-color at 5% opacity
- Border: 1.5px solid category-color at 30%
- Border radius: 16px
- Padding: 24dp
- Layout: Column, center-aligned

  **Category Icon:**
  - Size: 48x48dp
  - Background: category-color at 15%
  - Border radius: 12dp
  - Icon: 24x24dp, category-color
  - Center aligned

  **Title:**
  - Typography: `heading.md` -- 20sp, 600, `text.primary`
  - Center aligned, 12dp below icon

  **Date:**
  - Typography: `heading.sm` -- 18sp, 400, `text.primary`
  - Format: "March 21, 2026" (locale-appropriate)
  - Center aligned, 4dp below title

  **Countdown Badge:**
  - Typography: `label.lg` -- 16sp, 600
  - Color: `status.error` (<3 days), `status.warning` (<7 days), `brand.primary` (>7 days)
  - Text: "in 35 days" / "Tomorrow!" / "Today!" / "2 days overdue"
  - Background: corresponding color at 10%
  - Padding: 8dp horizontal, 4dp vertical
  - Border radius: `radius.chip` (16dp)
  - Center aligned, 8dp below date

  **Recurrence Label (if recurring):**
  - Icon: `ic_repeat` 14dp inline + text
  - Text: "Repeats yearly" / "Every Friday" / etc.
  - Typography: `body.md`, 14sp, `text.secondary`
  - 8dp below countdown

**3. Quick Actions Row**
- Layout: Row, evenly spaced, 16dp horizontal padding
- 4 action buttons

  **Action Button:**
  - Size: 56x56dp (icon area) + 16dp for label = total 72dp vertical
  - Layout: Column -- icon circle (top), label (bottom)
  - Icon circle: 48x48dp, `bg.tertiary`, border radius 24dp (circle), icon 20x20dp centered
  - Label: `label.sm`, 12sp, 500

  | Action | Icon | Color | Label |
  |--------|------|-------|-------|
  | Edit | `ic_edit` | `brand.primary` | "Edit" |
  | Snooze | `ic_snooze` | `status.warning` | "Snooze" |
  | Complete | `ic_check_circle` | `status.success` | "Done" |
  | Delete | `ic_trash` | `status.error` | "Delete" |

  **Button States:**
  | State | Icon Circle Bg | Icon Color |
  |-------|---------------|------------|
  | Default | `bg.tertiary` | action-color |
  | Pressed | action-color at 15% | action-color |
  | Disabled | `bg.tertiary` at 50% | `text.tertiary` |

  **Actions:**
  - Edit: navigate to `/reminders/create?id=xxx` (edit mode)
  - Snooze: opens snooze bottom sheet (1 hour, 1 day, 3 days, 1 week, custom)
  - Complete: marks as done, confetti animation, card updates
  - Delete: confirmation dialog (same as Screen 17)

**4. Snooze Bottom Sheet**
- Same sheet container style
- Title: "Snooze until..."
- Options as selectable list:

  | Option | On select |
  |--------|----------|
  | "1 hour" | reschedule +1h |
  | "Tomorrow morning" | reschedule next 9 AM |
  | "3 days" | reschedule +3d |
  | "1 week" | reschedule +7d |
  | "Custom..." | opens date+time picker |

  - Each option: 48dp height, `body.lg`, 16sp, `text.primary`, chevron on actionable items
  - On select: sheet dismisses, reminder date updates, toast "Snoozed until [date]"

**5. Escalation Timeline**
- Header: "Notification Timeline" -- `heading.sm`, 18sp, 600
- Visual: vertical timeline with dots and lines

  **Timeline Node:**
  - Layout: Row -- dot/line (left column, 24dp wide), text (right column)
  - Dot: 12x12dp circle
    - Past (sent): `status.success`, filled
    - Current (next): `brand.primary`, filled, pulse animation
    - Future: `border.default`, outline only
  - Connecting line: 2dp wide, extends from dot to next dot
    - Past: `status.success`
    - Future: `border.default`
  - Text: "7 days before -- Feb 14" -- `body.md`, 14sp
    - Sent: `text.secondary` + "Sent" badge (`status.success`, `body.sm`)
    - Next: `text.primary`, bold
    - Future: `text.tertiary`
  - Node height: 40dp

**6. Notes Section (conditional)**
- Header: "Notes" -- `label.lg`, 16sp, 500, `text.primary`
- Card: `bg.tertiary`, 12px radius, 16dp padding
- Text: `body.lg`, 16sp, `text.primary`

**7. Linked Gift Card (conditional)**
- Visible if "auto-suggest gifts" was enabled
- Width: screen width minus 32dp
- Background: `brand.accent` at 5%
- Border: 1px solid `brand.accent` at 20%
- Border radius: 12px
- Padding: 16dp
- Layout: Row -- gift icon (left), text (center), "Browse" button (right)
- Icon: `ic_gift` 24dp, `brand.accent`
- Text: "Gift suggestions ready for this date" -- `body.md`, 14sp, `text.primary`
- Button: "Browse" -- text button, `brand.accent`
- On tap: navigate to `/gifts?occasion=[category]`

#### Dark Mode / Light Mode

Standard patterns applied. Hero card uses category color at appropriate opacity in both modes.

#### RTL Notes

- Quick action buttons: same visual order (no reflow for evenly-spaced centered buttons)
- Timeline: dot column moves to right, text left
- Connecting lines stay vertically centered on dots
- Notes card text aligns right
- Gift card: icon right, button left
- Snooze sheet options: text right, chevrons left

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Hero card | Page load | 400ms | `anim.spring` | Scale from 0.95 + fade |
| Quick actions | Staggered after hero | 200ms each | `anim.spring` | Scale from 0.8 + fade, 50ms stagger |
| Timeline | After actions (staggered) | 150ms each | `ease-out` | Nodes fade in top-to-bottom, 50ms stagger |
| Current node pulse | Continuous | 2000ms loop | `ease-in-out` | Opacity 70%-100% on current timeline dot |
| Complete action | Tap | 600ms | `anim.spring` | Confetti burst (12 particles, gold + primary colors), hero card countdown changes to "Completed" with check |
| Snooze sheet | Open | 300ms | `anim.sheet.enter` | Slide up |

#### Accessibility

- Hero: "Her Birthday. March 21, 2026. In 35 days. Repeats yearly."
- Quick actions: "Edit, button. Snooze, button. Mark as done, button. Delete, button."
- Timeline: "Notification timeline. 7 days before, February 14, sent. 3 days before, February 18, next notification. 1 day before, February 20, scheduled."
- Snooze sheet: "Snooze until. List of options."
- Gift card: "Gift suggestions ready for this date. Browse gifts, button."

#### Edge Cases

- **Completed reminder:** Hero card shows green check overlay. Quick actions: Edit and Snooze disabled, "Done" changes to "Undo". Countdown shows "Completed on [date]".
- **Overdue reminder:** Hero countdown badge is red. Additional "Overdue" treatment: subtle pulsing red glow on hero card border.
- **No escalation set:** Timeline section hidden. Instead: "No notification schedule set. Edit to add."
- **Recurring reminder history:** Shows last 5 completions: "Completed: Feb 14, 2025. Jan 14, 2025." etc. in a simple list.
- **Deep link from notification:** Navigating to detail from push notification: back arrow returns to reminders list, not notification center.

---

## MODULE 5: AI MESSAGE GENERATOR

---

### Screen 19: Mode Picker

| Property | Value |
|----------|-------|
| **Screen Name** | Mode Picker |
| **Route** | `/messages` |
| **Module** | AI Message Generator |
| **Sprint** | Sprint 3 |

#### Layout Description

Grid of 10 situational message modes displayed as cards in a 2-column grid. Each card is a tappable entry point for generating a specific type of message. "History" link at bottom for past messages. Bottom nav with "Messages" tab active. Scrollable grid.

**Structure (top to bottom):**
- App bar: 56dp
- Spacer: 16dp
- Headline: "What do you want to say to her?"
- Spacer: 8dp
- Subtitle
- Spacer: 24dp
- Mode card grid (2 columns, 5 rows)
- Spacer: 24dp
- "View History" button (secondary)
- Spacer: 80dp (bottom nav clearance)
- Bottom Nav: 64dp

#### Component Breakdown

**1. App Bar**
- Back arrow: navigates to `/home`
- Title: "AI Messages" -- `heading.sm`, centered
- Right action: `ic_history.svg` 24dp, `text.secondary`, on tap navigate to `/messages/history`

**2. Headline**
- Text: "What do you want to say to her?"
- Typography: `heading.md` -- 20sp, 600, `text.primary`
- Padding: 16dp horizontal
- Alignment: start

**3. Subtitle**
- Text: "Pick a situation and LOLO will craft the perfect message"
- Typography: `body.md` -- 14sp, 400, `text.secondary`
- Padding: 16dp horizontal

**4. Mode Card Grid**
- Layout: 2-column grid
- Column gap: 12dp
- Row gap: 12dp
- Padding: 16dp horizontal
- Each card: (screen width - 32 - 12) / 2 = dynamic width, 112dp height

  **Mode Card:**
  - Background (dark): `bg.tertiary` (`#21262D`)
  - Background (light): `bg.tertiary` (`#EAEEF2`)
  - Border: 1px solid `border.default`
  - Border radius: `radius.card` (12px)
  - Padding: 12dp
  - Layout: Column, center-aligned
  - Elevation: `elevation.0` (flat, elevation on press)

  **Card Structure:**
  - Icon: 32x32dp, center-top, category-specific color
  - Title: `label.lg` -- 16sp, 500, `text.primary`, center, 8dp below icon
  - Subtitle: `body.sm` -- 12sp, 400, `text.secondary`, center, 4dp below title, max 2 lines

  **Mode Cards Data:**
  | # | Mode | Icon | Icon Color | Subtitle |
  |---|------|------|-----------|----------|
  | 1 | Appreciation | `ic_heart_sparkle` | `#E88DA1` | "Tell her she's amazing" |
  | 2 | Apology | `ic_bandaid_heart` | `status.error` | "Make things right" |
  | 3 | Reassurance | `ic_hug` | `brand.primary` | "Be her safe place" |
  | 4 | Motivation | `ic_muscle_heart` | `status.success` | "Lift her spirits" |
  | 5 | Celebration | `ic_party` | `brand.accent` | "Celebrate her wins" |
  | 6 | Flirting | `ic_fire_heart` | `#F85149` | "Turn up the heat" |
  | 7 | After Argument | `ic_peace_dove` | `brand.primary` | "Bridge the gap" |
  | 8 | Long Distance | `ic_airplane_heart` | `#4A90D9` | "Close the miles" |
  | 9 | Good Morning/Night | `ic_sun_moon` | `#D29922` | "Start or end her day right" |
  | 10 | Checking On You | `ic_wave_heart` | `status.success` | "Show you care" |

  **States:**
  | State | Background | Border | Elevation | Other |
  |-------|-----------|--------|-----------|-------|
  | Default | `bg.tertiary` | 1px `border.default` | `elevation.0` | -- |
  | Pressed | darken 5% | 1px `border.emphasis` | `elevation.1` | Scale 0.97 |
  | Focused | `bg.tertiary` | 2px `brand.primary` | `elevation.0` | Focus ring |
  | Locked (free tier) | `bg.tertiary` at 60% | 1px `border.default` | `elevation.0` | Lock icon overlay 20dp, `text.tertiary` |

  **Free Tier Locking:**
  - Modes 1-4: always available
  - Modes 5-10: show lock overlay for free users
  - Lock overlay: `ic_lock.svg` 20x20dp, `text.tertiary`, top-right corner of card, 8dp inset
  - On tap locked card: show upgrade prompt bottom sheet: "Unlock all message modes with Pro" + "Upgrade" button + "Not now" link

**5. "View History" Button**
- Width: screen width minus 32dp
- Height: 44dp
- Background: transparent
- Border: 1px solid `border.default`
- Border radius: `radius.button` (24px)
- Text: "View Message History" -- `label.lg`, 16sp, 500, `text.secondary`
- Center aligned
- On tap: navigate to `/messages/history`

**6. Bottom Nav**
- Same spec, "Messages" tab active

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Card bg | `#21262D` | `#EAEEF2` |
| Card border | `#30363D` | `#D0D7DE` |
| Lock overlay bg | `#21262D` at 60% | `#EAEEF2` at 60% |
| History button border | `#30363D` | `#D0D7DE` |

#### RTL Notes

- Grid flows right-to-left: card #1 (Appreciation) in top-right, card #2 (Apology) in top-left
- Card content center-aligned: no directional impact
- Lock icon stays in top-right corner (absolute position) in LTR; moves to top-left in RTL
- "View History" button centered
- Headline aligns right

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide + fade |
| Cards entrance | Page settle | 300ms | `anim.spring` | Staggered: each card fades in + scale from 0.9, 50ms stagger, zigzag order (left-right alternating) |
| Card press | Touch down | 100ms | `ease-out` | Scale to 0.97 + elevation bump |
| Card release | Touch up | 200ms | `anim.spring` | Scale back to 1.0 |
| Lock tap | Tap locked card | 300ms | `anim.spring` | Card shakes (translate X: 0, -4, 4, -2, 2, 0) + lock icon pulses |
| Upgrade sheet | After lock shake | 300ms | `anim.sheet.enter` | Upgrade prompt slides up |

#### Accessibility

- Screen: "AI Messages. What do you want to say to her? 10 message modes available."
- Each card: "Appreciation. Tell her she's amazing. Button."
- Locked cards: "Celebration. Celebrate her wins. Locked. Upgrade to Pro to unlock. Button."
- History button: "View Message History. Button."
- Grid: semantically a list for screen readers; announce "Item 1 of 10" etc.

#### Edge Cases

- **All modes unlocked (Pro/Legend):** No lock icons anywhere. All cards fully interactive.
- **Quota reached (free tier):** Cards 1-4 remain tappable but show "0 messages remaining today" badge on press. Bottom toast: "Daily limit reached. Upgrade or come back tomorrow."
- **Small screen:** Grid items reduce to 100dp height. Subtitle may truncate to 1 line.
- **Empty state:** Not applicable -- always shows 10 modes.

---

### Screen 20: Message Configuration

| Property | Value |
|----------|-------|
| **Screen Name** | Message Configuration |
| **Route** | `/messages/configure` |
| **Module** | AI Message Generator |
| **Sprint** | Sprint 3 |

#### Layout Description

Configuration form before AI generates a message. Fields: tone selector, humor slider, message language, optional context input, message length, name inclusion toggle. Pre-populated with smart defaults based on mode and her profile. Single scrollable column. Generate button at bottom.

**Structure (top to bottom):**
- App bar: 56dp (dynamic title based on mode)
- Spacer: 16dp
- Mode context card (mini): 56dp
- Spacer: 24dp
- Tone chips
- Spacer: 20dp
- Humor level slider
- Spacer: 20dp
- Message Language chips
- Spacer: 20dp
- Context text area (optional)
- Spacer: 20dp
- Message Length chips
- Spacer: 20dp
- Include Name toggle
- Spacer: 32dp
- Generate button
- Spacer: 8dp
- Usage hint text
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow + dynamic title centered
- Title matches selected mode: "Appreciation Message", "Apology Message", etc.
- No right action

**2. Mode Context Card**
- Width: screen width minus 32dp
- Height: 56dp
- Background: mode icon color at 5%
- Border: 1px solid mode icon color at 20%
- Border radius: `radius.card` (12px)
- Padding: 12dp horizontal
- Layout: Row -- mode icon (24dp, mode color), mode name + subtitle
- Mode name: `label.lg`, 16sp, 500, `text.primary`
- Subtitle: e.g. "Tell her she's amazing" -- `body.sm`, 12sp, `text.secondary`
- Not interactive -- purely informational context

**3. Tone Chips**
- Header: "Tone" -- `label.lg`, 16sp, 500, `text.primary`
- Single-select chip row, wrap layout
- Gap: 8dp

  **Chips:** "Romantic", "Funny", "Poetic", "Casual", "Formal"

  - Same chip spec as Screen 14 (40dp height, pill, outlined default, filled selected)
  - Selected chip: `brand.primary` bg, `#FFFFFF` text
  - Smart defaults by mode:
    | Mode | Default Tone |
    |------|-------------|
    | Appreciation | Romantic |
    | Apology | Formal |
    | Reassurance | Casual |
    | Motivation | Casual |
    | Celebration | Funny |
    | Flirting | Romantic |
    | After Argument | Formal |
    | Long Distance | Romantic |
    | Good Morning/Night | Casual |
    | Checking On You | Casual |

**4. Humor Level Slider**
- Same slider spec as Screen 13
- Label: "Humor Level"
- Low label: "None"
- High label: "Max"
- Range: 0 to 100
- Default: 30 (varies by mode; Flirting/Celebration higher at 60; Apology at 10)
- Thumb interaction: same spec with haptic at 25/50/75

**5. Message Language Chips**
- Header: "Message Language" -- `label.lg`
- Single-select chips: "English", "Arabic", "Bahasa Melayu"
- Default: her preferred language from profile (or app language if not set)
- Same chip styling

**6. Context Text Area**
- Header: "Add context (optional)" -- `label.lg`
- Subtext: "Help LOLO write a better message" -- `body.sm`, `text.secondary`
- Text area: 64dp min height, 200 char max
- Placeholder: varies by mode:
  | Mode | Placeholder |
  |------|------------|
  | Appreciation | "e.g. She just got promoted at work" |
  | Apology | "e.g. I forgot to call her back" |
  | Reassurance | "e.g. She's worried about her exam" |
  | Motivation | "e.g. She's thinking of starting a business" |
  | Celebration | "e.g. It's our 5th anniversary" |
  | Flirting | "e.g. We haven't seen each other all week" |
  | After Argument | "e.g. We disagreed about family plans" |
  | Long Distance | "e.g. She's in another city for work" |
  | Good Morning/Night | "e.g. She has a big presentation today" |
  | Checking On You | "e.g. She seemed quiet yesterday" |

**7. Message Length Chips**
- Header: "Message Length" -- `label.lg`
- Single-select: "Short" (2-3 sentences), "Medium" (4-6 sentences), "Long" (7+ sentences)
- Default: "Medium"
- Each chip has subtle character count: "Short (~50 words)" etc. in `body.sm`, `text.tertiary`

**8. Include Name Toggle**
- Layout: Row -- text (left), chip toggle pair (right)
- Text: "Include her name?" -- `label.lg`, 16sp, 500, `text.primary`
- Two mini chips: "Yes" / "No" -- single select, 32dp height, 40dp width each
- Default: "Yes" if her name is set, "No" otherwise
- If no name in profile: show hint "Set her name in Her Profile to enable"

**9. Generate Button**
- Width: screen width minus 32dp
- Height: 52dp
- Background: `gradient.premium` (special for AI generation)
- Text: "Generate Message" -- `button`, `#FFFFFF`
- Icon: `ic_sparkle.svg` 18x18dp, `#FFFFFF`, left of text, 8dp gap
- Border radius: `radius.button` (24px)
- Elevation: `elevation.2`
- Always enabled (defaults are sufficient)

  **States:**
  | State | Visual |
  |-------|--------|
  | Default | Gradient bg, "Generate Message" |
  | Pressed | Darken 10%, scale 0.98 |
  | Loading | Text changes to "Generating...", animated sparkle icon rotates, all form inputs disabled |
  | Disabled (quota) | Gray bg (`bg.tertiary`), "Limit reached", no gradient |

**10. Usage Hint**
- Layout: Row -- lightning icon (14dp, `brand.accent`) + text
- Text: "Uses 1 of 2 daily free messages" (or "Unlimited with Pro")
- Typography: `body.sm`, 12sp, `text.tertiary`
- Center aligned
- Pro users: "Unlimited messages" in `brand.accent`

#### Dark Mode / Light Mode

Standard form pattern. Generate button gradient is identical in both modes.

#### RTL Notes

- All headers and labels right-aligned
- Chip rows flow right-to-left
- Humor slider reverses: "None" right, "Max" left
- Text area cursor starts right
- Language chips: same order but right-aligned flow
- Include name toggle: text right, chips left
- Lightning icon in usage hint moves to right
- Generate button icon stays left of text (visual consistency, not mirrored)

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide + fade |
| Mode card | Page settle | 200ms | `ease-out` | Fade in |
| Chip select | Tap | 150ms | `ease-out` | Fill transition |
| Generating | Tap generate | continuous | linear | Sparkle icon rotates 360deg loop, button gradient subtly shifts (hue rotation) |
| Generating dots | During generation | 600ms loop | `ease-in-out` | "Generating..." text dots animate (., .., ..., repeat) |
| Generate success | Result ready | 300ms | `anim.page.enter` | Navigate to result screen |

#### Accessibility

- Mode card: "Appreciation mode. Tell her she's amazing."
- Tone: "Tone selector. 5 options. Romantic, selected."
- Humor: "Humor level slider. Current value: 30 out of 100."
- Language: "Message language. English, selected."
- Context: "Add context, optional text field."
- Length: "Message length. Short. Medium, selected. Long."
- Name toggle: "Include her name. Yes, selected. No."
- Generate: "Generate Message, button." / "Generating message, please wait."
- Usage: "Uses 1 of 2 daily free messages."

#### Edge Cases

- **Quota exceeded:** Generate button shows "Daily limit reached". Tapping shows upgrade prompt.
- **No internet:** On generate tap: toast "You need internet to generate messages." Button stays enabled for retry.
- **Generation timeout (>15s):** Show "Taking longer than expected..." text below button. After 30s: "Generation failed. Try again." with Retry.
- **Very long context (near 200 chars):** Character counter turns `status.warning` at 180 chars.
- **All defaults unchanged:** Fine. Generate with all smart defaults.

---

### Screen 21: Generated Message

| Property | Value |
|----------|-------|
| **Screen Name** | Generated Message |
| **Route** | `/messages/result` |
| **Module** | AI Message Generator |
| **Sprint** | Sprint 3 |

#### Layout Description

The hero screen showing the AI-generated message. Large message card as centerpiece. Action buttons row (Copy, Share, Edit). Star rating for feedback. Regenerate button. AI tip card. Save to history option. Designed to feel rewarding and premium.

**Structure (top to bottom):**
- App bar: 56dp ("Your Message")
- Spacer: 16dp
- Message card (hero): auto height
- Spacer: 20dp
- Action buttons row: 56dp
- Spacer: 24dp
- Rating row: 48dp
- Spacer: 20dp
- Regenerate button: 44dp
- Spacer: 20dp
- Tip card: auto (~56dp)
- Spacer: 20dp
- Save to History button: 44dp
- Spacer: 24dp

#### Component Breakdown

**1. App Bar**
- Back arrow: navigates to `/messages/configure`
- Title: "Your Message" -- `heading.sm`, centered
- Right action: bookmark icon (`ic_bookmark_outline.svg` 24dp, `text.secondary`)
  - On tap: toggle save to favorites (icon fills: `ic_bookmark_filled.svg`, `brand.accent`)

**2. Message Card (Hero)**
- Width: screen width minus 32dp
- Min height: 160dp (auto-expands to fit content)
- Background: `gradient.card.subtle` (vertical)
- Border: 1.5px solid `brand.primary` at 40%
- Outer glow: `brand.primary` at 8%, 8dp spread (dark mode only)
- Border radius: 16px (hero treatment)
- Padding: 24dp
- Elevation: `elevation.2`

  **Opening Quote Mark:**
  - Character: " (curly open quote)
  - Typography: `display.lg` -- 32sp, 700, `brand.accent`
  - Position: top-left of content, -8dp offset upward (overlaps card top padding slightly)

  **Message Text:**
  - Typography: `body.lg` -- 16sp, 400, line-height 26sp (extra generous for readability)
  - Color: `text.primary`
  - Text: the AI-generated message content
  - Selectable: user can long-press to select text

  **Closing Quote Mark:**
  - Character: " (curly close quote)
  - Same styling as opening, positioned at end of last line

  **Edited Badge (conditional):**
  - Visible only if user has edited the message
  - Text: "Edited" -- `label.sm`, 12sp, 500, `text.tertiary`
  - Icon: `ic_edit_small` 12dp, `text.tertiary`
  - Position: bottom-right of card, inside padding
  - Background: `bg.secondary` at 80%
  - Padding: 4dp 8dp
  - Border radius: 8dp

  **Edit Mode (activated by Edit button):**
  - Message text becomes editable (inline text field)
  - Card border changes to 2px `brand.primary`
  - Soft keyboard opens
  - "Done Editing" button appears below card (replaces action row temporarily)
  - Character counter appears: "X/500 characters"

**3. Action Buttons Row**
- Layout: Row, evenly spaced, center-aligned
- 3 buttons, each 56dp width (auto), 48dp height
- Gap: 16dp

  **Action Button Template:**
  - Layout: Column -- icon (top, 24dp), label (bottom, 12sp)
  - Background: `bg.tertiary`
  - Border: 1px solid `border.default`
  - Border radius: `radius.card` (12px)
  - Padding: 8dp
  - Touch target: 56x48dp minimum

  | Button | Icon | Color | Label | Action |
  |--------|------|-------|-------|--------|
  | Copy | `ic_copy` | `brand.primary` | "Copy" | Copy to clipboard |
  | Share | `ic_share` | `brand.primary` | "Share" | Native share sheet |
  | Edit | `ic_edit` | `brand.primary` | "Edit" | Enable inline editing |

  **Copy Success State:**
  - Icon changes to `ic_check` (checkmark), `status.success`, 300ms
  - Label changes to "Copied!" in `status.success`
  - Toast: "Message copied to clipboard" at screen bottom
  - Reverts to default after 2000ms

  **Share Action:**
  - Opens native platform share sheet (Android Intent / iOS UIActivityViewController)
  - Share text: message content only (no app branding in shared text)

**4. Rating Row**
- Layout: Column -- label (top), stars row (bottom)
- Label: "How was this message?" -- `body.md`, 14sp, `text.secondary`, center
- Stars: 5 star icons in a row, 32dp each, 8dp gap

  **Star:**
  - Size: 32x32dp
  - Unrated: `ic_star_outline.svg`, `border.default`
  - Rated: `ic_star_filled.svg`, `brand.accent` (`#C9A96E`)
  - Touch target: 40x40dp (overlapping slightly)

  - On tap star N: stars 1 through N fill with accent color
  - Animation: each star scales to 1.2 then 1.0 with 50ms stagger (`anim.spring`)
  - After rating: brief "Thanks!" text appears below stars, `body.sm`, `status.success`, 12sp, fade in then fade out after 2000ms

**5. Regenerate Button**
- Width: screen width minus 32dp
- Height: 44dp
- Background: transparent
- Border: 1px solid `brand.primary`
- Border radius: `radius.button` (24px)
- Text: "Regenerate" -- `label.lg`, 16sp, 500, `brand.primary`
- Icon: `ic_refresh` 18dp, `brand.primary`, left of text
- On tap: current message fades out, loading state, new message fades in. Same config used.
- Usage: counts against daily quota for free users

**6. Tip Card**
- Width: screen width minus 32dp
- Background: `brand.accent` at 5%
- Border: 1px solid `brand.accent` at 15%
- Border radius: `radius.card` (12px)
- Padding: 12dp
- Layout: Row -- lightbulb icon (left), text (right)
- Icon: `ic_lightbulb` 20dp, `brand.accent`
- Text: contextual AI tip, e.g.:
  - "Tip: Send this with her favorite flowers for maximum impact."
  - "Tip: Timing matters -- send this when she's relaxed, not busy."
  - "Tip: Follow up this message with a small action. Words + deeds = magic."
- Typography: `body.md`, 14sp, `text.secondary`
- Tip is randomly selected from a pool based on mode

**7. Save to History Button**
- Width: screen width minus 32dp
- Height: 44dp
- Background: transparent
- Border: 1px solid `border.default`
- Border radius: `radius.button` (24px)
- Text: "Save to History" -- `label.lg`, 16sp, 500, `text.secondary`
- Icon: `ic_history_save` 18dp, `text.secondary`, left of text

  **States:**
  | State | Visual |
  |-------|--------|
  | Default | Outlined, "Save to History" |
  | Saved | Icon becomes check, text "Saved", `status.success` border and text, disabled |

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Message card bg | gradient `#21262D` to `#161B22` | gradient `#EAEEF2` to `#F6F8FA` |
| Message card border | `#4A90D9` at 40% | `#4A90D9` at 40% |
| Card outer glow | `#4A90D9` at 8% | none |
| Quote marks | `#C9A96E` | `#C9A96E` |
| Action button bg | `#21262D` | `#EAEEF2` |
| Star unrated | `#30363D` | `#D0D7DE` |
| Star rated | `#C9A96E` | `#C9A96E` |
| Tip card bg | `#C9A96E` at 5% | `#C9A96E` at 5% |

#### RTL Notes

- Message text: auto-aligns based on message language (right for Arabic, left for English/Malay)
- Quote marks: right curly open quote on right side for Arabic text, closing on left
- Action buttons: same visual order (centered row, no directional change)
- Stars: remain left-to-right fill (universal convention)
- Tip card: icon moves to right, text aligns right
- Regenerate and Save buttons: icon stays left of text (no mirror for centered buttons)
- Bookmark icon in app bar: stays on right side (no change)

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation from config | 300ms | `anim.page.enter` | Slide + fade |
| Message card entrance | Page settle | 500ms | `anim.spring` | Scale from 0.92 + fade + slight Y translate (-8dp to 0) |
| Typewriter (first generation) | Card visible | varies | linear | Characters appear 20ms each, max 3s then instant-fill |
| Glow pulse (dark mode) | After card settle | 3000ms loop | `ease-in-out` | Border glow opacity 4% to 12%, subtle |
| Action buttons | After message complete | 300ms | `anim.spring` | Fade in + translate Y 12dp, 80ms stagger |
| Star fill | Star tap | 200ms per star | `anim.spring` | Scale 1.0 to 1.2 to 1.0, color fill, 50ms stagger |
| Regenerate | Tap | 400ms out + 500ms in | `ease-out` | Current message fades + scales to 0.95 out, new fades + scales from 0.95 in |
| Copy feedback | Tap copy | 300ms | `anim.spring` | Icon swaps with bounce, reverts after 2s |
| Save confirmation | Tap save | 200ms | `ease-out` | Border + text color transitions to success |

#### Accessibility

- Message card: "Generated message. [Full message text]. Selectable."
- If edited: "Generated message, edited. [text]."
- Copy: "Copy message to clipboard, button"
- Share: "Share message, button"
- Edit: "Edit message, button. Enables inline text editing."
- Stars: "Rate this message. 5 stars. Currently unrated." / "4 out of 5 stars."
- Regenerate: "Regenerate message, button. Generates a new message with same settings."
- Tip: informational, read as static text
- Save: "Save to History, button" / "Saved to history."
- Typewriter animation: screen reader reads full text immediately (animation is visual only, full text in accessibility tree from start)

#### Edge Cases

- **Very short message (Short setting):** Card min height ensures proper visual weight even with 2 sentences. Padding maintains.
- **Very long message (Long setting):** Card expands. Max 500 characters. If message is exceptionally long, card scrolls internally (rare).
- **Arabic message on English UI:** Message card text aligns right. Rest of UI stays LTR.
- **Edit produces empty message:** "Done Editing" button disabled if message field is empty.
- **Regenerate with no quota:** Show upgrade prompt instead of regenerating.
- **Share with no apps:** Toast "No sharing apps available."
- **Network failure during generation:** Error state: card shows "Couldn't generate. Check your connection." with Retry button inside card area.
- **Message contains her name check:** If "include name" was Yes but name is null, AI omits name gracefully. No "[NAME]" placeholder in output.

---

### Screen 22: Message History

| Property | Value |
|----------|-------|
| **Screen Name** | Message History |
| **Route** | `/messages/history` |
| **Module** | AI Message Generator |
| **Sprint** | Sprint 4 |

#### Layout Description

List of all previously generated and saved messages. Filterable by mode type, date, or favorites. Grouped by month. Each tile shows mode type, message preview, date, rating, and quick action buttons (copy/share). Bottom nav with "Messages" tab active. Infinite scroll with pagination.

**Structure (top to bottom):**
- App bar: 56dp ("Message History")
- Spacer: 8dp
- Filter chip row: 40dp (horizontal scroll)
- Spacer: 16dp
- Monthly group headers + message tiles (scrollable)
- Spacer: 80dp (bottom nav clearance)
- Bottom Nav: 64dp

#### Component Breakdown

**1. App Bar**
- Back arrow: navigates to `/messages`
- Title: "Message History" -- `heading.sm`, centered
- Right action: search icon (`ic_search.svg` 24dp, `text.secondary`)
  - On tap: expand search bar in app bar (replaces title). Text field for searching message content.

**2. Filter Chip Row**
- Layout: horizontal scroll row
- Padding: 16dp left, 16dp right
- Gap: 8dp
- Height: 36dp

  **Filter Chips:**
  - "All" (default selected), "Favorites", "Appreciation", "Apology", "Reassurance", "Motivation", "Celebration", "Flirting", "After Argument", "Long Distance", "Morning/Night", "Checking"

  **Chip Spec:**
  - Height: 36dp
  - Padding: 12dp horizontal
  - Border radius: 18dp (pill)

  | State | Background | Border | Text |
  |-------|-----------|--------|------|
  | Unselected | transparent | 1px `border.default` | `text.secondary`, `label.sm` 12sp |
  | Selected | `brand.primary` | none | `#FFFFFF`, `label.sm` 12sp 600 |

  - "Favorites" chip has a star icon 14dp inline
  - Single-select: tapping a filter deselects previous

**3. Monthly Group Header**
- Text: "February 2026" (or "This Month", "Last Month" for recent)
- Typography: `label.md`, 14sp, 500, `text.tertiary`
- Sticky on scroll
- Height: 32dp
- Padding: 16dp horizontal
- Background: `bg.primary`

**4. Message History Tile**
- Width: full screen width
- Min height: 96dp
- Background: `bg.primary`
- Padding: 16dp horizontal, 12dp vertical
- Border bottom: 1px solid `border.default` at 40%
- Layout: complex (described below)

  **Tile Structure:**

  **Row 1: Header**
  - Layout: Row -- mode badge (left), timestamp (right)
  - Mode badge: icon (16dp) + mode name, `label.sm`, 12sp, mode-color
  - Timestamp: "Feb 14" -- `body.sm`, 12sp, `text.tertiary`

  **Row 2: Message Preview**
  - Text: first 2 lines of message, with ellipsis
  - Typography: `body.md`, 14sp, 400, `text.primary`
  - Italic styling (inherited from message nature)
  - Opening quote: " in `brand.accent`, 14sp, inline
  - 4dp below Row 1

  **Row 3: Footer**
  - Layout: Row -- rating (left), action buttons (right)
  - Rating: filled star icons (12dp each) + count, `brand.accent`
  - Action buttons: Copy (`ic_copy` 16dp) and Share (`ic_share` 16dp), `text.secondary`, 32x32dp touch targets, 8dp gap
  - 8dp below Row 2

  **Favorite Indicator (conditional):**
  - Bookmark icon filled, `brand.accent`, top-right of tile (absolute position, 12dp inset)
  - Visible only on favorited messages

  **States:**
  | State | Visual |
  |-------|--------|
  | Default | Standard styling |
  | Pressed | bg darken 3% |
  | Swiped left | Delete: red bg, trash icon. Confirmation required. |

  - On tap tile: navigate to `/messages/result?id=xxx` (read-only detail view)

**5. Search Expansion (triggered from app bar)**
- App bar transforms: back arrow + text field (expanding) + clear button
- Text field: `body.lg`, 16sp, `text.primary`, placeholder "Search messages..."
- Filters below auto-update to show only matching results
- Debounce: 300ms after last keystroke before filtering
- Searches within message text, mode names, and dates

**6. Empty States**

  **No messages at all:**
  - Center illustration: `il_empty_messages.svg` (chat bubble with sparkle) 120x120dp
  - Title: "No messages yet" -- `heading.sm`, 18sp, 600, `text.primary`
  - Subtitle: "Generate your first one!" -- `body.md`, 14sp, `text.secondary`
  - CTA: "Create a Message" -- secondary outlined button
  - On tap: navigate to `/messages`

  **No results for filter:**
  - Title: "No messages match this filter" -- `body.lg`, 16sp, `text.secondary`
  - Subtitle: "Try a different filter or search term"
  - No CTA

**7. Bottom Nav**
- "Messages" tab active

#### Dark Mode / Light Mode

| Element | Dark | Light |
|---------|------|-------|
| Screen bg | `#0D1117` | `#FFFFFF` |
| Tile bg | `#0D1117` | `#FFFFFF` |
| Tile divider | `#30363D` at 40% | `#D0D7DE` at 40% |
| Group header bg | `#0D1117` | `#FFFFFF` |
| Filter selected bg | `#4A90D9` | `#4A90D9` |
| Filter unselected border | `#30363D` | `#D0D7DE` |
| Search field bg | `#161B22` | `#F6F8FA` |

#### RTL Notes

- Filter chips scroll from right; first chip ("All") on rightmost position
- Tile: mode badge moves to right, timestamp to left
- Message preview text: aligns based on message language (right for Arabic messages, left for English)
- Rating stars stay left-to-right
- Action buttons (copy/share) move to left side of footer
- Swipe to delete: swipe right in RTL
- Favorite bookmark icon: moves to top-left
- Group headers text aligns right
- Search: cursor starts right for Arabic input

#### Animation Specs

| Animation | Trigger | Duration | Easing | Description |
|-----------|---------|----------|--------|-------------|
| Page enter | Navigation | 300ms | `anim.page.enter` | Slide + fade |
| Tiles entrance | Page settle | 200ms each | `ease-out` | Staggered fade in, 30ms between tiles |
| Filter select | Chip tap | 150ms | `ease-out` | Fill transition |
| Search expand | Search icon tap | 300ms | `ease-out` | Title fades out, text field expands from right |
| Search collapse | Back or clear | 200ms | `ease-out` | Reverse of expand |
| Tile swipe delete | Past 80dp threshold + confirm | 200ms | `ease-out` | Slide out + height collapse |
| Copy feedback | Copy tap | 300ms | `anim.spring` | Check icon bounce, revert 2s |
| Load more spinner | Scroll to bottom | continuous | linear | Small spinner (24dp) at bottom of list |

#### Accessibility

- Screen: "Message History. [count] messages."
- Filter: "Filter messages. All, selected. Favorites. Appreciation. ..." (horizontal list)
- Group header: "February 2026, section"
- Each tile: "Appreciation message. Quote: [preview]. February 14. Rated 4 out of 5 stars. Copy button. Share button."
- Favorited: append "Favorited." to description
- Search: "Search messages, text field."
- Empty: "No messages yet. Create a Message, button."
- Swipe action: long-press menu alternative: "Delete message"

#### Edge Cases

- **1000+ messages:** Paginate: load 20 at a time. Spinner at bottom during load. Scroll performance optimized with item recycling.
- **Search with no results:** "No messages match '[query]'" with clear search button.
- **Deleted message confirmation:** Dialog: "Delete this message? This cannot be undone. [Cancel] [Delete]"
- **Favorited messages filter:** Shows only bookmarked messages. Empty state: "No favorites yet. Bookmark messages you love."
- **Mixed language messages:** Each tile's preview text aligns based on that specific message's language. A list may have mixed LTR and RTL tiles -- this is correct behavior.
- **Read-only detail view (from tap):** Same as Screen 21 but with no Regenerate button and no Generate-related elements. Shows full message, copy, share, rating, bookmark.
- **Offline:** Cached messages shown. Toast: "Offline. Showing saved messages."

---

## CROSS-CUTTING SPECIFICATIONS

---

### Global Navigation Transitions

| Transition | Animation | Duration | Easing |
|-----------|-----------|----------|--------|
| Forward navigation | New page slides in from right (LTR) / left (RTL), old page slides out to left/right | 300ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` |
| Back navigation | Current page slides out to right (LTR) / left (RTL), previous page slides in from left/right | 250ms | `cubic-bezier(0.4, 0.0, 1, 1)` |
| Bottom sheet open | Sheet slides up from bottom, overlay fades in | 300ms | `cubic-bezier(0.0, 0.0, 0.2, 1)` |
| Bottom sheet close | Sheet slides down, overlay fades out | 250ms | `cubic-bezier(0.4, 0.0, 1, 1)` |
| Dialog open | Fade in + scale from 0.95 | 200ms | `ease-out` |
| Dialog close | Fade out + scale to 0.95 | 150ms | `ease-out` |
| Tab switch (bottom nav) | Crossfade content area | 200ms | `ease-out` |
| Pull-to-refresh | Custom LOLO compass spinner rotates | 500ms | `ease-out` |

### Global Toast/Snackbar Spec

- Position: bottom of screen, 16dp above bottom nav (or 16dp from bottom if no nav)
- Width: screen width minus 32dp
- Height: auto (min 48dp)
- Background (dark): `#F0F6FC` (inverted for contrast)
- Background (light): `#1F2328`
- Text color (dark): `#0D1117`
- Text color (light): `#FFFFFF`
- Typography: `body.md`, 14sp, 500
- Border radius: 8px
- Padding: 12dp horizontal, 8dp vertical
- Action button: right-aligned, `brand.primary` (dark mode) or `brand.accent` (light mode)
- Duration: 4000ms default, 6000ms for errors, indefinite for actions requiring user response
- Enter: slide up + fade, 200ms
- Exit: slide down + fade, 200ms
- Max 1 toast visible at a time (new replaces old)

### Global Loading States

**Skeleton Shimmer:**
- Base color (dark): `bg.tertiary` (`#21262D`)
- Base color (light): `bg.tertiary` (`#EAEEF2`)
- Shimmer highlight (dark): `#30363D`
- Shimmer highlight (light): `#F6F8FA`
- Animation: gradient sweep left-to-right (right-to-left RTL), 1500ms, linear, infinite loop
- Shapes match actual content layout (rectangular blocks where text will be, circles where avatars will be)

### Global Error State Pattern

- Centered in content area (below app bar, above bottom nav)
- Icon: `ic_error_cloud.svg` 64x64dp, `text.tertiary`
- Title: varies (e.g. "Something went wrong") -- `heading.sm`, 18sp, `text.primary`
- Subtitle: varies (e.g. "Check your connection and try again") -- `body.md`, 14sp, `text.secondary`
- Retry button: "Try Again" -- secondary outlined button, `brand.primary`
- Spacing: 16dp between elements

### Haptic Feedback Map

| Interaction | Haptic Type |
|------------|-------------|
| Button tap | Light impact |
| Successful action (complete, save) | Medium impact |
| Error/validation failure | Error pattern (3 short buzzes) |
| Slider at 25/50/75 markers | Selection tick |
| Mood selection | Light impact |
| Card swipe past threshold | Medium impact |
| Pull-to-refresh release | Light impact |
| Streak milestone | Success pattern (1 medium + 2 light) |

---

## DOCUMENT END

**Next Steps:**
- Part 2 will cover Modules 6-11 (Screens 23-43)
- Design QA review with development team
- Prototype creation in Figma based on these specifications
- Accessibility audit with screen reader testing

**Version History:**
| Version | Date | Changes |
|---------|------|---------|
| 1.0 | February 14, 2026 | Initial high-fidelity specs for Modules 1-5 |
