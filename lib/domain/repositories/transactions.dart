import '../../data/models/request/transaction_request.dart';
import '../models/transaction.dart';

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
}
