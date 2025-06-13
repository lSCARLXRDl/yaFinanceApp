import 'package:ya_finance_app/data/models/shared/category.dart';

import '../../domain/models/category.dart';
import '../../domain/repositories/categories.dart';
import '../mappers/category_map.dart';

class MockCategoriesRepository implements CategoriesRepository {

  final List<CategoryDto> _categoriesList = [
    CategoryDto(id: 1, name: 'Продукты', emoji: '🥐', isIncome: false),
    CategoryDto(id: 1, name: 'Зарплата', emoji: '💸', isIncome: true),
    CategoryDto(id: 1, name: 'Обувь', emoji: '🥾', isIncome: false),
    CategoryDto(id: 1, name: 'Поступление', emoji: '⬆📈', isIncome: true),
  ];
  @override
  Future<List<Category>> getCategories() async{
    await Future.delayed(const Duration(milliseconds: 200));
    return _categoriesList.map((e) => CategoryMapper.fromDto(e)).toList();
  }

  @override
  Future<List<Category>> getCategoriesByType({required bool isIncome}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final _filtered = _categoriesList.where((e) => e.isIncome == isIncome).toList();
    return _filtered.map((e) => CategoryMapper.fromDto(e)).toList();
  }
}