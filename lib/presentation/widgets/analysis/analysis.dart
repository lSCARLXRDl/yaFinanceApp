import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';

import '../../../data/mappers/date_map.dart';
import '../date_picker/date_picker.dart';
import 'date_provider.dart';
import 'bloc/ta_bloc.dart';

class TransactionsAnalysis extends StatelessWidget {
  final bool isIncome;

  const TransactionsAnalysis({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DateProvider(),
      child: BlocProvider(
        create:
            (_) =>
                TaBloc(MockTransactionRepository(), MockCategoriesRepository()),
        child: TransactionsAnalysisState(isIncome: isIncome),
      ),
    );
  }
}

class TransactionsAnalysisState extends StatelessWidget {
  final bool isIncome;

  const TransactionsAnalysisState({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    final dateBloc = BlocProvider.of<TaBloc>(context);
    (isIncome)
        ? dateBloc.add(
          InitIncomeEvent(
            DateMapper.toDate(Provider.of<DateProvider>(context).startDate),
            DateMapper.toDate(Provider.of<DateProvider>(context).endDate),
          ),
        )
        : dateBloc.add(
          InitExpensesEvent(
            DateMapper.toDate(Provider.of<DateProvider>(context).startDate),
            DateMapper.toDate(Provider.of<DateProvider>(context).endDate),
          ),
        );
    return BlocBuilder<TaBloc, TaState>(
      builder: (context, state) {
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
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
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
                          textStyle: TextStyle(),
                        ),
                        onPressed: () async {
                          final date = await showYaDatePicker(context: context);
                          if (date != null)
                            Provider.of<DateProvider>(
                              context,
                              listen: false,
                            ).changeStartDate(date);
                        },
                        child: Text(
                          Provider.of<DateProvider>(
                            context,
                            listen: false,
                          ).startDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
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
                          textStyle: TextStyle(),
                        ),
                        onPressed: () async {
                          final date = await showYaDatePicker(context: context);
                          if (date != null)
                            Provider.of<DateProvider>(
                              context,
                              listen: false,
                            ).changeEndDate(date);
                        },
                        child: Text(
                          Provider.of<DateProvider>(
                            context,
                            listen: false,
                          ).endDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    (state is TaLoaded)
                        ? () {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFCAC4D0),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Сумма',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '${state.totalAmount.toString()} ₽',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (state.categListWithTransac.length > 0)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFCAC4D0),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  child: Center(child: DonutChart()),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.categListWithTransac.length,
                                  itemBuilder: (context, index) {
                                    return ExpandableListItem(
                                      list_categ: state.categListWithTransac[index],
                                      percent: state.percentList[index],
                                      amount: state.amountList[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }()
                        : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: CustomPaint(painter: DonutPainter()),
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
    final paint1 =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;
    drawDonutSegment(canvas, center, radius, innerRadius, -90, 0.2, paint1);

    // На собачку - 80%
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

    // Добавление текста в центр (опционально)
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

class ExpandableListItem extends StatefulWidget {
  final List list_categ;
  final String percent;
  final double amount;

  const ExpandableListItem({
    super.key,
    required this.list_categ,
    required this.percent,
    required this.amount
  });

  @override
  State<ExpandableListItem> createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFCAC4D0),
                width: 1,
              ),
            ),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFEF7FF),
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () async {
              setState(() => _isExpanded = !_isExpanded);
            },
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.list_categ[0].category.emoji,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list_categ[0].category.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        if (widget.list_categ[0].comment != null)
                          Text(
                            widget.list_categ[0].comment,
                            style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w400,
                            color: Color(
                              0xFF49454F,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.percent} %',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.amount} ₽',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 20),
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xFFCAC4D0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(height: (widget.list_categ.length * 100 < 300) ? widget.list_categ.length * 100 : 300, child: CatTile(list_categ: widget.list_categ))
      ],
    );
  }
}

class CatTile extends StatefulWidget {
  const CatTile({
    super.key,
    required this.list_categ,
  });

  final list_categ;

  @override
  State<CatTile> createState() => _CatTileState();
}

class _CatTileState extends State<CatTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list_categ.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFE6DEE8),
            border: Border(
              bottom: BorderSide(color: Color(0xFFB1ACB6), width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.list_categ[index].category.emoji,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list_categ[index].category.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        (widget.list_categ[index].comment != null)
                            ? Text(
                              widget.list_categ[index].comment,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF49454F),
                              ),
                            )
                            : Text(
                              ' ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF49454F),
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.list_categ[index].amount} ₽',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${widget.list_categ[index].transactionDate.toString().split(' ')[1].split(':')[0]}:${widget.list_categ[index].transactionDate.toString().split(' ')[1].split(':')[1]}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 20),
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xFFCAC4D0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
