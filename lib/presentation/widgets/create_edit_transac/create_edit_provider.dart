import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/database/transaction_db.dart';
import 'package:ya_finance_app/data/models/request/transaction_request.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_repository_impl.dart';

import '../../../data/database/transaction_event_db.dart';
import '../../../data/mappers/date_map.dart';
import '../../../data/repositories_impl/transactions_db_repository.dart';

final getIt = GetIt.instance;
final TransactionEventDb TransacEventDB = getIt<TransactionEventDb>();
final TransactionDb TransacDB = getIt<TransactionDb>();

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

  int newIncomeTransacId = -1;
  int newExpenseTransacId = -1;

  final transac_repo = TransactionsRepositoryImpl();
  final transac_repo_db = TransactionsDBRepository();


  void changeCategInfo(newCategInfo, {required isCreate}) {
    (isCreate) ? stateCreate = newCategInfo['categName'] : state = newCategInfo['categName'];
    (isCreate) ? categIdCreate = newCategInfo['categId'] : categId = newCategInfo['categId'];
    notifyListeners();
  }

  void setnewTransacId({required isIncome}) async{
    if (isIncome){
      newIncomeTransacId = await getNewTransacId(isIncome: isIncome);
    }
    else {
      newExpenseTransacId = await getNewTransacId(isIncome: isIncome);
    }
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

  void updateCreateTransactionInfo({required isIncome}) async {
    if (isIncome)
      newIncomeTransacId += 1;
    else
      newExpenseTransacId += 1;
    accIdCreate = -1;
    categIdCreate = -1;
    sumCreate = '0';
    stateCreate = 'Выбрать';
    accountCreate = 'Выбрать';
    nowDateCreate = DateMapper.fromDate(DateTime.now());
    nowTimeCreate = DateMapper.fromTime(DateTime.now());
    commentCreate = '';
  }

  void createTransac(BuildContext context, {required isIncome}) async {
    if (accIdCreate != -1 && categIdCreate != -1 && sumCreate != '0' && sumCreate != '') {
      final req = TransactionRequestDto(
        accountId: accIdCreate,
        categoryId: categIdCreate,
        amount: sumCreate,
        transactionDate:
            '${DateMapper.fromStringDate(nowDateCreate)}T${nowTimeCreate}:00.000Z',
        comment: commentCreate,
      );

      if (!await hasRealInternet()) {
        await TransacEventDB.into(TransacEventDB.transactionEvent).insert(TransactionEventCompanion.insert(
          type: 'create',
          data: Value(req.toString()),
        ));
      }
      else {
        final resp = await transac_repo.createTransaction(request: req);
      }
      if (isIncome)
        await transac_repo_db.createTransaction(transacId: newIncomeTransacId, request: req);
      else
        await transac_repo_db.createTransaction(transacId: newExpenseTransacId, request: req);

      List<TransactionItemData> allItems = await TransacDB.select(TransacDB.transactionItem).get();
      print(allItems);

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
      if (!await hasRealInternet()) {
        await TransacEventDB.into(TransacEventDB.transactionEvent).insert(TransactionEventCompanion.insert(
          type: 'edit',
          data: Value(req.toString()),
          id: Value(transacId)
        ));
      }
      else {
        final resp = await transac_repo.updateTransaction(id: transacId, request: req);
      }

      await transac_repo_db.updateTransaction(id: transacId, request: req);

      Navigator.pop(context);
    }
    else {
      _showAlertDialog(context);
    }
  }

  void deleteTransac(BuildContext context, {required isIncome}) async {
    if (transacId != -1) {
      if (!await hasRealInternet()) {
        await TransacEventDB.into(TransacEventDB.transactionEvent).insert(TransactionEventCompanion.insert(
            type: 'delete',
            id: Value((isIncome) ? newIncomeTransacId : newExpenseTransacId)
        ));
      }
      else {
        final resp = await transac_repo.deleteTransaction(id: transacId);
      }

      await transac_repo_db.deleteTransaction(id: (isIncome) ? newIncomeTransacId : newExpenseTransacId);

      List<TransactionItemData> allItems = await TransacDB.select(TransacDB.transactionItem).get();
      print(allItems);


      Navigator.pop(context);
    }
  }
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

Future<int> getNewTransacId({required isIncome}) async {
  final transac_repo = TransactionsRepositoryImpl();
  final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: DateTime.now(), endDate: DateTime.now());
  final transList = transacs.where((el) => el.category.isIncome == isIncome).toList();
  if (transList.length < 1)
    return 0;
  else
    return transList.last.id + 1;
}