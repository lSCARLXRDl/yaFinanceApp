import 'package:freezed_annotation/freezed_annotation.dart';

part 'stat_item.freezed.dart';
part 'stat_item.g.dart';

@freezed
abstract class StatItemDto with _$StatItemDto {
  const factory StatItemDto({
    required int categoryId,
    required String categoryName,
    required String emoji,
    required String amount
  }) = _StatItemDto;

  factory StatItemDto.fromJson(Map<String, Object?> json) => _$StatItemDtoFromJson(json);
}