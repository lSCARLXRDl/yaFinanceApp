import 'package:ya_finance_app/data/models/shared/transaction.dart';
import 'package:ya_finance_app/domain/models/transaction.dart';

class TransactionMapper {
  static Transaction fromDto(TransactionDto dto) {
    return Transaction(id: dto.id,
        accountId: dto.accountId,
        categoryId: dto.categoryId,
        amount: dto.amount,
        transactionDate: dto.transactionDate,
        comment: dto.comment,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt);
  }

  static TransactionDto toDto(Transaction transaction) {
    return TransactionDto(id: transaction.id,
        accountId: transaction.accountId,
        categoryId: transaction.categoryId,
        amount: transaction.amount,
        transactionDate: transaction.transactionDate,
        comment: transaction.comment,
        createdAt: transaction.createdAt,
        updatedAt: transaction.updatedAt);
  }
}