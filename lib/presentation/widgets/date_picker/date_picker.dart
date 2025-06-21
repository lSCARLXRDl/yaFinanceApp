import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerDialog extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const DatePickerDialog({
    super.key,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late DateTime _selectedDate;
  late int _currentYear;
  late int _currentMonth;
  late List<DateTime> _daysInMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _currentYear = _selectedDate.year;
    _currentMonth = _selectedDate.month;
    _updateDaysInMonth();
  }

  void _updateDaysInMonth() {
    final firstDay = DateTime(_currentYear, _currentMonth, 1);
    final lastDay = DateTime(_currentYear, _currentMonth + 1, 0);
    _daysInMonth = _generateDays(firstDay, lastDay);
  }

  List<DateTime> _generateDays(DateTime firstDay, DateTime lastDay) {
    final days = <DateTime>[];
    final weekday = firstDay.weekday;
    for (int i = 1; i < weekday; i++) {
      days.add(firstDay.subtract(Duration(days: weekday - i)));
    }
    for (int i = 0; i < lastDay.day; i++) {
      days.add(DateTime(firstDay.year, firstDay.month, i + 1));
    }
    final remaining = 7 - (days.length % 7);
    if (remaining < 7) {
      for (int i = 1; i <= remaining; i++) {
        days.add(lastDay.add(Duration(days: i)));
      }
    }
    return days;
  }

  void _onDateSelected(DateTime date) {
    if (date.month == _currentMonth) {
      setState(() {
        _selectedDate = date;
      });
    } else if (date.month < _currentMonth) {
      setState(() {
        _currentMonth--;
        if (_currentMonth < 1) {
          _currentMonth = 12;
          _currentYear--;
        }
        _updateDaysInMonth();
      });
    } else {
      setState(() {
        _currentMonth++;
        if (_currentMonth > 12) {
          _currentMonth = 1;
          _currentYear++;
        }
        _updateDaysInMonth();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<int>(
                  value: _currentMonth,
                  items:
                  List.generate(12, (index) => index + 1)
                      .map(
                        (month) => DropdownMenuItem(
                      value: month,
                      child: Text(
                        DateFormat(
                          'MMM',
                          'ru_RU',
                        ).format(DateTime(2000, month)),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentMonth = value!;
                      _updateDaysInMonth();
                    });
                  },
                ),
                DropdownButton<int>(
                  value: _currentYear,
                  items:
                  List.generate(
                    widget.lastDate.year - widget.firstDate.year + 1,
                        (index) => widget.firstDate.year + index,
                  )
                      .map(
                        (year) => DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentYear = value!;
                      _updateDaysInMonth();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Пн', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Вт', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Ср', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Чт', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Пт', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Сб', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Вс', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
              ),
              itemCount: _daysInMonth.length,
              itemBuilder: (context, index) {
                final date = _daysInMonth[index];
                final isCurrentMonth = date.month == _currentMonth;
                final isSelected =
                    isCurrentMonth &&
                        date.day == _selectedDate.day &&
                        date.month == _selectedDate.month &&
                        date.year == _selectedDate.year;
                return GestureDetector(
                  onTap: () => _onDateSelected(date),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : null,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color:
                        isCurrentMonth
                            ? isSelected
                            ? Colors.white
                            : Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: const Text('Очистить'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, _selectedDate);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<DateTime?> showYaDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return await showDialog<DateTime>(
    context: context,
    builder:
        (context) => DatePickerDialog(
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    ),
  );
}