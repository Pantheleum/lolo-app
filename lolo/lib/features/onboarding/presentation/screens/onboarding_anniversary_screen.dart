import 'package:flutter/material.dart';

/// Onboarding Step 3: Anniversary date entry.
class OnboardingAnniversaryScreen extends StatelessWidget {
  const OnboardingAnniversaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anniversary')),
      body: const Center(child: Text('Onboarding Anniversary Screen')),
    );
  }
}
