import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gradient_borders/gradient_borders.dart';

const _gradient = LinearGradient(colors: [Colors.red, Colors.blue]);
const _rect = Rect.fromLTWH(0, 0, 200, 100);

void main() {
  group('GradientOutlineInputBorder', () {
    group('default values', () {
      test('width defaults to 1.0', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        expect(border.width, 1.0);
      });

      test('gapPadding defaults to 4.0', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        expect(border.gapPadding, 4.0);
      });

      test('borderRadius defaults to circular(4)', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        expect(
          border.borderRadius,
          const BorderRadius.all(Radius.circular(4)),
        );
      });

      test('borderAlignment defaults to onEdge', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        expect(border.borderAlignment, OutlineBorderAlignment.onEdge);
      });
    });

    group('properties', () {
      test('isOutline returns true', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        expect(border.isOutline, isTrue);
      });

      test('dimensions returns EdgeInsets.all(width)', () {
        const border = GradientOutlineInputBorder(gradient: _gradient, width: 3.0);
        expect(border.dimensions, EdgeInsets.all(3.0));
      });

      test('copyWith returns same instance (current behaviour)', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        expect(border.copyWith(), same(border));
      });
    });

    group('scale', () {
      test('returns a GradientOutlineInputBorder', () {
        const border = GradientOutlineInputBorder(gradient: _gradient, width: 2.0);
        expect(border.scale(0.5), isA<GradientOutlineInputBorder>());
      });

      test('scales width by t', () {
        const border = GradientOutlineInputBorder(gradient: _gradient, width: 4.0);
        final scaled = border.scale(0.5) as GradientOutlineInputBorder;
        expect(scaled.width, 2.0);
      });

      test('scales borderRadius by t', () {
        const border = GradientOutlineInputBorder(
          gradient: _gradient,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );
        final scaled = border.scale(0.5) as GradientOutlineInputBorder;
        expect(scaled.borderRadius, const BorderRadius.all(Radius.circular(4)));
      });
    });

    group('getInnerPath', () {
      test('returns a non-null Path', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        final path = border.getInnerPath(_rect);
        expect(path, isNotNull);
      });

      test('inner path bounds equal outer bounds (borderSide defaults to none, deflate is 0)', () {
        const border = GradientOutlineInputBorder(gradient: _gradient, width: 2.0);
        final innerPath = border.getInnerPath(_rect);
        final outerPath = border.getOuterPath(_rect);
        // borderSide defaults to BorderSide.none, so deflate(borderSide.width) == deflate(0)
        expect(
          innerPath.getBounds().width,
          closeTo(outerPath.getBounds().width, 0.1),
        );
      });
    });

    group('getOuterPath', () {
      test('returns a non-null Path', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        final path = border.getOuterPath(_rect);
        expect(path, isNotNull);
      });

      test('outer path bounds match the rect', () {
        const border = GradientOutlineInputBorder(gradient: _gradient);
        final path = border.getOuterPath(_rect);
        final bounds = path.getBounds();
        expect(bounds.width, closeTo(_rect.width, 0.1));
        expect(bounds.height, closeTo(_rect.height, 0.1));
      });
    });

    group('paint — no gap', () {
      testWidgets('renders TextField without throwing', (tester) async {
        await tester.pumpWidget(
          _wrapTextField(
            border: const GradientOutlineInputBorder(gradient: _gradient),
          ),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('renders with borderAlignment inside without throwing', (tester) async {
        await tester.pumpWidget(
          _wrapTextField(
            border: const GradientOutlineInputBorder(
              gradient: _gradient,
              borderAlignment: OutlineBorderAlignment.inside,
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    });

    group('paint — with gap (focused label)', () {
      testWidgets('renders focused LTR TextField without throwing', (tester) async {
        await tester.pumpWidget(
          _wrapTextField(
            border: const GradientOutlineInputBorder(gradient: _gradient),
            withLabel: true,
          ),
        );
        // Focus the field to trigger the gap path
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });

      testWidgets('renders focused RTL TextField without throwing', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.rtl,
            child: _wrapTextField(
              border: const GradientOutlineInputBorder(gradient: _gradient),
              withLabel: true,
              addDirectionality: false,
            ),
          ),
        );
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    });

    group('gradient types', () {
      testWidgets('RadialGradient renders without throwing', (tester) async {
        await tester.pumpWidget(
          _wrapTextField(
            border: const GradientOutlineInputBorder(
              gradient: RadialGradient(colors: [Colors.green, Colors.yellow]),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    });
  });
}

Widget _wrapTextField({
  required InputBorder border,
  bool withLabel = false,
  bool addDirectionality = true,
}) {
  final field = MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            labelText: withLabel ? 'Label' : null,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
        ),
      ),
    ),
  );

  if (!addDirectionality) {
    return field;
  }
  return field;
}
