import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ms.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('ms')
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'LOLO'**
  String get appName;

  /// No description provided for @common_button_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get common_button_continue;

  /// No description provided for @common_button_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get common_button_back;

  /// No description provided for @common_button_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get common_button_skip;

  /// No description provided for @common_button_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_button_save;

  /// No description provided for @common_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_button_cancel;

  /// No description provided for @common_button_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_button_delete;

  /// No description provided for @common_button_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get common_button_done;

  /// No description provided for @common_button_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_button_retry;

  /// No description provided for @common_button_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_button_close;

  /// No description provided for @common_button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get common_button_confirm;

  /// No description provided for @common_button_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_button_edit;

  /// No description provided for @common_button_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get common_button_copy;

  /// No description provided for @common_button_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get common_button_share;

  /// No description provided for @common_label_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get common_label_loading;

  /// No description provided for @common_label_offline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Showing cached data.'**
  String get common_label_offline;

  /// No description provided for @common_label_lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated {time}'**
  String common_label_lastUpdated(String time);

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get error_generic;

  /// No description provided for @error_network.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network.'**
  String get error_network;

  /// No description provided for @error_timeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get error_timeout;

  /// No description provided for @error_server.
  ///
  /// In en, this message translates to:
  /// **'Server error. We\'re working on it.'**
  String get error_server;

  /// No description provided for @error_unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get error_unauthorized;

  /// No description provided for @error_rate_limited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait a moment.'**
  String get error_rate_limited;

  /// No description provided for @error_tier_exceeded.
  ///
  /// In en, this message translates to:
  /// **'Upgrade your plan to unlock this feature.'**
  String get error_tier_exceeded;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get nav_reminders;

  /// No description provided for @nav_messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get nav_messages;

  /// No description provided for @nav_gifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get nav_gifts;

  /// No description provided for @nav_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get nav_more;

  /// No description provided for @empty_reminders_title.
  ///
  /// In en, this message translates to:
  /// **'No reminders yet'**
  String get empty_reminders_title;

  /// No description provided for @empty_reminders_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add important dates so you never forget'**
  String get empty_reminders_subtitle;

  /// No description provided for @empty_messages_title.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get empty_messages_title;

  /// No description provided for @empty_messages_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate your first AI message'**
  String get empty_messages_subtitle;

  /// No description provided for @empty_memories_title.
  ///
  /// In en, this message translates to:
  /// **'No memories yet'**
  String get empty_memories_title;

  /// No description provided for @empty_memories_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Start saving moments that matter'**
  String get empty_memories_subtitle;

  /// No description provided for @onboarding_language_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get onboarding_language_title;

  /// No description provided for @onboarding_language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get onboarding_language_english;

  /// No description provided for @onboarding_language_arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get onboarding_language_arabic;

  /// No description provided for @onboarding_language_malay.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Melayu'**
  String get onboarding_language_malay;

  /// No description provided for @onboarding_welcome_tagline.
  ///
  /// In en, this message translates to:
  /// **'She won\'t know why you got so thoughtful.\nWe won\'t tell.'**
  String get onboarding_welcome_tagline;

  /// No description provided for @onboarding_welcome_benefit1_title.
  ///
  /// In en, this message translates to:
  /// **'Smart Reminders'**
  String get onboarding_welcome_benefit1_title;

  /// No description provided for @onboarding_welcome_benefit1_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Never forget what matters to her'**
  String get onboarding_welcome_benefit1_subtitle;

  /// No description provided for @onboarding_welcome_benefit2_title.
  ///
  /// In en, this message translates to:
  /// **'AI Messages'**
  String get onboarding_welcome_benefit2_title;

  /// No description provided for @onboarding_welcome_benefit2_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Say the right thing, every time'**
  String get onboarding_welcome_benefit2_subtitle;

  /// No description provided for @onboarding_welcome_benefit3_title.
  ///
  /// In en, this message translates to:
  /// **'SOS Mode'**
  String get onboarding_welcome_benefit3_title;

  /// No description provided for @onboarding_welcome_benefit3_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency help when she\'s upset'**
  String get onboarding_welcome_benefit3_subtitle;

  /// No description provided for @onboarding_welcome_button_start.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_welcome_button_start;

  /// No description provided for @onboarding_welcome_link_login.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get onboarding_welcome_link_login;

  /// No description provided for @onboarding_signup_title.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get onboarding_signup_title;

  /// No description provided for @onboarding_signup_heading.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get onboarding_signup_heading;

  /// No description provided for @onboarding_signup_button_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get onboarding_signup_button_google;

  /// No description provided for @onboarding_signup_button_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get onboarding_signup_button_apple;

  /// No description provided for @onboarding_signup_divider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get onboarding_signup_divider;

  /// No description provided for @onboarding_signup_label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get onboarding_signup_label_email;

  /// No description provided for @onboarding_signup_hint_email.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get onboarding_signup_hint_email;

  /// No description provided for @onboarding_signup_label_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get onboarding_signup_label_password;

  /// No description provided for @onboarding_signup_label_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get onboarding_signup_label_confirmPassword;

  /// No description provided for @onboarding_signup_button_create.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get onboarding_signup_button_create;

  /// No description provided for @onboarding_signup_legal.
  ///
  /// In en, this message translates to:
  /// **'By signing up you agree to our {terms} and {privacy}'**
  String onboarding_signup_legal(String terms, String privacy);

  /// No description provided for @onboarding_signup_legal_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get onboarding_signup_legal_terms;

  /// No description provided for @onboarding_signup_legal_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get onboarding_signup_legal_privacy;

  /// No description provided for @onboarding_signup_error_emailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get onboarding_signup_error_emailInUse;

  /// No description provided for @onboarding_signup_error_invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get onboarding_signup_error_invalidEmail;

  /// No description provided for @onboarding_signup_error_weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get onboarding_signup_error_weakPassword;

  /// No description provided for @onboarding_signup_error_networkFailed.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your connection.'**
  String get onboarding_signup_error_networkFailed;

  /// No description provided for @onboarding_signup_error_generic.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get onboarding_signup_error_generic;

  /// No description provided for @onboarding_login_title.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get onboarding_login_title;

  /// No description provided for @onboarding_login_heading.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get onboarding_login_heading;

  /// No description provided for @onboarding_login_button_login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get onboarding_login_button_login;

  /// No description provided for @onboarding_login_link_forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get onboarding_login_link_forgot;

  /// No description provided for @onboarding_login_link_signup.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get onboarding_login_link_signup;

  /// No description provided for @onboarding_name_title.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onboarding_name_title;

  /// No description provided for @onboarding_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onboarding_name_hint;

  /// No description provided for @onboarding_name_error_min.
  ///
  /// In en, this message translates to:
  /// **'Please enter at least 2 characters'**
  String get onboarding_name_error_min;

  /// No description provided for @onboarding_partner_title.
  ///
  /// In en, this message translates to:
  /// **'Who is the special one?'**
  String get onboarding_partner_title;

  /// No description provided for @onboarding_partner_hint.
  ///
  /// In en, this message translates to:
  /// **'Her name'**
  String get onboarding_partner_hint;

  /// No description provided for @onboarding_partner_label_zodiac.
  ///
  /// In en, this message translates to:
  /// **'Her zodiac sign (optional)'**
  String get onboarding_partner_label_zodiac;

  /// No description provided for @onboarding_partner_label_zodiacUnknown.
  ///
  /// In en, this message translates to:
  /// **'I don\'t know her sign'**
  String get onboarding_partner_label_zodiacUnknown;

  /// No description provided for @onboarding_partner_label_status.
  ///
  /// In en, this message translates to:
  /// **'Relationship status'**
  String get onboarding_partner_label_status;

  /// No description provided for @onboarding_partner_error_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter her name'**
  String get onboarding_partner_error_name;

  /// No description provided for @onboarding_status_dating.
  ///
  /// In en, this message translates to:
  /// **'Dating'**
  String get onboarding_status_dating;

  /// No description provided for @onboarding_status_engaged.
  ///
  /// In en, this message translates to:
  /// **'Engaged'**
  String get onboarding_status_engaged;

  /// No description provided for @onboarding_status_newlywed.
  ///
  /// In en, this message translates to:
  /// **'Newlywed'**
  String get onboarding_status_newlywed;

  /// No description provided for @onboarding_status_married.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get onboarding_status_married;

  /// No description provided for @onboarding_status_longDistance.
  ///
  /// In en, this message translates to:
  /// **'Long Distance'**
  String get onboarding_status_longDistance;

  /// No description provided for @onboarding_anniversary_title.
  ///
  /// In en, this message translates to:
  /// **'When did your story begin?'**
  String get onboarding_anniversary_title;

  /// No description provided for @onboarding_anniversary_label_dating.
  ///
  /// In en, this message translates to:
  /// **'Dating anniversary'**
  String get onboarding_anniversary_label_dating;

  /// No description provided for @onboarding_anniversary_label_wedding.
  ///
  /// In en, this message translates to:
  /// **'Wedding date'**
  String get onboarding_anniversary_label_wedding;

  /// No description provided for @onboarding_anniversary_select_date.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get onboarding_anniversary_select_date;

  /// No description provided for @onboarding_firstCard_title.
  ///
  /// In en, this message translates to:
  /// **'Your first smart card for {partnerName}'**
  String onboarding_firstCard_title(String partnerName);

  /// No description provided for @onboarding_firstCard_personalized.
  ///
  /// In en, this message translates to:
  /// **'Personalized for {partnerName}'**
  String onboarding_firstCard_personalized(String partnerName);

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Her Profile'**
  String get profile_title;

  /// No description provided for @profile_completion.
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String profile_completion(int percent);

  /// No description provided for @profile_nav_zodiac.
  ///
  /// In en, this message translates to:
  /// **'Zodiac & Traits'**
  String get profile_nav_zodiac;

  /// No description provided for @profile_nav_zodiac_empty.
  ///
  /// In en, this message translates to:
  /// **'Not set yet'**
  String get profile_nav_zodiac_empty;

  /// No description provided for @profile_nav_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profile_nav_preferences;

  /// No description provided for @profile_nav_preferences_subtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} items recorded'**
  String profile_nav_preferences_subtitle(int count);

  /// No description provided for @profile_nav_cultural.
  ///
  /// In en, this message translates to:
  /// **'Cultural Context'**
  String get profile_nav_cultural;

  /// No description provided for @profile_nav_cultural_empty.
  ///
  /// In en, this message translates to:
  /// **'Not set yet'**
  String get profile_nav_cultural_empty;

  /// No description provided for @profile_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profile_edit_title;

  /// No description provided for @profile_edit_zodiac_traits.
  ///
  /// In en, this message translates to:
  /// **'Zodiac Traits'**
  String get profile_edit_zodiac_traits;

  /// No description provided for @profile_edit_loveLanguage.
  ///
  /// In en, this message translates to:
  /// **'Her Love Language'**
  String get profile_edit_loveLanguage;

  /// No description provided for @profile_edit_commStyle.
  ///
  /// In en, this message translates to:
  /// **'Communication Style'**
  String get profile_edit_commStyle;

  /// No description provided for @profile_edit_conflictStyle.
  ///
  /// In en, this message translates to:
  /// **'Conflict Style'**
  String get profile_edit_conflictStyle;

  /// No description provided for @profile_edit_loveLanguage_words.
  ///
  /// In en, this message translates to:
  /// **'Words of Affirmation'**
  String get profile_edit_loveLanguage_words;

  /// No description provided for @profile_edit_loveLanguage_acts.
  ///
  /// In en, this message translates to:
  /// **'Acts of Service'**
  String get profile_edit_loveLanguage_acts;

  /// No description provided for @profile_edit_loveLanguage_gifts.
  ///
  /// In en, this message translates to:
  /// **'Receiving Gifts'**
  String get profile_edit_loveLanguage_gifts;

  /// No description provided for @profile_edit_loveLanguage_time.
  ///
  /// In en, this message translates to:
  /// **'Quality Time'**
  String get profile_edit_loveLanguage_time;

  /// No description provided for @profile_edit_loveLanguage_touch.
  ///
  /// In en, this message translates to:
  /// **'Physical Touch'**
  String get profile_edit_loveLanguage_touch;

  /// No description provided for @profile_edit_commStyle_direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get profile_edit_commStyle_direct;

  /// No description provided for @profile_edit_commStyle_indirect.
  ///
  /// In en, this message translates to:
  /// **'Indirect'**
  String get profile_edit_commStyle_indirect;

  /// No description provided for @profile_edit_commStyle_mixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get profile_edit_commStyle_mixed;

  /// No description provided for @profile_preferences_title.
  ///
  /// In en, this message translates to:
  /// **'Her Preferences'**
  String get profile_preferences_title;

  /// No description provided for @profile_preferences_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profile_preferences_favorites;

  /// No description provided for @profile_preferences_add_hint.
  ///
  /// In en, this message translates to:
  /// **'Add {category}...'**
  String profile_preferences_add_hint(String category);

  /// No description provided for @profile_preferences_hobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies & Interests'**
  String get profile_preferences_hobbies;

  /// No description provided for @profile_preferences_dislikes.
  ///
  /// In en, this message translates to:
  /// **'Dislikes & Triggers'**
  String get profile_preferences_dislikes;

  /// No description provided for @profile_preferences_category_flowers.
  ///
  /// In en, this message translates to:
  /// **'Flowers'**
  String get profile_preferences_category_flowers;

  /// No description provided for @profile_preferences_category_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get profile_preferences_category_food;

  /// No description provided for @profile_preferences_category_music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get profile_preferences_category_music;

  /// No description provided for @profile_preferences_category_movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get profile_preferences_category_movies;

  /// No description provided for @profile_preferences_category_brands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get profile_preferences_category_brands;

  /// No description provided for @profile_preferences_category_colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get profile_preferences_category_colors;

  /// No description provided for @profile_cultural_title.
  ///
  /// In en, this message translates to:
  /// **'Cultural Context'**
  String get profile_cultural_title;

  /// No description provided for @profile_cultural_background.
  ///
  /// In en, this message translates to:
  /// **'Cultural Background'**
  String get profile_cultural_background;

  /// No description provided for @profile_cultural_background_hint.
  ///
  /// In en, this message translates to:
  /// **'Select background'**
  String get profile_cultural_background_hint;

  /// No description provided for @profile_cultural_observance.
  ///
  /// In en, this message translates to:
  /// **'Religious Observance'**
  String get profile_cultural_observance;

  /// No description provided for @profile_cultural_dialect.
  ///
  /// In en, this message translates to:
  /// **'Arabic Dialect'**
  String get profile_cultural_dialect;

  /// No description provided for @profile_cultural_dialect_hint.
  ///
  /// In en, this message translates to:
  /// **'Select dialect'**
  String get profile_cultural_dialect_hint;

  /// No description provided for @profile_cultural_info.
  ///
  /// In en, this message translates to:
  /// **'This helps LOLO personalize AI content, filter inappropriate suggestions, and auto-add relevant holidays to your reminders.'**
  String get profile_cultural_info;

  /// No description provided for @profile_cultural_bg_gulf.
  ///
  /// In en, this message translates to:
  /// **'Gulf Arab'**
  String get profile_cultural_bg_gulf;

  /// No description provided for @profile_cultural_bg_levantine.
  ///
  /// In en, this message translates to:
  /// **'Levantine'**
  String get profile_cultural_bg_levantine;

  /// No description provided for @profile_cultural_bg_egyptian.
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get profile_cultural_bg_egyptian;

  /// No description provided for @profile_cultural_bg_northAfrican.
  ///
  /// In en, this message translates to:
  /// **'North African'**
  String get profile_cultural_bg_northAfrican;

  /// No description provided for @profile_cultural_bg_malay.
  ///
  /// In en, this message translates to:
  /// **'Malaysian/Malay'**
  String get profile_cultural_bg_malay;

  /// No description provided for @profile_cultural_bg_western.
  ///
  /// In en, this message translates to:
  /// **'Western'**
  String get profile_cultural_bg_western;

  /// No description provided for @profile_cultural_bg_southAsian.
  ///
  /// In en, this message translates to:
  /// **'South Asian'**
  String get profile_cultural_bg_southAsian;

  /// No description provided for @profile_cultural_bg_eastAsian.
  ///
  /// In en, this message translates to:
  /// **'East Asian'**
  String get profile_cultural_bg_eastAsian;

  /// No description provided for @profile_cultural_bg_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get profile_cultural_bg_other;

  /// No description provided for @profile_cultural_obs_high.
  ///
  /// In en, this message translates to:
  /// **'High -- Observes all religious practices'**
  String get profile_cultural_obs_high;

  /// No description provided for @profile_cultural_obs_moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate -- Observes major practices'**
  String get profile_cultural_obs_moderate;

  /// No description provided for @profile_cultural_obs_low.
  ///
  /// In en, this message translates to:
  /// **'Low -- Culturally connected'**
  String get profile_cultural_obs_low;

  /// No description provided for @profile_cultural_obs_secular.
  ///
  /// In en, this message translates to:
  /// **'Secular'**
  String get profile_cultural_obs_secular;

  /// No description provided for @reminders_title.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders_title;

  /// No description provided for @reminders_view_list.
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get reminders_view_list;

  /// No description provided for @reminders_view_calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar view'**
  String get reminders_view_calendar;

  /// No description provided for @reminders_section_overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get reminders_section_overdue;

  /// No description provided for @reminders_section_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get reminders_section_upcoming;

  /// No description provided for @reminders_create_title.
  ///
  /// In en, this message translates to:
  /// **'New Reminder'**
  String get reminders_create_title;

  /// No description provided for @reminders_create_label_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get reminders_create_label_title;

  /// No description provided for @reminders_create_hint_title.
  ///
  /// In en, this message translates to:
  /// **'e.g. Her birthday'**
  String get reminders_create_hint_title;

  /// No description provided for @reminders_create_label_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get reminders_create_label_category;

  /// No description provided for @reminders_create_label_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reminders_create_label_date;

  /// No description provided for @reminders_create_label_time.
  ///
  /// In en, this message translates to:
  /// **'Time (optional)'**
  String get reminders_create_label_time;

  /// No description provided for @reminders_create_label_recurrence.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get reminders_create_label_recurrence;

  /// No description provided for @reminders_create_label_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get reminders_create_label_notes;

  /// No description provided for @reminders_create_hint_notes.
  ///
  /// In en, this message translates to:
  /// **'Add any additional details...'**
  String get reminders_create_hint_notes;

  /// No description provided for @reminders_create_button_save.
  ///
  /// In en, this message translates to:
  /// **'Create Reminder'**
  String get reminders_create_button_save;

  /// No description provided for @reminders_create_recurrence_none.
  ///
  /// In en, this message translates to:
  /// **'No repeat'**
  String get reminders_create_recurrence_none;

  /// No description provided for @reminders_create_recurrence_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get reminders_create_recurrence_weekly;

  /// No description provided for @reminders_create_recurrence_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get reminders_create_recurrence_monthly;

  /// No description provided for @reminders_create_recurrence_yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get reminders_create_recurrence_yearly;

  /// No description provided for @reminders_create_category_birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get reminders_create_category_birthday;

  /// No description provided for @reminders_create_category_anniversary.
  ///
  /// In en, this message translates to:
  /// **'Anniversary'**
  String get reminders_create_category_anniversary;

  /// No description provided for @reminders_create_category_islamic.
  ///
  /// In en, this message translates to:
  /// **'Islamic Holiday'**
  String get reminders_create_category_islamic;

  /// No description provided for @reminders_create_category_cultural.
  ///
  /// In en, this message translates to:
  /// **'Cultural'**
  String get reminders_create_category_cultural;

  /// No description provided for @reminders_create_category_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get reminders_create_category_custom;

  /// No description provided for @reminders_create_category_promise.
  ///
  /// In en, this message translates to:
  /// **'Promise'**
  String get reminders_create_category_promise;

  /// No description provided for @reminders_create_error_title.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get reminders_create_error_title;

  /// No description provided for @reminders_create_error_date.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get reminders_create_error_date;

  /// No description provided for @reminders_create_error_pastDate.
  ///
  /// In en, this message translates to:
  /// **'Reminder date cannot be in the past'**
  String get reminders_create_error_pastDate;

  /// No description provided for @reminders_detail_title.
  ///
  /// In en, this message translates to:
  /// **'Reminder Details'**
  String get reminders_detail_title;

  /// No description provided for @reminders_detail_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reminders_detail_date;

  /// No description provided for @reminders_detail_time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get reminders_detail_time;

  /// No description provided for @reminders_detail_daysUntil.
  ///
  /// In en, this message translates to:
  /// **'Days until'**
  String get reminders_detail_daysUntil;

  /// No description provided for @reminders_detail_recurrence.
  ///
  /// In en, this message translates to:
  /// **'Repeats'**
  String get reminders_detail_recurrence;

  /// No description provided for @reminders_detail_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get reminders_detail_notes;

  /// No description provided for @reminders_detail_button_complete.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get reminders_detail_button_complete;

  /// No description provided for @reminders_detail_button_snooze.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get reminders_detail_button_snooze;

  /// No description provided for @reminders_detail_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get reminders_detail_completed;

  /// No description provided for @reminders_detail_overdue.
  ///
  /// In en, this message translates to:
  /// **'{days} days overdue'**
  String reminders_detail_overdue(int days);

  /// No description provided for @reminders_detail_inDays.
  ///
  /// In en, this message translates to:
  /// **'In {days} days'**
  String reminders_detail_inDays(int days);

  /// No description provided for @reminders_detail_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get reminders_detail_today;

  /// No description provided for @reminders_snooze_title.
  ///
  /// In en, this message translates to:
  /// **'Snooze for...'**
  String get reminders_snooze_title;

  /// No description provided for @reminders_snooze_1h.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get reminders_snooze_1h;

  /// No description provided for @reminders_snooze_3h.
  ///
  /// In en, this message translates to:
  /// **'3 hours'**
  String get reminders_snooze_3h;

  /// No description provided for @reminders_snooze_1d.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get reminders_snooze_1d;

  /// No description provided for @reminders_snooze_3d.
  ///
  /// In en, this message translates to:
  /// **'3 days'**
  String get reminders_snooze_3d;

  /// No description provided for @reminders_snooze_1w.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get reminders_snooze_1w;

  /// No description provided for @reminders_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Reminder'**
  String get reminders_delete_title;

  /// No description provided for @reminders_delete_message.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete this reminder and cancel all its notifications. Are you sure?'**
  String get reminders_delete_message;

  /// No description provided for @reminders_notification_today.
  ///
  /// In en, this message translates to:
  /// **'Today is the day!'**
  String get reminders_notification_today;

  /// No description provided for @reminders_notification_daysUntil.
  ///
  /// In en, this message translates to:
  /// **'{days} days until {title}'**
  String reminders_notification_daysUntil(int days, String title);

  /// No description provided for @reminders_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No reminders} =1{1 reminder} other{{count} reminders}}'**
  String reminders_count(int count);

  /// No description provided for @profile_items_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String profile_items_count(int count);

  /// No description provided for @days_remaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Today} =1{Tomorrow} other{In {count} days}}'**
  String days_remaining(int count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'ms'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'ms': return AppLocalizationsMs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
