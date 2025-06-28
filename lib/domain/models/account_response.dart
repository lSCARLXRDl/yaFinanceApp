import 'package:freezed_annotation/freezed_annotation.dart';
import 'stat_item.dart';

part 'account_response.freezed.dart';
part 'account_response.g.dart';

@freezed
abstract class AccountResponse with _$AccountResponse {
  const factory AccountResponse({
    required int id,
    required String name,
    required String balance,
    required String currency,
    required StatItem incomeStats,
    required StatItem expenseStats,
    required DateTime createdAt,
    required DateTime updatedAt
  }) = _AccountResponse;

  factory AccountResponse.fromJson(Map<String, Object?> json) => _$AccountResponseFromJson(json);
}