import 'package:flutter/material.dart';

/// Onboarding Step 5: First action card preview.
class OnboardingFirstCardScreen extends StatelessWidget {
  const OnboardingFirstCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your First Card')),
      body: const Center(child: Text('Onboarding First Card Screen')),
    );
  }
}
