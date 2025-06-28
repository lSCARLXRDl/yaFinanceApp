import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/bank_account.dart';

class DBAccountRepository{

  Future<Map> getBankAccount() async {
    Map<String, dynamic> account = {};
    final prefs = await SharedPreferences.getInstance();
    account['balance'] = prefs.getString('balance');
    account['currency'] = prefs.getString('currency');
    account['account_name'] = prefs.getString('account_name');
    return account;
  }

  Future<bool> updateBankAccount({required String balance, required String currency, required String name}) async {
    try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('balance', balance);
    await prefs.setString('currency', currency);
    await prefs.setString('account_name', name);
    return true;
    } on Exception catch(e) {
      return false;
    }
  }

}