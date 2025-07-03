import 'package:ya_finance_app/data/models/shared/account.dart';
import 'package:ya_finance_app/domain/models/bank_account.dart';

class AccountMapper {
  static BankAccount fromDto(AccountDto dto) {
    return BankAccount(
        id: dto.id,
        userid: dto.userId,
        name: dto.name ?? ' ',
        balance: dto.balance,
        currency: dto.currency,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt);
  }

  static AccountDto toDto(BankAccount account) {
    return AccountDto(id: account.id,
        userId: account.userid,
        name: account.name,
        balance: account.balance,
        currency: account.currency,
        createdAt: account.createdAt,
        updatedAt: account.updatedAt);
  }
}