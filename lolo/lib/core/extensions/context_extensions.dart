import 'package:flutter/material.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Convenience extensions on [BuildContext] for quick access to
/// theme, locale, and localization.
extension ContextExtensions on BuildContext {
  /// Quick access to the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Quick access to the current [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Quick access to the current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick access to localized strings.
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Quick access to the current [Locale].
  Locale get locale => Localizations.localeOf(this);

  /// Whether the current locale is RTL.
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  /// Screen size helpers.
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Safe area padding.
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}
