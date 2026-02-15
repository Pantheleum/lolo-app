import 'package:flutter/material.dart';
import 'package:lolo/features/sos_mode/presentation/screens/sos_activation_screen.dart';

/// SOS Mode entry point. Delegates to [SosActivationScreen].
class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) => const SosActivationScreen();
}
