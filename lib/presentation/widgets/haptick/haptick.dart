import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import 'haptick_provider.dart';

class HaptickDialog extends StatefulWidget {
  const HaptickDialog({super.key});

  static Future show({
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => HaptickDialog(),
    );
  }

  @override
  State<HaptickDialog> createState() => _HaptickDialogState();
}

class _HaptickDialogState extends State<HaptickDialog> {
  @override
  Widget build(BuildContext context) {
    final haptickProvider = Provider.of<HaptickProvider>(context);
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      title: Text(AppLocalizations.of(context)!.hapticks, style: TextStyle(color: Colors.black),),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    AppLocalizations.of(context)!.vibro,
                  style: Theme.of(context).textTheme.titleLarge
                ),
                Switch(
                  value: haptickProvider.isHaptick,
                  onChanged: (value) {
                    context.read<HaptickProvider>().setHaptick(value ? true : false);
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
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