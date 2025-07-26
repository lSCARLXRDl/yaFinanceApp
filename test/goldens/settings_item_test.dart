import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ya_finance_app/presentation/widgets/settings_item/settings_item.dart';

void main() {
  setUp(() async{
    await loadAppFonts();
  });

  group('$SettingsItem', () {
    testWidgets('settings item with text "Звук"', (widgetTester) async {

      final settingsItem = SettingsItem(text: 'Звук', onClick: () {},);

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: settingsItem,
        ),
      ));

      final actualFinder = find.byType(SettingsItem);
      await expectLater(
          actualFinder,
          matchesGoldenFile('templates/settingsItem_sound.png')
      );
    });

    testWidgets('settings item with text "Язык"', (widgetTester) async {

      final settingsItem = SettingsItem(text: 'Язык', onClick: () {},);

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: settingsItem,
        ),
      ));

      final actualFinder = find.byType(SettingsItem);
      await expectLater(
          actualFinder,
          matchesGoldenFile('templates/settingsItem_language.png')
      );
    });
  });

}