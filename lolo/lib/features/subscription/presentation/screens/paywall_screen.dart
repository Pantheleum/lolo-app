import 'package:flutter/material.dart';

/// Paywall screen stub.
class PaywallScreen extends StatelessWidget {
  final String? triggerFeature;

  const PaywallScreen({super.key, this.triggerFeature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade')),
      body: Center(child: Text('Paywall Screen - Triggered by: ${triggerFeature ?? "direct"}')),
    );
  }
}
