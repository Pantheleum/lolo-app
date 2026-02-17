import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'LOLO';

  @override
  String get common_button_continue => 'متابعة';

  @override
  String get common_button_back => 'رجوع';

  @override
  String get common_button_skip => 'تخطي';

  @override
  String get common_button_save => 'حفظ';

  @override
  String get common_button_cancel => 'إلغاء';

  @override
  String get common_button_delete => 'حذف';

  @override
  String get common_button_done => 'تم';

  @override
  String get common_button_retry => 'إعادة المحاولة';

  @override
  String get common_button_close => 'إغلاق';

  @override
  String get common_button_confirm => 'تأكيد';

  @override
  String get common_button_edit => 'تعديل';

  @override
  String get common_button_copy => 'نسخ';

  @override
  String get common_button_share => 'مشاركة';

  @override
  String get common_label_loading => 'جاري التحميل...';

  @override
  String get common_label_offline => 'أنت غير متصل. عرض البيانات المخزنة.';

  @override
  String common_label_lastUpdated(String time) {
    return 'آخر تحديث $time';
  }

  @override
  String get error_generic => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get error_network => 'لا يوجد اتصال بالإنترنت. تحقق من شبكتك.';

  @override
  String get error_timeout => 'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.';

  @override
  String get error_server => 'خطأ في الخادم. نحن نعمل على حله.';

  @override
  String get error_unauthorized => 'انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get error_rate_limited => 'طلبات كثيرة جداً. يرجى الانتظار لحظة.';

  @override
  String get error_tier_exceeded => 'قم بترقية خطتك لفتح هذه الميزة.';

  @override
  String get nav_home => 'الرئيسية';

  @override
  String get nav_reminders => 'التذكيرات';

  @override
  String get nav_messages => 'الرسائل';

  @override
  String get nav_gifts => 'الهدايا';

  @override
  String get nav_more => 'المزيد';

  @override
  String get empty_reminders_title => 'لا توجد تذكيرات بعد';

  @override
  String get empty_reminders_subtitle => 'أضف التواريخ المهمة حتى لا تنسى';

  @override
  String get empty_messages_title => 'لا توجد رسائل بعد';

  @override
  String get empty_messages_subtitle => 'أنشئ أول رسالة ذكية';

  @override
  String get empty_memories_title => 'لا توجد ذكريات بعد';

  @override
  String get empty_memories_subtitle => 'ابدأ بحفظ اللحظات المهمة';

  @override
  String get onboarding_language_title => 'اختر لغتك';

  @override
  String get onboarding_language_english => 'English';

  @override
  String get onboarding_language_arabic => 'العربية';

  @override
  String get onboarding_language_malay => 'Bahasa Melayu';

  @override
  String get onboarding_welcome_tagline => 'لن تعرف لماذا أصبحت أكثر اهتماماً.\nلن نخبرها.';

  @override
  String get onboarding_welcome_benefit1_title => 'تذكيرات ذكية';

  @override
  String get onboarding_welcome_benefit1_subtitle => 'لا تنسَ ما يهمها أبداً';

  @override
  String get onboarding_welcome_benefit2_title => 'رسائل ذكية';

  @override
  String get onboarding_welcome_benefit2_subtitle => 'قل الشيء الصحيح، في كل مرة';

  @override
  String get onboarding_welcome_benefit3_title => 'وضع الطوارئ';

  @override
  String get onboarding_welcome_benefit3_subtitle => 'مساعدة فورية عندما تكون منزعجة';

  @override
  String get onboarding_welcome_button_start => 'ابدأ الآن';

  @override
  String get onboarding_welcome_link_login => 'لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get onboarding_signup_title => 'إنشاء حساب';

  @override
  String get onboarding_signup_heading => 'أنشئ حسابك';

  @override
  String get onboarding_signup_button_google => 'المتابعة مع Google';

  @override
  String get onboarding_signup_button_apple => 'المتابعة مع Apple';

  @override
  String get onboarding_signup_divider => 'أو';

  @override
  String get onboarding_signup_label_email => 'البريد الإلكتروني';

  @override
  String get onboarding_signup_hint_email => 'you@example.com';

  @override
  String get onboarding_signup_label_password => 'كلمة المرور';

  @override
  String get onboarding_signup_label_confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get onboarding_signup_button_create => 'إنشاء حساب';

  @override
  String onboarding_signup_legal(String terms, String privacy) {
    return 'بالتسجيل أنت توافق على $terms و$privacy';
  }

  @override
  String get onboarding_signup_legal_terms => 'شروط الخدمة';

  @override
  String get onboarding_signup_legal_privacy => 'سياسة الخصوصية';

  @override
  String get onboarding_signup_error_emailInUse => 'هذا البريد الإلكتروني مسجل بالفعل.';

  @override
  String get onboarding_signup_error_invalidEmail => 'يرجى إدخال بريد إلكتروني صالح.';

  @override
  String get onboarding_signup_error_weakPassword => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل.';

  @override
  String get onboarding_signup_error_networkFailed => 'خطأ في الشبكة. تحقق من اتصالك.';

  @override
  String get onboarding_signup_error_generic => 'فشلت المصادقة. يرجى المحاولة مرة أخرى.';

  @override
  String get onboarding_login_title => 'تسجيل الدخول';

  @override
  String get onboarding_login_heading => 'مرحباً بعودتك';

  @override
  String get onboarding_login_button_login => 'تسجيل الدخول';

  @override
  String get onboarding_login_link_forgot => 'نسيت كلمة المرور؟';

  @override
  String get onboarding_login_link_signup => 'ليس لديك حساب؟ سجّل الآن';

  @override
  String get onboarding_name_title => 'ماذا نناديك؟';

  @override
  String get onboarding_name_hint => 'اسمك';

  @override
  String get onboarding_name_error_min => 'يرجى إدخال حرفين على الأقل';

  @override
  String get onboarding_partner_title => 'من هي المميزة؟';

  @override
  String get onboarding_partner_hint => 'اسمها';

  @override
  String get onboarding_partner_label_zodiac => 'برجها (اختياري)';

  @override
  String get onboarding_partner_label_zodiacUnknown => 'لا أعرف برجها';

  @override
  String get onboarding_partner_label_status => 'حالة العلاقة';

  @override
  String get onboarding_partner_error_name => 'يرجى إدخال اسمها';

  @override
  String get onboarding_status_dating => 'مواعدة';

  @override
  String get onboarding_status_engaged => 'خطوبة';

  @override
  String get onboarding_status_newlywed => 'عروسان جدد';

  @override
  String get onboarding_status_married => 'متزوجان';

  @override
  String get onboarding_status_longDistance => 'علاقة عن بعد';

  @override
  String get onboarding_anniversary_title => 'متى بدأت قصتكما؟';

  @override
  String get onboarding_anniversary_label_dating => 'ذكرى المواعدة';

  @override
  String get onboarding_anniversary_label_wedding => 'تاريخ الزفاف';

  @override
  String get onboarding_anniversary_select_date => 'اختر تاريخاً';

  @override
  String onboarding_firstCard_title(String partnerName) {
    return 'أول بطاقة ذكية لـ $partnerName';
  }

  @override
  String onboarding_firstCard_personalized(String partnerName) {
    return 'مخصصة لـ $partnerName';
  }

  @override
  String get profile_title => 'ملفها الشخصي';

  @override
  String profile_completion(int percent) {
    return 'مكتمل $percent%';
  }

  @override
  String get profile_nav_zodiac => 'البرج والصفات';

  @override
  String get profile_nav_zodiac_empty => 'لم يتم التحديد بعد';

  @override
  String get profile_nav_preferences => 'التفضيلات';

  @override
  String profile_nav_preferences_subtitle(int count) {
    return '$count عنصر مسجل';
  }

  @override
  String get profile_nav_cultural => 'السياق الثقافي';

  @override
  String get profile_nav_cultural_empty => 'لم يتم التحديد بعد';

  @override
  String get profile_edit_title => 'تعديل الملف';

  @override
  String get profile_edit_zodiac_traits => 'صفات البرج';

  @override
  String get profile_edit_loveLanguage => 'لغة حبها';

  @override
  String get profile_edit_commStyle => 'أسلوب التواصل';

  @override
  String get profile_edit_conflictStyle => 'أسلوب التعامل مع الخلافات';

  @override
  String get profile_edit_loveLanguage_words => 'كلمات التشجيع';

  @override
  String get profile_edit_loveLanguage_acts => 'أفعال الخدمة';

  @override
  String get profile_edit_loveLanguage_gifts => 'تلقي الهدايا';

  @override
  String get profile_edit_loveLanguage_time => 'وقت مميز معاً';

  @override
  String get profile_edit_loveLanguage_touch => 'التواصل الجسدي';

  @override
  String get profile_edit_commStyle_direct => 'مباشر';

  @override
  String get profile_edit_commStyle_indirect => 'غير مباشر';

  @override
  String get profile_edit_commStyle_mixed => 'مختلط';

  @override
  String get profile_preferences_title => 'تفضيلاتها';

  @override
  String get profile_preferences_favorites => 'المفضلات';

  @override
  String profile_preferences_add_hint(String category) {
    return 'أضف $category...';
  }

  @override
  String get profile_preferences_hobbies => 'الهوايات والاهتمامات';

  @override
  String get profile_preferences_dislikes => 'الأشياء التي لا تحبها';

  @override
  String get profile_preferences_category_flowers => 'زهور';

  @override
  String get profile_preferences_category_food => 'طعام';

  @override
  String get profile_preferences_category_music => 'موسيقى';

  @override
  String get profile_preferences_category_movies => 'أفلام';

  @override
  String get profile_preferences_category_brands => 'ماركات';

  @override
  String get profile_preferences_category_colors => 'ألوان';

  @override
  String get profile_cultural_title => 'السياق الثقافي';

  @override
  String get profile_cultural_background => 'الخلفية الثقافية';

  @override
  String get profile_cultural_background_hint => 'اختر الخلفية';

  @override
  String get profile_cultural_observance => 'الالتزام الديني';

  @override
  String get profile_cultural_dialect => 'اللهجة العربية';

  @override
  String get profile_cultural_dialect_hint => 'اختر اللهجة';

  @override
  String get profile_cultural_info => 'هذا يساعد LOLO في تخصيص المحتوى، وتصفية الاقتراحات غير المناسبة، وإضافة المناسبات تلقائياً.';

  @override
  String get profile_cultural_bg_gulf => 'خليجي';

  @override
  String get profile_cultural_bg_levantine => 'شامي';

  @override
  String get profile_cultural_bg_egyptian => 'مصري';

  @override
  String get profile_cultural_bg_northAfrican => 'شمال أفريقي';

  @override
  String get profile_cultural_bg_malay => 'ماليزي/ملايو';

  @override
  String get profile_cultural_bg_western => 'غربي';

  @override
  String get profile_cultural_bg_southAsian => 'جنوب آسيوي';

  @override
  String get profile_cultural_bg_eastAsian => 'شرق آسيوي';

  @override
  String get profile_cultural_bg_other => 'أخرى';

  @override
  String get profile_cultural_obs_high => 'عالي -- يلتزم بجميع الممارسات الدينية';

  @override
  String get profile_cultural_obs_moderate => 'متوسط -- يلتزم بالممارسات الرئيسية';

  @override
  String get profile_cultural_obs_low => 'منخفض -- مرتبط ثقافياً';

  @override
  String get profile_cultural_obs_secular => 'علماني';

  @override
  String get reminders_title => 'التذكيرات';

  @override
  String get reminders_view_list => 'عرض القائمة';

  @override
  String get reminders_view_calendar => 'عرض التقويم';

  @override
  String get reminders_section_overdue => 'متأخرة';

  @override
  String get reminders_section_upcoming => 'قادمة';

  @override
  String get reminders_create_title => 'تذكير جديد';

  @override
  String get reminders_create_label_title => 'العنوان';

  @override
  String get reminders_create_hint_title => 'مثلاً: عيد ميلادها';

  @override
  String get reminders_create_label_category => 'الفئة';

  @override
  String get reminders_create_label_date => 'التاريخ';

  @override
  String get reminders_create_label_time => 'الوقت (اختياري)';

  @override
  String get reminders_create_label_recurrence => 'التكرار';

  @override
  String get reminders_create_label_notes => 'ملاحظات (اختياري)';

  @override
  String get reminders_create_hint_notes => 'أضف أي تفاصيل إضافية...';

  @override
  String get reminders_create_button_save => 'إنشاء تذكير';

  @override
  String get reminders_create_recurrence_none => 'بدون تكرار';

  @override
  String get reminders_create_recurrence_weekly => 'أسبوعياً';

  @override
  String get reminders_create_recurrence_monthly => 'شهرياً';

  @override
  String get reminders_create_recurrence_yearly => 'سنوياً';

  @override
  String get reminders_create_category_birthday => 'عيد ميلاد';

  @override
  String get reminders_create_category_anniversary => 'ذكرى سنوية';

  @override
  String get reminders_create_category_islamic => 'عيد إسلامي';

  @override
  String get reminders_create_category_cultural => 'ثقافي';

  @override
  String get reminders_create_category_custom => 'مخصص';

  @override
  String get reminders_create_category_promise => 'وعد';

  @override
  String get reminders_create_error_title => 'العنوان مطلوب';

  @override
  String get reminders_create_error_date => 'يرجى اختيار تاريخ';

  @override
  String get reminders_create_error_pastDate => 'لا يمكن أن يكون تاريخ التذكير في الماضي';

  @override
  String get reminders_detail_title => 'تفاصيل التذكير';

  @override
  String get reminders_detail_date => 'التاريخ';

  @override
  String get reminders_detail_time => 'الوقت';

  @override
  String get reminders_detail_daysUntil => 'أيام متبقية';

  @override
  String get reminders_detail_recurrence => 'يتكرر';

  @override
  String get reminders_detail_notes => 'ملاحظات';

  @override
  String get reminders_detail_button_complete => 'تم الإنجاز';

  @override
  String get reminders_detail_button_snooze => 'تأجيل';

  @override
  String get reminders_detail_completed => 'مكتمل';

  @override
  String reminders_detail_overdue(int days) {
    return 'متأخر $days يوم';
  }

  @override
  String reminders_detail_inDays(int days) {
    return 'بعد $days يوم';
  }

  @override
  String get reminders_detail_today => 'اليوم';

  @override
  String get reminders_snooze_title => 'تأجيل لمدة...';

  @override
  String get reminders_snooze_1h => 'ساعة واحدة';

  @override
  String get reminders_snooze_3h => '3 ساعات';

  @override
  String get reminders_snooze_1d => 'يوم واحد';

  @override
  String get reminders_snooze_3d => '3 أيام';

  @override
  String get reminders_snooze_1w => 'أسبوع واحد';

  @override
  String get reminders_delete_title => 'حذف التذكير';

  @override
  String get reminders_delete_message => 'سيتم حذف هذا التذكير نهائياً وإلغاء جميع إشعاراته. هل أنت متأكد؟';

  @override
  String get reminders_notification_today => 'اليوم هو اليوم!';

  @override
  String reminders_notification_daysUntil(int days, String title) {
    return 'باقي $days يوم على $title';
  }

  @override
  String reminders_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تذكير',
      many: '$count تذكيرًا',
      few: '$count تذكيرات',
      two: 'تذكيران',
      one: 'تذكير واحد',
      zero: 'لا تذكيرات',
    );
    return '$_temp0';
  }

  @override
  String profile_items_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر',
      many: '$count عنصرًا',
      few: '$count عناصر',
      two: 'عنصران',
      one: 'عنصر واحد',
      zero: 'لا عناصر',
    );
    return '$_temp0';
  }

  @override
  String days_remaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'بعد $count يوم',
      many: 'بعد $count يومًا',
      few: 'بعد $count أيام',
      two: 'بعد يومين',
      one: 'غدًا',
      zero: 'اليوم',
    );
    return '$_temp0';
  }

  @override
  String get actionCardsTitle => 'المهام اليومية';

  @override
  String get allCardsDone => 'أنجزت كل شيء اليوم!';

  @override
  String get allCardsDoneSubtitle => 'عد غدًا لأفكار جديدة';

  @override
  String get whatToDo => 'ماذا تفعل';

  @override
  String get howDidItGo => 'كيف سارت الأمور؟';

  @override
  String get optionalNotes => 'أضف ملاحظات (اختياري)';

  @override
  String get markComplete => 'تم الإنجاز';

  @override
  String get gamification => 'التقدم';

  @override
  String get badges => 'الشارات';

  @override
  String get sosTitle => 'وضع الطوارئ';

  @override
  String get sosSubtitle => 'مساعدة عاجلة عندما تكون منزعجة';

  @override
  String get getHelp => 'احصل على المساعدة';

  @override
  String get assessment => 'التقييم';

  @override
  String get back => 'رجوع';

  @override
  String get coaching => 'التوجيه';

  @override
  String stepProgress(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get sayThis => 'قل هذا';

  @override
  String get dontSay => 'لا تقل هذا';

  @override
  String get whatHappened => 'ماذا حدث؟';

  @override
  String get nextStep => 'الخطوة التالية';

  @override
  String get viewRecoveryPlan => 'عرض خطة التعافي';

  @override
  String get recoveryPlan => 'خطة التعافي';

  @override
  String get immediate => 'فوري';

  @override
  String get immediateStep1 => 'اعتذر بصدق';

  @override
  String get immediateStep2 => 'أعطها مساحة إذا لزم الأمر';

  @override
  String get immediateStep3 => 'استمع بدون دفاع';

  @override
  String get shortTerm => 'قصير المدى';

  @override
  String get shortTermStep1 => 'خطط لبادرة مدروسة';

  @override
  String get shortTermStep2 => 'التزم بوعودك';

  @override
  String get longTerm => 'طويل المدى';

  @override
  String get longTermStep1 => 'عالج السبب الجذري';

  @override
  String get longTermStep2 => 'ابنِ عادات جديدة معاً';

  @override
  String get done => 'تم';

  @override
  String get upgradePlan => 'ترقية الخطة';

  @override
  String get noPlansAvailable => 'لا توجد خطط متاحة حالياً';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get subscriptionTerms => 'تطبق الشروط والأحكام';

  @override
  String get unlockFullPotential => 'افتح الإمكانيات الكاملة';

  @override
  String get paywallSubtitle => 'احصل على وصول غير محدود لجميع الميزات';

  @override
  String get welcome_tagline => 'Your AI-powered relationship\nintelligence companion';

  @override
  String get welcome_feature_messages => 'AI-crafted messages for every moment';

  @override
  String get welcome_feature_gifts => 'Smart gift recommendations';

  @override
  String get welcome_feature_reminders => 'Never forget an important date';

  @override
  String get welcome_alreadyHaveAccount => 'Already have an account? ';

  @override
  String get welcome_logIn => 'Log In';

  @override
  String get login_heading => 'Welcome back';

  @override
  String get login_subtitle => 'Sign in to continue your journey';

  @override
  String get login_label_email => 'Email';

  @override
  String get login_hint_email => 'you@example.com';

  @override
  String get login_label_password => 'Password';

  @override
  String get login_forgotPassword => 'Forgot Password?';

  @override
  String get login_buttonLogin => 'Log In';

  @override
  String get login_orContinueWith => 'or continue with';

  @override
  String get login_google => 'Google';

  @override
  String get login_apple => 'Apple';

  @override
  String get login_noAccount => 'Don\'t have an account? ';

  @override
  String get login_signUp => 'Sign Up';

  @override
  String get login_enterEmailFirst => 'Enter your email first';

  @override
  String get login_resetEmailSent => 'Password reset email sent';

  @override
  String get home_upcomingReminders => 'Upcoming Reminders';

  @override
  String get home_seeAll => 'See All';

  @override
  String get home_todaysActions => 'Today\'s Actions';

  @override
  String get home_somethingWentWrong => 'Something went wrong';

  @override
  String get home_notifications => 'Notifications';

  @override
  String get messages_title => 'AI Messages';

  @override
  String get messages_chooseMode => 'Choose a message mode';

  @override
  String get messages_history => 'Message History';

  @override
  String get generate_configureMessage => 'Configure Message';

  @override
  String get generate_tone => 'Tone';

  @override
  String get generate_humorLevel => 'Humor Level';

  @override
  String get generate_serious => 'Serious';

  @override
  String get generate_funny => 'Funny';

  @override
  String get generate_messageLength => 'Message Length';

  @override
  String get generate_language => 'Language';

  @override
  String get generate_includeHerName => 'Include her name';

  @override
  String get generate_includeHerNameDesc => 'Personalize the message with your partner\'s name';

  @override
  String get generate_contextOptional => 'Context (optional)';

  @override
  String get generate_contextHint => 'e.g., We had an argument about...';

  @override
  String get generate_button => 'Generate Message';

  @override
  String get messageDetail_title => 'Your Message';

  @override
  String get messageDetail_noMessage => 'No message generated yet.';

  @override
  String get messageDetail_crafting => 'Crafting your message...';

  @override
  String get messageDetail_copiedToClipboard => 'Message copied to clipboard';

  @override
  String get messageDetail_shareSubject => 'Message from LOLO';

  @override
  String get messageDetail_savedToFavorites => 'Saved to Favorites';

  @override
  String get messageDetail_saveToFavorites => 'Save to Favorites';

  @override
  String messageDetail_generatedBy(String model) {
    return 'Generated by $model';
  }

  @override
  String messageDetail_usageCount(int used, int limit) {
    return '$used of $limit messages used this month';
  }

  @override
  String get messageHistory_title => 'Message History';

  @override
  String get messageHistory_searchHint => 'Search messages...';

  @override
  String get messageHistory_all => 'All';

  @override
  String get messageHistory_favorites => 'Favorites';

  @override
  String get messageHistory_noMessages => 'No messages yet';

  @override
  String get messageHistory_noMessagesDesc => 'Generate your first message to see it here!';

  @override
  String get messageHistory_generateNow => 'Generate Now';

  @override
  String get messageHistory_copiedToClipboard => 'Copied to clipboard';

  @override
  String get messageHistory_today => 'Today';

  @override
  String get messageHistory_yesterday => 'Yesterday';

  @override
  String messageHistory_daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get sos_whatHappenedDesc => 'Select the scenario that best describes the situation';

  @override
  String get sos_howSevere => 'How severe is the situation?';

  @override
  String get sos_mild => 'Mild';

  @override
  String get sos_moderate => 'Moderate';

  @override
  String get sos_severe => 'Severe';

  @override
  String get sos_critical => 'Critical';

  @override
  String get sos_herMood => 'Her current mood';

  @override
  String get sos_sad => 'Sad';

  @override
  String get sos_angry => 'Angry';

  @override
  String get sos_disappointed => 'Disappointed';

  @override
  String get sos_hurt => 'Hurt';

  @override
  String get sos_frustrated => 'Frustrated';

  @override
  String get sos_silent => 'Silent';

  @override
  String get sos_getCoaching => 'Get Coaching';

  @override
  String get sos_doFirst => 'Do This First';

  @override
  String get sos_whatToSay => 'What to Say';

  @override
  String get sos_avoidSaying => 'Avoid Saying';

  @override
  String get sos_feedbackTitle => 'How did it go?';

  @override
  String get sos_feedbackGreat => 'Great';

  @override
  String get sos_feedbackOkay => 'Okay';

  @override
  String get sos_feedbackNotWell => 'Not well';

  @override
  String get sos_sessionComplete => 'Session Complete';

  @override
  String get sos_sessionCompleteDesc => 'Well done for making the effort. Remember, it\'s about progress, not perfection.';

  @override
  String get sos_moreResources => 'More Resources';

  @override
  String get gifts_title => 'Gift Ideas';

  @override
  String get gifts_subtitle => 'Thoughtful gift recommendations powered by AI';

  @override
  String get gifts_findPerfectGift => 'Find Perfect Gift';

  @override
  String get gifts_recentGifts => 'Recent Gift Ideas';

  @override
  String get gifts_noGiftsYet => 'No gift ideas yet';

  @override
  String get gifts_noGiftsDesc => 'Tap above to get personalized gift recommendations';

  @override
  String get gifts_budget => 'Budget';

  @override
  String get gifts_occasion => 'Occasion';

  @override
  String get gifts_getRecommendations => 'Get Recommendations';

  @override
  String get giftDetail_title => 'Gift Details';

  @override
  String get giftDetail_whyThisGift => 'Why this gift?';

  @override
  String get giftDetail_whereToBuy => 'Where to buy';

  @override
  String get giftDetail_priceRange => 'Price range';

  @override
  String get giftDetail_saveGift => 'Save Gift';

  @override
  String get giftDetail_markPurchased => 'Mark as Purchased';

  @override
  String get giftHistory_title => 'Gift History';

  @override
  String get giftHistory_purchased => 'Purchased';

  @override
  String get giftHistory_saved => 'Saved';

  @override
  String get giftHistory_noHistory => 'No gift history yet';

  @override
  String get memories_title => 'Memory Vault';

  @override
  String get memories_addMemory => 'Add Memory';

  @override
  String get createMemory_title => 'New Memory';

  @override
  String get createMemory_titleLabel => 'Title';

  @override
  String get createMemory_titleHint => 'e.g., Our first date';

  @override
  String get createMemory_dateLabel => 'Date';

  @override
  String get createMemory_descriptionLabel => 'Description';

  @override
  String get createMemory_descriptionHint => 'What made this moment special?';

  @override
  String get createMemory_addPhoto => 'Add Photo';

  @override
  String get createMemory_moodLabel => 'Mood';

  @override
  String get createMemory_tagsLabel => 'Tags';

  @override
  String get createMemory_tagsHint => 'Add tags...';

  @override
  String get createMemory_save => 'Save Memory';

  @override
  String get createMemory_saved => 'Memory saved!';

  @override
  String get memoryDetail_title => 'Memory';

  @override
  String get memoryDetail_delete => 'Delete Memory';

  @override
  String get memoryDetail_deleteConfirm => 'Are you sure you want to delete this memory?';

  @override
  String get wishlist_title => 'Wish List';

  @override
  String get wishlist_addItem => 'Add Item';

  @override
  String get wishlist_noItems => 'No wish list items yet';

  @override
  String get wishlist_noItemsDesc => 'Save things she mentions wanting';

  @override
  String get wishlist_itemName => 'Item name';

  @override
  String get wishlist_itemNotes => 'Notes (optional)';

  @override
  String get wishlist_priority => 'Priority';

  @override
  String get wishlist_priorityLow => 'Low';

  @override
  String get wishlist_priorityMedium => 'Medium';

  @override
  String get wishlist_priorityHigh => 'High';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_account => 'Account';

  @override
  String get settings_email => 'Email';

  @override
  String get settings_notifications => 'Notifications';

  @override
  String get settings_pushNotifications => 'Push Notifications';

  @override
  String get settings_reminderAlerts => 'Reminder Alerts';

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_themeSystem => 'System';

  @override
  String get settings_themeDark => 'Dark';

  @override
  String get settings_themeLight => 'Light';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_data => 'Data & Privacy';

  @override
  String get settings_exportData => 'Export My Data';

  @override
  String get settings_deleteAccount => 'Delete Account';

  @override
  String get settings_deleteAccountConfirm => 'This action cannot be undone. All your data will be permanently deleted.';

  @override
  String get settings_about => 'About';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_termsOfService => 'Terms of Service';

  @override
  String get settings_privacyPolicy => 'Privacy Policy';

  @override
  String get settings_logOut => 'Log Out';

  @override
  String get settings_logOutConfirm => 'Are you sure you want to log out?';

  @override
  String get settings_saving => 'Saving...';

  @override
  String get settings_saved => 'Saved!';

  @override
  String get notifications_title => 'Notifications';

  @override
  String get notifications_markAllRead => 'Mark all as read';

  @override
  String get notifications_noNotifications => 'No notifications yet';

  @override
  String get notifications_noNotificationsDesc => 'You\'re all caught up!';

  @override
  String get notifications_justNow => 'Just now';

  @override
  String notifications_minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String notifications_hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String gamification_level(int level) {
    return 'Level $level';
  }

  @override
  String get gamification_totalXP => 'Total XP';

  @override
  String get gamification_streak => 'Streak';

  @override
  String gamification_streakDays(int days) {
    return '$days days';
  }

  @override
  String get gamification_weeklyProgress => 'Weekly Progress';

  @override
  String get gamification_achievements => 'Achievements';

  @override
  String get gamification_recentActivity => 'Recent Activity';

  @override
  String get gamification_viewAllBadges => 'View All Badges';

  @override
  String get badges_title => 'Badge Gallery';

  @override
  String get badges_earned => 'Earned';

  @override
  String get badges_locked => 'Locked';

  @override
  String badges_progress(int current, int total) {
    return '$current/$total';
  }

  @override
  String get stats_title => 'Stats & Trends';

  @override
  String get stats_thisWeek => 'This Week';

  @override
  String get stats_thisMonth => 'This Month';

  @override
  String get stats_allTime => 'All Time';

  @override
  String get stats_messagesGenerated => 'Messages Generated';

  @override
  String get stats_remindersCompleted => 'Reminders Completed';

  @override
  String get stats_sosSessionsUsed => 'SOS Sessions Used';

  @override
  String get stats_cardsCompleted => 'Cards Completed';

  @override
  String get stats_averageRating => 'Average Rating';

  @override
  String get paywall_subscribe => 'Subscribe';

  @override
  String get paywall_mostPopular => 'MOST POPULAR';

  @override
  String get paywall_free => 'Free';

  @override
  String get paywall_pro => 'Pro';

  @override
  String get paywall_legend => 'Legend';

  @override
  String get paywall_aiMessages => 'AI Messages';

  @override
  String get paywall_actionCards => 'Action Cards';

  @override
  String get paywall_sosSessions => 'SOS Sessions';

  @override
  String get paywall_memoriesLimit => 'Memories';

  @override
  String get paywall_messageModes => 'Message Modes';

  @override
  String get paywall_streakFreezes => 'Streak Freezes';

  @override
  String get paywall_unlimited => 'Unlimited';

  @override
  String get actionCard_skip => 'Skip';

  @override
  String get actionCard_cardNotFound => 'Card not found';

  @override
  String get actionCard_save => 'Save';

  @override
  String get herProfile_birthday => 'Her Birthday';

  @override
  String get herProfile_birthdaySubtitle => 'Set her birthday for age-aware messages';

  @override
  String herProfile_birthdayFormat(String month, int day, int year, int age) {
    return '$month $day, $year ($age years old)';
  }

  @override
  String get herProfile_selectBirthday => 'Select her birthday';

  @override
  String get herProfile_nationality => 'Her Nationality';

  @override
  String get herProfile_nationalitySubtitle => 'Set her nationality for culturally personalized messages';

  @override
  String get herProfile_anniversary => 'Anniversary';

  @override
  String get herProfile_anniversarySubtitle => 'Set your anniversary date';

  @override
  String get herProfile_selectAnniversary => 'Select your anniversary';

  @override
  String get herProfile_quickFacts => 'QUICK FACTS';

  @override
  String get herProfile_status => 'Status';

  @override
  String get herProfile_zodiac => 'Zodiac';

  @override
  String get herProfile_background => 'Background';

  @override
  String get preferences_saving => 'Saving...';

  @override
  String get preferences_saved => 'Saved!';

  @override
  String get cultural_saving => 'Saving...';

  @override
  String get cultural_saved => 'Saved!';

  @override
  String get createMemory_photoComingSoon => 'Photo upload coming soon!';

  @override
  String get createMemory_addPhotos => 'Add photos';

  @override
  String get createMemory_saveButton => 'Save Memory';

  @override
  String get sos_howUrgent => 'How urgent is this?';

  @override
  String get sos_urgency_happeningNow => 'Happening NOW';

  @override
  String get sos_urgency_justHappened => 'Just Happened';

  @override
  String get sos_urgency_brewing => 'Brewing / Building Up';

  @override
  String get sos_assessmentTitle => 'Quick Assessment';

  @override
  String get sos_doThisRightNow => 'Do This Right Now';

  @override
  String get sos_dontDoThis => 'Don\'t Do This';

  @override
  String get sos_howLongAgo => 'How long ago did this start?';

  @override
  String get sos_time_rightNow => 'Right now';

  @override
  String get sos_time_fewMinutes => 'A few minutes ago';

  @override
  String get sos_time_withinHour => 'Within the hour';

  @override
  String get sos_time_earlierToday => 'Earlier today';

  @override
  String get sos_time_yesterday => 'Yesterday';

  @override
  String get sos_herCurrentState => 'Her current state?';

  @override
  String get sos_state_yelling => 'Yelling / Furious';

  @override
  String get sos_state_crying => 'Crying';

  @override
  String get sos_state_coldSilent => 'Cold & Silent';

  @override
  String get sos_state_disappointed => 'Disappointed';

  @override
  String get sos_state_confused => 'Confused';

  @override
  String get sos_state_hurt => 'Hurt';

  @override
  String get sos_state_calmUpset => 'Calm but upset';

  @override
  String get sos_myFault => 'This might be my fault';

  @override
  String get sos_brieflyWhatHappened => 'Briefly, what happened?';

  @override
  String get sos_whatHappenedHint => 'E.g. I forgot our anniversary and she found out...';

  @override
  String get sos_startCoaching => 'Start Coaching';

  @override
  String get sos_liveCoaching => 'Live Coaching';

  @override
  String get sos_analyzing => 'Analyzing situation...';

  @override
  String get sos_whyThisWorks => 'Why this works';

  @override
  String get sos_bodyLanguage => 'Body Language';

  @override
  String sos_waitFor(String text) {
    return 'Wait for: $text';
  }

  @override
  String get sos_finishCoaching => 'Finish Coaching';

  @override
  String get sos_coachingComplete => 'Coaching Complete';

  @override
  String get sos_situationResult => 'How did the situation turn out?';

  @override
  String get sos_rateSession => 'Rate this coaching session';

  @override
  String get sos_resolutionNotes => 'Resolution notes (optional)';

  @override
  String get sos_resolutionHint => 'How did she respond? What worked? What would you do differently?';

  @override
  String get sos_saveToMemoryVault => 'Save to Memory Vault';

  @override
  String get sos_saveToMemoryVaultDesc => 'Remember what you learned for next time';

  @override
  String get sos_completeButton => 'Complete';

  @override
  String get sos_sessionSaved => 'SOS session saved. Stay strong!';

  @override
  String get gifts_screenTitle => 'Gifts';

  @override
  String get gifts_searchHint => 'Search gifts...';

  @override
  String get gifts_whatsOccasion => 'What\'s the occasion?';

  @override
  String get gifts_occasion_justBecause => 'Just Because';

  @override
  String get gifts_occasion_birthday => 'Birthday';

  @override
  String get gifts_occasion_anniversary => 'Anniversary';

  @override
  String get gifts_occasion_apology => 'Apology';

  @override
  String get gifts_occasion_valentines => 'Valentine\'s Day';

  @override
  String get gifts_occasion_eidHoliday => 'Eid / Holiday';

  @override
  String get gifts_generatingIdeas => 'Generating AI gift ideas...';

  @override
  String get gifts_noGiftsFound => 'No gifts found';

  @override
  String get gifts_adjustFilters => 'Try adjusting your filters or search.';

  @override
  String get gifts_lowBudget => 'Low Budget High Impact';

  @override
  String get gifts_getAiRecommendations => 'Get AI Recommendations';

  @override
  String get giftDetail_whySheLoveIt => 'Why She\'ll Love It';

  @override
  String get giftDetail_basedOnProfile => 'Based on Her Profile';

  @override
  String get giftDetail_buyNow => 'Buy Now';

  @override
  String get giftDetail_unsave => 'Unsave';

  @override
  String get giftDetail_save => 'Save';

  @override
  String get giftDetail_notRight => 'Not right for her';

  @override
  String get giftDetail_relatedGifts => 'Related Gifts';

  @override
  String get giftHistory_all => 'All';

  @override
  String get giftHistory_liked => 'Liked';

  @override
  String get giftHistory_didntLike => 'Didn\'t Like';

  @override
  String get giftHistory_noHistoryDesc => 'Browse gifts and get recommendations to build your history.';

  @override
  String get memories_searchHint => 'Search memories...';

  @override
  String get memories_listView => 'List view';

  @override
  String get memories_gridView => 'Grid view';

  @override
  String get memories_noMemories => 'No memories yet';

  @override
  String get memories_noMemoriesDesc => 'Start capturing your special moments together';

  @override
  String get memoryDetail_photos => 'Photos';

  @override
  String get memoryDetail_tags => 'Tags';

  @override
  String get wishlist_noWishes => 'No wishes captured yet';

  @override
  String get wishlist_noWishesDesc => 'When she mentions something she wants, save it with the \'She Said\' toggle.';

  @override
  String get wishlist_sendToGiftEngine => 'Send to Gift Engine';

  @override
  String wishlist_sentToGiftEngine(String title) {
    return 'Sent \"$title\" to Gift Engine';
  }

  @override
  String get wishlist_sortNewest => 'Newest First';

  @override
  String get wishlist_sortOccasion => 'By Occasion Proximity';

  @override
  String get wishlist_statusNew => 'New';

  @override
  String get wishlist_statusSentToGifts => 'Sent to Gifts';

  @override
  String get wishlist_statusFulfilled => 'Fulfilled';

  @override
  String get wishlist_sort => 'Sort';

  @override
  String get settings_profile => 'Profile';

  @override
  String get settings_receiveNotifications => 'Receive push notifications';

  @override
  String get settings_reminderAlertsDesc => 'Get notified about upcoming dates';

  @override
  String get settings_dailyActionCards => 'Daily Action Cards';

  @override
  String get settings_dailyActionCardsDesc => 'Daily relationship tips and actions';

  @override
  String get settings_weeklyDigest => 'Weekly Digest';

  @override
  String get settings_weeklyDigestDesc => 'Weekly relationship summary';

  @override
  String get settings_subscription => 'Subscription';

  @override
  String get settings_premiumActive => 'Premium Active';

  @override
  String get settings_upgradeToPremium => 'Upgrade to Premium';

  @override
  String get settings_manageSubscription => 'Manage your subscription';

  @override
  String get settings_unlockAllFeatures => 'Unlock all features';

  @override
  String get settings_aboutLolo => 'About LOLO';

  @override
  String get settings_logOutTitle => 'Log Out';

  @override
  String get settings_deleteAccountTitle => 'Delete Account';

  @override
  String get settings_deleteAccountMessage => 'This action is permanent and cannot be undone. All your data will be deleted.';

  @override
  String settings_appVersion(String version) {
    return 'LOLO v$version';
  }

  @override
  String get notifications_loadError => 'Couldn\'t load notifications.';

  @override
  String get notifications_noNotificationsSubtitle => 'We\'ll keep you posted!';

  @override
  String get notifications_today => 'Today';

  @override
  String get notifications_yesterday => 'Yesterday';

  @override
  String get notifications_earlier => 'Earlier';

  @override
  String get gamification_weeklyActivity => 'Weekly Activity';

  @override
  String get gamification_viewStats => 'View Stats';

  @override
  String get gamification_seeAll => 'See All';

  @override
  String gamification_dayStreak(int days) {
    return '$days day streak';
  }

  @override
  String gamification_bestStreak(int days) {
    return 'Best: $days days';
  }

  @override
  String gamification_xpTotal(int xp) {
    return '$xp XP total';
  }

  @override
  String get gamification_freezes => 'freezes';

  @override
  String get gamification_useFreezeTitle => 'Use Streak Freeze?';

  @override
  String get gamification_useFreezeMessage => 'This will protect your streak for one missed day. You cannot undo this action.';

  @override
  String get gamification_useFreeze => 'Use Freeze';

  @override
  String get gamification_freezeApplied => 'Streak freeze applied!';

  @override
  String get gamification_leaderboard => 'Leaderboard';

  @override
  String get badges_noBadges => 'No badges yet';

  @override
  String get badges_noBadgesDesc => 'Complete your first action to start earning badges!';

  @override
  String get badges_category_all => 'All';

  @override
  String get badges_category_consistency => 'Consistency';

  @override
  String get badges_category_milestones => 'Milestones';

  @override
  String get badges_category_mastery => 'Mastery';

  @override
  String get badges_category_special => 'Special';

  @override
  String badges_earnedDate(String date) {
    return 'Earned $date';
  }

  @override
  String get stats_activityOverTime => 'Activity Over Time';

  @override
  String get stats_actionBreakdown => 'Action Breakdown';

  @override
  String get stats_personalBests => 'Personal Bests';

  @override
  String get stats_aiInsight => 'AI Insight';

  @override
  String get stats_noActivity => 'No activity for this period.\nStart by completing an action today!';

  @override
  String get stats_highestStreak => 'Highest\nStreak';

  @override
  String get stats_mostActiveWeek => 'Most Active\nWeek';

  @override
  String get stats_favoriteAction => 'Favorite\nAction';

  @override
  String get stats_week => 'Week';

  @override
  String get stats_month => 'Month';
}
