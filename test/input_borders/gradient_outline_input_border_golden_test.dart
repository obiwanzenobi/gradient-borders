import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gradient_borders/gradient_borders.dart';

const _gradient = LinearGradient(colors: [Colors.red, Colors.blue]);

void main() {
  group('GradientOutlineInputBorder golden tests', () {
    testWidgets('unfocused — no label', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientOutlineInputBorder(gradient: _gradient, width: 2.0),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/outline_border_unfocused.png'),
      );
    });

    testWidgets('focused — with floating label (gap)', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientOutlineInputBorder(gradient: _gradient, width: 2.0),
        withLabel: true,
      ));
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/outline_border_focused_with_label.png'),
      );
    });

    testWidgets('focused — no label', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientOutlineInputBorder(gradient: _gradient, width: 2.0),
      ));
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/outline_border_focused_no_label.png'),
      );
    });

    testWidgets('borderAlignment inside', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientOutlineInputBorder(
          gradient: _gradient,
          width: 2.0,
          borderAlignment: OutlineBorderAlignment.inside,
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/outline_border_align_inside.png'),
      );
    });

    testWidgets('large border radius', (tester) async {
      await tester.pumpWidget(_buildScene(
        const GradientOutlineInputBorder(
          gradient: _gradient,
          width: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/outline_border_large_radius.png'),
      );
    });

    testWidgets('RTL — focused with floating label', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: _buildScene(
            const GradientOutlineInputBorder(gradient: _gradient, width: 2.0),
            withLabel: true,
            addDirectionality: false,
          ),
        ),
      );
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/outline_border_rtl_focused.png'),
      );
    });
  });
}

Widget _buildScene(
  InputBorder border, {
  bool withLabel = false,
  bool addDirectionality = true,
}) {
  final content = MaterialApp(
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

  if (!addDirectionality) return content;
  return content;
}
