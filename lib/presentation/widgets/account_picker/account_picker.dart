import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_repository_impl.dart';
import 'package:ya_finance_app/domain/models/bank_account.dart';

import '../../../data/api/api_client.dart';
import '../../../l10n/app_localizations.dart';

final getIt = GetIt.instance;

Future<Map<String, dynamic>> showAccountPicker(BuildContext context) async {
  String? _accName = null;
  int? _accId = null;
  late var list_acc;
  if (await hasRealInternet()) {
    list_acc = await BankAccountRepositoryImpl(getIt<ApiClient>()).getBankAccounts();
  }
  else {
    list_acc = [BankAccount(id: 1, userid: 1, name: 'Основной счёт', balance: "13255", currency: "RUB", createdAt: DateTime.now(), updatedAt: DateTime.now())];
  }
  final dialog = await showModalBottomSheet<String?>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.25 * list_acc.length,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFF79747E),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: list_acc.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      _accName = list_acc[index].name;
                      _accId = list_acc[index].id;
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          '💰',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          list_acc[index].name,
                          style: Theme.of(context).textTheme.titleSmall
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE46962),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  _accName = null;
                  _accId = null;
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.cancel_outlined, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                        AppLocalizations.of(context)!.cancel,
                      style: TextStyle(color: Colors.white, fontSize: 15,
                        fontWeight: FontWeight.w400,)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  return {
    'accName': _accName,
    'accId': _accId
  };
}


Future<bool> hasRealInternet() async {
  try {
    final socket = await Socket.connect('8.8.8.8', 53, timeout: const Duration(seconds: 2));
    await socket.close();
    return true;
  } catch (e) {
    return false;
  }
}
