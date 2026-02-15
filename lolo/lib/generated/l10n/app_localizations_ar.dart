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
}
