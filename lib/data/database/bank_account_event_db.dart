import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'bank_account_event_db.g.dart';

class BankAccountEvent extends Table {
  TextColumn get type => text()();
  IntColumn get id => integer().nullable()();
  TextColumn get data => text().named('data').nullable()();
}

@DriftDatabase(tables: [BankAccountEvent])
class BankAccountEventDb extends _$BankAccountEventDb {
  BankAccountEventDb([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'bank_account_event_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}