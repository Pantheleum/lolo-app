# LOLO High-Fidelity Screen Specifications -- Part 2B (Modules 9-10, Settings, Supplementary)
### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0
### Status: Developer Handoff Ready

---

## Document Overview

This document provides pixel-perfect, developer-ready specifications for **11 screens** across Modules 9-10 (Smart Action Cards, Memory Vault), the Settings Module, and Supplementary screens. It follows the same token system, structure, and conventions established in Part 1.

**Scope:** Screens 33-43 (Action Cards, Memory Vault, Settings, Paywall, Empty States)

**Prerequisite:** Read the Design System Quick Reference in `high-fidelity-specs-part1.md` for full token definitions. Key tokens are referenced inline below.

---

## MODULE 9: SMART ACTION CARDS

---

### Screen 33: Action Card Feed

| Property | Value |
|----------|-------|
| **Screen Name** | Action Card Feed |
| **Route** | `/action-cards` |
| **Module** | Smart Action Cards |
| **Sprint** | Sprint 3 (S3-05) |

#### Layout Description

Full-screen card stack with bottom navigation visible. A swipeable card is centered in the viewport with a subtle "peek" of the next card behind it (offset 8dp down, scaled to 0.95, 50% opacity). The top bar contains the card counter. Three action buttons sit below the card. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp
- Top bar: 48dp height -- counter text centered
- Spacer: 16dp
- Card stack area: flexible height, centered, minimum 320dp
- Spacer: 24dp
- Action button row: 56dp height, centered horizontally
- Spacer: 24dp
- Bottom navigation: 64dp

#### Component Breakdown

**1. Card Counter**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Counter text "3 of 8 cards today" | -- | `#8B949E` | `#656D76` | `body.sm` -- Inter 400, 12sp/16sp | Static; updates on swipe |

**2. Action Card (Primary -- visible)**
- Width: screen width minus 32dp (16dp padding each side)
- Height: auto, minimum 320dp, maximum 400dp
- Background (dark): `#21262D`
- Background (light): `#EAEEF2`
- Border radius: `radius.card` (12px)
- Elevation: `elevation.2`
- Padding: 20dp all sides
- Layout: vertical stack

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Type badge (SAY) | auto width, 24dp height, 8dp horizontal padding | bg: `#4A90D9` at 15%, text: `#4A90D9` | bg: `#4A90D9` at 10%, text: `#4A90D9` | `label.sm` -- Inter 500, 12sp | SAY=blue, DO=green, BUY=gold, GO=purple |
| Type badge (DO) | same | bg: `#3FB950` at 15%, text: `#3FB950` | bg: `#1A7F37` at 10%, text: `#1A7F37` | same | -- |
| Type badge (BUY) | same | bg: `#C9A96E` at 15%, text: `#C9A96E` | bg: `#C9A96E` at 10%, text: `#956D2E` | same | -- |
| Type badge (GO) | same | bg: `#8957E5` at 15%, text: `#8957E5` | bg: `#8957E5` at 10%, text: `#6E40C9` | same | -- |
| Title | -- | `#F0F6FC` | `#1F2328` | `heading.sm` -- Inter 600, 18sp/24sp | Single line, ellipsize end |
| Body text | -- | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp/20sp | Max 4 lines, ellipsize end |
| Context line | -- | `#484F58` | `#8C959F` | `body.sm` -- Inter 400, 12sp/16sp | e.g. "Based on her Pisces profile" |
| Difficulty dots (1-3) | 8dp each, 4dp gap | filled: `#C9A96E`, empty: `#30363D` | filled: `#C9A96E`, empty: `#D0D7DE` | -- | 1=easy, 2=medium, 3=hard |

**Card internal spacing:**
- Type badge: top-left, 0dp from card padding edge
- Title: 12dp below badge
- Body: 8dp below title
- Context line: 12dp below body
- Difficulty dots: bottom-right corner of card, 0dp from padding edge

**3. Peek Card (Behind)**
- Same dimensions as primary card
- Offset: 8dp lower, centered horizontally
- Scale: 0.95
- Opacity: 0.5
- No interaction; purely visual depth cue

**4. Action Buttons Row**
- Centered horizontally with 24dp gaps between buttons

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Skip button (X icon) | 48x48dp circle | bg: `#21262D`, icon: `#8B949E` 24dp | bg: `#EAEEF2`, icon: `#656D76` 24dp | -- | Pressed: scale 0.9, bg darken 10% |
| Save button (bookmark icon) | 48x48dp circle | bg: transparent, border: 1.5px `#C9A96E`, icon: `#C9A96E` 24dp | bg: transparent, border: 1.5px `#C9A96E`, icon: `#C9A96E` 24dp | -- | Pressed: scale 0.9, fill `#C9A96E` at 15% |
| Complete button (check icon) | 56x56dp circle | bg: `#4A90D9`, icon: `#FFFFFF` 28dp | bg: `#4A90D9`, icon: `#FFFFFF` 28dp | -- | Pressed: scale 0.9, bg: `#3A7BC8` |

**5. Swipe Gestures**
- Swipe right threshold: 120dp horizontal displacement
- Swipe left threshold: 120dp horizontal displacement
- Pull down threshold: 80dp vertical displacement
- During drag: card follows finger with rotation (max 15deg), opacity overlay appears (green for right, red for left, gold for down)
- Snap-back animation if threshold not met: `anim.spring` 400ms

**6. XP Toast (on Complete)**
- Position: top center, 80dp from top
- Size: auto width, 40dp height, 16dp horizontal padding
- Background: `#3FB950` at 90%
- Text: "+15 XP" -- `label.md` Inter 500, 14sp, `#FFFFFF`
- Border radius: 20px
- Duration: appears for 2000ms, then fades out 300ms

**7. Empty State**
- Illustration: 120dp centered, muted compass icon with checkmark
- Title: "You're all caught up!" -- `heading.sm` Inter 600, 18sp, `text.primary`
- Subtitle: "Come back tomorrow for fresh suggestions" -- `body.md` Inter 400, 14sp, `text.secondary`
- Streak display below: current streak number + flame icon, `heading.lg` Inter 600, 24sp, `#C9A96E`

#### RTL Notes

- Card content alignment flips: type badge top-right, difficulty dots bottom-left
- Swipe directions remain the same (right=complete, left=skip) -- gesture meaning is universal
- Context line text aligns right; Arabic font `Cairo` for title, `Noto Naskh Arabic` for body

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Card entrance (initial) | 300ms | `anim.spring` | Scale from 0.8 to 1.0 + fade in |
| Swipe right (complete) | 300ms | `anim.normal` | Card flies right off-screen with 15deg rotation; peek card scales up to 1.0 and moves to primary position |
| Swipe left (skip) | 300ms | `anim.normal` | Card flies left off-screen with -15deg rotation; peek card transitions in |
| Pull down (save) | 400ms | `anim.spring` | Card shrinks to 0.6 scale and fades into bookmark icon; gold pulse on save button |
| Snap-back (threshold not met) | 400ms | `anim.spring` | Card returns to center with spring overshoot |
| XP toast | 300ms in, 300ms out | `ease-out` | Slide down from -20dp + fade in; fade out after 2s |
| Empty state | 500ms | `anim.slow` | Staggered fade-in: illustration (0ms), title (150ms), subtitle (300ms), streak (450ms) |

#### Accessibility

- Each card is announced: "[Type] card. [Title]. [Body text]. Difficulty [N] of 3. Swipe right to complete, left to skip, down to save. Or use buttons below."
- Action buttons labeled: "Skip card", "Save card for later", "Mark card complete"
- Reduce Motion: disable swipe physics, use simple fade transitions for card changes

#### Edge Cases

- **No cards generated yet:** Show loading skeleton (3 pulsing rectangle placeholders) for up to 5 seconds, then error state if API fails
- **Single card remaining:** Hide peek card; show "Last card today!" badge above counter
- **Offline:** Show cached cards (if any) with "Offline -- showing saved cards" banner; disable Complete action (requires sync)

---

### Screen 34: Action Card Detail

| Property | Value |
|----------|-------|
| **Screen Name** | Action Card Detail |
| **Route** | `/action-cards/:id` |
| **Module** | Smart Action Cards |
| **Sprint** | Sprint 3 (S3-05) |

#### Layout Description

Full-screen scrollable detail view. Top app bar with back arrow and type badge. Content flows vertically: title, instruction text, expandable sections, action row. Related cards carousel at bottom. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- back arrow (left), type badge (right of center), overflow menu (right)
- Spacer: 24dp
- Category chip: inline
- Spacer: 8dp
- Title: full width minus 32dp padding
- Spacer: 16dp
- Main instruction text: full width minus 32dp
- Spacer: 24dp
- "Why This Matters" expandable section
- Spacer: 16dp
- "Pro Tip" card
- Spacer: 16dp
- Zodiac context section (conditional)
- Spacer: 32dp
- Action row: 4 buttons
- Spacer: 24dp
- Divider: 1px `border.default`
- Spacer: 16dp
- "Related Cards" header + horizontal scroll
- Spacer: 24dp + bottom safe area

#### Component Breakdown

**1. App Bar**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Back arrow | 24dp icon, 48dp touch | `#F0F6FC` | `#1F2328` | -- | Pressed: opacity 0.6 |
| Type badge | auto width, 28dp height | Same as Screen 33 badge colors | Same | `label.sm` 12sp | Static |
| Overflow menu (3 dots) | 24dp icon, 48dp touch | `#8B949E` | `#656D76` | -- | Pressed: opacity 0.6 |

**2. Category Chip**
- Height: 28dp, horizontal padding: 12dp
- Background (dark): `#21262D`, text: `#8B949E`
- Background (light): `#EAEEF2`, text: `#656D76`
- Font: `label.sm` Inter 500, 12sp
- Border radius: `radius.chip` (16px)
- Example values: "Communication", "Romance", "Quality Time", "Gifts", "Support"

**3. Title**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Card title | -- | `#F0F6FC` | `#1F2328` | `heading.md` -- Inter 600, 22sp/28sp | Multi-line allowed |

**4. Main Instruction Text**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Instruction body | -- | `#8B949E` | `#656D76` | `body.lg` -- Inter 400, 16sp/25.6sp (1.6 line height) | Full text, no truncation |

**5. "Why This Matters" Expandable Section**
- Container: full width minus 32dp
- Header row: 48dp height, tap target full width
- Collapsed: header + chevron-down icon
- Expanded: header + chevron-up icon + content area

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Section header "Why This Matters" | -- | `#F0F6FC` | `#1F2328` | `label.lg` -- Inter 500, 16sp | Collapsed/Expanded |
| Chevron icon | 20dp | `#484F58` | `#8C959F` | -- | Rotates 180deg on expand |
| Section content (AI explanation) | -- | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp/20sp | Fade-in on expand |

**6. "Pro Tip" Card**
- Width: full width minus 32dp
- Background (dark): `#161B22`
- Background (light): `#F6F8FA`
- Left border: 3dp solid `#C9A96E`
- Border radius: `radius.input` (8px)
- Padding: 16dp

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Pro Tip" label | -- | `#C9A96E` | `#C9A96E` | `label.sm` -- Inter 500, 12sp | Static |
| Tip content | -- | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp/20sp | Static |

**7. Zodiac Context (conditional -- shown only if zodiac data available)**
- Width: full width minus 32dp
- Background (dark): `#161B22`
- Background (light): `#F6F8FA`
- Border: 1px `border.default`
- Border radius: `radius.card` (12px)
- Padding: 16dp

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Zodiac icon | 24dp | `#8957E5` | `#6E40C9` | -- | Static |
| "For a [Sign] partner, consider..." | -- | `#8B949E` | `#656D76` | `body.md` 14sp, italic | Static |

**8. Action Row**
- Full width minus 32dp, 4 buttons evenly distributed

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Complete button | 48dp circle | bg: `#4A90D9`, icon: `#FFF` 24dp | same | -- | Pressed: scale 0.9 |
| Skip button | 48dp circle | bg: `#21262D`, icon: `#8B949E` 24dp | bg: `#EAEEF2`, icon: `#656D76` | -- | Pressed: scale 0.9 |
| Save button | 48dp circle | border: 1.5px `#C9A96E`, icon: `#C9A96E` 24dp | same | -- | Pressed: fill 15% |
| Share button | 48dp circle | border: 1.5px `#30363D`, icon: `#8B949E` 24dp | border: 1.5px `#D0D7DE`, icon: `#656D76` | -- | Pressed: fill 10% |

**9. Related Cards Carousel**
- Section header: "Related Cards" -- `label.lg` Inter 500, 16sp, `text.primary`
- Horizontal scroll, peek next card by 32dp
- Each mini-card: 200dp wide, 120dp tall, 12px radius, `elevation.1`
- Mini-card content: type badge (small), title (14sp bold, 2 lines max), difficulty dots

#### RTL Notes

- Back arrow flips to right side; overflow menu moves to left
- Pro Tip left border becomes right border
- Related cards carousel scrolls from right-to-left; peek is on the left

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Shared element transition from card in feed; card expands to full screen |
| "Why This Matters" expand | 300ms | `anim.normal` | Chevron rotates 180deg; content height animates from 0 to auto with fade-in |
| "Why This Matters" collapse | 250ms | `anim.normal` | Reverse of expand |
| Action button tap | 200ms | `anim.fast` | Scale 1.0 to 0.9 to 1.0 spring; icon color flash |
| Related card scroll | -- | -- | Momentum-based scroll with snap-to-card behavior |
| Screen exit (back) | 250ms | `anim.page.exit` | Shared element transition back to card stack |

#### Accessibility

- Full card content read as single group: "Action card detail. Type: [TYPE]. Category: [CATEGORY]. [Title]. [Full instruction text]."
- Expandable section announced: "Why This Matters, collapsed, double tap to expand"
- Action buttons individually labeled: "Complete action", "Skip action", "Save for later", "Share action card"

#### Edge Cases

- **Very long instruction text (>500 chars):** Scrollable content area; no truncation on detail view
- **No zodiac data (partner zodiac not set):** Hide zodiac context section entirely; no empty placeholder
- **Card already completed:** Show "Completed" state -- action row replaced with checkmark + "Completed on [date]" text in `status.success` color

---

## MODULE 10: MEMORY VAULT

---

### Screen 35: Memory Vault Home

| Property | Value |
|----------|-------|
| **Screen Name** | Memory Vault Home |
| **Route** | `/memories` |
| **Module** | Memory Vault |
| **Sprint** | Sprint 3 (S3-10) |

#### Layout Description

Screen with top app bar ("Memory Vault" title), search bar, view toggle (segmented control), and content area that switches between Timeline and Categories views. FAB in bottom-right. Bottom navigation visible.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- "Memory Vault" title left-aligned
- Spacer: 8dp
- Search bar: full width minus 32dp, 44dp height
- Spacer: 12dp
- Segmented control: 2 segments, full width minus 32dp, 40dp height
- Spacer: 16dp
- Content area: flexible, scrollable
- Bottom navigation: 64dp
- FAB: 56dp, floating 16dp from right edge, 16dp above bottom nav

#### Component Breakdown

**1. App Bar**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Title "Memory Vault" | -- | `#F0F6FC` | `#1F2328` | `heading.lg` -- Inter 600, 24sp/32sp | Static |

**2. Search Bar**
- Width: screen width minus 32dp
- Height: 44dp
- Background (dark): `#21262D`
- Background (light): `#EAEEF2`
- Border: 1px `border.default`
- Border radius: `radius.input` (8px)
- Padding: 12dp horizontal

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Search icon | 20dp | `#484F58` | `#8C959F` | -- | Static |
| Placeholder "Search memories..." | -- | `#484F58` | `#8C959F` | `body.md` -- Inter 400, 14sp | Disappears on focus |
| Input text | -- | `#F0F6FC` | `#1F2328` | `body.md` -- Inter 400, 14sp | Active typing |
| Clear (X) icon | 20dp, 44dp touch | `#8B949E` | `#656D76` | -- | Visible when text entered |

**Search states:**

| State | Background | Border | Other |
|-------|-----------|--------|-------|
| Default | `bg.tertiary` | 1px `border.default` | Placeholder visible |
| Focused | `bg.tertiary` | 1.5px `brand.primary` | Cursor blinking |
| Filled | `bg.tertiary` | 1px `border.default` | Clear icon visible |

**3. Segmented Control**
- Width: screen width minus 32dp
- Height: 40dp
- Background (dark): `#161B22`
- Background (light): `#F6F8FA`
- Border radius: `radius.input` (8px)
- Two segments: "Timeline" and "Categories"

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Active segment | 50% width, 36dp height (2dp inset) | bg: `#21262D`, text: `#F0F6FC` | bg: `#FFFFFF`, text: `#1F2328` | `label.md` -- Inter 500, 14sp | Shadow `elevation.1` |
| Inactive segment | 50% width | bg: transparent, text: `#8B949E` | bg: transparent, text: `#656D76` | `label.md` -- Inter 500, 14sp | Pressed: text opacity 0.7 |

**4. Timeline View**
- Vertical timeline line: 2dp wide, `border.default` color, 16dp from left edge
- Date markers: 12dp circle on the line, filled `brand.primary`
- Memory cards: offset 40dp from left edge, full width minus 56dp (40dp left + 16dp right padding)

**Memory Card (Timeline):**
- Background (dark): `#21262D`
- Background (light): `#EAEEF2`
- Border radius: `radius.card` (12px)
- Padding: 12dp
- Elevation: `elevation.1`
- Layout: Row -- content left, photo thumbnail right (if attached)

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Memory title | -- | `#F0F6FC` | `#1F2328` | `label.md` -- Inter 500, 14sp | Single line, ellipsize |
| Preview text | -- | `#8B949E` | `#656D76` | `body.sm` -- Inter 400, 12sp/16sp | Max 2 lines |
| Date | -- | `#484F58` | `#8C959F` | `body.sm` -- Inter 400, 12sp | Static |
| Category chip | auto width, 22dp height, 8dp h-padding | bg: varies by category, text: matching | same | `label.sm` 10sp | Static |
| Photo thumbnail | 48dp circle, 4px border radius 50% | border: 1px `border.default` | same | -- | Placeholder: camera icon |

**Category chip colors:**

| Category | Dark bg | Dark text | Light bg | Light text |
|----------|---------|-----------|----------|------------|
| Stories | `#4A90D9` at 15% | `#4A90D9` | `#4A90D9` at 10% | `#4A90D9` |
| Inside Jokes | `#3FB950` at 15% | `#3FB950` | `#1A7F37` at 10% | `#1A7F37` |
| Wishes | `#C9A96E` at 15% | `#C9A96E` | `#C9A96E` at 10% | `#956D2E` |
| Milestones | `#8957E5` at 15% | `#8957E5` | `#8957E5` at 10% | `#6E40C9` |

**Date marker on timeline:**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Date circle | 12dp | `#4A90D9` | `#4A90D9` | -- | Static |
| Date label | -- | `#8B949E` | `#656D76` | `label.sm` 12sp, Inter 500 | e.g. "Feb 10" |

**5. Categories View**
- 2x2 grid, 12dp gap
- Each category card: (screen width minus 32dp - 12dp gap) / 2 wide, 120dp tall

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Category card bg | calculated | `#21262D` | `#EAEEF2` | -- | Pressed: scale 0.97, `anim.instant` |
| Category icon | 32dp, centered above text | category color (see chip table) | same | -- | Static |
| Category name | -- | `#F0F6FC` | `#1F2328` | `label.md` -- Inter 500, 14sp | Centered |
| Count badge | 20dp circle, top-right of card, -4dp offset | bg: `brand.primary`, text: `#FFF` | same | `label.sm` 10sp, bold | Hidden if count=0 |

Card border radius: `radius.card` (12px). Elevation: `elevation.1`.

**6. FAB (Add Memory)**
- Size: 56dp circle
- Background: `#4A90D9`
- Icon: "+" 28dp, `#FFFFFF`
- Elevation: `elevation.3`
- Position: 16dp from right edge, 16dp above bottom nav top edge

| State | Background | Shadow | Other |
|-------|-----------|--------|-------|
| Default | `#4A90D9` | `elevation.3` | -- |
| Pressed | `#3A7BC8` | `elevation.2` | Scale 0.95 |
| Extended (optional on scroll up) | Pill shape, 48dp height, auto width | `elevation.3` | Shows "+ Add Memory" text |

#### RTL Notes

- Timeline line moves to 16dp from right edge; memory cards offset from right
- Search icon moves to right side of search bar; clear icon to left
- FAB moves to bottom-left corner (16dp from left edge)

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Slide in from right |
| View toggle (Timeline to Categories) | 300ms | `anim.normal` | Cross-fade between views |
| Memory card appear (staggered) | 200ms each | `anim.fast` | Fade in + translate Y 16dp; stagger 50ms |
| FAB press | 100ms | `ease-out` | Scale to 0.95 |
| Search expand | 200ms | `anim.fast` | Search bar height grows if needed; keyboard slides up |
| Pull-to-refresh | 500ms | `anim.slow` | Spinner at top, cards fade out and back in |

#### Accessibility

- Segmented control: "View mode. Timeline selected. Double tap to switch to Categories."
- Each memory card: "[Title]. [Category]. [Date]. [Preview text]. Double tap to open."
- FAB: "Add new memory, button"

#### Edge Cases

- **No memories yet:** Show empty state (see Screen 43 pattern) -- "Start capturing moments" with CTA "Add First Memory"
- **Search yields no results:** "No memories match '[query]'" with suggestion to adjust search terms
- **100+ memories:** Lazy-load with pagination (20 per page); timeline shows year separators for older entries

---

### Screen 36: Add Memory

| Property | Value |
|----------|-------|
| **Screen Name** | Add Memory |
| **Route** | `/memories/new` |
| **Module** | Memory Vault |
| **Sprint** | Sprint 3 (S3-10) |

#### Layout Description

Full-screen form with top app bar (close X, "New Memory" title, Save button). Scrollable form body. All inputs stacked vertically. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- close X (left), "New Memory" (center), "Save" text button (right)
- Spacer: 16dp
- Title input
- Spacer: 16dp
- Category picker (4 chips)
- Spacer: 16dp
- Date picker row
- Spacer: 16dp
- Content text area
- Spacer: 16dp
- Photo attachment section
- Spacer: 16dp
- Tags chip input
- Spacer: 16dp
- "She Said" toggle row
- Spacer: 32dp
- Save button (full width)
- Spacer: 24dp + bottom safe area

#### Component Breakdown

**1. App Bar**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Close X icon | 24dp, 48dp touch | `#8B949E` | `#656D76` | -- | Pressed: opacity 0.6 |
| Title "New Memory" | -- | `#F0F6FC` | `#1F2328` | `heading.sm` -- Inter 600, 18sp | Static |
| "Save" text button | 48dp touch | `#4A90D9` | `#4A90D9` | `button` -- Inter 600, 16sp | Disabled: opacity 0.4 (when title empty) |

**2. Title Input**
- Width: screen width minus 32dp
- Height: 48dp
- Background (dark): `#161B22`
- Background (light): `#F6F8FA`
- Border: 1px `border.default`; focused: 1.5px `brand.primary`
- Border radius: `radius.input` (8px)
- Padding: 12dp horizontal

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Placeholder "Give this memory a title" | -- | `#484F58` | `#8C959F` | `body.lg` -- Inter 400, 16sp | Hidden on focus with text |
| Input text | -- | `#F0F6FC` | `#1F2328` | `body.lg` -- Inter 400, 16sp | Typing |
| Character count (optional) | -- | `#484F58` | `#8C959F` | `body.sm` 12sp | Max 80 chars |

**3. Category Picker**
- Label: "Category" -- `label.md` Inter 500, 14sp, `text.primary`
- Spacer: 8dp below label
- 4 chips in a horizontal wrap row, 8dp gap

| Element | Size | Color (Dark) Selected | Color (Dark) Unselected | Color (Light) Selected | Color (Light) Unselected | Font |
|---------|------|----------------------|------------------------|----------------------|------------------------|------|
| Stories chip | auto, 36dp h, 16dp h-pad | bg: `#4A90D9`, text: `#FFF` | bg: `#21262D`, text: `#8B949E`, border: 1px `#30363D` | bg: `#4A90D9`, text: `#FFF` | bg: `#EAEEF2`, text: `#656D76`, border: 1px `#D0D7DE` | `label.md` 14sp |
| Inside Jokes chip | same | bg: `#3FB950`, text: `#FFF` | same as above | bg: `#1A7F37`, text: `#FFF` | same | same |
| Wishes chip | same | bg: `#C9A96E`, text: `#FFF` | same | bg: `#C9A96E`, text: `#FFF` | same | same |
| Milestones chip | same | bg: `#8957E5`, text: `#FFF` | same | bg: `#6E40C9`, text: `#FFF` | same | same |

Border radius: `radius.chip` (16px). Single selection only.

**4. Date Picker Row**
- Label: "Date" -- `label.md` Inter 500, 14sp, `text.primary`
- Spacer: 8dp
- Tap target: full width minus 32dp, 48dp height

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Calendar icon | 20dp | `#8B949E` | `#656D76` | -- | Static |
| Date text (default: "Today, Feb 14, 2026") | -- | `#F0F6FC` | `#1F2328` | `body.lg` -- Inter 400, 16sp | Updates on selection |
| Chevron right | 20dp | `#484F58` | `#8C959F` | -- | Static |

Tapping opens system date picker or custom bottom sheet date picker.

**5. Content Text Area**
- Label: "What happened?" -- `label.md` Inter 500, 14sp, `text.primary`
- Spacer: 8dp
- Width: screen width minus 32dp
- Min height: 120dp
- Max height: 240dp (then scrolls internally)
- Background (dark): `#161B22`
- Background (light): `#F6F8FA`
- Border: 1px `border.default`; focused: 1.5px `brand.primary`
- Border radius: `radius.input` (8px)
- Padding: 12dp

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Placeholder "Describe the moment..." | -- | `#484F58` | `#8C959F` | `body.md` -- Inter 400, 14sp | Hidden on input |
| Content text | -- | `#F0F6FC` | `#1F2328` | `body.md` -- Inter 400, 14sp | Multiline |

**6. Photo Attachment**
- Label: "Photo" -- `label.md` Inter 500, 14sp, `text.primary`
- Spacer: 8dp

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Add Photo" button | auto width, 40dp h, 16dp h-pad | bg: `#21262D`, border: 1px `#30363D`, text+icon: `#8B949E` | bg: `#EAEEF2`, border: 1px `#D0D7DE`, text+icon: `#656D76` | `label.md` 14sp | Pressed: bg darken 10% |
| Camera icon (in button) | 18dp | same as text | same | -- | Static |
| Photo thumbnail (after attachment) | 80x80dp, 8px radius | border: 1px `border.default` | same | -- | X remove button top-right |
| Remove X | 20dp circle bg `#F85149`, icon `#FFF` 12dp | -- | -- | -- | On thumbnail corner |

Tapping "Add Photo" shows bottom sheet: "Take Photo" / "Choose from Gallery" / "Cancel".

**7. Tags Chip Input**
- Label: "Tags (max 5)" -- `label.md` Inter 500, 14sp, `text.primary`
- Spacer: 8dp
- Input area: same styling as Title input but wraps chips + text input

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Tag chip (entered) | auto, 28dp h, 8dp h-pad | bg: `#21262D`, text: `#F0F6FC`, X: `#8B949E` | bg: `#EAEEF2`, text: `#1F2328`, X: `#656D76` | `label.sm` 12sp | X tap removes chip |
| Text input (inline) | flexible width | `#F0F6FC` | `#1F2328` | `body.md` 14sp | Enter/comma creates chip |

Border radius on chips: `radius.chip` (16px). Max 5 chips; input disabled after 5.

**8. "She Said" Toggle**
- Full width minus 32dp, 56dp height row

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Label "She Said This" | -- | `#F0F6FC` | `#1F2328` | `label.lg` -- Inter 500, 16sp | Static |
| Subtitle "Marks as something she mentioned" | -- | `#8B949E` | `#656D76` | `body.sm` 12sp | Static |
| Toggle switch | 52x32dp | Track off: `#30363D`, on: `#C9A96E`. Thumb: `#FFF` | Track off: `#D0D7DE`, on: `#C9A96E`. Thumb: `#FFF` | -- | On/Off |

When toggled on, a subtle gold left border (3dp) appears on the entire "She Said" row to reinforce the wish list connection.

**9. Save Button (Bottom)**
- Width: screen width minus 32dp
- Height: 48dp
- Background: `#4A90D9`
- Text: "Save Memory" -- `button` Inter 600, 16sp, `#FFFFFF`
- Border radius: `radius.button` (24px)

| State | Background | Text | Other |
|-------|-----------|------|-------|
| Default | `#4A90D9` | `#FFFFFF` | -- |
| Pressed | `#3A7BC8` | `#FFFFFF` | Scale 0.98 |
| Disabled (title empty) | `#4A90D9` at 40% | `#FFFFFF` at 40% | Non-interactive |
| Loading | `#4A90D9` | Spinner 20dp `#FFF` | -- |

#### RTL Notes

- All labels right-aligned; input text starts from right
- "She Said" toggle moves to left side of row; label and subtitle right-aligned
- Photo "Add Photo" button text and icon flip order (icon on right of text)

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.sheet.enter` | Slide up from bottom (bottom sheet style) |
| Category chip select | 200ms | `anim.fast` | Background color fill transition + scale 1.0 to 1.05 to 1.0 |
| Tag chip creation | 200ms | `anim.spring` | New chip scales from 0 to 1 with spring |
| Tag chip removal | 150ms | `anim.fast` | Chip scales to 0 + fade out; remaining chips reflow |
| Photo thumbnail appear | 300ms | `anim.normal` | Scale from 0.5 + fade in |
| "She Said" toggle | 200ms | `anim.fast` | Thumb slides; track color transitions; gold border fades in |
| Save success | 300ms | `anim.normal` | Button shrinks to circle + checkmark icon, then screen dismisses |

#### Accessibility

- Form fields labeled: "Title, required, text field", "Category, required, single selection", "Date, date picker", "Content, text area", "Tags, text field, [N] of 5 tags added"
- "She Said" toggle: "Mark as something she mentioned for wish list. Currently [on/off]. Double tap to toggle."
- Save button: "Save memory, button. [Disabled: Title is required]"

#### Edge Cases

- **Unsaved changes + back:** Show confirmation dialog: "Discard this memory?" with "Discard" (error color text) and "Keep Editing" (primary) buttons
- **Photo too large (>10MB):** Auto-compress to 80% quality; show brief toast "Photo compressed for storage"
- **Duplicate title warning:** If exact title match exists, show inline warning below title: "You already have a memory with this title" (warning color)

---

### Screen 37: Memory Detail

| Property | Value |
|----------|-------|
| **Screen Name** | Memory Detail |
| **Route** | `/memories/:id` |
| **Module** | Memory Vault |
| **Sprint** | Sprint 3 (S3-10) |

#### Layout Description

Full-screen scrollable detail. If photo attached, hero image at top (edge-to-edge). App bar overlays the photo (transparent bg with scrim). Below photo: title, metadata row, content, tags, action row. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp (overlays photo if present)
- Photo hero (conditional): full width, 200dp height, edge-to-edge
- OR App bar: 56dp (if no photo) -- back arrow, "Memory" title, edit icon
- Spacer: 16dp
- Title
- Spacer: 8dp
- Metadata row: date + category chip
- Spacer: 16dp
- Content body
- Spacer: 16dp
- Tags row (if tags exist)
- Spacer: 24dp
- Divider: 1px `border.default`
- Spacer: 16dp
- Action row
- Spacer: 16dp
- "Use for Next Gift" button (conditional -- Wishes category only)
- Spacer: 24dp + bottom safe area

#### Component Breakdown

**1. Photo Hero (conditional)**
- Width: screen width (edge-to-edge)
- Height: 200dp
- Fit: cover (center-crop)
- Bottom scrim: linear gradient from transparent to `bg.primary` at 80% opacity (last 48dp)
- Overlaid app bar: back arrow `#FFFFFF`, edit icon `#FFFFFF`, drop shadow on icons for readability

**2. App Bar (no photo variant)**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Back arrow | 24dp, 48dp touch | `#F0F6FC` | `#1F2328` | -- | Pressed: opacity 0.6 |
| Title "Memory" | -- | `#F0F6FC` | `#1F2328` | `heading.sm` 18sp | Static |
| Edit icon (pencil) | 24dp, 48dp touch | `#8B949E` | `#656D76` | -- | Pressed: opacity 0.6 |

**3. Title**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Memory title | -- | `#F0F6FC` | `#1F2328` | `heading.md` -- Inter 600, 20sp/28sp | Multi-line |

**4. Metadata Row**
- Horizontal row, 8dp gap between elements

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Date text | -- | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp | e.g. "February 14, 2026" |
| Dot separator | 4dp circle | `#484F58` | `#8C959F` | -- | Static |
| Category chip | auto, 24dp h, 8dp h-pad | category colors (see Screen 35 table) | same | `label.sm` 12sp | Static |
| "She Said" badge (conditional) | auto, 24dp h | bg: `#C9A96E` at 15%, text: `#C9A96E` | same | `label.sm` 12sp | Only if flagged |

**5. Content Body**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Content text | full width minus 32dp | `#F0F6FC` | `#1F2328` | `body.lg` -- Inter 400, 16sp/24sp | Full text, no truncation |

**6. Tags Row**
- Horizontal wrap, 8dp gap

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Tag chip | auto, 28dp h, 10dp h-pad | bg: `#21262D`, text: `#8B949E`, border: 1px `#30363D` | bg: `#EAEEF2`, text: `#656D76`, border: 1px `#D0D7DE` | `label.sm` 12sp | Non-interactive (read-only) |

**7. Action Row**
- Full width minus 32dp, 3 buttons

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Edit button | auto, 40dp h, 16dp h-pad | bg: `#21262D`, icon+text: `#F0F6FC` | bg: `#EAEEF2`, icon+text: `#1F2328` | `label.md` 14sp | Pressed: opacity 0.8 |
| Share to Action Card | auto, 40dp h | bg: `#21262D`, icon+text: `#4A90D9` | bg: `#EAEEF2`, icon+text: `#4A90D9` | `label.md` 14sp | Pressed: opacity 0.8 |
| Delete button | auto, 40dp h | bg: transparent, icon+text: `#F85149` | bg: transparent, icon+text: `#CF222E` | `label.md` 14sp | Pressed: opacity 0.8 |

**8. "Use for Next Gift" Button (Wishes category only)**
- Width: screen width minus 32dp
- Height: 44dp
- Background: `gradient.achievement` (`#C9A96E` to `#E8D5A3`)
- Text: "Use for Next Gift" -- `button` Inter 600, 16sp, `#1F2328`
- Icon: gift icon 20dp left of text
- Border radius: `radius.button` (24px)

**9. Delete Confirmation Dialog**
- Modal overlay: `#000000` at 60% opacity
- Dialog card: 280dp wide, auto height, centered, `radius.card` 12px
- Background (dark): `#21262D`, (light): `#FFFFFF`
- Padding: 24dp
- Title: "Delete Memory?" -- `heading.sm` 18sp, `text.primary`
- Body: "This cannot be undone." -- `body.md` 14sp, `text.secondary`
- Buttons row (right-aligned): "Cancel" (text button, `text.secondary`), "Delete" (text button, `status.error`)

#### RTL Notes

- Photo hero unaffected (images are direction-agnostic)
- Metadata row flows right-to-left; date on far right, chip follows
- Action row buttons order reverses: Delete on far right, Edit on far left

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter (with photo) | 300ms | `anim.page.enter` | Photo parallax slide-up; content fades in staggered |
| Screen enter (no photo) | 300ms | `anim.page.enter` | Standard slide from right |
| Delete dialog appear | 200ms | `anim.fast` | Overlay fades in; dialog scales 0.9 to 1.0 |
| Delete dialog dismiss | 150ms | `anim.fast` | Reverse of appear |
| Delete confirm | 300ms | `anim.normal` | Memory card dissolves (scale down + fade); navigate back |
| "Use for Next Gift" tap | 200ms | `anim.fast` | Button pulse (scale 1.02 then 1.0); toast "Sent to Gift Engine" |

#### Accessibility

- Photo hero: content description from memory title, e.g. "Photo for memory: [Title]"
- Full read order: Title, date, category, "she said" indicator, content, tags, then action buttons
- Delete button: "Delete memory, button. Opens confirmation dialog."

#### Edge Cases

- **No photo:** App bar is opaque standard style; no hero section
- **Very long content (>2000 chars):** Full text rendered; no pagination; scroll position persisted on back navigation
- **Memory linked to fulfilled gift:** Show "Gift Fulfilled" badge in metadata row, "Use for Next Gift" button hidden

---

### Screen 38: Wish List

| Property | Value |
|----------|-------|
| **Screen Name** | Wish List |
| **Route** | `/memories/wishlist` |
| **Module** | Memory Vault |
| **Sprint** | Sprint 3 (S3-10) |

#### Layout Description

Filtered list view of memories tagged as wishes (via "She Said" toggle). Top app bar with title and sort control. Each item is a card with wish details and status. Background is `bg.primary`. Bottom navigation visible.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- back arrow, "Wish List" title, sort icon (right)
- Spacer: 8dp
- Filter/sort bar: 40dp (sort selector)
- Spacer: 12dp
- Wish list items (scrollable)
- Bottom navigation: 64dp

#### Component Breakdown

**1. App Bar**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Back arrow | 24dp, 48dp touch | `#F0F6FC` | `#1F2328` | -- | Pressed: opacity 0.6 |
| Title "Wish List" | -- | `#F0F6FC` | `#1F2328` | `heading.lg` -- Inter 600, 24sp | Static |
| Sort icon | 24dp, 48dp touch | `#8B949E` | `#656D76` | -- | Pressed: opacity 0.6 |

**2. Sort Selector (on sort icon tap)**
- Dropdown / bottom sheet with options:
  - "Newest First" (default)
  - "By Occasion Proximity"
- Active option has checkmark icon + `brand.primary` color

**3. Wish List Item Card**
- Width: screen width minus 32dp
- Background (dark): `#21262D`
- Background (light): `#EAEEF2`
- Border radius: `radius.card` (12px)
- Padding: 16dp
- Elevation: `elevation.1`
- Margin bottom: 12dp between cards

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Wish text (title) | -- | `#F0F6FC` | `#1F2328` | `label.lg` -- Inter 500, 16sp | Max 2 lines, ellipsize |
| Date captured | -- | `#484F58` | `#8C959F` | `body.sm` -- Inter 400, 12sp | e.g. "Captured Feb 10, 2026" |
| Source context | -- | `#8B949E` | `#656D76` | `body.sm` -- Inter 400, 12sp, italic | e.g. "She mentioned while shopping" |
| Status chip | auto, 24dp h, 8dp h-pad | varies (see below) | varies | `label.sm` 12sp | Static |
| "Send to Gift Engine" button | auto, 36dp h, 12dp h-pad | bg: `#C9A96E`, text: `#FFFFFF` | bg: `#C9A96E`, text: `#FFFFFF` | `label.md` 14sp | Only for status=New |

**Status chip colors:**

| Status | Dark bg | Dark text | Light bg | Light text |
|--------|---------|-----------|----------|------------|
| New | `#4A90D9` at 15% | `#4A90D9` | `#4A90D9` at 10% | `#4A90D9` |
| Sent to Gift Engine | `#D29922` at 15% | `#D29922` | `#BF8700` at 10% | `#BF8700` |
| Fulfilled | `#3FB950` at 15% | `#3FB950` | `#1A7F37` at 10% | `#1A7F37` |

**Card internal layout:**
- Row 1: Wish text (left) + Status chip (right)
- Row 2 (8dp below): Date captured
- Row 3 (4dp below): Source context (italic)
- Row 4 (12dp below, conditional): "Send to Gift Engine" button (right-aligned, only if status = New)

#### RTL Notes

- Status chip moves to left; wish text aligns right
- "Send to Gift Engine" button aligns left
- Sort dropdown text aligns right

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Slide in from right |
| Card stagger load | 200ms each, 50ms stagger | `anim.fast` | Fade in + translate Y 12dp |
| "Send to Gift Engine" tap | 400ms | `anim.normal` | Button text changes to checkmark + "Sent!"; status chip transitions from New to Sent |
| Sort change | 300ms | `anim.normal` | Cards fade out, reorder, fade back in |

#### Accessibility

- Each card: "[Wish text]. Status: [New/Sent/Fulfilled]. Captured on [date]. [Source context]."
- "Send to Gift Engine" button: "Send [wish text] to gift recommendation engine, button"
- Sort control: "Sort wishes. Currently sorted by [option]. Double tap to change."

#### Edge Cases

- **No wishes yet:** Empty state -- "No wishes captured yet. When she mentions something she wants, save it with the 'She Said' toggle."
- **All wishes fulfilled:** Show celebratory micro-illustration + "All wishes fulfilled! You're paying attention." in `status.success` color
- **Wish sent to Gift Engine but no occasion upcoming:** Show informational tooltip: "We'll suggest this when an occasion approaches"

---

## SETTINGS MODULE

---

### Screen 39: Settings Main

| Property | Value |
|----------|-------|
| **Screen Name** | Settings Main |
| **Route** | `/settings` |
| **Module** | Settings |
| **Sprint** | Sprint 2 (S2-12) |

#### Layout Description

Scrollable grouped list. Top app bar with "Settings" title. Sections separated by 24dp spacers and 1px dividers. Each section has a header label. Each row is a 56dp-height tap target. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- "Settings" title left-aligned, no back arrow (top-level tab)
- Spacer: 8dp
- Account section
- Section divider: 24dp spacer + 1px line
- Preferences section
- Section divider
- Subscription section
- Section divider
- Privacy section
- Section divider
- About section
- Spacer: 24dp + bottom safe area
- Bottom navigation: 64dp

#### Component Breakdown

**Section Header**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Section title | 16dp left padding | `#8B949E` | `#656D76` | `label.sm` -- Inter 500, 12sp, uppercase, letter-spacing 0.5sp | Static |

**Settings Row (generic)**
- Width: screen width
- Height: 56dp
- Padding: 16dp horizontal
- Layout: icon (left) + label (12dp right of icon) + value/control (right-aligned)
- Divider: 1px `border.default` between rows within a section, inset 52dp from left

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Row icon | 24dp | `#8B949E` | `#656D76` | -- | Static |
| Row label | -- | `#F0F6FC` | `#1F2328` | `body.lg` -- Inter 400, 16sp | Static |
| Row value / arrow | -- / 20dp | `#8B949E` / `#484F58` | `#656D76` / `#8C959F` | `body.md` 14sp / -- | Arrow for navigation rows |
| Toggle (where applicable) | 52x32dp | Track off: `#30363D`, on: `#4A90D9`. Thumb: `#FFF` | Track off: `#D0D7DE`, on: `#4A90D9`. Thumb: `#FFF` | -- | On/Off |

**Pressed state (all rows):** background tint `brand.primary` at 5%, `anim.instant`.

**1. Account Section**

| Row | Icon | Label | Value/Control |
|-----|------|-------|---------------|
| Profile | `ic_person` | (Photo 40dp circle + Name + email below) | Arrow |
| Email | `ic_mail` | Email address | Arrow |

**Profile row special layout:** 72dp height instead of 56dp. Photo (40dp circle, left), Name (`label.lg` 16sp, `text.primary`), Email (`body.sm` 12sp, `text.secondary`) stacked right of photo. Arrow far right.

**2. Preferences Section**

| Row | Icon | Label | Value/Control |
|-----|------|-------|---------------|
| Language | `ic_language` | Language | Current language name + arrow |
| Theme | `ic_palette` | Theme | "System" / "Dark" / "Light" + arrow |
| Notifications | `ic_notifications` | Notifications | Arrow |

**3. Subscription Section**

| Row | Icon | Label | Value/Control |
|-----|------|-------|---------------|
| Current Plan | `ic_star` | Subscription | Plan badge (colored chip: Free=gray, Pro=primary, Legend=accent) + arrow |

Plan badge styles:

| Plan | Dark bg | Dark text | Light bg | Light text |
|------|---------|-----------|----------|------------|
| Free | `#30363D` | `#8B949E` | `#D0D7DE` | `#656D76` |
| Pro | `#4A90D9` at 20% | `#4A90D9` | `#4A90D9` at 15% | `#4A90D9` |
| Legend | `#C9A96E` at 20% | `#C9A96E` | `#C9A96E` at 15% | `#956D2E` |

**4. Privacy Section**

| Row | Icon | Label | Value/Control |
|-----|------|-------|---------------|
| Biometric Lock | `ic_fingerprint` | Biometric Lock | Toggle switch |
| Data Export | `ic_download` | Export My Data | Arrow |
| Delete Account | `ic_delete` | Delete Account | Arrow (label in `#F85149` dark / `#CF222E` light) |

**5. About Section**

| Row | Icon | Label | Value/Control |
|-----|------|-------|---------------|
| Version | `ic_info` | Version | "1.0.0 (42)" text, no arrow |
| Terms | `ic_description` | Terms of Service | Arrow |
| Privacy Policy | `ic_shield` | Privacy Policy | Arrow |
| Licenses | `ic_code` | Open Source Licenses | Arrow |
| Help | `ic_help` | Help & Support | Arrow |

#### RTL Notes

- All icons move to right side; labels right-aligned; values/arrows move to left side
- Profile photo moves to right; name and email right-aligned
- Row divider inset flips to 52dp from right

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Standard slide from right (or tab cross-fade if from bottom nav) |
| Row press | 100ms | `ease-out` | Background tint appears |
| Toggle switch | 200ms | `anim.fast` | Thumb slides; track color transitions |
| Navigate to sub-screen | 300ms | `anim.page.enter` | Slide left-to-right transition |

#### Accessibility

- Screen reader: "Settings. [N] sections. Account. Preferences. Subscription. Privacy. About."
- Each row: "[Icon description] [Label]. Current value: [Value]. Double tap to open." or "Toggle. [Label]. Currently [on/off]. Double tap to toggle."
- Delete Account row: "Delete Account, button. Warning: this action is permanent."

#### Edge Cases

- **No profile photo set:** Show initials avatar (first letter of name) in circle with `brand.primary` background
- **Subscription expired:** Plan badge shows "Expired" in `status.error` color with "Renew" text
- **Biometric not available on device:** Biometric Lock row shows "Not available" in `text.tertiary`, toggle disabled

---

### Screen 40: Subscription Management

| Property | Value |
|----------|-------|
| **Screen Name** | Subscription Management |
| **Route** | `/settings/subscription` |
| **Module** | Settings |
| **Sprint** | Sprint 2 (S2-12) / Sprint 1 (S1-10 backend) |

#### Layout Description

Scrollable screen. Top app bar with back arrow and "Subscription" title. Hero card showing current plan. Usage meters section. Plan comparison section (swipeable cards or table). Upgrade CTA. Restore link. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- back arrow + "Subscription" title
- Spacer: 16dp
- Current plan hero card: full width minus 32dp, auto height
- Spacer: 24dp
- "Your Usage" section header
- Spacer: 12dp
- Usage meters (3 rows)
- Spacer: 24dp
- "Compare Plans" section header
- Spacer: 12dp
- Plan comparison cards (horizontal scroll)
- Spacer: 24dp
- Upgrade CTA button
- Spacer: 12dp
- "Restore Purchases" text link
- Spacer: 8dp
- Regional pricing note
- Spacer: 24dp + bottom safe area

#### Component Breakdown

**1. Current Plan Hero Card**
- Width: screen width minus 32dp
- Background: `gradient.premium` for Pro/Legend; `bg.tertiary` for Free
- Border radius: `radius.card` (12px)
- Padding: 20dp
- Elevation: `elevation.2`

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Plan name ("Pro") | -- | `#FFFFFF` | `#FFFFFF` (on gradient) | `heading.lg` -- Inter 600, 24sp | Static |
| Price "$6.99/mo" | -- | `#FFFFFF` at 90% | `#FFFFFF` at 90% | `heading.sm` -- Inter 600, 18sp | Static |
| Renewal date "Renews Mar 14, 2026" | -- | `#FFFFFF` at 70% | `#FFFFFF` at 70% | `body.sm` -- Inter 400, 12sp | Static |
| Status badge "Active" | auto, 24dp h | bg: `#3FB950` at 20%, text: `#3FB950` | same | `label.sm` 12sp | Active/Expired/Trial |

For Free tier, hero card uses `bg.tertiary` and standard text colors instead of gradient.

**2. Usage Meters**
- Each meter row: full width minus 32dp, 56dp height

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Usage label ("Messages") | -- | `#F0F6FC` | `#1F2328` | `body.md` -- Inter 400, 14sp | Static |
| Usage count ("42 / 100") | -- | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp | Static |
| Progress bar track | full width, 6dp h | `#21262D` | `#EAEEF2` | -- | Static |
| Progress bar fill | proportional, 6dp h | `#4A90D9` (Pro) / `#C9A96E` (Legend) | same | -- | >80%: `#D29922`; >95%: `#F85149` |

Border radius on progress bar: 3dp. Three meters: Messages, SOS Sessions, Saved Cards.

**3. Plan Comparison (Swipeable Cards)**
- Horizontal scroll with snap-to-card behavior
- 3 cards: Free, Pro (recommended), Legend
- Each card: 240dp wide, auto height, 16dp gap between cards
- First card visible with 32dp peek of next

**Plan Card:**
- Background (dark): `#21262D`; (light): `#EAEEF2`
- Pro card border: 2px `gradient.premium`
- Border radius: `radius.card` (12px)
- Padding: 20dp

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Recommended" badge (Pro only) | auto, 22dp h | bg: `gradient.premium`, text: `#FFF` | same | `label.sm` 12sp | Only on Pro card |
| Plan name | -- | `#F0F6FC` | `#1F2328` | `heading.sm` -- Inter 600, 18sp | Static |
| Price | -- | `#F0F6FC` | `#1F2328` | `heading.lg` -- Inter 600, 24sp | Static |
| Price period "/month" | -- | `#8B949E` | `#656D76` | `body.sm` 12sp | Static |
| Feature row (checkmark + text) | 32dp h per row | check: `#3FB950`, text: `#8B949E` | check: `#1A7F37`, text: `#656D76` | `body.sm` 12sp | Checkmark or X |
| Unavailable feature (X + text) | 32dp h | x: `#484F58`, text: `#484F58` | x: `#8C959F`, text: `#8C959F` | `body.sm` 12sp, strikethrough | -- |

**4. Upgrade CTA**
- Width: screen width minus 32dp
- Height: 48dp
- Background: `gradient.premium`
- Text: "Upgrade to Pro -- $6.99/mo" -- `button` Inter 600, 16sp, `#FFFFFF`
- Border radius: `radius.button` (24px)
- Elevation: `elevation.2`

| State | Background | Text | Other |
|-------|-----------|------|-------|
| Default | `gradient.premium` | `#FFFFFF` | Shadow active |
| Pressed | `gradient.premium` darkened 10% | `#FFFFFF` | Scale 0.98 |
| Already on Pro | Hidden (show "Upgrade to Legend" with accent outline style instead) | -- | -- |
| Already on Legend | Hidden entirely | -- | -- |

**5. Restore Purchases**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Restore Purchases" text link | 48dp touch height | `#4A90D9` | `#4A90D9` | `body.md` -- Inter 400, 14sp, underline | Pressed: opacity 0.7 |

**6. Regional Pricing Note**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Note text | full width minus 32dp | `#484F58` | `#8C959F` | `body.sm` -- Inter 400, 12sp | Static |

Text: "Prices may vary by region. Displayed in your local currency at checkout."

#### RTL Notes

- Plan card content aligns right; feature checkmarks on right side with text flowing left
- Progress bar fill starts from right edge
- "Restore Purchases" text aligns center (unaffected)

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Slide from right |
| Hero card entrance | 400ms | `anim.spring` | Scale from 0.9 to 1.0 + fade in |
| Usage meter fill | 600ms per meter, 100ms stagger | `anim.slow` | Width animates from 0 to actual percentage |
| Plan card scroll | -- | -- | Snap behavior with momentum |
| CTA button press | 100ms | `ease-out` | Scale 0.98 |

#### Accessibility

- Hero card: "Current plan: [Plan name]. [Price]. Renews [date]. Status: [Active/Expired]."
- Usage meters: "Messages used: [X] of [Y]. [Percentage]% used."
- Plan cards: navigable by swipe; each card announces all features
- Upgrade button: "Upgrade to [Plan] for [Price] per month, button"

#### Edge Cases

- **Free user, no trial used:** Show "7-day free trial" badge on Pro card + CTA says "Start Free Trial"
- **Subscription via different platform:** Show "Manage on [iOS App Store / Google Play]" with deep link
- **Usage at limit:** Progress bar fully filled in `status.error`; show "Upgrade for more" inline text below meter

---

### Screen 41: Notification Preferences

| Property | Value |
|----------|-------|
| **Screen Name** | Notification Preferences |
| **Route** | `/settings/notifications` |
| **Module** | Settings |
| **Sprint** | Sprint 2 (S2-12) |

#### Layout Description

Scrollable settings list. Top app bar with back arrow and "Notifications" title. Master toggle at top, followed by quiet hours, per-category toggles, preview style selector, and test button. Background is `bg.primary`.

**Structure (top to bottom):**
- Status bar: 24dp
- App bar: 56dp -- back arrow + "Notifications" title
- Spacer: 16dp
- Master toggle row
- Divider: 1px `border.default`, full width, 16dp vertical margin
- Quiet Hours section
- Divider
- Per-category toggles (5 items)
- Divider
- Preview style section
- Spacer: 24dp
- Test notification button
- Spacer: 24dp + bottom safe area

#### Component Breakdown

**1. Master Toggle Row**
- Height: 56dp, 16dp horizontal padding

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Label "All Notifications" | -- | `#F0F6FC` | `#1F2328` | `label.lg` -- Inter 500, 16sp | Static |
| Toggle | 52x32dp | Track off: `#30363D`, on: `#4A90D9`. Thumb: `#FFF` | Track off: `#D0D7DE`, on: `#4A90D9`. Thumb: `#FFF` | -- | On/Off |

When master is OFF, all sections below are visually dimmed (opacity 0.4) and non-interactive.

**2. Quiet Hours**
- Section label: "Quiet Hours" -- `label.sm` 12sp, uppercase, `text.secondary`
- Two rows: Start time, End time

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Start" label | -- | `#F0F6FC` | `#1F2328` | `body.lg` 16sp | Static |
| Start time value | -- | `#4A90D9` | `#4A90D9` | `body.lg` 16sp, Inter 500 | Tappable; opens time picker |
| "End" label | -- | `#F0F6FC` | `#1F2328` | `body.lg` 16sp | Static |
| End time value | -- | `#4A90D9` | `#4A90D9` | `body.lg` 16sp, Inter 500 | Tappable; opens time picker |

Default: Start 22:00, End 07:00.

**3. Per-Category Toggles**
- Section label: "Categories" -- `label.sm` 12sp, uppercase, `text.secondary`
- Each category: 72dp height (to accommodate description)

| Category | Description | Icon |
|----------|-------------|------|
| Reminders | "Upcoming dates and occasions" | `ic_event` |
| Action Cards | "Daily relationship suggestions" | `ic_cards` |
| Streak Alerts | "Don't lose your progress" | `ic_fire` |
| AI Tips | "Weekly relationship insights" | `ic_lightbulb` |
| Promotions | "Offers and updates" | `ic_campaign` |

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Category icon | 24dp | `#8B949E` | `#656D76` | -- | Static |
| Category label | -- | `#F0F6FC` | `#1F2328` | `body.lg` -- Inter 400, 16sp | Static |
| Category description | -- | `#8B949E` | `#656D76` | `body.sm` -- Inter 400, 12sp | Static |
| Toggle | 52x32dp | same as master toggle | same | -- | On/Off; disabled when master=off |

**4. Preview Style Selector**
- Section label: "Preview Style" -- `label.sm` 12sp, uppercase, `text.secondary`
- Two radio-style cards, 12dp gap

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Discreet" card | 50% minus 6dp, 80dp h | selected: border 2px `brand.primary`, bg `brand.primary` at 5%; unselected: border 1px `border.default` | same pattern | -- | -- |
| "Discreet" label | -- | `#F0F6FC` | `#1F2328` | `label.md` 14sp | Static |
| "Discreet" preview | -- | `#8B949E` | `#656D76` | `body.sm` 12sp | Shows "LOLO" only |
| "Detailed" card | same | same | same | -- | -- |
| "Detailed" label | -- | `#F0F6FC` | `#1F2328` | `label.md` 14sp | Static |
| "Detailed" preview | -- | `#8B949E` | `#656D76` | `body.sm` 12sp | Shows "LOLO: She'll love..." |

Default: "Discreet" (critical for AR/MS privacy per User Personas).

**5. Test Notification Button**
- Width: screen width minus 32dp
- Height: 44dp
- Background (dark): `#21262D`, border 1px `#30363D`
- Background (light): `#EAEEF2`, border 1px `#D0D7DE`
- Text: "Send Test Notification" -- `button` Inter 600, 16sp, `text.primary`
- Border radius: `radius.button` (24px)

| State | Background | Text | Other |
|-------|-----------|------|-------|
| Default | `bg.tertiary` + border | `text.primary` | -- |
| Pressed | `bg.tertiary` darkened 10% | `text.primary` | Scale 0.98 |
| Sent | bg `status.success` at 15% | `status.success` "Sent!" | Resets after 2s |

#### RTL Notes

- Toggle switches move to left side; labels and descriptions right-aligned
- Quiet hours time values remain LTR (numbers are always LTR in Arabic)
- Preview style cards maintain side-by-side layout; content aligns right within each card

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Screen enter | 300ms | `anim.page.enter` | Slide from right |
| Master toggle off | 300ms | `anim.normal` | All sections below fade to 0.4 opacity |
| Master toggle on | 300ms | `anim.normal` | All sections fade to 1.0 opacity |
| Toggle any switch | 200ms | `anim.fast` | Thumb slide + track color transition |
| Time picker open | 300ms | `anim.sheet.enter` | Bottom sheet slide up |
| Test notification sent | 200ms + 2000ms hold | `anim.fast` | Button text changes to "Sent!" with checkmark |

#### Accessibility

- Master toggle: "All notifications. Currently [on/off]. Double tap to toggle. When off, all notification categories are disabled."
- Each category toggle: "[Category name]. [Description]. Currently [on/off]. Double tap to toggle."
- Preview style: "Notification preview style. [Discreet/Detailed] selected. Discreet shows only app name. Detailed shows message preview."
- Quiet hours: "Quiet hours start time: [time]. Double tap to change."

#### Edge Cases

- **Notifications permission not granted (OS level):** Show banner at top: "Notifications are disabled in your device settings" with "Open Settings" button (deep link to OS settings)
- **Master off + individual toggle attempt:** Show subtle bounce animation on master toggle to draw attention
- **Quiet hours start = end:** Show inline error "Start and end times must be different" in `status.warning`

---

## SUPPLEMENTARY SCREENS

---

### Screen 42: Paywall

| Property | Value |
|----------|-------|
| **Screen Name** | Paywall |
| **Route** | `/paywall` |
| **Module** | Supplementary |
| **Sprint** | Sprint 1 (S1-10) |

#### Layout Description

Full-screen modal overlay. Close X button top-right (always accessible -- never trap the user). Header section with motivational text. Feature comparison table. Two CTA buttons (Pro primary, Legend secondary). Fine print at bottom. Background is `bg.primary`. No bottom navigation (modal context).

**Structure (top to bottom):**
- Status bar: 24dp
- Close X button: 48dp touch, top-right, 16dp from edges
- Spacer: 16dp
- Header text block: centered, 32dp horizontal padding
- Spacer: 24dp
- "7-day free trial" badge (conditional)
- Spacer: 16dp
- Feature comparison table: full width minus 32dp
- Spacer: 24dp
- Pro CTA button
- Spacer: 12dp
- Legend CTA button
- Spacer: 16dp
- Fine print text
- Spacer: 24dp + bottom safe area

#### Component Breakdown

**1. Close X Button**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| X icon | 24dp, 48dp touch target | `#8B949E` | `#656D76` | -- | Pressed: opacity 0.6 |

Position: absolute, top-right, 16dp from top (below status bar), 16dp from right edge. Z-index above all content.

**2. Header**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Title "Unlock Your Full Potential" | -- | `#F0F6FC` | `#1F2328` | `heading.md` -- Inter 600, 20sp/28sp | Centered |
| Subtitle | -- | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp/20sp | Centered, max 2 lines |

Subtitle examples: "Get unlimited AI messages, smart action cards, and more."

**3. Free Trial Badge (conditional -- first-time users only)**
- Centered, auto width, 32dp height, 16dp horizontal padding
- Background: `gradient.achievement`
- Text: "7-Day Free Trial Included" -- `label.md` Inter 500, 14sp, `#1F2328`
- Border radius: `radius.chip` (16px)

**4. Feature Comparison Table**
- Width: screen width minus 32dp
- 3 columns: Feature name (50% width), Free (16.6%), Pro (16.6%), Legend (16.6%)
- Pro column highlighted: `brand.primary` at 5% background; "Recommended" header badge

**Table header:**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| "Free" column header | -- | `#8B949E` | `#656D76` | `label.sm` 12sp, center | Static |
| "Pro" column header | -- | `#4A90D9` | `#4A90D9` | `label.sm` 12sp, center, bold | Highlighted column |
| "Legend" column header | -- | `#C9A96E` | `#C9A96E` | `label.sm` 12sp, center | Static |

**Table rows (36dp height each):**

| Feature | Free | Pro | Legend |
|---------|------|-----|--------|
| AI Messages | "5/mo" | "100/mo" | "Unlimited" |
| Action Cards | "1/day" | "5/day" | "Unlimited" |
| Message Modes | "3" | "10" | "10" |
| SOS Sessions | "1/mo" | "3/mo" | "Unlimited" |
| Memory Vault | "10" | "100" | "Unlimited" |
| Gift Engine | X | checkmark | checkmark |
| Streak Freeze | X | X | checkmark |
| Priority Support | X | X | checkmark |

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Feature name | -- | `#F0F6FC` | `#1F2328` | `body.sm` 12sp | Left-aligned |
| Value text | -- | `#8B949E` | `#656D76` | `body.sm` 12sp | Centered |
| Checkmark | 16dp | `#3FB950` | `#1A7F37` | -- | Static |
| X mark | 16dp | `#484F58` | `#8C959F` | -- | Static |
| Row divider | 1px | `#30363D` at 50% | `#D0D7DE` at 50% | -- | Between rows |

Pro column background: `#4A90D9` at 5% (dark) / `#4A90D9` at 5% (light) -- vertical stripe behind entire Pro column.

**5. Pro CTA Button**
- Width: screen width minus 32dp
- Height: 52dp
- Background: `gradient.premium`
- Text: "Start Pro -- $6.99/mo" -- `button` Inter 600, 16sp, `#FFFFFF`
- Border radius: `radius.button` (24px)
- Elevation: `elevation.2`

| State | Background | Other |
|-------|-----------|-------|
| Default | `gradient.premium` | Shadow active |
| Pressed | `gradient.premium` darkened 10% | Scale 0.98 |

**6. Legend CTA Button**
- Width: screen width minus 32dp
- Height: 48dp
- Background: transparent
- Border: 1.5px `#C9A96E`
- Text: "Go Legend -- $12.99/mo" -- `button` Inter 600, 16sp, `#C9A96E`
- Border radius: `radius.button` (24px)

| State | Background | Other |
|-------|-----------|-------|
| Default | transparent + border | -- |
| Pressed | `#C9A96E` at 10% | Scale 0.98 |

**7. Fine Print**

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Fine print text | full width, centered | `#484F58` | `#8C959F` | `body.sm` -- Inter 400, 12sp/16sp | Static |

Text: "Cancel anytime. Subscription auto-renews monthly. By subscribing you agree to our Terms of Service."
"Terms of Service" is a tappable link in `brand.primary` color.

#### RTL Notes

- Feature names right-aligned in table; column order reverses (Legend | Pro | Free from left-to-right)
- Close X button moves to top-left
- CTA button text centered (unaffected by direction)

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Paywall appear | 400ms | `anim.sheet.enter` | Slide up from bottom + backdrop fade in |
| Free trial badge | 500ms delay, 300ms | `anim.spring` | Scale from 0 to 1 with spring bounce |
| Table rows stagger | 50ms stagger, 200ms each | `anim.fast` | Fade in + translate Y 8dp per row |
| CTA button shimmer | 3000ms loop | linear | Subtle gradient shimmer sweep across Pro button (attention cue) |
| Close / dismiss | 250ms | `anim.sheet.exit` | Slide down + backdrop fade out |

#### Accessibility

- Close button: "Close paywall, button" -- announced first in focus order
- Table: structured as actual table for screen readers; each cell announced with column and row context
- CTA buttons: "Start Pro plan for six dollars ninety-nine per month, button" / "Start Legend plan for twelve dollars ninety-nine per month, button"
- Free trial badge: "Seven day free trial included"

#### Edge Cases

- **User already on Pro:** Hide Pro CTA; show only Legend upgrade; change header to "Go Further with Legend"
- **User on Legend:** Should never see paywall; if reached via deep link, redirect to subscription management
- **Regional pricing (AR/MS markets):** Prices dynamically replaced from store config; layout accommodates longer price strings (e.g., "SAR 25.99/mo")

---

### Screen 43: Empty States (Pattern Library)

| Property | Value |
|----------|-------|
| **Screen Name** | Empty States Pattern Library |
| **Route** | N/A (component pattern, applied across all modules) |
| **Module** | Supplementary / Design System |
| **Sprint** | Sprint 1-4 (applied as needed) |

#### Layout Description

Reusable empty state component. Vertically centered within the content area of any screen. Consists of: illustration, title, subtitle, and optional CTA button. Fixed internal spacing.

**Structure (centered vertically and horizontally):**
- Illustration: 120x120dp, centered
- Spacer: 24dp
- Title: centered, max width 280dp
- Spacer: 8dp
- Subtitle: centered, max width 300dp
- Spacer: 24dp
- CTA button (optional): auto width, centered

#### Component Breakdown (Reusable Pattern)

| Element | Size | Color (Dark) | Color (Light) | Font | States |
|---------|------|-------------|---------------|------|--------|
| Illustration container | 120x120dp | muted: 30% opacity of category color | muted: 20% opacity of category color | -- | SVG vector or Lottie |
| Title | max 280dp width | `#F0F6FC` | `#1F2328` | `heading.sm` -- Inter 600, 16sp/24sp | Static, centered |
| Subtitle | max 300dp width | `#8B949E` | `#656D76` | `body.md` -- Inter 400, 14sp/20sp | Static, centered |
| CTA button | auto width, 44dp h, 24dp h-pad | bg: `#4A90D9`, text: `#FFF` | bg: `#4A90D9`, text: `#FFF` | `button` Inter 600, 16sp | Standard button states |

CTA button border radius: `radius.button` (24px).

#### Empty State Definitions

**1. No Reminders**

| Property | Value |
|----------|-------|
| Illustration | Calendar with gentle checkmark, muted blue tones |
| Title | "No reminders yet" |
| Subtitle | "Add important dates so you never forget what matters" |
| CTA | "Add Reminder" -- navigates to `/reminders/new` |

**2. No Messages**

| Property | Value |
|----------|-------|
| Illustration | Chat bubble with sparkle, muted blue tones |
| Title | "No messages yet" |
| Subtitle | "Let AI help you find the right words" |
| CTA | "Generate Message" -- navigates to `/messages/new` |

**3. No Gifts**

| Property | Value |
|----------|-------|
| Illustration | Gift box with ribbon, muted gold tones |
| Title | "No gift ideas yet" |
| Subtitle | "Tell us about her and we'll suggest thoughtful gifts" |
| CTA | "Get Suggestions" -- navigates to `/gifts` |

**4. No Memories**

| Property | Value |
|----------|-------|
| Illustration | Open journal/book with heart, muted blue tones |
| Title | "Start capturing moments" |
| Subtitle | "Save the stories, jokes, and wishes that matter most" |
| CTA | "Add First Memory" -- navigates to `/memories/new` |

**5. No Badges**

| Property | Value |
|----------|-------|
| Illustration | Trophy/medal outline, muted gold tones |
| Title | "No badges earned yet" |
| Subtitle | "Complete actions and build streaks to earn your first badge" |
| CTA | None (no direct action) |

**6. No Action Cards**

| Property | Value |
|----------|-------|
| Illustration | Compass with checkmark, muted blue tones |
| Title | "You're all caught up!" |
| Subtitle | "Come back tomorrow for fresh suggestions" |
| CTA | None |

**7. No Notifications**

| Property | Value |
|----------|-------|
| Illustration | Bell with "Z" sleep marks, muted gray tones |
| Title | "All clear" |
| Subtitle | "You have no new notifications" |
| CTA | None |

**8. Offline State**

| Property | Value |
|----------|-------|
| Illustration | Cloud with X mark, muted gray tones |
| Title | "You're offline" |
| Subtitle | "Some features need an internet connection. Check your network and try again." |
| CTA | "Retry" -- triggers network check |

CTA button uses outline style for Offline: bg transparent, border 1.5px `brand.primary`, text `brand.primary`.

**9. Error State**

| Property | Value |
|----------|-------|
| Illustration | Warning triangle with exclamation, muted red tones |
| Title | "Something went wrong" |
| Subtitle | "We couldn't load this content. Please try again." |
| CTA | "Try Again" -- retries the failed API call |

Illustration uses `status.error` at 30% opacity.

#### RTL Notes

- All centered content is direction-agnostic (center alignment works identically in LTR and RTL)
- CTA button text will be longer in Arabic; ensure auto-width accommodates up to 200% text expansion
- Subtitle line breaks may differ; max-width constraint handles reflow naturally

#### Animation Specs

| Trigger | Duration | Easing | Description |
|---------|----------|--------|-------------|
| Empty state appear | 500ms total | staggered | Illustration: fade in 0-300ms; Title: fade in 150-350ms; Subtitle: fade in 300-500ms; CTA: fade in 400-600ms |
| Illustration idle | 3000ms loop | `ease-in-out` | Gentle float up/down 4dp (subtle breathing animation) |
| CTA button press | 100ms | `ease-out` | Scale 0.97 |
| Offline retry | 300ms | `anim.normal` | CTA spins icon 360deg; content area shows loading spinner |
| Error retry | 300ms | `anim.normal` | Same as offline retry |

#### Accessibility

- Illustration: decorative only, `contentDescription = null` (hidden from screen reader)
- Title and subtitle read as single group: "[Title]. [Subtitle]."
- CTA button: "[CTA text], button"
- Offline/Error states: announced with urgency -- "Alert. [Title]. [Subtitle]."

#### Edge Cases

- **Empty state shown briefly before content loads:** Add 500ms delay before showing empty state to avoid flash (show skeleton/shimmer during that window)
- **Very small screen (<360dp width):** Illustration reduces to 80x80dp; title drops to 14sp; subtitle to 12sp
- **Dark mode illustrations:** All illustrations must have dark-mode-aware variants or use `currentColor`-style vector tinting

---

## CROSS-SCREEN SPECIFICATIONS

### Shared Navigation Context

Screens 33-38 are accessible from the bottom navigation bar (Action Cards tab and Memory Vault via More or dedicated tab). Screens 39-41 are accessible from Settings in the bottom navigation or profile menu. Screen 42 (Paywall) is a modal that can appear from any screen when a gated feature is accessed. Screen 43 patterns are embedded within their respective parent screens.

### Bottom Navigation Tab Mapping

| Tab | Icon | Label | Primary Screen |
|-----|------|-------|---------------|
| Home | `ic_home` | Home | Dashboard |
| Cards | `ic_cards` | Cards | Screen 33 |
| Messages | `ic_chat` | Messages | Message Generator |
| Memories | `ic_book` | Memories | Screen 35 |
| Settings | `ic_settings` | Settings | Screen 39 |

### Data Flow Notes

- Screen 36 "She Said" toggle feeds data to Screen 38 (Wish List) and the Gift Engine
- Screen 33 completion actions feed into XP calculations on the Dashboard
- Screen 40 subscription state gates feature access across Screens 33-38 (card limits, memory limits)
- Screen 42 may trigger from any gated feature; on successful purchase, dismiss paywall and return to the originating screen with unlocked state

---

*End of Part 2B specifications. For Screens 1-22, see `high-fidelity-specs-part1.md`. For Screens 23-32, see `high-fidelity-specs-part2a.md` (forthcoming).*
