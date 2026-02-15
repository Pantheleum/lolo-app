import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appName => 'LOLO';

  @override
  String get common_button_continue => 'Teruskan';

  @override
  String get common_button_back => 'Kembali';

  @override
  String get common_button_skip => 'Langkau';

  @override
  String get common_button_save => 'Simpan';

  @override
  String get common_button_cancel => 'Batal';

  @override
  String get common_button_delete => 'Padam';

  @override
  String get common_button_done => 'Selesai';

  @override
  String get common_button_retry => 'Cuba Semula';

  @override
  String get common_button_close => 'Tutup';

  @override
  String get common_button_confirm => 'Sahkan';

  @override
  String get common_button_edit => 'Sunting';

  @override
  String get common_button_copy => 'Salin';

  @override
  String get common_button_share => 'Kongsi';

  @override
  String get common_label_loading => 'Memuatkan...';

  @override
  String get common_label_offline => 'Anda di luar talian. Menunjukkan data tersimpan.';

  @override
  String common_label_lastUpdated(String time) {
    return 'Kemas kini terakhir $time';
  }

  @override
  String get error_generic => 'Sesuatu tidak kena. Sila cuba lagi.';

  @override
  String get error_network => 'Tiada sambungan internet. Semak rangkaian anda.';

  @override
  String get error_timeout => 'Permintaan tamat masa. Sila cuba lagi.';

  @override
  String get error_server => 'Ralat pelayan. Kami sedang menyelesaikannya.';

  @override
  String get error_unauthorized => 'Sesi tamat. Sila log masuk semula.';

  @override
  String get error_rate_limited => 'Terlalu banyak permintaan. Sila tunggu sebentar.';

  @override
  String get error_tier_exceeded => 'Naik taraf pelan anda untuk membuka ciri ini.';

  @override
  String get nav_home => 'Utama';

  @override
  String get nav_reminders => 'Peringatan';

  @override
  String get nav_messages => 'Mesej';

  @override
  String get nav_gifts => 'Hadiah';

  @override
  String get nav_more => 'Lagi';

  @override
  String get empty_reminders_title => 'Tiada peringatan lagi';

  @override
  String get empty_reminders_subtitle => 'Tambah tarikh penting supaya tidak lupa';

  @override
  String get empty_messages_title => 'Tiada mesej lagi';

  @override
  String get empty_messages_subtitle => 'Jana mesej AI pertama anda';

  @override
  String get empty_memories_title => 'Tiada kenangan lagi';

  @override
  String get empty_memories_subtitle => 'Mula simpan detik yang bermakna';

  @override
  String get onboarding_language_title => 'Pilih Bahasa Anda';

  @override
  String get onboarding_language_english => 'English';

  @override
  String get onboarding_language_arabic => 'العربية';

  @override
  String get onboarding_language_malay => 'Bahasa Melayu';

  @override
  String get onboarding_welcome_tagline => 'Dia tak akan tahu kenapa kamu jadi lebih perhatian.\nKami tak akan bagitahu.';

  @override
  String get onboarding_welcome_benefit1_title => 'Peringatan Pintar';

  @override
  String get onboarding_welcome_benefit1_subtitle => 'Jangan lupa apa yang penting baginya';

  @override
  String get onboarding_welcome_benefit2_title => 'Mesej AI';

  @override
  String get onboarding_welcome_benefit2_subtitle => 'Cakap benda yang betul, setiap masa';

  @override
  String get onboarding_welcome_benefit3_title => 'Mod SOS';

  @override
  String get onboarding_welcome_benefit3_subtitle => 'Bantuan kecemasan bila dia sedih';

  @override
  String get onboarding_welcome_button_start => 'Mula';

  @override
  String get onboarding_welcome_link_login => 'Sudah ada akaun? Log masuk';

  @override
  String get onboarding_signup_title => 'Daftar';

  @override
  String get onboarding_signup_heading => 'Cipta akaun anda';

  @override
  String get onboarding_signup_button_google => 'Teruskan dengan Google';

  @override
  String get onboarding_signup_button_apple => 'Teruskan dengan Apple';

  @override
  String get onboarding_signup_divider => 'atau';

  @override
  String get onboarding_signup_label_email => 'Emel';

  @override
  String get onboarding_signup_hint_email => 'you@example.com';

  @override
  String get onboarding_signup_label_password => 'Kata Laluan';

  @override
  String get onboarding_signup_label_confirmPassword => 'Sahkan Kata Laluan';

  @override
  String get onboarding_signup_button_create => 'Cipta Akaun';

  @override
  String onboarding_signup_legal(String terms, String privacy) {
    return 'Dengan mendaftar anda bersetuju dengan $terms dan $privacy kami';
  }

  @override
  String get onboarding_signup_legal_terms => 'Terma Perkhidmatan';

  @override
  String get onboarding_signup_legal_privacy => 'Dasar Privasi';

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
  String get onboarding_name_title => 'Apa nama anda?';

  @override
  String get onboarding_name_hint => 'Nama anda';

  @override
  String get onboarding_name_error_min => 'Sila masukkan sekurang-kurangnya 2 aksara';

  @override
  String get onboarding_partner_title => 'Siapa yang istimewa?';

  @override
  String get onboarding_partner_hint => 'Nama dia';

  @override
  String get onboarding_partner_label_zodiac => 'Zodiak dia (pilihan)';

  @override
  String get onboarding_partner_label_zodiacUnknown => 'Saya tak tahu zodiak dia';

  @override
  String get onboarding_partner_label_status => 'Status hubungan';

  @override
  String get onboarding_partner_error_name => 'Please enter her name';

  @override
  String get onboarding_status_dating => 'Bercinta';

  @override
  String get onboarding_status_engaged => 'Bertunang';

  @override
  String get onboarding_status_newlywed => 'Pengantin Baru';

  @override
  String get onboarding_status_married => 'Berkahwin';

  @override
  String get onboarding_status_longDistance => 'Jarak Jauh';

  @override
  String get onboarding_anniversary_title => 'Bila kisah kamu bermula?';

  @override
  String get onboarding_anniversary_label_dating => 'Ulang tahun bercinta';

  @override
  String get onboarding_anniversary_label_wedding => 'Tarikh perkahwinan';

  @override
  String get onboarding_anniversary_select_date => 'Pilih tarikh';

  @override
  String onboarding_firstCard_title(String partnerName) {
    return 'Kad pintar pertama untuk $partnerName';
  }

  @override
  String onboarding_firstCard_personalized(String partnerName) {
    return 'Dikhaskan untuk $partnerName';
  }

  @override
  String get profile_title => 'Profil Dia';

  @override
  String profile_completion(int percent) {
    return '$percent% lengkap';
  }

  @override
  String get profile_nav_zodiac => 'Zodiak & Sifat';

  @override
  String get profile_nav_zodiac_empty => 'Belum ditetapkan';

  @override
  String get profile_nav_preferences => 'Keutamaan';

  @override
  String profile_nav_preferences_subtitle(int count) {
    return '$count item direkodkan';
  }

  @override
  String get profile_nav_cultural => 'Konteks Budaya';

  @override
  String get profile_nav_cultural_empty => 'Belum ditetapkan';

  @override
  String get profile_edit_title => 'Sunting Profil';

  @override
  String get profile_edit_zodiac_traits => 'Sifat Zodiak';

  @override
  String get profile_edit_loveLanguage => 'Bahasa Cinta Dia';

  @override
  String get profile_edit_commStyle => 'Gaya Komunikasi';

  @override
  String get profile_edit_conflictStyle => 'Gaya Konflik';

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
  String get profile_preferences_title => 'Keutamaan Dia';

  @override
  String get profile_preferences_favorites => 'Kegemaran';

  @override
  String profile_preferences_add_hint(String category) {
    return 'Tambah $category...';
  }

  @override
  String get profile_preferences_hobbies => 'Hobi & Minat';

  @override
  String get profile_preferences_dislikes => 'Tidak Suka & Pencetus';

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
  String get profile_cultural_title => 'Konteks Budaya';

  @override
  String get profile_cultural_background => 'Latar Belakang Budaya';

  @override
  String get profile_cultural_background_hint => 'Pilih latar belakang';

  @override
  String get profile_cultural_observance => 'Amalan Keagamaan';

  @override
  String get profile_cultural_dialect => 'Dialek Arab';

  @override
  String get profile_cultural_dialect_hint => 'Pilih dialek';

  @override
  String get profile_cultural_info => 'Ini membantu LOLO menyesuaikan kandungan AI, menapis cadangan yang tidak sesuai, dan menambah hari kelepasan yang berkaitan secara automatik.';

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
  String get reminders_title => 'Peringatan';

  @override
  String get reminders_view_list => 'Paparan senarai';

  @override
  String get reminders_view_calendar => 'Paparan kalendar';

  @override
  String get reminders_section_overdue => 'Tertunggak';

  @override
  String get reminders_section_upcoming => 'Akan Datang';

  @override
  String get reminders_create_title => 'Peringatan Baru';

  @override
  String get reminders_create_label_title => 'Tajuk';

  @override
  String get reminders_create_hint_title => 'cth. Hari lahir dia';

  @override
  String get reminders_create_label_category => 'Kategori';

  @override
  String get reminders_create_label_date => 'Tarikh';

  @override
  String get reminders_create_label_time => 'Masa (pilihan)';

  @override
  String get reminders_create_label_recurrence => 'Ulang';

  @override
  String get reminders_create_label_notes => 'Nota (pilihan)';

  @override
  String get reminders_create_hint_notes => 'Tambah sebarang butiran tambahan...';

  @override
  String get reminders_create_button_save => 'Cipta Peringatan';

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
  String get reminders_detail_title => 'Butiran Peringatan';

  @override
  String get reminders_detail_date => 'Tarikh';

  @override
  String get reminders_detail_time => 'Masa';

  @override
  String get reminders_detail_daysUntil => 'Hari lagi';

  @override
  String get reminders_detail_recurrence => 'Berulang';

  @override
  String get reminders_detail_notes => 'Nota';

  @override
  String get reminders_detail_button_complete => 'Tandakan Selesai';

  @override
  String get reminders_detail_button_snooze => 'Tangguhkan';

  @override
  String get reminders_detail_completed => 'Selesai';

  @override
  String reminders_detail_overdue(int days) {
    return 'Tertunggak $days hari';
  }

  @override
  String reminders_detail_inDays(int days) {
    return 'Dalam $days hari';
  }

  @override
  String get reminders_detail_today => 'Hari ini';

  @override
  String get reminders_snooze_title => 'Tangguhkan selama...';

  @override
  String get reminders_snooze_1h => '1 jam';

  @override
  String get reminders_snooze_3h => '3 jam';

  @override
  String get reminders_snooze_1d => '1 hari';

  @override
  String get reminders_snooze_3d => '3 hari';

  @override
  String get reminders_snooze_1w => '1 minggu';

  @override
  String get reminders_delete_title => 'Padam Peringatan';

  @override
  String get reminders_delete_message => 'Peringatan ini akan dipadamkan secara kekal dan semua pemberitahuannya akan dibatalkan. Adakah anda pasti?';

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
      other: '$count peringatan',
      one: '1 peringatan',
      zero: 'Tiada peringatan',
    );
    return '$_temp0';
  }

  @override
  String profile_items_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count item',
      one: '1 item',
      zero: 'Tiada item',
    );
    return '$_temp0';
  }

  @override
  String days_remaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dalam $count hari',
      one: 'Esok',
      zero: 'Hari ini',
    );
    return '$_temp0';
  }
}
