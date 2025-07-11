import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_repository_impl.dart';

import '../../../data/repositories_impl/transactions_mock.dart';
import 'bloc_histo/histo_bloc.dart';


class AccountProvider extends ChangeNotifier {
  String currency = '';
  String account_name = '';
  String balance = '';
  String type = 'day';

  final histoBloc = HistoBloc(TransactionsRepositoryImpl());

  void changeCurrency(String newCur) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', newCur);
    currency = newCur;
    notifyListeners();
  }

  void changetype(String t) {
    type = t;
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