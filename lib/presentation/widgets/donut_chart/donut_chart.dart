import 'package:flutter/material.dart';
import 'dart:math';

class DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(painter: DonutPainter()),
    );
  }
}

class DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.9;

    final paint1 =
    Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    drawDonutSegment(canvas, center, radius, innerRadius, -90, 0.2, paint1);

    final paint2 =
    Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    drawDonutSegment(
      canvas,
      center,
      radius,
      innerRadius,
      -90 + 72,
      0.8,
      paint2,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Бюджет',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  void drawDonutSegment(
      Canvas canvas,
      Offset center,
      double outerRadius,
      double innerRadius,
      double startAngleDegrees,
      double sweepPercentage,
      Paint paint,
      ) {
    final startAngle = radians(startAngleDegrees);
    final sweepAngle = radians(sweepPercentage * 360);

    final outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);

    final path =
    Path()
      ..arcTo(outerRect, startAngle, sweepAngle, false)
      ..arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false)
      ..close();

    canvas.drawPath(path, paint);
  }

  double radians(double degrees) => degrees * (pi / 180);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
