import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ya_finance_app/data/models/shared/account_state.dart';

part 'account_history.freezed.dart';
part 'account_history.g.dart';


enum EnumChangeType{CREATION, MODIFICATION}

@freezed
abstract class AccountHistory with _$AccountHistory {
  const factory AccountHistory({
    required int id,
    required int accountId,
    required EnumChangeType changeType,
    required AccountState previousState,
    required AccountState newState,
    required DateTime changeTimestamp,
    required DateTime createdAt,
  }) = _AccountHistory;

  factory AccountHistory.fromJson(Map<String, Object?> json) => _$AccountHistoryFromJson(json);
}