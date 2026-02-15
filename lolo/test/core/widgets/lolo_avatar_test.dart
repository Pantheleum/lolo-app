import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/widgets/lolo_avatar.dart';

void main() {
  Widget buildSubject({
    String? imageUrl,
    String? photoUrl,
    String? name,
    AvatarSize size = AvatarSize.medium,
    IconData? zodiacIcon,
    VoidCallback? onTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: LoloAvatar(
          imageUrl: imageUrl,
          photoUrl: photoUrl,
          name: name,
          size: size,
          zodiacIcon: zodiacIcon,
          onTap: onTap,
        ),
      ),
    );
  }

  group('LoloAvatar initials generation', () {
    testWidgets('shows first initial for single name', (tester) async {
      await tester.pumpWidget(buildSubject(name: 'Sara'));
      expect(find.text('S'), findsOneWidget);
    });

    testWidgets('shows two initials for two-word name', (tester) async {
      await tester.pumpWidget(buildSubject(name: 'Sara Ahmed'));
      expect(find.text('SA'), findsOneWidget);
    });

    testWidgets('shows two initials for multi-word name', (tester) async {
      await tester.pumpWidget(buildSubject(name: 'Sara Ahmed Khan'));
      expect(find.text('SA'), findsOneWidget);
    });

    testWidgets('shows ? for null name', (tester) async {
      await tester.pumpWidget(buildSubject(name: null));
      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('shows ? for empty name', (tester) async {
      await tester.pumpWidget(buildSubject(name: ''));
      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('uppercases initials', (tester) async {
      await tester.pumpWidget(buildSubject(name: 'sara ahmed'));
      expect(find.text('SA'), findsOneWidget);
    });

    testWidgets('handles extra whitespace in name', (tester) async {
      await tester.pumpWidget(buildSubject(name: '  sara   ahmed  '));
      expect(find.text('SA'), findsOneWidget);
    });
  });

  group('LoloAvatar sizing', () {
    testWidgets('small size is 32dp', (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'S',
        size: AvatarSize.small,
      ));
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, 32);
      expect(sizedBox.height, 32);
    });

    testWidgets('medium size is 48dp', (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'S',
        size: AvatarSize.medium,
      ));
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, 48);
      expect(sizedBox.height, 48);
    });

    testWidgets('large size is 64dp', (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'S',
        size: AvatarSize.large,
      ));
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, 64);
      expect(sizedBox.height, 64);
    });
  });

  group('LoloAvatar imageUrl vs photoUrl', () {
    testWidgets('shows initials when no image URLs provided', (tester) async {
      await tester.pumpWidget(buildSubject(name: 'Sara'));
      expect(find.text('S'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('uses imageUrl when provided', (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'Sara',
        imageUrl: 'https://example.com/photo.jpg',
      ));
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('uses photoUrl as fallback when imageUrl is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'Sara',
        photoUrl: 'https://example.com/fallback.jpg',
      ));
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('prefers imageUrl over photoUrl', (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'Sara',
        imageUrl: 'https://example.com/primary.jpg',
        photoUrl: 'https://example.com/fallback.jpg',
      ));
      // Only one Image widget should render
      expect(find.byType(Image), findsOneWidget);
    });
  });

  group('LoloAvatar onTap', () {
    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildSubject(
        name: 'Sara',
        onTap: () => tapped = true,
      ));

      await tester.tap(find.byType(GestureDetector).first);
      expect(tapped, true);
    });

    testWidgets('does not crash when onTap is null', (tester) async {
      await tester.pumpWidget(buildSubject(name: 'Sara'));
      await tester.tap(find.byType(GestureDetector).first);
      // Should not throw
    });
  });

  group('LoloAvatar zodiac badge', () {
    testWidgets('shows zodiac badge when zodiacIcon is provided',
        (tester) async {
      await tester.pumpWidget(buildSubject(
        name: 'Sara',
        zodiacIcon: Icons.star,
      ));
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('does not show zodiac badge when zodiacIcon is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(name: 'Sara'));
      // No PositionedDirectional for badge
      expect(find.byType(PositionedDirectional), findsNothing);
    });
  });

  group('AvatarSize enum', () {
    test('has three values', () {
      expect(AvatarSize.values.length, 3);
    });

    test('contains small, medium, large', () {
      expect(AvatarSize.values, contains(AvatarSize.small));
      expect(AvatarSize.values, contains(AvatarSize.medium));
      expect(AvatarSize.values, contains(AvatarSize.large));
    });
  });
}
