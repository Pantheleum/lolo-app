import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/bootstrap.dart';
import 'package:lolo/app.dart';
import 'package:lolo/core/di/provider_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait on phones
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for dark theme default
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF161B22),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize all services (Firebase, Hive, Isar, etc.)
  await bootstrap();

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const LoloApp(),
    ),
  );
}
