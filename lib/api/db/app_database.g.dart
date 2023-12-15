// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTableTable extends BasketTable
    with TableInfo<$BasketTableTable, BASKET> {
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
  VerificationContext validateIntegrity(Insertable<BASKET> instance,
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
  BASKET map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BASKET(
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

class BASKET extends DataClass implements Insertable<BASKET> {
  final int id;
  final String name;
  const BASKET({required this.id, required this.name});
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

  factory BASKET.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BASKET(
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

  BASKET copyWith({int? id, String? name}) => BASKET(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('BASKET(')
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
      (other is BASKET && other.id == this.id && other.name == this.name);
}

class BasketTableCompanion extends UpdateCompanion<BASKET> {
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
  static Insertable<BASKET> custom({
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
    with TableInfo<$InvestmentTableTable, INVESTMENT> {
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
      'BASKET_ID', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'VALUE', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _valueUpdatedOnMeta =
      const VerificationMeta('valueUpdatedOn');
  @override
  late final GeneratedColumn<DateTime> valueUpdatedOn =
      GeneratedColumn<DateTime>('VALUE_UPDATED_ON', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, basketId, value, valueUpdatedOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_table';
  @override
  VerificationContext validateIntegrity(Insertable<INVESTMENT> instance,
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
    } else if (isInserting) {
      context.missing(_basketIdMeta);
    }
    if (data.containsKey('VALUE')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['VALUE']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
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
  INVESTMENT map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return INVESTMENT(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      basketId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}BASKET_ID'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}VALUE'])!,
      valueUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON'])!,
    );
  }

  @override
  $InvestmentTableTable createAlias(String alias) {
    return $InvestmentTableTable(attachedDatabase, alias);
  }
}

class INVESTMENT extends DataClass implements Insertable<INVESTMENT> {
  final int id;
  final String name;
  final int basketId;
  final double value;
  final DateTime valueUpdatedOn;
  const INVESTMENT(
      {required this.id,
      required this.name,
      required this.basketId,
      required this.value,
      required this.valueUpdatedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    map['BASKET_ID'] = Variable<int>(basketId);
    map['VALUE'] = Variable<double>(value);
    map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn);
    return map;
  }

  InvestmentTableCompanion toCompanion(bool nullToAbsent) {
    return InvestmentTableCompanion(
      id: Value(id),
      name: Value(name),
      basketId: Value(basketId),
      value: Value(value),
      valueUpdatedOn: Value(valueUpdatedOn),
    );
  }

  factory INVESTMENT.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return INVESTMENT(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      basketId: serializer.fromJson<int>(json['basketId']),
      value: serializer.fromJson<double>(json['value']),
      valueUpdatedOn: serializer.fromJson<DateTime>(json['valueUpdatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'basketId': serializer.toJson<int>(basketId),
      'value': serializer.toJson<double>(value),
      'valueUpdatedOn': serializer.toJson<DateTime>(valueUpdatedOn),
    };
  }

  INVESTMENT copyWith(
          {int? id,
          String? name,
          int? basketId,
          double? value,
          DateTime? valueUpdatedOn}) =>
      INVESTMENT(
        id: id ?? this.id,
        name: name ?? this.name,
        basketId: basketId ?? this.basketId,
        value: value ?? this.value,
        valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('INVESTMENT(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('basketId: $basketId, ')
          ..write('value: $value, ')
          ..write('valueUpdatedOn: $valueUpdatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, basketId, value, valueUpdatedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is INVESTMENT &&
          other.id == this.id &&
          other.name == this.name &&
          other.basketId == this.basketId &&
          other.value == this.value &&
          other.valueUpdatedOn == this.valueUpdatedOn);
}

class InvestmentTableCompanion extends UpdateCompanion<INVESTMENT> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> basketId;
  final Value<double> value;
  final Value<DateTime> valueUpdatedOn;
  const InvestmentTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.basketId = const Value.absent(),
    this.value = const Value.absent(),
    this.valueUpdatedOn = const Value.absent(),
  });
  InvestmentTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int basketId,
    required double value,
    required DateTime valueUpdatedOn,
  })  : name = Value(name),
        basketId = Value(basketId),
        value = Value(value),
        valueUpdatedOn = Value(valueUpdatedOn);
  static Insertable<INVESTMENT> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? basketId,
    Expression<double>? value,
    Expression<DateTime>? valueUpdatedOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (basketId != null) 'BASKET_ID': basketId,
      if (value != null) 'VALUE': value,
      if (valueUpdatedOn != null) 'VALUE_UPDATED_ON': valueUpdatedOn,
    });
  }

  InvestmentTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? basketId,
      Value<double>? value,
      Value<DateTime>? valueUpdatedOn}) {
    return InvestmentTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      basketId: basketId ?? this.basketId,
      value: value ?? this.value,
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
          ..write('valueUpdatedOn: $valueUpdatedOn')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, TRANSACTION> {
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
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  static const String $name = 'transaction_table';
  @override
  VerificationContext validateIntegrity(Insertable<TRANSACTION> instance,
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
  TRANSACTION map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TRANSACTION(
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
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class TRANSACTION extends DataClass implements Insertable<TRANSACTION> {
  final int id;
  final int investmentId;
  final double amount;
  final DateTime amountInvestedOn;
  const TRANSACTION(
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

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      investmentId: Value(investmentId),
      amount: Value(amount),
      amountInvestedOn: Value(amountInvestedOn),
    );
  }

  factory TRANSACTION.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TRANSACTION(
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

  TRANSACTION copyWith(
          {int? id,
          int? investmentId,
          double? amount,
          DateTime? amountInvestedOn}) =>
      TRANSACTION(
        id: id ?? this.id,
        investmentId: investmentId ?? this.investmentId,
        amount: amount ?? this.amount,
        amountInvestedOn: amountInvestedOn ?? this.amountInvestedOn,
      );
  @override
  String toString() {
    return (StringBuffer('TRANSACTION(')
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
      (other is TRANSACTION &&
          other.id == this.id &&
          other.investmentId == this.investmentId &&
          other.amount == this.amount &&
          other.amountInvestedOn == this.amountInvestedOn);
}

class TransactionTableCompanion extends UpdateCompanion<TRANSACTION> {
  final Value<int> id;
  final Value<int> investmentId;
  final Value<double> amount;
  final Value<DateTime> amountInvestedOn;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountInvestedOn = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required int investmentId,
    required double amount,
    required DateTime amountInvestedOn,
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        amountInvestedOn = Value(amountInvestedOn);
  static Insertable<TRANSACTION> custom({
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

  TransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? investmentId,
      Value<double>? amount,
      Value<DateTime>? amountInvestedOn}) {
    return TransactionTableCompanion(
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
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('amount: $amount, ')
          ..write('amountInvestedOn: $amountInvestedOn')
          ..write(')'))
        .toString();
  }
}

class $GoalTableTable extends GoalTable with TableInfo<$GoalTableTable, GOAL> {
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
  static const VerificationMeta _inflationMeta =
      const VerificationMeta('inflation');
  @override
  late final GeneratedColumn<double> inflation = GeneratedColumn<double>(
      'INFLATION', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _riskProfileTypeMeta =
      const VerificationMeta('riskProfileType');
  @override
  late final GeneratedColumnWithTypeConverter<RiskProfileType?, String>
      riskProfileType = GeneratedColumn<String>(
              'RISK_PROFILE_TYPE', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<RiskProfileType?>(
              $GoalTableTable.$converterriskProfileTypen);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, targetAmount, targetDate, inflation, riskProfileType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_table';
  @override
  VerificationContext validateIntegrity(Insertable<GOAL> instance,
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
    if (data.containsKey('INFLATION')) {
      context.handle(_inflationMeta,
          inflation.isAcceptableOrUnknown(data['INFLATION']!, _inflationMeta));
    } else if (isInserting) {
      context.missing(_inflationMeta);
    }
    context.handle(_riskProfileTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GOAL map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GOAL(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      targetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}TARGET_AMOUNT'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}TARGET_DATE'])!,
      inflation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}INFLATION'])!,
      riskProfileType: $GoalTableTable.$converterriskProfileTypen.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}RISK_PROFILE_TYPE'])),
    );
  }

  @override
  $GoalTableTable createAlias(String alias) {
    return $GoalTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RiskProfileType, String, String>
      $converterriskProfileType =
      const EnumNameConverter<RiskProfileType>(RiskProfileType.values);
  static JsonTypeConverter2<RiskProfileType?, String?, String?>
      $converterriskProfileTypen =
      JsonTypeConverter2.asNullable($converterriskProfileType);
}

class GOAL extends DataClass implements Insertable<GOAL> {
  final int id;
  final String name;
  final double targetAmount;
  final DateTime targetDate;
  final double inflation;
  final RiskProfileType? riskProfileType;
  const GOAL(
      {required this.id,
      required this.name,
      required this.targetAmount,
      required this.targetDate,
      required this.inflation,
      this.riskProfileType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    map['TARGET_AMOUNT'] = Variable<double>(targetAmount);
    map['TARGET_DATE'] = Variable<DateTime>(targetDate);
    map['INFLATION'] = Variable<double>(inflation);
    if (!nullToAbsent || riskProfileType != null) {
      map['RISK_PROFILE_TYPE'] = Variable<String>(
          $GoalTableTable.$converterriskProfileTypen.toSql(riskProfileType));
    }
    return map;
  }

  GoalTableCompanion toCompanion(bool nullToAbsent) {
    return GoalTableCompanion(
      id: Value(id),
      name: Value(name),
      targetAmount: Value(targetAmount),
      targetDate: Value(targetDate),
      inflation: Value(inflation),
      riskProfileType: riskProfileType == null && nullToAbsent
          ? const Value.absent()
          : Value(riskProfileType),
    );
  }

  factory GOAL.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GOAL(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
      inflation: serializer.fromJson<double>(json['inflation']),
      riskProfileType: $GoalTableTable.$converterriskProfileTypen
          .fromJson(serializer.fromJson<String?>(json['riskProfileType'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'targetDate': serializer.toJson<DateTime>(targetDate),
      'inflation': serializer.toJson<double>(inflation),
      'riskProfileType': serializer.toJson<String?>(
          $GoalTableTable.$converterriskProfileTypen.toJson(riskProfileType)),
    };
  }

  GOAL copyWith(
          {int? id,
          String? name,
          double? targetAmount,
          DateTime? targetDate,
          double? inflation,
          Value<RiskProfileType?> riskProfileType = const Value.absent()}) =>
      GOAL(
        id: id ?? this.id,
        name: name ?? this.name,
        targetAmount: targetAmount ?? this.targetAmount,
        targetDate: targetDate ?? this.targetDate,
        inflation: inflation ?? this.inflation,
        riskProfileType: riskProfileType.present
            ? riskProfileType.value
            : this.riskProfileType,
      );
  @override
  String toString() {
    return (StringBuffer('GOAL(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('targetDate: $targetDate, ')
          ..write('inflation: $inflation, ')
          ..write('riskProfileType: $riskProfileType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, targetAmount, targetDate, inflation, riskProfileType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GOAL &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetAmount == this.targetAmount &&
          other.targetDate == this.targetDate &&
          other.inflation == this.inflation &&
          other.riskProfileType == this.riskProfileType);
}

class GoalTableCompanion extends UpdateCompanion<GOAL> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> targetAmount;
  final Value<DateTime> targetDate;
  final Value<double> inflation;
  final Value<RiskProfileType?> riskProfileType;
  const GoalTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.inflation = const Value.absent(),
    this.riskProfileType = const Value.absent(),
  });
  GoalTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double targetAmount,
    required DateTime targetDate,
    required double inflation,
    this.riskProfileType = const Value.absent(),
  })  : name = Value(name),
        targetAmount = Value(targetAmount),
        targetDate = Value(targetDate),
        inflation = Value(inflation);
  static Insertable<GOAL> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? targetAmount,
    Expression<DateTime>? targetDate,
    Expression<double>? inflation,
    Expression<String>? riskProfileType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
      if (targetAmount != null) 'TARGET_AMOUNT': targetAmount,
      if (targetDate != null) 'TARGET_DATE': targetDate,
      if (inflation != null) 'INFLATION': inflation,
      if (riskProfileType != null) 'RISK_PROFILE_TYPE': riskProfileType,
    });
  }

  GoalTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? targetAmount,
      Value<DateTime>? targetDate,
      Value<double>? inflation,
      Value<RiskProfileType?>? riskProfileType}) {
    return GoalTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
      inflation: inflation ?? this.inflation,
      riskProfileType: riskProfileType ?? this.riskProfileType,
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
    if (targetAmount.present) {
      map['TARGET_AMOUNT'] = Variable<double>(targetAmount.value);
    }
    if (targetDate.present) {
      map['TARGET_DATE'] = Variable<DateTime>(targetDate.value);
    }
    if (inflation.present) {
      map['INFLATION'] = Variable<double>(inflation.value);
    }
    if (riskProfileType.present) {
      map['RISK_PROFILE_TYPE'] = Variable<String>($GoalTableTable
          .$converterriskProfileTypen
          .toSql(riskProfileType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('targetDate: $targetDate, ')
          ..write('inflation: $inflation, ')
          ..write('riskProfileType: $riskProfileType')
          ..write(')'))
        .toString();
  }
}

class $GoalInvestmentMapTableTable extends GoalInvestmentMapTable
    with TableInfo<$GoalInvestmentMapTableTable, GOAL_INVESTMENT_MAP> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalInvestmentMapTableTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _investmentPercentageMeta =
      const VerificationMeta('investmentPercentage');
  @override
  late final GeneratedColumn<double> investmentPercentage =
      GeneratedColumn<double>('INVESTMENT_PERCENTAGE', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, goalId, investmentId, investmentPercentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_investment_map_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<GOAL_INVESTMENT_MAP> instance,
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
    if (data.containsKey('INVESTMENT_PERCENTAGE')) {
      context.handle(
          _investmentPercentageMeta,
          investmentPercentage.isAcceptableOrUnknown(
              data['INVESTMENT_PERCENTAGE']!, _investmentPercentageMeta));
    } else if (isInserting) {
      context.missing(_investmentPercentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GOAL_INVESTMENT_MAP map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GOAL_INVESTMENT_MAP(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}GOAL_ID'])!,
      investmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!,
      investmentPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}INVESTMENT_PERCENTAGE'])!,
    );
  }

  @override
  $GoalInvestmentMapTableTable createAlias(String alias) {
    return $GoalInvestmentMapTableTable(attachedDatabase, alias);
  }
}

class GOAL_INVESTMENT_MAP extends DataClass
    implements Insertable<GOAL_INVESTMENT_MAP> {
  final int id;
  final int goalId;
  final int investmentId;
  final double investmentPercentage;
  const GOAL_INVESTMENT_MAP(
      {required this.id,
      required this.goalId,
      required this.investmentId,
      required this.investmentPercentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['GOAL_ID'] = Variable<int>(goalId);
    map['INVESTMENT_ID'] = Variable<int>(investmentId);
    map['INVESTMENT_PERCENTAGE'] = Variable<double>(investmentPercentage);
    return map;
  }

  GoalInvestmentMapTableCompanion toCompanion(bool nullToAbsent) {
    return GoalInvestmentMapTableCompanion(
      id: Value(id),
      goalId: Value(goalId),
      investmentId: Value(investmentId),
      investmentPercentage: Value(investmentPercentage),
    );
  }

  factory GOAL_INVESTMENT_MAP.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GOAL_INVESTMENT_MAP(
      id: serializer.fromJson<int>(json['id']),
      goalId: serializer.fromJson<int>(json['goalId']),
      investmentId: serializer.fromJson<int>(json['investmentId']),
      investmentPercentage:
          serializer.fromJson<double>(json['investmentPercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalId': serializer.toJson<int>(goalId),
      'investmentId': serializer.toJson<int>(investmentId),
      'investmentPercentage': serializer.toJson<double>(investmentPercentage),
    };
  }

  GOAL_INVESTMENT_MAP copyWith(
          {int? id,
          int? goalId,
          int? investmentId,
          double? investmentPercentage}) =>
      GOAL_INVESTMENT_MAP(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        investmentId: investmentId ?? this.investmentId,
        investmentPercentage: investmentPercentage ?? this.investmentPercentage,
      );
  @override
  String toString() {
    return (StringBuffer('GOAL_INVESTMENT_MAP(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('investmentPercentage: $investmentPercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, goalId, investmentId, investmentPercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GOAL_INVESTMENT_MAP &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.investmentPercentage == this.investmentPercentage);
}

class GoalInvestmentMapTableCompanion
    extends UpdateCompanion<GOAL_INVESTMENT_MAP> {
  final Value<int> id;
  final Value<int> goalId;
  final Value<int> investmentId;
  final Value<double> investmentPercentage;
  const GoalInvestmentMapTableCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.investmentPercentage = const Value.absent(),
  });
  GoalInvestmentMapTableCompanion.insert({
    this.id = const Value.absent(),
    required int goalId,
    required int investmentId,
    required double investmentPercentage,
  })  : goalId = Value(goalId),
        investmentId = Value(investmentId),
        investmentPercentage = Value(investmentPercentage);
  static Insertable<GOAL_INVESTMENT_MAP> custom({
    Expression<int>? id,
    Expression<int>? goalId,
    Expression<int>? investmentId,
    Expression<double>? investmentPercentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (goalId != null) 'GOAL_ID': goalId,
      if (investmentId != null) 'INVESTMENT_ID': investmentId,
      if (investmentPercentage != null)
        'INVESTMENT_PERCENTAGE': investmentPercentage,
    });
  }

  GoalInvestmentMapTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? goalId,
      Value<int>? investmentId,
      Value<double>? investmentPercentage}) {
    return GoalInvestmentMapTableCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      investmentId: investmentId ?? this.investmentId,
      investmentPercentage: investmentPercentage ?? this.investmentPercentage,
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
    if (investmentPercentage.present) {
      map['INVESTMENT_PERCENTAGE'] =
          Variable<double>(investmentPercentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalInvestmentMapTableCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('investmentId: $investmentId, ')
          ..write('investmentPercentage: $investmentPercentage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $BasketTableTable basketTable = $BasketTableTable(this);
  late final $InvestmentTableTable investmentTable =
      $InvestmentTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $GoalTableTable goalTable = $GoalTableTable(this);
  late final $GoalInvestmentMapTableTable goalInvestmentMapTable =
      $GoalInvestmentMapTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        basketTable,
        investmentTable,
        transactionTable,
        goalTable,
        goalInvestmentMapTable
      ];
}
