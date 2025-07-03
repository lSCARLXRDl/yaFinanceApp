import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';
part 'transaction_request.g.dart';

@freezed
abstract class TransactionRequestDto with _$TransactionRequestDto {
  const factory TransactionRequestDto({
    required int accountId,
    required int categoryId,
    required String amount,
    required String transactionDate,
    required String? comment
  }) = _TransactionRequestDto;

  factory TransactionRequestDto.fromJson(Map<String, Object?> json) => _$TransactionRequestDtoFromJson(json);
}