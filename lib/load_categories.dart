// Это временный файл, т.к. пока не понятно как добавлять категории,
// поэтому в офлайн режиме негде брать данные

import 'package:get_it/get_it.dart';

import 'data/database/category_db.dart';
import 'data/repositories_impl/categories_repository_impl.dart';
import 'domain/models/category.dart';

final getIt = GetIt.instance;
final CategoryDb category_db = getIt<CategoryDb>();
final CategoriesRepositoryImpl categories_repo = CategoriesRepositoryImpl();

Future<void> loadCategories() async {
  final categoriesReq = await categories_repo.getCategories();

  final List<Category> lc = [];

  for (Category cat in categoriesReq) {
    lc.add(Category(id: cat.id, name: cat.name, emoji: cat.emoji, isIncome: cat.isIncome));
  }

  await category_db.saveCategories(lc);
}