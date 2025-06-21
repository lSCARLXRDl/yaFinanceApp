import 'package:ya_finance_app/data/models/response/transaction_response.dart';

import '../../data/models/request/transaction_request.dart';
import '../models/transaction.dart';
import '../models/transaction_response.dart';

abstract interface class TransactionRepository {
  Future<Transaction> createTransaction({
    required TransactionRequestDto request,
  });

  Future<Transaction> updateTransaction({
    required int id,
    required TransactionRequestDto request,
  });

  Future<bool> deleteTransaction({required int id});

  Future<List<Transaction>> getTransactions();

  Future<List<TransactionResponse>> getTransactionsByPeriod({required int accountId, DateTime? startDate, DateTime? endDate});
}
