import 'package:flutter/material.dart';

/// Welcome screen -- first screen shown to unauthenticated users.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
