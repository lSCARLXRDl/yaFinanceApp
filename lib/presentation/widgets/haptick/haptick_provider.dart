import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HaptickProvider with ChangeNotifier {

  bool _isHaptick = false;

  bool get isHaptick => _isHaptick;

  HaptickProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getBool('isHaptick');
    if (mode != null) {
      _isHaptick = mode;
      notifyListeners();
    }
  }

  Future<void> setHaptick(bool isHap) async{
    _isHaptick = isHap;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHaptick', isHap);
    notifyListeners();
  }
}