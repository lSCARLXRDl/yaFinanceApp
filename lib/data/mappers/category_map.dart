import 'package:ya_finance_app/data/models/shared/category.dart';
import 'package:ya_finance_app/domain/models/category.dart';

class CategoryMapper {
  static Category fromDto(CategoryDto dto) {
    return Category(
        id: dto.id,
        name: dto.name,
        emoji: dto.emoji,
        isIncome: dto.isIncome
    );
  }

  static CategoryDto toDto(Category category) {
    return CategoryDto(
        id: category.id,
        name: category.name,
        emoji: category.emoji,
        isIncome: category.isIncome
    );
  }
}
