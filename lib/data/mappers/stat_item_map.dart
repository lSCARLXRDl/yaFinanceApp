import 'package:ya_finance_app/data/models/shared/stat_item.dart';
import 'package:ya_finance_app/domain/models/stat_item.dart';

class StatItemMapper {
  static StatItem fromDto(StatItemDto dto) {
    return StatItem(
        categoryId: dto.categoryId,
        categoryName: dto.categoryName,
        emoji: dto.emoji,
        amount: dto.amount,
    );
  }

  static StatItemDto toDto(StatItem statItem) {
    return StatItemDto(
      categoryId: statItem.categoryId,
      categoryName: statItem.categoryName,
      emoji: statItem.emoji,
      amount: statItem.amount,
    );
  }
}