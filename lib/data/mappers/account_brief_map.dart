import 'package:ya_finance_app/data/models/shared/account_brief.dart';
import 'package:ya_finance_app/domain/models/account_brief.dart';


class AccountBriefMapper {
  static AccountBrief fromDto(AccountBriefDto dto) {
    return AccountBrief(
        id: dto.id,
        name: dto.name,
        balance: dto.balance,
        currency: dto.currency);
  }

  static AccountBriefDto toDto(AccountBrief transaction) {
    return AccountBriefDto(
        id: transaction.id,
        name: transaction.name,
        balance: transaction.balance,
        currency: transaction.currency);
  }
}