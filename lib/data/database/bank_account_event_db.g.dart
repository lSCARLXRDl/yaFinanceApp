// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_event_db.dart';

// ignore_for_file: type=lint
class $BankAccountEventTable extends BankAccountEvent
    with TableInfo<$BankAccountEventTable, BankAccountEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankAccountEventTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [type, id, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_account_event';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankAccountEventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BankAccountEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankAccountEventData(
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      ),
    );
  }

  @override
  $BankAccountEventTable createAlias(String alias) {
    return $BankAccountEventTable(attachedDatabase, alias);
  }
}

class BankAccountEventData extends DataClass
    implements Insertable<BankAccountEventData> {
  final String type;
  final int? id;
  final String? data;
  const BankAccountEventData({required this.type, this.id, this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String>(data);
    }
    return map;
  }

  BankAccountEventCompanion toCompanion(bool nullToAbsent) {
    return BankAccountEventCompanion(
      type: Value(type),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
    );
  }

  factory BankAccountEventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankAccountEventData(
      type: serializer.fromJson<String>(json['type']),
      id: serializer.fromJson<int?>(json['id']),
      data: serializer.fromJson<String?>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<String>(type),
      'id': serializer.toJson<int?>(id),
      'data': serializer.toJson<String?>(data),
    };
  }

  BankAccountEventData copyWith({
    String? type,
    Value<int?> id = const Value.absent(),
    Value<String?> data = const Value.absent(),
  }) => BankAccountEventData(
    type: type ?? this.type,
    id: id.present ? id.value : this.id,
    data: data.present ? data.value : this.data,
  );
  BankAccountEventData copyWithCompanion(BankAccountEventCompanion data) {
    return BankAccountEventData(
      type: data.type.present ? data.type.value : this.type,
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountEventData(')
          ..write('type: $type, ')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(type, id, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankAccountEventData &&
          other.type == this.type &&
          other.id == this.id &&
          other.data == this.data);
}

class BankAccountEventCompanion extends UpdateCompanion<BankAccountEventData> {
  final Value<String> type;
  final Value<int?> id;
  final Value<String?> data;
  final Value<int> rowid;
  const BankAccountEventCompanion({
    this.type = const Value.absent(),
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankAccountEventCompanion.insert({
    required String type,
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : type = Value(type);
  static Insertable<BankAccountEventData> custom({
    Expression<String>? type,
    Expression<int>? id,
    Expression<String>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankAccountEventCompanion copyWith({
    Value<String>? type,
    Value<int?>? id,
    Value<String?>? data,
    Value<int>? rowid,
  }) {
    return BankAccountEventCompanion(
      type: type ?? this.type,
      id: id ?? this.id,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountEventCompanion(')
          ..write('type: $type, ')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BankAccountEventDb extends GeneratedDatabase {
  _$BankAccountEventDb(QueryExecutor e) : super(e);
  $BankAccountEventDbManager get managers => $BankAccountEventDbManager(this);
  late final $BankAccountEventTable bankAccountEvent = $BankAccountEventTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bankAccountEvent];
}

typedef $$BankAccountEventTableCreateCompanionBuilder =
    BankAccountEventCompanion Function({
      required String type,
      Value<int?> id,
      Value<String?> data,
      Value<int> rowid,
    });
typedef $$BankAccountEventTableUpdateCompanionBuilder =
    BankAccountEventCompanion Function({
      Value<String> type,
      Value<int?> id,
      Value<String?> data,
      Value<int> rowid,
    });

class $$BankAccountEventTableFilterComposer
    extends Composer<_$BankAccountEventDb, $BankAccountEventTable> {
  $$BankAccountEventTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BankAccountEventTableOrderingComposer
    extends Composer<_$BankAccountEventDb, $BankAccountEventTable> {
  $$BankAccountEventTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BankAccountEventTableAnnotationComposer
    extends Composer<_$BankAccountEventDb, $BankAccountEventTable> {
  $$BankAccountEventTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$BankAccountEventTableTableManager
    extends
        RootTableManager<
          _$BankAccountEventDb,
          $BankAccountEventTable,
          BankAccountEventData,
          $$BankAccountEventTableFilterComposer,
          $$BankAccountEventTableOrderingComposer,
          $$BankAccountEventTableAnnotationComposer,
          $$BankAccountEventTableCreateCompanionBuilder,
          $$BankAccountEventTableUpdateCompanionBuilder,
          (
            BankAccountEventData,
            BaseReferences<
              _$BankAccountEventDb,
              $BankAccountEventTable,
              BankAccountEventData
            >,
          ),
          BankAccountEventData,
          PrefetchHooks Function()
        > {
  $$BankAccountEventTableTableManager(
    _$BankAccountEventDb db,
    $BankAccountEventTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$BankAccountEventTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BankAccountEventTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BankAccountEventTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> type = const Value.absent(),
                Value<int?> id = const Value.absent(),
                Value<String?> data = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankAccountEventCompanion(
                type: type,
                id: id,
                data: data,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String type,
                Value<int?> id = const Value.absent(),
                Value<String?> data = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankAccountEventCompanion.insert(
                type: type,
                id: id,
                data: data,
                rowid: rowid,
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

typedef $$BankAccountEventTableProcessedTableManager =
    ProcessedTableManager<
      _$BankAccountEventDb,
      $BankAccountEventTable,
      BankAccountEventData,
      $$BankAccountEventTableFilterComposer,
      $$BankAccountEventTableOrderingComposer,
      $$BankAccountEventTableAnnotationComposer,
      $$BankAccountEventTableCreateCompanionBuilder,
      $$BankAccountEventTableUpdateCompanionBuilder,
      (
        BankAccountEventData,
        BaseReferences<
          _$BankAccountEventDb,
          $BankAccountEventTable,
          BankAccountEventData
        >,
      ),
      BankAccountEventData,
      PrefetchHooks Function()
    >;

class $BankAccountEventDbManager {
  final _$BankAccountEventDb _db;
  $BankAccountEventDbManager(this._db);
  $$BankAccountEventTableTableManager get bankAccountEvent =>
      $$BankAccountEventTableTableManager(_db, _db.bankAccountEvent);
}
