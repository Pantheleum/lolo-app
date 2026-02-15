import 'package:flutter/material.dart';

/// Onboarding Step 4: Privacy assurance.
class OnboardingPrivacyScreen extends StatelessWidget {
  const OnboardingPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: const Center(child: Text('Onboarding Privacy Screen')),
    );
  }
}
