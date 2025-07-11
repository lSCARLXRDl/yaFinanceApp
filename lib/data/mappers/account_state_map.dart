import '../../domain/models/account_state.dart';
import '../models/shared/account_state.dart';

class AccountStateMapper {
  static AccountState fromDto(AccountStateDto dto) {
    return AccountState(
        id: dto.id,
        name: dto.name,
        balance: dto.balance,
        currency: dto.currency
    );
  }

  static AccountStateDto toDto(AccountState accountState) {
    return AccountStateDto(
        id: accountState.id,
        name: accountState.name,
        balance: accountState.balance,
        currency: accountState.currency
    );
  }
}