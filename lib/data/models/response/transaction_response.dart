import 'package:freezed_annotation/freezed_annotation.dart';

import '../shared/account_brief.dart';
import '../shared/category.dart';

part 'transaction_response.freezed.dart';
part 'transaction_response.g.dart';

@freezed
abstract class TransactionResponseDto with _$TransactionResponseDto {
  const factory TransactionResponseDto({
    required int id,
    required AccountBriefDto account,
    required CategoryDto category,
    required String amount,
    required DateTime transactionDate,
    required String? comment,
    required DateTime createdAt,
    required DateTime updatedAt
  }) = _TransactionResponseDto;

  factory TransactionResponseDto.fromJson(Map<String, Object?> json) => _$TransactionResponseDtoFromJson(json);
}