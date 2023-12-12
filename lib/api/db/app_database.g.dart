// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTableTable extends BasketTable
    with TableInfo<$BasketTableTable, BasketDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BasketTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _expectedSplitMeta =
      const VerificationMeta('expectedSplit');
  @override
  late final GeneratedColumn<double> expectedSplit = GeneratedColumn<double>(
      'expected_split', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, expectedSplit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'basket_table';
  @override
  VerificationContext validateIntegrity(Insertable<BasketDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('expected_split')) {
      context.handle(
          _expectedSplitMeta,
          expectedSplit.isAcceptableOrUnknown(
              data['expected_split']!, _expectedSplitMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BasketDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BasketDO(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      expectedSplit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}expected_split']),
    );
  }

  @override
  $BasketTableTable createAlias(String alias) {
    return $BasketTableTable(attachedDatabase, alias);
  }
}

class BasketDO extends DataClass implements Insertable<BasketDO> {
  final String name;
  final double? expectedSplit;
  const BasketDO({required this.name, this.expectedSplit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || expectedSplit != null) {
      map['expected_split'] = Variable<double>(expectedSplit);
    }
    return map;
  }

  BasketTableCompanion toCompanion(bool nullToAbsent) {
    return BasketTableCompanion(
      name: Value(name),
      expectedSplit: expectedSplit == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedSplit),
    );
  }

  factory BasketDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BasketDO(
      name: serializer.fromJson<String>(json['name']),
      expectedSplit: serializer.fromJson<double?>(json['expectedSplit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'expectedSplit': serializer.toJson<double?>(expectedSplit),
    };
  }

  BasketDO copyWith(
          {String? name,
          Value<double?> expectedSplit = const Value.absent()}) =>
      BasketDO(
        name: name ?? this.name,
        expectedSplit:
            expectedSplit.present ? expectedSplit.value : this.expectedSplit,
      );
  @override
  String toString() {
    return (StringBuffer('BasketDO(')
          ..write('name: $name, ')
          ..write('expectedSplit: $expectedSplit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, expectedSplit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BasketDO &&
          other.name == this.name &&
          other.expectedSplit == this.expectedSplit);
}

class BasketTableCompanion extends UpdateCompanion<BasketDO> {
  final Value<String> name;
  final Value<double?> expectedSplit;
  final Value<int> rowid;
  const BasketTableCompanion({
    this.name = const Value.absent(),
    this.expectedSplit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BasketTableCompanion.insert({
    required String name,
    this.expectedSplit = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<BasketDO> custom({
    Expression<String>? name,
    Expression<double>? expectedSplit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (expectedSplit != null) 'expected_split': expectedSplit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BasketTableCompanion copyWith(
      {Value<String>? name, Value<double?>? expectedSplit, Value<int>? rowid}) {
    return BasketTableCompanion(
      name: name ?? this.name,
      expectedSplit: expectedSplit ?? this.expectedSplit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (expectedSplit.present) {
      map['expected_split'] = Variable<double>(expectedSplit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BasketTableCompanion(')
          ..write('name: $name, ')
          ..write('expectedSplit: $expectedSplit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $BasketTableTable basketTable = $BasketTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [basketTable];
}
