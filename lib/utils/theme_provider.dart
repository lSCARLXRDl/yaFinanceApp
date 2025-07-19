import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ya_finance_app/utils/theme.dart';

class ThemeProvider with ChangeNotifier {

  bool _useSystemTheme = true;
  Color _tint = Colors.blue;
  ThemeMode _themeMode = ThemeMode.system;

  bool get useSystemTheme => _useSystemTheme;
  Color get tint => _tint;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadColorAndTheme();
  }

  Future<void> _loadColorAndTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('tint');
    final mode = prefs.getBool('useSystemTheme');
    if (colorValue != null) {
      _tint = Color(colorValue);
      notifyListeners();
    }
    if (mode != null) {
      _useSystemTheme = mode;
      notifyListeners();
    }
  }

  Future<void> toggleTheme(bool useSystem) async{
    _useSystemTheme = useSystem;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useSystemTheme', useSystem);
  }

  Future<void> setTint(Color color) async{
    _tint = color;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tint', color.toARGB32());
  }

  ThemeData getTheme(BuildContext context) {
    final baseTheme = _useSystemTheme
        ? (MediaQuery.of(context).platformBrightness == Brightness.dark
        ? AppThemes.systemThemeDark
        : AppThemes.systemThemeLight)
        : AppThemes.customLightTheme;

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: _tint,
        surfaceTint: _tint,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _tint,
      ),
      secondaryHeaderColor: HSLColor.fromColor(_tint).withLightness((HSLColor.fromColor(_tint).lightness + 0.32).clamp(0.0, 1.0)).toColor()
    );
  }
}