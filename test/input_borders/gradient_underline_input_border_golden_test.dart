import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gradient_borders/gradient_borders.dart';

const _gradient = LinearGradient(colors: [Colors.red, Colors.blue]);

void main() {
  group('GradientUnderlineInputBorder golden tests', () {
    testWidgets('unfocused — default width', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientUnderlineInputBorder(gradient: _gradient),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/underline_border_unfocused.png'),
      );
    });

    testWidgets('focused', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientUnderlineInputBorder(gradient: _gradient),
      ));
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/underline_border_focused.png'),
      );
    });

    testWidgets('wide border', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientUnderlineInputBorder(gradient: _gradient, width: 4.0),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/underline_border_wide.png'),
      );
    });

    testWidgets('with floating label', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientUnderlineInputBorder(gradient: _gradient),
        withLabel: true,
      ));
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/underline_border_focused_with_label.png'),
      );
    });

    testWidgets('radial gradient', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientUnderlineInputBorder(
          gradient: RadialGradient(colors: [Colors.green, Colors.yellow]),
          width: 3.0,
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/underline_border_radial_gradient.png'),
      );
    });
  });
}

Widget _buildScene(InputBorder border, {bool withLabel = false}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RepaintBoundary(
          key: const ValueKey('scene'),
          child: SizedBox(
            width: 280,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  labelText: withLabel ? 'Label' : null,
                  hintText: 'Hint text',
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
