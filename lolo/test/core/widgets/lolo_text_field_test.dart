import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';

void main() {
  late TextEditingController controller;

  setUp(() {
    controller = TextEditingController();
  });

  tearDown(() {
    controller.dispose();
  });

  Widget buildSubject({
    String label = 'Email',
    TextEditingController? textController,
    String? hint,
    String? errorText,
    String? helperText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    bool enabled = true,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: LoloTextField(
            label: label,
            controller: textController ?? controller,
            hint: hint,
            errorText: errorText,
            helperText: helperText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            obscureText: obscureText,
            enabled: enabled,
            validator: validator,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  group('LoloTextField rendering', () {
    testWidgets('renders a TextFormField', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('displays label text', (tester) async {
      await tester.pumpWidget(buildSubject(label: 'Username'));
      expect(find.text('Username'), findsOneWidget);
    });

    testWidgets('displays hint text', (tester) async {
      await tester.pumpWidget(buildSubject(hint: 'Enter your email'));
      // Hint is visible when field is focused/empty
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('displays error text', (tester) async {
      await tester.pumpWidget(buildSubject(errorText: 'Invalid email'));
      expect(find.text('Invalid email'), findsOneWidget);
    });

    testWidgets('displays helper text', (tester) async {
      await tester.pumpWidget(buildSubject(helperText: 'Required field'));
      expect(find.text('Required field'), findsOneWidget);
    });

    testWidgets('renders prefix icon', (tester) async {
      await tester.pumpWidget(buildSubject(prefixIcon: Icons.email));
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('renders suffix icon widget', (tester) async {
      await tester.pumpWidget(buildSubject(
        suffixIcon: const Icon(Icons.visibility),
      ));
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });

  group('LoloTextField input', () {
    testWidgets('accepts text input', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.enterText(find.byType(TextFormField), 'test@email.com');
      expect(controller.text, 'test@email.com');
    });

    testWidgets('calls onChanged callback', (tester) async {
      String? changedValue;
      await tester.pumpWidget(buildSubject(
        onChanged: (value) => changedValue = value,
      ));
      await tester.enterText(find.byType(TextFormField), 'hello');
      expect(changedValue, 'hello');
    });

    testWidgets('obscures text when obscureText is true', (tester) async {
      await tester.pumpWidget(buildSubject(obscureText: true));
      // TextFormField wraps a TextField; check the underlying EditableText
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editableText.obscureText, true);
    });
  });

  group('LoloTextField enabled/disabled states', () {
    testWidgets('accepts input when enabled', (tester) async {
      await tester.pumpWidget(buildSubject(enabled: true));
      await tester.enterText(find.byType(TextFormField), 'text');
      expect(controller.text, 'text');
    });

    testWidgets('does not accept input when disabled', (tester) async {
      await tester.pumpWidget(buildSubject(enabled: false));
      // Trying to enter text on disabled field
      await tester.enterText(find.byType(TextFormField), 'text');
      expect(controller.text, ''); // should remain empty
    });
  });

  group('LoloTextField validator', () {
    testWidgets('validates on form submit', (tester) async {
      final formKey = GlobalKey<FormState>();
      String? validatorResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: LoloTextField(
                label: 'Email',
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    validatorResult = 'Required';
                    return 'Required';
                  }
                  validatorResult = null;
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(validatorResult, 'Required');
      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('validator passes with valid input', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: LoloTextField(
                label: 'Email',
                controller: controller,
                validator: (value) {
                  if (value != null && value.isNotEmpty) return null;
                  return 'Required';
                },
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'user@test.com');
      final isValid = formKey.currentState!.validate();
      await tester.pump();

      expect(isValid, true);
    });
  });

  group('LoloTextField semantics', () {
    testWidgets('has text field semantics', (tester) async {
      await tester.pumpWidget(buildSubject(label: 'Password'));
      expect(find.byType(LoloTextField), findsOneWidget);
    });
  });
}
