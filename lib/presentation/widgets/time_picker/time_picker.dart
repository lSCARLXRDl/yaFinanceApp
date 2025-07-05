import 'package:flutter/material.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';

Future<String?> showYaTimePicker(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          alwaysUse24HourFormat: true,
        ),
        child: Container(
          child: Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF2AE881),
                onPrimary: Colors.white,
                surface: Color(0xFFD4FAE6),
              ),
            ),
            child: child!,
          ),
        ),
      );
    },
  );
  String? time = null;
  if (picked != null)
    time = DateMapper.fromTime(DateTime(2025, 07, 02, picked.hour, picked.minute));
  return time;
}