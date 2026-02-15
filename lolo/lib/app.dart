import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/router/app_router.dart';
import 'package:lolo/core/theme/lolo_theme.dart';
import 'package:lolo/core/localization/locale_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LoloApp extends ConsumerWidget {
  const LoloApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'LOLO',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: LoloTheme.light(),
      darkTheme: LoloTheme.dark(),
      themeMode: themeMode,

      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Navigation
      routerConfig: router,
    );
  }
}
