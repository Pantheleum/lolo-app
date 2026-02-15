import 'package:flutter/material.dart';

/// Onboarding Step 1: User name entry.
class OnboardingNameScreen extends StatelessWidget {
  const OnboardingNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Name')),
      body: const Center(child: Text('Onboarding Name Screen')),
    );
  }
}
