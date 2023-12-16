// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTable extends Basket with TableInfo<$BasketTable, BasketDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BasketTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'basket';
  @override
  VerificationContext validateIntegrity(Insertable<BasketDTO> instance,
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
  BasketDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BasketDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
    );
  }

  @override
  $BasketTable createAlias(String alias) {
    return $BasketTable(attachedDatabase, alias);
  }
}

class BasketDTO extends DataClass implements Insertable<BasketDTO> {
  final int id;
  final String name;
  const BasketDTO({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    return map;
  }

  BasketCompanion toCompanion(bool nullToAbsent) {
    return BasketCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory BasketDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BasketDTO(
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

  BasketDTO copyWith({int? id, String? name}) => BasketDTO(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('BasketDTO(')
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
      (other is BasketDTO && other.id == this.id && other.name == this.name);
}

class BasketCompanion extends UpdateCompanion<BasketDTO> {
  final Value<int> id;
  final Value<String> name;
  const BasketCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  BasketCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<BasketDTO> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (name != null) 'NAME': name,
    });
  }

  BasketCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return BasketCompanion(
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
    return (StringBuffer('BasketCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $InvestmentTable extends Investment
    with TableInfo<$InvestmentTable, InvestmentDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES basket (ID)'));
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
          .withConverter<RiskLevel>($InvestmentTable.$converterriskLevel);
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
  static const String $name = 'investment';
  @override
  VerificationContext validateIntegrity(Insertable<InvestmentDTO> instance,
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
  InvestmentDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}NAME'])!,
      basketId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}BASKET_ID'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}VALUE'])!,
      riskLevel: $InvestmentTable.$converterriskLevel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}RISK_LEVEL'])!),
      valueUpdatedOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON'])!,
    );
  }

  @override
  $InvestmentTable createAlias(String alias) {
    return $InvestmentTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RiskLevel, String, String> $converterriskLevel =
      const EnumNameConverter<RiskLevel>(RiskLevel.values);
}

class InvestmentDTO extends DataClass implements Insertable<InvestmentDTO> {
  final int id;
  final String name;
  final int basketId;
  final double value;
  final RiskLevel riskLevel;
  final DateTime valueUpdatedOn;
  const InvestmentDTO(
      {required this.id,
      required this.name,
      required this.basketId,
      required this.value,
      required this.riskLevel,
      required this.valueUpdatedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['NAME'] = Variable<String>(name);
    map['BASKET_ID'] = Variable<int>(basketId);
    map['VALUE'] = Variable<double>(value);
    {
      map['RISK_LEVEL'] = Variable<String>(
          $InvestmentTable.$converterriskLevel.toSql(riskLevel));
    }
    map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn);
    return map;
  }

  InvestmentCompanion toCompanion(bool nullToAbsent) {
    return InvestmentCompanion(
      id: Value(id),
      name: Value(name),
      basketId: Value(basketId),
      value: Value(value),
      riskLevel: Value(riskLevel),
      valueUpdatedOn: Value(valueUpdatedOn),
    );
  }

  factory InvestmentDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentDTO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      basketId: serializer.fromJson<int>(json['basketId']),
      value: serializer.fromJson<double>(json['value']),
      riskLevel: $InvestmentTable.$converterriskLevel
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
      'basketId': serializer.toJson<int>(basketId),
      'value': serializer.toJson<double>(value),
      'riskLevel': serializer.toJson<String>(
          $InvestmentTable.$converterriskLevel.toJson(riskLevel)),
      'valueUpdatedOn': serializer.toJson<DateTime>(valueUpdatedOn),
    };
  }

  InvestmentDTO copyWith(
          {int? id,
          String? name,
          int? basketId,
          double? value,
          RiskLevel? riskLevel,
          DateTime? valueUpdatedOn}) =>
      InvestmentDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        basketId: basketId ?? this.basketId,
        value: value ?? this.value,
        riskLevel: riskLevel ?? this.riskLevel,
        valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('InvestmentDTO(')
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
      (other is InvestmentDTO &&
          other.id == this.id &&
          other.name == this.name &&
          other.basketId == this.basketId &&
          other.value == this.value &&
          other.riskLevel == this.riskLevel &&
          other.valueUpdatedOn == this.valueUpdatedOn);
}

class InvestmentCompanion extends UpdateCompanion<InvestmentDTO> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> basketId;
  final Value<double> value;
  final Value<RiskLevel> riskLevel;
  final Value<DateTime> valueUpdatedOn;
  const InvestmentCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.basketId = const Value.absent(),
    this.value = const Value.absent(),
    this.riskLevel = const Value.absent(),
    this.valueUpdatedOn = const Value.absent(),
  });
  InvestmentCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int basketId,
    required double value,
    required RiskLevel riskLevel,
    required DateTime valueUpdatedOn,
  })  : name = Value(name),
        basketId = Value(basketId),
        value = Value(value),
        riskLevel = Value(riskLevel),
        valueUpdatedOn = Value(valueUpdatedOn);
  static Insertable<InvestmentDTO> custom({
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

  InvestmentCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? basketId,
      Value<double>? value,
      Value<RiskLevel>? riskLevel,
      Value<DateTime>? valueUpdatedOn}) {
    return InvestmentCompanion(
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
          $InvestmentTable.$converterriskLevel.toSql(riskLevel.value));
    }
    if (valueUpdatedOn.present) {
      map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentCompanion(')
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

class $InvestmentTransactionTable extends InvestmentTransaction
    with TableInfo<$InvestmentTransactionTable, TransactionDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentTransactionTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES investment (ID)'));
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
  static const String $name = 'investment_transaction';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDTO> instance,
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
  TransactionDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDTO(
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
  $InvestmentTransactionTable createAlias(String alias) {
    return $InvestmentTransactionTable(attachedDatabase, alias);
  }
}

class TransactionDTO extends DataClass implements Insertable<TransactionDTO> {
  final int id;
  final int investmentId;
  final double amount;
  final DateTime amountInvestedOn;
  const TransactionDTO(
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

  InvestmentTransactionCompanion toCompanion(bool nullToAbsent) {
    return InvestmentTransactionCompanion(
      id: Value(id),
      investmentId: Value(investmentId),
      amount: Value(amount),
      amountInvestedOn: Value(amountInvestedOn),
    );
  }

  factory TransactionDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDTO(
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

  TransactionDTO copyWith(
          {int? id,
          int? investmentId,
          double? amount,
          DateTime? amountInvestedOn}) =>
      TransactionDTO(
        id: id ?? this.id,
        investmentId: investmentId ?? this.investmentId,
        amount: amount ?? this.amount,
        amountInvestedOn: amountInvestedOn ?? this.amountInvestedOn,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDTO(')
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
      (other is TransactionDTO &&
          other.id == this.id &&
          other.investmentId == this.investmentId &&
          other.amount == this.amount &&
          other.amountInvestedOn == this.amountInvestedOn);
}

class InvestmentTransactionCompanion extends UpdateCompanion<TransactionDTO> {
  final Value<int> id;
  final Value<int> investmentId;
  final Value<double> amount;
  final Value<DateTime> amountInvestedOn;
  const InvestmentTransactionCompanion({
    this.id = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountInvestedOn = const Value.absent(),
  });
  InvestmentTransactionCompanion.insert({
    this.id = const Value.absent(),
    required int investmentId,
    required double amount,
    required DateTime amountInvestedOn,
  })  : investmentId = Value(investmentId),
        amount = Value(amount),
        amountInvestedOn = Value(amountInvestedOn);
  static Insertable<TransactionDTO> custom({
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

  InvestmentTransactionCompanion copyWith(
      {Value<int>? id,
      Value<int>? investmentId,
      Value<double>? amount,
      Value<DateTime>? amountInvestedOn}) {
    return InvestmentTransactionCompanion(
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
    return (StringBuffer('InvestmentTransactionCompanion(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('amount: $amount, ')
          ..write('amountInvestedOn: $amountInvestedOn')
          ..write(')'))
        .toString();
  }
}

class $GoalTable extends Goal with TableInfo<$GoalTable, GoalDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalTable(this.attachedDatabase, [this._alias]);
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
          .withConverter<GoalImportance>($GoalTable.$converterimportance);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, amount, date, inflation, targetAmount, targetDate, importance];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal';
  @override
  VerificationContext validateIntegrity(Insertable<GoalDTO> instance,
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
  GoalDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalDTO(
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
      importance: $GoalTable.$converterimportance.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}IMPORTANCE'])!),
    );
  }

  @override
  $GoalTable createAlias(String alias) {
    return $GoalTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalImportance, String, String>
      $converterimportance =
      const EnumNameConverter<GoalImportance>(GoalImportance.values);
}

class GoalDTO extends DataClass implements Insertable<GoalDTO> {
  final int id;
  final String name;
  final double amount;
  final DateTime date;
  final double inflation;
  final double targetAmount;
  final DateTime targetDate;
  final GoalImportance importance;
  const GoalDTO(
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
      map['IMPORTANCE'] =
          Variable<String>($GoalTable.$converterimportance.toSql(importance));
    }
    return map;
  }

  GoalCompanion toCompanion(bool nullToAbsent) {
    return GoalCompanion(
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

  factory GoalDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalDTO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      inflation: serializer.fromJson<double>(json['inflation']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
      importance: $GoalTable.$converterimportance
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
      'importance': serializer
          .toJson<String>($GoalTable.$converterimportance.toJson(importance)),
    };
  }

  GoalDTO copyWith(
          {int? id,
          String? name,
          double? amount,
          DateTime? date,
          double? inflation,
          double? targetAmount,
          DateTime? targetDate,
          GoalImportance? importance}) =>
      GoalDTO(
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
    return (StringBuffer('GoalDTO(')
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
      (other is GoalDTO &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.inflation == this.inflation &&
          other.targetAmount == this.targetAmount &&
          other.targetDate == this.targetDate &&
          other.importance == this.importance);
}

class GoalCompanion extends UpdateCompanion<GoalDTO> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<double> inflation;
  final Value<double> targetAmount;
  final Value<DateTime> targetDate;
  final Value<GoalImportance> importance;
  const GoalCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.inflation = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.importance = const Value.absent(),
  });
  GoalCompanion.insert({
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
  static Insertable<GoalDTO> custom({
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

  GoalCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<double>? inflation,
      Value<double>? targetAmount,
      Value<DateTime>? targetDate,
      Value<GoalImportance>? importance}) {
    return GoalCompanion(
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
          $GoalTable.$converterimportance.toSql(importance.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalCompanion(')
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

class $GoalInvestmentTable extends GoalInvestment
    with TableInfo<$GoalInvestmentTable, GoalInvestmentDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalInvestmentTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES goal (ID)'));
  static const VerificationMeta _investmentIdMeta =
      const VerificationMeta('investmentId');
  @override
  late final GeneratedColumn<int> investmentId = GeneratedColumn<int>(
      'INVESTMENT_ID', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES investment (ID)'));
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
  static const String $name = 'goal_investment';
  @override
  VerificationContext validateIntegrity(Insertable<GoalInvestmentDTO> instance,
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
  GoalInvestmentDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalInvestmentDTO(
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
  $GoalInvestmentTable createAlias(String alias) {
    return $GoalInvestmentTable(attachedDatabase, alias);
  }
}

class GoalInvestmentDTO extends DataClass
    implements Insertable<GoalInvestmentDTO> {
  final int id;
  final int goalId;
  final int investmentId;
  final double investmentPercentage;
  const GoalInvestmentDTO(
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

  GoalInvestmentCompanion toCompanion(bool nullToAbsent) {
    return GoalInvestmentCompanion(
      id: Value(id),
      goalId: Value(goalId),
      investmentId: Value(investmentId),
      investmentPercentage: Value(investmentPercentage),
    );
  }

  factory GoalInvestmentDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalInvestmentDTO(
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

  GoalInvestmentDTO copyWith(
          {int? id,
          int? goalId,
          int? investmentId,
          double? investmentPercentage}) =>
      GoalInvestmentDTO(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        investmentId: investmentId ?? this.investmentId,
        investmentPercentage: investmentPercentage ?? this.investmentPercentage,
      );
  @override
  String toString() {
    return (StringBuffer('GoalInvestmentDTO(')
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
      (other is GoalInvestmentDTO &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.investmentId == this.investmentId &&
          other.investmentPercentage == this.investmentPercentage);
}

class GoalInvestmentCompanion extends UpdateCompanion<GoalInvestmentDTO> {
  final Value<int> id;
  final Value<int> goalId;
  final Value<int> investmentId;
  final Value<double> investmentPercentage;
  const GoalInvestmentCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.investmentPercentage = const Value.absent(),
  });
  GoalInvestmentCompanion.insert({
    this.id = const Value.absent(),
    required int goalId,
    required int investmentId,
    required double investmentPercentage,
  })  : goalId = Value(goalId),
        investmentId = Value(investmentId),
        investmentPercentage = Value(investmentPercentage);
  static Insertable<GoalInvestmentDTO> custom({
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

  GoalInvestmentCompanion copyWith(
      {Value<int>? id,
      Value<int>? goalId,
      Value<int>? investmentId,
      Value<double>? investmentPercentage}) {
    return GoalInvestmentCompanion(
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
    return (StringBuffer('GoalInvestmentCompanion(')
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
  late final $BasketTable basket = $BasketTable(this);
  late final $InvestmentTable investment = $InvestmentTable(this);
  late final $InvestmentTransactionTable investmentTransaction =
      $InvestmentTransactionTable(this);
  late final $GoalTable goal = $GoalTable(this);
  late final $GoalInvestmentTable goalInvestment = $GoalInvestmentTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [basket, investment, investmentTransaction, goal, goalInvestment];
}
