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
