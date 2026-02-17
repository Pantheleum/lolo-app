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

  /// Title for the action cards screen
  ///
  /// In en, this message translates to:
  /// **'Daily Actions'**
  String get actionCardsTitle;

  /// Title shown when all daily action cards are completed
  ///
  /// In en, this message translates to:
  /// **'All done for today!'**
  String get allCardsDone;

  /// Subtitle shown when all daily action cards are completed
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow for fresh ideas'**
  String get allCardsDoneSubtitle;

  /// Section header for action card instructions
  ///
  /// In en, this message translates to:
  /// **'What to do'**
  String get whatToDo;

  /// Section header for post-action feedback
  ///
  /// In en, this message translates to:
  /// **'How did it go?'**
  String get howDidItGo;

  /// Hint text for optional notes input
  ///
  /// In en, this message translates to:
  /// **'Add notes (optional)'**
  String get optionalNotes;

  /// Button label to mark an action card as complete
  ///
  /// In en, this message translates to:
  /// **'Mark Complete'**
  String get markComplete;

  /// Title for the gamification hub screen
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get gamification;

  /// Section title for achievement badges
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @sosTitle.
  ///
  /// In en, this message translates to:
  /// **'SOS Mode'**
  String get sosTitle;

  /// No description provided for @sosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency help when she\'s upset'**
  String get sosSubtitle;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get Help Now'**
  String get getHelp;

  /// No description provided for @assessment.
  ///
  /// In en, this message translates to:
  /// **'Assessment'**
  String get assessment;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @coaching.
  ///
  /// In en, this message translates to:
  /// **'Coaching'**
  String get coaching;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepProgress(int current, int total);

  /// No description provided for @sayThis.
  ///
  /// In en, this message translates to:
  /// **'Say This'**
  String get sayThis;

  /// No description provided for @dontSay.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Say This'**
  String get dontSay;

  /// No description provided for @whatHappened.
  ///
  /// In en, this message translates to:
  /// **'What happened?'**
  String get whatHappened;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @viewRecoveryPlan.
  ///
  /// In en, this message translates to:
  /// **'View Recovery Plan'**
  String get viewRecoveryPlan;

  /// No description provided for @recoveryPlan.
  ///
  /// In en, this message translates to:
  /// **'Recovery Plan'**
  String get recoveryPlan;

  /// No description provided for @immediate.
  ///
  /// In en, this message translates to:
  /// **'Immediate'**
  String get immediate;

  /// No description provided for @immediateStep1.
  ///
  /// In en, this message translates to:
  /// **'Apologize sincerely'**
  String get immediateStep1;

  /// No description provided for @immediateStep2.
  ///
  /// In en, this message translates to:
  /// **'Give her space if needed'**
  String get immediateStep2;

  /// No description provided for @immediateStep3.
  ///
  /// In en, this message translates to:
  /// **'Listen without defending'**
  String get immediateStep3;

  /// No description provided for @shortTerm.
  ///
  /// In en, this message translates to:
  /// **'Short Term'**
  String get shortTerm;

  /// No description provided for @shortTermStep1.
  ///
  /// In en, this message translates to:
  /// **'Plan a thoughtful gesture'**
  String get shortTermStep1;

  /// No description provided for @shortTermStep2.
  ///
  /// In en, this message translates to:
  /// **'Follow through on promises'**
  String get shortTermStep2;

  /// No description provided for @longTerm.
  ///
  /// In en, this message translates to:
  /// **'Long Term'**
  String get longTerm;

  /// No description provided for @longTermStep1.
  ///
  /// In en, this message translates to:
  /// **'Address the root cause'**
  String get longTermStep1;

  /// No description provided for @longTermStep2.
  ///
  /// In en, this message translates to:
  /// **'Build new habits together'**
  String get longTermStep2;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @upgradePlan.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Plan'**
  String get upgradePlan;

  /// No description provided for @noPlansAvailable.
  ///
  /// In en, this message translates to:
  /// **'No plans available at this time'**
  String get noPlansAvailable;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @subscriptionTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions apply'**
  String get subscriptionTerms;

  /// No description provided for @unlockFullPotential.
  ///
  /// In en, this message translates to:
  /// **'Unlock Full Potential'**
  String get unlockFullPotential;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get unlimited access to all features'**
  String get paywallSubtitle;

  /// No description provided for @welcome_tagline.
  ///
  /// In en, this message translates to:
  /// **'Your AI-powered relationship\nintelligence companion'**
  String get welcome_tagline;

  /// No description provided for @welcome_feature_messages.
  ///
  /// In en, this message translates to:
  /// **'AI-crafted messages for every moment'**
  String get welcome_feature_messages;

  /// No description provided for @welcome_feature_gifts.
  ///
  /// In en, this message translates to:
  /// **'Smart gift recommendations'**
  String get welcome_feature_gifts;

  /// No description provided for @welcome_feature_reminders.
  ///
  /// In en, this message translates to:
  /// **'Never forget an important date'**
  String get welcome_feature_reminders;

  /// No description provided for @welcome_alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get welcome_alreadyHaveAccount;

  /// No description provided for @welcome_logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get welcome_logIn;

  /// No description provided for @login_heading.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get login_heading;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get login_subtitle;

  /// No description provided for @login_label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_label_email;

  /// No description provided for @login_hint_email.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get login_hint_email;

  /// No description provided for @login_label_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_label_password;

  /// No description provided for @login_forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get login_forgotPassword;

  /// No description provided for @login_buttonLogin.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login_buttonLogin;

  /// No description provided for @login_orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get login_orContinueWith;

  /// No description provided for @login_google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get login_google;

  /// No description provided for @login_apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get login_apple;

  /// No description provided for @login_noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get login_noAccount;

  /// No description provided for @login_signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get login_signUp;

  /// No description provided for @login_enterEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter your email first'**
  String get login_enterEmailFirst;

  /// No description provided for @login_resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get login_resetEmailSent;

  /// No description provided for @home_upcomingReminders.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Reminders'**
  String get home_upcomingReminders;

  /// No description provided for @home_seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get home_seeAll;

  /// No description provided for @home_todaysActions.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Actions'**
  String get home_todaysActions;

  /// No description provided for @home_somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get home_somethingWentWrong;

  /// No description provided for @home_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get home_notifications;

  /// No description provided for @messages_title.
  ///
  /// In en, this message translates to:
  /// **'AI Messages'**
  String get messages_title;

  /// No description provided for @messages_chooseMode.
  ///
  /// In en, this message translates to:
  /// **'Choose a message mode'**
  String get messages_chooseMode;

  /// No description provided for @messages_history.
  ///
  /// In en, this message translates to:
  /// **'Message History'**
  String get messages_history;

  /// No description provided for @generate_configureMessage.
  ///
  /// In en, this message translates to:
  /// **'Configure Message'**
  String get generate_configureMessage;

  /// No description provided for @generate_tone.
  ///
  /// In en, this message translates to:
  /// **'Tone'**
  String get generate_tone;

  /// No description provided for @generate_humorLevel.
  ///
  /// In en, this message translates to:
  /// **'Humor Level'**
  String get generate_humorLevel;

  /// No description provided for @generate_serious.
  ///
  /// In en, this message translates to:
  /// **'Serious'**
  String get generate_serious;

  /// No description provided for @generate_funny.
  ///
  /// In en, this message translates to:
  /// **'Funny'**
  String get generate_funny;

  /// No description provided for @generate_messageLength.
  ///
  /// In en, this message translates to:
  /// **'Message Length'**
  String get generate_messageLength;

  /// No description provided for @generate_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get generate_language;

  /// No description provided for @generate_includeHerName.
  ///
  /// In en, this message translates to:
  /// **'Include her name'**
  String get generate_includeHerName;

  /// No description provided for @generate_includeHerNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Personalize the message with your partner\'s name'**
  String get generate_includeHerNameDesc;

  /// No description provided for @generate_contextOptional.
  ///
  /// In en, this message translates to:
  /// **'Context (optional)'**
  String get generate_contextOptional;

  /// No description provided for @generate_contextHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., We had an argument about...'**
  String get generate_contextHint;

  /// No description provided for @generate_button.
  ///
  /// In en, this message translates to:
  /// **'Generate Message'**
  String get generate_button;

  /// No description provided for @messageDetail_title.
  ///
  /// In en, this message translates to:
  /// **'Your Message'**
  String get messageDetail_title;

  /// No description provided for @messageDetail_noMessage.
  ///
  /// In en, this message translates to:
  /// **'No message generated yet.'**
  String get messageDetail_noMessage;

  /// No description provided for @messageDetail_crafting.
  ///
  /// In en, this message translates to:
  /// **'Crafting your message...'**
  String get messageDetail_crafting;

  /// No description provided for @messageDetail_copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Message copied to clipboard'**
  String get messageDetail_copiedToClipboard;

  /// No description provided for @messageDetail_shareSubject.
  ///
  /// In en, this message translates to:
  /// **'Message from LOLO'**
  String get messageDetail_shareSubject;

  /// No description provided for @messageDetail_savedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Saved to Favorites'**
  String get messageDetail_savedToFavorites;

  /// No description provided for @messageDetail_saveToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Save to Favorites'**
  String get messageDetail_saveToFavorites;

  /// No description provided for @messageDetail_generatedBy.
  ///
  /// In en, this message translates to:
  /// **'Generated by {model}'**
  String messageDetail_generatedBy(String model);

  /// No description provided for @messageDetail_usageCount.
  ///
  /// In en, this message translates to:
  /// **'{used} of {limit} messages used this month'**
  String messageDetail_usageCount(int used, int limit);

  /// No description provided for @messageHistory_title.
  ///
  /// In en, this message translates to:
  /// **'Message History'**
  String get messageHistory_title;

  /// No description provided for @messageHistory_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search messages...'**
  String get messageHistory_searchHint;

  /// No description provided for @messageHistory_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get messageHistory_all;

  /// No description provided for @messageHistory_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get messageHistory_favorites;

  /// No description provided for @messageHistory_noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get messageHistory_noMessages;

  /// No description provided for @messageHistory_noMessagesDesc.
  ///
  /// In en, this message translates to:
  /// **'Generate your first message to see it here!'**
  String get messageHistory_noMessagesDesc;

  /// No description provided for @messageHistory_generateNow.
  ///
  /// In en, this message translates to:
  /// **'Generate Now'**
  String get messageHistory_generateNow;

  /// No description provided for @messageHistory_copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get messageHistory_copiedToClipboard;

  /// No description provided for @messageHistory_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get messageHistory_today;

  /// No description provided for @messageHistory_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get messageHistory_yesterday;

  /// No description provided for @messageHistory_daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String messageHistory_daysAgo(int days);

  /// No description provided for @sos_whatHappenedDesc.
  ///
  /// In en, this message translates to:
  /// **'Select the scenario that best describes the situation'**
  String get sos_whatHappenedDesc;

  /// No description provided for @sos_howSevere.
  ///
  /// In en, this message translates to:
  /// **'How severe is the situation?'**
  String get sos_howSevere;

  /// No description provided for @sos_mild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get sos_mild;

  /// No description provided for @sos_moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get sos_moderate;

  /// No description provided for @sos_severe.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get sos_severe;

  /// No description provided for @sos_critical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get sos_critical;

  /// No description provided for @sos_herMood.
  ///
  /// In en, this message translates to:
  /// **'Her current mood'**
  String get sos_herMood;

  /// No description provided for @sos_sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sos_sad;

  /// No description provided for @sos_angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get sos_angry;

  /// No description provided for @sos_disappointed.
  ///
  /// In en, this message translates to:
  /// **'Disappointed'**
  String get sos_disappointed;

  /// No description provided for @sos_hurt.
  ///
  /// In en, this message translates to:
  /// **'Hurt'**
  String get sos_hurt;

  /// No description provided for @sos_frustrated.
  ///
  /// In en, this message translates to:
  /// **'Frustrated'**
  String get sos_frustrated;

  /// No description provided for @sos_silent.
  ///
  /// In en, this message translates to:
  /// **'Silent'**
  String get sos_silent;

  /// No description provided for @sos_getCoaching.
  ///
  /// In en, this message translates to:
  /// **'Get Coaching'**
  String get sos_getCoaching;

  /// No description provided for @sos_doFirst.
  ///
  /// In en, this message translates to:
  /// **'Do This First'**
  String get sos_doFirst;

  /// No description provided for @sos_whatToSay.
  ///
  /// In en, this message translates to:
  /// **'What to Say'**
  String get sos_whatToSay;

  /// No description provided for @sos_avoidSaying.
  ///
  /// In en, this message translates to:
  /// **'Avoid Saying'**
  String get sos_avoidSaying;

  /// No description provided for @sos_feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'How did it go?'**
  String get sos_feedbackTitle;

  /// No description provided for @sos_feedbackGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get sos_feedbackGreat;

  /// No description provided for @sos_feedbackOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get sos_feedbackOkay;

  /// No description provided for @sos_feedbackNotWell.
  ///
  /// In en, this message translates to:
  /// **'Not well'**
  String get sos_feedbackNotWell;

  /// No description provided for @sos_sessionComplete.
  ///
  /// In en, this message translates to:
  /// **'Session Complete'**
  String get sos_sessionComplete;

  /// No description provided for @sos_sessionCompleteDesc.
  ///
  /// In en, this message translates to:
  /// **'Well done for making the effort. Remember, it\'s about progress, not perfection.'**
  String get sos_sessionCompleteDesc;

  /// No description provided for @sos_moreResources.
  ///
  /// In en, this message translates to:
  /// **'More Resources'**
  String get sos_moreResources;

  /// No description provided for @gifts_title.
  ///
  /// In en, this message translates to:
  /// **'Gift Ideas'**
  String get gifts_title;

  /// No description provided for @gifts_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Thoughtful gift recommendations powered by AI'**
  String get gifts_subtitle;

  /// No description provided for @gifts_findPerfectGift.
  ///
  /// In en, this message translates to:
  /// **'Find Perfect Gift'**
  String get gifts_findPerfectGift;

  /// No description provided for @gifts_recentGifts.
  ///
  /// In en, this message translates to:
  /// **'Recent Gift Ideas'**
  String get gifts_recentGifts;

  /// No description provided for @gifts_noGiftsYet.
  ///
  /// In en, this message translates to:
  /// **'No gift ideas yet'**
  String get gifts_noGiftsYet;

  /// No description provided for @gifts_noGiftsDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap above to get personalized gift recommendations'**
  String get gifts_noGiftsDesc;

  /// No description provided for @gifts_budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get gifts_budget;

  /// No description provided for @gifts_occasion.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get gifts_occasion;

  /// No description provided for @gifts_getRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Get Recommendations'**
  String get gifts_getRecommendations;

  /// No description provided for @giftDetail_title.
  ///
  /// In en, this message translates to:
  /// **'Gift Details'**
  String get giftDetail_title;

  /// No description provided for @giftDetail_whyThisGift.
  ///
  /// In en, this message translates to:
  /// **'Why this gift?'**
  String get giftDetail_whyThisGift;

  /// No description provided for @giftDetail_whereToBuy.
  ///
  /// In en, this message translates to:
  /// **'Where to buy'**
  String get giftDetail_whereToBuy;

  /// No description provided for @giftDetail_priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price range'**
  String get giftDetail_priceRange;

  /// No description provided for @giftDetail_saveGift.
  ///
  /// In en, this message translates to:
  /// **'Save Gift'**
  String get giftDetail_saveGift;

  /// No description provided for @giftDetail_markPurchased.
  ///
  /// In en, this message translates to:
  /// **'Mark as Purchased'**
  String get giftDetail_markPurchased;

  /// No description provided for @giftHistory_title.
  ///
  /// In en, this message translates to:
  /// **'Gift History'**
  String get giftHistory_title;

  /// No description provided for @giftHistory_purchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get giftHistory_purchased;

  /// No description provided for @giftHistory_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get giftHistory_saved;

  /// No description provided for @giftHistory_noHistory.
  ///
  /// In en, this message translates to:
  /// **'No gift history yet'**
  String get giftHistory_noHistory;

  /// No description provided for @memories_title.
  ///
  /// In en, this message translates to:
  /// **'Memory Vault'**
  String get memories_title;

  /// No description provided for @memories_addMemory.
  ///
  /// In en, this message translates to:
  /// **'Add Memory'**
  String get memories_addMemory;

  /// No description provided for @createMemory_title.
  ///
  /// In en, this message translates to:
  /// **'New Memory'**
  String get createMemory_title;

  /// No description provided for @createMemory_titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get createMemory_titleLabel;

  /// No description provided for @createMemory_titleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Our first date'**
  String get createMemory_titleHint;

  /// No description provided for @createMemory_dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get createMemory_dateLabel;

  /// No description provided for @createMemory_descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get createMemory_descriptionLabel;

  /// No description provided for @createMemory_descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'What made this moment special?'**
  String get createMemory_descriptionHint;

  /// No description provided for @createMemory_addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get createMemory_addPhoto;

  /// No description provided for @createMemory_moodLabel.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get createMemory_moodLabel;

  /// No description provided for @createMemory_tagsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get createMemory_tagsLabel;

  /// No description provided for @createMemory_tagsHint.
  ///
  /// In en, this message translates to:
  /// **'Add tags...'**
  String get createMemory_tagsHint;

  /// No description provided for @createMemory_save.
  ///
  /// In en, this message translates to:
  /// **'Save Memory'**
  String get createMemory_save;

  /// No description provided for @createMemory_saved.
  ///
  /// In en, this message translates to:
  /// **'Memory saved!'**
  String get createMemory_saved;

  /// No description provided for @memoryDetail_title.
  ///
  /// In en, this message translates to:
  /// **'Memory'**
  String get memoryDetail_title;

  /// No description provided for @memoryDetail_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete Memory'**
  String get memoryDetail_delete;

  /// No description provided for @memoryDetail_deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this memory?'**
  String get memoryDetail_deleteConfirm;

  /// No description provided for @wishlist_title.
  ///
  /// In en, this message translates to:
  /// **'Wish List'**
  String get wishlist_title;

  /// No description provided for @wishlist_addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get wishlist_addItem;

  /// No description provided for @wishlist_noItems.
  ///
  /// In en, this message translates to:
  /// **'No wish list items yet'**
  String get wishlist_noItems;

  /// No description provided for @wishlist_noItemsDesc.
  ///
  /// In en, this message translates to:
  /// **'Save things she mentions wanting'**
  String get wishlist_noItemsDesc;

  /// No description provided for @wishlist_itemName.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get wishlist_itemName;

  /// No description provided for @wishlist_itemNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get wishlist_itemNotes;

  /// No description provided for @wishlist_priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get wishlist_priority;

  /// No description provided for @wishlist_priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get wishlist_priorityLow;

  /// No description provided for @wishlist_priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get wishlist_priorityMedium;

  /// No description provided for @wishlist_priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get wishlist_priorityHigh;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settings_account;

  /// No description provided for @settings_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get settings_email;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get settings_pushNotifications;

  /// No description provided for @settings_reminderAlerts.
  ///
  /// In en, this message translates to:
  /// **'Reminder Alerts'**
  String get settings_reminderAlerts;

  /// No description provided for @settings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_themeSystem;

  /// No description provided for @settings_themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_themeDark;

  /// No description provided for @settings_themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_themeLight;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_data.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get settings_data;

  /// No description provided for @settings_exportData.
  ///
  /// In en, this message translates to:
  /// **'Export My Data'**
  String get settings_exportData;

  /// No description provided for @settings_deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settings_deleteAccount;

  /// No description provided for @settings_deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All your data will be permanently deleted.'**
  String get settings_deleteAccountConfirm;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_version;

  /// No description provided for @settings_termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settings_termsOfService;

  /// No description provided for @settings_privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settings_privacyPolicy;

  /// No description provided for @settings_logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settings_logOut;

  /// No description provided for @settings_logOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get settings_logOutConfirm;

  /// No description provided for @settings_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get settings_saving;

  /// No description provided for @settings_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved!'**
  String get settings_saved;

  /// No description provided for @notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_title;

  /// No description provided for @notifications_markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notifications_markAllRead;

  /// No description provided for @notifications_noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notifications_noNotifications;

  /// No description provided for @notifications_noNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get notifications_noNotificationsDesc;

  /// No description provided for @notifications_justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get notifications_justNow;

  /// No description provided for @notifications_minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String notifications_minutesAgo(int minutes);

  /// No description provided for @notifications_hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String notifications_hoursAgo(int hours);

  /// No description provided for @gamification_level.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String gamification_level(int level);

  /// No description provided for @gamification_totalXP.
  ///
  /// In en, this message translates to:
  /// **'Total XP'**
  String get gamification_totalXP;

  /// No description provided for @gamification_streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get gamification_streak;

  /// No description provided for @gamification_streakDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String gamification_streakDays(int days);

  /// No description provided for @gamification_weeklyProgress.
  ///
  /// In en, this message translates to:
  /// **'Weekly Progress'**
  String get gamification_weeklyProgress;

  /// No description provided for @gamification_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get gamification_achievements;

  /// No description provided for @gamification_recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get gamification_recentActivity;

  /// No description provided for @gamification_viewAllBadges.
  ///
  /// In en, this message translates to:
  /// **'View All Badges'**
  String get gamification_viewAllBadges;

  /// No description provided for @badges_title.
  ///
  /// In en, this message translates to:
  /// **'Badge Gallery'**
  String get badges_title;

  /// No description provided for @badges_earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get badges_earned;

  /// No description provided for @badges_locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get badges_locked;

  /// No description provided for @badges_progress.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total}'**
  String badges_progress(int current, int total);

  /// No description provided for @stats_title.
  ///
  /// In en, this message translates to:
  /// **'Stats & Trends'**
  String get stats_title;

  /// No description provided for @stats_thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get stats_thisWeek;

  /// No description provided for @stats_thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get stats_thisMonth;

  /// No description provided for @stats_allTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get stats_allTime;

  /// No description provided for @stats_messagesGenerated.
  ///
  /// In en, this message translates to:
  /// **'Messages Generated'**
  String get stats_messagesGenerated;

  /// No description provided for @stats_remindersCompleted.
  ///
  /// In en, this message translates to:
  /// **'Reminders Completed'**
  String get stats_remindersCompleted;

  /// No description provided for @stats_sosSessionsUsed.
  ///
  /// In en, this message translates to:
  /// **'SOS Sessions Used'**
  String get stats_sosSessionsUsed;

  /// No description provided for @stats_cardsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Cards Completed'**
  String get stats_cardsCompleted;

  /// No description provided for @stats_averageRating.
  ///
  /// In en, this message translates to:
  /// **'Average Rating'**
  String get stats_averageRating;

  /// No description provided for @paywall_subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get paywall_subscribe;

  /// No description provided for @paywall_mostPopular.
  ///
  /// In en, this message translates to:
  /// **'MOST POPULAR'**
  String get paywall_mostPopular;

  /// No description provided for @paywall_free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get paywall_free;

  /// No description provided for @paywall_pro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get paywall_pro;

  /// No description provided for @paywall_legend.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get paywall_legend;

  /// No description provided for @paywall_aiMessages.
  ///
  /// In en, this message translates to:
  /// **'AI Messages'**
  String get paywall_aiMessages;

  /// No description provided for @paywall_actionCards.
  ///
  /// In en, this message translates to:
  /// **'Action Cards'**
  String get paywall_actionCards;

  /// No description provided for @paywall_sosSessions.
  ///
  /// In en, this message translates to:
  /// **'SOS Sessions'**
  String get paywall_sosSessions;

  /// No description provided for @paywall_memoriesLimit.
  ///
  /// In en, this message translates to:
  /// **'Memories'**
  String get paywall_memoriesLimit;

  /// No description provided for @paywall_messageModes.
  ///
  /// In en, this message translates to:
  /// **'Message Modes'**
  String get paywall_messageModes;

  /// No description provided for @paywall_streakFreezes.
  ///
  /// In en, this message translates to:
  /// **'Streak Freezes'**
  String get paywall_streakFreezes;

  /// No description provided for @paywall_unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get paywall_unlimited;

  /// No description provided for @actionCard_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionCard_skip;

  /// No description provided for @actionCard_cardNotFound.
  ///
  /// In en, this message translates to:
  /// **'Card not found'**
  String get actionCard_cardNotFound;

  /// No description provided for @actionCard_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionCard_save;

  /// No description provided for @herProfile_birthday.
  ///
  /// In en, this message translates to:
  /// **'Her Birthday'**
  String get herProfile_birthday;

  /// No description provided for @herProfile_birthdaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set her birthday for age-aware messages'**
  String get herProfile_birthdaySubtitle;

  /// No description provided for @herProfile_birthdayFormat.
  ///
  /// In en, this message translates to:
  /// **'{month} {day}, {year} ({age} years old)'**
  String herProfile_birthdayFormat(String month, int day, int year, int age);

  /// No description provided for @herProfile_selectBirthday.
  ///
  /// In en, this message translates to:
  /// **'Select her birthday'**
  String get herProfile_selectBirthday;

  /// No description provided for @herProfile_nationality.
  ///
  /// In en, this message translates to:
  /// **'Her Nationality'**
  String get herProfile_nationality;

  /// No description provided for @herProfile_nationalitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set her nationality for culturally personalized messages'**
  String get herProfile_nationalitySubtitle;

  /// No description provided for @herProfile_anniversary.
  ///
  /// In en, this message translates to:
  /// **'Anniversary'**
  String get herProfile_anniversary;

  /// No description provided for @herProfile_anniversarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set your anniversary date'**
  String get herProfile_anniversarySubtitle;

  /// No description provided for @herProfile_selectAnniversary.
  ///
  /// In en, this message translates to:
  /// **'Select your anniversary'**
  String get herProfile_selectAnniversary;

  /// No description provided for @herProfile_quickFacts.
  ///
  /// In en, this message translates to:
  /// **'QUICK FACTS'**
  String get herProfile_quickFacts;

  /// No description provided for @herProfile_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get herProfile_status;

  /// No description provided for @herProfile_zodiac.
  ///
  /// In en, this message translates to:
  /// **'Zodiac'**
  String get herProfile_zodiac;

  /// No description provided for @herProfile_background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get herProfile_background;

  /// No description provided for @preferences_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get preferences_saving;

  /// No description provided for @preferences_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved!'**
  String get preferences_saved;

  /// No description provided for @cultural_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get cultural_saving;

  /// No description provided for @cultural_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved!'**
  String get cultural_saved;

  /// No description provided for @createMemory_photoComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Photo upload coming soon!'**
  String get createMemory_photoComingSoon;

  /// No description provided for @createMemory_addPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add photos'**
  String get createMemory_addPhotos;

  /// No description provided for @createMemory_saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Memory'**
  String get createMemory_saveButton;

  /// No description provided for @sos_howUrgent.
  ///
  /// In en, this message translates to:
  /// **'How urgent is this?'**
  String get sos_howUrgent;

  /// No description provided for @sos_urgency_happeningNow.
  ///
  /// In en, this message translates to:
  /// **'Happening NOW'**
  String get sos_urgency_happeningNow;

  /// No description provided for @sos_urgency_justHappened.
  ///
  /// In en, this message translates to:
  /// **'Just Happened'**
  String get sos_urgency_justHappened;

  /// No description provided for @sos_urgency_brewing.
  ///
  /// In en, this message translates to:
  /// **'Brewing / Building Up'**
  String get sos_urgency_brewing;

  /// No description provided for @sos_assessmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Assessment'**
  String get sos_assessmentTitle;

  /// No description provided for @sos_doThisRightNow.
  ///
  /// In en, this message translates to:
  /// **'Do This Right Now'**
  String get sos_doThisRightNow;

  /// No description provided for @sos_dontDoThis.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Do This'**
  String get sos_dontDoThis;

  /// No description provided for @sos_howLongAgo.
  ///
  /// In en, this message translates to:
  /// **'How long ago did this start?'**
  String get sos_howLongAgo;

  /// No description provided for @sos_time_rightNow.
  ///
  /// In en, this message translates to:
  /// **'Right now'**
  String get sos_time_rightNow;

  /// No description provided for @sos_time_fewMinutes.
  ///
  /// In en, this message translates to:
  /// **'A few minutes ago'**
  String get sos_time_fewMinutes;

  /// No description provided for @sos_time_withinHour.
  ///
  /// In en, this message translates to:
  /// **'Within the hour'**
  String get sos_time_withinHour;

  /// No description provided for @sos_time_earlierToday.
  ///
  /// In en, this message translates to:
  /// **'Earlier today'**
  String get sos_time_earlierToday;

  /// No description provided for @sos_time_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get sos_time_yesterday;

  /// No description provided for @sos_herCurrentState.
  ///
  /// In en, this message translates to:
  /// **'Her current state?'**
  String get sos_herCurrentState;

  /// No description provided for @sos_state_yelling.
  ///
  /// In en, this message translates to:
  /// **'Yelling / Furious'**
  String get sos_state_yelling;

  /// No description provided for @sos_state_crying.
  ///
  /// In en, this message translates to:
  /// **'Crying'**
  String get sos_state_crying;

  /// No description provided for @sos_state_coldSilent.
  ///
  /// In en, this message translates to:
  /// **'Cold & Silent'**
  String get sos_state_coldSilent;

  /// No description provided for @sos_state_disappointed.
  ///
  /// In en, this message translates to:
  /// **'Disappointed'**
  String get sos_state_disappointed;

  /// No description provided for @sos_state_confused.
  ///
  /// In en, this message translates to:
  /// **'Confused'**
  String get sos_state_confused;

  /// No description provided for @sos_state_hurt.
  ///
  /// In en, this message translates to:
  /// **'Hurt'**
  String get sos_state_hurt;

  /// No description provided for @sos_state_calmUpset.
  ///
  /// In en, this message translates to:
  /// **'Calm but upset'**
  String get sos_state_calmUpset;

  /// No description provided for @sos_myFault.
  ///
  /// In en, this message translates to:
  /// **'This might be my fault'**
  String get sos_myFault;

  /// No description provided for @sos_brieflyWhatHappened.
  ///
  /// In en, this message translates to:
  /// **'Briefly, what happened?'**
  String get sos_brieflyWhatHappened;

  /// No description provided for @sos_whatHappenedHint.
  ///
  /// In en, this message translates to:
  /// **'E.g. I forgot our anniversary and she found out...'**
  String get sos_whatHappenedHint;

  /// No description provided for @sos_startCoaching.
  ///
  /// In en, this message translates to:
  /// **'Start Coaching'**
  String get sos_startCoaching;

  /// No description provided for @sos_liveCoaching.
  ///
  /// In en, this message translates to:
  /// **'Live Coaching'**
  String get sos_liveCoaching;

  /// No description provided for @sos_analyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing situation...'**
  String get sos_analyzing;

  /// No description provided for @sos_whyThisWorks.
  ///
  /// In en, this message translates to:
  /// **'Why this works'**
  String get sos_whyThisWorks;

  /// No description provided for @sos_bodyLanguage.
  ///
  /// In en, this message translates to:
  /// **'Body Language'**
  String get sos_bodyLanguage;

  /// No description provided for @sos_waitFor.
  ///
  /// In en, this message translates to:
  /// **'Wait for: {text}'**
  String sos_waitFor(String text);

  /// No description provided for @sos_finishCoaching.
  ///
  /// In en, this message translates to:
  /// **'Finish Coaching'**
  String get sos_finishCoaching;

  /// No description provided for @sos_coachingComplete.
  ///
  /// In en, this message translates to:
  /// **'Coaching Complete'**
  String get sos_coachingComplete;

  /// No description provided for @sos_situationResult.
  ///
  /// In en, this message translates to:
  /// **'How did the situation turn out?'**
  String get sos_situationResult;

  /// No description provided for @sos_rateSession.
  ///
  /// In en, this message translates to:
  /// **'Rate this coaching session'**
  String get sos_rateSession;

  /// No description provided for @sos_resolutionNotes.
  ///
  /// In en, this message translates to:
  /// **'Resolution notes (optional)'**
  String get sos_resolutionNotes;

  /// No description provided for @sos_resolutionHint.
  ///
  /// In en, this message translates to:
  /// **'How did she respond? What worked? What would you do differently?'**
  String get sos_resolutionHint;

  /// No description provided for @sos_saveToMemoryVault.
  ///
  /// In en, this message translates to:
  /// **'Save to Memory Vault'**
  String get sos_saveToMemoryVault;

  /// No description provided for @sos_saveToMemoryVaultDesc.
  ///
  /// In en, this message translates to:
  /// **'Remember what you learned for next time'**
  String get sos_saveToMemoryVaultDesc;

  /// No description provided for @sos_completeButton.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get sos_completeButton;

  /// No description provided for @sos_sessionSaved.
  ///
  /// In en, this message translates to:
  /// **'SOS session saved. Stay strong!'**
  String get sos_sessionSaved;

  /// No description provided for @gifts_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get gifts_screenTitle;

  /// No description provided for @gifts_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search gifts...'**
  String get gifts_searchHint;

  /// No description provided for @gifts_whatsOccasion.
  ///
  /// In en, this message translates to:
  /// **'What\'s the occasion?'**
  String get gifts_whatsOccasion;

  /// No description provided for @gifts_occasion_justBecause.
  ///
  /// In en, this message translates to:
  /// **'Just Because'**
  String get gifts_occasion_justBecause;

  /// No description provided for @gifts_occasion_birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get gifts_occasion_birthday;

  /// No description provided for @gifts_occasion_anniversary.
  ///
  /// In en, this message translates to:
  /// **'Anniversary'**
  String get gifts_occasion_anniversary;

  /// No description provided for @gifts_occasion_apology.
  ///
  /// In en, this message translates to:
  /// **'Apology'**
  String get gifts_occasion_apology;

  /// No description provided for @gifts_occasion_valentines.
  ///
  /// In en, this message translates to:
  /// **'Valentine\'s Day'**
  String get gifts_occasion_valentines;

  /// No description provided for @gifts_occasion_eidHoliday.
  ///
  /// In en, this message translates to:
  /// **'Eid / Holiday'**
  String get gifts_occasion_eidHoliday;

  /// No description provided for @gifts_generatingIdeas.
  ///
  /// In en, this message translates to:
  /// **'Generating AI gift ideas...'**
  String get gifts_generatingIdeas;

  /// No description provided for @gifts_noGiftsFound.
  ///
  /// In en, this message translates to:
  /// **'No gifts found'**
  String get gifts_noGiftsFound;

  /// No description provided for @gifts_adjustFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or search.'**
  String get gifts_adjustFilters;

  /// No description provided for @gifts_lowBudget.
  ///
  /// In en, this message translates to:
  /// **'Low Budget High Impact'**
  String get gifts_lowBudget;

  /// No description provided for @gifts_getAiRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Get AI Recommendations'**
  String get gifts_getAiRecommendations;

  /// No description provided for @giftDetail_whySheLoveIt.
  ///
  /// In en, this message translates to:
  /// **'Why She\'ll Love It'**
  String get giftDetail_whySheLoveIt;

  /// No description provided for @giftDetail_basedOnProfile.
  ///
  /// In en, this message translates to:
  /// **'Based on Her Profile'**
  String get giftDetail_basedOnProfile;

  /// No description provided for @giftDetail_buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get giftDetail_buyNow;

  /// No description provided for @giftDetail_unsave.
  ///
  /// In en, this message translates to:
  /// **'Unsave'**
  String get giftDetail_unsave;

  /// No description provided for @giftDetail_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get giftDetail_save;

  /// No description provided for @giftDetail_notRight.
  ///
  /// In en, this message translates to:
  /// **'Not right for her'**
  String get giftDetail_notRight;

  /// No description provided for @giftDetail_relatedGifts.
  ///
  /// In en, this message translates to:
  /// **'Related Gifts'**
  String get giftDetail_relatedGifts;

  /// No description provided for @giftHistory_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get giftHistory_all;

  /// No description provided for @giftHistory_liked.
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get giftHistory_liked;

  /// No description provided for @giftHistory_didntLike.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t Like'**
  String get giftHistory_didntLike;

  /// No description provided for @giftHistory_noHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Browse gifts and get recommendations to build your history.'**
  String get giftHistory_noHistoryDesc;

  /// No description provided for @memories_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search memories...'**
  String get memories_searchHint;

  /// No description provided for @memories_listView.
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get memories_listView;

  /// No description provided for @memories_gridView.
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get memories_gridView;

  /// No description provided for @memories_noMemories.
  ///
  /// In en, this message translates to:
  /// **'No memories yet'**
  String get memories_noMemories;

  /// No description provided for @memories_noMemoriesDesc.
  ///
  /// In en, this message translates to:
  /// **'Start capturing your special moments together'**
  String get memories_noMemoriesDesc;

  /// No description provided for @memoryDetail_photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get memoryDetail_photos;

  /// No description provided for @memoryDetail_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get memoryDetail_tags;

  /// No description provided for @wishlist_noWishes.
  ///
  /// In en, this message translates to:
  /// **'No wishes captured yet'**
  String get wishlist_noWishes;

  /// No description provided for @wishlist_noWishesDesc.
  ///
  /// In en, this message translates to:
  /// **'When she mentions something she wants, save it with the \'She Said\' toggle.'**
  String get wishlist_noWishesDesc;

  /// No description provided for @wishlist_sendToGiftEngine.
  ///
  /// In en, this message translates to:
  /// **'Send to Gift Engine'**
  String get wishlist_sendToGiftEngine;

  /// No description provided for @wishlist_sentToGiftEngine.
  ///
  /// In en, this message translates to:
  /// **'Sent \"{title}\" to Gift Engine'**
  String wishlist_sentToGiftEngine(String title);

  /// No description provided for @wishlist_sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest First'**
  String get wishlist_sortNewest;

  /// No description provided for @wishlist_sortOccasion.
  ///
  /// In en, this message translates to:
  /// **'By Occasion Proximity'**
  String get wishlist_sortOccasion;

  /// No description provided for @wishlist_statusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get wishlist_statusNew;

  /// No description provided for @wishlist_statusSentToGifts.
  ///
  /// In en, this message translates to:
  /// **'Sent to Gifts'**
  String get wishlist_statusSentToGifts;

  /// No description provided for @wishlist_statusFulfilled.
  ///
  /// In en, this message translates to:
  /// **'Fulfilled'**
  String get wishlist_statusFulfilled;

  /// No description provided for @wishlist_sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get wishlist_sort;

  /// No description provided for @settings_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settings_profile;

  /// No description provided for @settings_receiveNotifications.
  ///
  /// In en, this message translates to:
  /// **'Receive push notifications'**
  String get settings_receiveNotifications;

  /// No description provided for @settings_reminderAlertsDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified about upcoming dates'**
  String get settings_reminderAlertsDesc;

  /// No description provided for @settings_dailyActionCards.
  ///
  /// In en, this message translates to:
  /// **'Daily Action Cards'**
  String get settings_dailyActionCards;

  /// No description provided for @settings_dailyActionCardsDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily relationship tips and actions'**
  String get settings_dailyActionCardsDesc;

  /// No description provided for @settings_weeklyDigest.
  ///
  /// In en, this message translates to:
  /// **'Weekly Digest'**
  String get settings_weeklyDigest;

  /// No description provided for @settings_weeklyDigestDesc.
  ///
  /// In en, this message translates to:
  /// **'Weekly relationship summary'**
  String get settings_weeklyDigestDesc;

  /// No description provided for @settings_subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settings_subscription;

  /// No description provided for @settings_premiumActive.
  ///
  /// In en, this message translates to:
  /// **'Premium Active'**
  String get settings_premiumActive;

  /// No description provided for @settings_upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get settings_upgradeToPremium;

  /// No description provided for @settings_manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage your subscription'**
  String get settings_manageSubscription;

  /// No description provided for @settings_unlockAllFeatures.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features'**
  String get settings_unlockAllFeatures;

  /// No description provided for @settings_aboutLolo.
  ///
  /// In en, this message translates to:
  /// **'About LOLO'**
  String get settings_aboutLolo;

  /// No description provided for @settings_logOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settings_logOutTitle;

  /// No description provided for @settings_deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settings_deleteAccountTitle;

  /// No description provided for @settings_deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and cannot be undone. All your data will be deleted.'**
  String get settings_deleteAccountMessage;

  /// No description provided for @settings_appVersion.
  ///
  /// In en, this message translates to:
  /// **'LOLO v{version}'**
  String settings_appVersion(String version);

  /// No description provided for @notifications_loadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load notifications.'**
  String get notifications_loadError;

  /// No description provided for @notifications_noNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll keep you posted!'**
  String get notifications_noNotificationsSubtitle;

  /// No description provided for @notifications_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notifications_today;

  /// No description provided for @notifications_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notifications_yesterday;

  /// No description provided for @notifications_earlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notifications_earlier;

  /// No description provided for @gamification_weeklyActivity.
  ///
  /// In en, this message translates to:
  /// **'Weekly Activity'**
  String get gamification_weeklyActivity;

  /// No description provided for @gamification_viewStats.
  ///
  /// In en, this message translates to:
  /// **'View Stats'**
  String get gamification_viewStats;

  /// No description provided for @gamification_seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get gamification_seeAll;

  /// No description provided for @gamification_dayStreak.
  ///
  /// In en, this message translates to:
  /// **'{days} day streak'**
  String gamification_dayStreak(int days);

  /// No description provided for @gamification_bestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best: {days} days'**
  String gamification_bestStreak(int days);

  /// No description provided for @gamification_xpTotal.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP total'**
  String gamification_xpTotal(int xp);

  /// No description provided for @gamification_freezes.
  ///
  /// In en, this message translates to:
  /// **'freezes'**
  String get gamification_freezes;

  /// No description provided for @gamification_useFreezeTitle.
  ///
  /// In en, this message translates to:
  /// **'Use Streak Freeze?'**
  String get gamification_useFreezeTitle;

  /// No description provided for @gamification_useFreezeMessage.
  ///
  /// In en, this message translates to:
  /// **'This will protect your streak for one missed day. You cannot undo this action.'**
  String get gamification_useFreezeMessage;

  /// No description provided for @gamification_useFreeze.
  ///
  /// In en, this message translates to:
  /// **'Use Freeze'**
  String get gamification_useFreeze;

  /// No description provided for @gamification_freezeApplied.
  ///
  /// In en, this message translates to:
  /// **'Streak freeze applied!'**
  String get gamification_freezeApplied;

  /// No description provided for @gamification_leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get gamification_leaderboard;

  /// No description provided for @badges_noBadges.
  ///
  /// In en, this message translates to:
  /// **'No badges yet'**
  String get badges_noBadges;

  /// No description provided for @badges_noBadgesDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first action to start earning badges!'**
  String get badges_noBadgesDesc;

  /// No description provided for @badges_category_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get badges_category_all;

  /// No description provided for @badges_category_consistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get badges_category_consistency;

  /// No description provided for @badges_category_milestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get badges_category_milestones;

  /// No description provided for @badges_category_mastery.
  ///
  /// In en, this message translates to:
  /// **'Mastery'**
  String get badges_category_mastery;

  /// No description provided for @badges_category_special.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get badges_category_special;

  /// No description provided for @badges_earnedDate.
  ///
  /// In en, this message translates to:
  /// **'Earned {date}'**
  String badges_earnedDate(String date);

  /// No description provided for @stats_activityOverTime.
  ///
  /// In en, this message translates to:
  /// **'Activity Over Time'**
  String get stats_activityOverTime;

  /// No description provided for @stats_actionBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Action Breakdown'**
  String get stats_actionBreakdown;

  /// No description provided for @stats_personalBests.
  ///
  /// In en, this message translates to:
  /// **'Personal Bests'**
  String get stats_personalBests;

  /// No description provided for @stats_aiInsight.
  ///
  /// In en, this message translates to:
  /// **'AI Insight'**
  String get stats_aiInsight;

  /// No description provided for @stats_noActivity.
  ///
  /// In en, this message translates to:
  /// **'No activity for this period.\nStart by completing an action today!'**
  String get stats_noActivity;

  /// No description provided for @stats_highestStreak.
  ///
  /// In en, this message translates to:
  /// **'Highest\nStreak'**
  String get stats_highestStreak;

  /// No description provided for @stats_mostActiveWeek.
  ///
  /// In en, this message translates to:
  /// **'Most Active\nWeek'**
  String get stats_mostActiveWeek;

  /// No description provided for @stats_favoriteAction.
  ///
  /// In en, this message translates to:
  /// **'Favorite\nAction'**
  String get stats_favoriteAction;

  /// No description provided for @stats_week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get stats_week;

  /// No description provided for @stats_month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get stats_month;
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
