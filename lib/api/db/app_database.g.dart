// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTableTable extends BasketTable
    with TableInfo<$BasketTableTable, Basket> {
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'basket_table';
  @override
  VerificationContext validateIntegrity(Insertable<Basket> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Basket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Basket(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
    );
  }

  @override
  $BasketTableTable createAlias(String alias) {
    return $BasketTableTable(attachedDatabase, alias);
  }
}

class Basket extends DataClass implements Insertable<Basket> {
  final int id;
  final String name;
  const Basket({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    return map;
  }

  BasketTableCompanion toCompanion(bool nullToAbsent) {
    return BasketTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Basket.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Basket(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Basket copyWith({int? id, String? name}) => Basket(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Basket(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Basket && other.id == this.id && other.name == this.name);
}

class BasketTableCompanion extends UpdateCompanion<Basket> {
  final Value<int> id;
  final Value<String> name;
  const BasketTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  BasketTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Basket> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
    });
  }

  BasketTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return BasketTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BasketTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $InvestmentTableTable extends InvestmentTable
    with TableInfo<$InvestmentTableTable, Investment> {
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
      'VALUE', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _riskLevelMeta =
      const VerificationMeta('riskLevel');
  @override
  late final GeneratedColumnWithTypeConverter<RiskLevel, String> riskLevel =
      GeneratedColumn<String>('RISK_LEVEL', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RiskLevel>($InvestmentTableTable.$converterriskLevel);
  static const VerificationMeta _valueUpdatedOnMeta =
      const VerificationMeta('valueUpdatedOn');
  @override
  late final GeneratedColumn<DateTime> valueUpdatedOn =
      GeneratedColumn<DateTime>('VALUE_UPDATED_ON', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, basketId, value, riskLevel, valueUpdatedOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_table';
  @override
  VerificationContext validateIntegrity(Insertable<Investment> instance,
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
    if (data.containsKey('BASKET_ID')) {
      context.handle(_basketIdMeta,
          basketId.isAcceptableOrUnknown(data['BASKET_ID']!, _basketIdMeta));
    }
    if (data.containsKey('VALUE')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['VALUE']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    context.handle(_riskLevelMeta, const VerificationResult.success());
    if (data.containsKey('VALUE_UPDATED_ON')) {
      context.handle(
          _valueUpdatedOnMeta,
          valueUpdatedOn.isAcceptableOrUnknown(
              data['VALUE_UPDATED_ON']!, _valueUpdatedOnMeta));
    } else if (isInserting) {
      context.missing(_valueUpdatedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Investment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Investment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      basketId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}BASKET_ID']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}VALUE'])!,
      riskLevel: $InvestmentTableTable.$converterriskLevel.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}RISK_LEVEL'])!),
      valueUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON'])!,
    );
  }

  @override
  $InvestmentTableTable createAlias(String alias) {
    return $InvestmentTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RiskLevel, String, String> $converterriskLevel =
      const EnumNameConverter<RiskLevel>(RiskLevel.values);
}

class Investment extends DataClass implements Insertable<Investment> {
  final int id;
  final String name;
  final int? basketId;
  final double value;
  final RiskLevel riskLevel;
  final DateTime valueUpdatedOn;
  const Investment(
      {required this.id,
      required this.name,
      this.basketId,
      required this.value,
      required this.riskLevel,
      required this.valueUpdatedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    if (!nullToAbsent || basketId != null) {
      map['BASKET_ID'] = Variable<int>(basketId);
    }
    map['VALUE'] = Variable<double>(value);
    {
      map['RISK_LEVEL'] = Variable<String>(
          $InvestmentTableTable.$converterriskLevel.toSql(riskLevel));
    }
    map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn);
    return map;
  }

  InvestmentTableCompanion toCompanion(bool nullToAbsent) {
    return InvestmentTableCompanion(
      id: Value(id),
      name: Value(name),
      basketId: basketId == null && nullToAbsent
          ? const Value.absent()
          : Value(basketId),
      value: Value(value),
      riskLevel: Value(riskLevel),
      valueUpdatedOn: Value(valueUpdatedOn),
    );
  }

  factory Investment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Investment(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      basketId: serializer.fromJson<int?>(json['basketId']),
      value: serializer.fromJson<double>(json['value']),
      riskLevel: $InvestmentTableTable.$converterriskLevel
          .fromJson(serializer.fromJson<String>(json['riskLevel'])),
      valueUpdatedOn: serializer.fromJson<DateTime>(json['valueUpdatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'basketId': serializer.toJson<int?>(basketId),
      'value': serializer.toJson<double>(value),
      'riskLevel': serializer.toJson<String>(
          $InvestmentTableTable.$converterriskLevel.toJson(riskLevel)),
      'valueUpdatedOn': serializer.toJson<DateTime>(valueUpdatedOn),
    };
  }

  Investment copyWith(
          {int? id,
          String? name,
          Value<int?> basketId = const Value.absent(),
          double? value,
          RiskLevel? riskLevel,
          DateTime? valueUpdatedOn}) =>
      Investment(
        id: id ?? this.id,
        name: name ?? this.name,
        basketId: basketId.present ? basketId.value : this.basketId,
        value: value ?? this.value,
        riskLevel: riskLevel ?? this.riskLevel,
        valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('Investment(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('basketId: $basketId, ')
          ..write('value: $value, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('valueUpdatedOn: $valueUpdatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, basketId, value, riskLevel, valueUpdatedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Investment &&
          other.id == this.id &&
          other.name == this.name &&
          other.basketId == this.basketId &&
          other.value == this.value &&
          other.riskLevel == this.riskLevel &&
          other.valueUpdatedOn == this.valueUpdatedOn);
}

class InvestmentTableCompanion extends UpdateCompanion<Investment> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> basketId;
  final Value<double> value;
  final Value<RiskLevel> riskLevel;
  final Value<DateTime> valueUpdatedOn;
  const InvestmentTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.basketId = const Value.absent(),
    this.value = const Value.absent(),
    this.riskLevel = const Value.absent(),
    this.valueUpdatedOn = const Value.absent(),
  });
  InvestmentTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.basketId = const Value.absent(),
    required double value,
    required RiskLevel riskLevel,
    required DateTime valueUpdatedOn,
  })  : name = Value(name),
        value = Value(value),
        riskLevel = Value(riskLevel),
        valueUpdatedOn = Value(valueUpdatedOn);
  static Insertable<Investment> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? basketId,
    Expression<double>? value,
    Expression<String>? riskLevel,
    Expression<DateTime>? valueUpdatedOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (basketId != null) 'BASKET_ID': basketId,
      if (value != null) 'VALUE': value,
      if (riskLevel != null) 'RISK_LEVEL': riskLevel,
      if (valueUpdatedOn != null) 'VALUE_UPDATED_ON': valueUpdatedOn,
    });
  }

  InvestmentTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int?>? basketId,
      Value<double>? value,
      Value<RiskLevel>? riskLevel,
      Value<DateTime>? valueUpdatedOn}) {
    return InvestmentTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      basketId: basketId ?? this.basketId,
      value: value ?? this.value,
      riskLevel: riskLevel ?? this.riskLevel,
      valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,
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
    if (basketId.present) {
      map['BASKET_ID'] = Variable<int>(basketId.value);
    }
    if (value.present) {
      map['VALUE'] = Variable<double>(value.value);
    }
    if (riskLevel.present) {
      map['RISK_LEVEL'] = Variable<String>(
          $InvestmentTableTable.$converterriskLevel.toSql(riskLevel.value));
    }
    if (valueUpdatedOn.present) {
      map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('basketId: $basketId, ')
          ..write('value: $value, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('valueUpdatedOn: $valueUpdatedOn')
          ..write(')'))
        .toString();
  }
}

class $InvestmentTransactionTableTable extends InvestmentTransactionTable
    with TableInfo<$InvestmentTransactionTableTable, InvestmentTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentTransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
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
  static const VerificationMeta _amountInvestedOnMeta =
      const VerificationMeta('amountInvestedOn');
  @override
  late final GeneratedColumn<DateTime> amountInvestedOn =
      GeneratedColumn<DateTime>('AMOUNT_INVESTED_ON', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, investmentId, amount, amountInvestedOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_transaction_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<InvestmentTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
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
    if (data.containsKey('AMOUNT_INVESTED_ON')) {
      context.handle(
          _amountInvestedOnMeta,
          amountInvestedOn.isAcceptableOrUnknown(
              data['AMOUNT_INVESTED_ON']!, _amountInvestedOnMeta));
    } else if (isInserting) {
      context.missing(_amountInvestedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvestmentTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      amountInvestedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}AMOUNT_INVESTED_ON'])!,
    );
  }

  @override
  $InvestmentTransactionTableTable createAlias(String alias) {
    return $InvestmentTransactionTableTable(attachedDatabase, alias);
  }
}

class InvestmentTransaction extends DataClass
    implements Insertable<InvestmentTransaction> {
  final int id;
  final int investmentId;
  final double amount;
  final DateTime amountInvestedOn;
  const InvestmentTransaction(
      {required this.id,
      required this.investmentId,
      required this.amount,
      required this.amountInvestedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    map['AMOUNT'] = Variable<double>(amount);
    map['AMOUNT_INVESTED_ON'] = Variable<DateTime>(amountInvestedOn);
    return map;
  }

  InvestmentTransactionTableCompanion toCompanion(bool nullToAbsent) {
    return InvestmentTransactionTableCompanion(
      id: Value(id),
      investmentId: Value(investmentId),
      amount: Value(amount),
      amountInvestedOn: Value(amountInvestedOn),
    );
  }

  factory InvestmentTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentTransaction(
      id: serializer.fromJson<int>(json['id']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      amount: serializer.fromJson<double>(json['amount']),
      amountInvestedOn: serializer.fromJson<DateTime>(json['amountInvestedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'investmentId': serializer.toJson<int>(investmentId),
      'amount': serializer.toJson<double>(amount),
      'amountInvestedOn': serializer.toJson<DateTime>(amountInvestedOn),
    };
  }

  InvestmentTransaction copyWith(
          {int? id,
          int? investmentId,
          double? amount,
          DateTime? amountInvestedOn}) =>
      InvestmentTransaction(
        id: id ?? this.id,
        investmentId: investmentId ?? this.investmentId,
        amount: amount ?? this.amount,
        amountInvestedOn: amountInvestedOn ?? this.amountInvestedOn,
      );
  @override
  String toString() {
    return (StringBuffer('InvestmentTransaction(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('amount: $amount, ')
          ..write('amountInvestedOn: $amountInvestedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, investmentId, amount, amountInvestedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentTransaction &&
          other.id == this.id &&
          other.investmentId == this.investmentId &&
          other.amount == this.amount &&
          other.amountInvestedOn == this.amountInvestedOn);
}

class InvestmentTransactionTableCompanion
    extends UpdateCompanion<InvestmentTransaction> {
  final Value<int> id;
  final Value<int> investmentId;
  final Value<double> amount;
  final Value<DateTime> amountInvestedOn;
  const InvestmentTransactionTableCompanion({
    this.id = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountInvestedOn = const Value.absent(),
  });
  InvestmentTransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required int investmentId,
    required double amount,
    required DateTime amountInvestedOn,
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        amountInvestedOn = Value(amountInvestedOn);
  static Insertable<InvestmentTransaction> custom({
    Expression<int>? id,
    Expression<int>? investmentId,
    Expression<double>? amount,
    Expression<DateTime>? amountInvestedOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (amount != null) 'AMOUNT': amount,
      if (amountInvestedOn != null) 'AMOUNT_INVESTED_ON': amountInvestedOn,
    });
  }

  InvestmentTransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? investmentId,
      Value<double>? amount,
      Value<DateTime>? amountInvestedOn}) {
    return InvestmentTransactionTableCompanion(
      id: id ?? this.id,
      investmentId: investmentId ?? this.investmentId,
      amount: amount ?? this.amount,
      amountInvestedOn: amountInvestedOn ?? this.amountInvestedOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (investmentId.present) {
      map['INVESTMENT_ID'] = Variable<int>(investmentId.value);
    }
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (amountInvestedOn.present) {
      map['AMOUNT_INVESTED_ON'] = Variable<DateTime>(amountInvestedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentTransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('amount: $amount, ')
          ..write('amountInvestedOn: $amountInvestedOn')
          ..write(')'))
        .toString();
  }
}

class $GoalTableTable extends GoalTable with TableInfo<$GoalTableTable, Goal> {
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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'AMOUNT', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'DATE', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _inflationMeta =
      const VerificationMeta('inflation');
  @override
  late final GeneratedColumn<double> inflation = GeneratedColumn<double>(
      'INFLATION', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _targetAmountMeta =
      const VerificationMeta('targetAmount');
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
      'TARGET_AMOUNT', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'TARGET_DATE', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _importanceMeta =
      const VerificationMeta('importance');
  @override
  late final GeneratedColumnWithTypeConverter<GoalImportance, String>
      importance = GeneratedColumn<String>('IMPORTANCE', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<GoalImportance>($GoalTableTable.$converterimportance);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, amount, date, inflation, targetAmount, targetDate, importance];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_table';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
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
    if (data.containsKey('AMOUNT')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('DATE')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['DATE']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('INFLATION')) {
      context.handle(_inflationMeta,
          inflation.isAcceptableOrUnknown(data['INFLATION']!, _inflationMeta));
    } else if (isInserting) {
      context.missing(_inflationMeta);
    }
    if (data.containsKey('TARGET_AMOUNT')) {
      context.handle(
          _targetAmountMeta,
          targetAmount.isAcceptableOrUnknown(
              data['TARGET_AMOUNT']!, _targetAmountMeta));
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('TARGET_DATE')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['TARGET_DATE']!, _targetDateMeta));
    } else if (isInserting) {
      context.missing(_targetDateMeta);
    }
    context.handle(_importanceMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}DATE'])!,
      inflation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}INFLATION'])!,
      targetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}TARGET_AMOUNT'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}TARGET_DATE'])!,
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

class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final String name;
  final double amount;
  final DateTime date;
  final double inflation;
  final double targetAmount;
  final DateTime targetDate;
  final GoalImportance importance;
  const Goal(
      {required this.id,
      required this.name,
      required this.amount,
      required this.date,
      required this.inflation,
      required this.targetAmount,
      required this.targetDate,
      required this.importance});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    map['AMOUNT'] = Variable<double>(amount);
    map['DATE'] = Variable<DateTime>(date);
    map['INFLATION'] = Variable<double>(inflation);
    map['TARGET_AMOUNT'] = Variable<double>(targetAmount);
    map['TARGET_DATE'] = Variable<DateTime>(targetDate);
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
      amount: Value(amount),
      date: Value(date),
      inflation: Value(inflation),
      targetAmount: Value(targetAmount),
      targetDate: Value(targetDate),
      importance: Value(importance),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      inflation: serializer.fromJson<double>(json['inflation']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
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
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'inflation': serializer.toJson<double>(inflation),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'targetDate': serializer.toJson<DateTime>(targetDate),
      'importance': serializer.toJson<String>(
          $GoalTableTable.$converterimportance.toJson(importance)),
    };
  }

  Goal copyWith(
          {int? id,
          String? name,
          double? amount,
          DateTime? date,
          double? inflation,
          double? targetAmount,
          DateTime? targetDate,
          GoalImportance? importance}) =>
      Goal(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        inflation: inflation ?? this.inflation,
        targetAmount: targetAmount ?? this.targetAmount,
        targetDate: targetDate ?? this.targetDate,
        importance: importance ?? this.importance,
      );
  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('inflation: $inflation, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('targetDate: $targetDate, ')
          ..write('importance: $importance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, amount, date, inflation, targetAmount, targetDate, importance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.inflation == this.inflation &&
          other.targetAmount == this.targetAmount &&
          other.targetDate == this.targetDate &&
          other.importance == this.importance);
}

class GoalTableCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<double> inflation;
  final Value<double> targetAmount;
  final Value<DateTime> targetDate;
  final Value<GoalImportance> importance;
  const GoalTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.inflation = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.importance = const Value.absent(),
  });
  GoalTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double amount,
    required DateTime date,
    required double inflation,
    required double targetAmount,
    required DateTime targetDate,
    required GoalImportance importance,
  })  : name = Value(name),
        amount = Value(amount),
        date = Value(date),
        inflation = Value(inflation),
        targetAmount = Value(targetAmount),
        targetDate = Value(targetDate),
        importance = Value(importance);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<double>? inflation,
    Expression<double>? targetAmount,
    Expression<DateTime>? targetDate,
    Expression<String>? importance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (amount != null) 'AMOUNT': amount,
      if (date != null) 'DATE': date,
      if (inflation != null) 'INFLATION': inflation,
      if (targetAmount != null) 'TARGET_AMOUNT': targetAmount,
      if (targetDate != null) 'TARGET_DATE': targetDate,
      if (importance != null) 'IMPORTANCE': importance,
    });
  }

  GoalTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<double>? inflation,
      Value<double>? targetAmount,
      Value<DateTime>? targetDate,
      Value<GoalImportance>? importance}) {
    return GoalTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      inflation: inflation ?? this.inflation,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
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
    if (amount.present) {
      map['AMOUNT'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['DATE'] = Variable<DateTime>(date.value);
    }
    if (inflation.present) {
      map['INFLATION'] = Variable<double>(inflation.value);
    }
    if (targetAmount.present) {
      map['TARGET_AMOUNT'] = Variable<double>(targetAmount.value);
    }
    if (targetDate.present) {
      map['TARGET_DATE'] = Variable<DateTime>(targetDate.value);
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
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('inflation: $inflation, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('targetDate: $targetDate, ')
          ..write('importance: $importance')
          ..write(')'))
        .toString();
  }
}

class $GoalInvestmentTableTable extends GoalInvestmentTable
    with TableInfo<$GoalInvestmentTableTable, GoalInvestment> {
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
  static const VerificationMeta _sharePercentageMeta =
      const VerificationMeta('sharePercentage');
  @override
  late final GeneratedColumn<double> sharePercentage = GeneratedColumn<double>(
      'SHARE_PERCENTAGE', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, goalId, investmentId, sharePercentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_investment_table';
  @override
  VerificationContext validateIntegrity(Insertable<GoalInvestment> instance,
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
    if (data.containsKey('SHARE_PERCENTAGE')) {
      context.handle(
          _sharePercentageMeta,
          sharePercentage.isAcceptableOrUnknown(
              data['SHARE_PERCENTAGE']!, _sharePercentageMeta));
    } else if (isInserting) {
      context.missing(_sharePercentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalInvestment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalInvestment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}GOAL_ID'])!,
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      sharePercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}SHARE_PERCENTAGE'])!,
    );
  }

  @override
  $GoalInvestmentTableTable createAlias(String alias) {
    return $GoalInvestmentTableTable(attachedDatabase, alias);
  }
}

class GoalInvestment extends DataClass implements Insertable<GoalInvestment> {
  final int id;
  final int goalId;
  final int investmentId;
  final double sharePercentage;
  const GoalInvestment(
      {required this.id,
      required this.goalId,
      required this.investmentId,
      required this.sharePercentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['GOAL_ID'] = Variable<int>(goalId);
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    map['SHARE_PERCENTAGE'] = Variable<double>(sharePercentage);
    return map;
  }

  GoalInvestmentTableCompanion toCompanion(bool nullToAbsent) {
    return GoalInvestmentTableCompanion(
      id: Value(id),
      goalId: Value(goalId),
      investmentId: Value(investmentId),
      sharePercentage: Value(sharePercentage),
    );
  }

  factory GoalInvestment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalInvestment(
      id: serializer.fromJson<int>(json['id']),
      goalId: serializer.fromJson<int>(json['goalId']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      sharePercentage: serializer.fromJson<double>(json['sharePercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalId': serializer.toJson<int>(goalId),
      'investmentId': serializer.toJson<int>(investmentId),
      'sharePercentage': serializer.toJson<double>(sharePercentage),
    };
  }

  GoalInvestment copyWith(
          {int? id, int? goalId, int? investmentId, double? sharePercentage}) =>
      GoalInvestment(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        investmentId: investmentId ?? this.investmentId,
        sharePercentage: sharePercentage ?? this.sharePercentage,
      );
  @override
  String toString() {
    return (StringBuffer('GoalInvestment(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('sharePercentage: $sharePercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, goalId, investmentId, sharePercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalInvestment &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.sharePercentage == this.sharePercentage);
}

class GoalInvestmentTableCompanion extends UpdateCompanion<GoalInvestment> {
  final Value<int> id;
  final Value<int> goalId;
  final Value<int> investmentId;
  final Value<double> sharePercentage;
  const GoalInvestmentTableCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.sharePercentage = const Value.absent(),
  });
  GoalInvestmentTableCompanion.insert({
    this.id = const Value.absent(),
    required int goalId,
    required int investmentId,
    required double sharePercentage,
  })  : goalId = Value(goalId),
        investmentId = Value(investmentId),
        sharePercentage = Value(sharePercentage);
  static Insertable<GoalInvestment> custom({
    Expression<int>? id,
    Expression<int>? goalId,
    Expression<int>? investmentId,
    Expression<double>? sharePercentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (goalId != null) 'GOAL_ID': goalId,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (sharePercentage != null) 'SHARE_PERCENTAGE': sharePercentage,
    });
  }

  GoalInvestmentTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? goalId,
      Value<int>? investmentId,
      Value<double>? sharePercentage}) {
    return GoalInvestmentTableCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      investmentId: investmentId ?? this.investmentId,
      sharePercentage: sharePercentage ?? this.sharePercentage,
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
    if (sharePercentage.present) {
      map['SHARE_PERCENTAGE'] = Variable<double>(sharePercentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalInvestmentTableCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('sharePercentage: $sharePercentage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $BasketTableTable basketTable = $BasketTableTable(this);
  late final $InvestmentTableTable investmentTable =
      $InvestmentTableTable(this);
  late final $InvestmentTransactionTableTable investmentTransactionTable =
      $InvestmentTransactionTableTable(this);
  late final $GoalTableTable goalTable = $GoalTableTable(this);
  late final $GoalInvestmentTableTable goalInvestmentTable =
      $GoalInvestmentTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        basketTable,
        investmentTable,
        investmentTransactionTable,
        goalTable,
        goalInvestmentTable
      ];
}
