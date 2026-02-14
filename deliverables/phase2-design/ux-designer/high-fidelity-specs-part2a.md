# LOLO High-Fidelity Screen Specifications -- Part 2A (Modules 6-8)
### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0
### Status: Developer Handoff Ready

---

## Document Overview

This document provides pixel-perfect, developer-ready specifications for **10 screens** across Modules 6-8. It continues from Part 1 (Screens 1-22) and covers the Gift Recommendation Engine, SOS Mode, and Gamification systems. All spacing values, typography tokens, color references, animation curves, and interaction states are defined.

**Scope:** Screens 23-32 (Gift Recommendation Engine, SOS Mode, Gamification)

**Key Design Decisions Incorporated:**
- SOS Mode: 2-step assessment wizard per PM testing report recommendation R6.3 (reduced from 3 steps)
- SOS Mode: Free for all users at entry + basic coaching per R6.1 (paywall removed from crisis entry)
- SOS Mode: 6 culturally-segmented quick scenarios per R6.2
- SOS button in lower-third thumb zone per R6.5
- All screens follow the 8dp grid, 16dp screen padding, 48dp minimum touch targets established in Part 1

---

## Design System Quick Reference

Refer to Part 1 for the full Design System token tables. The following tokens are **new or emphasized** in Part 2A:

### Additional Gradients (Module-Specific)

| Name | Value | Usage |
|------|-------|-------|
| `gradient.sos.bg` | `linear-gradient(180deg, #F85149 15%, #D29922 100%)` at 15% opacity over `bg.primary` | SOS Mode screen backgrounds |
| `gradient.sos.button` | `linear-gradient(135deg, #F85149, #D29922)` | SOS CTA buttons |
| `gradient.calm` | `linear-gradient(180deg, #3FB950 10%, bg.primary 100%)` | SOS Resolution calming background |
| `gradient.achievement` | `linear-gradient(135deg, #C9A96E, #E8D5A3)` | Badge earn animations, level-up |

### Card Border Variants (SOS Coaching)

| Variant | Border | Width | Side |
|---------|--------|-------|------|
| `card.sayThis` | `status.success` (`#3FB950`) | 4dp | Left (LTR) / Right (RTL) |
| `card.dontSay` | `status.error` (`#F85149`) | 4dp | Left (LTR) / Right (RTL) |
| `card.doThis` | `brand.primary` (`#4A90D9`) | 4dp | Left (LTR) / Right (RTL) |

---

## MODULE 6: GIFT RECOMMENDATION ENGINE

---

### Screen 23: Gift Browse

| Property | Value |
|----------|-------|
| **Screen Name** | Gift Browse |
| **Route** | `/gifts` |
| **Module** | Gift Recommendation Engine (Module 6) |
| **Sprint** | Sprint 4 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| App bar ("Gifts" title) | 56dp | 0dp |
| Search bar row | 48dp | 12dp |
| Category filter chips (horizontal scroll) | 40dp | 12dp |
| "Low Budget High Impact" toggle row | 48dp | 16dp |
| Gift card grid (2-column, infinite scroll) | Flexible | 0dp |
| Bottom nav | 64dp | 0dp |

Screen padding: 16dp horizontal throughout.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| App bar title "Gifts" | 20sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Search bar container | Full width x 48dp | `#21262D` | `#EAEEF2` | -- | Default, Focused (border `#4A90D9`), Filled |
| Search icon | 20x20dp | `#8B949E` | `#656D76` | -- | Static |
| Search placeholder text | 14sp | `#484F58` | `#8C959F` | Inter 400 `body.md` | Placeholder, Active input |
| Category chip (unselected) | Auto-width x 36dp, padding 12dp horiz | bg: `#21262D`, text: `#8B949E` | bg: `#EAEEF2`, text: `#656D76` | Inter 500 `label.sm` 12sp | Default, Selected, Pressed |
| Category chip (selected) | Auto-width x 36dp, padding 12dp horiz | bg: `#4A90D9` at 20%, text: `#4A90D9`, border: 1px `#4A90D9` | bg: `#4A90D9` at 15%, text: `#4A90D9`, border: 1px `#4A90D9` | Inter 500 `label.sm` 12sp | Selected (default chip: "All") |
| "Low Budget High Impact" label | 14sp | `#F0F6FC` | `#1F2328` | Inter 500 `label.md` | Static |
| Toggle switch (off) | 52x32dp | Track: `#30363D`, Thumb: `#8B949E` | Track: `#D0D7DE`, Thumb: `#8C959F` | -- | Off |
| Toggle switch (on) | 52x32dp | Track: `#C9A96E`, Thumb: `#FFFFFF` | Track: `#C9A96E`, Thumb: `#FFFFFF` | -- | On (accent color) |
| Gift card | (screen width - 48dp) / 2 per card, 12dp gap | bg: `#21262D`, border: 1px `#30363D` | bg: `#FFFFFF`, border: 1px `#D0D7DE` | -- | Default, Pressed (scale 0.98), Long-press |
| Card image placeholder | Full card width x 120dp | `#161B22` + category icon centered | `#F6F8FA` + category icon centered | -- | Loading (shimmer), Loaded |
| Card gift name | 14sp, max 2 lines | `#F0F6FC` | `#1F2328` | Inter 600 `body.md` bold | Static |
| Card price range | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |
| Card "Why She'll Love It" | 12sp, max 2 lines, ellipsis | `#484F58` | `#8C959F` | Inter 400 `body.sm` | Static |
| Heart save icon | 24x24dp inside 36x36dp touch | Unsaved: `#484F58`, Saved: `#F85149` | Unsaved: `#8C959F`, Saved: `#CF222E` | -- | Unsaved, Saved (filled), Animating |

**Category Chips:** All, Flowers, Jewelry, Experience, Food, Tech, Handmade. Horizontal scrollable, 8dp gap between chips. Chip border radius: `radius.chip` (16px).

**Card Grid:** 2 columns, 12dp horizontal gap, 12dp vertical gap. Card border radius: `radius.card` (12px). Card padding: 12dp bottom (below image, around text content). Image top corners rounded, bottom corners square (flush with card content area).

**Infinite Scroll:** Loading indicator -- 3-dot pulsing animation centered below last row, 32dp height. Loads next 10 cards per page.

#### RTL Notes
- Category chips scroll direction reverses; rightmost chip is "All" (first item)
- Heart icon position mirrors to top-left of card image
- Search icon moves to right side of search bar; clear (X) button moves to left
- Card text aligns to the right within each card

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Slide in from right (LTR) or left (RTL) |
| Card appear (staggered) | 200ms each | `anim.spring` | Fade in + translate Y 16dp to 0dp, 50ms stagger per card |
| Heart save tap | 300ms | `anim.spring` | Scale 1.0 to 1.3 to 1.0 + color fill transition |
| Toggle switch | 200ms | `ease-out` | Thumb slide + track color transition |
| Chip select | 150ms | `ease-out` | Background color crossfade + content grid reload fade |
| Pull to refresh | 300ms | `anim.normal` | Standard pull-down indicator |

#### Accessibility
- Search bar: `contentDescription` = "Search gifts", keyboard opens on focus, submit action triggers search
- Each gift card is a focusable button with label: "[Gift name], [price range], tap to view details"
- Heart icon toggle: "Save [gift name] to favorites" / "Remove [gift name] from favorites"
- Category chips announced as: "Filter by [category], selected/not selected"

#### Edge Cases
- **No results for search/filter:** Show centered empty state -- illustration (64dp), "No gifts found" (16sp), "Try a different search or category" (14sp secondary). Clear filters button below.
- **Slow network:** Show shimmer placeholder cards (8 cards, same dimensions). Shimmer gradient: `#21262D` to `#30363D` sweeping left-to-right (dark mode).
- **Budget toggle + filter combo yields 0 results:** Show specific message: "No low-budget options in [category]. Try 'All' categories."

---

### Screen 24: Gift Detail

| Property | Value |
|----------|-------|
| **Screen Name** | Gift Detail |
| **Route** | `/gifts/:id` |
| **Module** | Gift Recommendation Engine (Module 6) |
| **Sprint** | Sprint 4 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Hero image (extends under status bar) | 240dp | 0dp |
| Back arrow overlay (on hero) | 48dp touch target, 16dp from top safe area, 16dp from leading edge | -- |
| Content area (scrollable) | Flexible | -- |
| -- Gift name | auto | 8dp |
| -- Price range badge + Category chip row | auto | 16dp |
| -- "Why She'll Love It" AI card | auto | 16dp |
| -- "Based on Her Profile" card | auto | 16dp |
| -- Related gifts horizontal scroll | 180dp | 24dp |
| Action bar (sticky bottom) | 64dp + bottom safe area | 0dp |

Screen padding: 16dp horizontal for content area. No padding on hero image.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Hero image | Full width x 240dp | `#161B22` placeholder | `#F6F8FA` placeholder | -- | Loading (shimmer), Loaded, Error (fallback icon) |
| Back arrow | 24x24dp in 48dp touch target | `#FFFFFF` with 40% black circle bg | `#FFFFFF` with 40% black circle bg | -- | Default, Pressed (opacity 0.7) |
| Gift name | 20sp, max 3 lines | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Price range badge | Auto-width, 28dp height, 8dp horiz padding | bg: `#C9A96E` at 15%, text: `#C9A96E` | bg: `#C9A96E` at 15%, text: `#C9A96E` | Inter 500 `label.sm` 12sp | Static |
| Category chip | Auto-width, 28dp height, 8dp horiz padding | bg: `#21262D`, text: `#8B949E`, border: 1px `#30363D` | bg: `#EAEEF2`, text: `#656D76`, border: 1px `#D0D7DE` | Inter 500 `label.sm` 12sp | Static |
| "Why She'll Love It" header | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` bold | Static |
| AI reasoning card | Full width, auto-height, 16dp padding | bg: `#161B22`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Static |
| AI reasoning text | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Static |
| AI sparkle icon | 16x16dp | `#C9A96E` | `#C9A96E` | -- | Static (next to header) |
| "Based on Her Profile" header | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` bold | Static |
| Profile connection card | Full width, auto-height, 16dp padding | bg: `#161B22`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Static |
| Profile trait tag | Auto-width, 24dp height, 8dp horiz padding | bg: `#4A90D9` at 10%, text: `#4A90D9` | bg: `#4A90D9` at 10%, text: `#4A90D9` | Inter 500 `label.sm` 12sp | Static |
| Related gifts section title | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` bold | Static |
| Related gift card | 140dp wide x 180dp tall | bg: `#21262D`, border: 1px `#30363D` | bg: `#FFFFFF`, border: 1px `#D0D7DE` | -- | Default, Pressed |
| Related card image | 140x100dp | Same as gift card image | Same | -- | Loading, Loaded |
| Related card name | 12sp, 2 lines max | `#F0F6FC` | `#1F2328` | Inter 500 `label.sm` | Static |
| Related card price | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |
| "Buy Now" button | Flexible width, 48dp height | bg: `gradient.premium`, text: `#FFFFFF` | bg: `gradient.premium`, text: `#FFFFFF` | Inter 600 `button` 16sp | Default, Pressed (opacity 0.85), Loading |
| "Save" heart button | 48x48dp | Unsaved: outlined `#8B949E`, Saved: filled `#F85149` | Unsaved: outlined `#656D76`, Saved: filled `#CF222E` | -- | Unsaved, Saved |
| "Not Right" thumbs-down | 48x48dp | `#484F58` | `#8C959F` | -- | Default, Pressed (turns `#F85149`), Confirmed |

**Action Bar:** Sticky bottom. 16dp horizontal padding. Row layout: "Buy Now" (flex 1, leading), 12dp gap, "Save" heart (48dp), 8dp gap, "Not Right" thumbs-down (48dp). Background: `bg.secondary` with top border 1px `border.default`. Elevation: `elevation.2`.

**"Buy Now" behavior:** Opens external URL in in-app browser (Chrome Custom Tab / SFSafariViewController). Icon: external link 16x16dp trailing the text.

**Related gifts scroll:** Horizontal, 12dp gap between cards. Left-aligned (right-aligned in RTL). Peek: next card shows 32dp of its leading edge to indicate scrollability.

#### RTL Notes
- Back arrow flips to right side, icon mirrors to right-pointing arrow
- Price badge and category chip row: badge on right, chip on left
- Profile trait tags flow right-to-left
- Related gifts scroll starts from right edge
- Action bar: "Buy Now" remains in the leading position (right in RTL)

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Shared element transition on hero image from card |
| Content load | 200ms staggered | `anim.fast` | Each content section fades in sequentially, 100ms delay |
| Hero parallax scroll | Continuous | Linear | Image scrolls at 0.5x speed of content, fades to 0 opacity at 240dp scroll |
| Heart save | 300ms | `anim.spring` | Scale bounce 1.0 to 1.3 to 1.0 |
| Thumbs-down confirm | 400ms | `anim.normal` | Icon color transition + subtle shake (2dp horizontal, 2 cycles) |
| Related card press | 100ms | `ease-out` | Scale to 0.97 |

#### Accessibility
- Hero image: `contentDescription` = "[Gift name] image"
- "Buy Now" button: "Buy [gift name], opens external website"
- AI reasoning section: full text readable by screen reader, no truncation
- "Not Right" button: "Mark [gift name] as not suitable, helps improve recommendations"

#### Edge Cases
- **Gift no longer available from API:** Show "This recommendation has expired" banner at top of content area, disable "Buy Now" button (gray out), keep save/not-right functional
- **No partner profile linked:** "Based on Her Profile" section replaced with CTA card: "Add her profile for personalized reasoning" with link to `/profile/her`
- **External link fails:** Show toast "Could not open link. Try again." with retry action

---

### Screen 25: Gift History

| Property | Value |
|----------|-------|
| **Screen Name** | Gift History |
| **Route** | `/gifts/history` |
| **Module** | Gift Recommendation Engine (Module 6) |
| **Sprint** | Sprint 4 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| App bar ("Gift History" + back arrow) | 56dp | 0dp |
| Filter chips row | 40dp | 12dp |
| Gift history list (scrollable) | Flexible | 0dp |
| Bottom nav | 64dp | 0dp |

Screen padding: 16dp horizontal.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| App bar title "Gift History" | 20sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Back arrow | 24x24dp in 48dp touch | `#F0F6FC` | `#1F2328` | -- | Default, Pressed |
| Filter chip "All" | Auto x 36dp | Same as Screen 23 chips | Same | Inter 500 `label.sm` 12sp | Selected (default), Unselected |
| Filter chip "Liked" | Auto x 36dp | Same + success green when selected | Same | Inter 500 `label.sm` 12sp | Selected, Unselected |
| Filter chip "Didn't Like" | Auto x 36dp | Same + error red when selected | Same | Inter 500 `label.sm` 12sp | Selected, Unselected |
| History list item container | Full width x 80dp | bg: `#21262D`, border-bottom: 1px `#30363D` | bg: `#FFFFFF`, border-bottom: 1px `#D0D7DE` | -- | Default, Pressed (bg darkens 5%) |
| Gift name (in list) | 14sp, max 1 line, ellipsis | `#F0F6FC` | `#1F2328` | Inter 500 `label.md` | Static |
| Date text | 12sp | `#484F58` | `#8C959F` | Inter 400 `body.sm` | Static |
| Feedback icon -- liked | 20x20dp | `#3FB950` (heart filled) | `#1A7F37` (heart filled) | -- | Static |
| Feedback icon -- didn't like | 20x20dp | `#F85149` (thumbs down) | `#CF222E` (thumbs down) | -- | Static |
| Feedback icon -- no feedback | 20x20dp | `#484F58` (dash/empty) | `#8C959F` (dash/empty) | -- | Static |
| Learning indicator text | 12sp | `#C9A96E` | `#C9A96E` | Inter 400 `body.sm` italic | Static |
| Empty state illustration | 120x120dp | `#484F58` tinted | `#8C959F` tinted | -- | Static |
| Empty state title | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` | Static |
| Empty state subtitle | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Static |
| Empty state CTA "Browse Gifts" | Auto-width x 48dp, 24dp horiz padding | bg: `#4A90D9`, text: `#FFFFFF` | bg: `#4A90D9`, text: `#FFFFFF` | Inter 600 `button` 16sp | Default, Pressed |

**List Item Layout:** Row -- Leading: category icon (32x32dp in 40dp container, `brand.primary` at 10% bg, 8px radius). Center column: gift name (top), date + learning text (bottom, row). Trailing: feedback icon. Vertical padding: 12dp. Horizontal gap between elements: 12dp.

**Learning indicator text examples:** "AI learned: she prefers experiences", "Noted: avoid tech gifts", "She loved handmade -- more coming!"

**Empty State:** Centered vertically. Illustration above title above subtitle above CTA button. 16dp between each.

#### RTL Notes
- List items mirror: category icon to right, feedback icon to left
- Filter chips scroll direction reverses
- Learning indicator text aligns right with the date text

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Standard page slide |
| List items load | 150ms each | `anim.fast` | Fade in, staggered 50ms |
| Filter chip change | 200ms | `ease-out` | List crossfade with new filtered results |
| Empty state enter | 400ms | `anim.normal` | Fade in + slight scale from 0.95 to 1.0 |
| List item tap | 100ms | `ease-out` | Background darken |

#### Accessibility
- Each list item: "[Gift name], recommended on [date], feedback: [liked/didn't like/none], [learning text]"
- Filter chips: "Show [all/liked/didn't like] gift recommendations, [selected/not selected]"
- Empty state CTA: "Browse gift recommendations"

#### Edge Cases
- **No history at all (new user):** Show empty state with illustration, text "No gifts yet -- check out recommendations!", and "Browse Gifts" button navigating to `/gifts`
- **All items filtered out:** Show inline empty text "No [liked/didn't like] gifts yet" centered in list area, without the full empty state illustration
- **Item with deleted partner profile:** Show gift name normally, omit "Based on" text, show "(Profile removed)" in secondary text

---

## MODULE 7: SOS MODE

**URGENT DESIGN PRINCIPLES:**
- High contrast for readability during emotional distress
- One-hand use optimization -- all interactive elements in bottom 2/3 of screen (thumb zone)
- Minimal cognitive load -- large touch targets, clear language, no ambiguity
- Body text minimum 16sp throughout SOS flow for crisis readability
- No paywall at entry or basic coaching (per PM recommendation R6.1)
- 2-step assessment only (per PM recommendation R6.3)
- No bottom nav in SOS flow -- focus mode

---

### Screen 26: SOS Activation

| Property | Value |
|----------|-------|
| **Screen Name** | SOS Activation |
| **Route** | `/sos` |
| **Module** | SOS Mode (Module 7) |
| **Sprint** | Sprint 5 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| Back arrow row | 48dp (arrow only, leading edge) | 0dp |
| Spacer | Flexible (pushes content to center-lower) | 0dp |
| SOS pulsing circle | 120dp diameter | 24dp |
| "What happened?" label | auto | 16dp |
| Quick scenario chips (2 rows of 3) | auto (~100dp) | Flexible |
| Bottom safe area | 24dp | 0dp |

Screen padding: 16dp horizontal. Background: `bg.primary` overlaid with `gradient.sos.bg` (SOS gradient at 15% opacity). No bottom nav.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Back arrow | 24x24dp in 48dp touch | `#F0F6FC` | `#1F2328` | -- | Default, Pressed |
| SOS pulsing circle | 120dp diameter | bg: `#F85149`, glow: `#F85149` at 30% | bg: `#CF222E`, glow: `#CF222E` at 30% | -- | Pulsing (continuous), Tapped (solid) |
| "SOS" text (in circle) | 32sp | `#FFFFFF` | `#FFFFFF` | Inter 700 `display.lg` | Static |
| "What happened?" label | 18sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.sm` | Static |
| Scenario chip | Auto-width x 48dp, min 100dp wide, 16dp horiz padding | bg: `#21262D`, text: `#F0F6FC`, border: 1px `#30363D` | bg: `#EAEEF2`, text: `#1F2328`, border: 1px `#D0D7DE` | Inter 500 `label.md` 14sp | Default, Pressed (bg: `#F85149` at 15%, border: `#F85149`), Selected |

**SOS Circle:** Centered horizontally. Positioned in the lower-center of the screen (thumb zone, approximately 40% from bottom). Circle has 3 layers: solid core (120dp), glow ring 1 (140dp, 20% opacity), glow ring 2 (160dp, 10% opacity). Pulsing animation: glow rings scale from 1.0 to 1.15 and back, 1.5s interval, infinite loop.

**Quick Scenario Chips (6 total):**

| # | Label | API Value |
|---|-------|-----------|
| 1 | She's angry | `she_is_angry` |
| 2 | She's crying | `she_is_crying` |
| 3 | Big fight | `caught_in_lie` |
| 4 | Said wrong thing | `said_wrong_thing` |
| 5 | Forgot something | `forgot_important_date` |
| 6 | Other | `other` |

Chips arranged in 2 rows of 3. Centered horizontally. 8dp horizontal gap, 8dp vertical gap between rows. Each chip has border radius: `radius.chip` (16px).

**Tap Behavior:** Tapping a scenario chip immediately fires `POST /sos/activate` with the selected scenario and urgency `happening_now`, then navigates to `/sos/assess`. Tapping the SOS circle without selecting a scenario navigates to `/sos/assess` with scenario `other`.

#### RTL Notes
- Back arrow moves to top-right, icon flips to right-pointing arrow
- Scenario chip grid mirrors: first chip starts from right in each row
- "What happened?" label remains centered, unaffected by direction

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 200ms | `anim.fast` | Fast fade-in (no slide -- urgency) |
| SOS circle pulse | 1500ms per cycle | `cubic-bezier(0.4, 0.0, 0.6, 1.0)` | Glow rings scale 1.0 to 1.15 to 1.0, infinite loop |
| SOS circle glow | Continuous | Sine wave | Opacity oscillates between 20% and 40% on outer ring |
| Chip appear | 150ms each | `anim.fast` | Fade in, staggered 30ms per chip from center outward |
| Chip press | 100ms | `ease-out` | Scale to 0.95 + bg color change |
| Chip selected | 200ms | `ease-out` | Bg fills with `#F85149` at 15%, border transitions to `#F85149` |
| Page exit (to assess) | 200ms | `ease-out` | Crossfade (no slide -- speed) |

#### Accessibility
- SOS circle: `role=button`, `contentDescription` = "SOS emergency help. Tap to get immediate relationship advice."
- Each scenario chip: "Select scenario: [chip text]"
- Screen reader announcement on entry: "SOS Mode activated. Select what happened or tap the SOS button for help."
- All text minimum 14sp (chips) to 32sp (SOS text) -- exceeds WCAG AA large text requirements

#### Edge Cases
- **Monthly SOS limit reached (free tier):** Show a gentle overlay: "You've used your free SOS sessions this month. Upgrade for more." with "Upgrade" and "Close" buttons. Never fully block -- show the overlay but allow dismissal (per R6.1, basic help should still be provided; the overlay is informational only)
- **No internet connection:** Cache the SOS activation screen locally. On chip tap, show toast "No connection. Basic tips available offline" and display hardcoded offline advice cards
- **Accidental activation:** Back arrow at top allows immediate exit. No data is sent until a scenario chip is tapped or the SOS circle is tapped

---

### Screen 27: SOS Assessment

| Property | Value |
|----------|-------|
| **Screen Name** | SOS Assessment |
| **Route** | `/sos/assess` |
| **Module** | SOS Mode (Module 7) |
| **Sprint** | Sprint 5 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| Back arrow row | 48dp | 0dp |
| Progress dots (2 dots) | 12dp | 24dp |
| Step title | auto | 24dp |
| Step content area | Flexible | 24dp |
| "Get Help" button | 56dp | 24dp + bottom safe area |

Screen padding: 24dp horizontal (slightly wider than standard for breathing room during crisis). Background: `bg.primary` with subtle `gradient.sos.bg` at 8% opacity. No bottom nav.

#### Step 1: "How bad is it?"

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Progress dot (active) | 8dp diameter | `#F85149` | `#CF222E` | -- | Active |
| Progress dot (inactive) | 8dp diameter | `#30363D` | `#D0D7DE` | -- | Inactive |
| Step title "How bad is it?" | 24sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.lg` | Static |
| Emoji face button | 64x64dp touch target | bg: `#21262D`, border: 2px `#30363D` | bg: `#EAEEF2`, border: 2px `#D0D7DE` | -- | Default, Selected (border: `#F85149`, bg: `#F85149` at 15%), Pressed |
| Emoji label below | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |

**Emoji Row:** 5 faces in a horizontal row, centered. Each 64dp wide with 12dp gap between. Total width: 5*64 + 4*12 = 368dp.

| Position | Emoji | Label | Severity Value |
|----------|-------|-------|----------------|
| 1 (leftmost) | Neutral face | "Minor" | 1 |
| 2 | Slightly worried | "Tense" | 2 |
| 3 | Worried | "Upset" | 3 |
| 4 | Very worried | "Bad" | 4 |
| 5 (rightmost) | Distressed | "Crisis" | 5 |

Emoji rendering: Custom vector icons (not system emoji) for cross-platform consistency. Asset names: `ic_severity_1.svg` through `ic_severity_5.svg`. Each 32x32dp centered within the 64dp touch target.

**On selection:** The selected emoji scales up to 1.15x and the border highlights. The label below changes to the primary text color. User can change selection freely before continuing.

#### Step 2: "What do you need?"

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Step title "What do you need?" | 24sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.lg` | Static |
| Option card | Full width x 72dp | bg: `#21262D`, border: 1px `#30363D` | bg: `#EAEEF2`, border: 1px `#D0D7DE` | -- | Default, Selected (border: 2px `#4A90D9`, bg: `#4A90D9` at 10%), Pressed |
| Option icon | 28x28dp | `#4A90D9` | `#4A90D9` | -- | Static |
| Option title | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` bold | Static |
| Option subtitle | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |

**3 Option Cards:**

| # | Icon | Title | Subtitle | API mapping |
|---|------|-------|----------|-------------|
| 1 | `ic_chat_quote.svg` | "What to say right now" | "Get exact phrases to use" | Coaching mode: `say` |
| 2 | `ic_action_hand.svg` | "What to do" | "Step-by-step actions" | Coaching mode: `do` |
| 3 | `ic_brain_lightbulb.svg` | "Help me understand" | "Why she feels this way" | Coaching mode: `understand` |

Cards stacked vertically with 12dp gap. Each card has border radius: `radius.card` (12px). Card padding: 16dp all sides. Layout: Row -- icon left, text column right (12dp gap).

#### "Get Help" Button

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Get Help" button | Full width x 56dp | bg: `gradient.sos.button`, text: `#FFFFFF` | bg: `gradient.sos.button`, text: `#FFFFFF` | Inter 700 `button` 16sp | Disabled (opacity 0.4, no selection made), Enabled, Pressed (opacity 0.85), Loading (spinner replaces text) |

Border radius: `radius.button` (24px). Disabled until both steps are completed.

**Navigation:** Step 1 -> Step 2 is an inline transition (content swaps within the same screen). The "Get Help" button appears on Step 2 only. Step 1 advances automatically when an emoji is tapped (with 300ms delay for visual feedback). User can go back to Step 1 by tapping the first progress dot or swiping right (left in RTL).

#### RTL Notes
- Emoji row order does not change (severity always reads left-to-right, lowest to highest, as a universal scale)
- Option cards: icon moves to right, text aligns right
- Swipe-to-go-back reverses direction (swipe left to return to Step 1)

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 200ms | `anim.fast` | Fast fade-in |
| Emoji select | 200ms | `anim.spring` | Selected emoji scales to 1.15, border highlights |
| Step transition (1 to 2) | 300ms | `anim.normal` | Step 1 slides out left, Step 2 slides in from right (reverses in RTL) |
| Step transition (2 to 1) | 250ms | `anim.normal` | Reverse of above |
| Option card select | 150ms | `ease-out` | Border + bg color transition |
| "Get Help" enable | 200ms | `ease-out` | Opacity 0.4 to 1.0 |
| "Get Help" loading | Continuous | Linear | Circular spinner 20dp white, replaces button text |

#### Accessibility
- Screen reader on entry: "SOS Assessment. Step 1 of 2. How bad is it? Select a severity level."
- Each emoji: "Severity level [number]: [label]. [Selected/Not selected]"
- Each option card: "[Title]. [Subtitle]. [Selected/Not selected]"
- "Get Help" disabled state: "Get Help button, disabled. Complete both steps first."
- Step transition announced: "Step 2 of 2. What do you need?"

#### Edge Cases
- **Back navigation from Step 1:** Returns to `/sos` activation screen. Active session is preserved server-side.
- **Network failure on "Get Help":** Show inline error below button: "Connection failed. Tap to retry." Do not navigate away. Preserve selections.
- **Screen width < 360dp:** Emoji faces reduce to 56dp touch targets with 8dp gap. Still exceeds 48dp minimum.

---

### Screen 28: SOS Coaching

| Property | Value |
|----------|-------|
| **Screen Name** | SOS Coaching |
| **Route** | `/sos/coach` |
| **Module** | SOS Mode (Module 7) |
| **Sprint** | Sprint 5 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| Coaching header bar (session timer right, step counter left) | 48dp | 0dp |
| Coaching cards (scrollable chat-like area) | Flexible | 0dp |
| Input area ("Tell me more...") | 56dp + bottom safe area | 0dp |

Screen padding: 16dp horizontal. Background: `bg.primary`. No bottom nav.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Step counter | 14sp | `#F0F6FC` | `#1F2328` | Inter 500 `label.md` | Static ("Step X of Y") |
| Session timer | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Updating every second |
| "Say This" card | Full width, auto-height, 16dp padding | bg: `#21262D`, left border: 4dp `#3FB950` | bg: `#F6F8FA`, left border: 4dp `#1A7F37` | -- | Default, Copied (brief flash) |
| "Say This" label | 12sp | `#3FB950` | `#1A7F37` | Inter 600 `label.sm` uppercase | Static |
| "Say This" text | 16sp | `#F0F6FC` | `#1F2328` | Inter 400 `body.lg` | Streaming (typing), Complete |
| Copy button (in "Say This") | 24x24dp in 40dp touch | `#8B949E` | `#656D76` | -- | Default, Tapped (check icon, `#3FB950`) |
| "Don't Say This" card | Full width, auto-height, 16dp padding | bg: `#21262D`, left border: 4dp `#F85149` | bg: `#F6F8FA`, left border: 4dp `#CF222E` | -- | Default |
| "Don't Say This" label | 12sp | `#F85149` | `#CF222E` | Inter 600 `label.sm` uppercase | Static |
| "Don't Say This" text | 16sp, strikethrough | `#8B949E` (muted with strikethrough) | `#656D76` (muted with strikethrough) | Inter 400 `body.lg` strikethrough | Static |
| Warning icon (in "Don't Say") | 16x16dp | `#F85149` | `#CF222E` | -- | Static (leading each "don't say" line) |
| "Do This" card | Full width, auto-height, 16dp padding | bg: `#21262D`, left border: 4dp `#4A90D9` | bg: `#F6F8FA`, left border: 4dp `#4A90D9` | -- | Default |
| "Do This" label | 12sp | `#4A90D9` | `#4A90D9` | Inter 600 `label.sm` uppercase | Static |
| "Do This" text | 16sp | `#F0F6FC` | `#1F2328` | Inter 400 `body.lg` | Streaming, Complete |
| Body language tip | 14sp | `#C9A96E` | `#C9A96E` | Inter 500 `body.md` italic | Static |
| Input field container | Full width x 56dp | bg: `#161B22`, border: 1px `#30363D` | bg: `#EAEEF2`, border: 1px `#D0D7DE` | -- | Default, Focused (border: `#4A90D9`), Typing |
| Input placeholder | 16sp | `#484F58` | `#8C959F` | Inter 400 `body.lg` | Placeholder |
| Send button (in input) | 40x40dp | bg: `gradient.sos.button` (enabled) or `#30363D` (disabled) | Same gradient / `#D0D7DE` | -- | Disabled (no text), Enabled, Pressed |

**Card Layout:** Cards appear in a chat-like vertical flow. Each card has border radius: `radius.card` (12px). 12dp vertical gap between cards. Cards are NOT full screen-edge to screen-edge -- they have 16dp padding from screen edges. The left accent border is inside the card's left edge (or right edge in RTL).

**SSE Streaming Behavior:**
- `event: coaching_start` -- Show typing indicator (3 dots animation)
- `event: say_this` -- "Say This" card appears, text streams in character by character
- `event: do_not_say` -- "Don't Say This" card appears after "Say This" completes
- `event: body_language` -- Body language tip appears as an inline callout
- `event: coaching_complete` -- Input field enables, "What happened next?" prompt appears

**Streaming text appearance:** Characters appear at approximately 30ms intervals. Text uses `body.lg` (16sp minimum) for crisis readability.

**Copy Button:** Inside "Say This" cards only. Tapping copies the full phrase text to clipboard. Icon transitions from copy to checkmark for 2 seconds, then reverts.

**Session Timer:** Format "MM:SS" (e.g., "03:24"). Starts at 00:00 when coaching screen loads. Subtle, secondary text color -- informational only, not anxiety-inducing.

#### RTL Notes
- All card accent borders flip from left to right
- Copy button moves from trailing (right in LTR) to trailing (left in RTL) within the card
- Session timer stays in the trailing position (left in RTL)
- Step counter moves to the leading position (right in RTL)
- Input field send button remains at the trailing edge
- Warning icons in "Don't Say" cards move to the leading side of text (right in RTL)

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 200ms | `anim.fast` | Fast fade-in |
| Typing indicator | 800ms loop | `ease-in-out` | 3 dots pulse sequentially, 200ms each |
| Card appear | 300ms | `anim.spring` | Fade in + translate Y from 16dp to 0dp |
| Text streaming | ~30ms/char | Linear | Characters appear sequentially, cursor blink at end |
| Copy button confirm | 200ms | `anim.fast` | Icon crossfade: copy to checkmark |
| Copy revert | 200ms | `anim.fast` | Icon crossfade: checkmark to copy (after 2s delay) |
| Input send | 150ms | `ease-out` | Send button scale 1.0 to 0.9 to 1.0 |
| New coaching step | 400ms | `anim.normal` | Previous cards scroll up, new cards stream in below |

#### Accessibility
- "Say This" cards: "Suggestion: [text]. Double-tap to copy to clipboard."
- "Don't Say This" cards: "Warning, do not say: [text]"
- "Do This" cards: "Action to take: [text]"
- Session timer: `liveRegion=polite`, announced every 60 seconds: "Session time: [X] minutes"
- During streaming: `liveRegion=assertive` for each new card completion

#### Edge Cases
- **SSE connection drops mid-stream:** Show "Connection lost. Reconnecting..." banner at top. Auto-retry 3 times at 2s intervals. If all fail: "Connection lost. Last advice shown above. Tap to retry."
- **User sends follow-up before streaming completes:** Queue the message. Display it immediately in the chat flow. Process after current stream completes.
- **Very long coaching text (>500 chars in a single card):** Card expands to fit. No truncation ever in SOS coaching -- all text must be visible. Scrollable content area handles overflow.

---

### Screen 29: SOS Resolution

| Property | Value |
|----------|-------|
| **Screen Name** | SOS Resolution |
| **Route** | `/sos/resolve` |
| **Module** | SOS Mode (Module 7) |
| **Sprint** | Sprint 5 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| Spacer | 16dp | 0dp |
| Header "How did it go?" | auto | 24dp |
| Outcome options (5 stacked cards) | auto (~400dp) | 24dp |
| Follow-up actions section | auto | 16dp |
| "Save to History" toggle row | 48dp | 16dp |
| "Done" button | 56dp | 24dp + bottom safe area |

Screen padding: 16dp horizontal. Background: `bg.primary` with `gradient.calm` (success green at 10% from top). No bottom nav.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Header "How did it go?" | 24sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.lg` | Static |
| Outcome card | Full width x 64dp, 16dp padding | bg: `#21262D`, border: 1px `#30363D` | bg: `#EAEEF2`, border: 1px `#D0D7DE` | -- | Default, Selected (border: 2px color-specific, bg: color at 10%), Pressed |
| Outcome icon | 24x24dp | Color-specific (see below) | Color-specific | -- | Static |
| Outcome text | 16sp | `#F0F6FC` | `#1F2328` | Inter 500 `body.lg` | Static |
| Safety referral card | Full width, auto-height, 16dp padding | bg: `#F85149` at 10%, border: 2px `#F85149` | bg: `#CF222E` at 10%, border: 2px `#CF222E` | -- | Visible only when "Need professional help" selected |
| Safety card title | 16sp | `#F85149` | `#CF222E` | Inter 600 `body.lg` bold | Static |
| Safety card helpline text | 14sp | `#F0F6FC` | `#1F2328` | Inter 400 `body.md` | Static |
| Safety card phone link | 14sp underlined | `#4A90D9` | `#4A90D9` | Inter 500 `body.md` | Tappable (opens dialer) |
| Follow-up section title | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` bold | Static |
| Follow-up action card | Full width x 72dp, 16dp padding | bg: `#161B22`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Default, Pressed |
| Follow-up action icon | 24x24dp | `#4A90D9` | `#4A90D9` | -- | Static |
| Follow-up action text | 14sp | `#F0F6FC` | `#1F2328` | Inter 500 `label.md` | Static |
| Follow-up time label | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |
| "Save to History" label | 14sp | `#F0F6FC` | `#1F2328` | Inter 500 `label.md` | Static |
| Toggle (save to history) | 52x32dp | Same as Screen 23 toggle but uses `brand.primary` | Same | -- | On (default), Off |
| "Done" button | Full width x 56dp | bg: `#4A90D9`, text: `#FFFFFF` | bg: `#4A90D9`, text: `#FFFFFF` | Inter 600 `button` 16sp | Disabled (no outcome selected, opacity 0.4), Enabled, Pressed, Loading |

**5 Outcome Options:**

| # | Icon | Text | Selected Border Color | API Value |
|---|------|------|-----------------------|-----------|
| 1 | Checkmark circle | Fully resolved | `#3FB950` | `resolved_well` |
| 2 | Trending up | Getting better | `#3FB950` at 70% | `partially_resolved` |
| 3 | Minus circle | Still tense | `#D29922` | `still_ongoing` |
| 4 | Trending down | Got worse | `#F85149` | `got_worse` |
| 5 | Heart + phone | Need professional help | `#F85149` | `abandoned` (triggers safety card) |

Cards stacked vertically with 8dp gap. Border radius: `radius.card` (12px). Layout: Row -- icon leading, text center, radio indicator trailing.

**Safety Referral Card (appears when option 5 is selected):**
- Appears with slide-down animation below the outcome options
- Contains: "It's okay to ask for help" title, brief supportive text, and helpline numbers
- Helplines: localized based on user region (default: international crisis lines)
- Phone numbers are tappable and open the device dialer
- This card does NOT disappear if user changes selection -- it remains visible once triggered during the session

**Follow-Up Actions (3 AI-generated suggestion cards):**
- Example: "Send her a 'thinking of you' text in 2 hours", "Plan a quiet evening together tonight", "Write down what you learned"
- Each card: icon + text + time label. Tappable -- tapping creates a reminder in the Reminders module.
- 8dp gap between cards. Border radius: `radius.card` (12px).

**"Done" Button:** On tap, calls `POST /sos/resolve` with selected outcome and optional follow-up data. On success, navigates to dashboard (`/`). Save toggle state determines if session is recorded in SOS history.

#### RTL Notes
- Outcome cards mirror: icon to right, radio indicator to left
- Safety card content aligns right; phone numbers remain LTR (universal telephone format)
- Follow-up action cards mirror: icon to right, time label to left
- Toggle switch position mirrors to left of label

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.normal` | Fade in with calming green gradient |
| Outcome cards load | 200ms each | `anim.fast` | Staggered fade-in, 50ms delay per card |
| Outcome select | 200ms | `ease-out` | Border + bg color transition, subtle scale 1.02 |
| Safety card appear | 400ms | `anim.sheet.enter` | Slide down + fade in from 0 height |
| Follow-up cards load | 200ms each | `anim.fast` | Staggered fade-in after outcome selected |
| "Done" button enable | 200ms | `ease-out` | Opacity 0.4 to 1.0 |
| Page exit | 300ms | `anim.page.exit` | Fade out to dashboard |

#### Accessibility
- Each outcome: "[Outcome text], option [number] of 5, [selected/not selected]"
- Safety card: `liveRegion=assertive`, "Professional help resources available. Helpline numbers listed."
- Phone numbers: "Call [helpline name] at [number]"
- "Done" button disabled state: "Done button, disabled. Select an outcome first."
- Follow-up actions: "Suggested action: [text]. Tap to create a reminder."

#### Edge Cases
- **"Need professional help" + "Done":** Before navigating away, show a confirmation: "Are you sure you want to leave? Helpline numbers are also in Settings > Safety Resources." Two buttons: "Stay" and "I'm okay, continue."
- **Network failure on resolve:** Save outcome locally, sync when connection restores. Show toast "Saved offline. Will sync when connected." Navigate to dashboard normally.
- **Session expired (>2 hours):** API may return 404. Handle gracefully: save locally, show toast "Session timed out, saved locally." Navigate to dashboard.

---

## MODULE 8: GAMIFICATION

---

### Screen 30: Progress Dashboard

| Property | Value |
|----------|-------|
| **Screen Name** | Progress Dashboard |
| **Route** | `/gamification` |
| **Module** | Gamification (Module 8) |
| **Sprint** | Sprint 6 |

#### Layout Structure (top to bottom, scrollable)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| App bar ("My Progress") | 56dp | 0dp |
| Level hero card | 120dp | 16dp |
| Streak section | 96dp | 16dp |
| Relationship Consistency Score | 160dp | 16dp |
| Stats row (3 mini cards) | 88dp | 16dp |
| "View Badges" tile | 64dp | 16dp |
| Bottom nav | 64dp | 0dp |

Screen padding: 16dp horizontal.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| App bar title "My Progress" | 20sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Level hero card | Full width x 120dp, 16dp padding | bg: `gradient.premium` | bg: `gradient.premium` | -- | Static |
| Level badge (circle) | 64dp diameter | bg: `#FFFFFF` at 20%, border: 2px `#C9A96E` | bg: `#FFFFFF` at 40%, border: 2px `#C9A96E` | -- | Static |
| Level number (in badge) | 24sp | `#FFFFFF` | `#FFFFFF` | Inter 700 `heading.lg` | Static |
| Level name | 18sp | `#FFFFFF` | `#FFFFFF` | Inter 600 `heading.sm` | Static |
| XP progress bar | (card width - 64dp badge - 48dp padding) x 8dp | Track: `#FFFFFF` at 20%, Fill: `#C9A96E` | Track: `#FFFFFF` at 30%, Fill: `#C9A96E` | -- | Animating on load |
| XP text | 12sp | `#FFFFFF` at 80% | `#FFFFFF` at 80% | Inter 400 `body.sm` | Static ("X / Y XP to next level") |
| Streak section card | Full width x 96dp, 16dp padding | bg: `#21262D` | bg: `#F6F8FA` | -- | Static |
| Flame icon (Rive anim) | 32x32dp | Animated (orange/red) | Animated (orange/red) | -- | Animating (continuous) |
| Streak count | 28sp | `#F0F6FC` | `#1F2328` | Inter 700 `display.md` | Static |
| "days" label | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Static |
| Mini calendar dot (active) | 8dp diameter | `#3FB950` | `#1A7F37` | -- | Active day |
| Mini calendar dot (missed) | 8dp diameter | `#484F58` | `#D0D7DE` | -- | Missed day |
| Mini calendar dot (today) | 8dp diameter + 2dp ring | `#3FB950` + ring `#3FB950` at 30% | `#1A7F37` + ring `#1A7F37` at 30% | -- | Today (pulsing) |
| Mini calendar day label | 10sp | `#484F58` | `#8C959F` | Inter 400 | Static (Mon, Tue, etc.) |
| Consistency gauge (circular) | 120dp diameter | Track: `#30363D`, Arc: `gradient.premium` | Track: `#D0D7DE`, Arc: `gradient.premium` | -- | Animating on load |
| Consistency score number | 32sp (centered in gauge) | `#F0F6FC` | `#1F2328` | Inter 700 `display.lg` | Static |
| "/100" label | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Static |
| Trend arrow (up) | 16x16dp | `#3FB950` | `#1A7F37` | -- | Up trend |
| Trend arrow (down) | 16x16dp | `#F85149` | `#CF222E` | -- | Down trend |
| "vs last week" text | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |
| Stats mini card | (screen width - 48dp) / 3, 88dp height | bg: `#21262D`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Static |
| Stats card number | 20sp | `#F0F6FC` | `#1F2328` | Inter 700 `heading.md` | Static |
| Stats card label | 10sp, 2 lines max | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |
| Stats card icon | 20x20dp | `#4A90D9` | `#4A90D9` | -- | Static |
| "View Badges" tile | Full width x 64dp, 16dp padding | bg: `#21262D`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Default, Pressed (bg darkens 5%) |
| "View Badges" text | 16sp | `#F0F6FC` | `#1F2328` | Inter 500 `body.lg` | Static |
| "View Badges" chevron | 20x20dp | `#484F58` | `#8C959F` | -- | Static |
| Badge count label | 12sp | `#C9A96E` | `#C9A96E` | Inter 500 `label.sm` | Static ("X earned") |

**Level Hero Card Layout:** Row. Leading: Level badge circle (centered vertically). Trailing column: Level name (top), XP progress bar (middle), XP text (bottom). The card uses `gradient.premium` background with rounded corners `radius.card` (12px).

**Streak Section Layout:** Row. Leading: Flame icon (Rive animation -- animated fire that responds to streak length, more intense for longer streaks). Center column: Streak count (top, large), "days" label (bottom). Trailing: Mini calendar -- 7 dots in a row, each with a day label below. 12dp gap between dots. Card border radius: `radius.card` (12px).

**Consistency Gauge Layout:** Centered. Circular gauge with score inside. Trend arrow and "vs last week" text below the gauge, horizontally centered. The gauge arc starts at 7 o'clock position and sweeps clockwise to 5 o'clock (270-degree max arc). Card border radius: `radius.card` (12px). Full width card with 16dp padding.

**Stats Row:** 3 equal-width mini cards with 8dp gap between. Each card: icon top-center, number center, label bottom-center. 12dp internal padding. Border radius: `radius.card` (12px).

| Card | Icon | Label |
|------|------|-------|
| 1 | `ic_check_circle.svg` | Actions completed |
| 2 | `ic_message.svg` | Messages sent |
| 3 | `ic_gift.svg` | Gifts given |

All stats show "this month" data.

#### RTL Notes
- Level hero card: Badge circle moves to right, text column aligns right
- Streak section: Flame icon to right, mini calendar order reverses (Sunday rightmost = start of week in Arabic locale)
- "View Badges" tile: chevron flips to left-pointing, text aligns right
- Stats row order mirrors: rightmost card is "Actions completed" (first)

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Standard page transition |
| XP bar fill | 800ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` | Animates from 0% to actual percentage on first load |
| Consistency gauge fill | 1000ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` | Arc sweeps from 0 to score value |
| Flame Rive animation | Continuous | -- | Rive state machine: idle (1-7 days), medium (8-14), intense (15-30), legendary (30+) |
| Today dot pulse | 1500ms loop | `ease-in-out` | Ring opacity oscillates 30% to 60% |
| Stats numbers count up | 600ms | `ease-out` | Number counts from 0 to actual value |
| Level-up celebration | 2000ms | Custom | Confetti particles + badge scale bounce + gradient flash (shown when levelUp=true in API response) |
| Pull to refresh | 300ms | `anim.normal` | Standard pull-down refresh |

#### Accessibility
- Level card: "Level [number], [level name]. [current] of [total] XP to next level. Progress: [percentage]%."
- Streak: "[count] day streak. Last 7 days: [Monday active, Tuesday active, Wednesday missed...]"
- Consistency gauge: "Relationship Consistency Score: [score] out of 100. [Trend direction] compared to last week."
- Stats: "[number] actions completed this month. [number] messages sent. [number] gifts given."
- "View Badges" tile: "View Badges, [count] earned. Button."

#### Edge Cases
- **New user (no data):** XP bar at 0%, streak count 0, consistency score shows "--" with "Complete your first action to start tracking". Stats show 0 for all.
- **Streak broken today:** Show streak at 0 with a brief empathetic message: "Streaks restart -- today is a fresh start!" in `text.secondary` below the streak count. Flame icon shows extinguished state (gray, no animation).
- **Level-up occurs while viewing:** If a push notification or websocket event signals level-up, trigger the celebration animation immediately. Card content updates in place.

---

### Screen 31: Badges Gallery

| Property | Value |
|----------|-------|
| **Screen Name** | Badges Gallery |
| **Route** | `/gamification/badges` |
| **Module** | Gamification (Module 8) |
| **Sprint** | Sprint 6 |

#### Layout Structure (top to bottom)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| App bar ("Badges" + back arrow) | 56dp | 0dp |
| Category tab bar | 48dp | 12dp |
| Badge grid (3-column, scrollable) | Flexible | 0dp |
| Bottom nav | 64dp | 0dp |

Screen padding: 16dp horizontal.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| App bar title "Badges" | 20sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Back arrow | 24x24dp in 48dp touch | `#F0F6FC` | `#1F2328` | -- | Default, Pressed |
| Tab (unselected) | Auto-width x 48dp, 16dp horiz padding | text: `#8B949E`, no indicator | text: `#656D76`, no indicator | Inter 500 `label.md` 14sp | Unselected |
| Tab (selected) | Auto-width x 48dp, 16dp horiz padding | text: `#F0F6FC`, indicator: 3dp `#4A90D9` bottom | text: `#1F2328`, indicator: 3dp `#4A90D9` bottom | Inter 600 `label.md` 14sp | Selected |
| Badge cell (earned) | (screen width - 48dp) / 3, square aspect | -- | -- | -- | Default, Pressed (scale 0.95) |
| Badge icon (earned) | 56dp diameter | Full color, border: 2px `#C9A96E` | Full color, border: 2px `#C9A96E` | -- | Static, New (glowing) |
| Badge name (earned) | 12sp, 2 lines max, center | `#F0F6FC` | `#1F2328` | Inter 500 `label.sm` | Static |
| Badge cell (locked) | Same | -- | -- | -- | Default, Pressed |
| Badge icon (locked) | 56dp diameter | Grayscale, opacity 40%, lock overlay 20x20dp | Grayscale, opacity 50%, lock overlay 20x20dp | -- | Static |
| Badge name (locked) | 12sp, 2 lines max, center | `#484F58` | `#8C959F` | Inter 500 `label.sm` | Static |
| Lock overlay icon | 20x20dp | `#8B949E` | `#656D76` | -- | Static (centered on badge) |
| Badge count text | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Static ("[earned]/[total] earned") |

**Category Tabs:** Scrollable tab bar. Tabs: All, Consistency, Milestones, Mastery, Special. 8dp gap between tabs. Selected tab has 3dp bottom indicator in `brand.primary`. Horizontally scrollable if tabs exceed screen width.

**Badge Grid:** 3 columns, 12dp horizontal gap, 16dp vertical gap. Each cell is square (width = height). Badge icon centered in the upper portion (with 8dp top padding), name below (with 4dp gap). Cell has no explicit background or border -- the badge icon itself is the visual anchor.

**Earned badges sort first, then locked badges. Within earned, most recent first. Within locked, closest to completion first.**

**Newly Earned Badge Glow:** Badges earned within the last 24 hours have a `gradient.achievement` animated glow ring behind them. Ring: 64dp diameter, opacity oscillates 40% to 70%, 2s cycle.

#### Badge Detail Bottom Sheet (on tap)

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Sheet handle | 40x4dp, centered | `#484F58` | `#D0D7DE` | -- | Static |
| Badge icon (large) | 80dp diameter | Full color (earned) or grayscale (locked) | Same | -- | Static |
| Badge name | 20sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Badge rarity label | 12sp | Rarity color (see below) | Same | Inter 500 `label.sm` uppercase | Static |
| Description text | 14sp | `#8B949E` | `#656D76` | Inter 400 `body.md` | Static |
| "How to earn" text | 14sp | `#F0F6FC` | `#1F2328` | Inter 500 `body.md` | Static |
| Progress bar (locked) | Full sheet width - 48dp, 8dp height | Track: `#30363D`, Fill: `#4A90D9` | Track: `#D0D7DE`, Fill: `#4A90D9` | -- | Animating (if partially complete) |
| Progress text | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static ("X/Y completed") |
| "Earned on" date (earned) | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |

**Rarity Colors:**

| Rarity | Color |
|--------|-------|
| Common | `#8B949E` |
| Uncommon | `#3FB950` |
| Rare | `#4A90D9` |
| Epic | `#A371F7` |
| Legendary | `#C9A96E` |

**Bottom Sheet:** Max height 60% of screen. Border radius: `radius.sheet` (16px top corners). Background: `bg.secondary`. Padding: 24dp horizontal, 16dp top (above handle), 24dp bottom. Dismissible by swipe-down or tap outside.

#### RTL Notes
- Badge grid order mirrors: first badge starts from top-right
- Tab bar scroll starts from right; selected indicator position auto-mirrors
- Bottom sheet content text aligns right; badge icon remains centered

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Standard page slide |
| Badges load (staggered) | 150ms each | `anim.spring` | Fade in + scale from 0.8 to 1.0, 30ms stagger |
| New badge glow | 2000ms loop | `ease-in-out` | Achievement gradient glow ring oscillates 40%-70% opacity |
| Tab switch | 200ms | `ease-out` | Grid crossfade + indicator slide |
| Badge tap | 100ms | `ease-out` | Badge scale 0.95 |
| Bottom sheet open | 300ms | `anim.sheet.enter` | Slide up from bottom with backdrop fade |
| Bottom sheet dismiss | 250ms | `anim.sheet.exit` | Slide down + backdrop fade out |
| Progress bar fill (in sheet) | 600ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` | Animates from 0 to progress value |

#### Accessibility
- Each badge cell: "[Badge name], [earned/locked], [rarity] rarity. Tap for details."
- New badge glow: screen reader ignores animation, announces "New! [Badge name] earned [time ago]"
- Bottom sheet: focus trap when open, "Badge details. [Name]. [Description]. [How to earn / Earned on date]"
- Progress bar in sheet: "[X] of [Y] completed. [percentage]% progress."
- Tab bar: "Badge categories. [Category name] tab, [selected/not selected]"

#### Edge Cases
- **No badges earned yet:** All badges in "All" tab show as locked. A motivational banner at top: "Complete your first action to start earning badges!" with CTA to dashboard.
- **Badge earned while on this screen:** If push event arrives, animate the specific badge from locked to earned (grayscale to color transition, 800ms, confetti burst behind badge).
- **Very many badges (>30):** Grid handles via standard scroll. No pagination needed since badge count is bounded by design.

---

### Screen 32: Stats & Trends

| Property | Value |
|----------|-------|
| **Screen Name** | Stats & Trends |
| **Route** | `/gamification/stats` |
| **Module** | Gamification (Module 8) |
| **Sprint** | Sprint 6 |

#### Layout Structure (top to bottom, scrollable)

| Section | Height | Spacing After |
|---------|--------|---------------|
| Status bar | 24dp (system) | 0dp |
| App bar ("Stats & Trends" + back arrow) | 56dp | 0dp |
| Period toggle chips | 40dp | 16dp |
| Line chart (actions over time) | 200dp | 16dp |
| Category breakdown (bar chart) | 160dp | 16dp |
| "Personal Best" cards row | 120dp | 16dp |
| AI improvement tip card | auto | 16dp |
| Bottom nav | 64dp | 0dp |

Screen padding: 16dp horizontal.

#### Component Table

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| App bar title "Stats & Trends" | 20sp | `#F0F6FC` | `#1F2328` | Inter 600 `heading.md` | Static |
| Back arrow | 24x24dp in 48dp touch | `#F0F6FC` | `#1F2328` | -- | Default, Pressed |
| Period chip (unselected) | Auto x 36dp, 12dp horiz padding | bg: `#21262D`, text: `#8B949E` | bg: `#EAEEF2`, text: `#656D76` | Inter 500 `label.sm` 12sp | Unselected |
| Period chip (selected) | Auto x 36dp, 12dp horiz padding | bg: `#4A90D9` at 20%, text: `#4A90D9`, border: 1px `#4A90D9` | bg: `#4A90D9` at 15%, text: `#4A90D9`, border: 1px `#4A90D9` | Inter 500 `label.sm` 12sp | Selected |
| Line chart container | Full width x 200dp | bg: `#21262D`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Default, Touch (tooltip) |
| Chart line | 2dp stroke | `#4A90D9` | `#4A90D9` | -- | Static |
| Chart area fill | Under line | `#4A90D9` at 10% | `#4A90D9` at 8% | -- | Static |
| Chart milestone dot | 8dp diameter | `#C9A96E` | `#C9A96E` | -- | Default, Tapped (tooltip) |
| Chart axis labels | 10sp | `#484F58` | `#8C959F` | Inter 400 | Static |
| Chart grid lines | 1dp | `#30363D` at 50% | `#D0D7DE` at 50% | -- | Static |
| Chart tooltip | Auto-width x 32dp, 8dp padding | bg: `#F0F6FC`, text: `#0D1117` | bg: `#1F2328`, text: `#FFFFFF` | Inter 500 `label.sm` 12sp | Visible on touch |
| Bar chart container | Full width x 160dp, 16dp padding | bg: `#21262D`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Static |
| Bar chart section title | 16sp | `#F0F6FC` | `#1F2328` | Inter 600 `body.lg` bold | Static |
| Horizontal bar (SAY) | Variable width x 24dp | `#4A90D9` | `#4A90D9` | -- | Static |
| Horizontal bar (DO) | Variable width x 24dp | `#3FB950` | `#1A7F37` | -- | Static |
| Horizontal bar (BUY) | Variable width x 24dp | `#C9A96E` | `#C9A96E` | -- | Static |
| Horizontal bar (GO) | Variable width x 24dp | `#A371F7` | `#8250DF` | -- | Static |
| Bar label | 12sp | `#F0F6FC` | `#1F2328` | Inter 500 `label.sm` | Static (category name left of bar) |
| Bar percentage | 12sp | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static (right of bar) |
| "Personal Best" card | (screen width - 40dp) / 3, 120dp height | bg: `#21262D`, border: 1px `#30363D` | bg: `#F6F8FA`, border: 1px `#D0D7DE` | -- | Static |
| Personal best icon | 24x24dp | `#C9A96E` | `#C9A96E` | -- | Static |
| Personal best value | 20sp | `#F0F6FC` | `#1F2328` | Inter 700 `heading.md` | Static |
| Personal best label | 10sp, 2 lines | `#8B949E` | `#656D76` | Inter 400 `body.sm` | Static |
| AI tip card | Full width, auto-height, 16dp padding | bg: `gradient.card.subtle`, border: 1px `#C9A96E` at 30% | bg: `#F6F8FA`, border: 1px `#C9A96E` at 30% | -- | Default, Dismissed |
| AI tip sparkle icon | 16x16dp | `#C9A96E` | `#C9A96E` | -- | Static |
| AI tip title | 14sp | `#C9A96E` | `#C9A96E` | Inter 600 `label.md` | Static ("AI Insight") |
| AI tip text | 14sp | `#F0F6FC` | `#1F2328` | Inter 400 `body.md` | Static |
| AI tip dismiss (X) | 20x20dp in 36dp touch | `#484F58` | `#8C959F` | -- | Default, Pressed |

**Period Toggle Chips:** Week (default), Month, All Time. Horizontal row, centered. 8dp gap. Chip border radius: `radius.chip` (16px).

**Line Chart:**
- X-axis: dates (7 ticks for week, ~4 ticks for month, monthly ticks for all-time)
- Y-axis: action count (0 to max + 10% headroom)
- Line: smooth curve (cubic bezier interpolation between points)
- Milestone dots: accent color (`#C9A96E`), placed at dates where a badge was earned
- Touch interaction: drag finger across chart to see tooltip at each data point
- Chart card border radius: `radius.card` (12px). Internal padding: 16dp.

**Category Breakdown:**
- 4 horizontal bars representing SAY, DO, BUY, GO action categories
- Each bar width = (category percentage / 100) * available width
- Labels left of bars (40dp width), percentages right of bars
- Bars have rounded end caps (4px radius)
- 8dp vertical gap between bars
- Section title "Action Breakdown" above chart

**Personal Best Cards (3):**

| Card | Icon | Label | Value Example |
|------|------|-------|---------------|
| 1 | `ic_fire.svg` | Highest streak | "21 days" |
| 2 | `ic_trophy.svg` | Most active week | "Mar 3-9" |
| 3 | `ic_star.svg` | Favorite action | "SAY" |

Cards in horizontal row with 8dp gap. Each card: icon top-center, value center, label bottom-center. Border radius: `radius.card` (12px).

**AI Tip Card:** Bottom of screen. Accent border on left (4dp, `#C9A96E`). Sparkle icon + "AI Insight" title row at top. Tip text below. Dismiss X in top-right corner. Example tip: "You're strongest in SAY actions but haven't tried a GO action this week. Plan a date night to balance your approach!" Card border radius: `radius.card` (12px).

#### RTL Notes
- Period chips remain in natural order (Week, Month, All Time) as these are temporal, not directional
- Line chart X-axis does NOT mirror (time always flows left-to-right)
- Category breakdown: labels move to right of bars, percentages to left
- Personal best cards row mirrors: first card starts from right
- AI tip card: accent border moves to right side, dismiss X moves to top-left

#### Animation Table

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Standard page slide |
| Line chart draw | 1000ms | `cubic-bezier(0.4, 0.0, 0.2, 1)` | Line draws from left to right (like a pen stroke) |
| Chart milestone dots | 200ms each | `anim.spring` | Pop-in scale from 0 to 1, after line reaches dot position |
| Bar chart fill | 600ms staggered | `cubic-bezier(0.4, 0.0, 0.2, 1)` | Each bar grows from 0 width, 100ms stagger |
| Period chip switch | 200ms | `ease-out` | Chip color transition + chart crossfade |
| Chart data transition | 400ms | `anim.normal` | Old data fades out, new data draws in |
| Personal best count-up | 600ms | `ease-out` | Values count from 0 to actual |
| AI tip card entrance | 300ms | `anim.spring` | Slide up from below + fade in (last element) |
| AI tip dismiss | 200ms | `ease-out` | Fade out + slide down |
| Tooltip appear | 100ms | `ease-out` | Fade in at touch position |

#### Accessibility
- Line chart: provide textual alternative: "Actions over [period]: [day 1]: [count], [day 2]: [count]..." as a collapsible screen reader section
- Bar chart: "[SAY]: [percentage]%. [DO]: [percentage]%. [BUY]: [percentage]%. [GO]: [percentage]%."
- Each personal best card: "[Label]: [value]"
- Period chips: "View stats for [period], [selected/not selected]"
- AI tip: "AI Insight: [tip text]. Dismiss button."

#### Edge Cases
- **No data for selected period:** Charts show empty state -- flat line at 0, bars at 0%. Message: "No activity for this period. Start by completing an action today!"
- **All Time with >1 year of data:** Line chart aggregates to weekly data points. X-axis shows month labels. Performance optimized -- max 52 rendered points.
- **AI tip API fails:** Card does not render (no error shown). The rest of the screen functions normally. Retry silently on next screen visit.

---

## Cross-Module Notes

### Navigation Between Modules

| From | To | Trigger | Transition |
|------|-----|---------|------------|
| Dashboard | `/gifts` | Bottom nav "Gifts" tab or gift card tap | Standard page enter |
| Dashboard | `/sos` | SOS FAB button (if implemented) or nav item | Fast fade (200ms, urgency) |
| Dashboard | `/gamification` | Bottom nav "Progress" tab or level card tap | Standard page enter |
| `/gifts` | `/gifts/:id` | Gift card tap | Shared element (card image to hero) |
| `/gifts` | `/gifts/history` | App bar history icon | Standard page enter |
| `/sos` | `/sos/assess` | Scenario chip tap or SOS circle tap | Crossfade (200ms) |
| `/sos/assess` | `/sos/coach` | "Get Help" button | Crossfade (200ms) |
| `/sos/coach` | `/sos/resolve` | Last coaching step complete | Crossfade (300ms, calming) |
| `/sos/resolve` | `/` (dashboard) | "Done" button | Fade out (300ms) |
| `/gamification` | `/gamification/badges` | "View Badges" tile | Standard page enter |
| `/gamification` | `/gamification/stats` | Stats card tap or nav element | Standard page enter |

### SOS Mode System-Level Behavior

- **No bottom navigation** throughout the SOS flow (Screens 26-29). This is intentional focus mode.
- **Screen lock prevention:** While in SOS coaching (Screen 28), request `WAKE_LOCK` to prevent screen dimming.
- **Do Not Disturb:** Optionally suggest DND mode activation on SOS entry (non-blocking prompt).
- **Back button behavior:** Physical/gesture back always goes to the previous SOS step, never exits to dashboard mid-session. On Screen 26, back exits SOS entirely.
- **Session timeout:** SOS sessions expire after 2 hours server-side. Client shows warning at 1h45m: "Session expiring soon. Wrap up or start a new session."

### Offline Behavior Summary

| Screen | Offline Capability |
|--------|-------------------|
| Gift Browse | Cached results only, search disabled, "Offline -- showing saved gifts" banner |
| Gift Detail | Cached detail if previously viewed, otherwise "Not available offline" |
| Gift History | Full offline (cached list) |
| SOS Activation | Available offline with hardcoded basic tips |
| SOS Assessment | Available offline (selections saved locally) |
| SOS Coaching | Degraded -- show cached generic advice cards, no SSE streaming |
| SOS Resolution | Available offline (syncs on reconnect) |
| Progress Dashboard | Cached data from last sync, "Last updated [time]" label |
| Badges Gallery | Cached badge list, bottom sheet works offline |
| Stats & Trends | Cached charts, period toggle may show stale data with indicator |

---

*End of Part 2A. Screens 23-32 complete. Next: Part 2B covers Modules 9-10+ if applicable.*
