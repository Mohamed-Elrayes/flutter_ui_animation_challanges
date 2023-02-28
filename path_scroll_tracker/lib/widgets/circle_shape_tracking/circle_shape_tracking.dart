import 'dart:math';

import 'package:flutter/material.dart';

class CircleShapeTracking extends StatelessWidget {
  const CircleShapeTracking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, _) {
            return CustomPaint(
              // size: ,
              size: const Size(10, 10),
              painter: CircleShapeTrackingPaint(
                backgroundColor: Colors.red,
                fillValue: value,
                strokeWidth: 10,
                radius: 20,
              ),
            );
          }),
    );
  }
}

class CircleShapeTrackingPaint extends CustomPainter {
  CircleShapeTrackingPaint({
    required this.backgroundColor,
    required this.strokeWidth,
    required this.fillValue,
    this.radius = 30.0,
  });

  /// A variable that is used to set the background color of the circle.
  final Color backgroundColor;

  /// A variable that is used to set the width of the stroke.
  final double strokeWidth;

  /// from 0.0 to 1.0 => 0.0 empty , 1.0 fill
  final double fillValue;

  /// A variable that is used to set the radius of the circle.
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    // center in canvas
    final center = Offset(size.width / 2, size.height / 2);
    var paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
        center, radius, paint..color = backgroundColor.withOpacity(0.5));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * fillValue,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleShapeTrackingPaint oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.fillValue != fillValue ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.backgroundColor != backgroundColor;
}
