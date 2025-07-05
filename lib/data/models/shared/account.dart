import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class AccountDto with _$AccountDto {
  const factory AccountDto({
    required int id,
    required int userId,
    required String? name,
    required String balance,
    required String currency,
    required DateTime createdAt,
    required DateTime updatedAt
  }) = _AccountDto;

  factory AccountDto.fromJson(Map<String, Object?> json) => _$AccountDtoFromJson(json);
}