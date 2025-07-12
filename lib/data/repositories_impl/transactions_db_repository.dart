import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';
import 'package:dio/dio.dart';
import 'package:ya_finance_app/domain/models/account_brief.dart';
import 'package:ya_finance_app/domain/models/category.dart';

import '../../domain/models/transaction_response.dart';
import '../api/api_client.dart';
import '../database/transaction_db.dart';
import '../models/request/transaction_request.dart';

final getIt = GetIt.instance;
final TransactionDb TransacDB = getIt<TransactionDb>();

class TransactionsDBRepository {
  final ApiClient _dioClient = getIt<ApiClient>();

  Future<bool> createTransaction({
    required int transacId,
    required TransactionRequestDto request,
  }) async {
    try {
      await TransacDB.into(TransacDB.transactionItem).insert(
        TransactionItemCompanion.insert(
          id: transacId,
          accountId: request.accountId,
          categoryId: request.categoryId,
          amount: request.amount,
          transactionDate: DateMapper.toFullfromTZ(request.transactionDate),
          comment: Value(request.comment),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      return true;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  Future<bool> deleteTransaction({required int id}) async {
    try {
      await TransacDB.deleteById(id);
      return true;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  Future<TransactionResponse> getTransactionById({required int id}) async {
    try {
      final item = await (TransacDB.select(TransacDB.transactionItem)
        ..where((item) => item.id.equals(id))).getSingleOrNull();

      final cat = TransactionResponse(
        id: id,
        account: AccountBrief(id: 1, name: '', balance: "0", currency: "RUB"),
        category: Category(id: 1, name: "ЗП", emoji: "💰", isIncome: true),
        amount: item!.amount,
        transactionDate: item.transactionDate,
        comment: item.comment,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
      );
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  Future<bool> updateTransaction({
    required int id,
    required TransactionRequestDto request,
  }) async {
    try {
      await TransacDB.update(TransacDB.transactionItem)
        ..where((item) => item.id.equals(42))
        ..write(
          TransactionItemCompanion(
            id: Value(id),
            accountId: Value(request.accountId),
            categoryId: Value(request.categoryId),
            amount: Value(request.amount),
            transactionDate: Value(
              DateMapper.toFullfromTZ(request.transactionDate),
            ),
            comment: Value(request.comment),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );
      return true;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  Future<List<TransactionItemData>> getTransactionsByPeriod({
    required int accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      DateTime now = DateTime.now();
      DateTime startDateR = DateTime(now.year, now.month, 1);
      DateTime endDateR = DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1));

      final list = await (TransacDB.select(TransacDB.transactionItem)
        ..where((t) => t.transactionDate.isBetweenValues(startDateR, endDateR)))
          .get();
      print(list);
      return list;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }
}
