// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTableTable extends BasketTable
    with TableInfo<$BasketTableTable, BasketDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BasketTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      check: () => name.isNotValue(''),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
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
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NAME')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BasketDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BasketDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
    );
  }

  @override
  $BasketTableTable createAlias(String alias) {
    return $BasketTableTable(attachedDatabase, alias);
  }
}

class BasketDO extends DataClass implements Insertable<BasketDO> {
  final int id;
  final String name;
  final String? description;
  const BasketDO({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    return map;
  }

  BasketTableCompanion toCompanion(bool nullToAbsent) {
    return BasketTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory BasketDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BasketDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  BasketDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent()}) =>
      BasketDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('BasketDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BasketDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class BasketTableCompanion extends UpdateCompanion<BasketDO> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const BasketTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  BasketTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<BasketDO> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (description != null) 'DESCRIPTION': description,
    });
  }

  BasketTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String?>? description}) {
    return BasketTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['NAME'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BasketTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $InvestmentTableTable extends InvestmentTable
    with TableInfo<$InvestmentTableTable, BaseInvestmentDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      check: () => name.isNotValue(''),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _basketIdMeta =
      const VerificationMeta('basketId');
  @override
  late final GeneratedColumn<int> basketId = GeneratedColumn<int>(
      'BASKET_ID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES basket_table (ID)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'VALUE', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _valueUpdatedOnMeta =
      const VerificationMeta('valueUpdatedOn');
  @override
  late final GeneratedColumn<DateTime> valueUpdatedOn =
      GeneratedColumn<DateTime>('VALUE_UPDATED_ON', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _irrMeta = const VerificationMeta('irr');
  @override
  late final GeneratedColumn<double> irr = GeneratedColumn<double>(
      'IRR', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _maturityDateMeta =
      const VerificationMeta('maturityDate');
  @override
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
      'MATURITY_DATE', aliasedName, true,
      check: () =>
          maturityDate.isNull() |
          maturityDate.isBiggerThanValue(DateTime.now()),
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  static const VerificationMeta _valueUpdatedDateMeta =
      const VerificationMeta('valueUpdatedDate');
  @override
  late final GeneratedColumn<DateTime> valueUpdatedDate =
      GeneratedColumn<DateTime>('VALUE_UPDATED_DATE', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _riskLevelMeta =
      const VerificationMeta('riskLevel');
  @override
  late final GeneratedColumnWithTypeConverter<RiskLevel, String> riskLevel =
      GeneratedColumn<String>('RISK_LEVEL', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RiskLevel>($InvestmentTableTable.$converterriskLevel);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        basketId,
        value,
        valueUpdatedOn,
        irr,
        maturityDate,
        valueUpdatedDate,
        riskLevel
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_table';
  @override
  VerificationContext validateIntegrity(Insertable<BaseInvestmentDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NAME')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    if (data.containsKey('BASKET_ID')) {
      context.handle(_basketIdMeta,
          basketId.isAcceptableOrUnknown(data['BASKET_ID']!, _basketIdMeta));
    }
    if (data.containsKey('VALUE')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['VALUE']!, _valueMeta));
    }
    if (data.containsKey('VALUE_UPDATED_ON')) {
      context.handle(
          _valueUpdatedOnMeta,
          valueUpdatedOn.isAcceptableOrUnknown(
              data['VALUE_UPDATED_ON']!, _valueUpdatedOnMeta));
    }
    if (data.containsKey('IRR')) {
      context.handle(
          _irrMeta, irr.isAcceptableOrUnknown(data['IRR']!, _irrMeta));
    }
    if (data.containsKey('MATURITY_DATE')) {
      context.handle(
          _maturityDateMeta,
          maturityDate.isAcceptableOrUnknown(
              data['MATURITY_DATE']!, _maturityDateMeta));
    }
    if (data.containsKey('VALUE_UPDATED_DATE')) {
      context.handle(
          _valueUpdatedDateMeta,
          valueUpdatedDate.isAcceptableOrUnknown(
              data['VALUE_UPDATED_DATE']!, _valueUpdatedDateMeta));
    }
    context.handle(_riskLevelMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BaseInvestmentDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseInvestmentDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      basketId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}BASKET_ID']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}VALUE']),
      valueUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON']),
      irr: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}IRR']),
      maturityDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}MATURITY_DATE']),
      valueUpdatedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_DATE']),
      riskLevel: $InvestmentTableTable.$converterriskLevel.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}RISK_LEVEL'])!),
    );
  }

  @override
  $InvestmentTableTable createAlias(String alias) {
    return $InvestmentTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RiskLevel, String, String> $converterriskLevel =
      const EnumNameConverter<RiskLevel>(RiskLevel.values);
}

class BaseInvestmentDO extends DataClass
    implements Insertable<BaseInvestmentDO> {
  final int id;
  final String name;
  final String? description;
  final int? basketId;
  final double? value;
  final DateTime? valueUpdatedOn;
  final double? irr;
  final DateTime? maturityDate;
  final DateTime? valueUpdatedDate;
  final RiskLevel riskLevel;
  const BaseInvestmentDO(
      {required this.id,
      required this.name,
      this.description,
      this.basketId,
      this.value,
      this.valueUpdatedOn,
      this.irr,
      this.maturityDate,
      this.valueUpdatedDate,
      required this.riskLevel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    if (!nullToAbsent || basketId != null) {
      map['BASKET_ID'] = Variable<int>(basketId);
    }
    if (!nullToAbsent || value != null) {
      map['VALUE'] = Variable<double>(value);
    }
    if (!nullToAbsent || valueUpdatedOn != null) {
      map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn);
    }
    if (!nullToAbsent || irr != null) {
      map['IRR'] = Variable<double>(irr);
    }
    if (!nullToAbsent || maturityDate != null) {
      map['MATURITY_DATE'] = Variable<DateTime>(maturityDate);
    }
    if (!nullToAbsent || valueUpdatedDate != null) {
      map['VALUE_UPDATED_DATE'] = Variable<DateTime>(valueUpdatedDate);
    }
    {
      map['RISK_LEVEL'] = Variable<String>(
          $InvestmentTableTable.$converterriskLevel.toSql(riskLevel));
    }
    return map;
  }

  InvestmentTableCompanion toCompanion(bool nullToAbsent) {
    return InvestmentTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      basketId: basketId == null && nullToAbsent
          ? const Value.absent()
          : Value(basketId),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      valueUpdatedOn: valueUpdatedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(valueUpdatedOn),
      irr: irr == null && nullToAbsent ? const Value.absent() : Value(irr),
      maturityDate: maturityDate == null && nullToAbsent
          ? const Value.absent()
          : Value(maturityDate),
      valueUpdatedDate: valueUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(valueUpdatedDate),
      riskLevel: Value(riskLevel),
    );
  }

  factory BaseInvestmentDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseInvestmentDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      basketId: serializer.fromJson<int?>(json['basketId']),
      value: serializer.fromJson<double?>(json['value']),
      valueUpdatedOn: serializer.fromJson<DateTime?>(json['valueUpdatedOn']),
      irr: serializer.fromJson<double?>(json['irr']),
      maturityDate: serializer.fromJson<DateTime?>(json['maturityDate']),
      valueUpdatedDate:
          serializer.fromJson<DateTime?>(json['valueUpdatedDate']),
      riskLevel: $InvestmentTableTable.$converterriskLevel
          .fromJson(serializer.fromJson<String>(json['riskLevel'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'basketId': serializer.toJson<int?>(basketId),
      'value': serializer.toJson<double?>(value),
      'valueUpdatedOn': serializer.toJson<DateTime?>(valueUpdatedOn),
      'irr': serializer.toJson<double?>(irr),
      'maturityDate': serializer.toJson<DateTime?>(maturityDate),
      'valueUpdatedDate': serializer.toJson<DateTime?>(valueUpdatedDate),
      'riskLevel': serializer.toJson<String>(
          $InvestmentTableTable.$converterriskLevel.toJson(riskLevel)),
    };
  }

  BaseInvestmentDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<int?> basketId = const Value.absent(),
          Value<double?> value = const Value.absent(),
          Value<DateTime?> valueUpdatedOn = const Value.absent(),
          Value<double?> irr = const Value.absent(),
          Value<DateTime?> maturityDate = const Value.absent(),
          Value<DateTime?> valueUpdatedDate = const Value.absent(),
          RiskLevel? riskLevel}) =>
      BaseInvestmentDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        basketId: basketId.present ? basketId.value : this.basketId,
        value: value.present ? value.value : this.value,
        valueUpdatedOn:
            valueUpdatedOn.present ? valueUpdatedOn.value : this.valueUpdatedOn,
        irr: irr.present ? irr.value : this.irr,
        maturityDate:
            maturityDate.present ? maturityDate.value : this.maturityDate,
        valueUpdatedDate: valueUpdatedDate.present
            ? valueUpdatedDate.value
            : this.valueUpdatedDate,
        riskLevel: riskLevel ?? this.riskLevel,
      );
  @override
  String toString() {
    return (StringBuffer('BaseInvestmentDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('basketId: $basketId, ')
          ..write('value: $value, ')
          ..write('valueUpdatedOn: $valueUpdatedOn, ')
          ..write('irr: $irr, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('valueUpdatedDate: $valueUpdatedDate, ')
          ..write('riskLevel: $riskLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, basketId, value,
      valueUpdatedOn, irr, maturityDate, valueUpdatedDate, riskLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseInvestmentDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.basketId == this.basketId &&
          other.value == this.value &&
          other.valueUpdatedOn == this.valueUpdatedOn &&
          other.irr == this.irr &&
          other.maturityDate == this.maturityDate &&
          other.valueUpdatedDate == this.valueUpdatedDate &&
          other.riskLevel == this.riskLevel);
}

class InvestmentTableCompanion extends UpdateCompanion<BaseInvestmentDO> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int?> basketId;
  final Value<double?> value;
  final Value<DateTime?> valueUpdatedOn;
  final Value<double?> irr;
  final Value<DateTime?> maturityDate;
  final Value<DateTime?> valueUpdatedDate;
  final Value<RiskLevel> riskLevel;
  const InvestmentTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.basketId = const Value.absent(),
    this.value = const Value.absent(),
    this.valueUpdatedOn = const Value.absent(),
    this.irr = const Value.absent(),
    this.maturityDate = const Value.absent(),
    this.valueUpdatedDate = const Value.absent(),
    this.riskLevel = const Value.absent(),
  });
  InvestmentTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.basketId = const Value.absent(),
    this.value = const Value.absent(),
    this.valueUpdatedOn = const Value.absent(),
    this.irr = const Value.absent(),
    this.maturityDate = const Value.absent(),
    this.valueUpdatedDate = const Value.absent(),
    required RiskLevel riskLevel,
  })  : name = Value(name),
        riskLevel = Value(riskLevel);
  static Insertable<BaseInvestmentDO> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? basketId,
    Expression<double>? value,
    Expression<DateTime>? valueUpdatedOn,
    Expression<double>? irr,
    Expression<DateTime>? maturityDate,
    Expression<DateTime>? valueUpdatedDate,
    Expression<String>? riskLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (description != null) 'DESCRIPTION': description,
      if (basketId != null) 'BASKET_ID': basketId,
      if (value != null) 'VALUE': value,
      if (valueUpdatedOn != null) 'VALUE_UPDATED_ON': valueUpdatedOn,
      if (irr != null) 'IRR': irr,
      if (maturityDate != null) 'MATURITY_DATE': maturityDate,
      if (valueUpdatedDate != null) 'VALUE_UPDATED_DATE': valueUpdatedDate,
      if (riskLevel != null) 'RISK_LEVEL': riskLevel,
    });
  }

  InvestmentTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int?>? basketId,
      Value<double?>? value,
      Value<DateTime?>? valueUpdatedOn,
      Value<double?>? irr,
      Value<DateTime?>? maturityDate,
      Value<DateTime?>? valueUpdatedDate,
      Value<RiskLevel>? riskLevel}) {
    return InvestmentTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      basketId: basketId ?? this.basketId,
      value: value ?? this.value,
      valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,
      irr: irr ?? this.irr,
      maturityDate: maturityDate ?? this.maturityDate,
      valueUpdatedDate: valueUpdatedDate ?? this.valueUpdatedDate,
      riskLevel: riskLevel ?? this.riskLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['NAME'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    if (basketId.present) {
      map['BASKET_ID'] = Variable<int>(basketId.value);
    }
    if (value.present) {
      map['VALUE'] = Variable<double>(value.value);
    }
    if (valueUpdatedOn.present) {
      map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn.value);
    }
    if (irr.present) {
      map['IRR'] = Variable<double>(irr.value);
    }
    if (maturityDate.present) {
      map['MATURITY_DATE'] = Variable<DateTime>(maturityDate.value);
    }
    if (valueUpdatedDate.present) {
      map['VALUE_UPDATED_DATE'] = Variable<DateTime>(valueUpdatedDate.value);
    }
    if (riskLevel.present) {
      map['RISK_LEVEL'] = Variable<String>(
          $InvestmentTableTable.$converterriskLevel.toSql(riskLevel.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('basketId: $basketId, ')
          ..write('value: $value, ')
          ..write('valueUpdatedOn: $valueUpdatedOn, ')
          ..write('irr: $irr, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('valueUpdatedDate: $valueUpdatedDate, ')
          ..write('riskLevel: $riskLevel')
          ..write(')'))
        .toString();
  }
}

class $SipTableTable extends SipTable with TableInfo<$SipTableTable, SipDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SipTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES investment_table (ID)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'START_DATE', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'END_DATE', aliasedName, true,
      check: () => endDate.isNull() | endDate.isBiggerThan(startDate),
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumnWithTypeConverter<Frequency, String> frequency =
      GeneratedColumn<String>('FREQUENCY', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Frequency>($SipTableTable.$converterfrequency);
  static const VerificationMeta _executedTillMeta =
      const VerificationMeta('executedTill');
  @override
  late final GeneratedColumn<DateTime> executedTill = GeneratedColumn<DateTime>(
      'EXECUTED_TILL', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        description,
        investmentId,
        amount,
        startDate,
        endDate,
        frequency,
        executedTill
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sip_table';
  @override
  VerificationContext validateIntegrity(Insertable<SipDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    if (data.containsKey('INVESTMENT_ID')) {
      context.handle(
          _investmentIdMeta,
          investmentId.isAcceptableOrUnknown(
              data['INVESTMENT_ID']!, _investmentIdMeta));
    } else if (isInserting) {
      context.missing(_investmentIdMeta);
    }
    if (data.containsKey('AMOUNT')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('START_DATE')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['START_DATE']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('END_DATE')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['END_DATE']!, _endDateMeta));
    }
    context.handle(_frequencyMeta, const VerificationResult.success());
    if (data.containsKey('EXECUTED_TILL')) {
      context.handle(
          _executedTillMeta,
          executedTill.isAcceptableOrUnknown(
              data['EXECUTED_TILL']!, _executedTillMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SipDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SipDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}START_DATE'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}END_DATE']),
      frequency: $SipTableTable.$converterfrequency.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}FREQUENCY'])!),
      executedTill: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}EXECUTED_TILL']),
    );
  }

  @override
  $SipTableTable createAlias(String alias) {
    return $SipTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Frequency, String, String> $converterfrequency =
      const EnumNameConverter<Frequency>(Frequency.values);
}

class SipDO extends DataClass implements Insertable<SipDO> {
  final int id;
  final String? description;
  final int investmentId;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final Frequency frequency;
  final DateTime? executedTill;
  const SipDO(
      {required this.id,
      this.description,
      required this.investmentId,
      required this.amount,
      required this.startDate,
      this.endDate,
      required this.frequency,
      this.executedTill});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    map['AMOUNT'] = Variable<double>(amount);
    map['START_DATE'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['END_DATE'] = Variable<DateTime>(endDate);
    }
    {
      map['FREQUENCY'] =
          Variable<String>($SipTableTable.$converterfrequency.toSql(frequency));
    }
    if (!nullToAbsent || executedTill != null) {
      map['EXECUTED_TILL'] = Variable<DateTime>(executedTill);
    }
    return map;
  }

  SipTableCompanion toCompanion(bool nullToAbsent) {
    return SipTableCompanion(
      id: Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      investmentId: Value(investmentId),
      amount: Value(amount),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      frequency: Value(frequency),
      executedTill: executedTill == null && nullToAbsent
          ? const Value.absent()
          : Value(executedTill),
    );
  }

  factory SipDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SipDO(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      amount: serializer.fromJson<double>(json['amount']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      frequency: $SipTableTable.$converterfrequency
          .fromJson(serializer.fromJson<String>(json['frequency'])),
      executedTill: serializer.fromJson<DateTime?>(json['executedTill']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String?>(description),
      'investmentId': serializer.toJson<int>(investmentId),
      'amount': serializer.toJson<double>(amount),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'frequency': serializer
          .toJson<String>($SipTableTable.$converterfrequency.toJson(frequency)),
      'executedTill': serializer.toJson<DateTime?>(executedTill),
    };
  }

  SipDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          int? investmentId,
          double? amount,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          Frequency? frequency,
          Value<DateTime?> executedTill = const Value.absent()}) =>
      SipDO(
        id: id ?? this.id,
        description: description.present ? description.value : this.description,
        investmentId: investmentId ?? this.investmentId,
        amount: amount ?? this.amount,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        frequency: frequency ?? this.frequency,
        executedTill:
            executedTill.present ? executedTill.value : this.executedTill,
      );
  @override
  String toString() {
    return (StringBuffer('SipDO(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('investmentId: $investmentId, ')
          ..write('amount: $amount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('frequency: $frequency, ')
          ..write('executedTill: $executedTill')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, investmentId, amount,
      startDate, endDate, frequency, executedTill);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SipDO &&
          other.id == this.id &&
          other.description == this.description &&
          other.investmentId == this.investmentId &&
          other.amount == this.amount &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.frequency == this.frequency &&
          other.executedTill == this.executedTill);
}

class SipTableCompanion extends UpdateCompanion<SipDO> {
  final Value<int> id;
  final Value<String?> description;
  final Value<int> investmentId;
  final Value<double> amount;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<Frequency> frequency;
  final Value<DateTime?> executedTill;
  const SipTableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.frequency = const Value.absent(),
    this.executedTill = const Value.absent(),
  });
  SipTableCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required int investmentId,
    required double amount,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required Frequency frequency,
    this.executedTill = const Value.absent(),
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        startDate = Value(startDate),
        frequency = Value(frequency);
  static Insertable<SipDO> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? investmentId,
    Expression<double>? amount,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? frequency,
    Expression<DateTime>? executedTill,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (description != null) 'DESCRIPTION': description,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (amount != null) 'AMOUNT': amount,
      if (startDate != null) 'START_DATE': startDate,
      if (endDate != null) 'END_DATE': endDate,
      if (frequency != null) 'FREQUENCY': frequency,
      if (executedTill != null) 'EXECUTED_TILL': executedTill,
    });
  }

  SipTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? description,
      Value<int>? investmentId,
      Value<double>? amount,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<Frequency>? frequency,
      Value<DateTime?>? executedTill}) {
    return SipTableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      investmentId: investmentId ?? this.investmentId,
      amount: amount ?? this.amount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      frequency: frequency ?? this.frequency,
      executedTill: executedTill ?? this.executedTill,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    if (investmentId.present) {
      map['INVESTMENT_ID'] = Variable<int>(investmentId.value);
    }
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (startDate.present) {
      map['START_DATE'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['END_DATE'] = Variable<DateTime>(endDate.value);
    }
    if (frequency.present) {
      map['FREQUENCY'] = Variable<String>(
          $SipTableTable.$converterfrequency.toSql(frequency.value));
    }
    if (executedTill.present) {
      map['EXECUTED_TILL'] = Variable<DateTime>(executedTill.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SipTableCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('investmentId: $investmentId, ')
          ..write('amount: $amount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('frequency: $frequency, ')
          ..write('executedTill: $executedTill')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, TransactionDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES investment_table (ID)'));
  static const VerificationMeta _sipIdMeta = const VerificationMeta('sipId');
  @override
  late final GeneratedColumn<int> sipId = GeneratedColumn<int>(
      'SIP_ID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sip_table (ID)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      check: () => amount.isBiggerThanValue(0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
      'QTY', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'CREATED_ON', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, description, investmentId, sipId, amount, qty, createdOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_table';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    if (data.containsKey('INVESTMENT_ID')) {
      context.handle(
          _investmentIdMeta,
          investmentId.isAcceptableOrUnknown(
              data['INVESTMENT_ID']!, _investmentIdMeta));
    } else if (isInserting) {
      context.missing(_investmentIdMeta);
    }
    if (data.containsKey('SIP_ID')) {
      context.handle(
          _sipIdMeta, sipId.isAcceptableOrUnknown(data['SIP_ID']!, _sipIdMeta));
    }
    if (data.containsKey('AMOUNT')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('QTY')) {
      context.handle(
          _qtyMeta, qty.isAcceptableOrUnknown(data['QTY']!, _qtyMeta));
    }
    if (data.containsKey('CREATED_ON')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['CREATED_ON']!, _createdOnMeta));
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      sipId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}SIP_ID']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      qty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}QTY'])!,
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}CREATED_ON'])!,
    );
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class TransactionDO extends DataClass implements Insertable<TransactionDO> {
  final int id;
  final String? description;
  final int investmentId;
  final int? sipId;
  final double amount;
  final double qty;
  final DateTime createdOn;
  const TransactionDO(
      {required this.id,
      this.description,
      required this.investmentId,
      this.sipId,
      required this.amount,
      required this.qty,
      required this.createdOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    if (!nullToAbsent || sipId != null) {
      map['SIP_ID'] = Variable<int>(sipId);
    }
    map['AMOUNT'] = Variable<double>(amount);
    map['QTY'] = Variable<double>(qty);
    map['CREATED_ON'] = Variable<DateTime>(createdOn);
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      investmentId: Value(investmentId),
      sipId:
          sipId == null && nullToAbsent ? const Value.absent() : Value(sipId),
      amount: Value(amount),
      qty: Value(qty),
      createdOn: Value(createdOn),
    );
  }

  factory TransactionDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDO(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      sipId: serializer.fromJson<int?>(json['sipId']),
      amount: serializer.fromJson<double>(json['amount']),
      qty: serializer.fromJson<double>(json['qty']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String?>(description),
      'investmentId': serializer.toJson<int>(investmentId),
      'sipId': serializer.toJson<int?>(sipId),
      'amount': serializer.toJson<double>(amount),
      'qty': serializer.toJson<double>(qty),
      'createdOn': serializer.toJson<DateTime>(createdOn),
    };
  }

  TransactionDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          int? investmentId,
          Value<int?> sipId = const Value.absent(),
          double? amount,
          double? qty,
          DateTime? createdOn}) =>
      TransactionDO(
        id: id ?? this.id,
        description: description.present ? description.value : this.description,
        investmentId: investmentId ?? this.investmentId,
        sipId: sipId.present ? sipId.value : this.sipId,
        amount: amount ?? this.amount,
        qty: qty ?? this.qty,
        createdOn: createdOn ?? this.createdOn,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDO(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('investmentId: $investmentId, ')
          ..write('sipId: $sipId, ')
          ..write('amount: $amount, ')
          ..write('qty: $qty, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, description, investmentId, sipId, amount, qty, createdOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDO &&
          other.id == this.id &&
          other.description == this.description &&
          other.investmentId == this.investmentId &&
          other.sipId == this.sipId &&
          other.amount == this.amount &&
          other.qty == this.qty &&
          other.createdOn == this.createdOn);
}

class TransactionTableCompanion extends UpdateCompanion<TransactionDO> {
  final Value<int> id;
  final Value<String?> description;
  final Value<int> investmentId;
  final Value<int?> sipId;
  final Value<double> amount;
  final Value<double> qty;
  final Value<DateTime> createdOn;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.sipId = const Value.absent(),
    this.amount = const Value.absent(),
    this.qty = const Value.absent(),
    this.createdOn = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required int investmentId,
    this.sipId = const Value.absent(),
    required double amount,
    this.qty = const Value.absent(),
    required DateTime createdOn,
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        createdOn = Value(createdOn);
  static Insertable<TransactionDO> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? investmentId,
    Expression<int>? sipId,
    Expression<double>? amount,
    Expression<double>? qty,
    Expression<DateTime>? createdOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (description != null) 'DESCRIPTION': description,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (sipId != null) 'SIP_ID': sipId,
      if (amount != null) 'AMOUNT': amount,
      if (qty != null) 'QTY': qty,
      if (createdOn != null) 'CREATED_ON': createdOn,
    });
  }

  TransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? description,
      Value<int>? investmentId,
      Value<int?>? sipId,
      Value<double>? amount,
      Value<double>? qty,
      Value<DateTime>? createdOn}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      investmentId: investmentId ?? this.investmentId,
      sipId: sipId ?? this.sipId,
      amount: amount ?? this.amount,
      qty: qty ?? this.qty,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    if (investmentId.present) {
      map['INVESTMENT_ID'] = Variable<int>(investmentId.value);
    }
    if (sipId.present) {
      map['SIP_ID'] = Variable<int>(sipId.value);
    }
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (qty.present) {
      map['QTY'] = Variable<double>(qty.value);
    }
    if (createdOn.present) {
      map['CREATED_ON'] = Variable<DateTime>(createdOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('investmentId: $investmentId, ')
          ..write('sipId: $sipId, ')
          ..write('amount: $amount, ')
          ..write('qty: $qty, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }
}

class $GoalTableTable extends GoalTable
    with TableInfo<$GoalTableTable, BaseGoalDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      check: () => amount.isBiggerThanValue(0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _amountUpdatedOnMeta =
      const VerificationMeta('amountUpdatedOn');
  @override
  late final GeneratedColumn<DateTime> amountUpdatedOn =
      GeneratedColumn<DateTime>('AMOUNT_UPDATED_ON', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _inflationMeta =
      const VerificationMeta('inflation');
  @override
  late final GeneratedColumn<double> inflation = GeneratedColumn<double>(
      'INFLATION', aliasedName, false,
      check: () => inflation.isBetweenValues(1, 100),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _maturityDateMeta =
      const VerificationMeta('maturityDate');
  @override
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
      'MATURITY_DATE', aliasedName, false,
      check: () => maturityDate.isBiggerThanValue(DateTime.now()),
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true);
  static const VerificationMeta _importanceMeta =
      const VerificationMeta('importance');
  @override
  late final GeneratedColumnWithTypeConverter<GoalImportance, String>
      importance = GeneratedColumn<String>('IMPORTANCE', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<GoalImportance>($GoalTableTable.$converterimportance);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        amount,
        amountUpdatedOn,
        inflation,
        maturityDate,
        importance
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_table';
  @override
  VerificationContext validateIntegrity(Insertable<BaseGoalDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NAME')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    if (data.containsKey('AMOUNT')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('AMOUNT_UPDATED_ON')) {
      context.handle(
          _amountUpdatedOnMeta,
          amountUpdatedOn.isAcceptableOrUnknown(
              data['AMOUNT_UPDATED_ON']!, _amountUpdatedOnMeta));
    } else if (isInserting) {
      context.missing(_amountUpdatedOnMeta);
    }
    if (data.containsKey('INFLATION')) {
      context.handle(_inflationMeta,
          inflation.isAcceptableOrUnknown(data['INFLATION']!, _inflationMeta));
    } else if (isInserting) {
      context.missing(_inflationMeta);
    }
    if (data.containsKey('MATURITY_DATE')) {
      context.handle(
          _maturityDateMeta,
          maturityDate.isAcceptableOrUnknown(
              data['MATURITY_DATE']!, _maturityDateMeta));
    } else if (isInserting) {
      context.missing(_maturityDateMeta);
    }
    context.handle(_importanceMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BaseGoalDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseGoalDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      amountUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}AMOUNT_UPDATED_ON'])!,
      inflation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}INFLATION'])!,
      maturityDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}MATURITY_DATE'])!,
      importance: $GoalTableTable.$converterimportance.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}IMPORTANCE'])!),
    );
  }

  @override
  $GoalTableTable createAlias(String alias) {
    return $GoalTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalImportance, String, String>
      $converterimportance =
      const EnumNameConverter<GoalImportance>(GoalImportance.values);
}

class BaseGoalDO extends DataClass implements Insertable<BaseGoalDO> {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final DateTime amountUpdatedOn;
  final double inflation;
  final DateTime maturityDate;
  final GoalImportance importance;
  const BaseGoalDO(
      {required this.id,
      required this.name,
      this.description,
      required this.amount,
      required this.amountUpdatedOn,
      required this.inflation,
      required this.maturityDate,
      required this.importance});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    map['AMOUNT'] = Variable<double>(amount);
    map['AMOUNT_UPDATED_ON'] = Variable<DateTime>(amountUpdatedOn);
    map['INFLATION'] = Variable<double>(inflation);
    map['MATURITY_DATE'] = Variable<DateTime>(maturityDate);
    {
      map['IMPORTANCE'] = Variable<String>(
          $GoalTableTable.$converterimportance.toSql(importance));
    }
    return map;
  }

  GoalTableCompanion toCompanion(bool nullToAbsent) {
    return GoalTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: Value(amount),
      amountUpdatedOn: Value(amountUpdatedOn),
      inflation: Value(inflation),
      maturityDate: Value(maturityDate),
      importance: Value(importance),
    );
  }

  factory BaseGoalDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseGoalDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      amountUpdatedOn: serializer.fromJson<DateTime>(json['amountUpdatedOn']),
      inflation: serializer.fromJson<double>(json['inflation']),
      maturityDate: serializer.fromJson<DateTime>(json['maturityDate']),
      importance: $GoalTableTable.$converterimportance
          .fromJson(serializer.fromJson<String>(json['importance'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<double>(amount),
      'amountUpdatedOn': serializer.toJson<DateTime>(amountUpdatedOn),
      'inflation': serializer.toJson<double>(inflation),
      'maturityDate': serializer.toJson<DateTime>(maturityDate),
      'importance': serializer.toJson<String>(
          $GoalTableTable.$converterimportance.toJson(importance)),
    };
  }

  BaseGoalDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          double? amount,
          DateTime? amountUpdatedOn,
          double? inflation,
          DateTime? maturityDate,
          GoalImportance? importance}) =>
      BaseGoalDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        amount: amount ?? this.amount,
        amountUpdatedOn: amountUpdatedOn ?? this.amountUpdatedOn,
        inflation: inflation ?? this.inflation,
        maturityDate: maturityDate ?? this.maturityDate,
        importance: importance ?? this.importance,
      );
  @override
  String toString() {
    return (StringBuffer('BaseGoalDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('amountUpdatedOn: $amountUpdatedOn, ')
          ..write('inflation: $inflation, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('importance: $importance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, amount,
      amountUpdatedOn, inflation, maturityDate, importance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseGoalDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.amountUpdatedOn == this.amountUpdatedOn &&
          other.inflation == this.inflation &&
          other.maturityDate == this.maturityDate &&
          other.importance == this.importance);
}

class GoalTableCompanion extends UpdateCompanion<BaseGoalDO> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> amount;
  final Value<DateTime> amountUpdatedOn;
  final Value<double> inflation;
  final Value<DateTime> maturityDate;
  final Value<GoalImportance> importance;
  const GoalTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountUpdatedOn = const Value.absent(),
    this.inflation = const Value.absent(),
    this.maturityDate = const Value.absent(),
    this.importance = const Value.absent(),
  });
  GoalTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required double amount,
    required DateTime amountUpdatedOn,
    required double inflation,
    required DateTime maturityDate,
    required GoalImportance importance,
  })  : name = Value(name),
        amount = Value(amount),
        amountUpdatedOn = Value(amountUpdatedOn),
        inflation = Value(inflation),
        maturityDate = Value(maturityDate),
        importance = Value(importance);
  static Insertable<BaseGoalDO> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<DateTime>? amountUpdatedOn,
    Expression<double>? inflation,
    Expression<DateTime>? maturityDate,
    Expression<String>? importance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (description != null) 'DESCRIPTION': description,
      if (amount != null) 'AMOUNT': amount,
      if (amountUpdatedOn != null) 'AMOUNT_UPDATED_ON': amountUpdatedOn,
      if (inflation != null) 'INFLATION': inflation,
      if (maturityDate != null) 'MATURITY_DATE': maturityDate,
      if (importance != null) 'IMPORTANCE': importance,
    });
  }

  GoalTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<double>? amount,
      Value<DateTime>? amountUpdatedOn,
      Value<double>? inflation,
      Value<DateTime>? maturityDate,
      Value<GoalImportance>? importance}) {
    return GoalTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      amountUpdatedOn: amountUpdatedOn ?? this.amountUpdatedOn,
      inflation: inflation ?? this.inflation,
      maturityDate: maturityDate ?? this.maturityDate,
      importance: importance ?? this.importance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['NAME'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (amountUpdatedOn.present) {
      map['AMOUNT_UPDATED_ON'] = Variable<DateTime>(amountUpdatedOn.value);
    }
    if (inflation.present) {
      map['INFLATION'] = Variable<double>(inflation.value);
    }
    if (maturityDate.present) {
      map['MATURITY_DATE'] = Variable<DateTime>(maturityDate.value);
    }
    if (importance.present) {
      map['IMPORTANCE'] = Variable<String>(
          $GoalTableTable.$converterimportance.toSql(importance.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('amountUpdatedOn: $amountUpdatedOn, ')
          ..write('inflation: $inflation, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('importance: $importance')
          ..write(')'))
        .toString();
  }
}

class $GoalInvestmentTableTable extends GoalInvestmentTable
    with TableInfo<$GoalInvestmentTableTable, BaseGoalInvestmentDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalInvestmentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'GOAL_ID', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES goal_table (ID)'));
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES investment_table (ID)'));
  static const VerificationMeta _splitPercentageMeta =
      const VerificationMeta('splitPercentage');
  @override
  late final GeneratedColumn<double> splitPercentage = GeneratedColumn<double>(
      'SPLIT_PERCENTAGE', aliasedName, false,
      check: () =>
          splitPercentage.isBiggerThanValue(0) |
          splitPercentage.isSmallerOrEqualValue(100),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, goalId, investmentId, splitPercentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_investment_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<BaseGoalInvestmentDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('GOAL_ID')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['GOAL_ID']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('INVESTMENT_ID')) {
      context.handle(
          _investmentIdMeta,
          investmentId.isAcceptableOrUnknown(
              data['INVESTMENT_ID']!, _investmentIdMeta));
    } else if (isInserting) {
      context.missing(_investmentIdMeta);
    }
    if (data.containsKey('SPLIT_PERCENTAGE')) {
      context.handle(
          _splitPercentageMeta,
          splitPercentage.isAcceptableOrUnknown(
              data['SPLIT_PERCENTAGE']!, _splitPercentageMeta));
    } else if (isInserting) {
      context.missing(_splitPercentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {goalId, investmentId},
      ];
  @override
  BaseGoalInvestmentDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseGoalInvestmentDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}GOAL_ID'])!,
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      splitPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}SPLIT_PERCENTAGE'])!,
    );
  }

  @override
  $GoalInvestmentTableTable createAlias(String alias) {
    return $GoalInvestmentTableTable(attachedDatabase, alias);
  }
}

class BaseGoalInvestmentDO extends DataClass
    implements Insertable<BaseGoalInvestmentDO> {
  final int id;
  final int goalId;
  final int investmentId;
  final double splitPercentage;
  const BaseGoalInvestmentDO(
      {required this.id,
      required this.goalId,
      required this.investmentId,
      required this.splitPercentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['GOAL_ID'] = Variable<int>(goalId);
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    map['SPLIT_PERCENTAGE'] = Variable<double>(splitPercentage);
    return map;
  }

  GoalInvestmentTableCompanion toCompanion(bool nullToAbsent) {
    return GoalInvestmentTableCompanion(
      id: Value(id),
      goalId: Value(goalId),
      investmentId: Value(investmentId),
      splitPercentage: Value(splitPercentage),
    );
  }

  factory BaseGoalInvestmentDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseGoalInvestmentDO(
      id: serializer.fromJson<int>(json['id']),
      goalId: serializer.fromJson<int>(json['goalId']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      splitPercentage: serializer.fromJson<double>(json['splitPercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalId': serializer.toJson<int>(goalId),
      'investmentId': serializer.toJson<int>(investmentId),
      'splitPercentage': serializer.toJson<double>(splitPercentage),
    };
  }

  BaseGoalInvestmentDO copyWith(
          {int? id, int? goalId, int? investmentId, double? splitPercentage}) =>
      BaseGoalInvestmentDO(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        investmentId: investmentId ?? this.investmentId,
        splitPercentage: splitPercentage ?? this.splitPercentage,
      );
  @override
  String toString() {
    return (StringBuffer('BaseGoalInvestmentDO(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('splitPercentage: $splitPercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, goalId, investmentId, splitPercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseGoalInvestmentDO &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.splitPercentage == this.splitPercentage);
}

class GoalInvestmentTableCompanion
    extends UpdateCompanion<BaseGoalInvestmentDO> {
  final Value<int> id;
  final Value<int> goalId;
  final Value<int> investmentId;
  final Value<double> splitPercentage;
  const GoalInvestmentTableCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.splitPercentage = const Value.absent(),
  });
  GoalInvestmentTableCompanion.insert({
    this.id = const Value.absent(),
    required int goalId,
    required int investmentId,
    required double splitPercentage,
  })  : goalId = Value(goalId),
        investmentId = Value(investmentId),
        splitPercentage = Value(splitPercentage);
  static Insertable<BaseGoalInvestmentDO> custom({
    Expression<int>? id,
    Expression<int>? goalId,
    Expression<int>? investmentId,
    Expression<double>? splitPercentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (goalId != null) 'GOAL_ID': goalId,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (splitPercentage != null) 'SPLIT_PERCENTAGE': splitPercentage,
    });
  }

  GoalInvestmentTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? goalId,
      Value<int>? investmentId,
      Value<double>? splitPercentage}) {
    return GoalInvestmentTableCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      investmentId: investmentId ?? this.investmentId,
      splitPercentage: splitPercentage ?? this.splitPercentage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (goalId.present) {
      map['GOAL_ID'] = Variable<int>(goalId.value);
    }
    if (investmentId.present) {
      map['INVESTMENT_ID'] = Variable<int>(investmentId.value);
    }
    if (splitPercentage.present) {
      map['SPLIT_PERCENTAGE'] = Variable<double>(splitPercentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalInvestmentTableCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('splitPercentage: $splitPercentage')
          ..write(')'))
        .toString();
  }
}

class $ScriptTableTable extends ScriptTable
    with TableInfo<$ScriptTableTable, ScriptDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _scriptMeta = const VerificationMeta('script');
  @override
  late final GeneratedColumn<String> script = GeneratedColumn<String>(
      'SCRIPT', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES investment_table (ID)'));
  @override
  List<GeneratedColumn> get $columns => [id, script, investmentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'script_table';
  @override
  VerificationContext validateIntegrity(Insertable<ScriptDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('SCRIPT')) {
      context.handle(_scriptMeta,
          script.isAcceptableOrUnknown(data['SCRIPT']!, _scriptMeta));
    } else if (isInserting) {
      context.missing(_scriptMeta);
    }
    if (data.containsKey('INVESTMENT_ID')) {
      context.handle(
          _investmentIdMeta,
          investmentId.isAcceptableOrUnknown(
              data['INVESTMENT_ID']!, _investmentIdMeta));
    } else if (isInserting) {
      context.missing(_investmentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScriptDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      script: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}SCRIPT'])!,
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
    );
  }

  @override
  $ScriptTableTable createAlias(String alias) {
    return $ScriptTableTable(attachedDatabase, alias);
  }
}

class ScriptDO extends DataClass implements Insertable<ScriptDO> {
  final int id;
  final String script;
  final int investmentId;
  const ScriptDO(
      {required this.id, required this.script, required this.investmentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['SCRIPT'] = Variable<String>(script);
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    return map;
  }

  ScriptTableCompanion toCompanion(bool nullToAbsent) {
    return ScriptTableCompanion(
      id: Value(id),
      script: Value(script),
      investmentId: Value(investmentId),
    );
  }

  factory ScriptDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptDO(
      id: serializer.fromJson<int>(json['id']),
      script: serializer.fromJson<String>(json['script']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'script': serializer.toJson<String>(script),
      'investmentId': serializer.toJson<int>(investmentId),
    };
  }

  ScriptDO copyWith({int? id, String? script, int? investmentId}) => ScriptDO(
        id: id ?? this.id,
        script: script ?? this.script,
        investmentId: investmentId ?? this.investmentId,
      );
  @override
  String toString() {
    return (StringBuffer('ScriptDO(')
          ..write('id: $id, ')
          ..write('script: $script, ')
          ..write('investmentId: $investmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, script, investmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptDO &&
          other.id == this.id &&
          other.script == this.script &&
          other.investmentId == this.investmentId);
}

class ScriptTableCompanion extends UpdateCompanion<ScriptDO> {
  final Value<int> id;
  final Value<String> script;
  final Value<int> investmentId;
  const ScriptTableCompanion({
    this.id = const Value.absent(),
    this.script = const Value.absent(),
    this.investmentId = const Value.absent(),
  });
  ScriptTableCompanion.insert({
    this.id = const Value.absent(),
    required String script,
    required int investmentId,
  })  : script = Value(script),
        investmentId = Value(investmentId);
  static Insertable<ScriptDO> custom({
    Expression<int>? id,
    Expression<String>? script,
    Expression<int>? investmentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (script != null) 'SCRIPT': script,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
    });
  }

  ScriptTableCompanion copyWith(
      {Value<int>? id, Value<String>? script, Value<int>? investmentId}) {
    return ScriptTableCompanion(
      id: id ?? this.id,
      script: script ?? this.script,
      investmentId: investmentId ?? this.investmentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (script.present) {
      map['SCRIPT'] = Variable<String>(script.value);
    }
    if (investmentId.present) {
      map['INVESTMENT_ID'] = Variable<int>(investmentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptTableCompanion(')
          ..write('id: $id, ')
          ..write('script: $script, ')
          ..write('investmentId: $investmentId')
          ..write(')'))
        .toString();
  }
}

class $ExpenseTableTable extends ExpenseTable
    with TableInfo<$ExpenseTableTable, ExpenseDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'TAGS', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'CREATED_ON', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, description, amount, tags, createdOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    if (data.containsKey('AMOUNT')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('TAGS')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['TAGS']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('CREATED_ON')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['CREATED_ON']!, _createdOnMeta));
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}TAGS'])!,
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}CREATED_ON'])!,
    );
  }

  @override
  $ExpenseTableTable createAlias(String alias) {
    return $ExpenseTableTable(attachedDatabase, alias);
  }
}

class ExpenseDO extends DataClass implements Insertable<ExpenseDO> {
  final int id;
  final String? description;
  final double amount;
  final String tags;
  final DateTime createdOn;
  const ExpenseDO(
      {required this.id,
      this.description,
      required this.amount,
      required this.tags,
      required this.createdOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    map['AMOUNT'] = Variable<double>(amount);
    map['TAGS'] = Variable<String>(tags);
    map['CREATED_ON'] = Variable<DateTime>(createdOn);
    return map;
  }

  ExpenseTableCompanion toCompanion(bool nullToAbsent) {
    return ExpenseTableCompanion(
      id: Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: Value(amount),
      tags: Value(tags),
      createdOn: Value(createdOn),
    );
  }

  factory ExpenseDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseDO(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      tags: serializer.fromJson<String>(json['tags']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<double>(amount),
      'tags': serializer.toJson<String>(tags),
      'createdOn': serializer.toJson<DateTime>(createdOn),
    };
  }

  ExpenseDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          double? amount,
          String? tags,
          DateTime? createdOn}) =>
      ExpenseDO(
        id: id ?? this.id,
        description: description.present ? description.value : this.description,
        amount: amount ?? this.amount,
        tags: tags ?? this.tags,
        createdOn: createdOn ?? this.createdOn,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseDO(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('tags: $tags, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, amount, tags, createdOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseDO &&
          other.id == this.id &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.tags == this.tags &&
          other.createdOn == this.createdOn);
}

class ExpenseTableCompanion extends UpdateCompanion<ExpenseDO> {
  final Value<int> id;
  final Value<String?> description;
  final Value<double> amount;
  final Value<String> tags;
  final Value<DateTime> createdOn;
  const ExpenseTableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdOn = const Value.absent(),
  });
  ExpenseTableCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required double amount,
    required String tags,
    required DateTime createdOn,
  })  : amount = Value(amount),
        tags = Value(tags),
        createdOn = Value(createdOn);
  static Insertable<ExpenseDO> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? tags,
    Expression<DateTime>? createdOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (description != null) 'DESCRIPTION': description,
      if (amount != null) 'AMOUNT': amount,
      if (tags != null) 'TAGS': tags,
      if (createdOn != null) 'CREATED_ON': createdOn,
    });
  }

  ExpenseTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? description,
      Value<double>? amount,
      Value<String>? tags,
      Value<DateTime>? createdOn}) {
    return ExpenseTableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      tags: tags ?? this.tags,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (tags.present) {
      map['TAGS'] = Variable<String>(tags.value);
    }
    if (createdOn.present) {
      map['CREATED_ON'] = Variable<DateTime>(createdOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseTableCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('tags: $tags, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }
}

class $ExpenseTagTableTable extends ExpenseTagTable
    with TableInfo<$ExpenseTagTableTable, ExpenseTagDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseTagTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      check: () => name.isNotValue(''),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_tag_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseTagDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NAME')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseTagDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseTagDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
    );
  }

  @override
  $ExpenseTagTableTable createAlias(String alias) {
    return $ExpenseTagTableTable(attachedDatabase, alias);
  }
}

class ExpenseTagDO extends DataClass implements Insertable<ExpenseTagDO> {
  final int id;
  final String name;
  final String? description;
  const ExpenseTagDO({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['DESCRIPTION'] = Variable<String>(description);
    }
    return map;
  }

  ExpenseTagTableCompanion toCompanion(bool nullToAbsent) {
    return ExpenseTagTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory ExpenseTagDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseTagDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  ExpenseTagDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent()}) =>
      ExpenseTagDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseTagDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseTagDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class ExpenseTagTableCompanion extends UpdateCompanion<ExpenseTagDO> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const ExpenseTagTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  ExpenseTagTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ExpenseTagDO> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (description != null) 'DESCRIPTION': description,
    });
  }

  ExpenseTagTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String?>? description}) {
    return ExpenseTagTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['NAME'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseTagTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $AggregatedExpenseTableTable extends AggregatedExpenseTable
    with TableInfo<$AggregatedExpenseTableTable, AggregatedExpenseDO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AggregatedExpenseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'TAGS', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdMonthDateMeta =
      const VerificationMeta('createdMonthDate');
  @override
  late final GeneratedColumn<DateTime> createdMonthDate =
      GeneratedColumn<DateTime>('CREATED_MONTH_DATE', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, amount, tags, createdMonthDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aggregated_expense_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AggregatedExpenseDO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('AMOUNT')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('TAGS')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['TAGS']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('CREATED_MONTH_DATE')) {
      context.handle(
          _createdMonthDateMeta,
          createdMonthDate.isAcceptableOrUnknown(
              data['CREATED_MONTH_DATE']!, _createdMonthDateMeta));
    } else if (isInserting) {
      context.missing(_createdMonthDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AggregatedExpenseDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AggregatedExpenseDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}TAGS'])!,
      createdMonthDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}CREATED_MONTH_DATE'])!,
    );
  }

  @override
  $AggregatedExpenseTableTable createAlias(String alias) {
    return $AggregatedExpenseTableTable(attachedDatabase, alias);
  }
}

class AggregatedExpenseDO extends DataClass
    implements Insertable<AggregatedExpenseDO> {
  final int id;
  final double amount;
  final String tags;
  final DateTime createdMonthDate;
  const AggregatedExpenseDO(
      {required this.id,
      required this.amount,
      required this.tags,
      required this.createdMonthDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['AMOUNT'] = Variable<double>(amount);
    map['TAGS'] = Variable<String>(tags);
    map['CREATED_MONTH_DATE'] = Variable<DateTime>(createdMonthDate);
    return map;
  }

  AggregatedExpenseTableCompanion toCompanion(bool nullToAbsent) {
    return AggregatedExpenseTableCompanion(
      id: Value(id),
      amount: Value(amount),
      tags: Value(tags),
      createdMonthDate: Value(createdMonthDate),
    );
  }

  factory AggregatedExpenseDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AggregatedExpenseDO(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      tags: serializer.fromJson<String>(json['tags']),
      createdMonthDate: serializer.fromJson<DateTime>(json['createdMonthDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'tags': serializer.toJson<String>(tags),
      'createdMonthDate': serializer.toJson<DateTime>(createdMonthDate),
    };
  }

  AggregatedExpenseDO copyWith(
          {int? id,
          double? amount,
          String? tags,
          DateTime? createdMonthDate}) =>
      AggregatedExpenseDO(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        tags: tags ?? this.tags,
        createdMonthDate: createdMonthDate ?? this.createdMonthDate,
      );
  @override
  String toString() {
    return (StringBuffer('AggregatedExpenseDO(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('tags: $tags, ')
          ..write('createdMonthDate: $createdMonthDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, tags, createdMonthDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AggregatedExpenseDO &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.tags == this.tags &&
          other.createdMonthDate == this.createdMonthDate);
}

class AggregatedExpenseTableCompanion
    extends UpdateCompanion<AggregatedExpenseDO> {
  final Value<int> id;
  final Value<double> amount;
  final Value<String> tags;
  final Value<DateTime> createdMonthDate;
  const AggregatedExpenseTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdMonthDate = const Value.absent(),
  });
  AggregatedExpenseTableCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    required String tags,
    required DateTime createdMonthDate,
  })  : amount = Value(amount),
        tags = Value(tags),
        createdMonthDate = Value(createdMonthDate);
  static Insertable<AggregatedExpenseDO> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<String>? tags,
    Expression<DateTime>? createdMonthDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (amount != null) 'AMOUNT': amount,
      if (tags != null) 'TAGS': tags,
      if (createdMonthDate != null) 'CREATED_MONTH_DATE': createdMonthDate,
    });
  }

  AggregatedExpenseTableCompanion copyWith(
      {Value<int>? id,
      Value<double>? amount,
      Value<String>? tags,
      Value<DateTime>? createdMonthDate}) {
    return AggregatedExpenseTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      tags: tags ?? this.tags,
      createdMonthDate: createdMonthDate ?? this.createdMonthDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (tags.present) {
      map['TAGS'] = Variable<String>(tags.value);
    }
    if (createdMonthDate.present) {
      map['CREATED_MONTH_DATE'] = Variable<DateTime>(createdMonthDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AggregatedExpenseTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('tags: $tags, ')
          ..write('createdMonthDate: $createdMonthDate')
          ..write(')'))
        .toString();
  }
}

class InvestmentDO extends DataClass {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final DateTime? maturityDate;
  final double? irr;
  final double? value;
  final DateTime? valueUpdatedOn;
  final int? basketId;
  final String? basketName;
  final int? totalTransactions;
  final int? totalSips;
  final double? qty;
  const InvestmentDO(
      {required this.id,
      required this.name,
      this.description,
      required this.riskLevel,
      this.maturityDate,
      this.irr,
      this.value,
      this.valueUpdatedOn,
      this.basketId,
      this.basketName,
      this.totalTransactions,
      this.totalSips,
      this.qty});
  factory InvestmentDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      riskLevel: $InvestmentTableTable.$converterriskLevel
          .fromJson(serializer.fromJson<String>(json['riskLevel'])),
      maturityDate: serializer.fromJson<DateTime?>(json['maturityDate']),
      irr: serializer.fromJson<double?>(json['irr']),
      value: serializer.fromJson<double?>(json['value']),
      valueUpdatedOn: serializer.fromJson<DateTime?>(json['valueUpdatedOn']),
      basketId: serializer.fromJson<int?>(json['basketId']),
      basketName: serializer.fromJson<String?>(json['basketName']),
      totalTransactions: serializer.fromJson<int?>(json['totalTransactions']),
      totalSips: serializer.fromJson<int?>(json['totalSips']),
      qty: serializer.fromJson<double?>(json['qty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'riskLevel': serializer.toJson<String>(
          $InvestmentTableTable.$converterriskLevel.toJson(riskLevel)),
      'maturityDate': serializer.toJson<DateTime?>(maturityDate),
      'irr': serializer.toJson<double?>(irr),
      'value': serializer.toJson<double?>(value),
      'valueUpdatedOn': serializer.toJson<DateTime?>(valueUpdatedOn),
      'basketId': serializer.toJson<int?>(basketId),
      'basketName': serializer.toJson<String?>(basketName),
      'totalTransactions': serializer.toJson<int?>(totalTransactions),
      'totalSips': serializer.toJson<int?>(totalSips),
      'qty': serializer.toJson<double?>(qty),
    };
  }

  InvestmentDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          RiskLevel? riskLevel,
          Value<DateTime?> maturityDate = const Value.absent(),
          Value<double?> irr = const Value.absent(),
          Value<double?> value = const Value.absent(),
          Value<DateTime?> valueUpdatedOn = const Value.absent(),
          Value<int?> basketId = const Value.absent(),
          Value<String?> basketName = const Value.absent(),
          Value<int?> totalTransactions = const Value.absent(),
          Value<int?> totalSips = const Value.absent(),
          Value<double?> qty = const Value.absent()}) =>
      InvestmentDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        riskLevel: riskLevel ?? this.riskLevel,
        maturityDate:
            maturityDate.present ? maturityDate.value : this.maturityDate,
        irr: irr.present ? irr.value : this.irr,
        value: value.present ? value.value : this.value,
        valueUpdatedOn:
            valueUpdatedOn.present ? valueUpdatedOn.value : this.valueUpdatedOn,
        basketId: basketId.present ? basketId.value : this.basketId,
        basketName: basketName.present ? basketName.value : this.basketName,
        totalTransactions: totalTransactions.present
            ? totalTransactions.value
            : this.totalTransactions,
        totalSips: totalSips.present ? totalSips.value : this.totalSips,
        qty: qty.present ? qty.value : this.qty,
      );
  @override
  String toString() {
    return (StringBuffer('InvestmentDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('irr: $irr, ')
          ..write('value: $value, ')
          ..write('valueUpdatedOn: $valueUpdatedOn, ')
          ..write('basketId: $basketId, ')
          ..write('basketName: $basketName, ')
          ..write('totalTransactions: $totalTransactions, ')
          ..write('totalSips: $totalSips, ')
          ..write('qty: $qty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      riskLevel,
      maturityDate,
      irr,
      value,
      valueUpdatedOn,
      basketId,
      basketName,
      totalTransactions,
      totalSips,
      qty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.riskLevel == this.riskLevel &&
          other.maturityDate == this.maturityDate &&
          other.irr == this.irr &&
          other.value == this.value &&
          other.valueUpdatedOn == this.valueUpdatedOn &&
          other.basketId == this.basketId &&
          other.basketName == this.basketName &&
          other.totalTransactions == this.totalTransactions &&
          other.totalSips == this.totalSips &&
          other.qty == this.qty);
}

class $InvestmentEnrichedViewView
    extends ViewInfo<$InvestmentEnrichedViewView, InvestmentDO>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $InvestmentEnrichedViewView(this.attachedDatabase, [this._alias]);
  $InvestmentTableTable get investment =>
      attachedDatabase.investmentTable.createAlias('t0');
  $BasketTableTable get basket =>
      attachedDatabase.basketTable.createAlias('t1');
  $TransactionTableTable get transaction =>
      attachedDatabase.transactionTable.createAlias('t2');
  $SipTableTable get sip => attachedDatabase.sipTable.createAlias('t3');
  $ScriptTableTable get script =>
      attachedDatabase.scriptTable.createAlias('t4');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        riskLevel,
        maturityDate,
        irr,
        value,
        valueUpdatedOn,
        basketId,
        basketName,
        totalTransactions,
        totalSips,
        qty
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'investment_enriched_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $InvestmentEnrichedViewView get asDslTable => this;
  @override
  InvestmentDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      riskLevel: $InvestmentTableTable.$converterriskLevel.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}RISK_LEVEL'])!),
      maturityDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}MATURITY_DATE']),
      irr: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}IRR']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}VALUE']),
      valueUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON']),
      basketId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}basket_id']),
      basketName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}basket_name']),
      totalTransactions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_transactions']),
      totalSips: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_sips']),
      qty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}qty']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      generatedAs: GeneratedAs(investment.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      generatedAs: GeneratedAs(investment.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      generatedAs: GeneratedAs(investment.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumnWithTypeConverter<RiskLevel, String> riskLevel =
      GeneratedColumn<String>('RISK_LEVEL', aliasedName, false,
              generatedAs: GeneratedAs(investment.riskLevel, false),
              type: DriftSqlType.string)
          .withConverter<RiskLevel>($InvestmentTableTable.$converterriskLevel);
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
      'MATURITY_DATE', aliasedName, true,
      generatedAs: GeneratedAs(investment.maturityDate, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<double> irr = GeneratedColumn<double>(
      'IRR', aliasedName, true,
      generatedAs: GeneratedAs(investment.irr, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'VALUE', aliasedName, true,
      generatedAs: GeneratedAs(investment.value, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<DateTime> valueUpdatedOn =
      GeneratedColumn<DateTime>('VALUE_UPDATED_ON', aliasedName, true,
          generatedAs: GeneratedAs(investment.valueUpdatedOn, false),
          type: DriftSqlType.dateTime);
  late final GeneratedColumn<int> basketId = GeneratedColumn<int>(
      'basket_id', aliasedName, true,
      generatedAs: GeneratedAs(basket.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> basketName = GeneratedColumn<String>(
      'basket_name', aliasedName, true,
      generatedAs: GeneratedAs(basket.name, false), type: DriftSqlType.string);
  late final GeneratedColumn<int> totalTransactions = GeneratedColumn<int>(
      'total_transactions', aliasedName, true,
      generatedAs: GeneratedAs(
          transaction.id.count(
              distinct: true,
              filter: transaction.investmentId.equalsExp(investment.id)),
          false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> totalSips = GeneratedColumn<int>(
      'total_sips', aliasedName, true,
      generatedAs: GeneratedAs(
          sip.id.count(
              distinct: true,
              filter: sip.investmentId.equalsExp(investment.id)),
          false),
      type: DriftSqlType.int);
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
      'qty', aliasedName, true,
      generatedAs: GeneratedAs(
          transaction.qty
              .sum(filter: transaction.investmentId.equalsExp(investment.id)),
          false),
      type: DriftSqlType.double);
  @override
  $InvestmentEnrichedViewView createAlias(String alias) {
    return $InvestmentEnrichedViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(investment)..addColumns($columns)).join([
        leftOuterJoin(basket, basket.id.equalsExp(investment.basketId)),
        leftOuterJoin(
            transaction, transaction.investmentId.equalsExp(investment.id)),
        leftOuterJoin(sip, sip.investmentId.equalsExp(investment.id)),
        leftOuterJoin(script, script.investmentId.equalsExp(investment.id))
      ])
        ..groupBy([investment.id]);
  @override
  Set<String> get readTables => const {
        'investment_table',
        'basket_table',
        'transaction_table',
        'sip_table',
        'script_table'
      };
}

class GoalInvestmentDO extends DataClass {
  final int id;
  final int investmentId;
  final int goalId;
  final double splitPercentage;
  final String? investmentName;
  final String? goalName;
  final DateTime? maturityDate;
  const GoalInvestmentDO(
      {required this.id,
      required this.investmentId,
      required this.goalId,
      required this.splitPercentage,
      this.investmentName,
      this.goalName,
      this.maturityDate});
  factory GoalInvestmentDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalInvestmentDO(
      id: serializer.fromJson<int>(json['id']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      goalId: serializer.fromJson<int>(json['goalId']),
      splitPercentage: serializer.fromJson<double>(json['splitPercentage']),
      investmentName: serializer.fromJson<String?>(json['investmentName']),
      goalName: serializer.fromJson<String?>(json['goalName']),
      maturityDate: serializer.fromJson<DateTime?>(json['maturityDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'investmentId': serializer.toJson<int>(investmentId),
      'goalId': serializer.toJson<int>(goalId),
      'splitPercentage': serializer.toJson<double>(splitPercentage),
      'investmentName': serializer.toJson<String?>(investmentName),
      'goalName': serializer.toJson<String?>(goalName),
      'maturityDate': serializer.toJson<DateTime?>(maturityDate),
    };
  }

  GoalInvestmentDO copyWith(
          {int? id,
          int? investmentId,
          int? goalId,
          double? splitPercentage,
          Value<String?> investmentName = const Value.absent(),
          Value<String?> goalName = const Value.absent(),
          Value<DateTime?> maturityDate = const Value.absent()}) =>
      GoalInvestmentDO(
        id: id ?? this.id,
        investmentId: investmentId ?? this.investmentId,
        goalId: goalId ?? this.goalId,
        splitPercentage: splitPercentage ?? this.splitPercentage,
        investmentName:
            investmentName.present ? investmentName.value : this.investmentName,
        goalName: goalName.present ? goalName.value : this.goalName,
        maturityDate:
            maturityDate.present ? maturityDate.value : this.maturityDate,
      );
  @override
  String toString() {
    return (StringBuffer('GoalInvestmentDO(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('goalId: $goalId, ')
          ..write('splitPercentage: $splitPercentage, ')
          ..write('investmentName: $investmentName, ')
          ..write('goalName: $goalName, ')
          ..write('maturityDate: $maturityDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, investmentId, goalId, splitPercentage,
      investmentName, goalName, maturityDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalInvestmentDO &&
          other.id == this.id &&
          other.investmentId == this.investmentId &&
          other.goalId == this.goalId &&
          other.splitPercentage == this.splitPercentage &&
          other.investmentName == this.investmentName &&
          other.goalName == this.goalName &&
          other.maturityDate == this.maturityDate);
}

class $GoalInvestmentEnrichedViewView
    extends ViewInfo<$GoalInvestmentEnrichedViewView, GoalInvestmentDO>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $GoalInvestmentEnrichedViewView(this.attachedDatabase, [this._alias]);
  $GoalInvestmentTableTable get goalInvestment =>
      attachedDatabase.goalInvestmentTable.createAlias('t0');
  $InvestmentTableTable get investment =>
      attachedDatabase.investmentTable.createAlias('t1');
  $GoalTableTable get goal => attachedDatabase.goalTable.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        investmentId,
        goalId,
        splitPercentage,
        investmentName,
        goalName,
        maturityDate
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'goal_investment_enriched_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $GoalInvestmentEnrichedViewView get asDslTable => this;
  @override
  GoalInvestmentDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalInvestmentDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}GOAL_ID'])!,
      splitPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}SPLIT_PERCENTAGE'])!,
      investmentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}investment_name']),
      goalName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_name']),
      maturityDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}maturity_date']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      generatedAs: GeneratedAs(goalInvestment.id, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      generatedAs: GeneratedAs(goalInvestment.investmentId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'GOAL_ID', aliasedName, false,
      generatedAs: GeneratedAs(goalInvestment.goalId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<double> splitPercentage = GeneratedColumn<double>(
      'SPLIT_PERCENTAGE', aliasedName, false,
      generatedAs: GeneratedAs(goalInvestment.splitPercentage, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<String> investmentName = GeneratedColumn<String>(
      'investment_name', aliasedName, true,
      generatedAs: GeneratedAs(investment.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> goalName = GeneratedColumn<String>(
      'goal_name', aliasedName, true,
      generatedAs: GeneratedAs(goal.name, false), type: DriftSqlType.string);
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
      'maturity_date', aliasedName, true,
      generatedAs: GeneratedAs(goal.maturityDate, false),
      type: DriftSqlType.dateTime);
  @override
  $GoalInvestmentEnrichedViewView createAlias(String alias) {
    return $GoalInvestmentEnrichedViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(goalInvestment)..addColumns($columns)).join([
        innerJoin(
            investment, investment.id.equalsExp(goalInvestment.investmentId)),
        innerJoin(goal, goal.id.equalsExp(goalInvestment.goalId))
      ])
        ..groupBy([goalInvestment.id]);
  @override
  Set<String> get readTables =>
      const {'goal_investment_table', 'investment_table', 'goal_table'};
}

class GoalDO extends DataClass {
  final int id;
  final String name;
  final String? description;
  final GoalImportance importance;
  final DateTime maturityDate;
  final double amount;
  final double inflation;
  final DateTime amountUpdatedOn;
  final int? taggedInvestmentCount;
  const GoalDO(
      {required this.id,
      required this.name,
      this.description,
      required this.importance,
      required this.maturityDate,
      required this.amount,
      required this.inflation,
      required this.amountUpdatedOn,
      this.taggedInvestmentCount});
  factory GoalDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      importance: $GoalTableTable.$converterimportance
          .fromJson(serializer.fromJson<String>(json['importance'])),
      maturityDate: serializer.fromJson<DateTime>(json['maturityDate']),
      amount: serializer.fromJson<double>(json['amount']),
      inflation: serializer.fromJson<double>(json['inflation']),
      amountUpdatedOn: serializer.fromJson<DateTime>(json['amountUpdatedOn']),
      taggedInvestmentCount:
          serializer.fromJson<int?>(json['taggedInvestmentCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'importance': serializer.toJson<String>(
          $GoalTableTable.$converterimportance.toJson(importance)),
      'maturityDate': serializer.toJson<DateTime>(maturityDate),
      'amount': serializer.toJson<double>(amount),
      'inflation': serializer.toJson<double>(inflation),
      'amountUpdatedOn': serializer.toJson<DateTime>(amountUpdatedOn),
      'taggedInvestmentCount': serializer.toJson<int?>(taggedInvestmentCount),
    };
  }

  GoalDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          GoalImportance? importance,
          DateTime? maturityDate,
          double? amount,
          double? inflation,
          DateTime? amountUpdatedOn,
          Value<int?> taggedInvestmentCount = const Value.absent()}) =>
      GoalDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        importance: importance ?? this.importance,
        maturityDate: maturityDate ?? this.maturityDate,
        amount: amount ?? this.amount,
        inflation: inflation ?? this.inflation,
        amountUpdatedOn: amountUpdatedOn ?? this.amountUpdatedOn,
        taggedInvestmentCount: taggedInvestmentCount.present
            ? taggedInvestmentCount.value
            : this.taggedInvestmentCount,
      );
  @override
  String toString() {
    return (StringBuffer('GoalDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('importance: $importance, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('amount: $amount, ')
          ..write('inflation: $inflation, ')
          ..write('amountUpdatedOn: $amountUpdatedOn, ')
          ..write('taggedInvestmentCount: $taggedInvestmentCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, importance,
      maturityDate, amount, inflation, amountUpdatedOn, taggedInvestmentCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.importance == this.importance &&
          other.maturityDate == this.maturityDate &&
          other.amount == this.amount &&
          other.inflation == this.inflation &&
          other.amountUpdatedOn == this.amountUpdatedOn &&
          other.taggedInvestmentCount == this.taggedInvestmentCount);
}

class $GoalEnrichedViewView extends ViewInfo<$GoalEnrichedViewView, GoalDO>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $GoalEnrichedViewView(this.attachedDatabase, [this._alias]);
  $GoalTableTable get goal => attachedDatabase.goalTable.createAlias('t0');
  $GoalInvestmentTableTable get goalInvestment =>
      attachedDatabase.goalInvestmentTable.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        importance,
        maturityDate,
        amount,
        inflation,
        amountUpdatedOn,
        taggedInvestmentCount
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'goal_enriched_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $GoalEnrichedViewView get asDslTable => this;
  @override
  GoalDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalDO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']),
      importance: $GoalTableTable.$converterimportance.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}IMPORTANCE'])!),
      maturityDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}MATURITY_DATE'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      inflation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}INFLATION'])!,
      amountUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}AMOUNT_UPDATED_ON'])!,
      taggedInvestmentCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}tagged_investment_count']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      generatedAs: GeneratedAs(goal.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      generatedAs: GeneratedAs(goal.name, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      generatedAs: GeneratedAs(goal.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumnWithTypeConverter<GoalImportance, String>
      importance = GeneratedColumn<String>('IMPORTANCE', aliasedName, false,
              generatedAs: GeneratedAs(goal.importance, false),
              type: DriftSqlType.string)
          .withConverter<GoalImportance>($GoalTableTable.$converterimportance);
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
      'MATURITY_DATE', aliasedName, false,
      generatedAs: GeneratedAs(goal.maturityDate, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      generatedAs: GeneratedAs(goal.amount, false), type: DriftSqlType.double);
  late final GeneratedColumn<double> inflation = GeneratedColumn<double>(
      'INFLATION', aliasedName, false,
      generatedAs: GeneratedAs(goal.inflation, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<DateTime> amountUpdatedOn =
      GeneratedColumn<DateTime>('AMOUNT_UPDATED_ON', aliasedName, false,
          generatedAs: GeneratedAs(goal.amountUpdatedOn, false),
          type: DriftSqlType.dateTime);
  late final GeneratedColumn<int> taggedInvestmentCount = GeneratedColumn<int>(
      'tagged_investment_count', aliasedName, true,
      generatedAs: GeneratedAs(
          goalInvestment.investmentId.count(
              distinct: true, filter: goalInvestment.goalId.equalsExp(goal.id)),
          false),
      type: DriftSqlType.int);
  @override
  $GoalEnrichedViewView createAlias(String alias) {
    return $GoalEnrichedViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(goal)..addColumns($columns)).join([
        leftOuterJoin(goalInvestment, goalInvestment.goalId.equalsExp(goal.id))
      ])
        ..groupBy([goal.id]);
  @override
  Set<String> get readTables => const {'goal_table', 'goal_investment_table'};
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $BasketTableTable basketTable = $BasketTableTable(this);
  late final $InvestmentTableTable investmentTable =
      $InvestmentTableTable(this);
  late final $SipTableTable sipTable = $SipTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $GoalTableTable goalTable = $GoalTableTable(this);
  late final $GoalInvestmentTableTable goalInvestmentTable =
      $GoalInvestmentTableTable(this);
  late final $ScriptTableTable scriptTable = $ScriptTableTable(this);
  late final $ExpenseTableTable expenseTable = $ExpenseTableTable(this);
  late final $ExpenseTagTableTable expenseTagTable =
      $ExpenseTagTableTable(this);
  late final $AggregatedExpenseTableTable aggregatedExpenseTable =
      $AggregatedExpenseTableTable(this);
  late final $InvestmentEnrichedViewView investmentEnrichedView =
      $InvestmentEnrichedViewView(this);
  late final $GoalInvestmentEnrichedViewView goalInvestmentEnrichedView =
      $GoalInvestmentEnrichedViewView(this);
  late final $GoalEnrichedViewView goalEnrichedView =
      $GoalEnrichedViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        basketTable,
        investmentTable,
        sipTable,
        transactionTable,
        goalTable,
        goalInvestmentTable,
        scriptTable,
        expenseTable,
        expenseTagTable,
        aggregatedExpenseTable,
        investmentEnrichedView,
        goalInvestmentEnrichedView,
        goalEnrichedView
      ];
}
