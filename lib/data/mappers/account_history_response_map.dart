import '../../domain/models/account_history_response.dart';
import '../models/response/account_history_response.dart';
import 'account_history_map.dart';

class AccountHistoryResponseMapper {
  static AccountHistoryResponse fromDto(AccountHistoryResponseDto dto) {
    return AccountHistoryResponse(
      accountId: dto.accountId,
      accountName: dto.accountName,
      currency: dto.currency,
      currentBalance: dto.currentBalance,
      history: AccountHistoryMapper.fromDto(dto.history),
    );
  }

  static AccountHistoryResponseDto toDto(AccountHistoryResponse accountResp) {
    return AccountHistoryResponseDto(
      accountId: accountResp.accountId,
      accountName: accountResp.accountName,
      currency: accountResp.currency,
      currentBalance: accountResp.currentBalance,
      history: AccountHistoryMapper.toDto(accountResp.history),
    );
  }
}