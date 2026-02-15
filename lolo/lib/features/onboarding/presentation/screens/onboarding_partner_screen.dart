import 'package:flutter/material.dart';

/// Onboarding Step 2: Partner info entry.
class OnboardingPartnerScreen extends StatelessWidget {
  const OnboardingPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Her Info')),
      body: const Center(child: Text('Onboarding Partner Screen')),
    );
  }
}
