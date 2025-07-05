import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories_impl/transactions_mock.dart';
import '../../pages/bank_account_page/account_provider.dart';
import '../../pages/bank_account_page/bloc_histo/histo_bloc.dart';

class ChartScreen extends StatefulWidget {
  final Map<String, double> values;
  final BuildContext context;
  const ChartScreen({super.key, required this.values, required this.context});

  @override
  State<ChartScreen> createState() => _ChartScreenState(values: values, ccontext: context);
}

class _ChartScreenState extends State<ChartScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late int showingTooltip;
  final Map<String, double> values;
  final BuildContext ccontext;
  final _histoBloc = HistoBloc(MockTransactionRepository());

  List<bool> _isSelected = [true, false];

  _ChartScreenState({required this.values, required this.ccontext});

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateChart() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return BarChart(
                    BarChartData(
                      maxY: values.values.toList().map((n) => n.abs()).toList().reduce(max),
                      alignment: BarChartAlignment.spaceAround,
                      groupsSpace: 4,
                      barTouchData: BarTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        touchCallback: (event, response) {
                          if (response != null && response.spot != null && event is FlTapUpEvent) {
                            setState(() {
                              final x = response.spot!.touchedBarGroup.x;
                              final isShowing = showingTooltip == x;
                              if (isShowing) {
                                showingTooltip = -1;
                              } else {
                                showingTooltip = x;
                              }
                            });
                          }
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${values.keys.toList()[value.toInt()]}',
                                style: const TextStyle(fontSize: 11),
                              );
                            },
                            reservedSize: 30,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: _buildBarGroups(values.values.toList()),
                    ),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linear,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ToggleButtons(
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = (i == index);
                    if (!_isSelected[0]){
                      Provider.of<AccountProvider>(ccontext, listen: false).changetype('month');
                    }
                    else {
                      Provider.of<AccountProvider>(ccontext, listen: false).changetype('day');
                    }
                  }
                }
                );
                _updateChart();
              },
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('По дням', style: TextStyle(fontSize: 20),)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('По месяцам', style: TextStyle(fontSize: 20),)),
              ],
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Color(0xFF2AE881),
              color: Colors.grey,
              //constraints: BoxConstraints(minHeight: 40, minWidth: 80),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<double> values) {
    return List.generate(values.length, (index) {
      final isTouched = index == showingTooltip;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            color: (values[index].abs() == values[index]) ? Color(0xFF2AE881) : Color(0xFFFF5F00),
            toY: values[index].abs(),
            width: 10,
          ),
        ],
        showingTooltipIndicators: isTouched ? [0] : [],
      );
    });
  }
}