import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_update_request.freezed.dart';
part 'account_update_request.g.dart';

@freezed
abstract class AccountUpdateRequestDto with _$AccountUpdateRequestDto {
  const factory AccountUpdateRequestDto({
    required String name,
    required String balance,
    required String currency
  }) = _AccountUpdateRequestDto;

  factory AccountUpdateRequestDto.fromJson(Map<String, Object?> json) => _$AccountUpdateRequestDtoFromJson(json);
}