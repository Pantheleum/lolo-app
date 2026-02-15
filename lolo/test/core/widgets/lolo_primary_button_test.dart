import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

void main() {
  Widget buildSubject({
    String label = 'Test Button',
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
    bool fullWidth = true,
    bool? isExpanded,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: LoloPrimaryButton(
          label: label,
          onPressed: onPressed ?? () {},
          isLoading: isLoading,
          isEnabled: isEnabled,
          icon: icon,
          fullWidth: fullWidth,
          isExpanded: isExpanded,
        ),
      ),
    );
  }

  group('LoloPrimaryButton rendering', () {
    testWidgets('renders the label text', (tester) async {
      await tester.pumpWidget(buildSubject(label: 'Continue'));
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders an ElevatedButton', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('has 52dp height', (tester) async {
      await tester.pumpWidget(buildSubject());
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.height, 52);
    });

    testWidgets('renders with icon when provided', (tester) async {
      await tester.pumpWidget(buildSubject(icon: Icons.arrow_forward));
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('does not render icon when not provided', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.byType(Icon), findsNothing);
    });
  });

  group('LoloPrimaryButton tap callback', () {
    testWidgets('calls onPressed when tapped and enabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildSubject(
        onPressed: () => tapped = true,
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, true);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildSubject(
        onPressed: () => tapped = true,
        isEnabled: false,
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, false);
    });

    testWidgets('does not call onPressed when loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildSubject(
        onPressed: () => tapped = true,
        isLoading: true,
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, false);
    });

    testWidgets('does not call onPressed when onPressed is null',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoloPrimaryButton(
              label: 'Test',
              onPressed: null,
            ),
          ),
        ),
      );

      // Should not throw when tapped
      await tester.tap(find.byType(ElevatedButton));
    });
  });

  group('LoloPrimaryButton loading state', () {
    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      await tester.pumpWidget(buildSubject(isLoading: true));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides label text when loading', (tester) async {
      await tester.pumpWidget(buildSubject(
        label: 'Submit',
        isLoading: true,
      ));
      expect(find.text('Submit'), findsNothing);
    });

    testWidgets('does not show spinner when not loading', (tester) async {
      await tester.pumpWidget(buildSubject(isLoading: false));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('LoloPrimaryButton disabled state', () {
    testWidgets('renders with disabled appearance', (tester) async {
      await tester.pumpWidget(buildSubject(isEnabled: false));
      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      // When disabled, onPressed should be null
      expect(button.onPressed, isNull);
    });

    testWidgets('renders with enabled appearance', (tester) async {
      await tester.pumpWidget(buildSubject(isEnabled: true));
      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(button.onPressed, isNotNull);
    });
  });

  group('LoloPrimaryButton isExpanded', () {
    testWidgets('defaults to fullWidth when isExpanded is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(fullWidth: true, isExpanded: null));
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.width, double.infinity);
    });

    testWidgets('isExpanded true overrides fullWidth false', (tester) async {
      await tester.pumpWidget(
        buildSubject(fullWidth: false, isExpanded: true),
      );
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.width, double.infinity);
    });

    testWidgets('isExpanded false overrides fullWidth true', (tester) async {
      await tester.pumpWidget(
        buildSubject(fullWidth: true, isExpanded: false),
      );
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.width, isNull);
    });

    testWidgets('not full width when fullWidth is false', (tester) async {
      await tester.pumpWidget(buildSubject(fullWidth: false));
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.width, isNull);
    });
  });

  group('LoloPrimaryButton semantics', () {
    testWidgets('has button semantics', (tester) async {
      await tester.pumpWidget(buildSubject(label: 'Go'));
      final semantics = tester.getSemantics(find.byType(LoloPrimaryButton));
      expect(semantics.label, 'Go');
    });

    testWidgets('uses custom semanticLabel when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoloPrimaryButton(
              label: 'Go',
              onPressed: () {},
              semanticLabel: 'Navigate forward',
            ),
          ),
        ),
      );
      final semantics = tester.getSemantics(find.byType(LoloPrimaryButton));
      expect(semantics.label, contains('Navigate forward'));
    });
  });
}
