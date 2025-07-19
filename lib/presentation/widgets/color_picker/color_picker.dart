import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../l10n/app_localizations.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.onColorChanged,
  });

  static Future<Color?> show({
    required BuildContext context,
    required Color initialColor,
  }) async {
    Color? selectedColor;

    await showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(
        initialColor: initialColor,
        onColorChanged: (color) => selectedColor = color,
      ),
    );

    return selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    Color pickerColor = initialColor;

    return Container(
      child: AlertDialog(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text(AppLocalizations.of(context)!.colorPick, style: TextStyle(color: Colors.black)),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              pickerColor = color;
              onColorChanged(color);
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel, style: TextStyle(color: Colors.red),),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2AE881),
              elevation: 0
            ),
            child: const Text('ОК', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(pickerColor),
          ),
        ],
      ),
    );
  }
}