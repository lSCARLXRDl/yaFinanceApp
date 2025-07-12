import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'bank_account_db.g.dart';

class BankAccountItem extends Table {
  IntColumn get id => integer()();
  IntColumn get accountId => integer()();
  IntColumn get categoryId => integer()();
  TextColumn get amount => text()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get comment => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [BankAccountItem])
class BankAccountDb extends _$BankAccountDb {
  BankAccountDb([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'bank_account_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<BankAccountItemData?> getItemById() async {
    return await (select(bankAccountItem)).getSingle();
  }

}