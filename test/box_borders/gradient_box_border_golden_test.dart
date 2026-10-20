import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gradient_borders/gradient_borders.dart';

const _gradient = LinearGradient(colors: [Colors.red, Colors.blue]);
const _radialGradient = RadialGradient(colors: [Colors.green, Colors.yellow]);
const _sweepGradient = SweepGradient(colors: [Colors.red, Colors.blue]);

void main() {
  group('GradientBoxBorder golden tests', () {
    testWidgets('rectangle — strokeAlign inside', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: _gradient,
              width: 4.0,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_rect_align_inside.png'),
      );
    });

    testWidgets('rectangle — strokeAlign center', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: _gradient,
              width: 4.0,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_rect_align_center.png'),
      );
    });

    testWidgets('rectangle — strokeAlign outside', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: _gradient,
              width: 4.0,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_rect_align_outside.png'),
      );
    });

    testWidgets('rounded rectangle', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(gradient: _gradient, width: 4.0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_rrect.png'),
      );
    });

    testWidgets('circle shape', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: GradientBoxBorder(gradient: _gradient, width: 4.0),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_circle.png'),
      );
    });

    testWidgets('radial gradient', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(gradient: _radialGradient, width: 4.0),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_radial_gradient.png'),
      );
    });

    testWidgets('sweep gradient', (tester) async {
      await tester.pumpWidget(_buildScene(
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(gradient: _sweepGradient, width: 4.0),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ));
      await expectLater(
        find.byKey(const ValueKey('scene')),
        matchesGoldenFile('goldens/box_border_sweep_gradient.png'),
      );
    });
  });
}

Widget _buildScene(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RepaintBoundary(
          key: const ValueKey('scene'),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: child,
          ),
        ),
      ),
    ),
  );
}
