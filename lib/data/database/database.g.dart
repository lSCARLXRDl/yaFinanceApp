// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountPageTable extends AccountPage
    with TableInfo<$AccountPageTable, AccountPageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountPageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<String> balance = GeneratedColumn<String>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, balance, currency, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_page';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountPageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountPageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountPageData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      balance:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}balance'],
          )!,
      currency:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}currency'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $AccountPageTable createAlias(String alias) {
    return $AccountPageTable(attachedDatabase, alias);
  }
}

class AccountPageData extends DataClass implements Insertable<AccountPageData> {
  final int id;
  final String balance;
  final String currency;
  final String name;
  const AccountPageData({
    required this.id,
    required this.balance,
    required this.currency,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['balance'] = Variable<String>(balance);
    map['currency'] = Variable<String>(currency);
    map['name'] = Variable<String>(name);
    return map;
  }

  AccountPageCompanion toCompanion(bool nullToAbsent) {
    return AccountPageCompanion(
      id: Value(id),
      balance: Value(balance),
      currency: Value(currency),
      name: Value(name),
    );
  }

  factory AccountPageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountPageData(
      id: serializer.fromJson<int>(json['id']),
      balance: serializer.fromJson<String>(json['balance']),
      currency: serializer.fromJson<String>(json['currency']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'balance': serializer.toJson<String>(balance),
      'currency': serializer.toJson<String>(currency),
      'name': serializer.toJson<String>(name),
    };
  }

  AccountPageData copyWith({
    int? id,
    String? balance,
    String? currency,
    String? name,
  }) => AccountPageData(
    id: id ?? this.id,
    balance: balance ?? this.balance,
    currency: currency ?? this.currency,
    name: name ?? this.name,
  );
  AccountPageData copyWithCompanion(AccountPageCompanion data) {
    return AccountPageData(
      id: data.id.present ? data.id.value : this.id,
      balance: data.balance.present ? data.balance.value : this.balance,
      currency: data.currency.present ? data.currency.value : this.currency,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountPageData(')
          ..write('id: $id, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, balance, currency, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountPageData &&
          other.id == this.id &&
          other.balance == this.balance &&
          other.currency == this.currency &&
          other.name == this.name);
}

class AccountPageCompanion extends UpdateCompanion<AccountPageData> {
  final Value<int> id;
  final Value<String> balance;
  final Value<String> currency;
  final Value<String> name;
  const AccountPageCompanion({
    this.id = const Value.absent(),
    this.balance = const Value.absent(),
    this.currency = const Value.absent(),
    this.name = const Value.absent(),
  });
  AccountPageCompanion.insert({
    this.id = const Value.absent(),
    required String balance,
    required String currency,
    required String name,
  }) : balance = Value(balance),
       currency = Value(currency),
       name = Value(name);
  static Insertable<AccountPageData> custom({
    Expression<int>? id,
    Expression<String>? balance,
    Expression<String>? currency,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (balance != null) 'balance': balance,
      if (currency != null) 'currency': currency,
      if (name != null) 'name': name,
    });
  }

  AccountPageCompanion copyWith({
    Value<int>? id,
    Value<String>? balance,
    Value<String>? currency,
    Value<String>? name,
  }) {
    return AccountPageCompanion(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (balance.present) {
      map['balance'] = Variable<String>(balance.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountPageCompanion(')
          ..write('id: $id, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountPageTable accountPage = $AccountPageTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [accountPage];
}

typedef $$AccountPageTableCreateCompanionBuilder =
    AccountPageCompanion Function({
      Value<int> id,
      required String balance,
      required String currency,
      required String name,
    });
typedef $$AccountPageTableUpdateCompanionBuilder =
    AccountPageCompanion Function({
      Value<int> id,
      Value<String> balance,
      Value<String> currency,
      Value<String> name,
    });

class $$AccountPageTableFilterComposer
    extends Composer<_$AppDatabase, $AccountPageTable> {
  $$AccountPageTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountPageTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountPageTable> {
  $$AccountPageTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountPageTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountPageTable> {
  $$AccountPageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$AccountPageTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountPageTable,
          AccountPageData,
          $$AccountPageTableFilterComposer,
          $$AccountPageTableOrderingComposer,
          $$AccountPageTableAnnotationComposer,
          $$AccountPageTableCreateCompanionBuilder,
          $$AccountPageTableUpdateCompanionBuilder,
          (
            AccountPageData,
            BaseReferences<_$AppDatabase, $AccountPageTable, AccountPageData>,
          ),
          AccountPageData,
          PrefetchHooks Function()
        > {
  $$AccountPageTableTableManager(_$AppDatabase db, $AccountPageTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AccountPageTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AccountPageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$AccountPageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> balance = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => AccountPageCompanion(
                id: id,
                balance: balance,
                currency: currency,
                name: name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String balance,
                required String currency,
                required String name,
              }) => AccountPageCompanion.insert(
                id: id,
                balance: balance,
                currency: currency,
                name: name,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountPageTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountPageTable,
      AccountPageData,
      $$AccountPageTableFilterComposer,
      $$AccountPageTableOrderingComposer,
      $$AccountPageTableAnnotationComposer,
      $$AccountPageTableCreateCompanionBuilder,
      $$AccountPageTableUpdateCompanionBuilder,
      (
        AccountPageData,
        BaseReferences<_$AppDatabase, $AccountPageTable, AccountPageData>,
      ),
      AccountPageData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountPageTableTableManager get accountPage =>
      $$AccountPageTableTableManager(_db, _db.accountPage);
}
