/// Supported languages in the LOLO app.
enum AppLanguage {
  english('en', 'English', 'English'),
  arabic('ar', 'العربية', 'Arabic'),
  malay('ms', 'Bahasa Melayu', 'Malay');

  final String code;
  final String nativeName;
  final String englishName;

  const AppLanguage(this.code, this.nativeName, this.englishName);
}
