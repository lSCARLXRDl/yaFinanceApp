import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';
import 'package:ya_finance_app/data/mappers/transaction_response_map.dart';
import 'package:ya_finance_app/data/models/shared/transaction.dart';
import 'package:ya_finance_app/utils/list.dart';
import 'package:dio/dio.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_response.dart';
import '../../domain/repositories/transactions.dart';
import '../mappers/transaction_map.dart';
import '../models/request/transaction_request.dart';
import '../models/response/transaction_response.dart';

class MockTransactionRepository {
  final List<TransactionDto> _transactionsList = [
    TransactionDto(
      id: 1,
      accountId: 1,
      categoryId: 1,
      amount: '500.00',
      transactionDate: DateTime(2025, 6, 12, 15, 47),
      comment: null,
      createdAt: DateTime(2025, 6, 12, 15, 47),
      updatedAt: DateTime(2025, 6, 12, 15, 47),
    ),
    TransactionDto(
      id: 2,
      accountId: 1,
      categoryId: 2,
      amount: '75000.00',
      transactionDate: DateTime(2025, 5, 30, 12, 13),
      comment: 'Зарплата за месяц',
      createdAt: DateTime(2025, 5, 30, 12, 13),
      updatedAt: DateTime(2025, 5, 30, 12, 13),
    ),
    TransactionDto(
      id: 3,
      accountId: 1,
      categoryId: 3,
      amount: '5200.00',
      transactionDate: DateTime(2025, 6, 2, 18, 31),
      comment: 'Обувной магазин',
      createdAt: DateTime(2025, 6, 2, 18, 31),
      updatedAt: DateTime(2025, 6, 2, 18, 31),
    ),
    TransactionDto(
      id: 4,
      accountId: 1,
      categoryId: 4,
      amount: '1300.00',
      transactionDate: DateTime(2025, 6, 2, 15, 00),
      comment: 'Вернул',
      createdAt: DateTime(2025, 6, 2, 15, 00),
      updatedAt: DateTime(2025, 6, 2, 15, 00),
    ),
  ];
  int transid = 4;

  @override
  Future<Transaction> createTransaction({required TransactionRequestDto request,}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final DateTime now = DateTime.now();
    final newTransDto = TransactionDto(
      id: transid,
      accountId: request.accountId,
      categoryId: request.categoryId,
      amount: request.amount,
      transactionDate: DateTime.now(),
      comment: request.comment,
      createdAt: DateTime(now.year, now.month, now.day, now.hour, now.minute),
      updatedAt: DateTime(now.year, now.month, now.day, now.hour, now.minute),
    );
    _transactionsList.add(newTransDto);
    transid++;
    return TransactionMapper.fromDto(newTransDto);
  }

  @override
  Future<bool> deleteTransaction({required int id}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _transactionsList.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _transactionsList.map((e) => TransactionMapper.fromDto(e)).toList();
  }

  @override
  Future<Transaction> updateTransaction({
    required int id,
    required TransactionRequestDto request,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final transac = _transactionsList.firstWhereOrNull((e) => e.id == id);
    if (transac == null) {
      throw Exception();
    }
    final DateTime now = DateTime.now();
    _transactionsList.removeWhere((e) => e.id == id);
    final newTrans = transac.copyWith(
      accountId: request.accountId,
      categoryId: request.categoryId,
      amount: request.amount,
      transactionDate: DateTime.now(),
      comment: request.comment,
      updatedAt: DateTime(now.year, now.month, now.day, now.hour, now.minute),
    );
    _transactionsList.add(newTrans);
    return TransactionMapper.fromDto(newTrans);
  }
}