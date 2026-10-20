import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gradient_borders/gradient_borders.dart';

const _gradient = LinearGradient(colors: [Colors.red, Colors.blue]);
const _radialGradient = RadialGradient(colors: [Colors.green, Colors.yellow]);

void main() {
  group('GradientBoxBorder', () {
    group('default values', () {
      test('width defaults to 1.0', () {
        const border = GradientBoxBorder(gradient: _gradient);
        expect(border.width, 1.0);
      });

      test('strokeAlign defaults to BorderSide.strokeAlignInside', () {
        const border = GradientBoxBorder(gradient: _gradient);
        expect(border.strokeAlign, BorderSide.strokeAlignInside);
      });
    });

    group('properties', () {
      test('top returns BorderSide.none', () {
        const border = GradientBoxBorder(gradient: _gradient);
        expect(border.top, BorderSide.none);
      });

      test('bottom returns BorderSide.none', () {
        const border = GradientBoxBorder(gradient: _gradient);
        expect(border.bottom, BorderSide.none);
      });

      test('isUniform is always true', () {
        const border = GradientBoxBorder(gradient: _gradient);
        expect(border.isUniform, isTrue);
      });

      test('dimensions returns EdgeInsets.all(width)', () {
        const border = GradientBoxBorder(gradient: _gradient, width: 3.0);
        expect(border.dimensions, EdgeInsets.all(3.0));
      });
    });

    group('strokeInset', () {
      test('strokeAlign = -1 (inside): inset equals full width', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: -1,
        );
        expect(border.strokeInset, 4.0);
      });

      test('strokeAlign = 0 (center): inset equals half width', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: 0,
        );
        expect(border.strokeInset, 2.0);
      });

      test('strokeAlign = 1 (outside): inset is zero', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: 1,
        );
        expect(border.strokeInset, 0.0);
      });
    });

    group('strokeOutset', () {
      test('strokeAlign = -1 (inside): outset is zero', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: -1,
        );
        expect(border.strokeOutset, 0.0);
      });

      test('strokeAlign = 0 (center): outset equals half width', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: 0,
        );
        expect(border.strokeOutset, 2.0);
      });

      test('strokeAlign = 1 (outside): outset equals full width', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: 1,
        );
        expect(border.strokeOutset, 4.0);
      });
    });

    group('strokeOffset', () {
      test('strokeAlign = -1: offset is negative width', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: -1,
        );
        expect(border.strokeOffset, -4.0);
      });

      test('strokeAlign = 0: offset is zero', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: 0,
        );
        expect(border.strokeOffset, 0.0);
      });

      test('strokeAlign = 1: offset equals full width', () {
        const border = GradientBoxBorder(
          gradient: _gradient,
          width: 4.0,
          strokeAlign: 1,
        );
        expect(border.strokeOffset, 4.0);
      });
    });

    group('scale', () {
      test('returns a GradientBoxBorder', () {
        const border = GradientBoxBorder(gradient: _gradient);
        expect(border.scale(2.0), isA<GradientBoxBorder>());
      });
    });

    group('paint — rectangle shape', () {
      testWidgets('renders with strokeAlign inside without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
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
          ),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('renders with strokeAlign center without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
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
          ),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('renders with strokeAlign outside without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
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
          ),
        );
        expect(tester.takeException(), isNull);
      });
    });

    group('paint — rectangle shape with borderRadius', () {
      testWidgets('renders rounded rectangle without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
            DecoratedBox(
              decoration: BoxDecoration(
                border: GradientBoxBorder(gradient: _gradient, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    });

    group('paint — circle shape', () {
      testWidgets('renders circle with strokeAlign inside without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: GradientBoxBorder(
                  gradient: _gradient,
                  width: 4.0,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('renders circle with strokeAlign outside without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: GradientBoxBorder(
                  gradient: _gradient,
                  width: 4.0,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    });

    group('gradient types', () {
      testWidgets('RadialGradient renders without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
            DecoratedBox(
              decoration: BoxDecoration(
                border: GradientBoxBorder(gradient: _radialGradient),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('SweepGradient renders without throwing', (tester) async {
        await tester.pumpWidget(
          _wrap(
            DecoratedBox(
              decoration: BoxDecoration(
                border: GradientBoxBorder(
                  gradient: const SweepGradient(
                    colors: [Colors.red, Colors.blue],
                  ),
                ),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    });
  });
}

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
