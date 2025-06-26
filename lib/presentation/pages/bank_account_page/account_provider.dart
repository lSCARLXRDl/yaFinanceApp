import 'package:flutter/material.dart';


class AccountProvider extends ChangeNotifier {
  String currency = '₽';
  String account_name = '';
  String balance = '';

  void changeCurrency(String newCur){
    currency = newCur;
    notifyListeners();
  }

  void changeBalance(String newBalance){
    balance = newBalance;
    notifyListeners();
  }

  void changeAccountName(String newAccountName){
    account_name = newAccountName;
    print(account_name);
    notifyListeners();
  }
}