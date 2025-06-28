import 'package:ya_finance_app/data/mappers/stat_item_map.dart';

import '../../domain/models/account_response.dart';
import '../models/response/account_response.dart';

class AccountResponseMapper {
  static AccountResponse fromDto(AccountResponseDto dto) {
    return AccountResponse(
        id: dto.id,
        name: dto.name,
        balance: dto.balance,
        currency: dto.currency,
        incomeStats: StatItemMapper.fromDto(dto.incomeStats),
        expenseStats: StatItemMapper.fromDto(dto.expenseStats),
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt
    );
  }

  static AccountResponseDto toDto(AccountResponse accountResp) {
    return AccountResponseDto(
        id: accountResp.id,
        name: accountResp.name,
        balance: accountResp.balance,
        currency: accountResp.currency,
        incomeStats: StatItemMapper.toDto(accountResp.incomeStats),
        expenseStats: StatItemMapper.toDto(accountResp.expenseStats),
        createdAt: accountResp.createdAt,
        updatedAt: accountResp.updatedAt
    );
  }
}