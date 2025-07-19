import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import 'local_provider.dart';

class LocalPicker extends StatefulWidget {
  const LocalPicker({super.key});

  static Future show({
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => LocalPicker(),
    );
  }

  @override
  State<LocalPicker> createState() => _LocalPickerState();
}

class _LocalPickerState extends State<LocalPicker> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      title: Text(AppLocalizations.of(context)!.language, style: TextStyle(color: Colors.black),),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<Locale>(
                  value: Provider.of<LocaleProvider>(context).locale,
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('ru'),
                      child: Text('Русский'),
                    ),
                  ],
                  onChanged: (locale) {
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(locale!);
                  },
                )
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primary
          ),
          child: const Text('ОК', style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}