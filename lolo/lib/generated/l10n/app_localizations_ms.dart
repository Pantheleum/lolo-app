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
  String get onboarding_signup_error_emailInUse => 'Emel ini sudah didaftarkan.';

  @override
  String get onboarding_signup_error_invalidEmail => 'Sila masukkan alamat emel yang sah.';

  @override
  String get onboarding_signup_error_weakPassword => 'Kata laluan mesti sekurang-kurangnya 8 aksara.';

  @override
  String get onboarding_signup_error_networkFailed => 'Ralat rangkaian. Semak sambungan anda.';

  @override
  String get onboarding_signup_error_generic => 'Pengesahan gagal. Sila cuba lagi.';

  @override
  String get onboarding_login_title => 'Log Masuk';

  @override
  String get onboarding_login_heading => 'Selamat kembali';

  @override
  String get onboarding_login_button_login => 'Log Masuk';

  @override
  String get onboarding_login_link_forgot => 'Lupa kata laluan?';

  @override
  String get onboarding_login_link_signup => 'Tiada akaun? Daftar sekarang';

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
  String get onboarding_partner_error_name => 'Sila masukkan nama dia';

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
  String get profile_edit_loveLanguage_words => 'Kata-kata Pujian';

  @override
  String get profile_edit_loveLanguage_acts => 'Tindakan Perkhidmatan';

  @override
  String get profile_edit_loveLanguage_gifts => 'Menerima Hadiah';

  @override
  String get profile_edit_loveLanguage_time => 'Masa Berkualiti';

  @override
  String get profile_edit_loveLanguage_touch => 'Sentuhan Fizikal';

  @override
  String get profile_edit_commStyle_direct => 'Langsung';

  @override
  String get profile_edit_commStyle_indirect => 'Tidak Langsung';

  @override
  String get profile_edit_commStyle_mixed => 'Campuran';

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
  String get profile_preferences_category_flowers => 'Bunga';

  @override
  String get profile_preferences_category_food => 'Makanan';

  @override
  String get profile_preferences_category_music => 'Muzik';

  @override
  String get profile_preferences_category_movies => 'Filem';

  @override
  String get profile_preferences_category_brands => 'Jenama';

  @override
  String get profile_preferences_category_colors => 'Warna';

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
  String get profile_cultural_bg_gulf => 'Arab Teluk';

  @override
  String get profile_cultural_bg_levantine => 'Levantine';

  @override
  String get profile_cultural_bg_egyptian => 'Mesir';

  @override
  String get profile_cultural_bg_northAfrican => 'Afrika Utara';

  @override
  String get profile_cultural_bg_malay => 'Malaysia/Melayu';

  @override
  String get profile_cultural_bg_western => 'Barat';

  @override
  String get profile_cultural_bg_southAsian => 'Asia Selatan';

  @override
  String get profile_cultural_bg_eastAsian => 'Asia Timur';

  @override
  String get profile_cultural_bg_other => 'Lain-lain';

  @override
  String get profile_cultural_obs_high => 'Tinggi -- Mengamalkan semua amalan keagamaan';

  @override
  String get profile_cultural_obs_moderate => 'Sederhana -- Mengamalkan amalan utama';

  @override
  String get profile_cultural_obs_low => 'Rendah -- Berkaitan secara budaya';

  @override
  String get profile_cultural_obs_secular => 'Sekular';

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
  String get reminders_create_recurrence_none => 'Tiada ulangan';

  @override
  String get reminders_create_recurrence_weekly => 'Mingguan';

  @override
  String get reminders_create_recurrence_monthly => 'Bulanan';

  @override
  String get reminders_create_recurrence_yearly => 'Tahunan';

  @override
  String get reminders_create_category_birthday => 'Hari Lahir';

  @override
  String get reminders_create_category_anniversary => 'Ulang Tahun';

  @override
  String get reminders_create_category_islamic => 'Hari Raya Islam';

  @override
  String get reminders_create_category_cultural => 'Budaya';

  @override
  String get reminders_create_category_custom => 'Tersuai';

  @override
  String get reminders_create_category_promise => 'Janji';

  @override
  String get reminders_create_error_title => 'Tajuk diperlukan';

  @override
  String get reminders_create_error_date => 'Sila pilih tarikh';

  @override
  String get reminders_create_error_pastDate => 'Tarikh peringatan tidak boleh pada masa lalu';

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
  String get reminders_notification_today => 'Hari ini hari yang ditunggu!';

  @override
  String reminders_notification_daysUntil(int days, String title) {
    return '$days hari lagi sebelum $title';
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

  @override
  String get actionCardsTitle => 'Tindakan Harian';

  @override
  String get allCardsDone => 'Semua selesai hari ini!';

  @override
  String get allCardsDoneSubtitle => 'Kembali esok untuk idea baharu';

  @override
  String get whatToDo => 'Apa yang perlu dilakukan';

  @override
  String get howDidItGo => 'Bagaimana hasilnya?';

  @override
  String get optionalNotes => 'Tambah nota (pilihan)';

  @override
  String get markComplete => 'Tandakan Selesai';

  @override
  String get gamification => 'Kemajuan';

  @override
  String get badges => 'Lencana';

  @override
  String get sosTitle => 'Mod SOS';

  @override
  String get sosSubtitle => 'Bantuan kecemasan apabila dia kecewa';

  @override
  String get getHelp => 'Dapatkan Bantuan';

  @override
  String get assessment => 'Penilaian';

  @override
  String get back => 'Kembali';

  @override
  String get coaching => 'Bimbingan';

  @override
  String stepProgress(int current, int total) {
    return 'Langkah $current daripada $total';
  }

  @override
  String get sayThis => 'Katakan Ini';

  @override
  String get dontSay => 'Jangan Katakan Ini';

  @override
  String get whatHappened => 'Apa yang berlaku?';

  @override
  String get nextStep => 'Langkah Seterusnya';

  @override
  String get viewRecoveryPlan => 'Lihat Pelan Pemulihan';

  @override
  String get recoveryPlan => 'Pelan Pemulihan';

  @override
  String get immediate => 'Segera';

  @override
  String get immediateStep1 => 'Minta maaf dengan ikhlas';

  @override
  String get immediateStep2 => 'Beri dia ruang jika perlu';

  @override
  String get immediateStep3 => 'Dengar tanpa membela diri';

  @override
  String get shortTerm => 'Jangka Pendek';

  @override
  String get shortTermStep1 => 'Rancang isyarat yang bermakna';

  @override
  String get shortTermStep2 => 'Tunaikan janji anda';

  @override
  String get longTerm => 'Jangka Panjang';

  @override
  String get longTermStep1 => 'Tangani punca masalah';

  @override
  String get longTermStep2 => 'Bina tabiat baru bersama';

  @override
  String get done => 'Selesai';

  @override
  String get upgradePlan => 'Naik Taraf Pelan';

  @override
  String get noPlansAvailable => 'Tiada pelan tersedia pada masa ini';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get subscriptionTerms => 'Terma & Syarat terpakai';

  @override
  String get unlockFullPotential => 'Buka Potensi Penuh';

  @override
  String get paywallSubtitle => 'Dapatkan akses tanpa had ke semua ciri';
}
