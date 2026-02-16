import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/widgets/lolo_dialog.dart';

void main() {
  // Use a small surface size so that MediaQuery.size.width - 48 < 400
  // (the LoloDialog ConstrainedBox requires minWidth <= maxWidth).
  const smallSize = Size(400, 800);

  Widget buildDialogDirectly({
    required String title,
    required String body,
    required String confirmLabel,
    required VoidCallback onConfirm,
    String? cancelLabel,
    VoidCallback? onCancel,
    DialogVariant variant = DialogVariant.confirmation,
  }) {
    return MediaQuery(
      data: const MediaQueryData(size: smallSize),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: LoloDialog(
              title: title,
              body: body,
              confirmLabel: confirmLabel,
              onConfirm: onConfirm,
              variant: variant,
              cancelLabel: cancelLabel,
              onCancel: onCancel,
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildAppForShow() {
    return MaterialApp(
      home: const Scaffold(),
    );
  }

  group('LoloDialog widget rendering', () {
    testWidgets('renders title text', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildDialogDirectly(
        title: 'Delete Item',
        body: 'Are you sure?',
        confirmLabel: 'Delete',
        onConfirm: () {},
      ));
      expect(find.text('Delete Item'), findsOneWidget);
    });

    testWidgets('renders body text', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildDialogDirectly(
        title: 'Title',
        body: 'This action cannot be undone.',
        confirmLabel: 'OK',
        onConfirm: () {},
      ));
      expect(find.text('This action cannot be undone.'), findsOneWidget);
    });

    testWidgets('renders confirm button', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildDialogDirectly(
        title: 'Title',
        body: 'Body',
        confirmLabel: 'Confirm',
        onConfirm: () {},
      ));
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders cancel button when cancelLabel is provided',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildDialogDirectly(
        title: 'Title',
        body: 'Body',
        confirmLabel: 'Yes',
        cancelLabel: 'No',
        onConfirm: () {},
        onCancel: () {},
      ));
      expect(find.text('No'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('does not render cancel button when cancelLabel is null',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildDialogDirectly(
        title: 'Title',
        body: 'Body',
        confirmLabel: 'OK',
        onConfirm: () {},
      ));
      expect(find.byType(TextButton), findsNothing);
    });
  });

  group('LoloDialog actions', () {
    testWidgets('calls onConfirm when confirm button is tapped',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      var confirmed = false;
      await tester.pumpWidget(buildDialogDirectly(
        title: 'Title',
        body: 'Body',
        confirmLabel: 'Confirm',
        onConfirm: () => confirmed = true,
      ));

      await tester.tap(find.byType(ElevatedButton));
      expect(confirmed, true);
    });

    testWidgets('calls onCancel when cancel button is tapped',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      var cancelled = false;
      await tester.pumpWidget(buildDialogDirectly(
        title: 'Title',
        body: 'Body',
        confirmLabel: 'Yes',
        cancelLabel: 'Cancel',
        onConfirm: () {},
        onCancel: () => cancelled = true,
      ));

      await tester.tap(find.byType(TextButton));
      expect(cancelled, true);
    });
  });

  group('LoloDialog.show static method', () {
    testWidgets('shows dialog with title and body', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  LoloDialog.show(
                    context: context,
                    title: 'Confirm Delete',
                    body: 'This cannot be undone.',
                    confirmLabel: 'Delete',
                  );
                },
                child: const Text('Open Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Delete'), findsOneWidget);
      expect(find.text('This cannot be undone.'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('uses message alias for body', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  LoloDialog.show(
                    context: context,
                    title: 'Alert',
                    message: 'Message alias text',
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Message alias text'), findsOneWidget);
    });

    testWidgets('defaults confirmLabel to Confirm', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  LoloDialog.show(
                    context: context,
                    title: 'Title',
                    body: 'Body',
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm'), findsOneWidget);
    });

    testWidgets('shows cancel button for confirmation variant',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  LoloDialog.show(
                    context: context,
                    title: 'Title',
                    body: 'Body',
                    variant: DialogVariant.confirmation,
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('does not show cancel button for info variant',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  LoloDialog.show(
                    context: context,
                    title: 'Info',
                    body: 'Some info.',
                    variant: DialogVariant.info,
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('confirm button closes dialog and returns true',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await LoloDialog.show(
                    context: context,
                    title: 'Title',
                    body: 'Body',
                    confirmLabel: 'Yes',
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(result, true);
    });

    testWidgets('cancel button closes dialog and returns false',
        (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await LoloDialog.show(
                    context: context,
                    title: 'Title',
                    body: 'Body',
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(result, false);
    });

    testWidgets('calls onConfirm callback', (tester) async {
      tester.view.physicalSize = smallSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      var confirmed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  LoloDialog.show(
                    context: context,
                    title: 'Title',
                    body: 'Body',
                    onConfirm: () => confirmed = true,
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(confirmed, true);
    });
  });

  group('DialogVariant enum', () {
    test('has three values', () {
      expect(DialogVariant.values.length, 3);
    });

    test('contains confirmation, destructive, info', () {
      expect(DialogVariant.values, contains(DialogVariant.confirmation));
      expect(DialogVariant.values, contains(DialogVariant.destructive));
      expect(DialogVariant.values, contains(DialogVariant.info));
    });
  });
}
