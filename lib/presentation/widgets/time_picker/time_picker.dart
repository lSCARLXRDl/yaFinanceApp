import 'package:flutter/material.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';

import '../../../l10n/app_localizations.dart';

Future<String?> showYaTimePicker(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    cancelText: AppLocalizations.of(context)!.cancel,
    helpText: AppLocalizations.of(context)!.selectTime,
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
                primary: Theme.of(context).colorScheme.primary,
                onPrimary: Colors.white,
                surface: Theme.of(context).secondaryHeaderColor,
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