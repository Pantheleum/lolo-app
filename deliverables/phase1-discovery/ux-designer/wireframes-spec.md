# LOLO Wireframe Specifications
### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0

---

## Table of Contents

1. [Onboarding Module (Screens 1-8)](#onboarding-module)
2. [Dashboard Module (Screens 9-11)](#dashboard-module)
3. [Her Profile Module (Screens 12-15)](#her-profile-module)
4. [Smart Reminders Module (Screens 16-18)](#smart-reminders-module)
5. [AI Message Generator Module (Screens 19-22)](#ai-message-generator-module)
6. [Gift Recommendation Module (Screens 23-25)](#gift-recommendation-module)
7. [SOS Mode Module (Screens 26-29)](#sos-mode-module)
8. [Gamification Module (Screens 30-32)](#gamification-module)
9. [Smart Action Cards Module (Screens 33-34)](#smart-action-cards-module)
10. [Memory Vault Module (Screens 35-38)](#memory-vault-module)
11. [Settings Module (Screens 39-41)](#settings-module)
12. [Supplementary Screens (Screens 42-43)](#supplementary-screens)
13. [Navigation Map](#navigation-map)
14. [Critical User Flows](#critical-user-flows)
15. [RTL Impact Assessment](#rtl-impact-assessment)

---

## Design Tokens Reference

| Token | Value |
|-------|-------|
| Primary Color | #1A1A2E (Deep Navy) |
| Accent Color | #E94560 (Warm Red) |
| Secondary Accent | #0F3460 (Royal Blue) |
| Success | #16C47F |
| Warning | #FFB830 |
| Error | #FF4444 |
| Surface Dark | #16213E |
| Surface Light | #F5F5F5 |
| Text Primary | #FFFFFF (dark mode) / #1A1A2E (light mode) |
| Border Radius | 12px (cards), 8px (inputs), 24px (buttons) |
| Font Family | Inter (EN), Cairo (AR headings), Noto Naskh Arabic (AR body), Noto Sans (MS) |
| Min Touch Target | 48x48dp |
| Bottom Nav Height | 64dp |
| Status Bar Offset | 24dp |
| Screen Padding | 16dp horizontal |

---

## Onboarding Module

---

### Screen 1: Language Selector

- **Route:** `/onboarding/language`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** First screen. User picks app language. Three options with country flags. No back button. Sets locale for entire app.

```
+-------------------------------+
|          [Status Bar]         |
|                               |
|                               |
|         (( LOLO logo ))       |
|                               |
|     Choose Your Language      |
|                               |
|   +-------------------------+ |
|   | [US/UK]  English        | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [SA]     العربية        | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [MY]     Bahasa Melayu  | |
|   +-------------------------+ |
|                               |
|                               |
|                               |
|                               |
|                               |
+-------------------------------+
```

**Components:**
- `LogoWidget` -- centered LOLO brand mark, 80x80dp
- `HeadlineText` -- "Choose Your Language", 24sp, centered
- `LanguageTile` x3 -- 56dp height, flag icon 32x32dp left-aligned, language name right, border 1px #333, radius 12px, full width
- Selection state: accent border (#E94560), filled background (#E94560 at 10% opacity)

**User Actions:**
- Tap a language tile to select it
- Selection auto-advances to Welcome screen after 300ms delay
- No explicit "Next" button needed (single-purpose screen)

**Navigation:**
- Forward: `/onboarding/welcome` (on selection)
- Back: none (first screen)

**RTL Notes:**
- If user selects Arabic, layout flips immediately before navigating forward
- Flag moves to right side, text aligns right
- Transition animation reverses direction (slide-from-left becomes slide-from-right)

**States:**
- **Default:** All three tiles visible, none selected
- **Selected:** Chosen tile highlighted, brief haptic feedback, auto-navigate
- **Error:** Device locale detection fallback -- pre-highlight matching language if device language matches EN/AR/MS

---

### Screen 2: Welcome

- **Route:** `/onboarding/welcome`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** Value proposition screen. Shows tagline, 3 key benefits, and a CTA to proceed. Sets emotional tone for the app.

```
+-------------------------------+
|          [Status Bar]         |
|                               |
|         (( LOLO logo ))       |
|                               |
|     She won't know why you    |
|     got so thoughtful.        |
|     We won't tell.            |
|                               |
|   +-------------------------+ |
|   | [icon] Smart reminders  | |
|   |  Never forget what      | |
|   |  matters to her          | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [icon] AI messages      | |
|   |  Say the right thing    | |
|   |  every time              | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [icon] SOS mode         | |
|   |  Emergency help when    | |
|   |  she's upset             | |
|   +-------------------------+ |
|                               |
|   [    Get Started     ]      |
|                               |
|      Already have account?    |
|          Log in               |
+-------------------------------+
```

**Components:**
- `LogoWidget` -- same as Screen 1
- `TaglineText` -- app tagline, 20sp, semi-bold, centered, max 3 lines
- `BenefitCard` x3 -- icon (24dp) + title (16sp bold) + subtitle (14sp, #888), row layout, 8dp gap between cards
- `PrimaryButton` -- "Get Started", full width minus 32dp padding, 52dp height, #E94560 background, white text 16sp bold, radius 24px
- `TextLink` -- "Already have account? Log in", 14sp, #0F3460 underline on "Log in"

**User Actions:**
- Tap "Get Started" to proceed to Sign Up
- Tap "Log in" to go to login flow
- Swipe up gesture also advances (optional)

**Navigation:**
- Forward: `/onboarding/signup` (Get Started)
- Forward: `/login` (Log in link)
- Back: `/onboarding/language`

**RTL Notes:**
- Tagline text aligns right, reads naturally in Arabic
- Benefit card icons move to right side
- Benefit text aligns right
- Button text centered (same in both directions)

**States:**
- **Default:** Static content, no loading needed
- **Loading:** None (all content is local)
- **Error:** None (static screen)

---

### Screen 3: Sign Up

- **Route:** `/onboarding/signup`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** Authentication screen. Three sign-up methods: email, Google, Apple. Email option expands to show email/password form.

```
+-------------------------------+
|  <-        Sign Up            |
+-------------------------------+
|                               |
|         (( LOLO logo ))       |
|                               |
|     Create your account       |
|                               |
|   +-------------------------+ |
|   | [G]  Continue with      | |
|   |      Google              | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [A]  Continue with      | |
|   |      Apple               | |
|   +-------------------------+ |
|                               |
|        -- or --               |
|                               |
|   Email                       |
|   +-------------------------+ |
|   | you@example.com         | |
|   +-------------------------+ |
|                               |
|   Password                    |
|   +-------------------------+ |
|   | ********          [eye] | |
|   +-------------------------+ |
|                               |
|   Confirm Password            |
|   +-------------------------+ |
|   | ********          [eye] | |
|   +-------------------------+ |
|                               |
|   [    Create Account   ]     |
|                               |
|   By signing up you agree to  |
|   Terms of Service and        |
|   Privacy Policy              |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow left, "Sign Up" title center, no right action
- `LogoWidget` -- 60x60dp, smaller than welcome screen
- `SubheadText` -- "Create your account", 18sp, centered
- `SocialButton` x2 -- Google and Apple, 52dp height, outlined style, brand icon 24dp left, text centered, full width
- `DividerWithText` -- horizontal line with "or" centered
- `TextFieldLabeled` x3 -- email, password, confirm password; 48dp height, floating label, 14sp, radius 8px
- `PasswordToggle` -- eye icon inside password fields, 24dp
- `PrimaryButton` -- "Create Account", same style as Screen 2
- `LegalText` -- 12sp, #888, "Terms of Service" and "Privacy Policy" as tappable links (#0F3460)

**User Actions:**
- Tap Google button to trigger Google OAuth flow
- Tap Apple button to trigger Apple Sign-In
- Fill email + password + confirm, tap "Create Account"
- Tap eye icon to toggle password visibility
- Tap Terms/Privacy links to open webview

**Navigation:**
- Forward: `/onboarding/profile` (on successful auth)
- Back: `/onboarding/welcome`
- Modal: Terms of Service webview
- Modal: Privacy Policy webview

**RTL Notes:**
- Back arrow flips to right-pointing arrow on right side
- "Sign Up" title stays centered
- Social button icons move to right side
- Text fields: text input aligns right, placeholder aligns right
- Eye icon moves to left side of password field
- Legal text aligns right

**States:**
- **Default:** Form empty, button disabled (grayed out)
- **Filling:** Button remains disabled until all 3 fields valid
- **Validating:** Inline red error text beneath invalid fields (e.g. "Passwords don't match", "Invalid email format")
- **Loading:** Button shows circular spinner, fields disabled, social buttons disabled
- **Error:** Snackbar at bottom -- "Email already registered" / "Network error, try again"
- **Success:** Navigate forward with brief success haptic

---

### Screen 4: Your Profile

- **Route:** `/onboarding/profile`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** Basic user profile. Collects name, age, and relationship status. Minimal friction -- only 3 fields.

```
+-------------------------------+
|  <-     Your Profile          |
+-------------------------------+
|                               |
|   Tell us about you           |
|   (This helps personalize     |
|    your experience)           |
|                               |
|   Your Name                   |
|   +-------------------------+ |
|   | Ahmad                   | |
|   +-------------------------+ |
|                               |
|   Your Age                    |
|   +-------------------------+ |
|   | 28                      | |
|   +-------------------------+ |
|                               |
|   Relationship Status         |
|                               |
|   ( ) Dating                  |
|   ( ) Engaged                 |
|   (o) Married                 |
|   ( ) Long-distance           |
|   ( ) Complicated             |
|                               |
|                               |
|   [      Continue       ]     |
|                               |
|      Skip for now             |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Your Profile" title
- `SectionHeader` -- "Tell us about you", 20sp bold
- `SupportText` -- subtitle in parentheses, 14sp, #888
- `TextFieldLabeled` -- name field, 48dp, text input, max 40 chars
- `TextFieldLabeled` -- age field, 48dp, numeric keyboard, min 18 max 99
- `RadioGroup` -- "Relationship Status", 5 options, each 44dp height, radio circle 20dp, label 16sp
- `PrimaryButton` -- "Continue", full width, enabled when name + age + status filled
- `TextLink` -- "Skip for now", 14sp, #888, centered

**User Actions:**
- Type name (text keyboard)
- Type age (numeric keyboard, validated 18-99)
- Select one relationship status
- Tap "Continue" to proceed
- Tap "Skip for now" to proceed with defaults

**Navigation:**
- Forward: `/onboarding/zodiac`
- Back: `/onboarding/signup`

**RTL Notes:**
- All labels align right
- Text input cursor starts from right
- Radio buttons: circle moves to right side, label on left
- "Skip for now" stays centered

**States:**
- **Default:** Fields empty, Continue button disabled
- **Partial:** Some fields filled, Continue still disabled until all 3 complete
- **Valid:** All fields filled, Continue button active (#E94560)
- **Error:** Inline validation -- "Age must be 18-99", "Name is required"
- **Skip:** Navigate forward, profile fields stored as null (can complete later in settings)

---

### Screen 5: Her Zodiac

- **Route:** `/onboarding/zodiac`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** 12-sign zodiac wheel selector. User picks her zodiac sign. This sets AI personality defaults. Visual wheel with icons and date ranges.

```
+-------------------------------+
|  <-     Her Zodiac      Skip  |
+-------------------------------+
|                               |
|   What's her zodiac sign?     |
|   (This helps us understand   |
|    her personality)           |
|                               |
|        .---Ari---.            |
|      Pis          Tau         |
|    Aqu    [wheel]   Gem       |
|    Cap    center    Can       |
|      Sag          Leo         |
|        '--Sco--Vir--'         |
|            Lib                |
|                               |
|   +-------------------------+ |
|   | [Aries icon]            | |
|   | Aries                   | |
|   | Mar 21 - Apr 19         | |
|   | Bold, passionate,       | |
|   | confident               | |
|   +-------------------------+ |
|                               |
|   Don't know her sign?        |
|   Enter her birthday instead  |
|   +-------------------------+ |
|   | [date picker]           | |
|   +-------------------------+ |
|                               |
|   [      Continue       ]     |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, title, "Skip" text button right
- `SectionHeader` -- "What's her zodiac sign?", 20sp
- `SupportText` -- subtitle, 14sp, #888
- `ZodiacWheel` -- circular arrangement of 12 zodiac icons, each 40x40dp, scrollable/rotatable, selected sign scales to 56dp with accent glow
- `ZodiacDetailCard` -- appears below wheel on selection, 120dp height, icon 48dp, sign name 18sp bold, date range 14sp #888, traits 14sp
- `TextLink` -- "Don't know her sign? Enter her birthday instead"
- `DatePicker` -- standard date picker, calculates zodiac from birthday
- `PrimaryButton` -- "Continue", enabled on selection

**User Actions:**
- Rotate/tap zodiac wheel to select a sign
- Tap a sign icon to select it (detail card appears with animation)
- Tap "Enter her birthday" to reveal date picker
- Pick date, zodiac auto-calculated
- Tap "Continue" to proceed
- Tap "Skip" to skip zodiac setup

**Navigation:**
- Forward: `/onboarding/love-language`
- Back: `/onboarding/profile`

**RTL Notes:**
- Wheel layout remains circular (no directional change)
- Detail card text aligns right
- Date picker uses locale-appropriate format (DD/MM/YYYY for AR)
- "Skip" moves to left side of app bar
- Back arrow flips to right side

**States:**
- **Default:** Wheel visible, no selection, Continue disabled
- **Selected:** Chosen sign highlighted with glow, detail card animates in (slide up 200ms), Continue enabled
- **Birthday mode:** Date picker visible, wheel dimmed, auto-selects zodiac on date pick
- **Skip:** Navigate forward, zodiac stored as null

---

### Screen 6: Her Love Language

- **Route:** `/onboarding/love-language`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** User selects her primary love language from the 5 options. Each option has an icon, title, and short description. Single select.

```
+-------------------------------+
|  <-   Her Love Language Skip  |
+-------------------------------+
|                               |
|   How does she feel most      |
|   loved?                      |
|                               |
|   +-------------------------+ |
|   | [heart]                 | |
|   | Words of Affirmation    | |
|   | She loves hearing "I    | |
|   | love you" and complimts | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [hands]                 | |
|   | Acts of Service         | |
|   | Actions speak louder    | |
|   | than words to her       | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [gift]                  | |
|   | Receiving Gifts         | |
|   | Thoughtful gifts make   | |
|   | her feel special        | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [clock]                 | |
|   | Quality Time            | |
|   | Undivided attention     | |
|   | means everything        | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [hand]                  | |
|   | Physical Touch          | |
|   | Hugs, holding hands,    | |
|   | closeness               | |
|   +-------------------------+ |
|                               |
|   [      Continue       ]     |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, title, "Skip" right
- `SectionHeader` -- "How does she feel most loved?", 20sp
- `LoveLanguageCard` x5 -- each 80dp height, icon 32dp top-left, title 16sp bold, description 14sp #888, radius 12px, border 1px #333
- Selected state: accent border, filled background at 10%, check icon top-right
- `PrimaryButton` -- "Continue", enabled on selection
- Scrollable list (all 5 may not fit on small screens)

**User Actions:**
- Tap a love language card to select it (single select, deselects others)
- Tap "Continue" to proceed
- Tap "Skip" to skip

**Navigation:**
- Forward: `/onboarding/preferences`
- Back: `/onboarding/zodiac`

**RTL Notes:**
- Card icons move to top-right
- Card text aligns right
- Check icon on selection moves to top-left
- Scroll direction unchanged (vertical)

**States:**
- **Default:** All 5 cards visible, none selected, Continue disabled
- **Selected:** Chosen card highlighted, Continue enabled
- **Skip:** Navigate forward, love language stored as null

---

### Screen 7: Her Preferences

- **Route:** `/onboarding/preferences`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** Communication style and interests. Two sections: communication style (single select) and interests (multi-select chips). Last data collection screen before subscription teaser.

```
+-------------------------------+
|  <-   Her Preferences   Skip  |
+-------------------------------+
|                               |
|   Her Communication Style     |
|                               |
|   ( ) Romantic & poetic       |
|   ( ) Playful & funny         |
|   (o) Calm & reassuring       |
|   ( ) Direct & honest         |
|   ( ) Formal & respectful     |
|                               |
|   -------------------------   |
|                               |
|   Her Interests               |
|   (select all that apply)     |
|                               |
|   [Fashion] [Travel] [Food]   |
|   [Books] [Music] [Fitness]   |
|   [Art] [Nature] [Movies]     |
|   [Tech] [Cooking] [Pets]     |
|   [Photography] [Gaming]      |
|   [Spirituality] [Sports]     |
|                               |
|                               |
|   [      Continue       ]     |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, title, "Skip" right
- `SectionHeader` -- "Her Communication Style", 18sp bold
- `RadioGroup` -- 5 communication options, 44dp each, radio + label
- `Divider` -- 1px line, #333, 16dp vertical margin
- `SectionHeader` -- "Her Interests", 18sp bold
- `SupportText` -- "(select all that apply)", 14sp, #888
- `ChipGrid` -- wrap layout, each chip 36dp height, 12dp horizontal padding, radius 18px, outlined default, filled on select (#E94560 bg, white text)
- `PrimaryButton` -- "Continue", enabled when at least communication style is selected

**User Actions:**
- Select one communication style (radio)
- Tap interest chips to toggle (multi-select)
- Tap "Continue" to proceed
- Tap "Skip" to skip

**Navigation:**
- Forward: `/onboarding/subscription`
- Back: `/onboarding/love-language`

**RTL Notes:**
- Radio labels align right, radio circles on right
- Chip grid flows right-to-left (first chip starts top-right)
- Section headers align right

**States:**
- **Default:** Nothing selected, Continue disabled
- **Partial:** Communication style picked, no interests, Continue enabled (interests optional)
- **Full:** Both sections filled, Continue enabled
- **Skip:** Navigate forward, preferences stored as null

---

### Screen 8: Subscription Teaser

- **Route:** `/onboarding/subscription`
- **Module:** Onboarding
- **Sprint:** Sprint 1
- **Description:** Shows three tiers -- Free, Pro, Legend. Feature comparison. CTA to subscribe or continue with free tier. Not a hard paywall. User can always proceed for free.

```
+-------------------------------+
|  <-     Choose Your Plan      |
+-------------------------------+
|                               |
|   Unlock the full LOLO        |
|   experience                  |
|                               |
| +-------+--------+---------+ |
| | Free  | Pro    | Legend   | |
| |       | $4.99  | $9.99   | |
| |       | /mo    | /mo     | |
| +-------+--------+---------+ |
| | 2 msg | Unlim  | Unlim   | |
| | /day  | msgs   | msgs    | |
| +-------+--------+---------+ |
| | Basic | Smart  | Smart+  | |
| | remnd | remind | remind  | |
| +-------+--------+---------+ |
| | No    | SOS    | SOS +   | |
| | SOS   | mode   | coach   | |
| +-------+--------+---------+ |
| | No    | Basic  | AI gift | |
| | gifts | gifts  | engine  | |
| +-------+--------+---------+ |
| | No    | No     | Memory  | |
| | vault | vault  | vault   | |
| +-------+--------+---------+ |
|                               |
|   Most popular: Pro           |
|                               |
|   [  Start Pro Free Trial  ]  |
|                               |
|   Continue with Free plan     |
|                               |
|   7-day free trial, cancel    |
|   anytime                     |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Choose Your Plan" title
- `SubheadText` -- "Unlock the full LOLO experience", 18sp
- `PricingTable` -- 3-column comparison, header row with tier name + price, feature rows with check/cross/text, highlighted column for "Pro" (accent border)
- `BadgeLabel` -- "Most popular: Pro", 14sp, accent color
- `PrimaryButton` -- "Start Pro Free Trial", full width, accent color
- `TextLink` -- "Continue with Free plan", 14sp, centered, #888
- `LegalText` -- "7-day free trial, cancel anytime", 12sp, #888

**User Actions:**
- Tap column header to select a tier (visual highlight switches)
- Tap "Start Pro Free Trial" to initiate in-app purchase flow
- Tap "Continue with Free plan" to skip to home
- Scroll to see full feature comparison on small screens

**Navigation:**
- Forward: `/home` (on subscription or skip)
- Back: `/onboarding/preferences`
- Modal: Platform-native in-app purchase sheet (Google Play / App Store)

**RTL Notes:**
- Table columns remain in same visual order (Free left, Legend right in LTR; reversed in RTL)
- Feature text in rows aligns per locale
- Button and link text centered (no directional change)
- Price formatting: "$4.99" in EN, locale-appropriate in AR/MS

**States:**
- **Default:** Pro column highlighted, trial button active
- **Loading:** Purchase flow in progress, overlay spinner, buttons disabled
- **Success:** "Welcome to Pro!" brief toast, navigate to /home
- **Error:** "Purchase failed. Try again." snackbar with retry
- **Restored:** "Your subscription is active" if previously subscribed
- **Skip:** Navigate to /home with free tier

---

## Dashboard Module

---

### Screen 9: Home Dashboard

- **Route:** `/home`
- **Module:** Dashboard
- **Sprint:** Sprint 2
- **Description:** Main hub. Shows daily action cards feed, thoughtfulness streak, quick action buttons, and daily check-in prompt. Bottom navigation bar anchors here.

```
+-------------------------------+
|  [avatar]  Good morning,  [bell] |
|            Ahmad                  |
+-------------------------------+
|                               |
|   +-------------------------+ |
|   | Streak: 12 days [fire]  | |
|   | Level: Good Partner     | |
|   | Score: 847 pts          | |
|   +-------------------------+ |
|                               |
|   How is she today?           |
|   [Great][Ok][Stressed][Upset]|
|                               |
|   --- Today's Actions ---     |
|                               |
|   +-------------------------+ |
|   | [SAY] She had a long    | |
|   | day. Send her this:     | |
|   | "I know today was..."   | |
|   |            [Copy] [Send]| |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [DO] Anniversary in 3   | |
|   | days. Plan something    | |
|   | special for Friday.     | |
|   |              [View Plan]| |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [BUY] She mentioned     | |
|   | wanting a new scarf.    | |
|   | Budget ideas under $30  | |
|   |             [Browse]    | |
|   +-------------------------+ |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `DashboardAppBar` -- user avatar 36dp circular left, greeting text ("Good morning, Ahmad") 18sp, notification bell icon right with red badge dot
- `StreakCard` -- horizontal card, 64dp height, streak count + fire icon, level label, points, background gradient (dark navy to royal blue)
- `MoodCheckRow` -- "How is she today?" label 14sp, 4 mood buttons (emoji + label), each 56dp wide, horizontal scroll if needed
- `SectionLabel` -- "Today's Actions", 16sp bold, divider line
- `ActionCard` x3 -- SAY/DO/BUY/GO type badge (colored), context text 14sp, message preview 14sp italic, action buttons bottom-right (ghost style)
- `BottomNavBar` -- 5 tabs: Home, Messages, Gifts, SOS, Her Profile; 64dp height, icon 24dp + label 10sp, active tab uses accent color

**User Actions:**
- Tap avatar to go to user settings
- Tap bell to go to notifications
- Tap mood button to submit daily check-in (updates AI context)
- Tap action card to expand to detail view
- Tap Copy/Send/Browse/View Plan buttons on cards
- Swipe action cards horizontally to dismiss or save
- Pull-to-refresh to regenerate action cards
- Tap bottom nav tabs to switch modules

**Navigation:**
- Forward: `/notifications` (bell icon)
- Forward: `/settings` (avatar)
- Forward: `/home/checkin` (mood button, if expanded flow needed)
- Forward: `/actions/detail` (card tap)
- Tab: `/messages` | `/gifts` | `/sos` | `/her-profile` (bottom nav)

**RTL Notes:**
- Avatar moves to right, bell icon to left
- Greeting text aligns right
- Streak card content aligns right, fire icon on left
- Mood buttons order reverses (right-to-left reading)
- Action cards: type badge moves to top-right, action buttons to bottom-left
- Bottom nav: tab order stays same visually (Home always leftmost in LTR, rightmost in RTL)
- Swipe dismiss direction reverses

**States:**
- **Loading:** Skeleton shimmer on streak card and action cards (3 placeholder cards)
- **Default:** Streak card + mood check + 2-4 action cards
- **Empty (new user):** "Welcome to LOLO! Start by telling us about her" with CTA to /her-profile
- **Empty (no actions):** "All caught up! You're doing great." illustration
- **Error:** "Couldn't load your dashboard. Pull to refresh." with retry
- **Offline:** Cached action cards shown with "Offline" badge, mood check disabled

---

### Screen 10: Daily Check-in

- **Route:** `/home/checkin`
- **Module:** Dashboard
- **Sprint:** Sprint 2
- **Description:** 5-second mood/status tap. User reports how she is doing today. This feeds the AI context engine. Quick bottom sheet overlay on home screen.

```
+-------------------------------+
|                               |
|   (dim overlay on home)       |
|                               |
+-------------------------------+
|   How is she today?           |
|                               |
|   +------+ +------+ +------+ |
|   |[smiley]| [meh] | [sad] | |
|   | Great | |  Ok  | |Stress| |
|   +------+ +------+ +------+ |
|   +------+ +------+          |
|   |[angry]| [sick]|          |
|   | Upset | | Sick |          |
|   +------+ +------+          |
|                               |
|   Quick tags (optional):      |
|                               |
|   [Busy week] [Traveling]     |
|   [Conflict] [Period]         |
|   [Pregnant] [Sick]           |
|                               |
|   [      Done       ]        |
|                               |
|   Yesterday: Great            |
+-------------------------------+
```

**Components:**
- `BottomSheet` -- slides up from bottom, 400dp max height, drag handle top-center, radius 16px top corners, dim overlay behind
- `SheetTitle` -- "How is she today?", 18sp bold
- `MoodGrid` -- 5 mood options in 3+2 grid, each 80x80dp, icon 40dp + label 12sp, radius 12px, outlined default, filled on select
- `TagChipRow` -- "Quick tags (optional)" label 14sp, wrap layout of context chips, 32dp height, outlined, multi-select
- `PrimaryButton` -- "Done", full width within sheet, 48dp
- `HistoryHint` -- "Yesterday: Great", 12sp, #888, bottom of sheet

**User Actions:**
- Tap mood option (single select, required)
- Tap context tags (multi-select, optional)
- Tap "Done" to submit and close sheet
- Swipe down or tap overlay to dismiss without saving
- Haptic feedback on mood selection

**Navigation:**
- Dismiss: returns to `/home` (bottom sheet closes)
- No forward navigation (overlay only)

**RTL Notes:**
- Mood grid: items flow right-to-left
- Tag chips flow right-to-left
- "Yesterday" hint aligns right
- Drag handle stays centered

**States:**
- **Default:** No mood selected, Done button disabled
- **Selected:** One mood chosen (highlighted), Done enabled
- **With tags:** Mood + tags selected, Done enabled
- **Submitting:** Done button shows spinner, brief 200ms
- **Success:** Sheet closes with slide-down, home dashboard refreshes action cards based on new context
- **Already checked:** If already submitted today, show "Update check-in?" with current selection pre-filled

---

### Screen 11: Notifications

- **Route:** `/notifications`
- **Module:** Dashboard
- **Sprint:** Sprint 2
- **Description:** Notification center. Lists all app notifications grouped by date. Reminders, AI suggestions, streak alerts, system messages.

```
+-------------------------------+
|  <-     Notifications         |
+-------------------------------+
|                               |
|   Today                       |
|   +-------------------------+ |
|   | [bell] Anniversary in   | |
|   | 3 days! Start planning. | |
|   | 2h ago              [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [msg] New message idea  | |
|   | for her ready.          | |
|   | 4h ago              [>] | |
|   +-------------------------+ |
|                               |
|   Yesterday                   |
|   +-------------------------+ |
|   | [fire] 11-day streak!   | |
|   | Keep it going.          | |
|   | 1d ago                  | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [gift] Gift idea based  | |
|   | on her wish list.       | |
|   | 1d ago              [>] | |
|   +-------------------------+ |
|                               |
|   Earlier                     |
|   +-------------------------+ |
|   | [sos] Check in with     | |
|   | her -- she seemed       | |
|   | stressed yesterday.     | |
|   | 3d ago              [>] | |
|   +-------------------------+ |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Notifications" title, no right action
- `DateSectionHeader` -- "Today" / "Yesterday" / "Earlier", 14sp bold, #888, sticky header on scroll
- `NotificationTile` -- icon left (24dp, color-coded by type), title 16sp bold, body 14sp #888, timestamp 12sp #666 bottom-left, chevron right (if actionable), 72dp min height, full width, divider between items
- Notification types: reminder (blue bell), message (green chat), streak (orange fire), gift (pink gift), sos (red alert), system (gray gear)
- `BottomNavBar` -- same as home

**User Actions:**
- Tap notification to navigate to relevant screen
- Swipe left to dismiss/mark as read
- Pull to refresh for new notifications
- Scroll to load older notifications (pagination)

**Navigation:**
- Back: `/home`
- Forward: varies by notification type -- reminder goes to `/reminders`, message to `/messages/result`, streak to `/gamification`, gift to `/gifts/detail`, sos to `/sos`

**RTL Notes:**
- Icon moves to right side
- Text aligns right
- Timestamp stays at same relative position (end-aligned)
- Chevron flips to left-pointing, on left side
- Swipe to dismiss: swipe right instead of left

**States:**
- **Loading:** Skeleton list, 5 placeholder tiles
- **Default:** Grouped notifications list
- **Empty:** "No notifications yet. We'll keep you posted!" with illustration
- **Error:** "Couldn't load notifications. Pull to refresh."
- **Unread:** Unread items have accent-colored left border (4dp) or subtle background tint
- **All read:** All items in default style, no badge on bell icon in home

---

## Her Profile Module

---

### Screen 12: Profile Overview

- **Route:** `/her-profile`
- **Module:** Her Profile
- **Sprint:** Sprint 2
- **Description:** Summary card showing all key traits at a glance. Zodiac, love language, communication style, interests, cultural settings. Each section tappable to edit.

```
+-------------------------------+
|  <-     Her Profile     [edit]|
+-------------------------------+
|                               |
|   +-------------------------+ |
|   |      [zodiac icon]      | |
|   |        Aries            | |
|   |   "Bold & passionate"   | |
|   |   Love lang: Quality    | |
|   |   Time                  | |
|   |   Style: Calm &         | |
|   |   reassuring            | |
|   +-------------------------+ |
|                               |
|   Personality Traits          |
|   +-------------------------+ |
|   | [zodiac] Zodiac &       | |
|   | Personality         [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [heart] Love Language   | |
|   |                     [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [chat] Communication    | |
|   | & Preferences       [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [mosque] Cultural &     | |
|   | Religious           [>] | |
|   +-------------------------+ |
|                               |
|   Quick Facts                 |
|   +-------------------------+ |
|   | Interests: Fashion,     | |
|   | Travel, Cooking, Art    | |
|   | Humor: Loves jokes      | |
|   | Conflict: Needs space   | |
|   +-------------------------+ |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Her Profile" title, edit icon (pencil) right
- `ProfileSummaryCard` -- centered layout, zodiac icon 64dp, sign name 20sp bold, tagline 14sp italic #888, love language 14sp, communication style 14sp, radius 16px, gradient background
- `SectionLabel` -- "Personality Traits", 16sp bold
- `NavigationTile` x4 -- icon left 24dp, title 16sp, chevron right, 56dp height, tappable to sub-screens
- `SectionLabel` -- "Quick Facts", 16sp bold
- `QuickFactsCard` -- key-value list, label 14sp bold, value 14sp #888, compact layout
- `BottomNavBar` -- active state on "Her" tab

**User Actions:**
- Tap edit icon to enable edit mode across all fields
- Tap any NavigationTile to go to detailed edit screen
- Tap Quick Facts card to edit interests/humor/conflict
- Scroll to see full profile

**Navigation:**
- Forward: `/her-profile/zodiac` (Zodiac tile)
- Forward: `/her-profile/preferences` (Communication tile, Love Language tile)
- Forward: `/her-profile/cultural` (Cultural tile)
- Back: `/home`

**RTL Notes:**
- Icons move to right in navigation tiles
- Chevrons flip to left-pointing, move to left side
- Profile summary card text aligns right
- Quick facts labels align right

**States:**
- **Loading:** Skeleton card + shimmer tiles
- **Default:** Full profile displayed
- **Incomplete:** Missing sections show "Not set" in #888 with "Add" link in accent color
- **Empty (new user):** "Tell us about her to unlock personalized features" CTA with illustration
- **Error:** "Couldn't load profile. Pull to refresh."

---

### Screen 13: Edit Zodiac & Personality

- **Route:** `/her-profile/zodiac`
- **Module:** Her Profile
- **Sprint:** Sprint 2
- **Description:** Edit zodiac sign and AI-generated personality traits. User can override any AI default. Shows zodiac wheel plus editable trait sliders.

```
+-------------------------------+
|  <-   Zodiac & Personality    |
+-------------------------------+
|                               |
|   Her Zodiac Sign             |
|                               |
|   +-------------------------+ |
|   | [Aries icon] Aries      | |
|   | Mar 21 - Apr 19  [change]|
|   +-------------------------+ |
|                               |
|   AI-Generated Traits         |
|   (adjust to match her)       |
|                               |
|   Romantic    [----o----]     |
|   Low                  High   |
|                               |
|   Adventurous [------o--]     |
|   Low                  High   |
|                               |
|   Emotional   [--o------]     |
|   Low                  High   |
|                               |
|   Social      [----o----]     |
|   Low                  High   |
|                               |
|   Spontaneous [--------o]     |
|   Low                  High   |
|                               |
|   -------------------------   |
|                               |
|   Conflict Style              |
|   ( ) Needs space first       |
|   (o) Wants to talk now       |
|   ( ) Needs physical comfort  |
|   ( ) Needs written words     |
|                               |
|   Humor Level                 |
|   [--o------]                 |
|   Serious       Loves jokes   |
|                               |
|   [       Save        ]      |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, title
- `SectionLabel` -- "Her Zodiac Sign", 16sp bold
- `ZodiacDisplayCard` -- icon 48dp, sign name 18sp bold, date range 14sp #888, "change" text button right, tappable to open zodiac wheel modal
- `SectionLabel` -- "AI-Generated Traits", 16sp bold
- `SupportText` -- "(adjust to match her)", 14sp #888
- `TraitSlider` x5 -- label 14sp left, slider (continuous, 0-100), low/high labels 12sp #888, thumb 24dp accent color
- `Divider`
- `RadioGroup` -- "Conflict Style", 4 options
- `TraitSlider` -- "Humor Level" with custom labels
- `PrimaryButton` -- "Save"

**User Actions:**
- Tap "change" to open zodiac wheel modal (same as onboarding Screen 5)
- Drag sliders to adjust traits
- Select conflict style
- Tap "Save" to persist changes

**Navigation:**
- Back: `/her-profile`
- Modal: Zodiac wheel picker (same component as onboarding)

**RTL Notes:**
- Slider direction reverses (low on right, high on left)
- Labels swap positions accordingly
- Radio labels align right
- "change" link moves to left side

**States:**
- **Default:** Current values loaded from profile
- **Modified:** Unsaved changes, "Save" button pulses subtly, back button shows "Discard changes?" dialog
- **Saving:** Button shows spinner
- **Saved:** Brief green checkmark animation, auto-navigate back
- **Error:** "Couldn't save. Try again." snackbar

---

### Screen 14: Edit Preferences

- **Route:** `/her-profile/preferences`
- **Module:** Her Profile
- **Sprint:** Sprint 2
- **Description:** Edit communication style, interests, stress triggers, sensitive topics, and favorites. Comprehensive personality data.

```
+-------------------------------+
|  <-     Her Preferences       |
+-------------------------------+
|                               |
|   Communication Style         |
|   ( ) Romantic & poetic       |
|   (o) Calm & reassuring       |
|   ( ) Playful & funny         |
|   ( ) Direct & honest         |
|   ( ) Formal & respectful     |
|                               |
|   Love Language               |
|   [Words] [Acts] [Gifts]     |
|   [Time*] [Touch]            |
|                               |
|   Her Interests               |
|   [Fashion*] [Travel*]       |
|   [Cooking*] [Art*] [Books]  |
|   [Music] [Fitness] [+more]  |
|                               |
|   Stress Triggers             |
|   +-------------------------+ |
|   | Work deadlines, family  | |
|   | conflict, health worries| |
|   +-------------------------+ |
|                               |
|   Sensitive Topics (avoid)    |
|   +-------------------------+ |
|   | Past relationships,     | |
|   | weight discussions      | |
|   +-------------------------+ |
|                               |
|   Preferred Message Language  |
|   [English*] [Arabic] [Malay]|
|                               |
|   [       Save        ]      |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, title
- `RadioGroup` -- Communication Style, 5 options
- `ChipGroup` -- Love Language, single select, active chip filled
- `ChipGrid` -- Interests, multi-select, wrap layout, [+more] expands full list
- `TextArea` -- Stress Triggers, multi-line, 80dp height, placeholder text, max 200 chars
- `TextArea` -- Sensitive Topics, same spec
- `ChipGroup` -- Preferred Message Language, single select
- `PrimaryButton` -- "Save"

**User Actions:**
- Select communication style (radio)
- Tap love language chips (single select)
- Toggle interest chips (multi-select)
- Tap "+more" to expand full interest list
- Type in stress triggers and sensitive topics text areas
- Select preferred message language
- Tap "Save"

**Navigation:**
- Back: `/her-profile`

**RTL Notes:**
- All radio labels right-aligned
- Chip grid flows right-to-left
- Text areas: cursor starts right, text aligns right
- Language chips: same visual order as language selector

**States:**
- **Default:** Current values loaded
- **Modified:** Unsaved indicator, discard dialog on back
- **Saving:** Spinner on button
- **Saved:** Checkmark, navigate back
- **Error:** Snackbar with retry

---

### Screen 15: Cultural-Religious Settings

- **Route:** `/her-profile/cultural`
- **Module:** Her Profile
- **Sprint:** Sprint 3
- **Description:** Cultural background, religious observance, holiday preferences. Affects AI content generation and reminder suggestions.

```
+-------------------------------+
|  <-   Cultural & Religious    |
+-------------------------------+
|                               |
|   Cultural Background         |
|   +-------------------------+ |
|   | [dropdown]              | |
|   | Arab / Malay / Western  | |
|   | South Asian / East Asian| |
|   | African / Latin / Other | |
|   +-------------------------+ |
|                               |
|   Religious Observance        |
|   +-------------------------+ |
|   | [dropdown]              | |
|   | Muslim / Christian /    | |
|   | Hindu / Buddhist /      | |
|   | Jewish / None / Other   | |
|   +-------------------------+ |
|                               |
|   Holiday Preferences         |
|   (which holidays matter?)    |
|                               |
|   [x] Islamic holidays        |
|   [x] Eid al-Fitr             |
|   [x] Eid al-Adha             |
|   [x] Ramadan                 |
|   [ ] Christmas                |
|   [ ] Valentine's Day         |
|   [x] Hari Raya               |
|   [ ] Chinese New Year        |
|   [x] National Day            |
|   [ ] Diwali                  |
|   [+] Add custom holiday      |
|                               |
|   Dietary Restrictions        |
|   [Halal*] [Vegetarian]      |
|   [No pork] [No alcohol*]    |
|   [Gluten-free] [+Custom]    |
|                               |
|   [       Save        ]      |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, title
- `DropdownField` -- Cultural Background, bottom sheet picker with list
- `DropdownField` -- Religious Observance, bottom sheet picker
- `SectionLabel` -- "Holiday Preferences"
- `SupportText` -- "(which holidays matter?)"
- `CheckboxList` -- holidays, each 44dp height, multi-select, grouped by religion/culture
- `AddButton` -- "+Add custom holiday", text button, opens inline text field
- `SectionLabel` -- "Dietary Restrictions"
- `ChipGrid` -- dietary chips, multi-select, "+Custom" opens text input
- `PrimaryButton` -- "Save"

**User Actions:**
- Select cultural background from dropdown
- Select religious observance from dropdown
- Toggle holiday checkboxes
- Add custom holiday
- Toggle dietary restriction chips
- Add custom dietary restriction
- Tap "Save"

**Navigation:**
- Back: `/her-profile`
- Modal: Dropdown picker bottom sheets

**RTL Notes:**
- Dropdown arrows flip direction
- Checkbox: box moves to right, label on left
- Chip grid flows right-to-left
- Holiday names stay in original language/script where appropriate

**States:**
- **Default:** Current values loaded, pre-populated based on language selection
- **Modified:** Unsaved changes indicator
- **Saving/Saved/Error:** Same pattern as other edit screens
- **Smart defaults:** If user selected Arabic language and Muslim religion, Islamic holidays pre-checked

---

## Smart Reminders Module

---

### Screen 16: Reminders List

- **Route:** `/reminders`
- **Module:** Smart Reminders
- **Sprint:** Sprint 3
- **Description:** All reminders in calendar or list view. Toggle between views. Color-coded by type. Upcoming reminders sorted chronologically.

```
+-------------------------------+
|  <-      Reminders      [+]  |
+-------------------------------+
|   [Calendar view] [List view] |
|                               |
|   +-------------------------+ |
|   |  Feb 2026               | |
|   | Su Mo Tu We Th Fr Sa    | |
|   |                    1  2  | |
|   |  3  4  5  6  7  8  9   | |
|   | 10 11 12 13[14]15 16   | |
|   | 17 18 19 20 21 22 23   | |
|   | 24 25 26 27 28         | |
|   |        *  *     *       | |
|   +-------------------------+ |
|                               |
|   Upcoming                    |
|   +-------------------------+ |
|   | [heart] Anniversary     | |
|   | Feb 17 -- in 3 days     | |
|   | Escalation: Active      | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [cake] Her Birthday     | |
|   | Mar 21 -- in 35 days    | |
|   | Escalation: Not yet     | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [repeat] Weekly flowers | |
|   | Every Friday            | |
|   | Next: Feb 21            | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [ring] Promise: Take    | |
|   | her to that restaurant  | |
|   | Due: Feb 28             | |
|   +-------------------------+ |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Reminders" title, "+" add button right
- `ViewToggle` -- segmented control, "Calendar view" / "List view", 40dp height, accent fill on active segment
- `CalendarWidget` -- month view, 240dp height, today highlighted with circle, dates with reminders have colored dots below (red for important, blue for recurring, green for promises)
- `SectionLabel` -- "Upcoming", 16sp bold
- `ReminderTile` -- icon left (24dp, color-coded), title 16sp bold, date + countdown 14sp #888, escalation status 12sp (green "Active" / gray "Not yet"), chevron right, 72dp height
- Reminder types: anniversary (red heart), birthday (pink cake), recurring (blue repeat), promise (gold ring), custom (gray calendar)
- `BottomNavBar`

**User Actions:**
- Toggle calendar/list view
- Tap calendar date to filter reminders for that day
- Tap "+" to create new reminder
- Tap reminder tile to view/edit
- Swipe left on tile to delete (with confirmation)
- Swipe month left/right to navigate calendar

**Navigation:**
- Forward: `/reminders/create` (+ button or empty day tap)
- Forward: `/reminders/create?id=xxx` (tile tap for edit)
- Forward: `/reminders/promises` (promise tile or dedicated tab)
- Back: `/home`

**RTL Notes:**
- Calendar: week starts Saturday for Arabic locale, day names in Arabic
- Calendar swipe direction reverses (swipe left = next month in LTR, previous in RTL)
- Reminder tiles: icon right, chevron left (flipped)
- Date countdown text aligns right

**States:**
- **Loading:** Skeleton calendar + 3 shimmer tiles
- **Default:** Calendar + reminder list
- **Empty:** "No reminders yet. Never miss what matters." + "Create your first reminder" CTA
- **Calendar empty day:** "Nothing on this day. Tap + to add."
- **Error:** "Couldn't load reminders. Pull to refresh."
- **List view:** Flat chronological list without calendar widget, grouped by month

---

### Screen 17: Create/Edit Reminder

- **Route:** `/reminders/create`
- **Module:** Smart Reminders
- **Sprint:** Sprint 3
- **Description:** Form to create or edit a reminder. Date picker, time picker, recurrence options, notification escalation settings, category selection.

```
+-------------------------------+
|  <-   New Reminder     [save]|
+-------------------------------+
|                               |
|   Title                       |
|   +-------------------------+ |
|   | Her Birthday            | |
|   +-------------------------+ |
|                               |
|   Category                    |
|   [Bday] [Anniv] [Date]     |
|   [Promise] [Custom]         |
|                               |
|   Date                        |
|   +-------------------------+ |
|   | Mar 21, 2026     [cal]  | |
|   +-------------------------+ |
|                               |
|   Time (optional)             |
|   +-------------------------+ |
|   | 9:00 AM          [clk]  | |
|   +-------------------------+ |
|                               |
|   Recurring                   |
|   [OFF] [Daily] [Weekly]     |
|   [Monthly] [Yearly*]        |
|                               |
|   Notification Escalation     |
|   [x] 7 days before          |
|   [x] 3 days before          |
|   [x] 1 day before           |
|   [x] Same day morning       |
|   [ ] Same day (custom time) |
|                               |
|   Notes                       |
|   +-------------------------+ |
|   | She wants to go to that | |
|   | Italian place            | |
|   +-------------------------+ |
|                               |
|   Link to gift suggestion?    |
|   [ ] Auto-suggest gifts      |
|       before this date        |
|                               |
|   [    Save Reminder    ]     |
|                               |
|   [Delete] (edit mode only)   |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "New Reminder" / "Edit Reminder" title, save icon right (checkmark)
- `TextFieldLabeled` -- Title, 48dp, max 60 chars
- `ChipGroup` -- Category, single select, 5 options
- `DatePickerField` -- date field with calendar icon, taps opens native date picker
- `TimePickerField` -- time field with clock icon, optional, taps opens time picker
- `ChipGroup` -- Recurring options, single select, "OFF" default
- `SectionLabel` -- "Notification Escalation"
- `CheckboxList` -- 5 escalation options, pre-checked defaults (7d, 3d, 1d, same day)
- `TextArea` -- Notes, 80dp, optional, max 300 chars
- `CheckboxSingle` -- "Auto-suggest gifts" toggle
- `PrimaryButton` -- "Save Reminder"
- `DestructiveButton` -- "Delete", red text, only visible in edit mode, shows confirmation dialog

**User Actions:**
- Fill title
- Select category
- Pick date (required) and time (optional)
- Select recurrence
- Toggle notification escalation checkboxes
- Add notes
- Toggle gift auto-suggest
- Save or delete

**Navigation:**
- Back: `/reminders` (with discard dialog if unsaved changes)
- Forward: `/reminders` (on save)
- Modal: Date picker, Time picker, Delete confirmation dialog

**RTL Notes:**
- All field labels align right
- Calendar/clock icons move to left side
- Chips flow right-to-left
- Checkboxes: box on right, label on left
- Date format: locale-appropriate

**States:**
- **Create mode:** All fields empty, Delete hidden, title "New Reminder"
- **Edit mode:** Fields pre-filled, Delete visible, title "Edit Reminder"
- **Validation:** Title required, Date required; inline errors if missing on save attempt
- **Saving:** Button spinner
- **Saved:** Navigate back to list with success toast
- **Deleted:** Confirmation dialog, then navigate back with "Reminder deleted" toast

---

### Screen 18: Promise Tracker

- **Route:** `/reminders/promises`
- **Module:** Smart Reminders
- **Sprint:** Sprint 3
- **Description:** List of promises made to her. Status tracking: pending, in progress, kept, broken. Filtered view of promise-type reminders with accountability focus.

```
+-------------------------------+
|  <-   Promise Tracker   [+]  |
+-------------------------------+
|                               |
|   Promises kept: 8/10 (80%)  |
|   [========--] progress bar   |
|                               |
|   Active Promises             |
|   +-------------------------+ |
|   | [ ] Take her to that    | |
|   |     Italian restaurant  | |
|   |     Due: Feb 28         | |
|   |     [Mark Done]         | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [ ] Fix the kitchen     | |
|   |     shelf               | |
|   |     Due: Mar 5          | |
|   |     [Mark Done]         | |
|   +-------------------------+ |
|                               |
|   Completed                   |
|   +-------------------------+ |
|   | [x] Bought her the      | |
|   |     earrings she wanted | |
|   |     Kept: Feb 10        | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [x] Called her mom on    | |
|   |     her birthday        | |
|   |     Kept: Feb 5         | |
|   +-------------------------+ |
|                               |
|   Broken (overdue)            |
|   +-------------------------+ |
|   | [!] Learn to cook that  | |
|   |     pasta dish          | |
|   |     Was due: Jan 15     | |
|   |  [Reschedule] [Remove]  | |
|   +-------------------------+ |
|                               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Promise Tracker" title, "+" button right
- `ProgressSummary` -- "Promises kept: X/Y (Z%)", 16sp, progress bar below (accent fill, 8dp height, radius 4dp)
- `SectionLabel` -- "Active Promises" / "Completed" / "Broken (overdue)"
- `PromiseTile` -- checkbox left, promise text 16sp, due date 14sp #888, action button(s) right
- Active: unchecked, "Mark Done" ghost button
- Completed: checked (green), completion date shown, strikethrough text
- Broken: warning icon (red !), overdue date in red, "Reschedule" and "Remove" buttons
- `FAB` or AppBar "+" -- create new promise (navigates to create form)

**User Actions:**
- Tap "+" to add new promise
- Tap "Mark Done" to complete a promise (confetti animation)
- Tap "Reschedule" to update due date
- Tap "Remove" to delete (with confirmation)
- Tap promise tile to edit details
- Pull to refresh

**Navigation:**
- Forward: `/reminders/create?type=promise` (+ button)
- Back: `/reminders`
- Modal: Reschedule date picker, Remove confirmation

**RTL Notes:**
- Checkbox moves to right
- Promise text aligns right
- Action buttons move to left
- Progress bar fills from right to left

**States:**
- **Loading:** Skeleton progress bar + 3 shimmer tiles
- **Default:** Grouped list (active, completed, broken)
- **Empty:** "No promises tracked yet. Log a promise and never forget." + illustration
- **All kept:** "100% kept! You're a man of your word." celebration card at top
- **Error:** "Couldn't load promises. Pull to refresh."

---

## AI Message Generator Module

---

### Screen 19: Mode Picker

- **Route:** `/messages`
- **Module:** AI Message Generator
- **Sprint:** Sprint 3
- **Description:** Grid of 10 situational message modes. Each mode has an icon, label, and brief description. User picks a situation, then configures the message.

```
+-------------------------------+
|  <-     AI Messages           |
+-------------------------------+
|                               |
|   What do you want to         |
|   say to her?                 |
|                               |
|   +----------+ +----------+  |
|   | [heart]  | | [sorry]  |  |
|   | Apprec-  | | Apology  |  |
|   | iation   | | & Repair |  |
|   +----------+ +----------+  |
|   +----------+ +----------+  |
|   | [hug]    | | [muscle] |  |
|   | Reassur- | | Motivate |  |
|   | ance     | | & Encour |  |
|   +----------+ +----------+  |
|   +----------+ +----------+  |
|   | [party]  | | [fire]   |  |
|   | Celebra- | | Flirting |  |
|   | tion     | | & Romance|  |
|   +----------+ +----------+  |
|   +----------+ +----------+  |
|   | [band]   | | [plane]  |  |
|   | After    | | Long     |  |
|   | Argument | | Distance |  |
|   +----------+ +----------+  |
|   +----------+ +----------+  |
|   | [sun]    | | [wave]   |  |
|   | Good AM/ | | Checking |  |
|   | Good PM  | | on You   |  |
|   +----------+ +----------+  |
|                               |
|   [History]                   |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "AI Messages" title
- `SectionHeader` -- "What do you want to say to her?", 20sp
- `ModeCard` x10 -- 2-column grid, each card ~160x100dp, icon 32dp centered top, label 14sp bold center, brief desc 12sp #888 center, radius 12px, border 1px #333, tap ripple effect
- `TextLink` -- "History" button, 16sp, accent color, centered, navigates to history
- `BottomNavBar` -- active on Messages tab

**User Actions:**
- Tap a mode card to proceed to message configuration
- Tap "History" to view past generated messages
- Scroll to see all 10 modes

**Navigation:**
- Forward: `/messages/configure?mode=xxx` (card tap)
- Forward: `/messages/history` (History link)
- Back: `/home`

**RTL Notes:**
- Grid flows right-to-left (first card top-right)
- Card content centered (no directional change needed for centered content)
- "History" link stays centered

**States:**
- **Default:** All 10 cards displayed in grid
- **Loading:** Not needed (static content, locally stored)
- **Pro locked:** Free tier users see lock icon on modes 5-10, tap shows upgrade prompt
- **Empty:** Not applicable (always shows 10 modes)

---

### Screen 20: Message Config

- **Route:** `/messages/configure`
- **Module:** AI Message Generator
- **Sprint:** Sprint 3
- **Description:** Configure message before generation. Tone selection, humor level, language override, optional context input. Quick setup before AI generates.

```
+-------------------------------+
|  <-   Appreciation Message    |
+-------------------------------+
|                               |
|   Tone                        |
|   [Romantic*] [Funny]        |
|   [Poetic] [Casual] [Formal] |
|                               |
|   Humor Level                 |
|   [----o--------]            |
|   None         Max            |
|                               |
|   Message Language            |
|   [English*] [Arabic] [Malay]|
|                               |
|   Add context (optional)      |
|   +-------------------------+ |
|   | She just got promoted   | |
|   | at work                 | |
|   +-------------------------+ |
|                               |
|   Message Length              |
|   [Short*] [Medium] [Long]   |
|                               |
|   Include her name?           |
|   [Yes*] [No]                |
|                               |
|                               |
|   [   Generate Message   ]   |
|                               |
|   [lightning] Uses 1 of 2     |
|   daily free messages         |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, dynamic title based on selected mode ("Appreciation Message", "Apology Message", etc.)
- `SectionLabel` -- "Tone", 16sp bold
- `ChipGroup` -- 5 tone options, single select, pre-selected based on mode (Appreciation defaults to Romantic, Apology defaults to Formal)
- `TraitSlider` -- Humor Level, 0-100, label "None" to "Max"
- `ChipGroup` -- Message Language, single select, defaults to her preferred language from profile
- `TextArea` -- "Add context", 64dp, placeholder text, optional, max 200 chars
- `ChipGroup` -- Message Length, 3 options
- `ChipGroup` -- Include name, 2 options
- `PrimaryButton` -- "Generate Message", accent color, full width
- `UsageHint` -- lightning icon + "Uses 1 of X daily free messages", 12sp, #888

**User Actions:**
- Select tone (single select)
- Adjust humor slider
- Override message language
- Type optional context
- Select message length
- Toggle name inclusion
- Tap "Generate Message"

**Navigation:**
- Forward: `/messages/result` (on generate)
- Back: `/messages`

**RTL Notes:**
- All chip groups flow right-to-left
- Slider: "None" on right, "Max" on left in RTL
- Text area cursor starts right
- Usage hint: lightning icon moves to right

**States:**
- **Default:** Pre-filled with smart defaults based on mode + her profile
- **Generating:** Button shows "Generating..." with animated dots, all inputs disabled
- **Quota exceeded:** Button disabled, shows "Upgrade to Pro for unlimited messages" with link to /paywall
- **Error:** "Generation failed. Try again." snackbar
- **Offline:** "You need internet to generate messages." with cached suggestion

---

### Screen 21: Message Result

- **Route:** `/messages/result`
- **Module:** AI Message Generator
- **Sprint:** Sprint 3
- **Description:** Shows the AI-generated message. User can copy, share, regenerate, edit, or save. Star rating for feedback.

```
+-------------------------------+
|  <-      Your Message         |
+-------------------------------+
|                               |
|   +-------------------------+ |
|   |                         | |
|   | "I just wanted you to   | |
|   | know that watching you  | |
|   | grow in your career     | |
|   | makes me so proud.      | |
|   | You deserve every bit   | |
|   | of this success, and    | |
|   | I'm lucky to be the     | |
|   | one cheering you on.    | |
|   | Tonight, let's celebrate | |
|   | -- just you and me."    | |
|   |                         | |
|   +-------------------------+ |
|                               |
|   +------+ +------+ +------+ |
|   |[copy]| |[share]| |[edit]| |
|   | Copy | | Share | | Edit | |
|   +------+ +------+ +------+ |
|                               |
|   How was this message?       |
|   [star][star][star][star][star]|
|                               |
|   [  Regenerate  ]           |
|                               |
|   +-------------------------+ |
|   | [lightbulb] Tip: Send   | |
|   | this with flowers for   | |
|   | maximum impact.         | |
|   +-------------------------+ |
|                               |
|   [  Save to History  ]      |
|                               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Your Message" title
- `MessageCard` -- the generated message, 16sp, line-height 1.6, padding 20dp, radius 16px, subtle gradient border, min height 120dp
- `ActionButtonRow` -- 3 icon buttons in row, each 56dp, icon 24dp + label 12sp, outlined style
  - Copy: copies to clipboard, shows "Copied!" toast
  - Share: opens native share sheet
  - Edit: makes message editable (inline text editing)
- `RatingRow` -- "How was this message?" 14sp, 5 star icons 32dp each, tap to rate (1-5), accent fill on rated stars
- `SecondaryButton` -- "Regenerate", outlined, full width, generates new message with same config
- `TipCard` -- lightbulb icon, contextual tip from AI, 14sp, subtle background
- `SecondaryButton` -- "Save to History", outlined

**User Actions:**
- Tap Copy to clipboard
- Tap Share to open share sheet (WhatsApp, SMS, etc.)
- Tap Edit to enable inline editing of message text
- Tap stars to rate the message (feeds AI learning)
- Tap Regenerate to get a new version
- Tap Save to History
- Read the contextual tip

**Navigation:**
- Back: `/messages/configure` (back arrow)
- Forward: `/messages/history` (after save)
- Modal: Native share sheet

**RTL Notes:**
- Message text auto-aligns based on language (right for Arabic, left for English)
- Action buttons: order stays same (visually centered)
- Stars: order stays same (left-to-right fill even in RTL, as star ratings are universally LTR)
- Tip card icon moves to right in RTL

**States:**
- **Loading:** Message card shows typing animation (animated dots) while AI generates
- **Default:** Message displayed with all actions
- **Edited:** User has modified text, "edited" badge appears on card
- **Rated:** Stars filled, brief "Thanks!" animation
- **Regenerating:** Message card shows typing animation again, previous message fades out
- **Saved:** "Saved to History" toast, Save button changes to "Saved" (disabled)
- **Error:** "Couldn't generate message. Check your connection." with Retry button

---

### Screen 22: Message History

- **Route:** `/messages/history`
- **Module:** AI Message Generator
- **Sprint:** Sprint 4
- **Description:** List of all previously generated/saved messages. Filterable by mode, date, rating. User can re-copy, re-share, or delete old messages.

```
+-------------------------------+
|  <-   Message History         |
+-------------------------------+
|   Filter: [All] [Sent] [Saved]|
|                               |
|   February 2026               |
|   +-------------------------+ |
|   | [heart] Appreciation    | |
|   | "I just wanted you to   | |
|   | know that watching..."  | |
|   | Feb 14 -- 4 stars       | |
|   |          [copy] [share] | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [sorry] Apology         | |
|   | "I know I was wrong     | |
|   | about last night..."    | |
|   | Feb 10 -- 5 stars       | |
|   |          [copy] [share] | |
|   +-------------------------+ |
|                               |
|   January 2026                |
|   +-------------------------+ |
|   | [sun] Good Morning      | |
|   | "Rise and shine,        | |
|   | beautiful. Today is..." | |
|   | Jan 28 -- 3 stars       | |
|   |          [copy] [share] | |
|   +-------------------------+ |
|                               |
|   (scroll for more)          |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Message History" title
- `FilterChipRow` -- horizontal scroll, chips: All, Sent, Saved, or filter by mode type
- `DateSectionHeader` -- "February 2026", sticky header, 14sp bold #888
- `MessageHistoryTile` -- mode icon + label 14sp top-left, message preview (2 lines truncated) 14sp, date + star rating bottom-left, copy/share icon buttons bottom-right, 96dp height, radius 12px
- `BottomNavBar`
- Pagination: infinite scroll with loading spinner at bottom

**User Actions:**
- Tap filter chips to narrow list
- Tap a message tile to expand to full message result view
- Tap copy/share directly from tile
- Swipe left to delete (with confirmation)
- Scroll to load more

**Navigation:**
- Forward: `/messages/result?id=xxx` (tile tap, read-only mode)
- Back: `/messages`

**RTL Notes:**
- Filter chips flow right-to-left
- Message preview text aligns right for Arabic messages
- Icons and dates swap sides
- Swipe to delete: swipe right in RTL

**States:**
- **Loading:** Skeleton tiles with shimmer
- **Default:** Grouped list by month
- **Empty:** "No messages yet. Generate your first one!" with CTA to /messages
- **Filtered empty:** "No messages match this filter."
- **Error:** "Couldn't load history. Pull to refresh."

---

## Gift Recommendation Module

---

### Screen 23: Gift Browser

- **Route:** `/gifts`
- **Module:** Gift Recommendation
- **Sprint:** Sprint 4
- **Description:** Browse AI-recommended gifts with filters. Filter by occasion, budget range, category. Cards show gift image, name, price, and match score.

```
+-------------------------------+
|  <-       Gifts        [filter]|
+-------------------------------+
|                               |
|   Occasion                    |
|   [Any] [Bday*] [Anniv]     |
|   [Apology] [Just because]   |
|                               |
|   Budget                      |
|   [$0-25] [$25-50*] [$50-100]|
|   [$100-200] [$200+]         |
|                               |
|   +-------------------------+ |
|   | [img placeholder]       | |
|   | Personalized Necklace   | |
|   | $35 -- 95% match        | |
|   | "Perfect for her style" | |
|   |              [View]     | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [img placeholder]       | |
|   | Spa Gift Card           | |
|   | $45 -- 88% match        | |
|   | "She loves self-care"   | |
|   |              [View]     | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [img placeholder]       | |
|   | Custom Photo Album      | |
|   | $28 -- 85% match        | |
|   | "Meaningful memories"   | |
|   |              [View]     | |
|   +-------------------------+ |
|                               |
|   [  Low Budget Mode  ]      |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Gifts" title, filter icon right (opens filter bottom sheet with additional options)
- `ChipGroup` -- Occasion filter, single select, horizontal scroll
- `ChipGroup` -- Budget filter, single select, horizontal scroll
- `GiftCard` -- image area 120dp height (placeholder or product image), title 16sp bold, price 16sp accent, match percentage 14sp green, AI reason 14sp italic #888, "View" ghost button bottom-right, radius 12px, elevation 2dp
- `TextLink` -- "Low Budget Mode", 16sp, accent color, centered, bottom of list
- `BottomNavBar` -- active on Gifts tab
- List: vertical scroll, lazy loading with pagination

**User Actions:**
- Tap occasion chips to filter
- Tap budget chips to filter
- Tap filter icon for advanced filters (category, from wish list, etc.)
- Tap gift card to view detail
- Tap "Low Budget Mode" for budget-friendly suggestions
- Scroll to load more gifts
- Pull to refresh for new AI suggestions

**Navigation:**
- Forward: `/gifts/detail?id=xxx` (card tap)
- Forward: `/gifts/low-budget` (Low Budget Mode)
- Back: `/home`
- Modal: Advanced filter bottom sheet

**RTL Notes:**
- Filter chips flow right-to-left
- Gift cards: image stays full width, text aligns right, "View" button moves to left
- Match percentage badge position: top-left in RTL
- Price uses locale-appropriate currency formatting

**States:**
- **Loading:** Shimmer on filter chips + 3 skeleton gift cards
- **Default:** Filters active, gift cards listed
- **Empty:** "No gifts match these filters. Try adjusting your budget or occasion."
- **Generating:** "Finding perfect gifts for her..." with animated search illustration
- **Error:** "Couldn't load gift suggestions. Pull to refresh."
- **Offline:** "Gift suggestions need internet. Check your connection."

---

### Screen 24: Gift Detail

- **Route:** `/gifts/detail`
- **Module:** Gift Recommendation
- **Sprint:** Sprint 4
- **Description:** Full gift recommendation with presentation idea, message to attach, backup plan, and purchase links. Complete gift package.

```
+-------------------------------+
|  <-     Gift Detail    [save]|
+-------------------------------+
|                               |
|   +-------------------------+ |
|   |    [gift image area]    | |
|   |      240dp height       | |
|   +-------------------------+ |
|                               |
|   Personalized Necklace       |
|   $35.00       95% match     |
|                               |
|   Why this gift?              |
|   "She mentioned loving       |
|   minimalist jewelry and      |
|   her zodiac sign Aries is    |
|   engraved on the pendant."   |
|                               |
|   --- Presentation Idea ---   |
|   "Wrap it in gold tissue     |
|   paper with a handwritten    |
|   note. Leave it on her       |
|   nightstand for a morning    |
|   surprise."                  |
|                               |
|   --- Message to Attach ---   |
|   "Every time you wear this,  |
|   remember you're my whole    |
|   universe."                  |
|   [Copy message]              |
|                               |
|   --- Backup Plan ---         |
|   If unavailable:             |
|   - Similar pendant at $30    |
|   - Bracelet set at $38       |
|                               |
|   Where to Buy                |
|   +-------------------------+ |
|   | [Amazon] $35.00    [Go] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [Etsy]   $32.00    [Go] | |
|   +-------------------------+ |
|                               |
|   Past gift note:             |
|   "You gave jewelry 3 months  |
|   ago (earrings). Consider    |
|   variety."                   |
|                               |
|   [    Share Gift Idea    ]   |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Gift Detail" title, save/bookmark icon right
- `ImageCarousel` -- gift images, 240dp height, horizontal swipe, dot indicators, placeholder if no image
- `GiftTitle` -- 22sp bold
- `PriceMatch` -- price 18sp accent, match badge 14sp green pill
- `SectionCard` -- "Why this gift?" -- AI explanation, 14sp, 16dp padding
- `SectionCard` -- "Presentation Idea" -- 14sp italic
- `SectionCard` -- "Message to Attach" -- 14sp, "Copy message" text button below
- `SectionCard` -- "Backup Plan" -- bullet list of alternatives, each tappable
- `SectionLabel` -- "Where to Buy"
- `VendorTile` -- vendor icon 24dp, vendor name, price, "Go" button (opens external browser/app)
- `WarningCard` -- past gift note, 14sp, amber background, light warning style
- `PrimaryButton` -- "Share Gift Idea", full width

**User Actions:**
- Swipe through gift images
- Read AI reasoning, presentation, message
- Tap "Copy message" to copy attached message
- Tap backup alternatives to view those gifts
- Tap "Go" on vendor to open purchase link
- Tap save/bookmark to save for later
- Tap "Share Gift Idea" to share via native sheet

**Navigation:**
- Back: `/gifts`
- External: vendor URLs (in-app browser or external)
- Modal: Share sheet

**RTL Notes:**
- Image carousel: swipe direction stays natural (no change needed)
- All text sections align right
- Vendor tiles: icon right, "Go" button left
- Price formatting locale-appropriate
- Dot indicators same (no directional bias)

**States:**
- **Loading:** Skeleton image + shimmer text blocks
- **Default:** Full gift detail displayed
- **Saved:** Bookmark icon filled, "Saved!" toast
- **Vendor error:** "This product may be unavailable. Check the link."
- **Offline:** Cached data shown if previously viewed, "Prices may be outdated" warning

---

### Screen 25: Low Budget Mode

- **Route:** `/gifts/low-budget`
- **Module:** Gift Recommendation
- **Sprint:** Sprint 4
- **Description:** High-impact, low-cost gift ideas. DIY suggestions, free experiences, handwritten letter templates. Focus on emotional value over price.

```
+-------------------------------+
|  <-    Low Budget, High       |
|        Impact                 |
+-------------------------------+
|                               |
|   "The best gifts don't       |
|   have price tags"            |
|                               |
|   --- Free Experiences ---    |
|   +-------------------------+ |
|   | [sunset] Sunset walk    | |
|   | at [nearby park]        | |
|   | "She loves nature"      | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [cook] Home-cooked      | |
|   | dinner -- her favorite  | |
|   | pasta recipe            | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [music] Custom playlist | |
|   | of "our songs"          | |
|   +-------------------------+ |
|                               |
|   --- Under $20 ---           |
|   +-------------------------+ |
|   | [flower] Single rose    | |
|   | with handwritten note   | |
|   | ~$5                     | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [candle] Her favorite   | |
|   | scented candle          | |
|   | ~$12                    | |
|   +-------------------------+ |
|                               |
|   --- DIY Ideas ---           |
|   +-------------------------+ |
|   | [letter] Love letter    | |
|   | template (tap to see)   | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [photo] Photo collage   | |
|   | of your memories        | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [jar] "52 reasons I     | |
|   | love you" jar           | |
|   +-------------------------+ |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Low Budget, High Impact" two-line title
- `QuoteText` -- motivational quote, 16sp italic, centered, #888
- `SectionLabel` -- "Free Experiences" / "Under $20" / "DIY Ideas"
- `IdeaCard` -- icon 24dp left, title 16sp bold, AI-personalized subtitle 14sp #888, optional price 14sp accent, radius 12px, 72dp height
- Cards are personalized based on her profile (interests, favorites, location)
- `BottomNavBar`

**User Actions:**
- Tap idea card to expand detail (inline expansion or navigate to detail)
- Tap love letter template to view/copy template
- Scroll through all sections
- Pull to refresh for new AI suggestions

**Navigation:**
- Forward: card tap expands inline or navigates to `/gifts/detail?id=xxx`
- Back: `/gifts`

**RTL Notes:**
- Icons move to right
- Text aligns right
- Price aligns left (end-aligned)
- Quote text stays centered

**States:**
- **Loading:** Shimmer cards in each section
- **Default:** Personalized suggestions in 3 sections
- **No profile:** "Complete her profile for personalized suggestions" + generic ideas
- **Error:** "Couldn't load suggestions. Pull to refresh."

---

## SOS Mode Module

---

### Screen 26: SOS Entry

- **Route:** `/sos`
- **Module:** SOS Mode
- **Sprint:** Sprint 4
- **Description:** Emergency entry point. Large red "She's Upset" button dominates the screen. Quick-access panic mode. Minimal UI, maximum urgency.

```
+-------------------------------+
|  <-       SOS Mode            |
+-------------------------------+
|                               |
|                               |
|                               |
|        Don't panic.           |
|        We've got you.         |
|                               |
|                               |
|       +--------------+        |
|       |              |        |
|       |   SHE'S      |        |
|       |   UPSET      |        |
|       |              |        |
|       |   [!]        |        |
|       |              |        |
|       +--------------+        |
|       (large red button)      |
|                               |
|                               |
|   Quick scenarios:            |
|   +-------------------------+ |
|   | [!] I forgot our        | |
|   |     anniversary     [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [!] We had a fight  [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | [!] She's not talking   | |
|   |     to me           [>] | |
|   +-------------------------+ |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "SOS Mode" title, red accent color
- `CalmingText` -- "Don't panic. We've got you.", 22sp, centered, semi-bold, white
- `SOSButton` -- large circular or rounded square button, 160x160dp, red (#FF4444) background, "SHE'S UPSET" text 20sp bold white, warning icon 32dp, pulsing glow animation (subtle), tap triggers haptic feedback (strong)
- `SectionLabel` -- "Quick scenarios:", 16sp
- `ScenarioTile` x3 -- warning icon red, scenario text 16sp, chevron right, 56dp height, tappable, each pre-fills the assessment with a known scenario
- `BottomNavBar` -- SOS tab active (red highlight instead of accent)

**User Actions:**
- Tap SOS button to start assessment wizard
- Tap quick scenario to skip assessment with pre-filled data
- Scroll to see quick scenarios

**Navigation:**
- Forward: `/sos/assess` (SOS button tap)
- Forward: `/sos/response?scenario=xxx` (quick scenario tap, skips assessment)
- Back: `/home`

**RTL Notes:**
- SOS button stays centered (no directional change)
- Calming text stays centered
- Scenario tiles: icon right, chevron flips to left
- Scenario text aligns right

**States:**
- **Default:** SOS button pulsing gently, scenarios visible
- **Loading:** Not needed (static content)
- **Pro required:** Free users see "SOS Mode requires Pro" overlay with upgrade CTA
- **Cooldown:** If SOS used in last hour, show "Active SOS in progress. Continue?" link to current SOS response

---

### Screen 27: Assessment Wizard

- **Route:** `/sos/assess`
- **Module:** SOS Mode
- **Sprint:** Sprint 4
- **Description:** Quick 3-step assessment. What happened? How bad is it (1-5)? Any additional context? Feeds AI response generator.

```
+-------------------------------+
|  <-     SOS Assessment        |
+-------------------------------+
|   Step 1 of 3                 |
|   [===-------] progress      |
|                               |
|   What happened?              |
|                               |
|   +-------------------------+ |
|   | ( ) I forgot something  | |
|   |     important           | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | (o) We had an argument  | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | ( ) I said something    | |
|   |     hurtful             | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | ( ) She's stressed      | |
|   |     (not my fault)      | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | ( ) I don't know why    | |
|   |     she's upset         | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | ( ) Other               | |
|   |  [describe...]          | |
|   +-------------------------+ |
|                               |
|   [       Next        ]      |
+-------------------------------+

--- Step 2 ---
+-------------------------------+
|  <-     SOS Assessment        |
+-------------------------------+
|   Step 2 of 3                 |
|   [======----] progress      |
|                               |
|   How bad is it?              |
|                               |
|   1    2    3    4    5       |
|   [mild] ........... [severe]|
|                               |
|   (1) Slightly annoyed        |
|   (2) Clearly upset           |
|   (3) Very angry              |
|   (4) Not speaking to me      |
|   (5) Considering leaving     |
|                               |
|   [       Next        ]      |
+-------------------------------+

--- Step 3 ---
+-------------------------------+
|  <-     SOS Assessment        |
+-------------------------------+
|   Step 3 of 3                 |
|   [=========] progress       |
|                               |
|   Anything else we should     |
|   know?                       |
|                               |
|   +-------------------------+ |
|   | We argued about money.  | |
|   | She's been stressed     | |
|   | about work too.         | |
|   +-------------------------+ |
|                               |
|   Quick tags:                 |
|   [Money] [Family] [Trust]   |
|   [Jealousy] [Chores]       |
|   [Communication] [Other]    |
|                               |
|   [    Get Help Now    ]     |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "SOS Assessment" title
- `ProgressBar` -- 3 steps, accent fill, 8dp height
- `StepIndicator` -- "Step X of 3", 14sp #888

**Step 1:**
- `SectionHeader` -- "What happened?", 20sp
- `RadioCard` x6 -- each 56dp, radio circle + label, "Other" option reveals text input
- `PrimaryButton` -- "Next"

**Step 2:**
- `SectionHeader` -- "How bad is it?", 20sp
- `SeverityScale` -- 5 numbered circles in a row, 48dp each, labeled "mild" to "severe", selected fills with red gradient (darker = more severe)
- Description text updates below based on selection
- `PrimaryButton` -- "Next"

**Step 3:**
- `SectionHeader` -- "Anything else we should know?", 20sp
- `TextArea` -- 100dp, optional free text, max 300 chars
- `ChipGroup` -- quick topic tags, multi-select
- `PrimaryButton` -- "Get Help Now", red background (#FF4444) instead of accent

**User Actions:**
- Step 1: Select what happened, tap Next
- Step 2: Select severity, tap Next
- Step 3: Optionally type details, select tags, tap "Get Help Now"
- Back navigates to previous step (not out of wizard)

**Navigation:**
- Forward: `/sos/response` (on "Get Help Now")
- Back: previous step (step 1 back goes to `/sos`)

**RTL Notes:**
- Progress bar fills from right to left
- Radio cards: radio on right, text on left
- Severity scale: 1 on right (mild), 5 on left (severe)
- Tags flow right-to-left
- Text area cursor starts right

**States:**
- **Default (per step):** No selection, Next disabled
- **Selected:** Option chosen, Next enabled
- **Loading:** Not needed (local form)
- **Generating:** After "Get Help Now", full-screen loading with calming animation ("Analyzing situation... Building your action plan...")
- **Error:** "Couldn't generate response. Tap to retry." (rare, critical path)

---

### Screen 28: SOS Response

- **Route:** `/sos/response`
- **Module:** SOS Mode
- **Sprint:** Sprint 5
- **Description:** AI-generated action plan. Four sections: SAY (what to tell her), DO (actions to take), BUY (emergency gift), GO (where to take her). Complete crisis response.

```
+-------------------------------+
|  <-     Action Plan           |
+-------------------------------+
|                               |
|   Situation: Argument (Lv 3)  |
|   Topic: Money                |
|                               |
|   +-------------------------+ |
|   | [SAY]                   | |
|   | "I've been thinking     | |
|   | about what you said,    | |
|   | and you're right. I     | |
|   | should have been more   | |
|   | open about finances.    | |
|   | Can we talk about it    | |
|   | calmly tonight?"        | |
|   |           [Copy] [Edit] | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [DO]                    | |
|   | 1. Give her 2 hours     | |
|   |    of space first       | |
|   | 2. Make her favorite    | |
|   |    tea                  | |
|   | 3. Sit next to her      | |
|   |    (not across)         | |
|   | 4. Listen more than     | |
|   |    you talk             | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [BUY]                   | |
|   | Her comfort snack:      | |
|   | Dark chocolate          | |
|   | [Order now] from        | |
|   | [nearby store]          | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [GO]                    | |
|   | After making up:        | |
|   | Take a quiet walk at    | |
|   | [park name] -- she      | |
|   | de-stresses in nature   | |
|   +-------------------------+ |
|                               |
|   [  Start Conversation  ]   |
|   [  Coach  ]                 |
|                               |
|   Did this help?              |
|   [Yes] [Somewhat] [No]     |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Action Plan" title
- `SituationBadge` -- summary of assessment, 14sp, pill style, colored by severity
- `ActionSection` x4 -- SAY (blue), DO (green), BUY (pink), GO (orange)
  - Each has type badge (colored label), content area, relevant action buttons
  - SAY: message text 16sp + Copy/Edit buttons
  - DO: numbered step list 14sp
  - BUY: product suggestion + "Order now" link
  - GO: location suggestion with map link potential
- `PrimaryButton` -- "Start Conversation Coach", navigates to real-time coaching
- `FeedbackRow` -- "Did this help?", 3 options, tappable chips

**User Actions:**
- Read all 4 action sections
- Copy the SAY message
- Edit the SAY message
- Tap "Order now" to buy emergency gift
- Tap location to open maps
- Tap "Start Conversation Coach" for real-time help
- Provide feedback (Yes/Somewhat/No)

**Navigation:**
- Forward: `/sos/coach` (Conversation Coach button)
- External: store/delivery links, maps
- Back: `/sos`

**RTL Notes:**
- All section content aligns right
- SAY message auto-aligns based on language
- DO numbered list: numbers on right, text left-aligned from number
- BUY/GO action buttons move to left side
- Type badges stay at top of each section (positionally consistent)

**States:**
- **Loading:** Full-screen calming animation with progress messages ("Analyzing...", "Building plan...", "Almost ready...")
- **Default:** All 4 sections displayed
- **Partial:** Some sections may be "Not applicable" (e.g., GO section if context says "stay home")
- **Error:** "Couldn't generate action plan. Tap to retry." with manual retry
- **Feedback submitted:** "Thanks. We'll do better next time." (if "No" selected, offer to regenerate)

---

### Screen 29: Conversation Coach

- **Route:** `/sos/coach`
- **Module:** SOS Mode
- **Sprint:** Sprint 5
- **Description:** Real-time conversation tips. Chat-like interface where user describes what she just said and AI suggests what to say next. Step-by-step guidance.

```
+-------------------------------+
|  <-  Conversation Coach       |
+-------------------------------+
|                               |
|   Tip: Stay calm. Listen      |
|   first, respond second.      |
|                               |
|   +-------------------------+ |
|   | [her] She said:         | |
|   | "You never listen to    | |
|   | me about money."        | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [AI] Say this:          | |
|   | "You're right, I        | |
|   | haven't been listening  | |
|   | as well as I should.    | |
|   | Tell me what's been     | |
|   | on your mind."          | |
|   |              [Copy]     | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [!] DON'T say:          | |
|   | "You spend too much     | |
|   | too." (defensive)       | |
|   +-------------------------+ |
|                               |
|   What did she say next?      |
|   +-------------------------+ |
|   | Type what she said...   | |
|   +-------------------------+ |
|   [Get next tip]              |
|                               |
|   [  She calmed down  ]      |
|   [  It's getting worse  ]   |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Conversation Coach" title
- `TipBanner` -- top sticky banner, calming advice, 14sp, blue background (#0F3460), white text
- `CoachBubble` -- chat-style bubbles
  - "She said" bubble: left-aligned, gray background, user types what she said
  - "Say this" bubble: right-aligned, green background (#16C47F at 20%), AI suggestion, Copy button
  - "DON'T say" bubble: red background (#FF4444 at 10%), warning about what to avoid
- `TextFieldLabeled` -- "What did she say next?", 48dp, text input
- `PrimaryButton` -- "Get next tip", sends input to AI for next suggestion
- `StatusButtons` x2 -- "She calmed down" (green, success) and "It's getting worse" (red, escalate)

**User Actions:**
- Read AI coaching tip
- Copy suggested response
- Type what she just said
- Tap "Get next tip" for next round of coaching
- Tap "She calmed down" to end coaching (success)
- Tap "It's getting worse" to escalate (AI adjusts to more serious tone)

**Navigation:**
- Back: `/sos/response`
- "She calmed down": `/sos` with success celebration
- "It's getting worse": stays on screen, AI regenerates with higher severity tips

**RTL Notes:**
- Chat bubbles: "She said" moves to right (since she's the other person), "Say this" moves to left
- Actually, keep standard chat convention: her words on left, his suggestions on right (reversed in RTL)
- DON'T bubble stays visually distinct regardless of direction
- Input field cursor starts right for Arabic

**States:**
- **Default:** Initial tip banner + first AI suggestion based on SOS assessment context
- **Waiting:** After user submits what she said, "Say this" bubble shows typing animation
- **Generated:** New coaching round appears (scrolls down)
- **Calmed down:** Success screen with confetti: "Great job handling that. +50 points" and link to /home
- **Escalating:** AI tone shifts to more serious, may suggest "Give her space and try again tomorrow"
- **Error:** "Couldn't get next tip. Try again." inline retry
- **Session end:** After 10 rounds, suggest "You've been talking for a while. Consider giving her space."

---

## Gamification Module

---

### Screen 30: Gamification Dashboard

- **Route:** `/gamification`
- **Module:** Gamification
- **Sprint:** Sprint 5
- **Description:** Central gamification hub. Shows streak, level, total points, relationship consistency score, current weekly challenge, and recent achievements.

```
+-------------------------------+
|  <-     Gamification          |
+-------------------------------+
|                               |
|   +-------------------------+ |
|   |  Level: Good Partner    | |
|   |  [====>    ] 847/1200   | |
|   |  Next: Thoughtful Husb  | |
|   +-------------------------+ |
|                               |
|   +--------+ +--------+      |
|   | Streak | | Points |      |
|   |  12    | |  847   |      |
|   | days   | |  pts   |      |
|   | [fire] | | [star] |      |
|   +--------+ +--------+      |
|                               |
|   Consistency Score           |
|   +-------------------------+ |
|   | This week: 78/100       | |
|   | [===========>---]       | |
|   | Messages: 5  Events: 2  | |
|   | Actions: 3  Promises: 1 | |
|   +-------------------------+ |
|                               |
|   Weekly Challenge            |
|   +-------------------------+ |
|   | "Surprise her with      | |
|   |  breakfast this week"   | |
|   | Reward: +100 pts        | |
|   |  [Accept] [Skip]        | |
|   +-------------------------+ |
|                               |
|   Recent Achievements         |
|   [badge] [badge] [badge]    |
|   [View all achievements >]  |
|                               |
|   [View Improvement Graph]   |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Gamification" title
- `LevelCard` -- level name 18sp bold, progress bar (XP toward next level), "Next: [level]" 14sp #888, gradient background
- `StatCardRow` -- 2 cards side by side, each 100dp square, large number 28sp bold centered, label 14sp, icon 24dp, subtle shadow
- `ConsistencyCard` -- "This week: X/100" header, progress bar, 4 sub-metrics in 2x2 grid (messages, events, actions, promises), each with count
- `ChallengeCard` -- challenge description 16sp, reward badge, Accept/Skip buttons, accent border
- `AchievementPreview` -- horizontal row of 3 recent badge icons (48dp each), "View all >" link
- `SecondaryButton` -- "View Improvement Graph", full width

**User Actions:**
- Read stats and progress
- Tap "Accept" on weekly challenge to commit
- Tap "Skip" to dismiss challenge
- Tap achievement badges or "View all" to go to badge gallery
- Tap "View Improvement Graph"
- Pull to refresh stats

**Navigation:**
- Forward: `/gamification/badges` (achievements)
- Forward: `/gamification/graph` (improvement graph)
- Back: `/home`

**RTL Notes:**
- Progress bars fill from right to left
- Stat cards: same layout (centered content)
- Consistency sub-metrics: grid order reversed (right-to-left reading)
- Challenge card: buttons align left in RTL
- Achievement row: flows right-to-left

**States:**
- **Loading:** Skeleton cards with shimmer
- **Default:** All stats populated
- **New user:** Level "Rookie", 0 streak, 0 points, "Complete your first action to start earning!"
- **Streak broken:** Streak shows 0 with "Start a new streak today!" motivational text
- **Challenge active:** Challenge card shows progress ("2/5 days completed")
- **Error:** "Couldn't load stats. Pull to refresh."

---

### Screen 31: Improvement Graph

- **Route:** `/gamification/graph`
- **Module:** Gamification
- **Sprint:** Sprint 5
- **Description:** Visual trend graph showing relationship effort over time. Weekly and monthly toggle. Line chart with breakdown by action type.

```
+-------------------------------+
|  <-   Improvement Graph       |
+-------------------------------+
|   [Weekly*] [Monthly]         |
|                               |
|   Consistency Score Trend     |
|   +-------------------------+ |
|   | 100|                    | |
|   |    |       .--*         | |
|   |  75|    .-'    '-.      | |
|   |    | .-'          *     | |
|   |  50|*                   | |
|   |    |                    | |
|   |  25|                    | |
|   |    +---+---+---+---+   | |
|   |    W1  W2  W3  W4  W5  | |
|   +-------------------------+ |
|                               |
|   This Month vs Last Month    |
|   +-------------------------+ |
|   | Messages:  +15% [up]    | |
|   | Events:    +8%  [up]    | |
|   | Actions:   -5%  [dn]    | |
|   | Promises:  +22% [up]    | |
|   | Overall:   +10% [up]    | |
|   +-------------------------+ |
|                               |
|   Your Best Week: W3          |
|   Score: 92/100               |
|   "You sent 8 messages and    |
|   remembered her mom's        |
|   birthday without a          |
|   reminder!"                  |
|                               |
|   Insight from AI:            |
|   "Your consistency improves  |
|   when you do the daily       |
|   check-in. Keep it up!"     |
|                               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Improvement Graph" title
- `ViewToggle` -- "Weekly" / "Monthly" segmented control
- `LineChart` -- consistency score over time, accent color line, dots at data points, Y-axis 0-100, X-axis weeks or months, touch to see exact value tooltip
- `ComparisonCard` -- month-over-month breakdown, 5 metrics, each with percentage change + up/down arrow (green up, red down)
- `HighlightCard` -- "Your Best Week" with score and AI-generated description of what made it great
- `InsightCard` -- AI tip based on data patterns, lightbulb icon, 14sp

**User Actions:**
- Toggle weekly/monthly view
- Touch chart data points to see exact values
- Read comparison metrics
- Read AI insights

**Navigation:**
- Back: `/gamification`

**RTL Notes:**
- Chart: Y-axis moves to right side, X-axis labels stay in chronological order (left-to-right even in RTL, as timelines are universally LTR)
- Comparison metrics: label right, percentage left
- Up/down arrows: no directional change (universal)

**States:**
- **Loading:** Skeleton chart + shimmer cards
- **Default:** Chart + comparisons + insights
- **New user (< 1 week):** "Keep using LOLO for a week to see your first graph!" with illustration
- **Insufficient data:** "Not enough data yet for monthly view. Check back next month."
- **Error:** "Couldn't load graph data. Pull to refresh."

---

### Screen 32: Achievements

- **Route:** `/gamification/badges`
- **Module:** Gamification
- **Sprint:** Sprint 5
- **Description:** Badge gallery. All possible achievements in a grid. Earned badges are colored, unearned are grayed and locked. Progress toward next achievement shown.

```
+-------------------------------+
|  <-     Achievements          |
+-------------------------------+
|   Earned: 8/24 badges         |
|                               |
|   --- Streak Badges ---       |
|   +------+ +------+ +------+ |
|   |[fire]| |[fire]| |[lock]| |
|   | 7-day| | 30d  | | 100d | |
|   |streak| |streak| |streak| |
|   | [ok] | | [ok] | | 42%  | |
|   +------+ +------+ +------+ |
|                               |
|   --- Message Badges ---      |
|   +------+ +------+ +------+ |
|   |[chat]| |[chat]| |[lock]| |
|   | First| | 50   | | 200  | |
|   | msg  | | msgs | | msgs | |
|   | [ok] | | [ok] | | 78%  | |
|   +------+ +------+ +------+ |
|                               |
|   --- Milestone Badges ---    |
|   +------+ +------+ +------+ |
|   |[star]| |[lock]| |[lock]| |
|   | First| | SOS  | |Legend | |
|   | month| | hero | | rank | |
|   | [ok] | | 0%   | | 0%   | |
|   +------+ +------+ +------+ |
|                               |
|   --- Special Badges ---      |
|   +------+ +------+ +------+ |
|   |[gift]| |[lock]| |[lock]| |
|   | Gift | |100%  | |Vault | |
|   |master| |proms | |master| |
|   | [ok] | | 80%  | | 15%  | |
|   +------+ +------+ +------+ |
|                               |
|   Share your achievements     |
|   [  Share Badge  ]          |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Achievements" title
- `ProgressSummary` -- "Earned: X/Y badges", 16sp
- `SectionLabel` -- category headers ("Streak Badges", "Message Badges", etc.)
- `BadgeCard` -- 3-column grid, each ~100x120dp, badge icon 48dp (colored if earned, gray if locked), title 12sp bold, subtitle 12sp, status: checkmark (earned) or percentage (progress), lock overlay on unearned
- Tappable: shows detail modal with description, date earned, and share option
- `PrimaryButton` -- "Share Badge", opens share sheet for selected badge

**User Actions:**
- Browse badge gallery by category
- Tap earned badge to see detail + share
- Tap locked badge to see requirements and progress
- Tap "Share Badge" to share on social media
- Scroll through all categories

**Navigation:**
- Back: `/gamification`
- Modal: Badge detail popup
- Modal: Share sheet

**RTL Notes:**
- Badge grid flows right-to-left (first badge top-right)
- Section headers align right
- Progress summary aligns right
- Badge detail modal: text aligns right

**States:**
- **Loading:** Skeleton grid with shimmer
- **Default:** All badges displayed, earned colored, locked grayed
- **New user:** All locked except "Welcome" badge, encouraging message
- **All earned:** Golden banner "You've earned every badge! You're a legend."
- **Error:** "Couldn't load achievements. Pull to refresh."

---

## Smart Action Cards Module

---

### Screen 33: Card Stack

- **Route:** `/actions`
- **Module:** Smart Action Cards
- **Sprint:** Sprint 3
- **Description:** Swipeable stack of AI-generated action cards. Each card is a SAY/DO/BUY/GO suggestion. Tinder-style swipe: right to accept, left to dismiss. Cards stack visually.

```
+-------------------------------+
|  <-    Today's Actions        |
+-------------------------------+
|                               |
|   2 of 5 cards remaining     |
|                               |
|   +-------------------------+ |
|   | CONTEXT: She's stressed | |
|   | + your anniversary is   | |
|   | in 3 days               | |
|   |-------------------------| |
|   |                         | |
|   | [SAY]                   | |
|   | "I know this week has   | |
|   | been tough. Let's do    | |
|   | something low-key this  | |
|   | weekend -- just us."    | |
|   |                         | |
|   | [DO]                    | |
|   | Plan a quiet home date  | |
|   | night (she's drained)   | |
|   |                         | |
|   | [BUY]                   | |
|   | Comfort gift under $40: | |
|   | Her fav candle + bath   | |
|   | bomb                    | |
|   |                         | |
|   | [GO]                    | |
|   | Quiet walk at sunset    | |
|   | at [nearby park]        | |
|   |                         | |
|   +-------------------------+ |
|   (card 2 peek behind)       |
|                               |
|   [dismiss]     [accept]     |
|   Swipe L       Swipe R      |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Today's Actions" title
- `CardCounter` -- "X of Y cards remaining", 14sp #888
- `ActionCardStack` -- swipeable card stack widget
  - Top card: full detail, 400dp height, radius 16px, elevation 4dp
  - Context section: gray background top, situation summary 14sp
  - SAY/DO/BUY/GO sections: each with colored type badge (SAY blue, DO green, BUY pink, GO orange), content 14sp
  - Peek card: offset 8dp down, 8dp in from sides, lower opacity
- `SwipeHint` -- "dismiss" left arrow, "accept" right arrow, 12sp #888, shown only first time
- Swipe gestures: right = accept (card flies right with green tint), left = dismiss (card flies left with red tint), up = save for later

**User Actions:**
- Swipe right to accept action (marks as "to do", adds to task list)
- Swipe left to dismiss (gone, AI notes preference for learning)
- Swipe up to save for later
- Tap card to expand to full detail view
- Swipe through entire stack

**Navigation:**
- Forward: `/actions/detail?id=xxx` (card tap)
- Back: `/home`

**RTL Notes:**
- Swipe directions reverse: right = dismiss, left = accept (matching RTL reading flow)
- Card content aligns right
- Type badges move to right side
- Peek card offset mirrors
- Swipe hints reverse

**States:**
- **Loading:** Single skeleton card with shimmer
- **Default:** Stack of 2-5 cards
- **Last card:** No peek behind, "Last one!" label
- **All done:** "You've reviewed all today's actions! Check back tomorrow." with illustration
- **Empty (no context):** "Do the daily check-in to get personalized action cards" with CTA to check-in
- **Error:** "Couldn't load action cards. Pull to refresh."

---

### Screen 34: Card Detail

- **Route:** `/actions/detail`
- **Module:** Smart Action Cards
- **Sprint:** Sprint 3
- **Description:** Expanded view of a single action card. Full details for each SAY/DO/BUY/GO section with actionable buttons.

```
+-------------------------------+
|  <-     Action Detail         |
+-------------------------------+
|                               |
|   CONTEXT                     |
|   She's stressed from work    |
|   + Anniversary in 3 days     |
|   + She prefers quiet time    |
|                               |
|   +-------------------------+ |
|   | [SAY]                   | |
|   | "I know this week has   | |
|   | been tough. Let's do    | |
|   | something low-key this  | |
|   | weekend -- just us."    | |
|   |                         | |
|   | [Copy] [Send via chat]  | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [DO]                    | |
|   | 1. Cook her favorite    | |
|   |    pasta recipe         | |
|   | 2. Set up living room   | |
|   |    with candles         | |
|   | 3. Pick a movie she     | |
|   |    mentioned wanting    | |
|   |    to watch             | |
|   |                         | |
|   | [ ] Mark as done        | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [BUY]                   | |
|   | Candle + bath bomb set  | |
|   | $38 at [Store]          | |
|   |                         | |
|   | [Order] [See more]      | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [GO]                    | |
|   | Sunset walk at Central  | |
|   | Park -- 10 min drive    | |
|   |                         | |
|   | [Open Maps]             | |
|   +-------------------------+ |
|                               |
|   [  Mark All Complete  ]    |
|                               |
|   Was this helpful?           |
|   [thumbs up] [thumbs down]  |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Action Detail" title
- `ContextCard` -- gray background, bullet points of context factors, 14sp
- `SAYSection` -- blue badge, message text 16sp, Copy button + Send button
- `DOSection` -- green badge, numbered checklist (checkable items), "Mark as done" per item
- `BUYSection` -- pink badge, product + price + store, Order button + See alternatives
- `GOSection` -- orange badge, location + distance, "Open Maps" button
- `PrimaryButton` -- "Mark All Complete", full width, awards points
- `FeedbackRow` -- thumbs up/down, 32dp icons

**User Actions:**
- Copy SAY message
- Send via native share/chat
- Check off DO items
- Tap Order to buy
- Tap Open Maps for directions
- Mark all complete (awards gamification points)
- Provide feedback

**Navigation:**
- Back: `/actions`
- External: store links, maps
- Modal: Share sheet

**RTL Notes:**
- All section content right-aligned
- Checklist: checkboxes on right, text on left
- Action buttons swap sides within sections
- Maps link respects locale

**States:**
- **Loading:** Skeleton sections with shimmer
- **Default:** All 4 sections expanded
- **Partially complete:** Some items checked, button shows "Complete remaining"
- **All complete:** Confetti animation, "+25 points" popup, button disabled
- **Error:** "Couldn't load card detail. Go back and try again."

---

## Memory Vault Module

---

### Screen 35: Vault Home

- **Route:** `/vault`
- **Module:** Memory Vault
- **Sprint:** Sprint 6
- **Description:** Memory bank home with tabbed navigation. Four tabs: Stories, Jokes, Wish List, Timeline. Biometric lock option on entry.

```
+-------------------------------+
|  <-    Memory Vault    [lock] |
+-------------------------------+
|  [Stories][Jokes][Wish][Time] |
|                               |
|   --- Stories Tab ---         |
|                               |
|   +-------------------------+ |
|   | How We Met              | |
|   | "It was raining at the  | |
|   | coffee shop when..."    | |
|   | Added: Jan 5, 2026      | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | First Vacation Together | |
|   | "We drove 6 hours to    | |
|   | the beach and got..."   | |
|   | Added: Jan 20, 2026     | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | The Proposal            | |
|   | "I hid the ring in..."  | |
|   | Added: Feb 1, 2026      | |
|   +-------------------------+ |
|                               |
|   [  + Add New Memory  ]    |
|                               |
+-------------------------------+
|  [home] [msg] [gift] [sos] [her]|
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Memory Vault" title, lock icon right (toggles biometric protection)
- `TabBar` -- 4 tabs: Stories, Jokes, Wish List, Timeline, accent underline on active, horizontal scroll for smaller screens
- `MemoryCard` -- title 16sp bold, preview text 14sp #888 (2 line truncate), date 12sp #666, radius 12px, 88dp height, tappable
- `FABButton` -- "+ Add New Memory", fixed bottom, accent color, 56dp
- `BottomNavBar`

**User Actions:**
- Switch tabs to browse different memory types
- Tap memory card to view full story
- Tap "+ Add New Memory" to add new entry
- Tap lock icon to enable/disable biometric protection
- Swipe left on card to delete (with confirmation)
- Pull to refresh

**Navigation:**
- Forward: `/vault/add` (+ button)
- Forward: `/vault/add?id=xxx` (card tap to edit)
- Forward: `/vault/wishlist` (Wish List tab)
- Forward: `/vault/timeline` (Timeline tab)
- Back: `/home`
- Modal: Biometric prompt (fingerprint/face), Delete confirmation

**RTL Notes:**
- Tab bar: tabs flow right-to-left
- Memory cards: text aligns right
- Date aligns left (end-aligned in RTL)
- FAB stays at bottom-right in LTR, bottom-left in RTL
- Swipe to delete: right in RTL

**States:**
- **Loading:** Skeleton cards per tab
- **Default:** Populated memory list
- **Empty (per tab):** "No [stories/jokes/wishes] yet. Start building your vault!" with illustration + CTA
- **Locked:** Biometric prompt on screen entry, blurred content behind
- **Auth failed:** "Authentication failed. Try again." with retry
- **Error:** "Couldn't load vault. Pull to refresh."
- **Pro only:** Legend tier required for vault, shows upgrade prompt for free/Pro users

---

### Screen 36: Add Memory Form

- **Route:** `/vault/add`
- **Module:** Memory Vault
- **Sprint:** Sprint 6
- **Description:** Form to add a new memory, inside joke, or story. Type selector, title, content, tags, optional photo attachment.

```
+-------------------------------+
|  <-     Add Memory     [save]|
+-------------------------------+
|                               |
|   Memory Type                 |
|   [Story*] [Joke] [Moment]  |
|   [Quote] [Lesson]           |
|                               |
|   Title                       |
|   +-------------------------+ |
|   | How We Met              | |
|   +-------------------------+ |
|                               |
|   Your Memory                 |
|   +-------------------------+ |
|   | It was a rainy Tuesday  | |
|   | at the coffee shop on   | |
|   | Main Street. She was    | |
|   | reading a book and I    | |
|   | accidentally knocked    | |
|   | over her coffee...      | |
|   |                         | |
|   |                         | |
|   +-------------------------+ |
|                               |
|   Date (when it happened)     |
|   +-------------------------+ |
|   | June 15, 2023    [cal]  | |
|   +-------------------------+ |
|                               |
|   Tags                        |
|   [Romantic] [Funny]         |
|   [Milestone] [Travel]       |
|   [+Add tag]                  |
|                               |
|   Add Photo (optional)        |
|   +------+ +------+          |
|   |[+img]| |[+img]|          |
|   +------+ +------+          |
|                               |
|   AI can reference this       |
|   memory in messages [on/off] |
|                               |
|   [    Save Memory    ]      |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Add Memory" / "Edit Memory", save icon right
- `ChipGroup` -- Memory Type, single select
- `TextFieldLabeled` -- Title, 48dp, max 80 chars
- `TextArea` -- Memory content, 160dp min height, expandable, max 2000 chars
- `DatePickerField` -- when it happened, optional, calendar icon
- `ChipGrid` -- Tags, multi-select, "+Add tag" creates custom tag
- `PhotoGrid` -- 2 slots (expandable), each 80x80dp, "+" icon to add from gallery/camera, tap to preview/remove
- `SwitchRow` -- "AI can reference this memory in messages", toggle switch, 14sp label
- `PrimaryButton` -- "Save Memory"

**User Actions:**
- Select memory type
- Fill title and content
- Optionally set date
- Select/create tags
- Attach photos from gallery or camera
- Toggle AI reference permission
- Save

**Navigation:**
- Back: `/vault` (with discard dialog if unsaved)
- Modal: Date picker, Photo picker (gallery/camera), Discard confirmation

**RTL Notes:**
- All labels and inputs right-aligned
- Photo grid flows right-to-left
- Tags flow right-to-left
- Toggle switch: label right, switch left
- Calendar icon moves to left side of date field

**States:**
- **Create mode:** Empty form, "Add Memory" title
- **Edit mode:** Pre-filled form, "Edit Memory" title, delete option
- **Validation:** Title required, Content required; inline errors
- **Saving:** Button spinner
- **Saved:** Success toast, navigate back to vault
- **Photo uploading:** Progress indicator on photo thumbnail
- **Error:** "Couldn't save memory. Try again."

---

### Screen 37: Wish List Management

- **Route:** `/vault/wishlist`
- **Module:** Memory Vault
- **Sprint:** Sprint 6
- **Description:** Things she has mentioned wanting. Quick-add items, categorize by type, link to gift engine. AI uses this to auto-suggest gifts.

```
+-------------------------------+
|  <-     Her Wish List   [+]  |
+-------------------------------+
|                               |
|   Quick Add                   |
|   +-------------------------+ |
|   | "She said she wants..." | |
|   |                  [Add]  | |
|   +-------------------------+ |
|                               |
|   --- Items ---               |
|   +-------------------------+ |
|   | [bag] That leather bag  | |
|   | from the mall            | |
|   | Added: Feb 10            | |
|   | [Find gift] [Done]      | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [trip] Visit Paris      | |
|   | someday                  | |
|   | Added: Jan 22            | |
|   | [Plan trip]              | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [food] Try that new     | |
|   | sushi place              | |
|   | Added: Feb 5             | |
|   | [Book table] [Done]     | |
|   +-------------------------+ |
|                               |
|   --- Fulfilled ---           |
|   +-------------------------+ |
|   | [x] Gold earrings       | |
|   | Fulfilled: Feb 14        | |
|   +-------------------------+ |
|                               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Her Wish List" title, "+" add button right
- `QuickAddField` -- inline text input 48dp + "Add" button, 14sp placeholder "She said she wants..."
- `SectionLabel` -- "Items" / "Fulfilled"
- `WishTile` -- category icon left 24dp, wish text 16sp, date added 12sp #888, action buttons bottom ("Find gift" links to gift engine, "Done" marks fulfilled, "Book table" / "Plan trip" contextual actions)
- Fulfilled section: strikethrough text, checkmark, fulfillment date
- Swipe to delete with confirmation

**User Actions:**
- Quick-add a wish item (type + tap Add)
- Tap "+" for detailed add form
- Tap "Find gift" to search gift engine with this wish as input
- Tap "Done" to mark as fulfilled
- Tap contextual action buttons
- Swipe to delete
- Reorder items (drag handle)

**Navigation:**
- Forward: `/gifts?wish=xxx` (Find gift button)
- Forward: `/vault/add?type=wish` (+ button for detailed add)
- Back: `/vault`

**RTL Notes:**
- Icons move to right
- Text aligns right
- Action buttons move to left
- Quick add: "Add" button on left, text input on right
- Drag handle moves to left side

**States:**
- **Loading:** Skeleton tiles
- **Default:** Items list + fulfilled list
- **Empty:** "She hasn't mentioned wanting anything? Listen closely and quick-add here!" with illustration
- **All fulfilled:** "Everything fulfilled! You're amazing. Keep listening for new wishes."
- **Error:** "Couldn't load wish list. Pull to refresh."

---

### Screen 38: Relationship Timeline

- **Route:** `/vault/timeline`
- **Module:** Memory Vault
- **Sprint:** Sprint 6
- **Description:** Visual chronological timeline of relationship milestones. Vertical scrollable timeline with events, memories, and milestones.

```
+-------------------------------+
|  <-  Relationship Timeline    |
+-------------------------------+
|                               |
|   Together: 3 years, 2 months|
|                               |
|   2026                        |
|   |                           |
|   o Feb 14 - Valentine's Day  |
|   |  (upcoming)               |
|   |                           |
|   o Jan 5 - Added "How We    |
|   |  Met" story               |
|   |                           |
|   2025                        |
|   |                           |
|   o Dec 25 - Christmas        |
|   |  together                 |
|   |                           |
|   o Oct 15 - Got engaged!     |
|   |  [milestone badge]        |
|   |                           |
|   o Jun 21 - 2nd anniversary  |
|   |                           |
|   o Mar 21 - Her birthday     |
|   |  (gave gold earrings)     |
|   |                           |
|   2024                        |
|   |                           |
|   o Jun 21 - 1st anniversary  |
|   |  [milestone badge]        |
|   |                           |
|   o Apr 1 - First vacation    |
|   |  (beach trip)             |
|   |                           |
|   2023                        |
|   |                           |
|   o Jun 21 - Started dating   |
|   |  [milestone badge]        |
|   |                           |
|   [  + Add Milestone  ]      |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Relationship Timeline" title
- `DurationLabel` -- "Together: X years, Y months", 16sp, accent color, calculated from first date
- `YearLabel` -- year headers, 18sp bold, sticky on scroll
- `TimelineNode` -- vertical line (2dp, #333) with circle nodes (12dp), date 14sp bold, event description 14sp #888, optional milestone badge (gold star icon)
- Event types: milestone (gold node), memory (blue node), reminder (gray node), upcoming (outlined node)
- `FABButton` -- "+ Add Milestone"

**User Actions:**
- Scroll through timeline vertically
- Tap a node to view associated memory/event detail
- Tap "+ Add Milestone" to add a new timeline event
- Long-press node to edit/delete

**Navigation:**
- Forward: `/vault/add?type=milestone` (+ button)
- Forward: `/vault/add?id=xxx` (node tap to view/edit)
- Back: `/vault`

**RTL Notes:**
- Timeline line moves to right side
- Nodes on right, text extends left
- Year labels align right
- Duration label aligns right
- Dates: locale-appropriate formatting

**States:**
- **Loading:** Skeleton timeline with shimmer nodes
- **Default:** Chronological timeline with all events
- **Empty:** "Start your timeline! Add when you started dating." with single "Add first date" CTA
- **Single event:** Timeline with just the first date, encouraging "Add more milestones"
- **Error:** "Couldn't load timeline. Pull to refresh."

---

## Settings Module

---

### Screen 39: Main Settings

- **Route:** `/settings`
- **Module:** Settings
- **Sprint:** Sprint 2
- **Description:** Central settings hub. Account info, app preferences, subscription management, privacy, notifications, language, theme, and support links.

```
+-------------------------------+
|  <-       Settings            |
+-------------------------------+
|                               |
|   +-------------------------+ |
|   | [avatar]                | |
|   | Ahmad Al-Rashid         | |
|   | ahmad@email.com         | |
|   | [Edit Profile]          | |
|   +-------------------------+ |
|                               |
|   App Preferences             |
|   +-------------------------+ |
|   | Language          EN [>]| |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Theme       Dark    [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Notifications       [>] | |
|   +-------------------------+ |
|                               |
|   Subscription                |
|   +-------------------------+ |
|   | Plan: Pro ($4.99/mo) [>]| |
|   +-------------------------+ |
|                               |
|   Privacy & Security          |
|   +-------------------------+ |
|   | Privacy settings    [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Vault biometric lock[>] | |
|   +-------------------------+ |
|                               |
|   Support                     |
|   +-------------------------+ |
|   | Help Center         [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Contact Support     [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Rate LOLO           [>] | |
|   +-------------------------+ |
|                               |
|   [  Log Out  ]              |
|                               |
|   Version 1.0.0               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Settings" title
- `AccountCard` -- avatar 56dp, name 18sp bold, email 14sp #888, "Edit Profile" text button
- `SectionLabel` -- "App Preferences" / "Subscription" / "Privacy & Security" / "Support"
- `SettingsTile` -- label left 16sp, current value 14sp #888 right, chevron right, 52dp height, divider between items
- `DestructiveButton` -- "Log Out", red outlined, centered
- `VersionLabel` -- "Version X.X.X", 12sp, #666, centered

**User Actions:**
- Tap "Edit Profile" to edit name/email/avatar
- Tap Language to change app language
- Tap Theme to toggle dark/light
- Tap Notifications to manage notification preferences
- Tap Subscription tile to manage plan
- Tap Privacy to manage data/security
- Tap Vault biometric to toggle fingerprint/face lock
- Tap Help/Support/Rate
- Tap "Log Out" (confirmation dialog)

**Navigation:**
- Forward: `/settings/subscription` (subscription tile)
- Forward: `/settings/privacy` (privacy tile)
- Forward: `/onboarding/language` (language, or inline picker)
- Modal: Theme picker, Notification preferences, Log out confirmation
- External: Help center URL, App store rating prompt
- Back: `/home`

**RTL Notes:**
- Account card text aligns right
- Settings tiles: label right, value left, chevron flips
- Section labels align right
- "Log Out" stays centered

**States:**
- **Loading:** Skeleton account card + shimmer tiles
- **Default:** All settings displayed with current values
- **Logged out:** Redirects to `/onboarding/welcome`
- **Error:** "Couldn't load settings. Pull to refresh."

---

### Screen 40: Subscription Management

- **Route:** `/settings/subscription`
- **Module:** Settings
- **Sprint:** Sprint 6
- **Description:** Current plan details, upgrade/downgrade options, billing history, cancel subscription. Links to platform-specific subscription management.

```
+-------------------------------+
|  <-     Subscription          |
+-------------------------------+
|                               |
|   Current Plan                |
|   +-------------------------+ |
|   | [star] Pro Plan         | |
|   | $4.99/month             | |
|   | Renews: Mar 14, 2026    | |
|   | Since: Jan 14, 2026     | |
|   +-------------------------+ |
|                               |
|   +-------------------------+ |
|   | [crown] Upgrade to      | |
|   | Legend -- $9.99/mo       | |
|   | Unlock: Memory Vault,   | |
|   | Conversation Coach,     | |
|   | Priority AI responses   | |
|   |                         | |
|   | [  Upgrade to Legend  ] | |
|   +-------------------------+ |
|                               |
|   Plan Comparison             |
|   +-------------------------+ |
|   | Feature    Pro  Legend   | |
|   | Messages   Unl  Unl     | |
|   | SOS Mode    Y    Y      | |
|   | Coach       N    Y      | |
|   | Vault       N    Y      | |
|   | Priority    N    Y      | |
|   +-------------------------+ |
|                               |
|   Billing History             |
|   +-------------------------+ |
|   | Feb 14 -- $4.99  Paid   | |
|   | Jan 14 -- $4.99  Paid   | |
|   +-------------------------+ |
|                               |
|   [Manage on Google Play]     |
|   [Cancel Subscription]       |
|                               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Subscription" title
- `CurrentPlanCard` -- star/crown icon, plan name 18sp bold, price 16sp, renewal date 14sp, member since 14sp #888, accent border
- `UpgradeCard` -- crown icon, "Upgrade to Legend" 18sp bold, benefits list 14sp, upgrade button inside card
- `ComparisonTable` -- 3-column, feature vs Pro vs Legend, check/cross icons
- `SectionLabel` -- "Billing History"
- `BillingTile` -- date + amount + status, 14sp, divider between items
- `TextLink` -- "Manage on Google Play" / "Manage on App Store", opens platform subscription page
- `DestructiveLink` -- "Cancel Subscription", red text, opens confirmation flow

**User Actions:**
- View current plan details
- Tap "Upgrade to Legend" to initiate upgrade purchase
- Review billing history
- Tap "Manage on Google Play" to open platform management
- Tap "Cancel Subscription" to start cancellation flow

**Navigation:**
- External: Google Play / App Store subscription management
- Modal: Upgrade purchase flow, Cancel confirmation
- Back: `/settings`

**RTL Notes:**
- Plan card text aligns right
- Comparison table: feature labels right, values in same column order
- Billing tiles: date right, amount left
- Links centered

**States:**
- **Loading:** Skeleton cards
- **Free user:** No current plan card, shows "Choose a Plan" with upgrade options
- **Pro user:** Current plan + Legend upgrade
- **Legend user:** Current plan shown, no upgrade card, "You have the best plan!"
- **Cancelled:** "Your plan is active until [date]. Resubscribe anytime."
- **Error:** "Couldn't load subscription info. Try again."

---

### Screen 41: Privacy & Security

- **Route:** `/settings/privacy`
- **Module:** Settings
- **Sprint:** Sprint 6
- **Description:** Data management, export, delete account, biometric settings. GDPR/privacy compliance features.

```
+-------------------------------+
|  <-   Privacy & Security      |
+-------------------------------+
|                               |
|   Security                    |
|   +-------------------------+ |
|   | Biometric Lock  [toggle]| |
|   | Require fingerprint or  | |
|   | face to open LOLO       | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Vault Lock      [toggle]| |
|   | Extra protection for    | |
|   | Memory Vault             | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Change Password     [>] | |
|   +-------------------------+ |
|                               |
|   Data Management             |
|   +-------------------------+ |
|   | Export My Data      [>] | |
|   | Download all your data  | |
|   | as a JSON file          | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Clear AI History    [>] | |
|   | Remove all generated    | |
|   | messages and responses  | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Clear Vault Data    [>] | |
|   | Remove all memories     | |
|   +-------------------------+ |
|                               |
|   Legal                       |
|   +-------------------------+ |
|   | Privacy Policy      [>] | |
|   +-------------------------+ |
|   +-------------------------+ |
|   | Terms of Service    [>] | |
|   +-------------------------+ |
|                               |
|   Danger Zone                 |
|   +-------------------------+ |
|   | [!] Delete Account      | |
|   | Permanently remove all  | |
|   | data. Cannot be undone. | |
|   |  [ Delete My Account ]  | |
|   +-------------------------+ |
|                               |
+-------------------------------+
```

**Components:**
- `AppBar` -- back arrow, "Privacy & Security" title
- `SectionLabel` -- "Security" / "Data Management" / "Legal" / "Danger Zone"
- `ToggleTile` -- label 16sp, description 14sp #888, toggle switch right
- `SettingsTile` -- label + description + chevron, navigates to sub-screen or triggers action
- `DangerCard` -- red border, warning icon, title 16sp bold red, description 14sp, "Delete My Account" red button inside, extra confirmation required (type "DELETE" + password)

**User Actions:**
- Toggle biometric lock (triggers biometric enrollment if not set up)
- Toggle vault lock
- Change password (opens change password form)
- Export data (generates and downloads JSON)
- Clear AI history (confirmation dialog)
- Clear vault data (confirmation dialog)
- View privacy policy / terms (opens webview)
- Delete account (multi-step confirmation)

**Navigation:**
- Modal: Change password form
- Modal: Confirmation dialogs for clear/delete actions
- External: Privacy policy and Terms webviews
- Back: `/settings`
- On delete: `/onboarding/welcome` (full reset)

**RTL Notes:**
- Toggle switches move to left
- Labels and descriptions align right
- Chevrons flip
- Danger card: warning icon moves to right, button stays centered

**States:**
- **Default:** All options visible with current states
- **Biometric not available:** Toggle disabled with "Not available on this device" note
- **Exporting:** Progress dialog "Preparing your data..."
- **Exported:** "Data exported! Check your downloads." toast
- **Clearing:** Confirmation + progress + success toast
- **Deleting account:** Multi-step: confirm dialog, type "DELETE", enter password, final confirmation, progress, logout
- **Error:** "Operation failed. Try again." snackbar

---

## Supplementary Screens

---

### Screen 42: Subscription Paywall

- **Route:** `/paywall`
- **Module:** Supplementary
- **Sprint:** Sprint 2
- **Description:** Modal paywall shown when free user tries to access a Pro/Legend feature. Contextual -- shows which feature triggered it and what tier unlocks it. Not blocking; user can always dismiss.

```
+-------------------------------+
|                               |
|   (dim overlay background)    |
|                               |
+-------------------------------+
|   +-------------------------+ |
|   |       [X] close         | |
|   |                         | |
|   |   [crown icon]          | |
|   |                         | |
|   |   Unlock SOS Mode       | |
|   |                         | |
|   |   Get instant help      | |
|   |   when she's upset      | |
|   |   with AI-powered       | |
|   |   action plans.         | |
|   |                         | |
|   |   Included in:          | |
|   |   [star] Pro -- $4.99/mo| |
|   |   [crown] Legend $9.99  | |
|   |                         | |
|   |   [  Start Free Trial ] | |
|   |                         | |
|   |   7-day free trial      | |
|   |   Cancel anytime        | |
|   |                         | |
|   |   [See all plans]       | |
|   +-------------------------+ |
|                               |
+-------------------------------+
```

**Components:**
- `ModalOverlay` -- dim background (black 60% opacity), tap to dismiss
- `PaywallSheet` -- centered card or bottom sheet, radius 16px, max 70% screen height
- `CloseButton` -- X icon top-right, 32dp, dismisses modal
- `CrownIcon` -- large 64dp, gold, centered
- `FeatureTitle` -- dynamic: "Unlock [Feature Name]", 22sp bold, centered
- `FeatureDescription` -- what the feature does, 16sp, centered, max 3 lines
- `TierList` -- which plans include this feature, star/crown icons, plan name + price
- `PrimaryButton` -- "Start Free Trial", accent color, full width within modal
- `LegalText` -- "7-day free trial, Cancel anytime", 12sp #888
- `TextLink` -- "See all plans", navigates to full subscription comparison

**User Actions:**
- Tap "Start Free Trial" to initiate purchase
- Tap "See all plans" to view full comparison
- Tap X or overlay to dismiss and return to previous screen
- Read feature description

**Navigation:**
- Dismiss: returns to previous screen
- Forward: `/onboarding/subscription` or `/settings/subscription` (See all plans)
- Modal: Platform purchase flow

**RTL Notes:**
- Close X moves to top-left
- All text stays centered (no directional change for centered layout)
- Crown icon stays centered
- Tier list: icon moves to right, text left

**States:**
- **Default:** Contextual paywall with feature info
- **Loading:** Purchase in progress, spinner overlay
- **Success:** "Welcome to [Plan]!" toast, modal closes, feature unlocks
- **Error:** "Purchase failed. Try again." inline error
- **Already subscribed:** Should not appear (guard in navigation), but fallback shows "You already have access!"

---

### Screen 43: Empty State Templates

- **Route:** N/A (component templates, not a standalone screen)
- **Module:** Supplementary
- **Sprint:** Sprint 1
- **Description:** Reusable empty state designs for all screens. Consistent pattern: illustration + title + description + CTA button. 6 variations for different contexts.

```
--- Variation 1: First Use ---
+-------------------------------+
|                               |
|                               |
|       [illustration:          |
|        person looking at      |
|        phone with hearts]     |
|                               |
|   Welcome to [Feature]!       |
|                               |
|   [Contextual description     |
|    of what this feature       |
|    does and why it matters]   |
|                               |
|   [  Get Started  ]          |
|                               |
+-------------------------------+

--- Variation 2: No Data ---
+-------------------------------+
|                               |
|       [illustration:          |
|        empty box with         |
|        sparkles]              |
|                               |
|   Nothing here yet            |
|                               |
|   [Encouraging description    |
|    to add first item]         |
|                               |
|   [  Add First [Item]  ]     |
|                               |
+-------------------------------+

--- Variation 3: Search/Filter ---
+-------------------------------+
|                               |
|       [illustration:          |
|        magnifying glass       |
|        with question mark]    |
|                               |
|   No results found            |
|                               |
|   Try adjusting your          |
|   filters or search terms.    |
|                               |
|   [  Clear Filters  ]        |
|                               |
+-------------------------------+

--- Variation 4: Error ---
+-------------------------------+
|                               |
|       [illustration:          |
|        broken connection      |
|        or cloud with X]       |
|                               |
|   Something went wrong        |
|                               |
|   We couldn't load this.      |
|   Check your connection       |
|   and try again.              |
|                               |
|   [  Try Again  ]            |
|                               |
+-------------------------------+

--- Variation 5: Offline ---
+-------------------------------+
|                               |
|       [illustration:          |
|        disconnected wifi]     |
|                               |
|   You're offline              |
|                               |
|   Some features need the      |
|   internet. Connect and       |
|   we'll be right back.        |
|                               |
|   [  Retry  ]                |
|                               |
+-------------------------------+

--- Variation 6: Pro Feature ---
+-------------------------------+
|                               |
|       [illustration:          |
|        locked treasure        |
|        chest]                 |
|                               |
|   This is a Pro feature       |
|                               |
|   Upgrade to unlock           |
|   [feature description].      |
|                               |
|   [  Upgrade Now  ]          |
|   [  Maybe Later  ]          |
|                               |
+-------------------------------+
```

**Components (shared template):**
- `EmptyStateIllustration` -- SVG/Lottie illustration, 160x160dp, centered, theme-aware (different for dark/light mode)
- `EmptyStateTitle` -- 20sp bold, centered
- `EmptyStateDescription` -- 16sp, #888, centered, max 3 lines, line-height 1.5
- `EmptyStateCTA` -- PrimaryButton, centered, contextual label
- Optional `SecondaryLink` -- for dismissible states ("Maybe Later")

**Usage Pattern:**
```
EmptyState(
  illustration: EmptyIllustration.noData,
  title: "Nothing here yet",
  description: "Start by adding your first memory.",
  ctaLabel: "Add Memory",
  onCta: () => navigate('/vault/add'),
)
```

**RTL Notes:**
- All centered content: no directional change needed
- Illustration: check that SVG illustrations are not directional (no left-pointing arrows, etc.)
- If any illustration has directional elements, provide mirrored RTL variant

**States:**
- These ARE the states. Each variation maps to a specific screen state documented in individual screen specs above.

---
---

## Summary

### Total Screen Count: 43

| Module | Screens | Sprint |
|--------|---------|--------|
| Onboarding | 8 (Screens 1-8) | Sprint 1 |
| Dashboard | 3 (Screens 9-11) | Sprint 2 |
| Her Profile | 4 (Screens 12-15) | Sprint 2-3 |
| Smart Reminders | 3 (Screens 16-18) | Sprint 3 |
| AI Message Generator | 4 (Screens 19-22) | Sprint 3-4 |
| Gift Recommendation | 3 (Screens 23-25) | Sprint 4 |
| SOS Mode | 4 (Screens 26-29) | Sprint 4-5 |
| Gamification | 3 (Screens 30-32) | Sprint 5 |
| Smart Action Cards | 2 (Screens 33-34) | Sprint 3 |
| Memory Vault | 4 (Screens 35-38) | Sprint 6 |
| Settings | 3 (Screens 39-41) | Sprint 2, 6 |
| Supplementary | 2 (Screens 42-43) | Sprint 1-2 |
| **Total** | **43 screens** | **6 Sprints** |

---

## Navigation Map

```
                         /onboarding/language
                                |
                         /onboarding/welcome
                                |
                    +-----------+-----------+
                    |                       |
             /onboarding/signup          /login
                    |
             /onboarding/profile
                    |
             /onboarding/zodiac
                    |
             /onboarding/love-language
                    |
             /onboarding/preferences
                    |
             /onboarding/subscription
                    |
    ================+=========================
    |          BOTTOM NAV BAR                |
    |   [home] [msg] [gift] [sos] [her]      |
    ==========================================
         |       |       |      |      |
         v       v       v      v      v
      /home  /messages /gifts  /sos /her-profile
         |       |       |      |      |
         |       |       |      |      +-- /her-profile/zodiac
         |       |       |      |      +-- /her-profile/preferences
         |       |       |      |      +-- /her-profile/cultural
         |       |       |      |
         |       |       |      +-- /sos/assess
         |       |       |      +-- /sos/response
         |       |       |      +-- /sos/coach
         |       |       |
         |       |       +-- /gifts/detail
         |       |       +-- /gifts/low-budget
         |       |
         |       +-- /messages/configure
         |       +-- /messages/result
         |       +-- /messages/history
         |
         +-- /home/checkin (bottom sheet)
         +-- /notifications
         +-- /actions
         |     +-- /actions/detail
         +-- /reminders
         |     +-- /reminders/create
         |     +-- /reminders/promises
         +-- /gamification
         |     +-- /gamification/graph
         |     +-- /gamification/badges
         +-- /vault
         |     +-- /vault/add
         |     +-- /vault/wishlist
         |     +-- /vault/timeline
         +-- /settings
         |     +-- /settings/subscription
         |     +-- /settings/privacy
         +-- /paywall (modal, any screen)
```

---

## Critical User Flows

### Flow 1: First-Time Onboarding (8 steps)

**Goal:** New user downloads app and reaches home dashboard.

| Step | Screen | Action | Duration |
|------|--------|--------|----------|
| 1 | Language Selector | Pick language | 2s |
| 2 | Welcome | Read value prop, tap "Get Started" | 5s |
| 3 | Sign Up | Sign up via Google (1 tap) or email (fill form) | 10-30s |
| 4 | Your Profile | Enter name, age, relationship status | 15s |
| 5 | Her Zodiac | Pick zodiac sign or enter birthday | 10s |
| 6 | Her Love Language | Select love language | 5s |
| 7 | Her Preferences | Pick communication style + interests | 15s |
| 8 | Subscription Teaser | Choose plan or skip | 5s |

**Total: 8 screens, ~67-87 seconds**
**Critical path: Steps 1-3 (must complete), Steps 4-7 (skippable), Step 8 (skippable)**
**Drop-off risk: Step 3 (sign up friction), Step 5 (may not know zodiac)**

---

### Flow 2: Generate and Send AI Message (4 steps)

**Goal:** User generates a personalized message and sends it to her.

| Step | Screen | Action | Duration |
|------|--------|--------|----------|
| 1 | Mode Picker | Tap "Appreciation" mode | 2s |
| 2 | Message Config | Adjust tone, tap "Generate" | 10s |
| 3 | Message Result | Read message, tap "Copy" | 5s |
| 4 | External | Paste in WhatsApp/SMS | 5s |

**Total: 3 in-app screens + 1 external, ~22 seconds**
**Critical path: All steps required**
**Drop-off risk: Step 2 (too many options), Step 3 (message quality not satisfactory)**

---

### Flow 3: SOS Emergency Response (4-5 steps)

**Goal:** User's partner is upset; he needs immediate guidance.

| Step | Screen | Action | Duration |
|------|--------|--------|----------|
| 1 | SOS Entry | Tap "She's Upset" or quick scenario | 2s |
| 2 | Assessment Step 1 | Select what happened | 5s |
| 3 | Assessment Step 2 | Rate severity | 3s |
| 4 | Assessment Step 3 | Add context (optional) | 10s |
| 5 | SOS Response | Read SAY/DO/BUY/GO action plan | 30s |

**Total: 4-5 screens, ~50 seconds (or ~32s via quick scenario shortcut)**
**Critical path: Steps 1, 2, 3, 5 (Step 4 optional)**
**Drop-off risk: Low (high urgency drives completion)**
**Quick shortcut: Step 1 scenario tile skips to Step 5 directly (~12s)**

---

### Flow 4: Daily Check-in + Action Cards (3 steps)

**Goal:** User does daily check-in and acts on a suggestion.

| Step | Screen | Action | Duration |
|------|--------|--------|----------|
| 1 | Home Dashboard | Tap mood button for check-in | 3s |
| 2 | Daily Check-in | Select mood + optional tags, tap Done | 5s |
| 3 | Home Dashboard | AI refreshes action cards, tap a card | 10s |

**Total: 2 screens (check-in is overlay), ~18 seconds**
**Critical path: Steps 1-2 (check-in), Step 3 (optional engagement)**
**Drop-off risk: Step 2 (may skip tags), Step 3 (may not engage with cards)**

---

### Flow 5: Create Reminder + Promise Tracking (3 steps)

**Goal:** User creates a reminder for an upcoming event and logs a promise.

| Step | Screen | Action | Duration |
|------|--------|--------|----------|
| 1 | Reminders List | Tap "+" button | 2s |
| 2 | Create Reminder | Fill title, date, category, notifications | 30s |
| 3 | Reminders List | See new reminder in list | 2s |

**Total: 2 screens, ~34 seconds**
**Critical path: All steps required**
**Drop-off risk: Step 2 (form length -- mitigated by smart defaults and optional fields)**

---

## RTL Impact Assessment

### RTL Complexity Rating Scale
- **Low:** Centered content only, minimal directional elements
- **Medium:** Standard text/icon flipping, list reordering
- **High:** Complex layouts that need structural mirroring (calendars, charts, swipe gestures, chat bubbles)

| Module | Screens | RTL Complexity | Key RTL Concerns |
|--------|---------|---------------|-------------------|
| **Onboarding** | 8 | Medium | Language selector triggers immediate RTL flip; form fields need RTL input; zodiac wheel is non-directional; chip grids reorder |
| **Dashboard** | 3 | High | Action cards have directional swipe; mood grid reorders; notification tiles flip icons/chevrons; bottom nav tab order reverses |
| **Her Profile** | 4 | Medium | Standard form flipping; sliders reverse direction; radio/checkbox indicators swap sides; dropdown arrows flip |
| **Smart Reminders** | 3 | High | Calendar widget needs full RTL: week starts Saturday, swipe direction reverses, day names in Arabic; promise tracker progress bar fills RTL |
| **AI Message Generator** | 4 | Medium | Message content auto-aligns per language; mode grid reorders; star ratings stay LTR (universal); history tiles flip |
| **Gift Recommendation** | 3 | Medium | Product cards flip text alignment; price formatting is locale-specific; vendor tiles flip; image carousels are non-directional |
| **SOS Mode** | 4 | High | SOS button is centered (safe); severity scale reverses; chat bubbles in Conversation Coach swap sides; assessment progress bar fills RTL |
| **Gamification** | 3 | High | Charts need Y-axis on right side; progress bars fill RTL; badge grid reorders; timeline in improvement graph stays LTR (chronological) |
| **Smart Action Cards** | 2 | High | Swipe gestures reverse (right=dismiss in RTL); card stack peek offset mirrors; SAY/DO/BUY/GO sections flip content alignment |
| **Memory Vault** | 4 | High | Timeline vertical line moves to right; wish list reorders; tab bar reverses; biometric prompt is OS-native (auto-RTL) |
| **Settings** | 3 | Medium | Standard settings tile flipping; toggle switches swap sides; danger zone centered (safe); legal links centered |
| **Supplementary** | 2 | Low | Paywall modal is centered; empty states are centered; illustrations must be checked for directional bias |

### RTL Implementation Priority

1. **Sprint 1 (Critical):** Language selector RTL flip, onboarding form RTL, `EdgeInsetsDirectional` established in design system
2. **Sprint 2 (High):** Dashboard action cards, bottom nav, settings tiles, notification list
3. **Sprint 3 (High):** Calendar widget RTL, reminder forms, action card swipe reversal, message generator
4. **Sprint 4 (Medium):** Gift cards, SOS assessment, severity scale reversal
5. **Sprint 5 (Medium):** Gamification charts, conversation coach chat bubbles, achievement grid
6. **Sprint 6 (Medium):** Memory vault timeline, wish list, subscription management

### RTL Testing Checklist (per screen)

- [ ] All `EdgeInsets` replaced with `EdgeInsetsDirectional`
- [ ] `TextDirection.rtl` propagated via `Directionality` widget
- [ ] Icons that imply direction (arrows, chevrons) are mirrored
- [ ] Swipe gestures reversed appropriately
- [ ] Text alignment uses `TextAlign.start` / `TextAlign.end` (not left/right)
- [ ] Numbers display correctly (Arabic-Indic optional, Western default)
- [ ] Date formats use locale-appropriate patterns
- [ ] Fonts load correctly (Cairo/Noto Naskh Arabic for Arabic content)
- [ ] Mixed-direction text (Arabic + English brand names) renders correctly
- [ ] Animations respect direction (slide transitions)

---

*End of Wireframe Specifications Document*
*Prepared by Lina Vazquez, Senior UX/UI Designer -- LOLO*
*February 14, 2026*

