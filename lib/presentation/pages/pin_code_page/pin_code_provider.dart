import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _correctPin = "1234";

  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final pin = prefs.getString('password');
    print(pin);
    if (pin != null) {
      _correctPin = pin;
      notifyListeners();
    }
  }

  void setIsAuthenticated(bool ia) {
    _isAuthenticated = ia;
  }

  Future<bool> checkPin(String pin) async {
    _isAuthenticated = pin == _correctPin;
    notifyListeners();
    return _isAuthenticated;
  }

  Future<void> changePin(String pin) async{
    _correctPin = pin;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', pin);
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}