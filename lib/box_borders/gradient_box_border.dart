import 'package:flutter/widgets.dart';

class GradientBoxBorder extends BoxBorder {
  const GradientBoxBorder({
    required this.gradient,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.width = 1.0,
  });

  final Gradient gradient;
  final double strokeAlign;
  final double width;

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  BorderSide get top => BorderSide.none;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  /// Get the amount of the stroke width that lies inside of the [BorderSide].
  ///
  /// For example, this will return the [width] for a [strokeAlign] of -1, half
  /// the [width] for a [strokeAlign] of 0, and 0 for a [strokeAlign] of 1.
  double get strokeInset => width * (1 - (1 + strokeAlign) / 2);

  /// Get the amount of the stroke width that lies outside of the [BorderSide].
  ///
  /// For example, this will return 0 for a [strokeAlign] of -1, half the
  /// [width] for a [strokeAlign] of 0, and the [width] for a [strokeAlign]
  /// of 1.
  double get strokeOutset => width * (1 + strokeAlign) / 2;

  /// The offset of the stroke, taking into account the stroke alignment.
  ///
  /// For example, this will return the negative [width] of the stroke
  /// for a [strokeAlign] of -1, 0 for a [strokeAlign] of 0, and the
  /// [width] for a [strokeAlign] of -1.
  double get strokeOffset => width * strokeAlign;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    switch (shape) {
      case BoxShape.circle:
        assert(
          borderRadius == null,
          'A borderRadius can only be given for rectangular boxes.',
        );
        _paintCircle(canvas, rect);
        break;
      case BoxShape.rectangle:
        if (borderRadius != null) {
          _paintRRect(canvas, rect, borderRadius);
          return;
        }
        _paintRect(canvas, rect);
        break;
    }
  }

  void _paintRect(Canvas canvas, Rect rect) {
    final rectWithOffset = switch (strokeAlign) {
      < 0 => rect.deflate(strokeInset / 2),
      > 0 => rect.inflate(strokeOutset / 2),
      _ => rect,
    };
    canvas.drawRect(rectWithOffset, _getPaint(rect));
  }

  void _paintRRect(Canvas canvas, Rect rect, BorderRadius borderRadius) {
    var rrect = borderRadius.toRRect(rect);
    if (strokeOffset == 0) {
      rrect = rrect.deflate(strokeOffset);
    } else if (strokeAlign > 0) {
      rrect = rrect.inflate(strokeOffset / 2);
    } else {
      rrect = rrect.deflate(strokeInset / 2);
    }

    canvas.drawRRect(rrect, _getPaint(rect));
  }

  void _paintCircle(Canvas canvas, Rect rect) {
    final paint = _getPaint(rect);
    final offset = switch (strokeAlign) {
          < 0 => -strokeInset,
          > 0 => strokeOutset,
          _ => 0,
        } /
        2;

    final radius = rect.shortestSide / 2.0;
    canvas.drawCircle(rect.center, radius + offset, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }

  Paint _getPaint(Rect rect) {
    return Paint()
      ..strokeWidth = width
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;
  }
}
