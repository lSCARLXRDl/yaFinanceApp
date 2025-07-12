import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'transaction_db.g.dart';

class TransactionItem extends Table {
  IntColumn get id => integer()();
  IntColumn get accountId => integer()();
  IntColumn get categoryId => integer()();
  TextColumn get amount => text()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get comment => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [TransactionItem])
class TransactionDb extends _$TransactionDb {
  TransactionDb([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'transaction_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<int> deleteById(int id) async {
    return await (delete(transactionItem)..where((item) => item.id.equals(id))).go();
  }

  Future<TransactionItemData?> getItemById(int id) async {
    return await (select(transactionItem)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

}