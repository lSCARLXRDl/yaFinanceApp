import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountProvider extends ChangeNotifier {
  String currency = '';
  String account_name = '';
  String balance = '';

  void changeCurrency(String newCur) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', newCur);
    currency = newCur;
    notifyListeners();
  }

  void changeBalance(String newBalance) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('balance', newBalance);
    balance = newBalance;
    notifyListeners();
  }

  void changeAccountName(String newAccountName) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('account_name', newAccountName);
    account_name = newAccountName;
    notifyListeners();
  }
}