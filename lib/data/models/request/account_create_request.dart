import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_create_request.freezed.dart';
part 'account_create_request.g.dart';

@freezed
abstract class AccountCreateRequestDto with _$AccountCreateRequestDto {
  const factory AccountCreateRequestDto({
    required String name,
    required String balance,
    required String currency
  }) = _AccountCreateRequestDto;

  factory AccountCreateRequestDto.fromJson(Map<String, Object?> json) => _$AccountCreateRequestDtoFromJson(json);
}