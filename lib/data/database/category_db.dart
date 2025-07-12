import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/models/category.dart';

part 'category_db.g.dart';

class CategoryItem extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get emoji => text()();
  BoolColumn get isIncome => boolean()();
}

@DriftDatabase(tables: [CategoryItem])
class CategoryDb extends _$CategoryDb {
  CategoryDb([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'category_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<void> saveCategories(List<Category> categoryList) async {
    await transaction(() async {
      final companions = categoryList.map((category) => CategoryItemCompanion(
        id: Value(category.id),
        name: Value(category.name),
        emoji: Value(category.emoji),
        isIncome: Value(category.isIncome),
      )).toList();

      await batch((batch) {
        for (final companion in companions) {
          batch.insert(
            categoryItem,
            companion,
          );
        }
      });
    });
  }

  Future<List<Category>> getCategoriesByType({required bool isIncome}) async {
    final query = select(categoryItem)
      ..where((tbl) => tbl.isIncome.equals(isIncome));

    final categories = await query.get();
    return categories.map((item) => Category(
      id: item.id,
      name: item.name,
      emoji: item.emoji,
      isIncome: item.isIncome,
    )).toList();
  }

  Future<List<Category>> getCategories() async {

    final categories = await select(categoryItem).get();
    return categories.map((item) => Category(
      id: item.id,
      name: item.name,
      emoji: item.emoji,
      isIncome: item.isIncome,
    )).toList();
  }
}