import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ya_finance_app/data/models/shared/account_state.dart';

part 'account_history.freezed.dart';
part 'account_history.g.dart';


enum EnumChangeType{CREATION, MODIFICATION}

@freezed
abstract class AccountHistoryDto with _$AccountHistoryDto {
  const factory AccountHistoryDto({
    required int id,
    required int accountId,
    required EnumChangeType changeType,
    required AccountStateDto previousState,
    required AccountStateDto newState,
    required DateTime changeTimestamp,
    required DateTime createdAt,
  }) = _AccountHistoryDto;

  factory AccountHistoryDto.fromJson(Map<String, Object?> json) => _$AccountHistoryDtoFromJson(json);
}