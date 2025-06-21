import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'bloc/ta_bloc.dart';

class TransactionsAnalysis extends StatelessWidget {
  final bool isIncome;

  const TransactionsAnalysis({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaBloc(),
      child: TransactionsAnalysisState(isIncome: isIncome),
    );
  }
}

class TransactionsAnalysisState extends StatelessWidget {
  final bool isIncome;

  const TransactionsAnalysisState({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text(
          'Анализ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Color(0xFFCAC4D0), width: 2
                )
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Период: начало',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2AE881),
                      textStyle: TextStyle(
                      )
                    ),
                    onPressed: () {},
                    child: Text(
                      'месяц год',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFCAC4D0), width: 2
                )
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Период: конец',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2AE881),
                        textStyle: TextStyle(
                        )
                    ),
                    onPressed: () {},
                    child: Text(
                      'месяц год',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFCAC4D0), width: 2
                )
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Сумма',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '... Р',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xFFCAC4D0), width: 2
                  )
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Center(
                  child: DonutChart(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimplePieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: PieChartPainter(),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Ремонт квартиры - 20%
    final paint1 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.1415926535 / 180),
      0.2 * 2 * 3.1415926535,
      true,
      paint1,
    );

    // На собачку - 80%
    final paint2 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.1415926535 / 180) + 0.2 * 2 * 3.1415926535,
      0.8 * 2 * 3.1415926535,
      true,
      paint2,
    );

    // Добавление текста (опционально)
    final textPainter1 = TextPainter(
      text: TextSpan(
        text: '20% Ремонт',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout();
    textPainter1.paint(
      canvas,
      Offset(center.dx - textPainter1.width / 2, center.dy - 20),
    );

    final textPainter2 = TextPainter(
      text: TextSpan(
        text: '80% Собачка',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout();
    textPainter2.paint(
      canvas,
      Offset(center.dx - textPainter2.width / 2, center.dy + 10),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: CustomPaint(
        painter: DonutPainter(),
      ),
    );
  }
}

class DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.9; // Радиус пустого центра

    // Ремонт квартиры - 20%
    final paint1 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    drawDonutSegment(canvas, center, radius, innerRadius, -90, 0.2, paint1);

    // На собачку - 80%
    final paint2 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    drawDonutSegment(canvas, center, radius, innerRadius, -90 + 72, 0.8, paint2);

    // Добавление текста в центр (опционально)
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Бюджет',
        style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  void drawDonutSegment(Canvas canvas, Offset center, double outerRadius,
      double innerRadius, double startAngleDegrees, double sweepPercentage, Paint paint) {
    final startAngle = radians(startAngleDegrees);
    final sweepAngle = radians(sweepPercentage * 360);

    final outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);

    final path = Path()
      ..arcTo(outerRect, startAngle, sweepAngle, false)
      ..arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false)
      ..close();

    canvas.drawPath(path, paint);
  }

  double radians(double degrees) => degrees * (pi / 180);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}