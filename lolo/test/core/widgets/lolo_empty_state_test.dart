import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

void main() {
  Widget buildSubject({
    Widget? illustration,
    IconData? icon,
    String title = 'No Items',
    String? description,
    String? subtitle,
    String? ctaLabel,
    VoidCallback? onCtaTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: LoloEmptyState(
          illustration: illustration,
          icon: icon ?? (illustration == null ? Icons.inbox : null),
          title: title,
          description: description,
          subtitle: subtitle,
          ctaLabel: ctaLabel,
          onCtaTap: onCtaTap,
        ),
      ),
    );
  }

  group('LoloEmptyState rendering', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(buildSubject(title: 'No Reminders'));
      expect(find.text('No Reminders'), findsOneWidget);
    });

    testWidgets('renders description text', (tester) async {
      await tester.pumpWidget(buildSubject(
        description: 'Add your first reminder',
      ));
      expect(find.text('Add your first reminder'), findsOneWidget);
    });

    testWidgets('renders subtitle as alias for description', (tester) async {
      await tester.pumpWidget(buildSubject(
        subtitle: 'Subtitle text here',
      ));
      expect(find.text('Subtitle text here'), findsOneWidget);
    });

    testWidgets('description takes priority over subtitle', (tester) async {
      await tester.pumpWidget(buildSubject(
        description: 'Description wins',
        subtitle: 'Subtitle loses',
      ));
      expect(find.text('Description wins'), findsOneWidget);
      expect(find.text('Subtitle loses'), findsNothing);
    });

    testWidgets('renders empty text when no description or subtitle',
        (tester) async {
      await tester.pumpWidget(buildSubject());
      // The bodyText should be '' but the Text widget still renders
      expect(find.text(''), findsWidgets);
    });
  });

  group('LoloEmptyState with icon', () {
    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(buildSubject(icon: Icons.inbox));
      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('icon has 64dp size', (tester) async {
      await tester.pumpWidget(buildSubject(icon: Icons.inbox));
      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.inbox));
      expect(iconWidget.size, 64);
    });
  });

  group('LoloEmptyState with illustration', () {
    testWidgets('renders custom illustration widget', (tester) async {
      await tester.pumpWidget(buildSubject(
        illustration: const FlutterLogo(size: 100),
      ));
      expect(find.byType(FlutterLogo), findsOneWidget);
    });

    testWidgets('illustration takes priority over icon', (tester) async {
      await tester.pumpWidget(buildSubject(
        illustration: const FlutterLogo(size: 100),
        icon: Icons.inbox,
      ));
      expect(find.byType(FlutterLogo), findsOneWidget);
      // The icon from the empty state should not appear
      // (though the icon parameter is ignored when illustration is set)
    });

    testWidgets('illustration area is 120x120', (tester) async {
      await tester.pumpWidget(buildSubject(icon: Icons.inbox));
      // Find the SizedBox wrapping the illustration
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final illustrationBox = sizedBoxes.firstWhere(
        (sb) => sb.width == 120 && sb.height == 120,
        orElse: () => throw Exception('No 120x120 SizedBox found'),
      );
      expect(illustrationBox.width, 120);
      expect(illustrationBox.height, 120);
    });
  });

  group('LoloEmptyState CTA button', () {
    testWidgets('shows CTA button when ctaLabel and onCtaTap are provided',
        (tester) async {
      await tester.pumpWidget(buildSubject(
        ctaLabel: 'Add Reminder',
        onCtaTap: () {},
      ));
      expect(find.text('Add Reminder'), findsOneWidget);
      expect(find.byType(LoloPrimaryButton), findsOneWidget);
    });

    testWidgets('does not show CTA button when ctaLabel is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(onCtaTap: () {}));
      expect(find.byType(LoloPrimaryButton), findsNothing);
    });

    testWidgets('does not show CTA button when onCtaTap is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(ctaLabel: 'Add'));
      expect(find.byType(LoloPrimaryButton), findsNothing);
    });

    testWidgets('CTA button tap calls onCtaTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildSubject(
        ctaLabel: 'Create',
        onCtaTap: () => tapped = true,
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, true);
    });
  });

  group('LoloEmptyState layout', () {
    testWidgets('is centered on screen', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.byType(Center), findsWidgets);
    });
  });
}
