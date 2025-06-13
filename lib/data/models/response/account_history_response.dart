import 'package:freezed_annotation/freezed_annotation.dart';

import '../shared/account_history.dart';

part 'account_history_response.freezed.dart';
part 'account_history_response.g.dart';

@freezed
abstract class AccountHistoryResponseDto with _$AccountHistoryResponseDto {
  const factory AccountHistoryResponseDto({
    required int accountId,
    required String accountName,
    required String currency,
    required String currentBalance,
    required AccountHistoryDto history
  }) = _AccountHistoryResponseDto;

  factory AccountHistoryResponseDto.fromJson(Map<String, Object?> json) => _$AccountHistoryResponseDtoFromJson(json);
}