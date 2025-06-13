import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_state.freezed.dart';
part 'account_state.g.dart';

@freezed
abstract class AccountStateDto with _$AccountStateDto {
  const factory AccountStateDto({
    required int id,
    required String name,
    required String balance,
    required String currency
  }) = _AccountStateDto;

  factory AccountStateDto.fromJson(Map<String, Object?> json) => _$AccountStateDtoFromJson(json);
}