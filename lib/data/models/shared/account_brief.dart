import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_brief.freezed.dart';
part 'account_brief.g.dart';

@freezed
abstract class AccountBriefDto with _$AccountBriefDto {
  const factory AccountBriefDto({
    required int id,
    required String name,
    required String balance,
    required String currency
  }) = _AccountBriefDto;

  factory AccountBriefDto.fromJson(Map<String, Object?> json) => _$AccountBriefDtoFromJson(json);
}