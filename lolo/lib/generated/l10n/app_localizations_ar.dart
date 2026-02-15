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
  String get onboarding_partner_error_name => 'Please enter her name';

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
}
