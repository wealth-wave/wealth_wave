// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTableTable extends BasketTable
    with TableInfo<$BasketTableTable, BaseBasketDO> {
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
  VerificationContext validateIntegrity(Insertable<BaseBasketDO> instance,
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
  BaseBasketDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseBasketDO(
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

class BaseBasketDO extends DataClass implements Insertable<BaseBasketDO> {
  final int id;
  final String name;
  final String? description;
  const BaseBasketDO({required this.id, required this.name, this.description});
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

  factory BaseBasketDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseBasketDO(
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

  BaseBasketDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent()}) =>
      BaseBasketDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('BaseBasketDO(')
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
      (other is BaseBasketDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class BasketTableCompanion extends UpdateCompanion<BaseBasketDO> {
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
  static Insertable<BaseBasketDO> custom({
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
          ..write('riskLevel: $riskLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, basketId, value,
      valueUpdatedOn, irr, maturityDate, riskLevel);
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
          ..write('riskLevel: $riskLevel')
          ..write(')'))
        .toString();
  }
}

class $SipTableTable extends SipTable
    with TableInfo<$SipTableTable, BaseSipDO> {
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
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumnWithTypeConverter<SipFrequency, String> frequency =
      GeneratedColumn<String>('FREQUENCY', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SipFrequency>($SipTableTable.$converterfrequency);
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
  VerificationContext validateIntegrity(Insertable<BaseSipDO> instance,
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
  BaseSipDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseSipDO(
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

  static JsonTypeConverter2<SipFrequency, String, String> $converterfrequency =
      const EnumNameConverter<SipFrequency>(SipFrequency.values);
}

class BaseSipDO extends DataClass implements Insertable<BaseSipDO> {
  final int id;
  final String? description;
  final int investmentId;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final SipFrequency frequency;
  final DateTime? executedTill;
  const BaseSipDO(
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

  factory BaseSipDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseSipDO(
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

  BaseSipDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          int? investmentId,
          double? amount,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          SipFrequency? frequency,
          Value<DateTime?> executedTill = const Value.absent()}) =>
      BaseSipDO(
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
    return (StringBuffer('BaseSipDO(')
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
      (other is BaseSipDO &&
          other.id == this.id &&
          other.description == this.description &&
          other.investmentId == this.investmentId &&
          other.amount == this.amount &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.frequency == this.frequency &&
          other.executedTill == this.executedTill);
}

class SipTableCompanion extends UpdateCompanion<BaseSipDO> {
  final Value<int> id;
  final Value<String?> description;
  final Value<int> investmentId;
  final Value<double> amount;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<SipFrequency> frequency;
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
    required SipFrequency frequency,
    this.executedTill = const Value.absent(),
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        startDate = Value(startDate),
        frequency = Value(frequency);
  static Insertable<BaseSipDO> custom({
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
      Value<SipFrequency>? frequency,
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
    with TableInfo<$TransactionTableTable, BaseTransactionDO> {
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
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'CREATED_ON', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, description, investmentId, sipId, amount, createdOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_table';
  @override
  VerificationContext validateIntegrity(Insertable<BaseTransactionDO> instance,
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
  BaseTransactionDO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaseTransactionDO(
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
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}CREATED_ON'])!,
    );
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class BaseTransactionDO extends DataClass
    implements Insertable<BaseTransactionDO> {
  final int id;
  final String? description;
  final int investmentId;
  final int? sipId;
  final double amount;
  final DateTime createdOn;
  const BaseTransactionDO(
      {required this.id,
      this.description,
      required this.investmentId,
      this.sipId,
      required this.amount,
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
      createdOn: Value(createdOn),
    );
  }

  factory BaseTransactionDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaseTransactionDO(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      sipId: serializer.fromJson<int?>(json['sipId']),
      amount: serializer.fromJson<double>(json['amount']),
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
      'createdOn': serializer.toJson<DateTime>(createdOn),
    };
  }

  BaseTransactionDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          int? investmentId,
          Value<int?> sipId = const Value.absent(),
          double? amount,
          DateTime? createdOn}) =>
      BaseTransactionDO(
        id: id ?? this.id,
        description: description.present ? description.value : this.description,
        investmentId: investmentId ?? this.investmentId,
        sipId: sipId.present ? sipId.value : this.sipId,
        amount: amount ?? this.amount,
        createdOn: createdOn ?? this.createdOn,
      );
  @override
  String toString() {
    return (StringBuffer('BaseTransactionDO(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('investmentId: $investmentId, ')
          ..write('sipId: $sipId, ')
          ..write('amount: $amount, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, description, investmentId, sipId, amount, createdOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseTransactionDO &&
          other.id == this.id &&
          other.description == this.description &&
          other.investmentId == this.investmentId &&
          other.sipId == this.sipId &&
          other.amount == this.amount &&
          other.createdOn == this.createdOn);
}

class TransactionTableCompanion extends UpdateCompanion<BaseTransactionDO> {
  final Value<int> id;
  final Value<String?> description;
  final Value<int> investmentId;
  final Value<int?> sipId;
  final Value<double> amount;
  final Value<DateTime> createdOn;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.sipId = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdOn = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required int investmentId,
    this.sipId = const Value.absent(),
    required double amount,
    required DateTime createdOn,
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        createdOn = Value(createdOn);
  static Insertable<BaseTransactionDO> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? investmentId,
    Expression<int>? sipId,
    Expression<double>? amount,
    Expression<DateTime>? createdOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (description != null) 'DESCRIPTION': description,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (sipId != null) 'SIP_ID': sipId,
      if (amount != null) 'AMOUNT': amount,
      if (createdOn != null) 'CREATED_ON': createdOn,
    });
  }

  TransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? description,
      Value<int>? investmentId,
      Value<int?>? sipId,
      Value<double>? amount,
      Value<DateTime>? createdOn}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      investmentId: investmentId ?? this.investmentId,
      sipId: sipId ?? this.sipId,
      amount: amount ?? this.amount,
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _maturityDateMeta =
      const VerificationMeta('maturityDate');
  @override
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
      'MATURITY_DATE', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES goal_table (ID)'));
  static const VerificationMeta _splitPercentageMeta =
      const VerificationMeta('splitPercentage');
  @override
  late final GeneratedColumn<double> splitPercentage = GeneratedColumn<double>(
      'SPLIT_PERCENTAGE', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
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

class BasketDO extends DataClass {
  final int id;
  final String name;
  final String? description;
  final int? totalInvestmentCount;
  const BasketDO(
      {required this.id,
      required this.name,
      this.description,
      this.totalInvestmentCount});
  factory BasketDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BasketDO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      totalInvestmentCount:
          serializer.fromJson<int?>(json['totalInvestmentCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'totalInvestmentCount': serializer.toJson<int?>(totalInvestmentCount),
    };
  }

  BasketDO copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<int?> totalInvestmentCount = const Value.absent()}) =>
      BasketDO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        totalInvestmentCount: totalInvestmentCount.present
            ? totalInvestmentCount.value
            : this.totalInvestmentCount,
      );
  @override
  String toString() {
    return (StringBuffer('BasketDO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalInvestmentCount: $totalInvestmentCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, totalInvestmentCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BasketDO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.totalInvestmentCount == this.totalInvestmentCount);
}

class $BasketEnrichedViewView
    extends ViewInfo<$BasketEnrichedViewView, BasketDO>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $BasketEnrichedViewView(this.attachedDatabase, [this._alias]);
  $BasketTableTable get basket =>
      attachedDatabase.basketTable.createAlias('t0');
  $InvestmentTableTable get investment =>
      attachedDatabase.investmentTable.createAlias('t1');
  $TransactionTableTable get transaction =>
      attachedDatabase.transactionTable.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, totalInvestmentCount];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'basket_enriched_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $BasketEnrichedViewView get asDslTable => this;
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
      totalInvestmentCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_investment_count']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      generatedAs: GeneratedAs(basket.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'NAME', aliasedName, false,
      generatedAs: GeneratedAs(basket.name, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      generatedAs: GeneratedAs(basket.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> totalInvestmentCount = GeneratedColumn<int>(
      'total_investment_count', aliasedName, true,
      generatedAs: GeneratedAs(investment.id.count(), false),
      type: DriftSqlType.int);
  @override
  $BasketEnrichedViewView createAlias(String alias) {
    return $BasketEnrichedViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(basket)..addColumns($columns)).join([
        leftOuterJoin(investment, investment.basketId.equalsExp(basket.id))
      ]);
  @override
  Set<String> get readTables =>
      const {'basket_table', 'investment_table', 'transaction_table'};
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
  final double? totalInvestedAmount;
  final int? totalTransactions;
  final int? totalSips;
  final int? taggedGoals;
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
      this.totalInvestedAmount,
      this.totalTransactions,
      this.totalSips,
      this.taggedGoals});
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
      totalInvestedAmount:
          serializer.fromJson<double?>(json['totalInvestedAmount']),
      totalTransactions: serializer.fromJson<int?>(json['totalTransactions']),
      totalSips: serializer.fromJson<int?>(json['totalSips']),
      taggedGoals: serializer.fromJson<int?>(json['taggedGoals']),
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
      'totalInvestedAmount': serializer.toJson<double?>(totalInvestedAmount),
      'totalTransactions': serializer.toJson<int?>(totalTransactions),
      'totalSips': serializer.toJson<int?>(totalSips),
      'taggedGoals': serializer.toJson<int?>(taggedGoals),
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
          Value<double?> totalInvestedAmount = const Value.absent(),
          Value<int?> totalTransactions = const Value.absent(),
          Value<int?> totalSips = const Value.absent(),
          Value<int?> taggedGoals = const Value.absent()}) =>
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
        totalInvestedAmount: totalInvestedAmount.present
            ? totalInvestedAmount.value
            : this.totalInvestedAmount,
        totalTransactions: totalTransactions.present
            ? totalTransactions.value
            : this.totalTransactions,
        totalSips: totalSips.present ? totalSips.value : this.totalSips,
        taggedGoals: taggedGoals.present ? taggedGoals.value : this.taggedGoals,
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
          ..write('totalInvestedAmount: $totalInvestedAmount, ')
          ..write('totalTransactions: $totalTransactions, ')
          ..write('totalSips: $totalSips, ')
          ..write('taggedGoals: $taggedGoals')
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
      totalInvestedAmount,
      totalTransactions,
      totalSips,
      taggedGoals);
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
          other.totalInvestedAmount == this.totalInvestedAmount &&
          other.totalTransactions == this.totalTransactions &&
          other.totalSips == this.totalSips &&
          other.taggedGoals == this.taggedGoals);
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
  $GoalInvestmentTableTable get goalInvestment =>
      attachedDatabase.goalInvestmentTable.createAlias('t3');
  $SipTableTable get sip => attachedDatabase.sipTable.createAlias('t4');
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
        totalInvestedAmount,
        totalTransactions,
        totalSips,
        taggedGoals
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
      totalInvestedAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_invested_amount']),
      totalTransactions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_transactions']),
      totalSips: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_sips']),
      taggedGoals: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tagged_goals']),
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
  late final GeneratedColumn<double> totalInvestedAmount =
      GeneratedColumn<double>('total_invested_amount', aliasedName, true,
          generatedAs: GeneratedAs(transaction.amount.sum(), false),
          type: DriftSqlType.double);
  late final GeneratedColumn<int> totalTransactions = GeneratedColumn<int>(
      'total_transactions', aliasedName, true,
      generatedAs: GeneratedAs(transaction.id.count(), false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> totalSips = GeneratedColumn<int>(
      'total_sips', aliasedName, true,
      generatedAs: GeneratedAs(sip.id.count(), false), type: DriftSqlType.int);
  late final GeneratedColumn<int> taggedGoals = GeneratedColumn<int>(
      'tagged_goals', aliasedName, true,
      generatedAs: GeneratedAs(goalInvestment.id.count(), false),
      type: DriftSqlType.int);
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
        leftOuterJoin(goalInvestment,
            goalInvestment.investmentId.equalsExp(investment.id))
      ])
        ..groupBy([investment.id]);
  @override
  Set<String> get readTables => const {
        'investment_table',
        'basket_table',
        'transaction_table',
        'goal_investment_table',
        'sip_table'
      };
}

class GoalInvestmentDO extends DataClass {
  final int id;
  final int investmentId;
  final int goalId;
  final double splitPercentage;
  final String? investmentName;
  final String? goalName;
  const GoalInvestmentDO(
      {required this.id,
      required this.investmentId,
      required this.goalId,
      required this.splitPercentage,
      this.investmentName,
      this.goalName});
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
    };
  }

  GoalInvestmentDO copyWith(
          {int? id,
          int? investmentId,
          int? goalId,
          double? splitPercentage,
          Value<String?> investmentName = const Value.absent(),
          Value<String?> goalName = const Value.absent()}) =>
      GoalInvestmentDO(
        id: id ?? this.id,
        investmentId: investmentId ?? this.investmentId,
        goalId: goalId ?? this.goalId,
        splitPercentage: splitPercentage ?? this.splitPercentage,
        investmentName:
            investmentName.present ? investmentName.value : this.investmentName,
        goalName: goalName.present ? goalName.value : this.goalName,
      );
  @override
  String toString() {
    return (StringBuffer('GoalInvestmentDO(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('goalId: $goalId, ')
          ..write('splitPercentage: $splitPercentage, ')
          ..write('investmentName: $investmentName, ')
          ..write('goalName: $goalName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, investmentId, goalId, splitPercentage, investmentName, goalName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalInvestmentDO &&
          other.id == this.id &&
          other.investmentId == this.investmentId &&
          other.goalId == this.goalId &&
          other.splitPercentage == this.splitPercentage &&
          other.investmentName == this.investmentName &&
          other.goalName == this.goalName);
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
  List<GeneratedColumn> get $columns =>
      [id, investmentId, goalId, splitPercentage, investmentName, goalName];
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
      ]);
  @override
  Set<String> get readTables =>
      const {'goal_investment_table', 'investment_table', 'goal_table'};
}

class TransactionDO extends DataClass {
  final int id;
  final String? description;
  final int investmentId;
  final int? sipId;
  final double amount;
  final DateTime createdOn;
  final String? investmentName;
  final String? sipDescription;
  const TransactionDO(
      {required this.id,
      this.description,
      required this.investmentId,
      this.sipId,
      required this.amount,
      required this.createdOn,
      this.investmentName,
      this.sipDescription});
  factory TransactionDO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDO(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      sipId: serializer.fromJson<int?>(json['sipId']),
      amount: serializer.fromJson<double>(json['amount']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      investmentName: serializer.fromJson<String?>(json['investmentName']),
      sipDescription: serializer.fromJson<String?>(json['sipDescription']),
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
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'investmentName': serializer.toJson<String?>(investmentName),
      'sipDescription': serializer.toJson<String?>(sipDescription),
    };
  }

  TransactionDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          int? investmentId,
          Value<int?> sipId = const Value.absent(),
          double? amount,
          DateTime? createdOn,
          Value<String?> investmentName = const Value.absent(),
          Value<String?> sipDescription = const Value.absent()}) =>
      TransactionDO(
        id: id ?? this.id,
        description: description.present ? description.value : this.description,
        investmentId: investmentId ?? this.investmentId,
        sipId: sipId.present ? sipId.value : this.sipId,
        amount: amount ?? this.amount,
        createdOn: createdOn ?? this.createdOn,
        investmentName:
            investmentName.present ? investmentName.value : this.investmentName,
        sipDescription:
            sipDescription.present ? sipDescription.value : this.sipDescription,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDO(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('investmentId: $investmentId, ')
          ..write('sipId: $sipId, ')
          ..write('amount: $amount, ')
          ..write('createdOn: $createdOn, ')
          ..write('investmentName: $investmentName, ')
          ..write('sipDescription: $sipDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, investmentId, sipId, amount,
      createdOn, investmentName, sipDescription);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDO &&
          other.id == this.id &&
          other.description == this.description &&
          other.investmentId == this.investmentId &&
          other.sipId == this.sipId &&
          other.amount == this.amount &&
          other.createdOn == this.createdOn &&
          other.investmentName == this.investmentName &&
          other.sipDescription == this.sipDescription);
}

class $TransactionEnrichedViewView
    extends ViewInfo<$TransactionEnrichedViewView, TransactionDO>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $TransactionEnrichedViewView(this.attachedDatabase, [this._alias]);
  $TransactionTableTable get transaction =>
      attachedDatabase.transactionTable.createAlias('t0');
  $InvestmentTableTable get investment =>
      attachedDatabase.investmentTable.createAlias('t1');
  $SipTableTable get sip => attachedDatabase.sipTable.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        description,
        investmentId,
        sipId,
        amount,
        createdOn,
        investmentName,
        sipDescription
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'transaction_enriched_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $TransactionEnrichedViewView get asDslTable => this;
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
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}CREATED_ON'])!,
      investmentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}investment_name']),
      sipDescription: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sip_description']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      generatedAs: GeneratedAs(transaction.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      generatedAs: GeneratedAs(transaction.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      generatedAs: GeneratedAs(transaction.investmentId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> sipId = GeneratedColumn<int>(
      'SIP_ID', aliasedName, true,
      generatedAs: GeneratedAs(transaction.sipId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      generatedAs: GeneratedAs(transaction.amount, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'CREATED_ON', aliasedName, false,
      generatedAs: GeneratedAs(transaction.createdOn, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<String> investmentName = GeneratedColumn<String>(
      'investment_name', aliasedName, true,
      generatedAs: GeneratedAs(investment.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> sipDescription = GeneratedColumn<String>(
      'sip_description', aliasedName, true,
      generatedAs: GeneratedAs(sip.description, false),
      type: DriftSqlType.string);
  @override
  $TransactionEnrichedViewView createAlias(String alias) {
    return $TransactionEnrichedViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(transaction)..addColumns($columns)).join([
        innerJoin(
            investment, investment.id.equalsExp(transaction.investmentId)),
        leftOuterJoin(sip, sip.id.equalsExp(transaction.sipId))
      ]);
  @override
  Set<String> get readTables =>
      const {'transaction_table', 'investment_table', 'sip_table'};
}

class SipDO extends DataClass {
  final int id;
  final String? description;
  final int investmentId;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final SipFrequency frequency;
  final DateTime? executedTill;
  final String? investmentName;
  final int? transactionCount;
  const SipDO(
      {required this.id,
      this.description,
      required this.investmentId,
      required this.amount,
      required this.startDate,
      this.endDate,
      required this.frequency,
      this.executedTill,
      this.investmentName,
      this.transactionCount});
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
      investmentName: serializer.fromJson<String?>(json['investmentName']),
      transactionCount: serializer.fromJson<int?>(json['transactionCount']),
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
      'investmentName': serializer.toJson<String?>(investmentName),
      'transactionCount': serializer.toJson<int?>(transactionCount),
    };
  }

  SipDO copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          int? investmentId,
          double? amount,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          SipFrequency? frequency,
          Value<DateTime?> executedTill = const Value.absent(),
          Value<String?> investmentName = const Value.absent(),
          Value<int?> transactionCount = const Value.absent()}) =>
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
        investmentName:
            investmentName.present ? investmentName.value : this.investmentName,
        transactionCount: transactionCount.present
            ? transactionCount.value
            : this.transactionCount,
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
          ..write('executedTill: $executedTill, ')
          ..write('investmentName: $investmentName, ')
          ..write('transactionCount: $transactionCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      description,
      investmentId,
      amount,
      startDate,
      endDate,
      frequency,
      executedTill,
      investmentName,
      transactionCount);
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
          other.executedTill == this.executedTill &&
          other.investmentName == this.investmentName &&
          other.transactionCount == this.transactionCount);
}

class $SipEnrichedViewView extends ViewInfo<$SipEnrichedViewView, SipDO>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $SipEnrichedViewView(this.attachedDatabase, [this._alias]);
  $SipTableTable get sip => attachedDatabase.sipTable.createAlias('t0');
  $InvestmentTableTable get investment =>
      attachedDatabase.investmentTable.createAlias('t1');
  $TransactionTableTable get transaction =>
      attachedDatabase.transactionTable.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        description,
        investmentId,
        amount,
        startDate,
        endDate,
        frequency,
        executedTill,
        investmentName,
        transactionCount
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'sip_enriched_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $SipEnrichedViewView get asDslTable => this;
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
      investmentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}investment_name']),
      transactionCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction_count']),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      generatedAs: GeneratedAs(sip.id, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, true,
      generatedAs: GeneratedAs(sip.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      generatedAs: GeneratedAs(sip.investmentId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      generatedAs: GeneratedAs(sip.amount, false), type: DriftSqlType.double);
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'START_DATE', aliasedName, false,
      generatedAs: GeneratedAs(sip.startDate, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'END_DATE', aliasedName, true,
      generatedAs: GeneratedAs(sip.endDate, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumnWithTypeConverter<SipFrequency, String> frequency =
      GeneratedColumn<String>('FREQUENCY', aliasedName, false,
              generatedAs: GeneratedAs(sip.frequency, false),
              type: DriftSqlType.string)
          .withConverter<SipFrequency>($SipTableTable.$converterfrequency);
  late final GeneratedColumn<DateTime> executedTill = GeneratedColumn<DateTime>(
      'EXECUTED_TILL', aliasedName, true,
      generatedAs: GeneratedAs(sip.executedTill, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<String> investmentName = GeneratedColumn<String>(
      'investment_name', aliasedName, true,
      generatedAs: GeneratedAs(investment.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> transactionCount = GeneratedColumn<int>(
      'transaction_count', aliasedName, true,
      generatedAs: GeneratedAs(transaction.id.count(), false),
      type: DriftSqlType.int);
  @override
  $SipEnrichedViewView createAlias(String alias) {
    return $SipEnrichedViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(sip)..addColumns($columns)).join([
        leftOuterJoin(investment, investment.id.equalsExp(sip.investmentId)),
        leftOuterJoin(transaction, transaction.sipId.equalsExp(sip.id))
      ]);
  @override
  Set<String> get readTables =>
      const {'sip_table', 'investment_table', 'transaction_table'};
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
      generatedAs: GeneratedAs(goalInvestment.id.count(), false),
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
  late final $BasketEnrichedViewView basketEnrichedView =
      $BasketEnrichedViewView(this);
  late final $InvestmentEnrichedViewView investmentEnrichedView =
      $InvestmentEnrichedViewView(this);
  late final $GoalInvestmentEnrichedViewView goalInvestmentEnrichedView =
      $GoalInvestmentEnrichedViewView(this);
  late final $TransactionEnrichedViewView transactionEnrichedView =
      $TransactionEnrichedViewView(this);
  late final $SipEnrichedViewView sipEnrichedView = $SipEnrichedViewView(this);
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
        basketEnrichedView,
        investmentEnrichedView,
        goalInvestmentEnrichedView,
        transactionEnrichedView,
        sipEnrichedView,
        goalEnrichedView
      ];
}
