import 'package:ya_finance_app/data/mappers/category_map.dart';
import 'package:ya_finance_app/data/models/response/transaction_response.dart';
import 'package:ya_finance_app/domain/models/transaction_response.dart';

import 'account_brief_map.dart';


class TransactionResponseMapper {
  static TransactionResponse fromDto(TransactionResponseDto dto) {
    return TransactionResponse(
        id: dto.id,
        account: AccountBriefMapper.fromDto(dto.account),
        category: CategoryMapper.fromDto(dto.category),
        amount: dto.amount,
        transactionDate: dto.transactionDate,
        comment: dto.comment,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt);
  }

  static TransactionResponseDto toDto(TransactionResponse transaction) {
    return TransactionResponseDto(
        id: transaction.id,
        account: AccountBriefMapper.toDto(transaction.account),
        category: CategoryMapper.toDto(transaction.category),
        amount: transaction.amount,
        transactionDate: transaction.transactionDate,
        comment: transaction.comment,
        createdAt: transaction.createdAt,
        updatedAt: transaction.updatedAt);
  }
}