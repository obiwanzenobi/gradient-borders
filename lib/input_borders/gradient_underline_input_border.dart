import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class GradientUnderlineInputBorder extends InputBorder {
  const GradientUnderlineInputBorder({
    required this.gradient,
    this.width = 1.0,
    this.gapPadding = 4.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  final double width;

  final BorderRadius borderRadius;

  final Gradient gradient;

  final double gapPadding;

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return this;
  }

  @override
  bool get isOutline => true;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        borderRadius
            .resolve(textDirection)
            .toRRect(rect)
            .deflate(borderSide.width),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = _getPaint(rect);
    Rect underlineRect =
        Rect.fromLTWH(rect.left, rect.height - width, rect.width, width);
    canvas.drawRect(underlineRect, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return GradientUnderlineInputBorder(
      width: width * t,
      borderRadius: borderRadius * t,
      gradient: gradient,
    );
  }

  Paint _getPaint(Rect rect) {
    return Paint()
      ..strokeWidth = width
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;
  }

}
