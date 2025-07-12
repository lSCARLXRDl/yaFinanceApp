import '../../domain/models/account_history.dart';
import '../../enums/change_type.dart';
import '../models/shared/account_history.dart';
import 'account_state_map.dart';

class AccountHistoryMapper {
  static AccountHistory fromDto(AccountHistoryDto dto) {
    return AccountHistory(
      id: dto.id,
      accountId: dto.accountId,
      changeType: dto.changeType,
      previousState: AccountStateMapper.fromDto(dto.previousState),
      newState: AccountStateMapper.fromDto(dto.newState),
      changeTimestamp: dto.changeTimestamp,
      createdAt: dto.createdAt
    );
  }

  static AccountHistoryDto toDto(AccountHistory accountHist) {
    return AccountHistoryDto(
        id: accountHist.id,
        accountId: accountHist.accountId,
        changeType: accountHist.changeType,
        previousState: AccountStateMapper.toDto(accountHist.previousState),
        newState: AccountStateMapper.toDto(accountHist.newState),
        changeTimestamp: accountHist.changeTimestamp,
        createdAt: accountHist.createdAt
    );
  }
}