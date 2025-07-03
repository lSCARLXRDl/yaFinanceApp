import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/models/request/transaction_request.dart';

import '../../../data/mappers/date_map.dart';
import '../../../data/repositories_impl/transactions_mock.dart';
import '../../../domain/models/transaction_request.dart';

class CreateEditProvider extends ChangeNotifier {
  String sum = '0';
  String state = 'Выбрать';
  String account = 'Выбрать';
  String nDate = DateMapper.fromDate(DateTime.now());
  String nTime = DateMapper.fromTime(DateTime.now());
  String comment = '';

  String sumCreate = '0';
  String stateCreate = 'Выбрать';
  String accountCreate = 'Выбрать';
  String nowDateCreate = DateMapper.fromDate(DateTime.now());
  String nowTimeCreate = DateMapper.fromTime(DateTime.now());
  String commentCreate = '';

  int accId = -1;
  int categId = -1;

  int accIdCreate = -1;
  int categIdCreate = -1;

  int transacId = -1;

  //final getIt = GetIt.instance;

  final transac_repo = MockTransactionRepository();

  void changeCategInfo(newCategInfo, {required isCreate}) {
    (isCreate) ? stateCreate = newCategInfo['categName'] : state = newCategInfo['categName'];
    (isCreate) ? categIdCreate = newCategInfo['categId'] : categId = newCategInfo['categId'];
    notifyListeners();
  }

  void changeAccountInfo(newAccountInfo, {required isCreate}) {
    (isCreate) ? accountCreate = newAccountInfo['accName'] : account = newAccountInfo['accName'];
    (isCreate) ? accIdCreate = newAccountInfo['accId'] : accId = newAccountInfo['accId'];
    notifyListeners();
  }

  void changeDate(DateTime date, {required isCreate}) {
    (isCreate)
        ? nowDateCreate = '${date.year}-${date.month}-${date.day}'
        : nDate = '${date.year}-${date.month}-${date.day}';
    notifyListeners();
  }

  void changeTime(String time, {required isCreate}) {
    (isCreate) ? nowTimeCreate = time : nTime = time;
    notifyListeners();
  }

  void updateData() {
    sumCreate = '0';
    stateCreate = 'Выбрать';
    accountCreate = 'Выбрать';
    nowDateCreate = DateMapper.fromDate(DateTime.now());
    nowTimeCreate = DateMapper.fromTime(DateTime.now());
    commentCreate = '';
  }

  void setEditTransactionInfo({required category, required transac}) {
    transacId = transac.id;
    accId = transac.account.id;
    categId = category.id;
    account = transac.account.name;
    state = category.name;
    sum = transac.amount;
    nDate = DateMapper.fromDate(transac.transactionDate);
    nTime = DateMapper.fromTime(transac.transactionDate);
    comment = transac.comment;
  }

  void updateCreateTransactionInfo() {
    accIdCreate = -1;
    categIdCreate = -1;
    sumCreate = '0';
    stateCreate = 'Выбрать';
    accountCreate = 'Выбрать';
    nowDateCreate = DateMapper.fromDate(DateTime.now());
    nowTimeCreate = DateMapper.fromTime(DateTime.now());
    commentCreate = '';
  }

  void createTransac(BuildContext context) async {
    if (accIdCreate != -1 && categIdCreate != -1 && sumCreate != '0' && sumCreate != '') {
      final req = TransactionRequestDto(
        accountId: accIdCreate,
        categoryId: categIdCreate,
        amount: sumCreate,
        transactionDate:
            '${DateMapper.fromStringDate(nowDateCreate)}T${nowTimeCreate}:00.000Z',
        comment: commentCreate,
      );
      final resp = await transac_repo.createTransaction(request: req);
      Navigator.pop(context);
    }
    else {
      _showAlertDialog(context);
    }
  }

  void editTransac(BuildContext context) async {
    if (accId != -1 && categId != -1 && sum != '0' && sum != '' && transacId != -1) {
      final req = TransactionRequestDto(
        accountId: accId,
        categoryId: categId,
        amount: sum,
        transactionDate: '${DateMapper.fromStringDate(nDate)}T${nTime}:00.000Z',
        comment: comment,
      );
      final resp = await transac_repo.updateTransaction(id: transacId, request: req);
      Navigator.pop(context);
    }
    else {
      _showAlertDialog(context);
    }
  }

  void deleteTransac(BuildContext context) async {
    if (transacId != -1) {
      final resp = await transac_repo.deleteTransaction(id: transacId);
      Navigator.pop(context);
    }
  }
}


void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Заполните все поля"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF2AE881)
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("ОК", style: TextStyle(color: Colors.black),),
          ),
        ],
      );
    },
  );
}