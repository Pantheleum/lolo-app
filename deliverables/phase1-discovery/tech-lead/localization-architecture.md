# LOLO Localization Architecture

**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Dependencies:** Architecture Document (v1.0), Feature Backlog MoSCoW (v1.0), User Personas & Journey Maps (v1.0)

---

## Table of Contents

1. [Localization Strategy](#section-1-localization-strategy)
2. [ARB File Structure](#section-2-arb-file-structure)
3. [RTL Implementation](#section-3-rtl-implementation)
4. [Arabic Typography](#section-4-arabic-typography)
5. [AI Content Localization](#section-5-ai-content-localization)
6. [Implementation Checklist](#section-6-implementation-checklist)

---

## Section 1: Localization Strategy

### 1.1 Two-Layer Localization Approach

LOLO's localization operates on two fundamentally different layers that must be addressed with distinct strategies:

**Layer 1: UI Localization (ARB Files)**

This layer covers all static and semi-static text that appears in the app interface. It is handled by Flutter's built-in `flutter_localizations` system with ARB (Application Resource Bundle) files.

| Scope | Examples | Source |
|-------|---------|--------|
| Navigation labels | "Home", "Messages", "Gifts", "Memories", "Profile" | ARB files |
| Button text | "Generate", "Copy", "Share", "Complete", "Skip" | ARB files |
| Screen titles | "Smart Action Cards", "Her Profile", "SOS Mode" | ARB files |
| Form labels | "Partner's Name", "Birthday", "Zodiac Sign" | ARB files |
| System messages | "No internet connection", "Loading...", "Error occurred" | ARB files |
| Notification templates | "Your streak is at {count} days!", "Reminder: {title}" | ARB files |
| Paywall text | "Upgrade to Pro", "5 messages remaining this month" | ARB files |
| Gamification labels | "Level 5: Strategist", "Relationship Consistency Score" | ARB files |
| Settings options | "Dark Mode", "Quiet Hours", "Language" | ARB files |

**Layer 2: AI Content Localization (Native Generation)**

This layer covers all dynamically generated text produced by AI models. Instead of translating English AI output, each language gets native-language generation from the ground up.

| Scope | Examples | Source |
|-------|---------|--------|
| AI-generated messages | Love messages, apologies, morning greetings | AI model (language parameter) |
| Action card suggestions | "SAY: Tell her you noticed..." | AI model (language + cultural context) |
| Gift recommendations | Gift names, descriptions, reasoning | AI model (language + locale) |
| SOS coaching responses | "Say this: ...", "Don't say: ..." | AI model (language + cultural context) |
| Occasion-based content | Eid messages, Ramadan suggestions | AI model (cultural + religious context) |

**Why Two Layers?**

Translating AI-generated content from English would produce stilted, culturally inappropriate output. Ahmed's Gulf Arabic apology message and Hafiz's Malaysian BM comfort message must be generated natively in those languages -- not translated from an English original. The AI models receive the target language as a primary parameter and generate content directly in that language with the appropriate cultural tone, dialect, and expression patterns.

### 1.2 Runtime Locale Switching (No Restart)

LOLO supports instant language switching without app restart. This is critical because:
- Users may want to switch languages to show the app to someone
- Ahmed may switch between Arabic and English contextually
- Testing requires rapid language switching

**Implementation Architecture:**

```dart
// === Locale Provider (Riverpod) ===

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    // Load saved locale from Hive, fallback to system locale
    final savedCode = ref.read(settingsBoxProvider).get('language');
    if (savedCode != null) return Locale(savedCode);

    // Auto-detect from system
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (['en', 'ar', 'ms'].contains(systemLocale.languageCode)) {
      return systemLocale;
    }
    return const Locale('en'); // Default fallback
  }

  Future<void> setLocale(Locale locale) async {
    // Persist to Hive
    await ref.read(settingsBoxProvider).put('language', locale.languageCode);

    // Update Firestore user record
    await ref.read(userRepositoryProvider).updateLanguage(locale.languageCode);

    // Update state (triggers full app rebuild via Consumer at root)
    state = locale;
  }
}

// === App Root (MaterialApp.router) ===

class LoloApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      locale: locale,
      supportedLocales: const [
        Locale('en'),        // English
        Locale('ar'),        // Arabic
        Locale('ms'),        // Bahasa Melayu
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,          // Generated from ARB files
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(appRouterProvider),
      theme: ref.watch(themeProvider),
      builder: (context, child) {
        // Wrap with Directionality based on locale
        final isRtl = locale.languageCode == 'ar';
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
```

**How It Works:**
1. User taps new language in Settings (or during onboarding)
2. `LocaleNotifier.setLocale()` updates Riverpod state
3. `MaterialApp.router` is a `Consumer` that watches `localeNotifierProvider`
4. Locale change triggers full widget tree rebuild
5. All `AppLocalizations.of(context).stringKey` calls resolve to new language
6. `Directionality` widget updates text direction (RTL for Arabic)
7. No app restart needed -- the rebuild is seamless and takes < 100ms

---

## Section 2: ARB File Structure

### 2.1 File Configuration

**l10n.yaml (project root):**

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
nullable-getter: false
synthetic-package: false
output-dir: lib/core/localization
```

**File naming:**
- `lib/l10n/app_en.arb` -- English (template/baseline)
- `lib/l10n/app_ar.arb` -- Arabic
- `lib/l10n/app_ms.arb` -- Bahasa Melayu

### 2.2 Key Naming Convention

Keys follow a strict naming pattern: `{module}_{screen}_{element}_{description}`

```
module:      auth, onboarding, profile, reminders, messages,
             cards, gifts, sos, gamification, memories, home,
             subscription, settings, common
screen:      login, home, generate, detail, create, etc.
element:     title, subtitle, button, label, hint, error,
             message, placeholder, tooltip, badge, dialog
description: brief snake_case descriptor
```

**Examples:**

```
auth_login_title                     -> "Welcome to LOLO"
auth_login_button_google             -> "Continue with Google"
onboarding_partner_label_name        -> "What's her name?"
messages_generate_button_regenerate   -> "Generate Another"
cards_home_badge_say                 -> "SAY"
sos_scenario_button_argument         -> "We're in an argument"
gamification_home_label_streak       -> "Day Streak"
common_button_cancel                 -> "Cancel"
common_error_network                 -> "No internet connection"
```

### 2.3 Complete ARB Examples

**app_en.arb (English -- Template):**

```json
{
  "@@locale": "en",
  "@@last_modified": "2026-02-14T00:00:00.000Z",

  "__COMMON": "=== COMMON / SHARED STRINGS ===",

  "common_button_cancel": "Cancel",
  "common_button_save": "Save",
  "common_button_done": "Done",
  "common_button_next": "Next",
  "common_button_back": "Back",
  "common_button_skip": "Skip",
  "common_button_retry": "Try Again",
  "common_button_copy": "Copy",
  "common_button_share": "Share",
  "common_button_delete": "Delete",
  "common_button_edit": "Edit",

  "common_label_loading": "Loading...",
  "common_label_offline": "You're offline. Showing cached data.",
  "common_label_lastUpdated": "Last updated {time}",
  "@common_label_lastUpdated": {
    "placeholders": {
      "time": { "type": "String", "example": "5 minutes ago" }
    }
  },

  "common_error_generic": "Something went wrong. Please try again.",
  "common_error_network": "No internet connection. Please check your network.",
  "common_error_timeout": "Request timed out. Please try again.",
  "common_error_unauthorized": "Session expired. Please sign in again.",

  "__AUTH": "=== AUTH MODULE ===",

  "auth_welcome_title": "Your Relationship Intelligence Companion",
  "auth_welcome_subtitle": "She won't know why you got so thoughtful.\nWe won't tell.",
  "auth_login_button_google": "Continue with Google",
  "auth_login_button_apple": "Continue with Apple",
  "auth_login_button_email": "Continue with Email",
  "auth_login_label_or": "or",
  "auth_login_label_privacy": "By continuing, you agree to our Privacy Policy",

  "__ONBOARDING": "=== ONBOARDING MODULE ===",

  "onboarding_name_title": "What should we call you?",
  "onboarding_name_hint": "Your name",
  "onboarding_partner_title": "Who is the special one?",
  "onboarding_partner_hint": "Her name",
  "onboarding_partner_label_zodiac": "Her zodiac sign (optional)",
  "onboarding_partner_label_zodiacUnknown": "I don't know her sign",
  "onboarding_partner_label_status": "Relationship status",
  "onboarding_anniversary_title": "When did your story begin?",
  "onboarding_anniversary_label_dating": "Dating anniversary",
  "onboarding_anniversary_label_wedding": "Wedding date (optional)",
  "onboarding_privacy_title": "Your privacy matters",
  "onboarding_privacy_label_notifications": "Enable smart reminders",
  "onboarding_privacy_label_biometric": "Lock with fingerprint or face",
  "onboarding_privacy_label_discreet": "Notifications will never show relationship content on your lock screen",
  "onboarding_firstCard_title": "Your first smart card for {partnerName}",
  "@onboarding_firstCard_title": {
    "placeholders": {
      "partnerName": { "type": "String", "example": "Jessica" }
    }
  },

  "__HOME": "=== HOME MODULE ===",

  "home_title": "Home",
  "home_label_todayCard": "Today's Card",
  "home_label_noCard": "No action card for today. Check back tomorrow!",
  "home_label_nextReminder": "Next Reminder",
  "home_label_noReminder": "No upcoming reminders",
  "home_button_messages": "Messages",
  "home_button_sos": "SOS",

  "__NAVIGATION": "=== BOTTOM NAVIGATION ===",

  "nav_home": "Home",
  "nav_messages": "Messages",
  "nav_gifts": "Gifts",
  "nav_memories": "Memories",
  "nav_profile": "Profile",

  "__MESSAGES": "=== AI MESSAGE GENERATOR ===",

  "messages_title": "Messages",
  "messages_generate_title": "Generate a message",
  "messages_generate_label_mode": "What kind of message?",
  "messages_generate_label_tone": "Tone",
  "messages_generate_label_length": "Length",
  "messages_generate_button_generate": "Generate Message",
  "messages_generate_button_regenerate": "Generate Another",
  "messages_generate_label_generating": "Crafting your message...",
  "messages_result_button_copy": "Copy to Clipboard",
  "messages_result_button_share": "Share via...",
  "messages_result_label_copied": "Copied!",
  "messages_feedback_label": "How was this message?",

  "messages_mode_goodMorning": "Good Morning",
  "messages_mode_appreciation": "Appreciation",
  "messages_mode_romance": "Romance",
  "messages_mode_apology": "Apology",
  "messages_mode_missingYou": "Missing You",
  "messages_mode_celebration": "Celebration",
  "messages_mode_comfort": "Comfort",
  "messages_mode_flirting": "Flirting",
  "messages_mode_deepConvo": "Deep Conversation",
  "messages_mode_justBecause": "Just Because",

  "messages_tone_formal": "Formal",
  "messages_tone_warm": "Warm",
  "messages_tone_casual": "Casual",
  "messages_tone_playful": "Playful",

  "messages_length_short": "Short",
  "messages_length_medium": "Medium",
  "messages_length_long": "Long",

  "messages_limit_free": "{remaining} of {total} free messages remaining this month",
  "@messages_limit_free": {
    "placeholders": {
      "remaining": { "type": "int", "example": "3" },
      "total": { "type": "int", "example": "5" }
    }
  },

  "messages_history_title": "Message History",
  "messages_history_empty": "No messages yet. Generate your first!",

  "__ACTION_CARDS": "=== SMART ACTION CARDS ===",

  "cards_title": "Action Cards",
  "cards_badge_say": "SAY",
  "cards_badge_do": "DO",
  "cards_badge_buy": "BUY",
  "cards_badge_go": "GO",
  "cards_button_complete": "I did it!",
  "cards_button_skip": "Skip",
  "cards_skip_reason_busy": "Too busy today",
  "cards_skip_reason_irrelevant": "Not relevant",
  "cards_skip_reason_expensive": "Too expensive",
  "cards_skip_reason_similar": "Already did something similar",
  "cards_completed_label": "Completed! +{xp} XP",
  "@cards_completed_label": {
    "placeholders": {
      "xp": { "type": "int", "example": "15" }
    }
  },
  "cards_history_title": "Card History",

  "__GIFTS": "=== GIFT ENGINE ===",

  "gifts_title": "Gifts",
  "gifts_recommend_title": "Gift Recommendations",
  "gifts_recommend_label_occasion": "What's the occasion?",
  "gifts_recommend_label_budget": "Budget range",
  "gifts_recommend_button_lowBudget": "Low Budget, High Impact",
  "gifts_recommend_button_generate": "Find Gifts",
  "gifts_recommend_label_generating": "Finding the perfect gifts...",
  "gifts_detail_label_priceRange": "Price range: {range}",
  "@gifts_detail_label_priceRange": {
    "placeholders": {
      "range": { "type": "String", "example": "$50-100" }
    }
  },
  "gifts_detail_label_whyThisGift": "Why this gift for {partnerName}",
  "@gifts_detail_label_whyThisGift": {
    "placeholders": {
      "partnerName": { "type": "String", "example": "Jessica" }
    }
  },
  "gifts_detail_button_buyNow": "Buy Now",
  "gifts_packages_title": "Gift Packages",
  "gifts_feedback_title": "Did she like it?",
  "gifts_feedback_loved": "She loved it!",
  "gifts_feedback_liked": "She liked it",
  "gifts_feedback_neutral": "Neutral",
  "gifts_feedback_disliked": "Not her style",

  "__SOS": "=== SOS MODE ===",

  "sos_title": "SOS Mode",
  "sos_subtitle": "What's happening?",
  "sos_scenario_argument": "We're in an argument",
  "sos_scenario_forgot": "I forgot something important",
  "sos_scenario_upset": "She's upset and I don't know why",
  "sos_scenario_apologize": "I need to apologize right now",
  "sos_scenario_wrongThing": "I said the wrong thing",
  "sos_coaching_label_sayThis": "Say this",
  "sos_coaching_label_dontSay": "Don't say this",
  "sos_coaching_label_bodyLanguage": "Body language",
  "sos_coaching_label_loading": "Getting you help...",
  "sos_followup_title": "How did it go?",
  "sos_followup_better": "It went better",
  "sos_followup_same": "About the same",
  "sos_followup_worse": "It got worse",
  "sos_offline_notice": "You're offline. Showing general tips.",

  "__GAMIFICATION": "=== GAMIFICATION ===",

  "gamification_streak_label": "{count}-day streak",
  "@gamification_streak_label": {
    "placeholders": {
      "count": { "type": "int", "example": "14" }
    }
  },
  "gamification_streak_broken": "Your streak ended. Start a new one today!",
  "gamification_xp_label": "{count} XP",
  "@gamification_xp_label": {
    "placeholders": {
      "count": { "type": "int", "example": "450" }
    }
  },
  "gamification_level_label": "Level {level}: {name}",
  "@gamification_level_label": {
    "placeholders": {
      "level": { "type": "int", "example": "5" },
      "name": { "type": "String", "example": "Strategist" }
    }
  },
  "gamification_score_label": "Relationship Consistency Score",
  "gamification_score_value": "{score}/100",
  "@gamification_score_value": {
    "placeholders": {
      "score": { "type": "int", "example": "78" }
    }
  },
  "gamification_percentile": "More thoughtful than {percent}% of LOLO users",
  "@gamification_percentile": {
    "placeholders": {
      "percent": { "type": "int", "example": "72" }
    }
  },
  "gamification_levelUp_title": "Level Up!",
  "gamification_levelUp_message": "You've reached Level {level}: {name}",
  "@gamification_levelUp_message": {
    "placeholders": {
      "level": { "type": "int", "example": "5" },
      "name": { "type": "String", "example": "Strategist" }
    }
  },

  "gamification_level_1": "Beginner",
  "gamification_level_2": "Learner",
  "gamification_level_3": "Attentive",
  "gamification_level_4": "Thoughtful",
  "gamification_level_5": "Strategist",
  "gamification_level_6": "Devoted",
  "gamification_level_7": "Champion",
  "gamification_level_8": "Legend",
  "gamification_level_9": "Master",
  "gamification_level_10": "Soulmate",

  "__REMINDERS": "=== REMINDERS ===",

  "reminders_title": "Reminders",
  "reminders_create_title": "New Reminder",
  "reminders_create_label_title": "What's the reminder for?",
  "reminders_create_label_date": "Date",
  "reminders_create_label_recurrence": "Repeat",
  "reminders_recurrence_none": "One-time",
  "reminders_recurrence_daily": "Daily",
  "reminders_recurrence_weekly": "Weekly",
  "reminders_recurrence_monthly": "Monthly",
  "reminders_recurrence_yearly": "Yearly",
  "reminders_type_birthday": "Birthday",
  "reminders_type_anniversary": "Anniversary",
  "reminders_type_islamic": "Islamic Holiday",
  "reminders_type_custom": "Custom",
  "reminders_tierDays": "{days} days away",
  "@reminders_tierDays": {
    "placeholders": {
      "days": { "type": "int", "example": "14" }
    }
  },
  "reminders_tierToday": "Today!",

  "reminders_promises_title": "Promise Tracker",
  "reminders_promises_create_title": "New Promise",
  "reminders_promises_status_open": "Open",
  "reminders_promises_status_inProgress": "In Progress",
  "reminders_promises_status_completed": "Completed",
  "reminders_promises_status_overdue": "Overdue",
  "reminders_promises_overdue_message": "This promise is overdue. {partnerName} may have noticed.",
  "@reminders_promises_overdue_message": {
    "placeholders": {
      "partnerName": { "type": "String", "example": "Jessica" }
    }
  },

  "__HER_PROFILE": "=== HER PROFILE ===",

  "profile_her_title": "Her Profile",
  "profile_her_label_name": "Name",
  "profile_her_label_zodiac": "Zodiac Sign",
  "profile_her_label_birthday": "Birthday",
  "profile_her_label_loveLanguage": "Love Language",
  "profile_her_label_commStyle": "Communication Style",
  "profile_her_label_status": "Relationship Status",
  "profile_her_label_completion": "{percent}% complete",
  "@profile_her_label_completion": {
    "placeholders": {
      "percent": { "type": "int", "example": "65" }
    }
  },
  "profile_her_label_zodiacDisclaimer": "Based on her zodiac sign. Adjust if needed.",
  "profile_her_section_preferences": "Her Preferences",
  "profile_her_section_cultural": "Cultural Context",
  "profile_her_section_family": "Family Members",

  "profile_her_loveLanguage_words": "Words of Affirmation",
  "profile_her_loveLanguage_acts": "Acts of Service",
  "profile_her_loveLanguage_gifts": "Receiving Gifts",
  "profile_her_loveLanguage_time": "Quality Time",
  "profile_her_loveLanguage_touch": "Physical Touch",

  "profile_her_commStyle_direct": "Direct",
  "profile_her_commStyle_indirect": "Indirect",
  "profile_her_commStyle_mixed": "Mixed",

  "profile_her_status_dating": "Dating",
  "profile_her_status_engaged": "Engaged",
  "profile_her_status_married": "Married",

  "__MEMORIES": "=== MEMORY VAULT ===",

  "memories_title": "Memory Vault",
  "memories_create_title": "New Memory",
  "memories_create_label_title": "Title",
  "memories_create_label_description": "What happened?",
  "memories_create_label_date": "When?",
  "memories_create_label_photo": "Add photo (optional)",
  "memories_create_label_tags": "Tags",
  "memories_tag_dateNight": "Date Night",
  "memories_tag_gift": "Gift",
  "memories_tag_conversation": "Conversation",
  "memories_tag_trip": "Trip",
  "memories_tag_milestone": "Milestone",
  "memories_empty": "No memories yet. Start logging your special moments.",

  "memories_wishlist_title": "Wish List",
  "memories_wishlist_subtitle": "Things she mentioned wanting",
  "memories_wishlist_add_title": "Add to Wish List",
  "memories_wishlist_add_hint": "She said she wants...",
  "memories_wishlist_label_price": "Approximate price (optional)",
  "memories_wishlist_label_priority_nice": "Nice to have",
  "memories_wishlist_label_priority_wants": "She really wants this",
  "memories_wishlist_empty": "No wish list items. Listen for hints!",

  "__SUBSCRIPTION": "=== SUBSCRIPTION / PAYWALL ===",

  "subscription_title": "Subscription",
  "subscription_tier_free": "Free",
  "subscription_tier_pro": "Pro",
  "subscription_tier_legend": "Legend",
  "subscription_paywall_title": "Unlock Full Power",
  "subscription_paywall_subtitle": "Become the partner she deserves",
  "subscription_paywall_button_trial": "Start 7-Day Free Trial",
  "subscription_paywall_button_subscribe": "Subscribe Now",
  "subscription_paywall_label_restore": "Restore Purchases",
  "subscription_paywall_feature_compare": "Compare Plans",
  "subscription_paywall_trigger_messages": "You've used all {count} free messages this month",
  "@subscription_paywall_trigger_messages": {
    "placeholders": {
      "count": { "type": "int", "example": "5" }
    }
  },

  "__SETTINGS": "=== SETTINGS ===",

  "settings_title": "Settings",
  "settings_section_general": "General",
  "settings_section_notifications": "Notifications",
  "settings_section_privacy": "Privacy",
  "settings_section_account": "Account",
  "settings_label_language": "Language",
  "settings_label_theme": "Theme",
  "settings_label_darkMode": "Dark Mode",
  "settings_label_lightMode": "Light Mode",
  "settings_label_notifications": "Push Notifications",
  "settings_label_quietHours": "Quiet Hours",
  "settings_label_biometric": "Biometric Lock",
  "settings_label_dataExport": "Export My Data",
  "settings_label_deleteAccount": "Delete Account",
  "settings_label_logout": "Sign Out",
  "settings_label_version": "Version {version}",
  "@settings_label_version": {
    "placeholders": {
      "version": { "type": "String", "example": "1.0.0" }
    }
  },

  "settings_delete_confirm": "This will permanently delete your account and all data. This cannot be undone.",
  "settings_delete_button": "Delete My Account"
}
```

**app_ar.arb (Arabic):**

```json
{
  "@@locale": "ar",
  "@@last_modified": "2026-02-14T00:00:00.000Z",

  "common_button_cancel": "إلغاء",
  "common_button_save": "حفظ",
  "common_button_done": "تم",
  "common_button_next": "التالي",
  "common_button_back": "رجوع",
  "common_button_skip": "تخطي",
  "common_button_retry": "حاول مرة أخرى",
  "common_button_copy": "نسخ",
  "common_button_share": "مشاركة",
  "common_button_delete": "حذف",
  "common_button_edit": "تعديل",

  "common_label_loading": "جاري التحميل...",
  "common_label_offline": "أنت غير متصل بالإنترنت. عرض البيانات المحفوظة.",
  "common_label_lastUpdated": "آخر تحديث {time}",

  "common_error_generic": "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
  "common_error_network": "لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.",
  "common_error_timeout": "انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.",
  "common_error_unauthorized": "انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.",

  "auth_welcome_title": "مساعدك الذكي للعلاقات",
  "auth_welcome_subtitle": "ما راح تعرف ليش صرت أكثر اهتمام.\nسرك عندنا.",
  "auth_login_button_google": "المتابعة مع جوجل",
  "auth_login_button_apple": "المتابعة مع آبل",
  "auth_login_button_email": "المتابعة بالبريد الإلكتروني",
  "auth_login_label_or": "أو",
  "auth_login_label_privacy": "بالمتابعة، أنت توافق على سياسة الخصوصية",

  "onboarding_name_title": "شو نسميك؟",
  "onboarding_name_hint": "اسمك",
  "onboarding_partner_title": "مين الشخص المميز؟",
  "onboarding_partner_hint": "اسمها",
  "onboarding_partner_label_zodiac": "برجها (اختياري)",
  "onboarding_partner_label_zodiacUnknown": "ما أعرف برجها",
  "onboarding_partner_label_status": "حالة العلاقة",
  "onboarding_anniversary_title": "متى بدت قصتكم؟",
  "onboarding_anniversary_label_dating": "ذكرى التعارف",
  "onboarding_anniversary_label_wedding": "تاريخ الزواج (اختياري)",
  "onboarding_privacy_title": "خصوصيتك تهمنا",
  "onboarding_privacy_label_notifications": "تفعيل التذكيرات الذكية",
  "onboarding_privacy_label_biometric": "قفل بالبصمة أو الوجه",
  "onboarding_privacy_label_discreet": "الإشعارات لن تعرض أي محتوى شخصي على شاشة القفل",
  "onboarding_firstCard_title": "أول بطاقة ذكية لـ {partnerName}",

  "home_title": "الرئيسية",
  "home_label_todayCard": "بطاقة اليوم",
  "home_label_noCard": "ما في بطاقة لليوم. ارجع بكرة!",
  "home_label_nextReminder": "التذكير القادم",
  "home_label_noReminder": "ما في تذكيرات قادمة",
  "home_button_messages": "الرسائل",
  "home_button_sos": "طوارئ",

  "nav_home": "الرئيسية",
  "nav_messages": "الرسائل",
  "nav_gifts": "الهدايا",
  "nav_memories": "الذكريات",
  "nav_profile": "الملف",

  "messages_title": "الرسائل",
  "messages_generate_title": "إنشاء رسالة",
  "messages_generate_label_mode": "شو نوع الرسالة؟",
  "messages_generate_label_tone": "الأسلوب",
  "messages_generate_label_length": "الطول",
  "messages_generate_button_generate": "إنشاء رسالة",
  "messages_generate_button_regenerate": "إنشاء رسالة ثانية",
  "messages_generate_label_generating": "نكتب لك رسالتك...",
  "messages_result_button_copy": "نسخ",
  "messages_result_button_share": "مشاركة عبر...",
  "messages_result_label_copied": "تم النسخ!",
  "messages_feedback_label": "كيف كانت الرسالة؟",

  "messages_mode_goodMorning": "صباح الخير",
  "messages_mode_appreciation": "تقدير",
  "messages_mode_romance": "رومانسية",
  "messages_mode_apology": "اعتذار",
  "messages_mode_missingYou": "اشتقت لك",
  "messages_mode_celebration": "تهنئة",
  "messages_mode_comfort": "دعم ومواساة",
  "messages_mode_flirting": "غزل",
  "messages_mode_deepConvo": "محادثة عميقة",
  "messages_mode_justBecause": "بدون سبب",

  "messages_tone_formal": "رسمي",
  "messages_tone_warm": "دافئ",
  "messages_tone_casual": "عفوي",
  "messages_tone_playful": "مرح",

  "messages_length_short": "قصير",
  "messages_length_medium": "متوسط",
  "messages_length_long": "طويل",

  "messages_limit_free": "متبقي {remaining} من {total} رسائل مجانية هذا الشهر",
  "messages_history_title": "سجل الرسائل",
  "messages_history_empty": "ما في رسائل بعد. أنشئ أول رسالة!",

  "cards_title": "البطاقات الذكية",
  "cards_badge_say": "قُل",
  "cards_badge_do": "افعل",
  "cards_badge_buy": "اشترِ",
  "cards_badge_go": "روح",
  "cards_button_complete": "سويتها!",
  "cards_button_skip": "تخطي",
  "cards_skip_reason_busy": "مشغول اليوم",
  "cards_skip_reason_irrelevant": "مو مناسبة",
  "cards_skip_reason_expensive": "غالية",
  "cards_skip_reason_similar": "سويت شي مشابه",
  "cards_completed_label": "أحسنت! +{xp} نقطة",
  "cards_history_title": "سجل البطاقات",

  "gifts_title": "الهدايا",
  "gifts_recommend_title": "اقتراحات هدايا",
  "gifts_recommend_label_occasion": "شو المناسبة؟",
  "gifts_recommend_label_budget": "الميزانية",
  "gifts_recommend_button_lowBudget": "ميزانية قليلة، تأثير كبير",
  "gifts_recommend_button_generate": "اقترح هدايا",
  "gifts_recommend_label_generating": "نبحث لك عن الهدية المثالية...",
  "gifts_detail_label_priceRange": "السعر: {range}",
  "gifts_detail_label_whyThisGift": "ليش هالهدية مناسبة لـ {partnerName}",
  "gifts_detail_button_buyNow": "اشتري الآن",
  "gifts_packages_title": "باقات الهدايا",
  "gifts_feedback_title": "عجبتها الهدية؟",
  "gifts_feedback_loved": "عجبتها مرة!",
  "gifts_feedback_liked": "عجبتها",
  "gifts_feedback_neutral": "عادي",
  "gifts_feedback_disliked": "ما كانت ذوقها",

  "sos_title": "وضع الطوارئ",
  "sos_subtitle": "شو الوضع؟",
  "sos_scenario_argument": "نتخانق",
  "sos_scenario_forgot": "نسيت شي مهم",
  "sos_scenario_upset": "زعلانة وما أدري ليش",
  "sos_scenario_apologize": "لازم أعتذر الحين",
  "sos_scenario_wrongThing": "قلت شي غلط",
  "sos_coaching_label_sayThis": "قول هالكلام",
  "sos_coaching_label_dontSay": "لا تقول هالكلام",
  "sos_coaching_label_bodyLanguage": "لغة الجسد",
  "sos_coaching_label_loading": "نجهز لك المساعدة...",
  "sos_followup_title": "كيف صار الوضع؟",
  "sos_followup_better": "تحسن",
  "sos_followup_same": "نفس الشي",
  "sos_followup_worse": "زاد",
  "sos_offline_notice": "أنت غير متصل. نعرض لك نصائح عامة.",

  "gamification_streak_label": "سلسلة {count} يوم",
  "gamification_streak_broken": "انتهت سلسلتك. ابدأ وحدة جديدة اليوم!",
  "gamification_xp_label": "{count} نقطة",
  "gamification_level_label": "المستوى {level}: {name}",
  "gamification_score_label": "مؤشر الاهتمام",
  "gamification_score_value": "{score}/١٠٠",
  "gamification_percentile": "أنت أكثر اهتماماً من {percent}% من مستخدمي لولو",
  "gamification_levelUp_title": "ارتقيت!",
  "gamification_levelUp_message": "وصلت للمستوى {level}: {name}",

  "gamification_level_1": "مبتدئ",
  "gamification_level_2": "متعلم",
  "gamification_level_3": "منتبه",
  "gamification_level_4": "مهتم",
  "gamification_level_5": "استراتيجي",
  "gamification_level_6": "مخلص",
  "gamification_level_7": "بطل",
  "gamification_level_8": "أسطوري",
  "gamification_level_9": "متمكن",
  "gamification_level_10": "توأم الروح",

  "reminders_title": "التذكيرات",
  "reminders_create_title": "تذكير جديد",
  "reminders_create_label_title": "التذكير لأي شي؟",
  "reminders_create_label_date": "التاريخ",
  "reminders_create_label_recurrence": "التكرار",
  "reminders_recurrence_none": "مرة واحدة",
  "reminders_recurrence_daily": "يومياً",
  "reminders_recurrence_weekly": "أسبوعياً",
  "reminders_recurrence_monthly": "شهرياً",
  "reminders_recurrence_yearly": "سنوياً",
  "reminders_type_birthday": "عيد ميلاد",
  "reminders_type_anniversary": "ذكرى",
  "reminders_type_islamic": "مناسبة إسلامية",
  "reminders_type_custom": "مخصص",
  "reminders_tierDays": "بعد {days} يوم",
  "reminders_tierToday": "اليوم!",

  "reminders_promises_title": "متابعة الوعود",
  "reminders_promises_create_title": "وعد جديد",
  "reminders_promises_status_open": "مفتوح",
  "reminders_promises_status_inProgress": "قيد التنفيذ",
  "reminders_promises_status_completed": "مكتمل",
  "reminders_promises_status_overdue": "متأخر",
  "reminders_promises_overdue_message": "هالوعد متأخر. {partnerName} ممكن لاحظت.",

  "profile_her_title": "ملفها",
  "profile_her_label_name": "الاسم",
  "profile_her_label_zodiac": "البرج",
  "profile_her_label_birthday": "تاريخ الميلاد",
  "profile_her_label_loveLanguage": "لغة الحب",
  "profile_her_label_commStyle": "أسلوب التواصل",
  "profile_her_label_status": "حالة العلاقة",
  "profile_her_label_completion": "مكتمل {percent}%",
  "profile_her_label_zodiacDisclaimer": "بناءً على برجها. عدّل لو تبي.",
  "profile_her_section_preferences": "تفضيلاتها",
  "profile_her_section_cultural": "السياق الثقافي",
  "profile_her_section_family": "أفراد العائلة",

  "profile_her_loveLanguage_words": "كلمات التقدير",
  "profile_her_loveLanguage_acts": "أفعال الخدمة",
  "profile_her_loveLanguage_gifts": "استقبال الهدايا",
  "profile_her_loveLanguage_time": "وقت نوعي",
  "profile_her_loveLanguage_touch": "اللمس الجسدي",

  "profile_her_commStyle_direct": "مباشر",
  "profile_her_commStyle_indirect": "غير مباشر",
  "profile_her_commStyle_mixed": "مختلط",

  "profile_her_status_dating": "مواعدة",
  "profile_her_status_engaged": "خطوبة",
  "profile_her_status_married": "زواج",

  "memories_title": "خزنة الذكريات",
  "memories_create_title": "ذكرى جديدة",
  "memories_create_label_title": "العنوان",
  "memories_create_label_description": "شو صار؟",
  "memories_create_label_date": "متى؟",
  "memories_create_label_photo": "أضف صورة (اختياري)",
  "memories_create_label_tags": "التصنيفات",
  "memories_tag_dateNight": "سهرة",
  "memories_tag_gift": "هدية",
  "memories_tag_conversation": "محادثة",
  "memories_tag_trip": "سفر",
  "memories_tag_milestone": "إنجاز",
  "memories_empty": "ما في ذكريات بعد. ابدأ بتسجيل لحظاتكم المميزة.",

  "memories_wishlist_title": "قائمة الأمنيات",
  "memories_wishlist_subtitle": "أشياء ذكرت إنها تبيها",
  "memories_wishlist_add_title": "أضف للقائمة",
  "memories_wishlist_add_hint": "قالت إنها تبي...",
  "memories_wishlist_label_price": "السعر التقريبي (اختياري)",
  "memories_wishlist_label_priority_nice": "شي حلو",
  "memories_wishlist_label_priority_wants": "تبيه مرة",
  "memories_wishlist_empty": "ما في أمنيات. خلك منتبه لتلميحاتها!",

  "subscription_title": "الاشتراك",
  "subscription_tier_free": "مجاني",
  "subscription_tier_pro": "برو",
  "subscription_tier_legend": "أسطوري",
  "subscription_paywall_title": "اطلق قدراتك الكاملة",
  "subscription_paywall_subtitle": "كن الشريك اللي تستاهله",
  "subscription_paywall_button_trial": "ابدأ التجربة المجانية ٧ أيام",
  "subscription_paywall_button_subscribe": "اشترك الآن",
  "subscription_paywall_label_restore": "استعادة المشتريات",
  "subscription_paywall_feature_compare": "قارن الباقات",
  "subscription_paywall_trigger_messages": "استخدمت كل {count} رسائلك المجانية هذا الشهر",

  "settings_title": "الإعدادات",
  "settings_section_general": "عام",
  "settings_section_notifications": "الإشعارات",
  "settings_section_privacy": "الخصوصية",
  "settings_section_account": "الحساب",
  "settings_label_language": "اللغة",
  "settings_label_theme": "المظهر",
  "settings_label_darkMode": "الوضع الداكن",
  "settings_label_lightMode": "الوضع الفاتح",
  "settings_label_notifications": "الإشعارات",
  "settings_label_quietHours": "ساعات الهدوء",
  "settings_label_biometric": "القفل البيومتري",
  "settings_label_dataExport": "تصدير بياناتي",
  "settings_label_deleteAccount": "حذف الحساب",
  "settings_label_logout": "تسجيل الخروج",
  "settings_label_version": "الإصدار {version}",

  "settings_delete_confirm": "سيتم حذف حسابك وجميع بياناتك نهائياً. لا يمكن التراجع عن هذا.",
  "settings_delete_button": "حذف حسابي"
}
```

**app_ms.arb (Bahasa Melayu):**

```json
{
  "@@locale": "ms",
  "@@last_modified": "2026-02-14T00:00:00.000Z",

  "common_button_cancel": "Batal",
  "common_button_save": "Simpan",
  "common_button_done": "Selesai",
  "common_button_next": "Seterusnya",
  "common_button_back": "Kembali",
  "common_button_skip": "Langkau",
  "common_button_retry": "Cuba Lagi",
  "common_button_copy": "Salin",
  "common_button_share": "Kongsi",
  "common_button_delete": "Padam",
  "common_button_edit": "Edit",

  "common_label_loading": "Memuatkan...",
  "common_label_offline": "Anda tiada internet. Memaparkan data tersimpan.",
  "common_label_lastUpdated": "Kemas kini terakhir {time}",

  "common_error_generic": "Sesuatu tidak kena. Sila cuba lagi.",
  "common_error_network": "Tiada sambungan internet. Sila semak rangkaian anda.",
  "common_error_timeout": "Permintaan tamat masa. Sila cuba lagi.",
  "common_error_unauthorized": "Sesi tamat. Sila log masuk semula.",

  "auth_welcome_title": "Pembantu Pintar untuk Hubungan Anda",
  "auth_welcome_subtitle": "Dia tak akan tahu kenapa anda jadi lebih prihatin.\nRahsia anda selamat.",
  "auth_login_button_google": "Teruskan dengan Google",
  "auth_login_button_apple": "Teruskan dengan Apple",
  "auth_login_button_email": "Teruskan dengan E-mel",
  "auth_login_label_or": "atau",
  "auth_login_label_privacy": "Dengan meneruskan, anda bersetuju dengan Dasar Privasi",

  "onboarding_name_title": "Apa nama anda?",
  "onboarding_name_hint": "Nama anda",
  "onboarding_partner_title": "Siapa yang istimewa?",
  "onboarding_partner_hint": "Nama dia",
  "onboarding_partner_label_zodiac": "Zodiak dia (pilihan)",
  "onboarding_partner_label_zodiacUnknown": "Saya tak tahu zodiak dia",
  "onboarding_partner_label_status": "Status hubungan",
  "onboarding_anniversary_title": "Bila kisah anda bermula?",
  "onboarding_anniversary_label_dating": "Tarikh mula berpacaran",
  "onboarding_anniversary_label_wedding": "Tarikh perkahwinan (pilihan)",
  "onboarding_privacy_title": "Privasi anda penting",
  "onboarding_privacy_label_notifications": "Aktifkan peringatan pintar",
  "onboarding_privacy_label_biometric": "Kunci dengan cap jari atau wajah",
  "onboarding_privacy_label_discreet": "Notifikasi tidak akan paparkan kandungan peribadi di skrin kunci",
  "onboarding_firstCard_title": "Kad pintar pertama untuk {partnerName}",

  "home_title": "Utama",
  "home_label_todayCard": "Kad Hari Ini",
  "home_label_noCard": "Tiada kad untuk hari ini. Semak esok!",
  "home_label_nextReminder": "Peringatan Seterusnya",
  "home_label_noReminder": "Tiada peringatan akan datang",
  "home_button_messages": "Mesej",
  "home_button_sos": "SOS",

  "nav_home": "Utama",
  "nav_messages": "Mesej",
  "nav_gifts": "Hadiah",
  "nav_memories": "Kenangan",
  "nav_profile": "Profil",

  "messages_title": "Mesej",
  "messages_generate_title": "Hasilkan mesej",
  "messages_generate_label_mode": "Jenis mesej apa?",
  "messages_generate_label_tone": "Nada",
  "messages_generate_label_length": "Panjang",
  "messages_generate_button_generate": "Hasilkan Mesej",
  "messages_generate_button_regenerate": "Hasilkan Lagi",
  "messages_generate_label_generating": "Menulis mesej anda...",
  "messages_result_button_copy": "Salin",
  "messages_result_button_share": "Kongsi melalui...",
  "messages_result_label_copied": "Disalin!",
  "messages_feedback_label": "Macam mana mesej ni?",

  "messages_mode_goodMorning": "Selamat Pagi",
  "messages_mode_appreciation": "Penghargaan",
  "messages_mode_romance": "Romantik",
  "messages_mode_apology": "Minta Maaf",
  "messages_mode_missingYou": "Rindu",
  "messages_mode_celebration": "Perayaan",
  "messages_mode_comfort": "Sokongan",
  "messages_mode_flirting": "Goda",
  "messages_mode_deepConvo": "Perbualan Mendalam",
  "messages_mode_justBecause": "Tanpa Sebab",

  "messages_tone_formal": "Formal",
  "messages_tone_warm": "Mesra",
  "messages_tone_casual": "Santai",
  "messages_tone_playful": "Bermain",

  "messages_length_short": "Pendek",
  "messages_length_medium": "Sederhana",
  "messages_length_long": "Panjang",

  "messages_limit_free": "{remaining} daripada {total} mesej percuma tinggal bulan ini",
  "messages_history_title": "Sejarah Mesej",
  "messages_history_empty": "Tiada mesej lagi. Hasilkan yang pertama!",

  "cards_title": "Kad Pintar",
  "cards_badge_say": "CAKAP",
  "cards_badge_do": "BUAT",
  "cards_badge_buy": "BELI",
  "cards_badge_go": "PERGI",
  "cards_button_complete": "Dah buat!",
  "cards_button_skip": "Langkau",
  "cards_skip_reason_busy": "Sibuk hari ini",
  "cards_skip_reason_irrelevant": "Tak berkaitan",
  "cards_skip_reason_expensive": "Terlalu mahal",
  "cards_skip_reason_similar": "Dah buat benda serupa",
  "cards_completed_label": "Tahniah! +{xp} XP",
  "cards_history_title": "Sejarah Kad",

  "gifts_title": "Hadiah",
  "gifts_recommend_title": "Cadangan Hadiah",
  "gifts_recommend_label_occasion": "Apa majlis?",
  "gifts_recommend_label_budget": "Bajet",
  "gifts_recommend_button_lowBudget": "Bajet Rendah, Impak Tinggi",
  "gifts_recommend_button_generate": "Cari Hadiah",
  "gifts_recommend_label_generating": "Mencari hadiah terbaik...",
  "gifts_detail_label_priceRange": "Harga: {range}",
  "gifts_detail_label_whyThisGift": "Kenapa hadiah ni sesuai untuk {partnerName}",
  "gifts_detail_button_buyNow": "Beli Sekarang",
  "gifts_packages_title": "Pakej Hadiah",
  "gifts_feedback_title": "Dia suka tak?",
  "gifts_feedback_loved": "Dia suka sangat!",
  "gifts_feedback_liked": "Dia suka",
  "gifts_feedback_neutral": "Biasa saja",
  "gifts_feedback_disliked": "Bukan citarasa dia",

  "sos_title": "Mod SOS",
  "sos_subtitle": "Apa yang berlaku?",
  "sos_scenario_argument": "Kami bergaduh",
  "sos_scenario_forgot": "Saya terlupa sesuatu penting",
  "sos_scenario_upset": "Dia marah dan saya tak tahu kenapa",
  "sos_scenario_apologize": "Saya perlu minta maaf sekarang",
  "sos_scenario_wrongThing": "Saya cakap benda salah",
  "sos_coaching_label_sayThis": "Cakap ni",
  "sos_coaching_label_dontSay": "Jangan cakap ni",
  "sos_coaching_label_bodyLanguage": "Bahasa badan",
  "sos_coaching_label_loading": "Sedang dapatkan bantuan...",
  "sos_followup_title": "Macam mana jadinya?",
  "sos_followup_better": "Lebih baik",
  "sos_followup_same": "Sama saja",
  "sos_followup_worse": "Lebih teruk",
  "sos_offline_notice": "Anda tiada internet. Memaparkan tip umum.",

  "gamification_streak_label": "Rentak {count} hari",
  "gamification_streak_broken": "Rentak anda terputus. Mulakan semula hari ini!",
  "gamification_xp_label": "{count} XP",
  "gamification_level_label": "Tahap {level}: {name}",
  "gamification_score_label": "Skor Keprihatinan Hubungan",
  "gamification_score_value": "{score}/100",
  "gamification_percentile": "Lebih prihatin daripada {percent}% pengguna LOLO",
  "gamification_levelUp_title": "Naik Tahap!",
  "gamification_levelUp_message": "Anda mencapai Tahap {level}: {name}",

  "gamification_level_1": "Pemula",
  "gamification_level_2": "Pelajar",
  "gamification_level_3": "Perhatian",
  "gamification_level_4": "Bertimbang Rasa",
  "gamification_level_5": "Strategis",
  "gamification_level_6": "Setia",
  "gamification_level_7": "Juara",
  "gamification_level_8": "Legenda",
  "gamification_level_9": "Mahir",
  "gamification_level_10": "Jiwa Kekasih",

  "reminders_title": "Peringatan",
  "reminders_create_title": "Peringatan Baru",
  "reminders_create_label_title": "Untuk apa peringatan ini?",
  "reminders_create_label_date": "Tarikh",
  "reminders_create_label_recurrence": "Ulang",
  "reminders_recurrence_none": "Sekali sahaja",
  "reminders_recurrence_daily": "Setiap hari",
  "reminders_recurrence_weekly": "Setiap minggu",
  "reminders_recurrence_monthly": "Setiap bulan",
  "reminders_recurrence_yearly": "Setiap tahun",
  "reminders_type_birthday": "Hari Lahir",
  "reminders_type_anniversary": "Ulang Tahun",
  "reminders_type_islamic": "Hari Kelepasan Islam",
  "reminders_type_custom": "Khas",
  "reminders_tierDays": "{days} hari lagi",
  "reminders_tierToday": "Hari ini!",

  "reminders_promises_title": "Penjejak Janji",
  "reminders_promises_create_title": "Janji Baru",
  "reminders_promises_status_open": "Terbuka",
  "reminders_promises_status_inProgress": "Dalam Proses",
  "reminders_promises_status_completed": "Selesai",
  "reminders_promises_status_overdue": "Terlewat",
  "reminders_promises_overdue_message": "Janji ini terlewat. {partnerName} mungkin dah perasan.",

  "profile_her_title": "Profil Dia",
  "profile_her_label_name": "Nama",
  "profile_her_label_zodiac": "Zodiak",
  "profile_her_label_birthday": "Hari Lahir",
  "profile_her_label_loveLanguage": "Bahasa Cinta",
  "profile_her_label_commStyle": "Gaya Komunikasi",
  "profile_her_label_status": "Status Hubungan",
  "profile_her_label_completion": "{percent}% lengkap",
  "profile_her_label_zodiacDisclaimer": "Berdasarkan zodiak dia. Ubah jika perlu.",
  "profile_her_section_preferences": "Kesukaan Dia",
  "profile_her_section_cultural": "Konteks Budaya",
  "profile_her_section_family": "Ahli Keluarga",

  "profile_her_loveLanguage_words": "Kata-kata Pujian",
  "profile_her_loveLanguage_acts": "Perbuatan Khidmat",
  "profile_her_loveLanguage_gifts": "Menerima Hadiah",
  "profile_her_loveLanguage_time": "Masa Berkualiti",
  "profile_her_loveLanguage_touch": "Sentuhan Fizikal",

  "profile_her_commStyle_direct": "Langsung",
  "profile_her_commStyle_indirect": "Tidak langsung",
  "profile_her_commStyle_mixed": "Campuran",

  "profile_her_status_dating": "Berpacaran",
  "profile_her_status_engaged": "Bertunang",
  "profile_her_status_married": "Berkahwin",

  "memories_title": "Peti Kenangan",
  "memories_create_title": "Kenangan Baru",
  "memories_create_label_title": "Tajuk",
  "memories_create_label_description": "Apa yang berlaku?",
  "memories_create_label_date": "Bila?",
  "memories_create_label_photo": "Tambah gambar (pilihan)",
  "memories_create_label_tags": "Tag",
  "memories_tag_dateNight": "Malam Date",
  "memories_tag_gift": "Hadiah",
  "memories_tag_conversation": "Perbualan",
  "memories_tag_trip": "Percutian",
  "memories_tag_milestone": "Pencapaian",
  "memories_empty": "Tiada kenangan lagi. Mula rekodkan detik istimewa anda.",

  "memories_wishlist_title": "Senarai Hajat",
  "memories_wishlist_subtitle": "Benda yang dia sebut nak",
  "memories_wishlist_add_title": "Tambah ke Senarai Hajat",
  "memories_wishlist_add_hint": "Dia cakap dia nak...",
  "memories_wishlist_label_price": "Anggaran harga (pilihan)",
  "memories_wishlist_label_priority_nice": "Bagus kalau ada",
  "memories_wishlist_label_priority_wants": "Dia betul-betul nak",
  "memories_wishlist_empty": "Tiada item. Dengar baik-baik bila dia bagi hint!",

  "subscription_title": "Langganan",
  "subscription_tier_free": "Percuma",
  "subscription_tier_pro": "Pro",
  "subscription_tier_legend": "Legenda",
  "subscription_paywall_title": "Buka Kuasa Penuh",
  "subscription_paywall_subtitle": "Jadi pasangan yang dia layak dapat",
  "subscription_paywall_button_trial": "Mula Percubaan Percuma 7 Hari",
  "subscription_paywall_button_subscribe": "Langgan Sekarang",
  "subscription_paywall_label_restore": "Pulihkan Pembelian",
  "subscription_paywall_feature_compare": "Bandingkan Pelan",
  "subscription_paywall_trigger_messages": "Anda telah guna semua {count} mesej percuma bulan ini",

  "settings_title": "Tetapan",
  "settings_section_general": "Am",
  "settings_section_notifications": "Notifikasi",
  "settings_section_privacy": "Privasi",
  "settings_section_account": "Akaun",
  "settings_label_language": "Bahasa",
  "settings_label_theme": "Tema",
  "settings_label_darkMode": "Mod Gelap",
  "settings_label_lightMode": "Mod Cerah",
  "settings_label_notifications": "Notifikasi Tolak",
  "settings_label_quietHours": "Waktu Senyap",
  "settings_label_biometric": "Kunci Biometrik",
  "settings_label_dataExport": "Eksport Data Saya",
  "settings_label_deleteAccount": "Padam Akaun",
  "settings_label_logout": "Log Keluar",
  "settings_label_version": "Versi {version}",

  "settings_delete_confirm": "Ini akan memadamkan akaun dan semua data anda secara kekal. Tindakan ini tidak boleh diundur.",
  "settings_delete_button": "Padam Akaun Saya"
}
```

### 2.4 Plural and Gender Handling

**Plural Examples (Arabic requires 6 plural forms):**

```json
// app_en.arb
"reminders_count": "{count, plural, =0{No reminders} =1{1 reminder} other{{count} reminders}}",
"@reminders_count": {
  "placeholders": {
    "count": { "type": "int" }
  }
}

// app_ar.arb (Arabic has: zero, one, two, few, many, other)
"reminders_count": "{count, plural, =0{لا توجد تذكيرات} =1{تذكير واحد} =2{تذكيران} few{{count} تذكيرات} many{{count} تذكيراً} other{{count} تذكير}}",

// app_ms.arb (Malay has no grammatical plural, uses classifier)
"reminders_count": "{count, plural, =0{Tiada peringatan} other{{count} peringatan}}"
```

**Gender is not required for LOLO's current strings** because:
- The user is always male (product design)
- The partner is always female (product design)
- Arabic strings are written directly in the appropriate grammatical gender

### 2.5 Number Formatting Per Locale

```dart
// Number formatting utility
class LocaleAwareFormatters {
  static String formatNumber(int number, Locale locale) {
    final formatter = NumberFormat.decimalPattern(locale.languageCode);
    return formatter.format(number);
    // en: 1,234    ar: ١٬٢٣٤    ms: 1,234
  }

  static String formatCurrency(double amount, Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return NumberFormat.currency(
          locale: 'ar_AE',
          symbol: 'د.إ',          // AED
          decimalDigits: 2,
        ).format(amount);
      case 'ms':
        return NumberFormat.currency(
          locale: 'ms_MY',
          symbol: 'RM',
          decimalDigits: 2,
        ).format(amount);
      default:
        return NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 2,
        ).format(amount);
    }
  }

  static String formatPercentage(int value, Locale locale) {
    if (locale.languageCode == 'ar') {
      // Arabic: ٧٨٪
      return '${_toArabicNumerals(value)}٪';
    }
    return '$value%';
  }
}
```

### 2.6 Date Formatting Per Locale

```dart
class LocaleAwareDateFormatters {
  // Standard Gregorian date
  static String formatDate(DateTime date, Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        // Arabic: ١٤ فبراير ٢٠٢٦
        return DateFormat('d MMMM yyyy', 'ar').format(date);
      case 'ms':
        // Malay: 14 Februari 2026
        return DateFormat('d MMMM yyyy', 'ms').format(date);
      default:
        // English: February 14, 2026
        return DateFormat('MMMM d, yyyy', 'en').format(date);
    }
  }

  // Hijri date (for Arabic and Malay Islamic features)
  static String formatHijriDate(DateTime gregorianDate, Locale locale) {
    final hijri = HijriCalendar.fromDate(gregorianDate);
    final monthNames = {
      'ar': ['محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني',
             'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
             'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'],
      'ms': ['Muharam', 'Safar', 'Rabiulawal', 'Rabiulakhir',
             'Jamadilawal', 'Jamadilakhir', 'Rejab', 'Syaaban',
             'Ramadan', 'Syawal', 'Zulkaedah', 'Zulhijjah'],
      'en': ['Muharram', 'Safar', 'Rabi al-Awwal', 'Rabi al-Thani',
             'Jumada al-Ula', 'Jumada al-Thani', 'Rajab', 'Shaban',
             'Ramadan', 'Shawwal', 'Dhul Qadah', 'Dhul Hijjah'],
    };

    final months = monthNames[locale.languageCode] ?? monthNames['en']!;
    final monthName = months[hijri.hMonth - 1];

    if (locale.languageCode == 'ar') {
      return '${_toArabicNumerals(hijri.hDay)} $monthName ${_toArabicNumerals(hijri.hYear)} هـ';
    }
    return '${hijri.hDay} $monthName ${hijri.hYear} H';
  }

  // Dual date display (Gregorian + Hijri) for Arabic/Malay users
  static String formatDualDate(DateTime date, Locale locale) {
    final gregorian = formatDate(date, locale);
    if (locale.languageCode == 'ar' || locale.languageCode == 'ms') {
      final hijri = formatHijriDate(date, locale);
      return '$gregorian\n$hijri';
    }
    return gregorian;
  }

  // Relative time ("5 minutes ago", "3 days ago")
  static String formatRelativeTime(DateTime date, Locale locale) {
    final now = DateTime.now();
    final diff = now.difference(date);

    // Uses intl package's relative time formatting
    // Arabic: "قبل ٥ دقائق"
    // Malay: "5 minit yang lalu"
    // English: "5 minutes ago"
    return timeago.format(date, locale: locale.languageCode);
  }
}
```

---

## Section 3: RTL Implementation

### 3.1 Directionality Widget Placement

The root `Directionality` widget is placed in `MaterialApp.builder` to ensure the entire widget tree respects the current locale's text direction:

```dart
MaterialApp.router(
  // ...
  builder: (context, child) {
    final locale = Localizations.localeOf(context);
    final isRtl = locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: child!,
    );
  },
);
```

**Per-widget overrides** are used only when a specific widget must ignore the ambient direction (e.g., phone number input fields that are always LTR, even in Arabic):

```dart
Directionality(
  textDirection: TextDirection.ltr, // Phone numbers are always LTR
  child: TextField(
    keyboardType: TextInputType.phone,
  ),
)
```

### 3.2 EdgeInsetsDirectional Usage Patterns

**Rule: NEVER use `EdgeInsets`. ALWAYS use `EdgeInsetsDirectional`.**

This is enforced via a custom lint rule in `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint
  rules:
    avoid_edge_insets: true  # Custom lint: error on EdgeInsets usage
```

**Pattern:**

```dart
// WRONG - does not respect RTL
Padding(padding: EdgeInsets.only(left: 16, right: 8))

// CORRECT - automatically mirrors in RTL
Padding(padding: EdgeInsetsDirectional.only(start: 16, end: 8))

// WRONG
Container(margin: EdgeInsets.fromLTRB(16, 0, 8, 0))

// CORRECT
Container(margin: EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0))

// Symmetric padding (no change needed, same in both directions)
Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)) // OK
```

**Common Patterns:**

| Use Case | Code |
|----------|------|
| Start padding only | `EdgeInsetsDirectional.only(start: 16)` |
| End padding only | `EdgeInsetsDirectional.only(end: 16)` |
| Start + End (different) | `EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0)` |
| Uniform horizontal | `EdgeInsets.symmetric(horizontal: 16)` (OK, symmetric) |
| All sides equal | `EdgeInsets.all(16)` (OK, symmetric) |

### 3.3 Mirrored Icons and Navigation

**Icons that must mirror in RTL:**

| Icon | LTR Direction | RTL Direction |
|------|--------------|---------------|
| Back arrow | Points left (<-) | Points right (->) |
| Forward arrow | Points right (->) | Points left (<-) |
| List bullet indent | Indented right | Indented left |
| Send icon | Points right | Points left |
| Chevron (list item) | Points right (>) | Points left (<) |
| Text align | Left aligned | Right aligned |

**Implementation:**

```dart
// Use Directionality-aware icon helper
class DirectionalIcon extends StatelessWidget {
  final IconData ltrIcon;
  final IconData rtlIcon;

  const DirectionalIcon({
    required this.ltrIcon,
    required this.rtlIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Icon(isRtl ? rtlIcon : ltrIcon);
  }
}

// Usage
DirectionalIcon(
  ltrIcon: Icons.arrow_back,
  rtlIcon: Icons.arrow_forward,
)

// For icons that just need flipping (not different icons):
Transform(
  alignment: Alignment.center,
  transform: Directionality.of(context) == TextDirection.rtl
    ? Matrix4.rotationY(pi)  // Mirror horizontally
    : Matrix4.identity(),
  child: Icon(Icons.send),
)
```

**Bottom Navigation Tab Order:**

```dart
// Tabs mirror order in RTL
BottomNavigationBar(
  items: _getTabItems(context),
)

List<BottomNavigationBarItem> _getTabItems(BuildContext context) {
  final items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: l10n.nav_home),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: l10n.nav_messages),
    BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: l10n.nav_gifts),
    BottomNavigationBarItem(icon: Icon(Icons.lock), label: l10n.nav_memories),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: l10n.nav_profile),
  ];

  // Flutter's BottomNavigationBar automatically handles RTL tab order
  // when wrapped in a Directionality widget. No manual reversal needed.
  return items;
}
```

### 3.4 Bidirectional Text Handling

LOLO handles mixed-direction text (common when Arabic users include English words or brand names):

```dart
// Wrap text that may contain mixed directions
Text(
  'Ahmed يحب LOLO',    // Mixed Arabic + English
  textDirection: TextDirection.rtl, // Base direction is RTL
  // Unicode Bidi algorithm handles embedded LTR text automatically
)

// For user input fields that may contain mixed text:
TextField(
  textDirection: _detectTextDirection(controller.text),
  textAlign: _detectTextAlign(controller.text),
)

TextDirection _detectTextDirection(String text) {
  if (text.isEmpty) {
    // Use ambient direction
    return Directionality.of(context);
  }
  // Check first strong character
  final firstChar = text.runes.first;
  if (_isArabicChar(firstChar)) return TextDirection.rtl;
  return TextDirection.ltr;
}
```

### 3.5 TextDirection Management

**Global Strategy:**
```
Locale changes -> Riverpod state updates -> MaterialApp.builder
  -> Directionality widget at root -> all children inherit direction
```

**Per-widget scenarios requiring explicit TextDirection:**

| Scenario | TextDirection | Reason |
|----------|-------------|--------|
| Phone number input | Always LTR | Phone numbers are always LTR formatted |
| Email input | Always LTR | Email addresses are LTR |
| URL display | Always LTR | URLs are LTR |
| Numeric-only input | Context-dependent | Arabic numerals can be RTL |
| AI-generated content | Matches content language | If Arabic user generates English message, content is LTR |
| Mixed language text | Base direction = locale | Bidi algorithm handles embedding |

### 3.6 Testing RTL Layouts

**Automated RTL Testing Strategy:**

```dart
// Widget test helper that runs tests in both LTR and RTL
void testWidgetBothDirections(
  String description,
  WidgetTesterCallback callback,
) {
  testWidgets('$description (LTR)', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: /* widget under test */,
      ),
    );
    await callback(tester);
  });

  testWidgets('$description (RTL)', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.rtl,
        child: /* widget under test */,
      ),
    );
    await callback(tester);
  });
}
```

**RTL Testing Checklist (per screen):**

| Check | How to Verify | Pass Criteria |
|-------|--------------|---------------|
| Text alignment | Visual inspection + golden test | All text aligns to start (right in RTL) |
| Padding/margin | Golden test comparison LTR vs RTL | Mirrored correctly |
| Icon direction | Visual inspection | Directional icons point correct way |
| Navigation | Tap back button in RTL | Navigates correctly, button on right side |
| Input cursor | Type in Arabic TextField | Cursor starts on right, moves left |
| Scroll direction | Swipe horizontal list in RTL | Scrolls right-to-left |
| Overflow | Resize text to max length | No overflow in either direction |
| Tab order | Focus traversal in RTL | Moves right-to-left |
| Animations | Card slide, page transitions | Slide direction matches RTL |

---

## Section 4: Arabic Typography

### 4.1 Font Selection and Fallback Chain

**Primary Arabic Font: Noto Naskh Arabic**
- Style: Traditional Arabic script (Naskh style)
- Weights: Regular (400), Bold (700)
- Use case: Body text, message content, card descriptions
- Why: Excellent readability, complete Arabic character coverage, widely tested

**Secondary Arabic Font: Cairo**
- Style: Modern geometric Arabic
- Weights: Regular (400), SemiBold (600), Bold (700)
- Use case: Headings, titles, navigation labels, buttons
- Why: Clean, modern feel that matches LOLO's premium aesthetic

**Tertiary Arabic Font: Tajawal**
- Style: Contemporary Arabic, slightly condensed
- Weights: Regular (400), Medium (500), Bold (700)
- Use case: Fallback for Cairo, UI labels where space is constrained
- Why: Compact without sacrificing readability, good for buttons and badges

**Fallback Chain:**

```dart
// Arabic text theme configuration
TextTheme _arabicTextTheme() {
  return TextTheme(
    // Headings: Cairo (modern, bold)
    displayLarge: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
    headlineLarge: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500),

    // Body: Noto Naskh Arabic (traditional, readable)
    bodyLarge: TextStyle(fontFamily: 'NotoNaskhArabic', fontWeight: FontWeight.w400, height: 1.8),
    bodyMedium: TextStyle(fontFamily: 'NotoNaskhArabic', fontWeight: FontWeight.w400, height: 1.7),
    bodySmall: TextStyle(fontFamily: 'NotoNaskhArabic', fontWeight: FontWeight.w400, height: 1.6),

    // Labels/Buttons: Tajawal (compact, modern)
    labelLarge: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w400),
  );
}

// Fallback chain in pubspec.yaml fontFamilyFallback
// fontFamilyFallback: ['Cairo', 'Tajawal', 'NotoNaskhArabic', 'NotoSansArabic']
```

### 4.2 Font Loading Strategy

**Strategy: Bundled fonts (not Google Fonts API)**

Fonts are bundled in the APK/IPA rather than loaded from Google Fonts at runtime.

**Reasons:**
- Offline access: Arabic fonts must be available without internet (critical for offline mode)
- Consistent rendering: No flash of unstyled text on first load
- Privacy: No Google Fonts API call that could leak locale information
- Performance: No network latency for font loading

**pubspec.yaml configuration:**

```yaml
flutter:
  fonts:
    - family: NotoNaskhArabic
      fonts:
        - asset: assets/fonts/noto_naskh_arabic/NotoNaskhArabic-Regular.ttf
          weight: 400
        - asset: assets/fonts/noto_naskh_arabic/NotoNaskhArabic-Bold.ttf
          weight: 700

    - family: Cairo
      fonts:
        - asset: assets/fonts/cairo/Cairo-Regular.ttf
          weight: 400
        - asset: assets/fonts/cairo/Cairo-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/cairo/Cairo-Bold.ttf
          weight: 700

    - family: Tajawal
      fonts:
        - asset: assets/fonts/tajawal/Tajawal-Regular.ttf
          weight: 400
        - asset: assets/fonts/tajawal/Tajawal-Medium.ttf
          weight: 500
        - asset: assets/fonts/tajawal/Tajawal-Bold.ttf
          weight: 700
```

### 4.3 Arabic-Indic Numeral Support

Arabic users in GCC markets expect Arabic-Indic numerals (also called Eastern Arabic numerals) in certain contexts:

| Western | Arabic-Indic | Context |
|---------|-------------|---------|
| 0 | ٠ | Gamification scores, dates |
| 1 | ١ | Streak counts, XP |
| 2 | ٢ | Reminder days |
| 3 | ٣ | etc. |
| 4 | ٤ | |
| 5 | ٥ | |
| 6 | ٦ | |
| 7 | ٧ | |
| 8 | ٨ | |
| 9 | ٩ | |

**Implementation:**

```dart
String toArabicNumerals(dynamic number) {
  const westernToArabic = {
    '0': '٠', '1': '١', '2': '٢', '3': '٣', '4': '٤',
    '5': '٥', '6': '٦', '7': '٧', '8': '٨', '9': '٩',
  };
  return number.toString().split('').map((c) =>
    westernToArabic[c] ?? c
  ).join();
}

// Usage in locale-aware widget
Text(
  locale.languageCode == 'ar'
    ? toArabicNumerals(score)
    : score.toString(),
)

// For date/number formatting, intl package handles this automatically:
NumberFormat.decimalPattern('ar').format(1234); // Output: ١٬٢٣٤
```

**Where to use Arabic-Indic numerals:**
- Gamification scores and XP
- Streak day counts
- Reminder countdown days
- Hijri calendar dates
- In-app formatted numbers

**Where to keep Western numerals (even in Arabic):**
- Phone numbers
- Prices (AED amounts -- convention varies, but Western numerals are standard for currency in GCC apps)
- Subscription pricing on paywall
- Version numbers

### 4.4 Impact on APK Size

| Font | File Size (all weights) | Characters |
|------|------------------------|------------|
| Noto Naskh Arabic (Regular + Bold) | ~280 KB | Full Arabic + Arabic supplements |
| Cairo (Regular + SemiBold + Bold) | ~190 KB | Arabic + Latin |
| Tajawal (Regular + Medium + Bold) | ~170 KB | Arabic + Latin |
| **Total Arabic fonts** | **~640 KB** | |

**Impact analysis:**
- Base Flutter APK (release, no fonts): ~15 MB
- Adding Arabic fonts: +640 KB (+4.3%)
- Total with Latin fonts + Arabic fonts: ~1.2 MB
- Remaining APK budget for code, assets, animations: ~33 MB
- Conclusion: Arabic fonts are well within the 50 MB APK target

**Optimization strategies (if APK size becomes a concern):**
1. Subset fonts to remove unused glyphs (e.g., remove Latin glyphs from Noto Naskh Arabic since Cairo/Tajawal cover Latin)
2. Use `fonttools` to subset: `pyftsubset NotoNaskhArabic-Regular.ttf --text-file=arabic_chars.txt`
3. Consider dropping one Arabic font (Tajawal) and using Cairo for both headings and labels
4. These optimizations can reduce Arabic font overhead to ~350 KB

---

## Section 5: AI Content Localization

### 5.1 Language Parameter in All AI Requests

Every AI request includes a mandatory `language` field and optional `dialect` and `culturalContext` fields:

```json
{
  "language": "ar",
  "dialect": "gulf",
  "culturalContext": {
    "background": "gulf_arab",
    "religiousObservance": "high",
    "isRamadan": false,
    "familyInvolvement": "high",
    "communicationStyle": "indirect"
  }
}
```

**Language Parameter Rules:**
1. Default: matches app UI language
2. Override: user can request a different language per message (e.g., Arabic user generates one English message)
3. The `language` parameter is the PRIMARY instruction to the AI model -- it determines which language the response is generated in
4. The `dialect` parameter refines the output within a language (Gulf Arabic vs. Levantine vs. Egyptian)
5. The `culturalContext` adjusts tone, references, and appropriateness

### 5.2 Cultural Context Parameter

The cultural context parameter is built from the user's Her Profile settings and injected into every AI request:

```dart
class CulturalContextBuilder {
  static Map<String, dynamic> build({
    required String language,
    required CulturalContextEntity? culturalContext,
    required PartnerProfileEntity partnerProfile,
  }) {
    return {
      'language': language,
      'dialect': _resolveDialect(language, culturalContext),
      'culturalBackground': culturalContext?.background ?? 'general',
      'religiousObservance': culturalContext?.religiousObservance ?? 'secular',
      'isRamadan': _isCurrentlyRamadan(),
      'familyInvolvement': _inferFamilyInvolvement(culturalContext),
      'communicationNorms': _getCommunicationNorms(language, culturalContext),
      'giftCultureIntensity': _getGiftCultureIntensity(culturalContext),
      'avoidTopics': _getAvoidTopics(culturalContext),
      'honorifics': _getHonorifics(language, culturalContext),
    };
  }

  static String _resolveDialect(String language, CulturalContextEntity? ctx) {
    if (language != 'ar') return 'standard';
    switch (ctx?.background) {
      case 'gulf_arab': return 'gulf';
      case 'levantine': return 'levantine';
      case 'egyptian': return 'egyptian';
      case 'north_african': return 'maghrebi';
      default: return 'gulf'; // Default Arabic dialect for LOLO
    }
  }

  static Map<String, dynamic> _getCommunicationNorms(
    String language, CulturalContextEntity? ctx
  ) {
    switch (language) {
      case 'ar':
        return {
          'directness': 'formal_respectful',
          'familyReferences': 'frequent',      // Reference family members
          'religiousExpressions': 'natural',   // InshaAllah, MashAllah, etc.
          'humorStyle': 'warm_clever',          // Not sarcastic
          'genderAddress': 'gendered',          // Masculine/feminine grammar
        };
      case 'ms':
        return {
          'directness': 'indirect_gentle',
          'familyReferences': 'moderate',
          'religiousExpressions': 'natural',   // InsyaAllah, Alhamdulillah
          'humorStyle': 'gentle_subtle',
          'genderAddress': 'neutral',           // Malay has no grammatical gender
          'honorifics': ['Abang', 'Sayang'],   // Common Malay endearments
        };
      default:
        return {
          'directness': 'direct_conversational',
          'familyReferences': 'minimal',
          'religiousExpressions': 'none',
          'humorStyle': 'varies',
          'genderAddress': 'neutral',
        };
    }
  }
}
```

### 5.3 Per-Language Prompt Templates

Each AI request type has locale-specific system prompts that establish the cultural and linguistic parameters:

**Message Generation System Prompts:**

```
=== ENGLISH SYSTEM PROMPT ===
You are a relationship message assistant helping a man communicate
with his partner. Generate a natural, conversational message in
American English. The message should sound like something he would
genuinely say -- not robotic, not overly poetic. Match the requested
tone (formal/warm/casual/playful) and length (short/medium/long).
Use the partner's name naturally. Reference specific details from
the context provided.

=== ARABIC (GULF) SYSTEM PROMPT ===
أنت مساعد لكتابة رسائل العلاقات. اكتب رسالة باللهجة الخليجية
(الإمارات/السعودية). يجب أن تكون الرسالة طبيعية وتشبه طريقة كلام
الشباب الخليجي -- مو رسمية زيادة ولا عامية مبالغ فيها. استخدم
التعابير الخليجية المناسبة. إذا كان السياق إسلامي، استخدم عبارات
دينية بشكل طبيعي (إن شاء الله، ما شاء الله) بدون مبالغة. احترم
العلاقة العائلية والثقافية. خاطب المؤنث بصيغة المؤنث الصحيحة.

=== BAHASA MELAYU SYSTEM PROMPT ===
Anda adalah pembantu menulis mesej hubungan. Tulis mesej dalam Bahasa
Melayu Malaysia yang natural dan santai -- seperti cara lelaki Melayu
berkomunikasi dengan pasangan. Gunakan panggilan mesra Malaysia yang
sesuai (Sayang, Abang). Sertakan ungkapan Islam secara natural jika
sesuai (InsyaAllah, Alhamdulillah). Elakkan bahasa yang terlalu
formal atau kaku. Mesej harus berbunyi seperti teks WhatsApp yang
ikhlas, bukan seperti puisi atau surat rasmi.
```

**SOS Mode System Prompts (adapted per culture):**

```
=== ENGLISH SOS PROMPT ===
You are an emergency relationship coach. The user is in a real-time
crisis with his partner. Provide 3-5 specific, actionable steps.
Include "SAY THIS" and "DON'T SAY THIS" sections. Be direct and
practical. No generic advice -- every step must be specific to the
scenario and partner context.

=== ARABIC SOS PROMPT ===
أنت مدرب طوارئ للعلاقات. المستخدم في موقف صعب مع شريكته الآن.
قدم ٣-٥ خطوات محددة وعملية. احترم الثقافة الخليجية: لا تقترح
أي شيء يتعارض مع القيم الإسلامية أو العادات العائلية. تذكر
أن العلاقة العائلية مهمة -- لا تقترح "تجاهل رأي العائلة".
استخدم أسلوب مباشر لكن محترم.

=== MALAY SOS PROMPT ===
Anda adalah jurulatih kecemasan hubungan. Pengguna dalam situasi
sukar dengan pasangan sekarang. Berikan 3-5 langkah yang spesifik.
Fahami budaya Melayu: komunikasi tidak langsung, konsep "malu",
dan hubungan dengan ibu mertua. Jangan cadangkan konfrontasi
langsung -- cadangkan pendekatan lembut dan hormat. Gunakan Bahasa
Melayu Malaysia yang natural.
```

### 5.4 Language Verification of AI Responses

Every AI response passes through a language verification step before being returned to the client:

```python
# Cloud Function: verify_response_language

def verify_language(response_text: str, expected_language: str) -> dict:
    """
    Verifies the AI response is in the expected language.
    Returns: { 'valid': bool, 'detected_language': str, 'confidence': float }
    """

    # Strategy 1: Character script detection (fast, reliable for Arabic)
    arabic_chars = sum(1 for c in response_text if '\u0600' <= c <= '\u06FF')
    latin_chars = sum(1 for c in response_text if 'a' <= c.lower() <= 'z')
    total_alpha = arabic_chars + latin_chars

    if total_alpha == 0:
        return {'valid': False, 'detected_language': 'unknown', 'confidence': 0}

    arabic_ratio = arabic_chars / total_alpha

    if expected_language == 'ar':
        # Arabic response should have >60% Arabic script
        # (allows for embedded English words/names)
        return {
            'valid': arabic_ratio > 0.6,
            'detected_language': 'ar' if arabic_ratio > 0.6 else 'en',
            'confidence': arabic_ratio,
        }

    if expected_language == 'ms':
        # Malay uses Latin script -- verify it's not Arabic
        # Additional check: presence of common Malay words
        malay_markers = ['yang', 'dan', 'untuk', 'dengan', 'ini', 'itu',
                        'saya', 'anda', 'dia', 'kita', 'kami']
        has_malay_markers = any(m in response_text.lower() for m in malay_markers)
        return {
            'valid': arabic_ratio < 0.1 and has_malay_markers,
            'detected_language': 'ms' if has_malay_markers else 'en',
            'confidence': 0.9 if has_malay_markers else 0.5,
        }

    if expected_language == 'en':
        return {
            'valid': arabic_ratio < 0.1,
            'detected_language': 'en',
            'confidence': 1 - arabic_ratio,
        }

    return {'valid': False, 'detected_language': 'unknown', 'confidence': 0}


# If verification fails:
# 1. Log the failure (model, language, request context)
# 2. Retry with stronger language instruction in the prompt
# 3. If retry also fails: return error to client with localized message
```

### 5.5 Language-Specific Cache Keys

All AI response caches include the language and dialect as part of the cache key to prevent cross-language cache collisions:

```
# Cache key structure:
# cache:{type}:{language}:{dialect}:{other_params}:{context_hash}

# Examples:
cache:msg:en:standard:good_morning:warm:medium:a1b2c3d4
cache:msg:ar:gulf:apology:warm:medium:e5f6g7h8
cache:msg:ms:standard:appreciation:casual:short:i9j0k1l2

cache:gift:en:standard:birthday:50-100:m3n4o5p6
cache:gift:ar:gulf:eid:200-500:q7r8s9t0
cache:gift:ms:standard:birthday:30-80:u1v2w3x4

cache:sos:en:standard:argument:direct
cache:sos:ar:gulf:argument:formal_respectful
cache:sos:ms:standard:argument:indirect_gentle

cache:card:en:standard:{userId}:2026-02-14
cache:card:ar:gulf:{userId}:2026-02-14
cache:card:ms:standard:{userId}:2026-02-14
```

**Cache Isolation Rules:**
- English, Arabic, and Malay caches are completely separate
- Gulf Arabic and Levantine Arabic caches are separate
- Changing app language clears the relevant pre-fetched content
- Language-specific cache TTLs may differ (Arabic SOS tips cached longer due to higher generation cost)

---

## Section 6: Implementation Checklist

### 6.1 Sprint-by-Sprint Localization Tasks

#### Sprint 1 (Weeks 9-10) -- Foundation

| # | Task | Owner | Effort | Priority |
|---|------|-------|--------|----------|
| L1-01 | Configure `l10n.yaml` and `flutter gen-l10n` pipeline | Tech Lead | 0.5d | P0 |
| L1-02 | Create `app_en.arb` baseline with all Sprint 1 strings (~120 keys) | Frontend 1 | 1d | P0 |
| L1-03 | Translate `app_ar.arb` Sprint 1 strings (Gulf Arabic, not MSA) | Arabic Advisor | 2d | P0 |
| L1-04 | Translate `app_ms.arb` Sprint 1 strings (Malaysian BM, colloquial) | Malay Advisor | 1.5d | P0 |
| L1-05 | Bundle Arabic fonts (Noto Naskh, Cairo, Tajawal) in `pubspec.yaml` | Frontend 2 | 0.5d | P0 |
| L1-06 | Implement `LocaleNotifier` Riverpod provider with runtime switching | Frontend 2 | 1d | P0 |
| L1-07 | Add `Directionality` widget in `MaterialApp.builder` for RTL | Frontend 2 | 0.5d | P0 |
| L1-08 | Create Arabic `TextTheme` with font fallback chain | Frontend 2 | 0.5d | P0 |
| L1-09 | Build Language Picker widget (onboarding + settings) | Frontend 1 | 0.5d | P0 |
| L1-10 | Implement `EdgeInsetsDirectional` lint rule | Tech Lead | 0.25d | P0 |
| L1-11 | RTL layout pass on Welcome, Login, and Onboarding screens | Frontend 1 + 2 | 1d | P0 |
| L1-12 | RTL layout pass on Home Dashboard and Bottom Navigation | Frontend 1 + 2 | 1d | P0 |
| L1-13 | Arabic golden tests for Sprint 1 screens (6 screens) | QA | 1d | P1 |
| L1-14 | Set up locale-aware date/number formatters in `core/localization/` | Frontend 2 | 0.5d | P0 |
| L1-15 | Test language switching without restart (all 3 languages) | QA | 0.5d | P0 |

**Sprint 1 Localization Effort:** ~12 engineering-days + 3.5 advisor-days

---

#### Sprint 2 (Weeks 11-12) -- Core Features

| # | Task | Owner | Effort | Priority |
|---|------|-------|--------|----------|
| L2-01 | Add Sprint 2 ARB strings to all 3 files (~150 new keys) | Frontend 1 + Advisors | 2d | P0 |
| L2-02 | Implement Hijri calendar utility (`hijri_calendar.dart`) | Backend 2 | 1d | P0 |
| L2-03 | Add dual date display (Gregorian + Hijri) for AR/MS users | Frontend 2 | 0.5d | P0 |
| L2-04 | Arabic-Indic numeral formatter integration | Frontend 2 | 0.5d | P0 |
| L2-05 | RTL layout pass on Her Profile screens (4 screens) | Frontend 2 | 1d | P0 |
| L2-06 | RTL layout pass on Reminders screens (3 screens) | Frontend 1 | 0.75d | P0 |
| L2-07 | RTL layout pass on AI Messages mode selection and generation screens | Frontend 1 | 1d | P0 |
| L2-08 | RTL layout pass on Gamification widgets (streak, XP, level) | Frontend 1 | 0.5d | P0 |
| L2-09 | Cultural context dropdown options localized (Arabic/Malay cultural backgrounds) | Frontend 2 | 0.5d | P0 |
| L2-10 | Zodiac sign names localized (12 signs x 3 languages) | Advisors | 0.5d | P0 |
| L2-11 | AI Message Generator: implement language parameter in API request | Backend 2 | 0.5d | P0 |
| L2-12 | AI Message Generator: create Gulf Arabic system prompt template | AI Engineer | 1d | P0 |
| L2-13 | AI Message Generator: create Malaysian BM system prompt template | AI Engineer | 1d | P0 |
| L2-14 | AI Message Generator: test 20 sample messages per mode x 3 languages | AI Engineer + Advisors | 2d | P0 |
| L2-15 | Arabic golden tests for Sprint 2 screens (7 screens) | QA | 1d | P1 |
| L2-16 | Plural form testing (Arabic 6-form plurals for reminder counts, XP) | QA | 0.5d | P1 |
| L2-17 | Islamic holiday data: populate Firestore with 2026-2027 Hijri dates | Backend 1 | 0.5d | P0 |
| L2-18 | Notification templates localized (reminder notifications in 3 languages) | Frontend 1 | 0.5d | P0 |

**Sprint 2 Localization Effort:** ~15 engineering-days + 4 advisor-days

---

#### Sprint 3 (Weeks 13-14) -- AI Engine & Smart Actions

| # | Task | Owner | Effort | Priority |
|---|------|-------|--------|----------|
| L3-01 | Add Sprint 3 ARB strings (~100 new keys) | Frontend 1 + Advisors | 1.5d | P0 |
| L3-02 | 7 Pro/Legend message modes: Arabic prompt tuning | AI Engineer + Arabic Advisor | 2d | P0 |
| L3-03 | 7 Pro/Legend message modes: Malay prompt tuning | AI Engineer + Malay Advisor | 2d | P0 |
| L3-04 | Trilingual message quality benchmark: 20 samples x 10 modes x 3 langs = 600 messages | AI Engineer + Advisors | 3d | P0 |
| L3-05 | Native speaker review of all Arabic AI messages (Gulf dialect accuracy) | Arabic Cultural Advisor | 2d | P0 |
| L3-06 | Native speaker review of all Malay AI messages (Malaysian BM naturalness) | Malay Cultural Advisor | 2d | P0 |
| L3-07 | Language verification function for AI responses | Backend 2 | 0.5d | P0 |
| L3-08 | RTL layout pass on Action Card screens (SAY/DO/BUY/GO) | Frontend 1 | 1d | P0 |
| L3-09 | RTL layout pass on Gift Engine screens (4 screens) | Frontend 2 | 1d | P0 |
| L3-10 | RTL layout pass on Memory Vault and Wish List screens | Frontend 2 | 0.5d | P0 |
| L3-11 | Action card content: cultural calibration for Arabic (appropriate actions) | AI Engineer + Arabic Advisor | 1d | P0 |
| L3-12 | Action card content: cultural calibration for Malay (budget-aware, pregnancy-aware) | AI Engineer + Malay Advisor | 1d | P0 |
| L3-13 | Gift Engine: Arabic gift norms (halal, culturally appropriate, no alcohol) | AI Engineer + Arabic Advisor | 1d | P0 |
| L3-14 | Gift Engine: Malay gift norms (budget-conscious, local options) | AI Engineer + Malay Advisor | 0.5d | P0 |
| L3-15 | Gift Engine: currency formatting per locale (USD, AED, MYR) | Frontend 2 | 0.5d | P0 |
| L3-16 | Language-specific cache key implementation in Redis | Backend 1 | 0.5d | P0 |
| L3-17 | Arabic golden tests for Sprint 3 screens (8 screens) | QA | 1d | P1 |
| L3-18 | End-to-end localization test: full user flow in Arabic | QA + Arabic Advisor | 1d | P0 |
| L3-19 | End-to-end localization test: full user flow in Malay | QA + Malay Advisor | 1d | P0 |

**Sprint 3 Localization Effort:** ~21 engineering-days + 8 advisor-days

---

#### Sprint 4 (Weeks 15-16) -- SOS Mode, Polish & Launch

| # | Task | Owner | Effort | Priority |
|---|------|-------|--------|----------|
| L4-01 | Add Sprint 4 ARB strings (~60 new keys) | Frontend 1 + Advisors | 1d | P0 |
| L4-02 | SOS Mode: Arabic crisis coaching prompt engineering | AI Engineer + Arabic Advisor | 1.5d | P0 |
| L4-03 | SOS Mode: Malay crisis coaching prompt engineering | AI Engineer + Malay Advisor | 1.5d | P0 |
| L4-04 | SOS Mode: cultural calibration (Arabic: family hierarchy; Malay: indirect communication) | AI Engineer + Advisors | 1d | P0 |
| L4-05 | SOS offline tips: pre-cache in all 3 languages | Backend 1 | 0.5d | P0 |
| L4-06 | RTL layout pass on SOS Mode screens (4 screens) | Frontend 1 | 1d | P0 |
| L4-07 | RTL layout pass on Paywall/Subscription screens (regional pricing display) | Frontend 2 | 0.5d | P0 |
| L4-08 | Ramadan mode: Arabic content tone adjustment testing | AI Engineer + Arabic Advisor | 1d | P1 |
| L4-09 | Pregnancy mode: Malay content calibration | AI Engineer + Malay Advisor | 0.5d | P1 |
| L4-10 | Full localization regression test: all screens x 3 languages | QA | 2d | P0 |
| L4-11 | String overflow audit: verify no text truncation in any language | QA | 1d | P0 |
| L4-12 | Arabic font rendering audit: verify diacritics, ligatures, kashida | QA + Arabic Advisor | 0.5d | P0 |
| L4-13 | Final golden test suite: all critical screens x 3 languages | QA | 1d | P0 |
| L4-14 | App Store listing localization: English, Arabic, Malay descriptions | PM + Advisors | 1d | P0 |
| L4-15 | Privacy Policy localization: Arabic and Malay versions | Legal + Advisors | 1d | P0 |

**Sprint 4 Localization Effort:** ~15 engineering-days + 5 advisor-days

---

### 6.2 Testing Matrix (Feature x Language x Direction)

#### Matrix Legend
- **F** = Full test (unit + widget + golden + integration)
- **W** = Widget test + golden test
- **G** = Golden test only
- **M** = Manual testing only (native speaker review)
- **--** = Not applicable

#### Sprint 1 Testing Matrix

| Feature / Screen | EN (LTR) | AR (RTL) | MS (LTR) |
|-----------------|-----------|----------|----------|
| Welcome Screen | F | F | W |
| Login Screen | F | F | W |
| Onboarding - Name | F | F | W |
| Onboarding - Partner | F | F | W |
| Onboarding - Anniversary | F | F | W |
| Onboarding - Privacy | F | F | W |
| Onboarding - First Card | F | F | W |
| Home Dashboard | F | F | W |
| Bottom Navigation | F | F | W |
| Language Picker | F | F | F |
| Language Runtime Switch | F | F | F |
| Notifications (content) | W | M | M |

#### Sprint 2 Testing Matrix

| Feature / Screen | EN (LTR) | AR (RTL) | MS (LTR) |
|-----------------|-----------|----------|----------|
| Her Profile - Main | F | F | W |
| Her Profile - Zodiac | F | F | W |
| Her Profile - Preferences | F | W | W |
| Her Profile - Cultural | F | F | F |
| Reminders - List | F | F | W |
| Reminders - Create | F | F | W |
| Reminders - Islamic Holidays | W | F | F |
| Hijri Date Display | W | F | F |
| AI Message - Mode Selection | F | F | W |
| AI Message - Generate | F | F | W |
| AI Message - Result | F | F | W |
| AI Message Content Quality | M | M | M |
| Gamification - Streak Widget | F | F | W |
| Gamification - XP Widget | F | F | W |
| Gamification - Level Badge | F | F | W |
| Arabic Numerals Display | -- | F | -- |
| Settings Screen | F | F | W |
| Biometric Lock Flow | F | F | F |

#### Sprint 3 Testing Matrix

| Feature / Screen | EN (LTR) | AR (RTL) | MS (LTR) |
|-----------------|-----------|----------|----------|
| Action Card - SAY | F | F | W |
| Action Card - DO | F | F | W |
| Action Card - BUY | F | F | W |
| Action Card - GO | F | F | W |
| AI Messages - All 10 Modes | F | F | F |
| AI Message - Tone/Length | F | F | W |
| AI Message Content (Arabic) | -- | M (20 samples x 10 modes) | -- |
| AI Message Content (Malay) | -- | -- | M (20 samples x 10 modes) |
| Gift Engine - Recommendations | F | F | W |
| Gift Engine - Budget Filter | F | F | W |
| Gift Engine - Currency Format | F | F | F |
| Gift Cultural Appropriateness | -- | M | M |
| Memory Vault - List | F | F | W |
| Memory Vault - Create | F | F | W |
| Wish List | F | F | W |
| Promise Tracker | F | F | W |
| Consistency Score | F | F | W |
| Calendar Sync | F | F | F |

#### Sprint 4 Testing Matrix

| Feature / Screen | EN (LTR) | AR (RTL) | MS (LTR) |
|-----------------|-----------|----------|----------|
| SOS Mode - Entry | F | F | F |
| SOS Mode - Scenarios | F | F | F |
| SOS Mode - Coaching | F | F | F |
| SOS Mode - Follow-up | F | F | W |
| SOS Content (Arabic) | -- | M (5 scenarios x 3 tips) | -- |
| SOS Content (Malay) | -- | -- | M (5 scenarios x 3 tips) |
| SOS Offline Tips | F | F | F |
| Gift Packages | F | F | W |
| Paywall - Regional Pricing | F | F | F |
| Family Profiles | F | W | W |
| Weekly Summary | F | W | W |
| Ramadan Mode Content | -- | M | M |
| Pregnancy Mode Content | M | -- | M |
| Data Export | F | W | W |
| Full App Flow (E2E) | F | F | F |
| Regression (all screens) | G | G | G |

#### Summary: Testing Effort Per Sprint

| Sprint | EN Tests | AR Tests | MS Tests | Native Speaker Reviews | Total Effort |
|--------|----------|----------|----------|----------------------|-------------|
| Sprint 1 | 12 F | 12 F | 10 W, 2 M | 0.5 days | 3 QA-days |
| Sprint 2 | 16 F | 16 F, 2 M | 14 W, 2 M | 2 days (message quality) | 5 QA-days |
| Sprint 3 | 18 F | 18 F, 3 M | 16 W, 3 M | 5 days (message + gift + action card quality) | 8 QA-days |
| Sprint 4 | 14 F | 14 F, 3 M | 12 W, 3 M | 3 days (SOS + Ramadan + regression) | 6 QA-days |
| **Total** | **60 F** | **60 F, 8 M** | **52 W, 8 M** | **10.5 advisor-days** | **22 QA-days** |

### 6.3 Localization Quality Gates

Before any sprint can be marked as "localization complete," all of the following gates must pass:

**Gate 1: String Completeness**
- All ARB keys in `app_en.arb` have corresponding entries in `app_ar.arb` and `app_ms.arb`
- CI check: `flutter gen-l10n` succeeds with zero warnings
- No `@@TODO` or placeholder strings in any ARB file

**Gate 2: RTL Visual Audit**
- Every screen in Arabic mode has a golden test that passes
- Arabic golden tests are reviewed by the Arabic advisor for visual correctness
- No `EdgeInsets` usage (only `EdgeInsetsDirectional`) -- enforced by lint

**Gate 3: AI Content Quality**
- Arabic AI messages: minimum 20 samples per mode, rated >= 4.0/5.0 by native speaker
- Malay AI messages: minimum 20 samples per mode, rated >= 4.0/5.0 by native speaker
- Language verification passes for 100% of AI responses in testing

**Gate 4: Cultural Appropriateness**
- Arabic advisor signs off on: gift suggestions, action cards, SOS coaching, Ramadan content
- Malay advisor signs off on: gift suggestions, action cards, SOS coaching, pregnancy content
- No culturally inappropriate content in any AI output (verified via adversarial testing)

**Gate 5: Functional Correctness**
- Language switching works without restart (all 3 languages)
- Hijri dates are accurate for 2026-2027
- Islamic holidays are correctly dated
- Currency formatting is correct per locale (USD, AED, MYR)
- Notification content is in the correct language

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | February 14, 2026 | Omar Al-Rashidi, Tech Lead | Initial localization architecture document |

---

*Omar Al-Rashidi, Tech Lead & Senior Flutter Developer*
*LOLO -- "She won't know why you got so thoughtful. We won't tell."*

---

### References

- LOLO Architecture Document (Omar Al-Rashidi, February 2026)
- LOLO Feature Backlog MoSCoW (Sarah Chen, February 2026)
- LOLO User Personas & Journey Maps (Sarah Chen, February 2026)
- Flutter Internationalization Guide (flutter.dev/docs/accessibility-and-localization/internationalization)
- ARB File Format Specification (github.com/nicklockwood/ARBFileFormat)
- Riverpod 2.x Documentation (riverpod.dev)
- ICU MessageFormat Specification (unicode-org.github.io/icu/userguide/format_parse/messages)
- Hijri Calendar Algorithm (hijricalendar.com)
- Arabic Typography Best Practices (fonts.google.com/knowledge/using_type/arabic)
- Noto Naskh Arabic (fonts.google.com/noto/specimen/Noto+Naskh+Arabic)
- Cairo Font (fonts.google.com/specimen/Cairo)
- Tajawal Font (fonts.google.com/specimen/Tajawal)
