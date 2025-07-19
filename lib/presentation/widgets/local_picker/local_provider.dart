import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('ru');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final lan = prefs.getString('language');
    if (lan != null) {
      _locale = Locale(lan);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async{
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    notifyListeners();
  }
}