import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'LOLO';

  @override
  String get common_button_continue => 'Continue';

  @override
  String get common_button_back => 'Back';

  @override
  String get common_button_skip => 'Skip';

  @override
  String get common_button_save => 'Save';

  @override
  String get common_button_cancel => 'Cancel';

  @override
  String get common_button_delete => 'Delete';

  @override
  String get common_button_done => 'Done';

  @override
  String get common_button_retry => 'Retry';

  @override
  String get common_button_close => 'Close';

  @override
  String get common_button_confirm => 'Confirm';

  @override
  String get common_button_edit => 'Edit';

  @override
  String get common_button_copy => 'Copy';

  @override
  String get common_button_share => 'Share';

  @override
  String get common_label_loading => 'Loading...';

  @override
  String get common_label_offline => 'You\'re offline. Showing cached data.';

  @override
  String common_label_lastUpdated(String time) {
    return 'Last updated $time';
  }

  @override
  String get error_generic => 'Something went wrong. Please try again.';

  @override
  String get error_network => 'No internet connection. Check your network.';

  @override
  String get error_timeout => 'Request timed out. Please try again.';

  @override
  String get error_server => 'Server error. We\'re working on it.';

  @override
  String get error_unauthorized => 'Session expired. Please log in again.';

  @override
  String get error_rate_limited => 'Too many requests. Please wait a moment.';

  @override
  String get error_tier_exceeded => 'Upgrade your plan to unlock this feature.';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_reminders => 'Reminders';

  @override
  String get nav_messages => 'Messages';

  @override
  String get nav_gifts => 'Gifts';

  @override
  String get nav_more => 'More';

  @override
  String get empty_reminders_title => 'No reminders yet';

  @override
  String get empty_reminders_subtitle => 'Add important dates so you never forget';

  @override
  String get empty_messages_title => 'No messages yet';

  @override
  String get empty_messages_subtitle => 'Generate your first AI message';

  @override
  String get empty_memories_title => 'No memories yet';

  @override
  String get empty_memories_subtitle => 'Start saving moments that matter';

  @override
  String get onboarding_language_title => 'Choose Your Language';

  @override
  String get onboarding_language_english => 'English';

  @override
  String get onboarding_language_arabic => 'العربية';

  @override
  String get onboarding_language_malay => 'Bahasa Melayu';

  @override
  String get onboarding_welcome_tagline => 'She won\'t know why you got so thoughtful.\nWe won\'t tell.';

  @override
  String get onboarding_welcome_benefit1_title => 'Smart Reminders';

  @override
  String get onboarding_welcome_benefit1_subtitle => 'Never forget what matters to her';

  @override
  String get onboarding_welcome_benefit2_title => 'AI Messages';

  @override
  String get onboarding_welcome_benefit2_subtitle => 'Say the right thing, every time';

  @override
  String get onboarding_welcome_benefit3_title => 'SOS Mode';

  @override
  String get onboarding_welcome_benefit3_subtitle => 'Emergency help when she\'s upset';

  @override
  String get onboarding_welcome_button_start => 'Get Started';

  @override
  String get onboarding_welcome_link_login => 'Already have an account? Log in';

  @override
  String get onboarding_signup_title => 'Sign Up';

  @override
  String get onboarding_signup_heading => 'Create your account';

  @override
  String get onboarding_signup_button_google => 'Continue with Google';

  @override
  String get onboarding_signup_button_apple => 'Continue with Apple';

  @override
  String get onboarding_signup_divider => 'or';

  @override
  String get onboarding_signup_label_email => 'Email';

  @override
  String get onboarding_signup_hint_email => 'you@example.com';

  @override
  String get onboarding_signup_label_password => 'Password';

  @override
  String get onboarding_signup_label_confirmPassword => 'Confirm Password';

  @override
  String get onboarding_signup_button_create => 'Create Account';

  @override
  String onboarding_signup_legal(String terms, String privacy) {
    return 'By signing up you agree to our $terms and $privacy';
  }

  @override
  String get onboarding_signup_legal_terms => 'Terms of Service';

  @override
  String get onboarding_signup_legal_privacy => 'Privacy Policy';

  @override
  String get onboarding_signup_error_emailInUse => 'This email is already registered.';

  @override
  String get onboarding_signup_error_invalidEmail => 'Please enter a valid email address.';

  @override
  String get onboarding_signup_error_weakPassword => 'Password must be at least 8 characters.';

  @override
  String get onboarding_signup_error_networkFailed => 'Network error. Check your connection.';

  @override
  String get onboarding_signup_error_generic => 'Authentication failed. Please try again.';

  @override
  String get onboarding_login_title => 'Log In';

  @override
  String get onboarding_login_heading => 'Welcome back';

  @override
  String get onboarding_login_button_login => 'Log In';

  @override
  String get onboarding_login_link_forgot => 'Forgot password?';

  @override
  String get onboarding_login_link_signup => 'Don\'t have an account? Sign up';

  @override
  String get onboarding_name_title => 'What should we call you?';

  @override
  String get onboarding_name_hint => 'Your name';

  @override
  String get onboarding_name_error_min => 'Please enter at least 2 characters';

  @override
  String get onboarding_partner_title => 'Who is the special one?';

  @override
  String get onboarding_partner_hint => 'Her name';

  @override
  String get onboarding_partner_label_zodiac => 'Her zodiac sign (optional)';

  @override
  String get onboarding_partner_label_zodiacUnknown => 'I don\'t know her sign';

  @override
  String get onboarding_partner_label_status => 'Relationship status';

  @override
  String get onboarding_partner_error_name => 'Please enter her name';

  @override
  String get onboarding_status_dating => 'Dating';

  @override
  String get onboarding_status_engaged => 'Engaged';

  @override
  String get onboarding_status_newlywed => 'Newlywed';

  @override
  String get onboarding_status_married => 'Married';

  @override
  String get onboarding_status_longDistance => 'Long Distance';

  @override
  String get onboarding_anniversary_title => 'When did your story begin?';

  @override
  String get onboarding_anniversary_label_dating => 'Dating anniversary';

  @override
  String get onboarding_anniversary_label_wedding => 'Wedding date';

  @override
  String get onboarding_anniversary_select_date => 'Select a date';

  @override
  String onboarding_firstCard_title(String partnerName) {
    return 'Your first smart card for $partnerName';
  }

  @override
  String onboarding_firstCard_personalized(String partnerName) {
    return 'Personalized for $partnerName';
  }

  @override
  String get profile_title => 'Her Profile';

  @override
  String profile_completion(int percent) {
    return '$percent% complete';
  }

  @override
  String get profile_nav_zodiac => 'Zodiac & Traits';

  @override
  String get profile_nav_zodiac_empty => 'Not set yet';

  @override
  String get profile_nav_preferences => 'Preferences';

  @override
  String profile_nav_preferences_subtitle(int count) {
    return '$count items recorded';
  }

  @override
  String get profile_nav_cultural => 'Cultural Context';

  @override
  String get profile_nav_cultural_empty => 'Not set yet';

  @override
  String get profile_edit_title => 'Edit Profile';

  @override
  String get profile_edit_zodiac_traits => 'Zodiac Traits';

  @override
  String get profile_edit_loveLanguage => 'Her Love Language';

  @override
  String get profile_edit_commStyle => 'Communication Style';

  @override
  String get profile_edit_conflictStyle => 'Conflict Style';

  @override
  String get profile_edit_loveLanguage_words => 'Words of Affirmation';

  @override
  String get profile_edit_loveLanguage_acts => 'Acts of Service';

  @override
  String get profile_edit_loveLanguage_gifts => 'Receiving Gifts';

  @override
  String get profile_edit_loveLanguage_time => 'Quality Time';

  @override
  String get profile_edit_loveLanguage_touch => 'Physical Touch';

  @override
  String get profile_edit_commStyle_direct => 'Direct';

  @override
  String get profile_edit_commStyle_indirect => 'Indirect';

  @override
  String get profile_edit_commStyle_mixed => 'Mixed';

  @override
  String get profile_preferences_title => 'Her Preferences';

  @override
  String get profile_preferences_favorites => 'Favorites';

  @override
  String profile_preferences_add_hint(String category) {
    return 'Add $category...';
  }

  @override
  String get profile_preferences_hobbies => 'Hobbies & Interests';

  @override
  String get profile_preferences_dislikes => 'Dislikes & Triggers';

  @override
  String get profile_preferences_category_flowers => 'Flowers';

  @override
  String get profile_preferences_category_food => 'Food';

  @override
  String get profile_preferences_category_music => 'Music';

  @override
  String get profile_preferences_category_movies => 'Movies';

  @override
  String get profile_preferences_category_brands => 'Brands';

  @override
  String get profile_preferences_category_colors => 'Colors';

  @override
  String get profile_cultural_title => 'Cultural Context';

  @override
  String get profile_cultural_background => 'Cultural Background';

  @override
  String get profile_cultural_background_hint => 'Select background';

  @override
  String get profile_cultural_observance => 'Religious Observance';

  @override
  String get profile_cultural_dialect => 'Arabic Dialect';

  @override
  String get profile_cultural_dialect_hint => 'Select dialect';

  @override
  String get profile_cultural_info => 'This helps LOLO personalize AI content, filter inappropriate suggestions, and auto-add relevant holidays to your reminders.';

  @override
  String get profile_cultural_bg_gulf => 'Gulf Arab';

  @override
  String get profile_cultural_bg_levantine => 'Levantine';

  @override
  String get profile_cultural_bg_egyptian => 'Egyptian';

  @override
  String get profile_cultural_bg_northAfrican => 'North African';

  @override
  String get profile_cultural_bg_malay => 'Malaysian/Malay';

  @override
  String get profile_cultural_bg_western => 'Western';

  @override
  String get profile_cultural_bg_southAsian => 'South Asian';

  @override
  String get profile_cultural_bg_eastAsian => 'East Asian';

  @override
  String get profile_cultural_bg_other => 'Other';

  @override
  String get profile_cultural_obs_high => 'High -- Observes all religious practices';

  @override
  String get profile_cultural_obs_moderate => 'Moderate -- Observes major practices';

  @override
  String get profile_cultural_obs_low => 'Low -- Culturally connected';

  @override
  String get profile_cultural_obs_secular => 'Secular';

  @override
  String get reminders_title => 'Reminders';

  @override
  String get reminders_view_list => 'List view';

  @override
  String get reminders_view_calendar => 'Calendar view';

  @override
  String get reminders_section_overdue => 'Overdue';

  @override
  String get reminders_section_upcoming => 'Upcoming';

  @override
  String get reminders_create_title => 'New Reminder';

  @override
  String get reminders_create_label_title => 'Title';

  @override
  String get reminders_create_hint_title => 'e.g. Her birthday';

  @override
  String get reminders_create_label_category => 'Category';

  @override
  String get reminders_create_label_date => 'Date';

  @override
  String get reminders_create_label_time => 'Time (optional)';

  @override
  String get reminders_create_label_recurrence => 'Repeat';

  @override
  String get reminders_create_label_notes => 'Notes (optional)';

  @override
  String get reminders_create_hint_notes => 'Add any additional details...';

  @override
  String get reminders_create_button_save => 'Create Reminder';

  @override
  String get reminders_create_recurrence_none => 'No repeat';

  @override
  String get reminders_create_recurrence_weekly => 'Weekly';

  @override
  String get reminders_create_recurrence_monthly => 'Monthly';

  @override
  String get reminders_create_recurrence_yearly => 'Yearly';

  @override
  String get reminders_create_category_birthday => 'Birthday';

  @override
  String get reminders_create_category_anniversary => 'Anniversary';

  @override
  String get reminders_create_category_islamic => 'Islamic Holiday';

  @override
  String get reminders_create_category_cultural => 'Cultural';

  @override
  String get reminders_create_category_custom => 'Custom';

  @override
  String get reminders_create_category_promise => 'Promise';

  @override
  String get reminders_create_error_title => 'Title is required';

  @override
  String get reminders_create_error_date => 'Please select a date';

  @override
  String get reminders_create_error_pastDate => 'Reminder date cannot be in the past';

  @override
  String get reminders_detail_title => 'Reminder Details';

  @override
  String get reminders_detail_date => 'Date';

  @override
  String get reminders_detail_time => 'Time';

  @override
  String get reminders_detail_daysUntil => 'Days until';

  @override
  String get reminders_detail_recurrence => 'Repeats';

  @override
  String get reminders_detail_notes => 'Notes';

  @override
  String get reminders_detail_button_complete => 'Mark as Complete';

  @override
  String get reminders_detail_button_snooze => 'Snooze';

  @override
  String get reminders_detail_completed => 'Completed';

  @override
  String reminders_detail_overdue(int days) {
    return '$days days overdue';
  }

  @override
  String reminders_detail_inDays(int days) {
    return 'In $days days';
  }

  @override
  String get reminders_detail_today => 'Today';

  @override
  String get reminders_snooze_title => 'Snooze for...';

  @override
  String get reminders_snooze_1h => '1 hour';

  @override
  String get reminders_snooze_3h => '3 hours';

  @override
  String get reminders_snooze_1d => '1 day';

  @override
  String get reminders_snooze_3d => '3 days';

  @override
  String get reminders_snooze_1w => '1 week';

  @override
  String get reminders_delete_title => 'Delete Reminder';

  @override
  String get reminders_delete_message => 'This will permanently delete this reminder and cancel all its notifications. Are you sure?';

  @override
  String get reminders_notification_today => 'Today is the day!';

  @override
  String reminders_notification_daysUntil(int days, String title) {
    return '$days days until $title';
  }

  @override
  String reminders_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reminders',
      one: '1 reminder',
      zero: 'No reminders',
    );
    return '$_temp0';
  }

  @override
  String profile_items_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String days_remaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count days',
      one: 'Tomorrow',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String get actionCardsTitle => 'Daily Actions';

  @override
  String get allCardsDone => 'All done for today!';

  @override
  String get allCardsDoneSubtitle => 'Come back tomorrow for fresh ideas';

  @override
  String get whatToDo => 'What to do';

  @override
  String get howDidItGo => 'How did it go?';

  @override
  String get optionalNotes => 'Add notes (optional)';

  @override
  String get markComplete => 'Mark Complete';

  @override
  String get gamification => 'Progress';

  @override
  String get badges => 'Badges';
}
