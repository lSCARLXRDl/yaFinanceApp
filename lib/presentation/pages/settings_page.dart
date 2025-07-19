import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/presentation/pages/pin_code_page/pin_code_provider.dart';
import 'package:ya_finance_app/presentation/pages/pin_code_page/pin_code_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/theme_provider.dart';
import '../widgets/color_picker/color_picker.dart';
import '../widgets/haptick/haptick.dart';
import '../widgets/local_picker/local_picker.dart';
import '../widgets/settings_item/settings_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!.lightTheme,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  Switch(
                    value: !themeProvider.useSystemTheme,
                    onChanged: (value) {
                      context.read<ThemeProvider>().toggleTheme(value ? false : true);
                    },
                  ),
                ],
              ),
            ),
            SettingsItem(
                onClick: () async {
                  final newColor = await ColorPickerDialog.show(context: context, initialColor: Theme.of(context).colorScheme.primary);
                  if (newColor != null) {
                    themeProvider.setTint(newColor);
                  }
                  else {
                    themeProvider.setTint(Theme.of(context).colorScheme.primary);
                  }
                },
                text: AppLocalizations.of(context)!.mainColor
            ),
            SettingsItem(
                onClick: () {

                },
                text: AppLocalizations.of(context)!.sound
            ),
            SettingsItem(
                onClick: () {
                  HaptickDialog.show(context: context);
                },
                text: AppLocalizations.of(context)!.hapticks
            ),
            SettingsItem(
                onClick: () {
                  context.goNamed('settings_edit_pin');
                },
                text: AppLocalizations.of(context)!.password
            ),
            SettingsItem(
                onClick: () {

                },
                text: AppLocalizations.of(context)!.synchronization
            ),
            SettingsItem(
                onClick: () {
                  LocalPicker.show(context:context);
                },
                text: AppLocalizations.of(context)!.language
            ),
            SettingsItem(
                onClick: () {

                },
                text: AppLocalizations.of(context)!.about
            ),
          ],
        ),
      ),
    );
  }
}
