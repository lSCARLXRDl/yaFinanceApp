import 'package:freezed_annotation/freezed_annotation.dart';

import '../shared/stat_item.dart';

part 'account_response.freezed.dart';
part 'account_response.g.dart';

@freezed
abstract class AccountResponseDto with _$AccountResponseDto {
  const factory AccountResponseDto({
    required int id,
    required String name,
    required String balance,
    required String currency,
    required StatItemDto incomeStats,
    required StatItemDto expenseStats,
    required DateTime createdAt,
    required DateTime updatedAt
  }) = _AccountResponseDto;

  factory AccountResponseDto.fromJson(Map<String, Object?> json) => _$AccountResponseDtoFromJson(json);
}