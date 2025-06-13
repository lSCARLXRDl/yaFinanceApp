import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required int id,
    required String name,
    required String emoji,
    required bool isIncome
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, Object?> json) => _$CategoryDtoFromJson(json);
}