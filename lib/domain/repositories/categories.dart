import '../models/category.dart';

abstract interface class CategoriesRepository {
  Future<List<Category>> getCategories();

  Future<List<Category>> getCategoriesByType(
    {required bool isIncome}
  );
}