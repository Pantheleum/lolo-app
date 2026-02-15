import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';

void main() {
  final testItems = [
    const ChipItem(label: 'Say'),
    const ChipItem(label: 'Do'),
    const ChipItem(label: 'Buy'),
    const ChipItem(label: 'Go'),
  ];

  Widget buildSubject({
    List<ChipItem>? items,
    Set<int> selectedIndices = const {},
    ValueChanged<Set<int>>? onSelectionChanged,
    ChipSelectionMode selectionMode = ChipSelectionMode.single,
    bool scrollable = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: LoloChipGroup(
          items: items ?? testItems,
          selectedIndices: selectedIndices,
          onSelectionChanged: onSelectionChanged ?? (_) {},
          selectionMode: selectionMode,
          scrollable: scrollable,
        ),
      ),
    );
  }

  group('LoloChipGroup rendering', () {
    testWidgets('renders all chip items', (tester) async {
      await tester.pumpWidget(buildSubject());
      expect(find.text('Say'), findsOneWidget);
      expect(find.text('Do'), findsOneWidget);
      expect(find.text('Buy'), findsOneWidget);
      expect(find.text('Go'), findsOneWidget);
    });

    testWidgets('renders in Wrap by default', (tester) async {
      await tester.pumpWidget(buildSubject(scrollable: false));
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('renders in SingleChildScrollView when scrollable',
        (tester) async {
      await tester.pumpWidget(buildSubject(scrollable: true));
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('renders chip with icon when provided', (tester) async {
      final itemsWithIcon = [
        const ChipItem(label: 'Heart', icon: Icons.favorite),
      ];
      await tester.pumpWidget(buildSubject(items: itemsWithIcon));
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });

  group('LoloChipGroup single selection', () {
    testWidgets('calls onSelectionChanged with tapped index', (tester) async {
      Set<int>? result;
      await tester.pumpWidget(buildSubject(
        selectionMode: ChipSelectionMode.single,
        onSelectionChanged: (selected) => result = selected,
      ));

      await tester.tap(find.text('Do'));
      expect(result, {1});
    });

    testWidgets('clears previous selection in single mode', (tester) async {
      Set<int>? result;
      await tester.pumpWidget(buildSubject(
        selectionMode: ChipSelectionMode.single,
        selectedIndices: {0},
        onSelectionChanged: (selected) => result = selected,
      ));

      await tester.tap(find.text('Buy'));
      expect(result, {2});
      expect(result!.contains(0), false);
    });
  });

  group('LoloChipGroup multi selection', () {
    testWidgets('adds index to selection in multi mode', (tester) async {
      Set<int>? result;
      await tester.pumpWidget(buildSubject(
        selectionMode: ChipSelectionMode.multi,
        selectedIndices: {0},
        onSelectionChanged: (selected) => result = selected,
      ));

      await tester.tap(find.text('Buy'));
      expect(result, {0, 2});
    });

    testWidgets('removes index from selection when already selected',
        (tester) async {
      Set<int>? result;
      await tester.pumpWidget(buildSubject(
        selectionMode: ChipSelectionMode.multi,
        selectedIndices: {0, 2},
        onSelectionChanged: (selected) => result = selected,
      ));

      await tester.tap(find.text('Say'));
      expect(result, {2});
    });

    testWidgets('shows check icon for selected chips in multi mode',
        (tester) async {
      await tester.pumpWidget(buildSubject(
        selectionMode: ChipSelectionMode.multi,
        selectedIndices: {0},
      ));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('does not show check icon in single mode', (tester) async {
      await tester.pumpWidget(buildSubject(
        selectionMode: ChipSelectionMode.single,
        selectedIndices: {0},
      ));
      expect(find.byIcon(Icons.check), findsNothing);
    });
  });

  group('ChipItem', () {
    test('creates with label only', () {
      const item = ChipItem(label: 'Test');
      expect(item.label, 'Test');
      expect(item.icon, isNull);
      expect(item.color, isNull);
    });

    test('creates with all fields', () {
      const item = ChipItem(
        label: 'Heart',
        icon: Icons.favorite,
        color: Colors.red,
      );
      expect(item.label, 'Heart');
      expect(item.icon, Icons.favorite);
      expect(item.color, Colors.red);
    });
  });

  group('ChipSelectionMode', () {
    test('has two values', () {
      expect(ChipSelectionMode.values.length, 2);
    });

    test('contains single and multi', () {
      expect(ChipSelectionMode.values, contains(ChipSelectionMode.single));
      expect(ChipSelectionMode.values, contains(ChipSelectionMode.multi));
    });
  });
}
