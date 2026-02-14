# LOLO UI String Catalog v1.0

### Prepared by: Lina Vazquez, Senior UX/UI Designer
### Date: February 14, 2026
### Version: 1.0
### Classification: Internal -- Confidential
### Dependencies: Design System (v1.0), Wireframe Specifications (v1.0), Localization Architecture (v1.0), Feature Backlog MoSCoW (v1.0)

---

## Overview

This catalog contains **652 unique UI strings** organized by screen/module, formatted for direct conversion to Flutter ARB (Application Resource Bundle) files. Every string in this document maps to a user-visible text element in the LOLO app.

**Key Naming Convention:** `{module}_{screen}_{element}_{description}`

**Placeholder Syntax:** `{variableName}` for dynamic values (ARB ICU format).

**Notes:**
- Strings are in English (template language). Arabic and Bahasa Melayu translations are handled separately in the ARB pipeline.
- Context comments indicate where each string appears in the UI.
- Strings with `{placeholders}` require corresponding ARB metadata (type, example) in the final ARB file.
- This catalog covers Layer 1 (UI Localization) only. AI-generated content (Layer 2) is not included here.

---

## Table of Contents

1. [Onboarding Strings (62)](#1-onboarding-strings)
2. [Dashboard / Home Strings (35)](#2-dashboard--home-strings)
3. [Her Profile Strings (52)](#3-her-profile-strings)
4. [Reminders Strings (38)](#4-reminders-strings)
5. [AI Messages Strings (48)](#5-ai-messages-strings)
6. [Gift Engine Strings (36)](#6-gift-engine-strings)
7. [SOS Mode Strings (34)](#7-sos-mode-strings)
8. [Gamification Strings (46)](#8-gamification-strings)
9. [Action Cards Strings (28)](#9-action-cards-strings)
10. [Memory Vault Strings (38)](#10-memory-vault-strings)
11. [Settings Strings (48)](#11-settings-strings)
12. [Common / Shared Strings (58)](#12-common--shared-strings)
13. [Error Messages (36)](#13-error-messages)
14. [Notification Text (28)](#14-notification-text)
15. [Subscription / Payment Strings (26)](#15-subscription--payment-strings)
16. [Accessibility Strings (24)](#16-accessibility-strings)
17. [String Count Summary](#17-string-count-summary)

---

## 1. Onboarding Strings

**Total: 62 strings**

### Language Selection (Screen 1)

```
"onboarding_language_title": "Choose Your Language",
// Context: Title on language selection screen (first screen of the app)

"onboarding_language_english": "English",
// Context: Language option label

"onboarding_language_arabic": "العربية",
// Context: Language option label (always displayed in Arabic regardless of current locale)

"onboarding_language_malay": "Bahasa Melayu",
// Context: Language option label (always displayed in Malay regardless of current locale)
```

### Welcome (Screen 2)

```
"onboarding_welcome_tagline": "She won't know why you got so thoughtful.\nWe won't tell.",
// Context: App tagline on welcome screen, below the logo

"onboarding_welcome_benefit1_title": "Smart Reminders",
// Context: First benefit card title on welcome screen

"onboarding_welcome_benefit1_subtitle": "Never forget what matters to her",
// Context: First benefit card subtitle

"onboarding_welcome_benefit2_title": "AI Messages",
// Context: Second benefit card title

"onboarding_welcome_benefit2_subtitle": "Say the right thing, every time",
// Context: Second benefit card subtitle

"onboarding_welcome_benefit3_title": "SOS Mode",
// Context: Third benefit card title

"onboarding_welcome_benefit3_subtitle": "Emergency help when she's upset",
// Context: Third benefit card subtitle

"onboarding_welcome_button_start": "Get Started",
// Context: Primary CTA button on welcome screen

"onboarding_welcome_link_login": "Already have an account? Log in",
// Context: Secondary link below CTA for returning users
```

### Sign Up (Screen 3)

```
"onboarding_signup_title": "Sign Up",
// Context: App bar title on sign up screen

"onboarding_signup_heading": "Create your account",
// Context: Heading below logo on sign up screen

"onboarding_signup_button_google": "Continue with Google",
// Context: Google sign-in button label

"onboarding_signup_button_apple": "Continue with Apple",
// Context: Apple sign-in button label

"onboarding_signup_divider": "or",
// Context: Divider text between social auth and email form

"onboarding_signup_label_email": "Email",
// Context: Email input field label

"onboarding_signup_hint_email": "you@example.com",
// Context: Email input field placeholder

"onboarding_signup_label_password": "Password",
// Context: Password input field label

"onboarding_signup_label_confirmPassword": "Confirm Password",
// Context: Confirm password input field label

"onboarding_signup_button_create": "Create Account",
// Context: Submit button for email sign-up form

"onboarding_signup_legal": "By signing up you agree to our {terms} and {privacy}",
// Context: Legal consent text. {terms} and {privacy} are tappable links.

"onboarding_signup_legal_terms": "Terms of Service",
// Context: Tappable link within legal text

"onboarding_signup_legal_privacy": "Privacy Policy",
// Context: Tappable link within legal text
```

### Login (Returning Users)

```
"onboarding_login_title": "Log In",
// Context: App bar title on login screen

"onboarding_login_heading": "Welcome back",
// Context: Heading on login screen

"onboarding_login_button_login": "Log In",
// Context: Login submit button

"onboarding_login_link_forgot": "Forgot password?",
// Context: Link below login form

"onboarding_login_link_signup": "Don't have an account? Sign up",
// Context: Link below login form for new users
```

### Password Reset

```
"onboarding_reset_title": "Reset Password",
// Context: App bar title on password reset screen

"onboarding_reset_heading": "Enter your email address",
// Context: Heading on password reset screen

"onboarding_reset_subtitle": "We'll send you a link to reset your password.",
// Context: Subtitle below heading

"onboarding_reset_button_send": "Send Reset Link",
// Context: Submit button for password reset

"onboarding_reset_success": "Check your email. We sent a reset link to {email}.",
// Context: Success message after password reset request. {email} is the user's email.
```

### Your Profile (Screen 4)

```
"onboarding_profile_title": "Your Profile",
// Context: App bar title

"onboarding_profile_heading": "Tell us about you",
// Context: Section heading

"onboarding_profile_subtitle": "This helps personalize your experience",
// Context: Supporting text below heading

"onboarding_profile_label_name": "Your Name",
// Context: Name input field label

"onboarding_profile_hint_name": "What should we call you?",
// Context: Name input field placeholder

"onboarding_profile_label_age": "Your Age",
// Context: Age input field label

"onboarding_profile_label_status": "Relationship Status",
// Context: Relationship status radio group label

"onboarding_profile_status_dating": "Dating",
// Context: Relationship status option

"onboarding_profile_status_engaged": "Engaged",
// Context: Relationship status option

"onboarding_profile_status_married": "Married",
// Context: Relationship status option

"onboarding_profile_status_longDistance": "Long-distance",
// Context: Relationship status option

"onboarding_profile_status_complicated": "It's complicated",
// Context: Relationship status option

"onboarding_profile_button_continue": "Continue",
// Context: Continue button

"onboarding_profile_link_skip": "Skip for now",
// Context: Skip link below continue button
```

### Her Zodiac (Screen 5)

```
"onboarding_zodiac_title": "Her Zodiac",
// Context: App bar title

"onboarding_zodiac_heading": "What's her zodiac sign?",
// Context: Section heading

"onboarding_zodiac_subtitle": "This helps us understand her personality",
// Context: Supporting text

"onboarding_zodiac_link_birthday": "Don't know her sign? Enter her birthday instead",
// Context: Link to switch to date picker mode

"onboarding_zodiac_label_birthday": "Her Birthday",
// Context: Date picker label when in birthday mode
```

### Her Love Language (Screen 6)

```
"onboarding_loveLanguage_title": "Her Love Language",
// Context: App bar title

"onboarding_loveLanguage_heading": "How does she feel most loved?",
// Context: Section heading

"onboarding_loveLanguage_words_title": "Words of Affirmation",
// Context: Love language option title

"onboarding_loveLanguage_words_desc": "She loves hearing \"I love you\" and compliments",
// Context: Love language option description

"onboarding_loveLanguage_acts_title": "Acts of Service",
// Context: Love language option title

"onboarding_loveLanguage_acts_desc": "Actions speak louder than words to her",
// Context: Love language option description

"onboarding_loveLanguage_gifts_title": "Receiving Gifts",
// Context: Love language option title

"onboarding_loveLanguage_gifts_desc": "Thoughtful gifts make her feel special",
// Context: Love language option description

"onboarding_loveLanguage_time_title": "Quality Time",
// Context: Love language option title

"onboarding_loveLanguage_time_desc": "Undivided attention means everything to her",
// Context: Love language option description

"onboarding_loveLanguage_touch_title": "Physical Touch",
// Context: Love language option title

"onboarding_loveLanguage_touch_desc": "Hugs, holding hands, and closeness",
// Context: Love language option description

"onboarding_loveLanguage_unknown": "I'm not sure yet",
// Context: Option for users who don't know her love language
```

### Anniversary (Screen 7)

```
"onboarding_anniversary_title": "Your Anniversary",
// Context: App bar title

"onboarding_anniversary_heading": "When did your story begin?",
// Context: Section heading

"onboarding_anniversary_label_dating": "Dating anniversary",
// Context: Date picker label

"onboarding_anniversary_label_wedding": "Wedding date (if applicable)",
// Context: Optional wedding date picker label

"onboarding_anniversary_link_skip": "Skip for now",
// Context: Skip link
```

### Privacy & Notifications (Screen 7.5)

```
"onboarding_privacy_title": "Privacy & Notifications",
// Context: App bar title

"onboarding_privacy_heading": "Your privacy matters",
// Context: Section heading

"onboarding_privacy_toggle_notifications": "Enable smart reminders",
// Context: Toggle label for notification permission

"onboarding_privacy_toggle_biometric": "Lock with fingerprint or face",
// Context: Toggle label for biometric lock

"onboarding_privacy_notice": "Notifications will never show relationship content on your lock screen",
// Context: Privacy notice text below toggles
```

### First Value Moment (Screen 8)

```
"onboarding_firstCard_title": "Your first action card for {partnerName}",
// Context: Title on the first value delivery screen. {partnerName} is the partner's name.

"onboarding_firstCard_subtitle": "Here's something you can do right now",
// Context: Subtitle below the first action card

"onboarding_firstCard_button_start": "Start Using LOLO",
// Context: CTA button that enters the home dashboard

"onboarding_firstCard_button_copy": "Copy This Message",
// Context: Secondary button to copy the first AI-generated message
```

---

## 2. Dashboard / Home Strings

**Total: 35 strings**

### Home Screen

```
"home_title": "Home",
// Context: Bottom nav label and app bar title when on home screen

"home_greeting_morning": "Good morning, {userName}",
// Context: Greeting text at top of home screen (6AM-12PM). {userName} is the user's name.

"home_greeting_afternoon": "Good afternoon, {userName}",
// Context: Greeting text (12PM-5PM)

"home_greeting_evening": "Good evening, {userName}",
// Context: Greeting text (5PM-9PM)

"home_greeting_night": "Good night, {userName}",
// Context: Greeting text (9PM-6AM)

"home_section_todayCards": "Today's Cards",
// Context: Section header for daily action cards

"home_section_upcomingReminders": "Coming Up",
// Context: Section header for upcoming reminders

"home_section_quickActions": "Quick Actions",
// Context: Section header for quick action buttons

"home_label_noCards": "No action cards for today. Check back tomorrow!",
// Context: Empty state when no action cards are available

"home_label_noReminders": "No upcoming reminders",
// Context: Empty state when no reminders are scheduled

"home_label_streak": "{count}-day streak",
// Context: Streak counter display. {count} is the number of days.

"home_label_streakBroken": "Start a new streak today",
// Context: Streak counter when streak is zero/broken

"home_label_level": "Level {level}",
// Context: Level badge on home screen. {level} is the level number.

"home_label_xp": "{current}/{needed} XP",
// Context: XP progress label. {current} is current XP, {needed} is XP for next level.

"home_label_consistencyScore": "Consistency Score: {score}/100",
// Context: Relationship consistency score widget. {score} is the current score.

"home_button_sos": "SOS",
// Context: SOS quick action button label

"home_button_messages": "Messages",
// Context: Messages quick action button label

"home_button_gifts": "Gifts",
// Context: Gifts quick action button label

"home_button_viewAllCards": "View All Cards",
// Context: Link to see all action cards

"home_button_viewAllReminders": "View All Reminders",
// Context: Link to see all reminders

"home_contextCheckin_title": "Quick Check-in",
// Context: Title for the daily context check-in card

"home_contextCheckin_subtitle": "How's {partnerName}'s day?",
// Context: Subtitle for context check-in. {partnerName} is partner's name.

"home_contextCheckin_great": "Great",
// Context: Context check-in mood option

"home_contextCheckin_normal": "Normal",
// Context: Context check-in mood option

"home_contextCheckin_stressed": "Stressed",
// Context: Context check-in mood option

"home_contextCheckin_upset": "Upset",
// Context: Context check-in mood option

"home_contextCheckin_sick": "Sick",
// Context: Context check-in mood option

"home_contextTag_travel": "Travel mode",
// Context: Context tag option

"home_contextTag_busyWeek": "Busy week",
// Context: Context tag option

"home_contextTag_conflict": "Conflict happened",
// Context: Context tag option

"home_contextTag_period": "She's on her period",
// Context: Context tag option

"home_contextTag_pregnant": "She's pregnant",
// Context: Context tag option

"home_contextCheckin_thanks": "Got it. Cards adjusted for today.",
// Context: Confirmation message after context check-in submission

"home_nextAction_title": "Next Best Action",
// Context: Label for the AI-recommended top priority action

"home_nextAction_subtitle": "The single most impactful thing to do today",
// Context: Subtitle for next best action widget
```

---

## 3. Her Profile Strings

**Total: 52 strings**

### Profile Overview

```
"herProfile_title": "Her Profile",
// Context: App bar title and bottom nav label for the Her Profile section

"herProfile_label_name": "Name",
// Context: Profile field label

"herProfile_label_zodiac": "Zodiac Sign",
// Context: Profile field label

"herProfile_label_birthday": "Birthday",
// Context: Profile field label

"herProfile_label_loveLanguage": "Love Language",
// Context: Profile field label

"herProfile_label_commStyle": "Communication Style",
// Context: Profile field label

"herProfile_label_conflictStyle": "Conflict Style",
// Context: Profile field label

"herProfile_label_humorLevel": "Humor Tolerance",
// Context: Profile field label

"herProfile_label_status": "Relationship Status",
// Context: Profile field label

"herProfile_label_completion": "{percent}% complete",
// Context: Profile completion percentage. {percent} is the percentage value.

"herProfile_label_completionCta": "Finish her profile for better recommendations",
// Context: CTA text below incomplete profile progress bar

"herProfile_zodiacDisclaimer": "Based on her zodiac sign. Adjust anything that doesn't match.",
// Context: Disclaimer note next to zodiac-derived personality traits

"herProfile_button_edit": "Edit Profile",
// Context: Button to enter profile editing mode
```

### Profile Sections

```
"herProfile_section_personality": "Personality",
// Context: Section header for personality traits

"herProfile_section_preferences": "Her Preferences",
// Context: Section header for preferences (favorites, dietary, fashion)

"herProfile_section_cultural": "Cultural Context",
// Context: Section header for cultural/religious context settings

"herProfile_section_family": "Family Members",
// Context: Section header for family member tracking

"herProfile_section_sensitive": "Sensitive Topics",
// Context: Section header for topics to avoid

"herProfile_section_favorites": "Favorite Things",
// Context: Section header for quick reference favorites
```

### Personality Fields

```
"herProfile_commStyle_direct": "Direct",
// Context: Communication style option

"herProfile_commStyle_indirect": "Indirect",
// Context: Communication style option

"herProfile_commStyle_mixed": "Mixed",
// Context: Communication style option

"herProfile_conflictStyle_space": "Needs space first",
// Context: Conflict style option

"herProfile_conflictStyle_talk": "Wants to talk immediately",
// Context: Conflict style option

"herProfile_conflictStyle_physical": "Needs physical comfort",
// Context: Conflict style option

"herProfile_conflictStyle_written": "Prefers written words",
// Context: Conflict style option

"herProfile_humorLevel_serious": "Serious",
// Context: Humor tolerance slider label (low end)

"herProfile_humorLevel_balanced": "Balanced",
// Context: Humor tolerance slider label (middle)

"herProfile_humorLevel_lovesJokes": "Loves jokes",
// Context: Humor tolerance slider label (high end)

"herProfile_humorType_sarcastic": "Sarcastic",
// Context: Humor type chip

"herProfile_humorType_wholesome": "Wholesome",
// Context: Humor type chip

"herProfile_humorType_dark": "Dark humor",
// Context: Humor type chip

"herProfile_humorType_silly": "Silly / Playful",
// Context: Humor type chip
```

### Preferences Fields

```
"herProfile_pref_language": "Preferred Message Language",
// Context: Label for which language she prefers for AI messages

"herProfile_pref_interests": "Interests & Hobbies",
// Context: Label for interests tag input

"herProfile_pref_dietary": "Dietary Restrictions",
// Context: Label for dietary preferences

"herProfile_pref_fashionStyle": "Fashion Style",
// Context: Label for fashion preference

"herProfile_pref_clothingSize": "Clothing Size",
// Context: Label for clothing size (for gift accuracy)

"herProfile_pref_shoeSize": "Shoe Size",
// Context: Label for shoe size

"herProfile_hint_interests": "Type and press enter to add",
// Context: Placeholder for tag input fields

"herProfile_favorites_flowers": "Favorite Flowers",
// Context: Quick reference field label

"herProfile_favorites_colors": "Favorite Colors",
// Context: Quick reference field label

"herProfile_favorites_scents": "Favorite Scents",
// Context: Quick reference field label

"herProfile_favorites_restaurants": "Favorite Restaurants",
// Context: Quick reference field label

"herProfile_favorites_music": "Favorite Music",
// Context: Quick reference field label

"herProfile_favorites_movies": "Favorite Movies/Shows",
// Context: Quick reference field label
```

### Cultural & Family

```
"herProfile_cultural_religion": "Religious/Cultural Background",
// Context: Dropdown label

"herProfile_cultural_holidays": "Important Holidays & Occasions",
// Context: Section label for tracked cultural holidays

"herProfile_family_add": "Add Family Member",
// Context: Button to add a family member entry

"herProfile_family_label_name": "Name",
// Context: Family member name field

"herProfile_family_label_relation": "Relationship to her",
// Context: Family member relation dropdown label

"herProfile_family_label_birthday": "Birthday (optional)",
// Context: Family member birthday field

"herProfile_sensitive_add": "Add Sensitive Topic",
// Context: Button to add a topic to avoid

"herProfile_sensitive_hint": "A subject to avoid in messages and suggestions",
// Context: Placeholder for sensitive topic input
```

---

## 4. Reminders Strings

**Total: 38 strings**

### Reminders List

```
"reminders_title": "Reminders",
// Context: App bar title for reminders screen

"reminders_section_upcoming": "Upcoming",
// Context: Section header for upcoming reminders

"reminders_section_past": "Past",
// Context: Section header for past reminders

"reminders_empty_title": "No reminders yet",
// Context: Empty state title

"reminders_empty_subtitle": "Add important dates so you never forget",
// Context: Empty state description

"reminders_empty_button": "Add Your First Reminder",
// Context: Empty state CTA button

"reminders_label_daysAway": "{days} days away",
// Context: Days until reminder. {days} is the number of days.

"reminders_label_today": "Today!",
// Context: Label when a reminder is due today

"reminders_label_tomorrow": "Tomorrow",
// Context: Label when a reminder is due tomorrow

"reminders_label_overdue": "Overdue",
// Context: Label when a reminder is past due

"reminders_label_completed": "Completed",
// Context: Label when a reminder has been marked complete
```

### Create / Edit Reminder

```
"reminders_create_title": "New Reminder",
// Context: App bar title for create reminder screen

"reminders_edit_title": "Edit Reminder",
// Context: App bar title for edit reminder screen

"reminders_create_label_title": "What's the reminder for?",
// Context: Title input label

"reminders_create_hint_title": "e.g., Her birthday, dinner reservation",
// Context: Title input placeholder

"reminders_create_label_date": "Date",
// Context: Date picker label

"reminders_create_label_time": "Time (optional)",
// Context: Time picker label

"reminders_create_label_recurrence": "Repeat",
// Context: Recurrence dropdown label

"reminders_recurrence_none": "One-time",
// Context: Recurrence option

"reminders_recurrence_daily": "Daily",
// Context: Recurrence option

"reminders_recurrence_weekly": "Weekly",
// Context: Recurrence option

"reminders_recurrence_monthly": "Monthly",
// Context: Recurrence option

"reminders_recurrence_yearly": "Yearly",
// Context: Recurrence option

"reminders_create_label_type": "Category",
// Context: Reminder type/category dropdown label

"reminders_type_birthday": "Birthday",
// Context: Reminder category option

"reminders_type_anniversary": "Anniversary",
// Context: Reminder category option

"reminders_type_dateNight": "Date Night",
// Context: Reminder category option

"reminders_type_islamic": "Islamic Holiday",
// Context: Reminder category option

"reminders_type_custom": "Custom",
// Context: Reminder category option

"reminders_create_label_notes": "Notes (optional)",
// Context: Notes text area label

"reminders_create_hint_notes": "Any details to remember",
// Context: Notes text area placeholder

"reminders_create_button_save": "Save Reminder",
// Context: Save button for reminder creation

"reminders_delete_confirm": "Delete this reminder?",
// Context: Confirmation dialog title for reminder deletion
```

### Promise Tracker

```
"reminders_promises_title": "Promise Tracker",
// Context: Section title or screen title for promise tracker

"reminders_promises_create_title": "New Promise",
// Context: App bar title for new promise creation

"reminders_promises_label_what": "What did you promise?",
// Context: Promise text input label

"reminders_promises_hint_what": "e.g., Take her to that Italian restaurant",
// Context: Promise text input placeholder

"reminders_promises_status_open": "Open",
// Context: Promise status badge

"reminders_promises_status_inProgress": "In Progress",
// Context: Promise status badge

"reminders_promises_status_completed": "Kept",
// Context: Promise status badge (completed)

"reminders_promises_status_overdue": "Overdue",
// Context: Promise status badge

"reminders_promises_overdue_message": "This promise is overdue. {partnerName} may have noticed.",
// Context: Warning text on overdue promise. {partnerName} is partner's name.
```

---

## 5. AI Messages Strings

**Total: 48 strings**

### Message Generator

```
"messages_title": "Messages",
// Context: Bottom nav label and app bar title

"messages_generate_title": "Generate a Message",
// Context: Section heading on message generation screen

"messages_generate_label_mode": "What kind of message?",
// Context: Label for message mode selector

"messages_generate_label_tone": "Tone",
// Context: Label for tone selector

"messages_generate_label_length": "Length",
// Context: Label for length selector

"messages_generate_label_language": "Message Language",
// Context: Label for output language override

"messages_generate_label_languageHint": "Send in a different language than your app",
// Context: Hint text under language override dropdown

"messages_generate_button_generate": "Generate Message",
// Context: Primary CTA button to generate a message

"messages_generate_button_regenerate": "Generate Another",
// Context: Button to regenerate a new message with same parameters

"messages_generate_label_generating": "Crafting your message...",
// Context: Loading text while AI generates the message
```

### Message Modes

```
"messages_mode_goodMorning": "Good Morning",
// Context: Message mode chip label

"messages_mode_goodNight": "Good Night",
// Context: Message mode chip label

"messages_mode_appreciation": "Appreciation",
// Context: Message mode chip label

"messages_mode_romance": "Romance",
// Context: Message mode chip label

"messages_mode_apology": "Apology",
// Context: Message mode chip label

"messages_mode_missingYou": "Missing You",
// Context: Message mode chip label

"messages_mode_celebration": "Celebration",
// Context: Message mode chip label

"messages_mode_comfort": "Comfort & Support",
// Context: Message mode chip label

"messages_mode_flirting": "Flirting",
// Context: Message mode chip label

"messages_mode_motivation": "Motivation",
// Context: Message mode chip label

"messages_mode_checkingIn": "Just Checking In",
// Context: Message mode chip label

"messages_mode_deepConvo": "Deep Conversation",
// Context: Message mode chip label

"messages_mode_afterArgument": "After an Argument",
// Context: Message mode chip label

"messages_mode_longDistance": "Long Distance",
// Context: Message mode chip label

"messages_mode_justBecause": "Just Because",
// Context: Message mode chip label
```

### Tone & Length Options

```
"messages_tone_formal": "Formal",
// Context: Tone chip label

"messages_tone_warm": "Warm",
// Context: Tone chip label

"messages_tone_casual": "Casual",
// Context: Tone chip label

"messages_tone_playful": "Playful",
// Context: Tone chip label

"messages_tone_poetic": "Poetic",
// Context: Tone chip label

"messages_tone_funny": "Funny",
// Context: Tone chip label

"messages_length_short": "Short",
// Context: Length option label (1-2 sentences)

"messages_length_medium": "Medium",
// Context: Length option label (3-5 sentences)

"messages_length_long": "Long",
// Context: Length option label (paragraph)
```

### Message Result

```
"messages_result_button_copy": "Copy to Clipboard",
// Context: Button to copy generated message

"messages_result_button_share": "Share via...",
// Context: Button to share message through system share sheet

"messages_result_label_copied": "Copied!",
// Context: Confirmation label after copying message

"messages_result_feedback_label": "How was this message?",
// Context: Label above feedback thumbs

"messages_result_feedback_good": "Good",
// Context: Positive feedback button label (thumbs up)

"messages_result_feedback_bad": "Not great",
// Context: Negative feedback button label (thumbs down)

"messages_result_label_savedToHistory": "Saved to history",
// Context: Confirmation after message is auto-saved
```

### Message History

```
"messages_history_title": "Message History",
// Context: App bar title for message history screen

"messages_history_empty_title": "No messages yet",
// Context: Empty state title

"messages_history_empty_subtitle": "Generate your first message and it will appear here",
// Context: Empty state description

"messages_history_empty_button": "Generate Your First Message",
// Context: Empty state CTA

"messages_limit_free": "{remaining} of {total} free messages remaining this month",
// Context: Free tier limit indicator. {remaining} is messages left, {total} is monthly limit.

"messages_limit_upgrade": "Upgrade for unlimited messages",
// Context: Upgrade CTA shown near the limit indicator
```

---

## 6. Gift Engine Strings

**Total: 36 strings**

### Gift Recommendations

```
"gifts_title": "Gifts",
// Context: Bottom nav label and app bar title

"gifts_recommend_title": "Gift Recommendations",
// Context: Section heading on gift recommendation screen

"gifts_recommend_label_occasion": "What's the occasion?",
// Context: Label for occasion selector

"gifts_recommend_label_budget": "Budget range",
// Context: Label for budget range slider/selector

"gifts_recommend_button_lowBudget": "Low Budget, High Impact",
// Context: Toggle/filter button for budget-conscious mode

"gifts_recommend_button_generate": "Find Gifts",
// Context: CTA button to generate gift recommendations

"gifts_recommend_label_generating": "Finding the perfect gifts...",
// Context: Loading text while AI generates gift suggestions
```

### Gift Occasions

```
"gifts_occasion_birthday": "Birthday",
// Context: Occasion selector option

"gifts_occasion_anniversary": "Anniversary",
// Context: Occasion selector option

"gifts_occasion_apology": "Apology",
// Context: Occasion selector option

"gifts_occasion_justBecause": "Just Because",
// Context: Occasion selector option

"gifts_occasion_valentines": "Valentine's Day",
// Context: Occasion selector option

"gifts_occasion_holiday": "Holiday / Celebration",
// Context: Occasion selector option

"gifts_occasion_graduation": "Graduation",
// Context: Occasion selector option

"gifts_occasion_newBaby": "New Baby",
// Context: Occasion selector option
```

### Gift Detail

```
"gifts_detail_label_priceRange": "Price range: {range}",
// Context: Price range on gift detail card. {range} is like "$50-100".

"gifts_detail_label_whyThisGift": "Why this gift for {partnerName}",
// Context: AI explanation heading. {partnerName} is partner's name.

"gifts_detail_label_whereToGet": "Where to get it",
// Context: Section heading for purchase links

"gifts_detail_button_buyNow": "Buy Now",
// Context: External link button to purchase the gift

"gifts_detail_button_saveForLater": "Save for Later",
// Context: Button to bookmark the gift

"gifts_detail_label_presentation": "Presentation Idea",
// Context: Section heading for gift wrapping/delivery suggestion

"gifts_detail_label_messageToAttach": "Message to Attach",
// Context: Section heading for AI-generated card message to go with gift

"gifts_detail_label_backupPlan": "Backup Plan",
// Context: Section heading for alternative gift suggestion
```

### Gift History & Feedback

```
"gifts_history_title": "Gift History",
// Context: Section heading or screen title for past gifts

"gifts_history_empty_title": "No gifts tracked yet",
// Context: Empty state title

"gifts_history_empty_subtitle": "Track gifts so we can learn what she loves",
// Context: Empty state description

"gifts_feedback_title": "How did she react?",
// Context: Title for gift feedback prompt

"gifts_feedback_loved": "She loved it!",
// Context: Feedback option (5 stars)

"gifts_feedback_liked": "She liked it",
// Context: Feedback option (4 stars)

"gifts_feedback_neutral": "Neutral",
// Context: Feedback option (3 stars)

"gifts_feedback_disliked": "Not her style",
// Context: Feedback option (1-2 stars)

"gifts_feedback_thanks": "Thanks! This helps us recommend better gifts.",
// Context: Confirmation after submitting gift feedback

"gifts_packages_title": "Complete Gift Package",
// Context: Section heading for the full gift + presentation + message bundle

"gifts_wishlist_match": "From her wish list",
// Context: Badge on gift cards that match items from the wish list
```

---

## 7. SOS Mode Strings

**Total: 34 strings**

### SOS Activation

```
"sos_title": "SOS Mode",
// Context: App bar title and quick action button label

"sos_subtitle": "What's happening?",
// Context: Heading on SOS scenario selection screen

"sos_description": "Select what's going on and we'll help you handle it.",
// Context: Supporting text below SOS heading
```

### SOS Scenarios

```
"sos_scenario_argument": "We're in an argument",
// Context: Scenario selection button

"sos_scenario_forgot": "I forgot something important",
// Context: Scenario selection button

"sos_scenario_upset": "She's upset and I don't know why",
// Context: Scenario selection button

"sos_scenario_apologize": "I need to apologize right now",
// Context: Scenario selection button

"sos_scenario_wrongThing": "I said the wrong thing",
// Context: Scenario selection button

"sos_scenario_lastMinuteGift": "I need a last-minute gift",
// Context: Scenario selection button

"sos_scenario_silentTreatment": "She's giving me the silent treatment",
// Context: Scenario selection button

"sos_scenario_caughtLying": "I got caught in a lie",
// Context: Scenario selection button

"sos_scenario_herFamily": "Problem with her family",
// Context: Scenario selection button

"sos_scenario_other": "Something else",
// Context: Scenario selection button (opens freeform input)
```

### SOS Coaching Response

```
"sos_coaching_title": "Here's what to do",
// Context: Heading on the SOS coaching response screen

"sos_coaching_label_sayThis": "Say this",
// Context: Section label for recommended words to say

"sos_coaching_label_dontSay": "Don't say this",
// Context: Section label for words to avoid

"sos_coaching_label_doThis": "Do this",
// Context: Section label for recommended actions

"sos_coaching_label_avoid": "Avoid doing this",
// Context: Section label for actions to avoid

"sos_coaching_label_bodyLanguage": "Body language",
// Context: Section label for body language advice

"sos_coaching_label_timing": "Timing",
// Context: Section label for when to take action

"sos_coaching_label_loading": "Getting you help...",
// Context: Loading text while AI generates SOS response

"sos_coaching_button_moreHelp": "I need more help",
// Context: Button to get additional coaching or escalate

"sos_coaching_button_sendMessage": "Send her a message",
// Context: Button that navigates to AI message generator pre-filled with SOS context

"sos_coaching_button_orderGift": "Order an emergency gift",
// Context: Button that navigates to gift engine with urgency filter
```

### SOS Follow-up

```
"sos_followup_title": "How did it go?",
// Context: Title on follow-up screen (shown after SOS coaching has been viewed)

"sos_followup_better": "It went better",
// Context: Follow-up feedback option

"sos_followup_same": "About the same",
// Context: Follow-up feedback option

"sos_followup_worse": "It got worse",
// Context: Follow-up feedback option

"sos_followup_resolved": "Fully resolved",
// Context: Follow-up feedback option

"sos_followup_thanks_better": "Good to hear. Keep doing what's working.",
// Context: Response message after positive follow-up

"sos_followup_thanks_worse": "Hang in there. Here's what to try next.",
// Context: Response message after negative follow-up, followed by additional coaching

"sos_offline_notice": "You're offline. Showing general tips instead of personalized coaching.",
// Context: Notice banner when offline during SOS mode
```

---

## 8. Gamification Strings

**Total: 46 strings**

### Streak

```
"gamification_streak_label": "{count}-day streak",
// Context: Streak counter display. {count} is the streak count.

"gamification_streak_broken": "Your streak ended. Start a new one today!",
// Context: Message when streak resets to zero

"gamification_streak_milestone": "{count}-day milestone! Keep it up.",
// Context: Celebration message at streak milestones (7, 14, 30, etc.). {count} is the milestone number.

"gamification_streak_record": "New personal best: {count} days!",
// Context: Message when user beats their longest streak. {count} is the new record.
```

### XP & Levels

```
"gamification_xp_label": "{count} XP",
// Context: XP display. {count} is the total XP.

"gamification_xp_gained": "+{count} XP",
// Context: XP gain floating text. {count} is the XP earned.

"gamification_level_label": "Level {level}: {name}",
// Context: Level display. {level} is level number, {name} is level title.

"gamification_levelUp_title": "Level Up!",
// Context: Level-up celebration dialog title

"gamification_levelUp_message": "You've reached Level {level}: {name}",
// Context: Level-up celebration dialog body. {level} is the new level, {name} is the new title.

"gamification_levelUp_button": "Awesome",
// Context: Dismiss button on level-up dialog
```

### Level Names

```
"gamification_level_1": "Rookie",
// Context: Level 1 title

"gamification_level_2": "Initiate",
// Context: Level 2 title

"gamification_level_3": "Apprentice",
// Context: Level 3 title

"gamification_level_4": "Contender",
// Context: Level 4 title

"gamification_level_5": "Strategist",
// Context: Level 5 title

"gamification_level_6": "Guardian",
// Context: Level 6 title

"gamification_level_7": "Protector",
// Context: Level 7 title

"gamification_level_8": "Champion",
// Context: Level 8 title

"gamification_level_9": "Commander",
// Context: Level 9 title

"gamification_level_10": "Architect",
// Context: Level 10 title

"gamification_level_11": "Vanguard",
// Context: Level 11 title

"gamification_level_12": "Legend",
// Context: Level 12 title

"gamification_level_13": "Master",
// Context: Level 13 title

"gamification_level_14": "Grand Master",
// Context: Level 14 title

"gamification_level_15": "Titan",
// Context: Level 15 title
```

### Consistency Score

```
"gamification_score_title": "Relationship Consistency Score",
// Context: Title for the consistency score widget/screen

"gamification_score_value": "{score}/100",
// Context: Score display. {score} is the current score.

"gamification_score_percentile": "More thoughtful than {percent}% of LOLO users",
// Context: Percentile comparison. {percent} is the percentile rank.

"gamification_score_improving": "Trending up this week",
// Context: Positive trend indicator next to score

"gamification_score_declining": "Trending down. Time to step up!",
// Context: Negative trend indicator next to score
```

### Achievements

```
"gamification_achievements_title": "Achievements",
// Context: Section title or screen title for achievements

"gamification_achievements_unlocked": "{count} of {total} unlocked",
// Context: Achievement progress. {count} is unlocked count, {total} is total available.

"gamification_achievement_unlocked": "Achievement Unlocked!",
// Context: Toast/banner when a new achievement is earned

"gamification_achievement_locked": "Locked",
// Context: Label on locked achievement badges
```

### Weekly Challenge

```
"gamification_challenge_title": "Weekly Challenge",
// Context: Section title for the weekly challenge widget

"gamification_challenge_progress": "{completed} of {total} completed",
// Context: Challenge progress. {completed} is done, {total} is target.

"gamification_challenge_completed": "Challenge Complete! +{xp} XP",
// Context: Celebration when weekly challenge is completed. {xp} is bonus XP.

"gamification_challenge_new": "New challenge available",
// Context: Badge text when a new weekly challenge starts

"gamification_challenge_timeLeft": "{days} days left",
// Context: Time remaining for current weekly challenge. {days} is days remaining.
```

### Improvement Graph

```
"gamification_graph_title": "Your Progress",
// Context: Title for the improvement trend graph

"gamification_graph_week": "This Week",
// Context: Tab label for weekly view

"gamification_graph_month": "This Month",
// Context: Tab label for monthly view

"gamification_graph_allTime": "All Time",
// Context: Tab label for all-time view
```

---

## 9. Action Cards Strings

**Total: 28 strings**

### Card Types

```
"cards_title": "Action Cards",
// Context: App bar title and screen title

"cards_badge_say": "SAY",
// Context: Badge label on SAY-type action cards

"cards_badge_do": "DO",
// Context: Badge label on DO-type action cards

"cards_badge_buy": "BUY",
// Context: Badge label on BUY-type action cards

"cards_badge_go": "GO",
// Context: Badge label on GO-type action cards

"cards_label_basedOn": "Based on: {source}",
// Context: Attribution text showing why this card was generated. {source} is like "Words of Affirmation" or "Memory Vault".

"cards_label_difficulty": "Difficulty: {level}",
// Context: Difficulty indicator. {level} is "Easy", "Medium", or "Hard".

"cards_difficulty_easy": "Easy",
// Context: Difficulty level label

"cards_difficulty_medium": "Medium",
// Context: Difficulty level label

"cards_difficulty_hard": "Hard",
// Context: Difficulty level label
```

### Card Actions

```
"cards_button_complete": "I did it!",
// Context: Button to mark an action card as completed

"cards_button_skip": "Skip",
// Context: Button to skip an action card

"cards_button_getHelp": "Get AI Help",
// Context: Button to get AI-generated assistance for completing the card

"cards_button_details": "See Details",
// Context: Button to expand card for more information

"cards_button_recipe": "Show Recipe",
// Context: Button on DO cards that involve cooking (links to recipe)

"cards_button_options": "See Options",
// Context: Button on BUY cards (links to gift recommendations)

"cards_button_bookNow": "Book Now",
// Context: Button on GO cards (links to booking/maps)
```

### Card Completion & Skip

```
"cards_completed_label": "Completed! +{xp} XP",
// Context: Confirmation after marking a card done. {xp} is XP earned.

"cards_skip_title": "Why are you skipping?",
// Context: Title for skip reason bottom sheet

"cards_skip_reason_busy": "Too busy today",
// Context: Skip reason option

"cards_skip_reason_irrelevant": "Not relevant right now",
// Context: Skip reason option

"cards_skip_reason_expensive": "Too expensive",
// Context: Skip reason option

"cards_skip_reason_similar": "Already did something similar",
// Context: Skip reason option

"cards_skip_reason_other": "Other reason",
// Context: Skip reason option
```

### Card History

```
"cards_history_title": "Card History",
// Context: App bar title for card history screen

"cards_history_empty_title": "No cards yet",
// Context: Empty state title

"cards_history_filter_all": "All",
// Context: History filter chip (show all cards)

"cards_history_filter_completed": "Completed",
// Context: History filter chip (show completed cards only)
```

---

## 10. Memory Vault Strings

**Total: 38 strings**

### Vault Overview

```
"memories_title": "Memory Vault",
// Context: Bottom nav label and app bar title

"memories_section_recent": "Recent Memories",
// Context: Section header for recent entries

"memories_section_timeline": "Timeline",
// Context: Section header / tab for chronological view

"memories_section_tags": "By Category",
// Context: Section header / tab for tag-filtered view

"memories_empty_title": "Your vault is empty",
// Context: Empty state title

"memories_empty_subtitle": "Start logging your special moments together",
// Context: Empty state description

"memories_empty_button": "Add a Memory",
// Context: Empty state CTA button

"memories_search_hint": "Search memories...",
// Context: Search input placeholder in Memory Vault
```

### Create / Edit Memory

```
"memories_create_title": "New Memory",
// Context: App bar title for create memory screen

"memories_edit_title": "Edit Memory",
// Context: App bar title for edit memory screen

"memories_create_label_title": "Title",
// Context: Memory title input label

"memories_create_hint_title": "Give this memory a name",
// Context: Memory title input placeholder

"memories_create_label_description": "What happened?",
// Context: Memory description text area label

"memories_create_hint_description": "Tell the story...",
// Context: Memory description placeholder

"memories_create_label_date": "When did this happen?",
// Context: Date picker label for memory

"memories_create_label_photo": "Add photo (optional)",
// Context: Photo picker label

"memories_create_label_tags": "Tags",
// Context: Tag selector label

"memories_create_button_save": "Save Memory",
// Context: Save button
```

### Memory Tags

```
"memories_tag_dateNight": "Date Night",
// Context: Memory tag chip

"memories_tag_gift": "Gift",
// Context: Memory tag chip

"memories_tag_conversation": "Conversation",
// Context: Memory tag chip

"memories_tag_trip": "Trip",
// Context: Memory tag chip

"memories_tag_milestone": "Milestone",
// Context: Memory tag chip

"memories_tag_funny": "Funny Moment",
// Context: Memory tag chip

"memories_tag_conflict": "Conflict & Resolution",
// Context: Memory tag chip

"memories_tag_insideJoke": "Inside Joke",
// Context: Memory tag chip

"memories_tag_firstTime": "First Time",
// Context: Memory tag chip (first date, first kiss, first trip, etc.)
```

### Wish List

```
"memories_wishlist_title": "Wish List",
// Context: Section title or tab for the wish list within Memory Vault

"memories_wishlist_subtitle": "Things she mentioned wanting",
// Context: Subtitle below wish list title

"memories_wishlist_add_title": "Add to Wish List",
// Context: Button label and dialog title for adding a wish list item

"memories_wishlist_add_hint": "She said she wants...",
// Context: Wish list item input placeholder

"memories_wishlist_label_price": "Approximate price (optional)",
// Context: Price field label for wish list item

"memories_wishlist_label_priority": "Priority",
// Context: Priority selector label

"memories_wishlist_priority_nice": "Nice to have",
// Context: Priority option

"memories_wishlist_priority_wants": "She really wants this",
// Context: Priority option

"memories_wishlist_priority_hinted": "She strongly hinted at this",
// Context: Priority option

"memories_wishlist_empty_title": "No wishes captured yet",
// Context: Empty state title

"memories_wishlist_empty_subtitle": "Listen for hints and log them here",
// Context: Empty state description
```

---

## 11. Settings Strings

**Total: 48 strings**

### Settings Main

```
"settings_title": "Settings",
// Context: App bar title

"settings_section_general": "General",
// Context: Section header

"settings_section_appearance": "Appearance",
// Context: Section header

"settings_section_notifications": "Notifications",
// Context: Section header

"settings_section_privacy": "Privacy & Security",
// Context: Section header

"settings_section_subscription": "Subscription",
// Context: Section header

"settings_section_data": "Data & Storage",
// Context: Section header

"settings_section_account": "Account",
// Context: Section header

"settings_section_about": "About",
// Context: Section header
```

### General Settings

```
"settings_label_language": "Language",
// Context: Setting row label for language selection

"settings_label_language_value_en": "English",
// Context: Current language display value

"settings_label_language_value_ar": "العربية",
// Context: Current language display value

"settings_label_language_value_ms": "Bahasa Melayu",
// Context: Current language display value

"settings_label_region": "Region",
// Context: Setting row label for region/locale

"settings_label_calendarType": "Calendar Type",
// Context: Setting row label for calendar preference

"settings_calendar_gregorian": "Gregorian",
// Context: Calendar type option

"settings_calendar_hijri": "Hijri",
// Context: Calendar type option
```

### Appearance Settings

```
"settings_label_theme": "Theme",
// Context: Setting row label for theme selection

"settings_theme_system": "System Default",
// Context: Theme option that follows OS setting

"settings_theme_dark": "Dark",
// Context: Theme option for dark mode

"settings_theme_light": "Light",
// Context: Theme option for light mode

"settings_label_reduceMotion": "Reduce Motion",
// Context: Toggle label for reduced animation mode

"settings_label_reduceMotion_desc": "Simplifies animations throughout the app",
// Context: Setting description text
```

### Notification Settings

```
"settings_label_notifications": "Push Notifications",
// Context: Toggle label for enabling/disabling notifications

"settings_label_quietHours": "Quiet Hours",
// Context: Setting row label for do-not-disturb window

"settings_label_quietHours_desc": "No notifications during this time",
// Context: Setting description text

"settings_label_quietHours_from": "From",
// Context: Time picker label for quiet hours start

"settings_label_quietHours_to": "To",
// Context: Time picker label for quiet hours end

"settings_label_reminderNotifications": "Reminder Alerts",
// Context: Toggle label for reminder-specific notifications

"settings_label_cardNotifications": "Daily Action Card",
// Context: Toggle label for daily action card push notification

"settings_label_streakNotifications": "Streak Reminders",
// Context: Toggle label for streak maintenance reminders

"settings_label_discreetMode": "Discreet Notifications",
// Context: Toggle label for notification content hiding

"settings_label_discreetMode_desc": "Notifications show generic text instead of relationship content",
// Context: Setting description text
```

### Privacy & Security Settings

```
"settings_label_biometric": "Biometric Lock",
// Context: Toggle label for fingerprint/face lock

"settings_label_biometric_desc": "Require fingerprint or face to open LOLO",
// Context: Setting description text

"settings_label_stealthMode": "Stealth Mode",
// Context: Toggle label for stealth/disguise mode

"settings_label_stealthMode_desc": "Changes app name and icon to look like a utility app",
// Context: Setting description text

"settings_label_prayerAware": "Prayer Time Awareness",
// Context: Toggle label for avoiding notifications during Islamic prayer times

"settings_label_prayerAware_desc": "Avoid sending notifications during prayer times",
// Context: Setting description text
```

### Data & Account

```
"settings_label_dataExport": "Export My Data",
// Context: Setting action row label

"settings_label_dataExport_desc": "Download all your data as a file",
// Context: Setting description text

"settings_label_clearCache": "Clear Cache",
// Context: Setting action row label

"settings_label_cacheSize": "Cache: {size}",
// Context: Current cache size display. {size} is like "45 MB".

"settings_label_logout": "Sign Out",
// Context: Sign out button

"settings_label_deleteAccount": "Delete Account",
// Context: Delete account button (destructive)

"settings_delete_confirm_title": "Delete your account?",
// Context: Confirmation dialog title

"settings_delete_confirm_body": "This will permanently delete your account and all data. This action cannot be undone.",
// Context: Confirmation dialog body text

"settings_delete_confirm_button": "Delete My Account",
// Context: Destructive confirm button in delete dialog

"settings_label_version": "Version {version}",
// Context: App version display at bottom of settings. {version} is the version string.
```

---

## 12. Common / Shared Strings

**Total: 58 strings**

### Buttons

```
"common_button_cancel": "Cancel",
// Context: Universal cancel action

"common_button_save": "Save",
// Context: Universal save action

"common_button_done": "Done",
// Context: Universal completion/dismiss action

"common_button_next": "Next",
// Context: Universal next/continue action

"common_button_back": "Back",
// Context: Universal back/previous action

"common_button_skip": "Skip",
// Context: Universal skip action

"common_button_retry": "Try Again",
// Context: Universal retry after error

"common_button_copy": "Copy",
// Context: Universal copy to clipboard action

"common_button_share": "Share",
// Context: Universal share action

"common_button_delete": "Delete",
// Context: Universal delete action

"common_button_edit": "Edit",
// Context: Universal edit action

"common_button_close": "Close",
// Context: Universal close/dismiss action

"common_button_confirm": "Confirm",
// Context: Universal confirmation action

"common_button_ok": "OK",
// Context: Universal acknowledgement action

"common_button_yes": "Yes",
// Context: Universal affirmative

"common_button_no": "No",
// Context: Universal negative

"common_button_learnMore": "Learn More",
// Context: Link to additional information

"common_button_viewAll": "View All",
// Context: Link to see full list

"common_button_seeMore": "See More",
// Context: Expand content action

"common_button_refresh": "Refresh",
// Context: Pull-to-refresh or manual refresh action

"common_button_apply": "Apply",
// Context: Apply filter/setting changes
```

### Labels

```
"common_label_loading": "Loading...",
// Context: Generic loading indicator text

"common_label_offline": "You're offline",
// Context: Offline status indicator

"common_label_offlineDetail": "Showing cached data. Some features may be limited.",
// Context: Expanded offline notice

"common_label_lastUpdated": "Last updated {time}",
// Context: Data freshness indicator. {time} is relative time like "5 minutes ago".

"common_label_required": "Required",
// Context: Required field indicator

"common_label_optional": "Optional",
// Context: Optional field indicator

"common_label_today": "Today",
// Context: Date label for today

"common_label_yesterday": "Yesterday",
// Context: Date label for yesterday

"common_label_tomorrow": "Tomorrow",
// Context: Date label for tomorrow

"common_label_search": "Search",
// Context: Search input label

"common_label_noResults": "No results found",
// Context: Empty search results message

"common_label_noResultsHint": "Try adjusting your search or filters",
// Context: Hint text below empty search results

"common_label_and": "and",
// Context: Conjunction used in lists

"common_label_or": "or",
// Context: Conjunction/divider
```

### Time & Date

```
"common_time_justNow": "Just now",
// Context: Relative timestamp for very recent activity

"common_time_minutesAgo": "{count} min ago",
// Context: Relative timestamp. {count} is number of minutes.

"common_time_hoursAgo": "{count}h ago",
// Context: Relative timestamp. {count} is number of hours.

"common_time_daysAgo": "{count}d ago",
// Context: Relative timestamp. {count} is number of days.
```

### Navigation

```
"common_nav_home": "Home",
// Context: Bottom navigation tab label

"common_nav_messages": "Messages",
// Context: Bottom navigation tab label

"common_nav_gifts": "Gifts",
// Context: Bottom navigation tab label

"common_nav_memories": "Memories",
// Context: Bottom navigation tab label

"common_nav_profile": "Profile",
// Context: Bottom navigation tab label
```

### Zodiac Signs

```
"common_zodiac_aries": "Aries",
// Context: Zodiac sign name

"common_zodiac_taurus": "Taurus",
// Context: Zodiac sign name

"common_zodiac_gemini": "Gemini",
// Context: Zodiac sign name

"common_zodiac_cancer": "Cancer",
// Context: Zodiac sign name

"common_zodiac_leo": "Leo",
// Context: Zodiac sign name

"common_zodiac_virgo": "Virgo",
// Context: Zodiac sign name

"common_zodiac_libra": "Libra",
// Context: Zodiac sign name

"common_zodiac_scorpio": "Scorpio",
// Context: Zodiac sign name

"common_zodiac_sagittarius": "Sagittarius",
// Context: Zodiac sign name

"common_zodiac_capricorn": "Capricorn",
// Context: Zodiac sign name

"common_zodiac_aquarius": "Aquarius",
// Context: Zodiac sign name

"common_zodiac_pisces": "Pisces",
// Context: Zodiac sign name
```

---

## 13. Error Messages

**Total: 36 strings**

### Generic Errors

```
"error_generic": "Something went wrong. Please try again.",
// Context: Fallback error message for unhandled errors

"error_network": "No internet connection. Please check your network.",
// Context: Network connectivity error

"error_timeout": "Request timed out. Please try again.",
// Context: Server request timeout error

"error_serverDown": "Our servers are having trouble. Please try again later.",
// Context: Server 500-level error

"error_unauthorized": "Session expired. Please sign in again.",
// Context: Authentication token expired
```

### Auth Errors

```
"error_auth_emailInUse": "This email is already registered. Try logging in instead.",
// Context: Sign-up error when email already exists

"error_auth_invalidEmail": "Please enter a valid email address.",
// Context: Email validation error

"error_auth_weakPassword": "Password must be at least 8 characters.",
// Context: Password strength validation error

"error_auth_passwordMismatch": "Passwords don't match.",
// Context: Confirm password validation error

"error_auth_wrongPassword": "Incorrect password. Please try again.",
// Context: Login error for wrong password

"error_auth_userNotFound": "No account found with this email.",
// Context: Login error when email is not registered

"error_auth_tooManyAttempts": "Too many attempts. Please try again in a few minutes.",
// Context: Rate limiting error for auth

"error_auth_googleFailed": "Google sign-in failed. Please try again.",
// Context: Google OAuth error

"error_auth_appleFailed": "Apple sign-in failed. Please try again.",
// Context: Apple Sign-In error
```

### Form Validation

```
"error_form_required": "This field is required.",
// Context: Generic required field validation error

"error_form_tooShort": "Must be at least {min} characters.",
// Context: Minimum length validation. {min} is the minimum character count.

"error_form_tooLong": "Must be {max} characters or fewer.",
// Context: Maximum length validation. {max} is the maximum character count.

"error_form_invalidDate": "Please enter a valid date.",
// Context: Date input validation error

"error_form_ageTooYoung": "You must be at least 18 to use LOLO.",
// Context: Age validation error for minimum age

"error_form_ageTooHigh": "Please enter a valid age.",
// Context: Age validation error for unreasonable values
```

### Feature-Specific Errors

```
"error_ai_generationFailed": "Could not generate a message. Please try again.",
// Context: AI message generation failure

"error_ai_contentFiltered": "The generated content was filtered for safety. Trying again...",
// Context: Content safety filter triggered

"error_gift_loadFailed": "Could not load gift recommendations. Please try again.",
// Context: Gift engine API failure

"error_sos_loadFailed": "Could not load coaching advice. Showing general tips.",
// Context: SOS coaching API failure with offline fallback

"error_reminder_saveFailed": "Could not save this reminder. Please try again.",
// Context: Reminder save failure

"error_memory_saveFailed": "Could not save this memory. Please try again.",
// Context: Memory vault save failure

"error_memory_photoFailed": "Could not upload the photo. Please check your connection.",
// Context: Photo upload failure in Memory Vault

"error_profile_saveFailed": "Could not save profile changes. Please try again.",
// Context: Her Profile save failure

"error_subscription_failed": "Purchase could not be completed. You were not charged.",
// Context: In-app purchase failure

"error_subscription_restoreFailed": "Could not restore purchases. Please try again.",
// Context: Purchase restoration failure

"error_data_exportFailed": "Could not export your data. Please try again later.",
// Context: Data export failure

"error_data_deleteFailed": "Could not delete your account. Please contact support.",
// Context: Account deletion failure

"error_biometric_failed": "Biometric authentication failed. Please try again or use your password.",
// Context: Fingerprint/face recognition failure

"error_permission_notifications": "LOLO needs notification permission to send reminders. Enable in Settings.",
// Context: Notification permission denied

"error_permission_camera": "LOLO needs camera access to add photos. Enable in Settings.",
// Context: Camera permission denied

"error_permission_photos": "LOLO needs photo library access to add photos. Enable in Settings.",
// Context: Photo library permission denied
```

---

## 14. Notification Text

**Total: 28 strings**

### Reminder Notifications

```
"notification_reminder_title_7day": "Coming up in 7 days",
// Context: Push notification title for 7-day reminder

"notification_reminder_title_3day": "3 days away",
// Context: Push notification title for 3-day reminder

"notification_reminder_title_1day": "Tomorrow!",
// Context: Push notification title for 1-day reminder

"notification_reminder_title_today": "Today!",
// Context: Push notification title for same-day reminder

"notification_reminder_body": "{reminderTitle} is {timeframe}. {suggestion}",
// Context: Push notification body. {reminderTitle} is like "Her birthday", {timeframe} is like "in 3 days", {suggestion} is an AI-generated tip.

"notification_reminder_body_discreet": "Reminder: {timeframe}",
// Context: Discreet mode notification body. Only shows timing, no relationship content.
```

### Streak Notifications

```
"notification_streak_title": "Keep your streak alive!",
// Context: Push notification title for streak maintenance

"notification_streak_body": "You're on a {count}-day streak. Complete today's card to keep it going.",
// Context: Push notification body. {count} is current streak.

"notification_streak_body_discreet": "Daily task pending",
// Context: Discreet mode streak notification

"notification_streak_milestone_title": "Streak Milestone!",
// Context: Push notification for streak achievement

"notification_streak_milestone_body": "{count} days of consistency. That's impressive.",
// Context: Milestone celebration body. {count} is the milestone number.
```

### Action Card Notifications

```
"notification_card_title": "Today's action card is ready",
// Context: Push notification for daily card delivery

"notification_card_body": "A new {cardType} card for {partnerName}. Tap to see it.",
// Context: Card notification body. {cardType} is SAY/DO/BUY/GO, {partnerName} is partner's name.

"notification_card_body_discreet": "New suggestion available",
// Context: Discreet mode card notification
```

### Promise Notifications

```
"notification_promise_title": "Promise check-in",
// Context: Push notification for overdue promise

"notification_promise_body": "You promised to {promiseText}. Have you followed through?",
// Context: Promise reminder body. {promiseText} is the promise summary.

"notification_promise_body_discreet": "Action item reminder",
// Context: Discreet mode promise notification
```

### Context-Based Notifications

```
"notification_context_title": "Quick check-in",
// Context: Push notification prompting daily context input

"notification_context_body": "How's {partnerName}'s day? A quick tap helps us personalize your cards.",
// Context: Context check-in body. {partnerName} is partner's name.

"notification_context_body_discreet": "Daily update needed",
// Context: Discreet mode context notification
```

### Achievement Notifications

```
"notification_achievement_title": "Achievement unlocked!",
// Context: Push notification for achievement unlock

"notification_achievement_body": "You earned: {achievementName}",
// Context: Achievement body. {achievementName} is the achievement title.

"notification_levelUp_title": "Level up!",
// Context: Push notification for level advance

"notification_levelUp_body": "You're now Level {level}: {name}. Keep building momentum.",
// Context: Level up body. {level} is new level number, {name} is level title.
```

### Subscription Notifications

```
"notification_trial_ending_title": "Your free trial ends soon",
// Context: Push notification 2 days before trial expiry

"notification_trial_ending_body": "Your Pro trial ends in {days} days. Subscribe to keep all features.",
// Context: Trial expiry body. {days} is days remaining.

"notification_subscription_expired_title": "Your subscription has ended",
// Context: Push notification after subscription expires

"notification_subscription_expired_body": "You're now on the free plan. Upgrade anytime to unlock all features.",
// Context: Subscription expiry body
```

---

## 15. Subscription / Payment Strings

**Total: 26 strings**

### Paywall Screen

```
"subscription_title": "Subscription",
// Context: App bar title for subscription management screen

"subscription_paywall_title": "Unlock Full Power",
// Context: Paywall screen main heading

"subscription_paywall_subtitle": "Become the partner she deserves",
// Context: Paywall screen subheading

"subscription_paywall_button_trial": "Start 7-Day Free Trial",
// Context: Primary CTA on paywall (when trial is available)

"subscription_paywall_button_subscribe": "Subscribe Now",
// Context: Primary CTA on paywall (when no trial)

"subscription_paywall_label_restore": "Restore Purchases",
// Context: Link for restoring previous purchases

"subscription_paywall_label_terms": "Subscription Terms",
// Context: Link to subscription terms document
```

### Tier Names & Labels

```
"subscription_tier_free": "Free",
// Context: Free tier name

"subscription_tier_pro": "Pro",
// Context: Pro tier name

"subscription_tier_legend": "Legend",
// Context: Legend (highest) tier name

"subscription_tier_current": "Current Plan",
// Context: Badge on the user's current plan

"subscription_tier_recommended": "Recommended",
// Context: Badge on the suggested plan
```

### Feature Comparison

```
"subscription_feature_unlimitedMessages": "Unlimited AI messages",
// Context: Feature row in plan comparison

"subscription_feature_unlimitedCards": "Unlimited action cards",
// Context: Feature row in plan comparison

"subscription_feature_allModes": "All 15 message modes",
// Context: Feature row in plan comparison

"subscription_feature_advancedGifts": "Advanced gift recommendations",
// Context: Feature row in plan comparison

"subscription_feature_memoryVault": "Full Memory Vault access",
// Context: Feature row in plan comparison

"subscription_feature_sosMode": "Unlimited SOS Mode",
// Context: Feature row in plan comparison

"subscription_feature_priorityAI": "Priority AI processing",
// Context: Feature row in plan comparison (Legend tier)

"subscription_feature_noAds": "No ads",
// Context: Feature row in plan comparison
```

### Payment & Billing

```
"subscription_price_monthly": "{price}/month",
// Context: Monthly pricing display. {price} is like "$4.99".

"subscription_price_yearly": "{price}/year",
// Context: Yearly pricing display. {price} is like "$29.99".

"subscription_price_yearlyMonthly": "That's just {price}/month",
// Context: Per-month breakdown for yearly plan. {price} is like "$2.50".

"subscription_label_savingsYearly": "Save {percent}%",
// Context: Savings badge on yearly plan. {percent} is the discount percentage.

"subscription_paywall_trigger_messages": "You've used all {count} free messages this month",
// Context: Soft paywall trigger when free message limit is reached. {count} is the monthly limit.

"subscription_paywall_trigger_sos": "SOS Mode is a Pro feature",
// Context: Soft paywall trigger when attempting SOS Mode on free tier
```

---

## 16. Accessibility Strings

**Total: 24 strings**

These strings are used as `semanticLabel`, `tooltip`, or `Semantics` widget labels for screen readers (TalkBack on Android, VoiceOver on iOS).

### Navigation

```
"a11y_nav_home": "Home tab. View dashboard and today's action cards.",
// Context: Semantics label for Home bottom nav tab

"a11y_nav_messages": "Messages tab. Generate AI-powered messages.",
// Context: Semantics label for Messages bottom nav tab

"a11y_nav_gifts": "Gifts tab. Get gift recommendations.",
// Context: Semantics label for Gifts bottom nav tab

"a11y_nav_memories": "Memories tab. Access your Memory Vault.",
// Context: Semantics label for Memories bottom nav tab

"a11y_nav_profile": "Profile tab. View and edit her profile.",
// Context: Semantics label for Profile bottom nav tab
```

### Buttons & Actions

```
"a11y_button_sos": "SOS Mode. Emergency relationship help.",
// Context: Semantics label for SOS button

"a11y_button_back": "Go back to previous screen",
// Context: Semantics label for back navigation button

"a11y_button_close": "Close this dialog",
// Context: Semantics label for close/dismiss button

"a11y_button_menu": "Open menu",
// Context: Semantics label for hamburger menu (if used)

"a11y_button_copyMessage": "Copy this message to clipboard",
// Context: Semantics label for message copy button

"a11y_button_shareMessage": "Share this message via other apps",
// Context: Semantics label for message share button
```

### Cards & Widgets

```
"a11y_card_action": "{cardType} action card. {actionText}. Difficulty: {difficulty}. Reward: {xp} XP.",
// Context: Full semantics label for an action card. Screen reader reads the complete card context.

"a11y_card_reminder": "Reminder: {title}. {timeframe}.",
// Context: Semantics label for a reminder card. {title} is reminder title, {timeframe} is like "3 days away".

"a11y_streak": "Current streak: {count} days.",
// Context: Semantics label for streak counter widget.

"a11y_level": "Current level: {level}, {name}. {current} of {needed} XP to next level.",
// Context: Semantics label for level progress widget.

"a11y_score": "Relationship Consistency Score: {score} out of 100.",
// Context: Semantics label for consistency score ring.

"a11y_profileCompletion": "Her profile is {percent} percent complete.",
// Context: Semantics label for profile completion progress bar.
```

### Images & Media

```
"a11y_avatar_partner": "Profile photo of {partnerName}",
// Context: Semantics label for partner's avatar image. {partnerName} is partner name.

"a11y_avatar_user": "Your profile photo",
// Context: Semantics label for user's own avatar

"a11y_image_memory": "Memory photo: {title}",
// Context: Semantics label for photos in Memory Vault. {title} is the memory title.

"a11y_image_gift": "Photo of gift: {giftName}",
// Context: Semantics label for gift product images. {giftName} is the gift name.

"a11y_zodiac_icon": "Zodiac sign: {sign}",
// Context: Semantics label for zodiac sign icons. {sign} is the sign name.

"a11y_loveLanguage_icon": "Love language: {language}",
// Context: Semantics label for love language icons. {language} is the love language name.

"a11y_badge_achievement": "Achievement badge: {name}. {status}.",
// Context: Semantics label for achievement badges. {name} is achievement name, {status} is "Unlocked" or "Locked".
```

---

## 17. String Count Summary

| Module | String Count |
|--------|:-----------:|
| Onboarding | 62 |
| Dashboard / Home | 35 |
| Her Profile | 52 |
| Reminders | 38 |
| AI Messages | 48 |
| Gift Engine | 36 |
| SOS Mode | 34 |
| Gamification | 46 |
| Action Cards | 28 |
| Memory Vault | 38 |
| Settings | 48 |
| Common / Shared | 58 |
| Error Messages | 36 |
| Notification Text | 28 |
| Subscription / Payment | 26 |
| Accessibility | 24 |
| **Total** | **637** |

**Note:** This count covers Layer 1 (UI strings) only. An additional estimated 100-200 strings will be needed for:
- Achievement names and descriptions (50+)
- Zodiac sign descriptions and trait labels (60+)
- AI-generated content templates (Layer 2, not ARB-based)
- Store listing metadata (title, descriptions per language)
- Legal documents (Terms of Service, Privacy Policy)

These additional strings will be cataloged in a supplementary document as they are finalized.

---

## Appendix: ARB Metadata Template

For strings with placeholders, the ARB file requires metadata entries. Here is the pattern:

```json
{
  "home_greeting_morning": "Good morning, {userName}",
  "@home_greeting_morning": {
    "description": "Greeting text at top of home screen, shown between 6AM-12PM",
    "placeholders": {
      "userName": {
        "type": "String",
        "example": "Marcus"
      }
    }
  }
}
```

**Placeholder Types Used in This Catalog:**

| Type | Usage | Example Strings |
|------|-------|----------------|
| `String` | Names, text values | `{userName}`, `{partnerName}`, `{achievementName}`, `{email}` |
| `int` | Counts, numbers, scores | `{count}`, `{level}`, `{score}`, `{percent}`, `{xp}`, `{days}` |
| `String` (formatted) | Prices, ranges, versions | `{price}`, `{range}`, `{version}`, `{size}`, `{time}` |

**Pluralization:** Strings like "{count}-day streak" should use ICU plural syntax in the final ARB files for languages that require it (Arabic has 6 plural forms: zero, one, two, few, many, other).

```json
{
  "gamification_streak_label": "{count, plural, =0{No streak} =1{1-day streak} other{{count}-day streak}}",
  "@gamification_streak_label": {
    "description": "Streak counter display",
    "placeholders": {
      "count": {
        "type": "int",
        "example": "14"
      }
    }
  }
}
```

---

**End of UI String Catalog**

*Next deliverables: Arabic (app_ar.arb) and Bahasa Melayu (app_ms.arb) translation files, High-Fidelity Figma Designs*
