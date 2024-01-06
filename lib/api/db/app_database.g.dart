// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BasketTableTable extends BasketTable with TableInfo<$BasketTableTable, BasketDO>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$BasketTableTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _nameMeta = const VerificationMeta('name');
@override
late final GeneratedColumn<String> name = GeneratedColumn<String>('NAME', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
@override
late final GeneratedColumn<String> description = GeneratedColumn<String>('DESCRIPTION', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, name, description];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'basket_table';
@override
VerificationContext validateIntegrity(Insertable<BasketDO> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('ID')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));}if (data.containsKey('NAME')) {
context.handle(_nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));} else if (isInserting) {
context.missing(_nameMeta);
}
if (data.containsKey('DESCRIPTION')) {
context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['DESCRIPTION']!, _descriptionMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override BasketDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return BasketDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}NAME'])!, description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']), );
}
@override
$BasketTableTable createAlias(String alias) {
return $BasketTableTable(attachedDatabase, alias);}}class BasketDO extends DataClass implements Insertable<BasketDO> {
final int id;
final String name;
final String? description;
const BasketDO({required this.id, required this.name, this.description});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['ID'] = Variable<int>(id);
map['NAME'] = Variable<String>(name);
if (!nullToAbsent || description != null){map['DESCRIPTION'] = Variable<String>(description);
}return map; 
}
BasketTableCompanion toCompanion(bool nullToAbsent) {
return BasketTableCompanion(id: Value(id),name: Value(name),description: description == null && nullToAbsent ? const Value.absent() : Value(description),);
}
factory BasketDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return BasketDO(id: serializer.fromJson<int>(json['id']),name: serializer.fromJson<String>(json['name']),description: serializer.fromJson<String?>(json['description']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'name': serializer.toJson<String>(name),'description': serializer.toJson<String?>(description),};}BasketDO copyWith({int? id,String? name,Value<String?> description = const Value.absent()}) => BasketDO(id: id ?? this.id,name: name ?? this.name,description: description.present ? description.value : this.description,);@override
String toString() {return (StringBuffer('BasketDO(')..write('id: $id, ')..write('name: $name, ')..write('description: $description')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, name, description);@override
bool operator ==(Object other) => identical(this, other) || (other is BasketDO && other.id == this.id && other.name == this.name && other.description == this.description);
}class BasketTableCompanion extends UpdateCompanion<BasketDO> {
final Value<int> id;
final Value<String> name;
final Value<String?> description;
const BasketTableCompanion({this.id = const Value.absent(),this.name = const Value.absent(),this.description = const Value.absent(),});
BasketTableCompanion.insert({this.id = const Value.absent(),required String name,this.description = const Value.absent(),}): name = Value(name);
static Insertable<BasketDO> custom({Expression<int>? id, 
Expression<String>? name, 
Expression<String>? description, 
}) {
return RawValuesInsertable({if (id != null)'ID': id,if (name != null)'NAME': name,if (description != null)'DESCRIPTION': description,});
}BasketTableCompanion copyWith({Value<int>? id, Value<String>? name, Value<String?>? description}) {
return BasketTableCompanion(id: id ?? this.id,name: name ?? this.name,description: description ?? this.description,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['ID'] = Variable<int>(id.value);}
if (name.present) {
map['NAME'] = Variable<String>(name.value);}
if (description.present) {
map['DESCRIPTION'] = Variable<String>(description.value);}
return map; 
}
@override
String toString() {return (StringBuffer('BasketTableCompanion(')..write('id: $id, ')..write('name: $name, ')..write('description: $description')..write(')')).toString();}
}
class $InvestmentTableTable extends InvestmentTable with TableInfo<$InvestmentTableTable, InvestmentDO>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$InvestmentTableTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _nameMeta = const VerificationMeta('name');
@override
late final GeneratedColumn<String> name = GeneratedColumn<String>('NAME', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
@override
late final GeneratedColumn<String> description = GeneratedColumn<String>('DESCRIPTION', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _basketIdMeta = const VerificationMeta('basketId');
@override
late final GeneratedColumn<int> basketId = GeneratedColumn<int>('BASKET_ID', aliasedName, true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES basket_table (ID)'));
static const VerificationMeta _valueMeta = const VerificationMeta('value');
@override
late final GeneratedColumn<double> value = GeneratedColumn<double>('VALUE', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _riskLevelMeta = const VerificationMeta('riskLevel');
@override
late final GeneratedColumnWithTypeConverter<RiskLevel, String> riskLevel = GeneratedColumn<String>('RISK_LEVEL', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true).withConverter<RiskLevel>($InvestmentTableTable.$converterriskLevel);
static const VerificationMeta _valueUpdatedOnMeta = const VerificationMeta('valueUpdatedOn');
@override
late final GeneratedColumn<DateTime> valueUpdatedOn = GeneratedColumn<DateTime>('VALUE_UPDATED_ON', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, name, description, basketId, value, riskLevel, valueUpdatedOn];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'investment_table';
@override
VerificationContext validateIntegrity(Insertable<InvestmentDO> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('ID')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));}if (data.containsKey('NAME')) {
context.handle(_nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));} else if (isInserting) {
context.missing(_nameMeta);
}
if (data.containsKey('DESCRIPTION')) {
context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['DESCRIPTION']!, _descriptionMeta));}if (data.containsKey('BASKET_ID')) {
context.handle(_basketIdMeta, basketId.isAcceptableOrUnknown(data['BASKET_ID']!, _basketIdMeta));}if (data.containsKey('VALUE')) {
context.handle(_valueMeta, value.isAcceptableOrUnknown(data['VALUE']!, _valueMeta));} else if (isInserting) {
context.missing(_valueMeta);
}
context.handle(_riskLevelMeta, const VerificationResult.success());if (data.containsKey('VALUE_UPDATED_ON')) {
context.handle(_valueUpdatedOnMeta, valueUpdatedOn.isAcceptableOrUnknown(data['VALUE_UPDATED_ON']!, _valueUpdatedOnMeta));} else if (isInserting) {
context.missing(_valueUpdatedOnMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override InvestmentDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return InvestmentDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}NAME'])!, description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']), basketId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}BASKET_ID']), value: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}VALUE'])!, riskLevel: $InvestmentTableTable.$converterriskLevel.fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}RISK_LEVEL'])!), valueUpdatedOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON'])!, );
}
@override
$InvestmentTableTable createAlias(String alias) {
return $InvestmentTableTable(attachedDatabase, alias);}static JsonTypeConverter2<RiskLevel,String,String> $converterriskLevel = const EnumNameConverter<RiskLevel>(RiskLevel.values);}class InvestmentDO extends DataClass implements Insertable<InvestmentDO> {
final int id;
final String name;
final String? description;
final int? basketId;
final double value;
final RiskLevel riskLevel;
final DateTime valueUpdatedOn;
const InvestmentDO({required this.id, required this.name, this.description, this.basketId, required this.value, required this.riskLevel, required this.valueUpdatedOn});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['ID'] = Variable<int>(id);
map['NAME'] = Variable<String>(name);
if (!nullToAbsent || description != null){map['DESCRIPTION'] = Variable<String>(description);
}if (!nullToAbsent || basketId != null){map['BASKET_ID'] = Variable<int>(basketId);
}map['VALUE'] = Variable<double>(value);
{map['RISK_LEVEL'] = Variable<String>($InvestmentTableTable.$converterriskLevel.toSql(riskLevel));
}map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn);
return map; 
}
InvestmentTableCompanion toCompanion(bool nullToAbsent) {
return InvestmentTableCompanion(id: Value(id),name: Value(name),description: description == null && nullToAbsent ? const Value.absent() : Value(description),basketId: basketId == null && nullToAbsent ? const Value.absent() : Value(basketId),value: Value(value),riskLevel: Value(riskLevel),valueUpdatedOn: Value(valueUpdatedOn),);
}
factory InvestmentDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return InvestmentDO(id: serializer.fromJson<int>(json['id']),name: serializer.fromJson<String>(json['name']),description: serializer.fromJson<String?>(json['description']),basketId: serializer.fromJson<int?>(json['basketId']),value: serializer.fromJson<double>(json['value']),riskLevel: $InvestmentTableTable.$converterriskLevel.fromJson(serializer.fromJson<String>(json['riskLevel'])),valueUpdatedOn: serializer.fromJson<DateTime>(json['valueUpdatedOn']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'name': serializer.toJson<String>(name),'description': serializer.toJson<String?>(description),'basketId': serializer.toJson<int?>(basketId),'value': serializer.toJson<double>(value),'riskLevel': serializer.toJson<String>($InvestmentTableTable.$converterriskLevel.toJson(riskLevel)),'valueUpdatedOn': serializer.toJson<DateTime>(valueUpdatedOn),};}InvestmentDO copyWith({int? id,String? name,Value<String?> description = const Value.absent(),Value<int?> basketId = const Value.absent(),double? value,RiskLevel? riskLevel,DateTime? valueUpdatedOn}) => InvestmentDO(id: id ?? this.id,name: name ?? this.name,description: description.present ? description.value : this.description,basketId: basketId.present ? basketId.value : this.basketId,value: value ?? this.value,riskLevel: riskLevel ?? this.riskLevel,valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,);@override
String toString() {return (StringBuffer('InvestmentDO(')..write('id: $id, ')..write('name: $name, ')..write('description: $description, ')..write('basketId: $basketId, ')..write('value: $value, ')..write('riskLevel: $riskLevel, ')..write('valueUpdatedOn: $valueUpdatedOn')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, name, description, basketId, value, riskLevel, valueUpdatedOn);@override
bool operator ==(Object other) => identical(this, other) || (other is InvestmentDO && other.id == this.id && other.name == this.name && other.description == this.description && other.basketId == this.basketId && other.value == this.value && other.riskLevel == this.riskLevel && other.valueUpdatedOn == this.valueUpdatedOn);
}class InvestmentTableCompanion extends UpdateCompanion<InvestmentDO> {
final Value<int> id;
final Value<String> name;
final Value<String?> description;
final Value<int?> basketId;
final Value<double> value;
final Value<RiskLevel> riskLevel;
final Value<DateTime> valueUpdatedOn;
const InvestmentTableCompanion({this.id = const Value.absent(),this.name = const Value.absent(),this.description = const Value.absent(),this.basketId = const Value.absent(),this.value = const Value.absent(),this.riskLevel = const Value.absent(),this.valueUpdatedOn = const Value.absent(),});
InvestmentTableCompanion.insert({this.id = const Value.absent(),required String name,this.description = const Value.absent(),this.basketId = const Value.absent(),required double value,required RiskLevel riskLevel,required DateTime valueUpdatedOn,}): name = Value(name), value = Value(value), riskLevel = Value(riskLevel), valueUpdatedOn = Value(valueUpdatedOn);
static Insertable<InvestmentDO> custom({Expression<int>? id, 
Expression<String>? name, 
Expression<String>? description, 
Expression<int>? basketId, 
Expression<double>? value, 
Expression<String>? riskLevel, 
Expression<DateTime>? valueUpdatedOn, 
}) {
return RawValuesInsertable({if (id != null)'ID': id,if (name != null)'NAME': name,if (description != null)'DESCRIPTION': description,if (basketId != null)'BASKET_ID': basketId,if (value != null)'VALUE': value,if (riskLevel != null)'RISK_LEVEL': riskLevel,if (valueUpdatedOn != null)'VALUE_UPDATED_ON': valueUpdatedOn,});
}InvestmentTableCompanion copyWith({Value<int>? id, Value<String>? name, Value<String?>? description, Value<int?>? basketId, Value<double>? value, Value<RiskLevel>? riskLevel, Value<DateTime>? valueUpdatedOn}) {
return InvestmentTableCompanion(id: id ?? this.id,name: name ?? this.name,description: description ?? this.description,basketId: basketId ?? this.basketId,value: value ?? this.value,riskLevel: riskLevel ?? this.riskLevel,valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['ID'] = Variable<int>(id.value);}
if (name.present) {
map['NAME'] = Variable<String>(name.value);}
if (description.present) {
map['DESCRIPTION'] = Variable<String>(description.value);}
if (basketId.present) {
map['BASKET_ID'] = Variable<int>(basketId.value);}
if (value.present) {
map['VALUE'] = Variable<double>(value.value);}
if (riskLevel.present) {
map['RISK_LEVEL'] = Variable<String>($InvestmentTableTable.$converterriskLevel.toSql(riskLevel.value));}
if (valueUpdatedOn.present) {
map['VALUE_UPDATED_ON'] = Variable<DateTime>(valueUpdatedOn.value);}
return map; 
}
@override
String toString() {return (StringBuffer('InvestmentTableCompanion(')..write('id: $id, ')..write('name: $name, ')..write('description: $description, ')..write('basketId: $basketId, ')..write('value: $value, ')..write('riskLevel: $riskLevel, ')..write('valueUpdatedOn: $valueUpdatedOn')..write(')')).toString();}
}
class $TransactionTableTable extends TransactionTable with TableInfo<$TransactionTableTable, TransactionDO>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$TransactionTableTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _investmentIdMeta = const VerificationMeta('investmentId');
@override
late final GeneratedColumn<int> investmentId = GeneratedColumn<int>('INVESTMENT_ID', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES investment_table (ID)'));
static const VerificationMeta _amountMeta = const VerificationMeta('amount');
@override
late final GeneratedColumn<double> amount = GeneratedColumn<double>('AMOUNT', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
@override
late final GeneratedColumn<String> description = GeneratedColumn<String>('DESCRIPTION', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _amountInvestedOnMeta = const VerificationMeta('amountInvestedOn');
@override
late final GeneratedColumn<DateTime> amountInvestedOn = GeneratedColumn<DateTime>('AMOUNT_INVESTED_ON', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, investmentId, amount, description, amountInvestedOn];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'transaction_table';
@override
VerificationContext validateIntegrity(Insertable<TransactionDO> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('ID')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));}if (data.containsKey('INVESTMENT_ID')) {
context.handle(_investmentIdMeta, investmentId.isAcceptableOrUnknown(data['INVESTMENT_ID']!, _investmentIdMeta));} else if (isInserting) {
context.missing(_investmentIdMeta);
}
if (data.containsKey('AMOUNT')) {
context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));} else if (isInserting) {
context.missing(_amountMeta);
}
if (data.containsKey('DESCRIPTION')) {
context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['DESCRIPTION']!, _descriptionMeta));}if (data.containsKey('AMOUNT_INVESTED_ON')) {
context.handle(_amountInvestedOnMeta, amountInvestedOn.isAcceptableOrUnknown(data['AMOUNT_INVESTED_ON']!, _amountInvestedOnMeta));} else if (isInserting) {
context.missing(_amountInvestedOnMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override TransactionDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return TransactionDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, investmentId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!, amount: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!, description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']), amountInvestedOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}AMOUNT_INVESTED_ON'])!, );
}
@override
$TransactionTableTable createAlias(String alias) {
return $TransactionTableTable(attachedDatabase, alias);}}class TransactionDO extends DataClass implements Insertable<TransactionDO> {
final int id;
final int investmentId;
final double amount;
final String? description;
final DateTime amountInvestedOn;
const TransactionDO({required this.id, required this.investmentId, required this.amount, this.description, required this.amountInvestedOn});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['ID'] = Variable<int>(id);
map['INVESTMENT_ID'] = Variable<int>(investmentId);
map['AMOUNT'] = Variable<double>(amount);
if (!nullToAbsent || description != null){map['DESCRIPTION'] = Variable<String>(description);
}map['AMOUNT_INVESTED_ON'] = Variable<DateTime>(amountInvestedOn);
return map; 
}
TransactionTableCompanion toCompanion(bool nullToAbsent) {
return TransactionTableCompanion(id: Value(id),investmentId: Value(investmentId),amount: Value(amount),description: description == null && nullToAbsent ? const Value.absent() : Value(description),amountInvestedOn: Value(amountInvestedOn),);
}
factory TransactionDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return TransactionDO(id: serializer.fromJson<int>(json['id']),investmentId: serializer.fromJson<int>(json['investmentId']),amount: serializer.fromJson<double>(json['amount']),description: serializer.fromJson<String?>(json['description']),amountInvestedOn: serializer.fromJson<DateTime>(json['amountInvestedOn']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'investmentId': serializer.toJson<int>(investmentId),'amount': serializer.toJson<double>(amount),'description': serializer.toJson<String?>(description),'amountInvestedOn': serializer.toJson<DateTime>(amountInvestedOn),};}TransactionDO copyWith({int? id,int? investmentId,double? amount,Value<String?> description = const Value.absent(),DateTime? amountInvestedOn}) => TransactionDO(id: id ?? this.id,investmentId: investmentId ?? this.investmentId,amount: amount ?? this.amount,description: description.present ? description.value : this.description,amountInvestedOn: amountInvestedOn ?? this.amountInvestedOn,);@override
String toString() {return (StringBuffer('TransactionDO(')..write('id: $id, ')..write('investmentId: $investmentId, ')..write('amount: $amount, ')..write('description: $description, ')..write('amountInvestedOn: $amountInvestedOn')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, investmentId, amount, description, amountInvestedOn);@override
bool operator ==(Object other) => identical(this, other) || (other is TransactionDO && other.id == this.id && other.investmentId == this.investmentId && other.amount == this.amount && other.description == this.description && other.amountInvestedOn == this.amountInvestedOn);
}class TransactionTableCompanion extends UpdateCompanion<TransactionDO> {
final Value<int> id;
final Value<int> investmentId;
final Value<double> amount;
final Value<String?> description;
final Value<DateTime> amountInvestedOn;
const TransactionTableCompanion({this.id = const Value.absent(),this.investmentId = const Value.absent(),this.amount = const Value.absent(),this.description = const Value.absent(),this.amountInvestedOn = const Value.absent(),});
TransactionTableCompanion.insert({this.id = const Value.absent(),required int investmentId,required double amount,this.description = const Value.absent(),required DateTime amountInvestedOn,}): investmentId = Value(investmentId), amount = Value(amount), amountInvestedOn = Value(amountInvestedOn);
static Insertable<TransactionDO> custom({Expression<int>? id, 
Expression<int>? investmentId, 
Expression<double>? amount, 
Expression<String>? description, 
Expression<DateTime>? amountInvestedOn, 
}) {
return RawValuesInsertable({if (id != null)'ID': id,if (investmentId != null)'INVESTMENT_ID': investmentId,if (amount != null)'AMOUNT': amount,if (description != null)'DESCRIPTION': description,if (amountInvestedOn != null)'AMOUNT_INVESTED_ON': amountInvestedOn,});
}TransactionTableCompanion copyWith({Value<int>? id, Value<int>? investmentId, Value<double>? amount, Value<String?>? description, Value<DateTime>? amountInvestedOn}) {
return TransactionTableCompanion(id: id ?? this.id,investmentId: investmentId ?? this.investmentId,amount: amount ?? this.amount,description: description ?? this.description,amountInvestedOn: amountInvestedOn ?? this.amountInvestedOn,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['ID'] = Variable<int>(id.value);}
if (investmentId.present) {
map['INVESTMENT_ID'] = Variable<int>(investmentId.value);}
if (amount.present) {
map['AMOUNT'] = Variable<double>(amount.value);}
if (description.present) {
map['DESCRIPTION'] = Variable<String>(description.value);}
if (amountInvestedOn.present) {
map['AMOUNT_INVESTED_ON'] = Variable<DateTime>(amountInvestedOn.value);}
return map; 
}
@override
String toString() {return (StringBuffer('TransactionTableCompanion(')..write('id: $id, ')..write('investmentId: $investmentId, ')..write('amount: $amount, ')..write('description: $description, ')..write('amountInvestedOn: $amountInvestedOn')..write(')')).toString();}
}
class $GoalTableTable extends GoalTable with TableInfo<$GoalTableTable, GoalDO>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$GoalTableTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _nameMeta = const VerificationMeta('name');
@override
late final GeneratedColumn<String> name = GeneratedColumn<String>('NAME', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
@override
late final GeneratedColumn<String> description = GeneratedColumn<String>('DESCRIPTION', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _amountMeta = const VerificationMeta('amount');
@override
late final GeneratedColumn<double> amount = GeneratedColumn<double>('AMOUNT', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _dateMeta = const VerificationMeta('date');
@override
late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>('DATE', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _inflationMeta = const VerificationMeta('inflation');
@override
late final GeneratedColumn<double> inflation = GeneratedColumn<double>('INFLATION', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _targetAmountMeta = const VerificationMeta('targetAmount');
@override
late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>('TARGET_AMOUNT', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _targetDateMeta = const VerificationMeta('targetDate');
@override
late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>('TARGET_DATE', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _importanceMeta = const VerificationMeta('importance');
@override
late final GeneratedColumnWithTypeConverter<GoalImportance, String> importance = GeneratedColumn<String>('IMPORTANCE', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true).withConverter<GoalImportance>($GoalTableTable.$converterimportance);
@override
List<GeneratedColumn> get $columns => [id, name, description, amount, date, inflation, targetAmount, targetDate, importance];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'goal_table';
@override
VerificationContext validateIntegrity(Insertable<GoalDO> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('ID')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));}if (data.containsKey('NAME')) {
context.handle(_nameMeta, name.isAcceptableOrUnknown(data['NAME']!, _nameMeta));} else if (isInserting) {
context.missing(_nameMeta);
}
if (data.containsKey('DESCRIPTION')) {
context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['DESCRIPTION']!, _descriptionMeta));}if (data.containsKey('AMOUNT')) {
context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));} else if (isInserting) {
context.missing(_amountMeta);
}
if (data.containsKey('DATE')) {
context.handle(_dateMeta, date.isAcceptableOrUnknown(data['DATE']!, _dateMeta));} else if (isInserting) {
context.missing(_dateMeta);
}
if (data.containsKey('INFLATION')) {
context.handle(_inflationMeta, inflation.isAcceptableOrUnknown(data['INFLATION']!, _inflationMeta));} else if (isInserting) {
context.missing(_inflationMeta);
}
if (data.containsKey('TARGET_AMOUNT')) {
context.handle(_targetAmountMeta, targetAmount.isAcceptableOrUnknown(data['TARGET_AMOUNT']!, _targetAmountMeta));} else if (isInserting) {
context.missing(_targetAmountMeta);
}
if (data.containsKey('TARGET_DATE')) {
context.handle(_targetDateMeta, targetDate.isAcceptableOrUnknown(data['TARGET_DATE']!, _targetDateMeta));} else if (isInserting) {
context.missing(_targetDateMeta);
}
context.handle(_importanceMeta, const VerificationResult.success());return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override GoalDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return GoalDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}NAME'])!, description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']), amount: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!, date: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}DATE'])!, inflation: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}INFLATION'])!, targetAmount: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}TARGET_AMOUNT'])!, targetDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}TARGET_DATE'])!, importance: $GoalTableTable.$converterimportance.fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}IMPORTANCE'])!), );
}
@override
$GoalTableTable createAlias(String alias) {
return $GoalTableTable(attachedDatabase, alias);}static JsonTypeConverter2<GoalImportance,String,String> $converterimportance = const EnumNameConverter<GoalImportance>(GoalImportance.values);}class GoalDO extends DataClass implements Insertable<GoalDO> {
final int id;
final String name;
final String? description;
final double amount;
final DateTime date;
final double inflation;
final double targetAmount;
final DateTime targetDate;
final GoalImportance importance;
const GoalDO({required this.id, required this.name, this.description, required this.amount, required this.date, required this.inflation, required this.targetAmount, required this.targetDate, required this.importance});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['ID'] = Variable<int>(id);
map['NAME'] = Variable<String>(name);
if (!nullToAbsent || description != null){map['DESCRIPTION'] = Variable<String>(description);
}map['AMOUNT'] = Variable<double>(amount);
map['DATE'] = Variable<DateTime>(date);
map['INFLATION'] = Variable<double>(inflation);
map['TARGET_AMOUNT'] = Variable<double>(targetAmount);
map['TARGET_DATE'] = Variable<DateTime>(targetDate);
{map['IMPORTANCE'] = Variable<String>($GoalTableTable.$converterimportance.toSql(importance));
}return map; 
}
GoalTableCompanion toCompanion(bool nullToAbsent) {
return GoalTableCompanion(id: Value(id),name: Value(name),description: description == null && nullToAbsent ? const Value.absent() : Value(description),amount: Value(amount),date: Value(date),inflation: Value(inflation),targetAmount: Value(targetAmount),targetDate: Value(targetDate),importance: Value(importance),);
}
factory GoalDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return GoalDO(id: serializer.fromJson<int>(json['id']),name: serializer.fromJson<String>(json['name']),description: serializer.fromJson<String?>(json['description']),amount: serializer.fromJson<double>(json['amount']),date: serializer.fromJson<DateTime>(json['date']),inflation: serializer.fromJson<double>(json['inflation']),targetAmount: serializer.fromJson<double>(json['targetAmount']),targetDate: serializer.fromJson<DateTime>(json['targetDate']),importance: $GoalTableTable.$converterimportance.fromJson(serializer.fromJson<String>(json['importance'])),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'name': serializer.toJson<String>(name),'description': serializer.toJson<String?>(description),'amount': serializer.toJson<double>(amount),'date': serializer.toJson<DateTime>(date),'inflation': serializer.toJson<double>(inflation),'targetAmount': serializer.toJson<double>(targetAmount),'targetDate': serializer.toJson<DateTime>(targetDate),'importance': serializer.toJson<String>($GoalTableTable.$converterimportance.toJson(importance)),};}GoalDO copyWith({int? id,String? name,Value<String?> description = const Value.absent(),double? amount,DateTime? date,double? inflation,double? targetAmount,DateTime? targetDate,GoalImportance? importance}) => GoalDO(id: id ?? this.id,name: name ?? this.name,description: description.present ? description.value : this.description,amount: amount ?? this.amount,date: date ?? this.date,inflation: inflation ?? this.inflation,targetAmount: targetAmount ?? this.targetAmount,targetDate: targetDate ?? this.targetDate,importance: importance ?? this.importance,);@override
String toString() {return (StringBuffer('GoalDO(')..write('id: $id, ')..write('name: $name, ')..write('description: $description, ')..write('amount: $amount, ')..write('date: $date, ')..write('inflation: $inflation, ')..write('targetAmount: $targetAmount, ')..write('targetDate: $targetDate, ')..write('importance: $importance')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, name, description, amount, date, inflation, targetAmount, targetDate, importance);@override
bool operator ==(Object other) => identical(this, other) || (other is GoalDO && other.id == this.id && other.name == this.name && other.description == this.description && other.amount == this.amount && other.date == this.date && other.inflation == this.inflation && other.targetAmount == this.targetAmount && other.targetDate == this.targetDate && other.importance == this.importance);
}class GoalTableCompanion extends UpdateCompanion<GoalDO> {
final Value<int> id;
final Value<String> name;
final Value<String?> description;
final Value<double> amount;
final Value<DateTime> date;
final Value<double> inflation;
final Value<double> targetAmount;
final Value<DateTime> targetDate;
final Value<GoalImportance> importance;
const GoalTableCompanion({this.id = const Value.absent(),this.name = const Value.absent(),this.description = const Value.absent(),this.amount = const Value.absent(),this.date = const Value.absent(),this.inflation = const Value.absent(),this.targetAmount = const Value.absent(),this.targetDate = const Value.absent(),this.importance = const Value.absent(),});
GoalTableCompanion.insert({this.id = const Value.absent(),required String name,this.description = const Value.absent(),required double amount,required DateTime date,required double inflation,required double targetAmount,required DateTime targetDate,required GoalImportance importance,}): name = Value(name), amount = Value(amount), date = Value(date), inflation = Value(inflation), targetAmount = Value(targetAmount), targetDate = Value(targetDate), importance = Value(importance);
static Insertable<GoalDO> custom({Expression<int>? id, 
Expression<String>? name, 
Expression<String>? description, 
Expression<double>? amount, 
Expression<DateTime>? date, 
Expression<double>? inflation, 
Expression<double>? targetAmount, 
Expression<DateTime>? targetDate, 
Expression<String>? importance, 
}) {
return RawValuesInsertable({if (id != null)'ID': id,if (name != null)'NAME': name,if (description != null)'DESCRIPTION': description,if (amount != null)'AMOUNT': amount,if (date != null)'DATE': date,if (inflation != null)'INFLATION': inflation,if (targetAmount != null)'TARGET_AMOUNT': targetAmount,if (targetDate != null)'TARGET_DATE': targetDate,if (importance != null)'IMPORTANCE': importance,});
}GoalTableCompanion copyWith({Value<int>? id, Value<String>? name, Value<String?>? description, Value<double>? amount, Value<DateTime>? date, Value<double>? inflation, Value<double>? targetAmount, Value<DateTime>? targetDate, Value<GoalImportance>? importance}) {
return GoalTableCompanion(id: id ?? this.id,name: name ?? this.name,description: description ?? this.description,amount: amount ?? this.amount,date: date ?? this.date,inflation: inflation ?? this.inflation,targetAmount: targetAmount ?? this.targetAmount,targetDate: targetDate ?? this.targetDate,importance: importance ?? this.importance,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['ID'] = Variable<int>(id.value);}
if (name.present) {
map['NAME'] = Variable<String>(name.value);}
if (description.present) {
map['DESCRIPTION'] = Variable<String>(description.value);}
if (amount.present) {
map['AMOUNT'] = Variable<double>(amount.value);}
if (date.present) {
map['DATE'] = Variable<DateTime>(date.value);}
if (inflation.present) {
map['INFLATION'] = Variable<double>(inflation.value);}
if (targetAmount.present) {
map['TARGET_AMOUNT'] = Variable<double>(targetAmount.value);}
if (targetDate.present) {
map['TARGET_DATE'] = Variable<DateTime>(targetDate.value);}
if (importance.present) {
map['IMPORTANCE'] = Variable<String>($GoalTableTable.$converterimportance.toSql(importance.value));}
return map; 
}
@override
String toString() {return (StringBuffer('GoalTableCompanion(')..write('id: $id, ')..write('name: $name, ')..write('description: $description, ')..write('amount: $amount, ')..write('date: $date, ')..write('inflation: $inflation, ')..write('targetAmount: $targetAmount, ')..write('targetDate: $targetDate, ')..write('importance: $importance')..write(')')).toString();}
}
class $SipTableTable extends SipTable with TableInfo<$SipTableTable, SipDO>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$SipTableTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _investmentIdMeta = const VerificationMeta('investmentId');
@override
late final GeneratedColumn<int> investmentId = GeneratedColumn<int>('INVESTMENT_ID', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES investment_table (ID)'));
static const VerificationMeta _amountMeta = const VerificationMeta('amount');
@override
late final GeneratedColumn<double> amount = GeneratedColumn<double>('AMOUNT', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
@override
late final GeneratedColumn<String> description = GeneratedColumn<String>('DESCRIPTION', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _startDateMeta = const VerificationMeta('startDate');
@override
late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>('START_DATE', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _endDateMeta = const VerificationMeta('endDate');
@override
late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>('END_DATE', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _frequencyMeta = const VerificationMeta('frequency');
@override
late final GeneratedColumn<double> frequency = GeneratedColumn<double>('FREQUENCY', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, investmentId, amount, description, startDate, endDate, frequency];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'sip_table';
@override
VerificationContext validateIntegrity(Insertable<SipDO> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('ID')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));}if (data.containsKey('INVESTMENT_ID')) {
context.handle(_investmentIdMeta, investmentId.isAcceptableOrUnknown(data['INVESTMENT_ID']!, _investmentIdMeta));} else if (isInserting) {
context.missing(_investmentIdMeta);
}
if (data.containsKey('AMOUNT')) {
context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['AMOUNT']!, _amountMeta));} else if (isInserting) {
context.missing(_amountMeta);
}
if (data.containsKey('DESCRIPTION')) {
context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['DESCRIPTION']!, _descriptionMeta));}if (data.containsKey('START_DATE')) {
context.handle(_startDateMeta, startDate.isAcceptableOrUnknown(data['START_DATE']!, _startDateMeta));} else if (isInserting) {
context.missing(_startDateMeta);
}
if (data.containsKey('END_DATE')) {
context.handle(_endDateMeta, endDate.isAcceptableOrUnknown(data['END_DATE']!, _endDateMeta));} else if (isInserting) {
context.missing(_endDateMeta);
}
if (data.containsKey('FREQUENCY')) {
context.handle(_frequencyMeta, frequency.isAcceptableOrUnknown(data['FREQUENCY']!, _frequencyMeta));} else if (isInserting) {
context.missing(_frequencyMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override SipDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return SipDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, investmentId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!, amount: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}AMOUNT'])!, description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']), startDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}START_DATE'])!, endDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}END_DATE'])!, frequency: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}FREQUENCY'])!, );
}
@override
$SipTableTable createAlias(String alias) {
return $SipTableTable(attachedDatabase, alias);}}class SipDO extends DataClass implements Insertable<SipDO> {
final int id;
final int investmentId;
final double amount;
final String? description;
final DateTime startDate;
final DateTime endDate;
final double frequency;
const SipDO({required this.id, required this.investmentId, required this.amount, this.description, required this.startDate, required this.endDate, required this.frequency});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['ID'] = Variable<int>(id);
map['INVESTMENT_ID'] = Variable<int>(investmentId);
map['AMOUNT'] = Variable<double>(amount);
if (!nullToAbsent || description != null){map['DESCRIPTION'] = Variable<String>(description);
}map['START_DATE'] = Variable<DateTime>(startDate);
map['END_DATE'] = Variable<DateTime>(endDate);
map['FREQUENCY'] = Variable<double>(frequency);
return map; 
}
SipTableCompanion toCompanion(bool nullToAbsent) {
return SipTableCompanion(id: Value(id),investmentId: Value(investmentId),amount: Value(amount),description: description == null && nullToAbsent ? const Value.absent() : Value(description),startDate: Value(startDate),endDate: Value(endDate),frequency: Value(frequency),);
}
factory SipDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return SipDO(id: serializer.fromJson<int>(json['id']),investmentId: serializer.fromJson<int>(json['investmentId']),amount: serializer.fromJson<double>(json['amount']),description: serializer.fromJson<String?>(json['description']),startDate: serializer.fromJson<DateTime>(json['startDate']),endDate: serializer.fromJson<DateTime>(json['endDate']),frequency: serializer.fromJson<double>(json['frequency']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'investmentId': serializer.toJson<int>(investmentId),'amount': serializer.toJson<double>(amount),'description': serializer.toJson<String?>(description),'startDate': serializer.toJson<DateTime>(startDate),'endDate': serializer.toJson<DateTime>(endDate),'frequency': serializer.toJson<double>(frequency),};}SipDO copyWith({int? id,int? investmentId,double? amount,Value<String?> description = const Value.absent(),DateTime? startDate,DateTime? endDate,double? frequency}) => SipDO(id: id ?? this.id,investmentId: investmentId ?? this.investmentId,amount: amount ?? this.amount,description: description.present ? description.value : this.description,startDate: startDate ?? this.startDate,endDate: endDate ?? this.endDate,frequency: frequency ?? this.frequency,);@override
String toString() {return (StringBuffer('SipDO(')..write('id: $id, ')..write('investmentId: $investmentId, ')..write('amount: $amount, ')..write('description: $description, ')..write('startDate: $startDate, ')..write('endDate: $endDate, ')..write('frequency: $frequency')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, investmentId, amount, description, startDate, endDate, frequency);@override
bool operator ==(Object other) => identical(this, other) || (other is SipDO && other.id == this.id && other.investmentId == this.investmentId && other.amount == this.amount && other.description == this.description && other.startDate == this.startDate && other.endDate == this.endDate && other.frequency == this.frequency);
}class SipTableCompanion extends UpdateCompanion<SipDO> {
final Value<int> id;
final Value<int> investmentId;
final Value<double> amount;
final Value<String?> description;
final Value<DateTime> startDate;
final Value<DateTime> endDate;
final Value<double> frequency;
const SipTableCompanion({this.id = const Value.absent(),this.investmentId = const Value.absent(),this.amount = const Value.absent(),this.description = const Value.absent(),this.startDate = const Value.absent(),this.endDate = const Value.absent(),this.frequency = const Value.absent(),});
SipTableCompanion.insert({this.id = const Value.absent(),required int investmentId,required double amount,this.description = const Value.absent(),required DateTime startDate,required DateTime endDate,required double frequency,}): investmentId = Value(investmentId), amount = Value(amount), startDate = Value(startDate), endDate = Value(endDate), frequency = Value(frequency);
static Insertable<SipDO> custom({Expression<int>? id, 
Expression<int>? investmentId, 
Expression<double>? amount, 
Expression<String>? description, 
Expression<DateTime>? startDate, 
Expression<DateTime>? endDate, 
Expression<double>? frequency, 
}) {
return RawValuesInsertable({if (id != null)'ID': id,if (investmentId != null)'INVESTMENT_ID': investmentId,if (amount != null)'AMOUNT': amount,if (description != null)'DESCRIPTION': description,if (startDate != null)'START_DATE': startDate,if (endDate != null)'END_DATE': endDate,if (frequency != null)'FREQUENCY': frequency,});
}SipTableCompanion copyWith({Value<int>? id, Value<int>? investmentId, Value<double>? amount, Value<String?>? description, Value<DateTime>? startDate, Value<DateTime>? endDate, Value<double>? frequency}) {
return SipTableCompanion(id: id ?? this.id,investmentId: investmentId ?? this.investmentId,amount: amount ?? this.amount,description: description ?? this.description,startDate: startDate ?? this.startDate,endDate: endDate ?? this.endDate,frequency: frequency ?? this.frequency,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['ID'] = Variable<int>(id.value);}
if (investmentId.present) {
map['INVESTMENT_ID'] = Variable<int>(investmentId.value);}
if (amount.present) {
map['AMOUNT'] = Variable<double>(amount.value);}
if (description.present) {
map['DESCRIPTION'] = Variable<String>(description.value);}
if (startDate.present) {
map['START_DATE'] = Variable<DateTime>(startDate.value);}
if (endDate.present) {
map['END_DATE'] = Variable<DateTime>(endDate.value);}
if (frequency.present) {
map['FREQUENCY'] = Variable<double>(frequency.value);}
return map; 
}
@override
String toString() {return (StringBuffer('SipTableCompanion(')..write('id: $id, ')..write('investmentId: $investmentId, ')..write('amount: $amount, ')..write('description: $description, ')..write('startDate: $startDate, ')..write('endDate: $endDate, ')..write('frequency: $frequency')..write(')')).toString();}
}
class $GoalInvestmentTableTable extends GoalInvestmentTable with TableInfo<$GoalInvestmentTableTable, GoalInvestmentMappingDO>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$GoalInvestmentTableTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
@override
late final GeneratedColumn<int> goalId = GeneratedColumn<int>('GOAL_ID', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES goal_table (ID)'));
static const VerificationMeta _investmentIdMeta = const VerificationMeta('investmentId');
@override
late final GeneratedColumn<int> investmentId = GeneratedColumn<int>('INVESTMENT_ID', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES goal_table (ID)'));
static const VerificationMeta _sharePercentageMeta = const VerificationMeta('sharePercentage');
@override
late final GeneratedColumn<double> sharePercentage = GeneratedColumn<double>('SHARE_PERCENTAGE', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, goalId, investmentId, sharePercentage];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'goal_investment_table';
@override
VerificationContext validateIntegrity(Insertable<GoalInvestmentMappingDO> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('ID')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));}if (data.containsKey('GOAL_ID')) {
context.handle(_goalIdMeta, goalId.isAcceptableOrUnknown(data['GOAL_ID']!, _goalIdMeta));} else if (isInserting) {
context.missing(_goalIdMeta);
}
if (data.containsKey('INVESTMENT_ID')) {
context.handle(_investmentIdMeta, investmentId.isAcceptableOrUnknown(data['INVESTMENT_ID']!, _investmentIdMeta));} else if (isInserting) {
context.missing(_investmentIdMeta);
}
if (data.containsKey('SHARE_PERCENTAGE')) {
context.handle(_sharePercentageMeta, sharePercentage.isAcceptableOrUnknown(data['SHARE_PERCENTAGE']!, _sharePercentageMeta));} else if (isInserting) {
context.missing(_sharePercentageMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override GoalInvestmentMappingDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return GoalInvestmentMappingDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, goalId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}GOAL_ID'])!, investmentId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!, sharePercentage: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}SHARE_PERCENTAGE'])!, );
}
@override
$GoalInvestmentTableTable createAlias(String alias) {
return $GoalInvestmentTableTable(attachedDatabase, alias);}}class GoalInvestmentMappingDO extends DataClass implements Insertable<GoalInvestmentMappingDO> {
final int id;
final int goalId;
final int investmentId;
final double sharePercentage;
const GoalInvestmentMappingDO({required this.id, required this.goalId, required this.investmentId, required this.sharePercentage});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['ID'] = Variable<int>(id);
map['GOAL_ID'] = Variable<int>(goalId);
map['INVESTMENT_ID'] = Variable<int>(investmentId);
map['SHARE_PERCENTAGE'] = Variable<double>(sharePercentage);
return map; 
}
GoalInvestmentTableCompanion toCompanion(bool nullToAbsent) {
return GoalInvestmentTableCompanion(id: Value(id),goalId: Value(goalId),investmentId: Value(investmentId),sharePercentage: Value(sharePercentage),);
}
factory GoalInvestmentMappingDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return GoalInvestmentMappingDO(id: serializer.fromJson<int>(json['id']),goalId: serializer.fromJson<int>(json['goalId']),investmentId: serializer.fromJson<int>(json['investmentId']),sharePercentage: serializer.fromJson<double>(json['sharePercentage']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'goalId': serializer.toJson<int>(goalId),'investmentId': serializer.toJson<int>(investmentId),'sharePercentage': serializer.toJson<double>(sharePercentage),};}GoalInvestmentMappingDO copyWith({int? id,int? goalId,int? investmentId,double? sharePercentage}) => GoalInvestmentMappingDO(id: id ?? this.id,goalId: goalId ?? this.goalId,investmentId: investmentId ?? this.investmentId,sharePercentage: sharePercentage ?? this.sharePercentage,);@override
String toString() {return (StringBuffer('GoalInvestmentMappingDO(')..write('id: $id, ')..write('goalId: $goalId, ')..write('investmentId: $investmentId, ')..write('sharePercentage: $sharePercentage')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, goalId, investmentId, sharePercentage);@override
bool operator ==(Object other) => identical(this, other) || (other is GoalInvestmentMappingDO && other.id == this.id && other.goalId == this.goalId && other.investmentId == this.investmentId && other.sharePercentage == this.sharePercentage);
}class GoalInvestmentTableCompanion extends UpdateCompanion<GoalInvestmentMappingDO> {
final Value<int> id;
final Value<int> goalId;
final Value<int> investmentId;
final Value<double> sharePercentage;
const GoalInvestmentTableCompanion({this.id = const Value.absent(),this.goalId = const Value.absent(),this.investmentId = const Value.absent(),this.sharePercentage = const Value.absent(),});
GoalInvestmentTableCompanion.insert({this.id = const Value.absent(),required int goalId,required int investmentId,required double sharePercentage,}): goalId = Value(goalId), investmentId = Value(investmentId), sharePercentage = Value(sharePercentage);
static Insertable<GoalInvestmentMappingDO> custom({Expression<int>? id, 
Expression<int>? goalId, 
Expression<int>? investmentId, 
Expression<double>? sharePercentage, 
}) {
return RawValuesInsertable({if (id != null)'ID': id,if (goalId != null)'GOAL_ID': goalId,if (investmentId != null)'INVESTMENT_ID': investmentId,if (sharePercentage != null)'SHARE_PERCENTAGE': sharePercentage,});
}GoalInvestmentTableCompanion copyWith({Value<int>? id, Value<int>? goalId, Value<int>? investmentId, Value<double>? sharePercentage}) {
return GoalInvestmentTableCompanion(id: id ?? this.id,goalId: goalId ?? this.goalId,investmentId: investmentId ?? this.investmentId,sharePercentage: sharePercentage ?? this.sharePercentage,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['ID'] = Variable<int>(id.value);}
if (goalId.present) {
map['GOAL_ID'] = Variable<int>(goalId.value);}
if (investmentId.present) {
map['INVESTMENT_ID'] = Variable<int>(investmentId.value);}
if (sharePercentage.present) {
map['SHARE_PERCENTAGE'] = Variable<double>(sharePercentage.value);}
return map; 
}
@override
String toString() {return (StringBuffer('GoalInvestmentTableCompanion(')..write('id: $id, ')..write('goalId: $goalId, ')..write('investmentId: $investmentId, ')..write('sharePercentage: $sharePercentage')..write(')')).toString();}
}
class InvestmentEnrichedDO extends DataClass {
final int id;
final String name;
final String? description;
final RiskLevel riskLevel;
final double value;
final DateTime valueUpdatedOn;
final int? basketId;
final String? basketName;
final double? totalInvestedAmount;
final int? totalTransactions;
const InvestmentEnrichedDO({required this.id, required this.name, this.description, required this.riskLevel, required this.value, required this.valueUpdatedOn, this.basketId, this.basketName, this.totalInvestedAmount, this.totalTransactions});factory InvestmentEnrichedDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return InvestmentEnrichedDO(id: serializer.fromJson<int>(json['id']),name: serializer.fromJson<String>(json['name']),description: serializer.fromJson<String?>(json['description']),riskLevel: $InvestmentTableTable.$converterriskLevel.fromJson(serializer.fromJson<String>(json['riskLevel'])),value: serializer.fromJson<double>(json['value']),valueUpdatedOn: serializer.fromJson<DateTime>(json['valueUpdatedOn']),basketId: serializer.fromJson<int?>(json['basketId']),basketName: serializer.fromJson<String?>(json['basketName']),totalInvestedAmount: serializer.fromJson<double?>(json['totalInvestedAmount']),totalTransactions: serializer.fromJson<int?>(json['totalTransactions']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'name': serializer.toJson<String>(name),'description': serializer.toJson<String?>(description),'riskLevel': serializer.toJson<String>($InvestmentTableTable.$converterriskLevel.toJson(riskLevel)),'value': serializer.toJson<double>(value),'valueUpdatedOn': serializer.toJson<DateTime>(valueUpdatedOn),'basketId': serializer.toJson<int?>(basketId),'basketName': serializer.toJson<String?>(basketName),'totalInvestedAmount': serializer.toJson<double?>(totalInvestedAmount),'totalTransactions': serializer.toJson<int?>(totalTransactions),};}InvestmentEnrichedDO copyWith({int? id,String? name,Value<String?> description = const Value.absent(),RiskLevel? riskLevel,double? value,DateTime? valueUpdatedOn,Value<int?> basketId = const Value.absent(),Value<String?> basketName = const Value.absent(),Value<double?> totalInvestedAmount = const Value.absent(),Value<int?> totalTransactions = const Value.absent()}) => InvestmentEnrichedDO(id: id ?? this.id,name: name ?? this.name,description: description.present ? description.value : this.description,riskLevel: riskLevel ?? this.riskLevel,value: value ?? this.value,valueUpdatedOn: valueUpdatedOn ?? this.valueUpdatedOn,basketId: basketId.present ? basketId.value : this.basketId,basketName: basketName.present ? basketName.value : this.basketName,totalInvestedAmount: totalInvestedAmount.present ? totalInvestedAmount.value : this.totalInvestedAmount,totalTransactions: totalTransactions.present ? totalTransactions.value : this.totalTransactions,);@override
String toString() {return (StringBuffer('InvestmentEnrichedDO(')..write('id: $id, ')..write('name: $name, ')..write('description: $description, ')..write('riskLevel: $riskLevel, ')..write('value: $value, ')..write('valueUpdatedOn: $valueUpdatedOn, ')..write('basketId: $basketId, ')..write('basketName: $basketName, ')..write('totalInvestedAmount: $totalInvestedAmount, ')..write('totalTransactions: $totalTransactions')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, name, description, riskLevel, value, valueUpdatedOn, basketId, basketName, totalInvestedAmount, totalTransactions);@override
bool operator ==(Object other) => identical(this, other) || (other is InvestmentEnrichedDO && other.id == this.id && other.name == this.name && other.description == this.description && other.riskLevel == this.riskLevel && other.value == this.value && other.valueUpdatedOn == this.valueUpdatedOn && other.basketId == this.basketId && other.basketName == this.basketName && other.totalInvestedAmount == this.totalInvestedAmount && other.totalTransactions == this.totalTransactions);
}class $InvestmentEnrichedViewView extends ViewInfo<$InvestmentEnrichedViewView, InvestmentEnrichedDO> implements HasResultSet {
final String? _alias;
@override final _$AppDatabase attachedDatabase;
$InvestmentEnrichedViewView(this.attachedDatabase, [this._alias]);
$InvestmentTableTable get investment => attachedDatabase.investmentTable.createAlias('t0');
$BasketTableTable get basket => attachedDatabase.basketTable.createAlias('t1');
$TransactionTableTable get transaction => attachedDatabase.transactionTable.createAlias('t2');
@override
List<GeneratedColumn> get $columns => [id, name, description, riskLevel, value, valueUpdatedOn, basketId, basketName, totalInvestedAmount, totalTransactions];
@override
String get aliasedName => _alias ?? entityName;
@override
 String get entityName=> 'investment_enriched_view';
@override
Map<SqlDialect, String>?get createViewStatements => null;
@override
$InvestmentEnrichedViewView get asDslTable => this;
@override InvestmentEnrichedDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return InvestmentEnrichedDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}NAME'])!, description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION']), riskLevel: $InvestmentTableTable.$converterriskLevel.fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}RISK_LEVEL'])!), value: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}VALUE'])!, valueUpdatedOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}VALUE_UPDATED_ON'])!, basketId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}basket_id']), basketName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}basket_name']), totalInvestedAmount: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_invested_amount']), totalTransactions: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total_transactions']), );
}
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, generatedAs: GeneratedAs(investment.id, false), type: DriftSqlType.int);
late final GeneratedColumn<String> name = GeneratedColumn<String>('NAME', aliasedName, false, generatedAs: GeneratedAs(investment.name, false), type: DriftSqlType.string);
late final GeneratedColumn<String> description = GeneratedColumn<String>('DESCRIPTION', aliasedName, true, generatedAs: GeneratedAs(investment.description, false), type: DriftSqlType.string);
late final GeneratedColumnWithTypeConverter<RiskLevel, String> riskLevel = GeneratedColumn<String>('RISK_LEVEL', aliasedName, false, generatedAs: GeneratedAs(investment.riskLevel, false), type: DriftSqlType.string).withConverter<RiskLevel>($InvestmentTableTable.$converterriskLevel);
late final GeneratedColumn<double> value = GeneratedColumn<double>('VALUE', aliasedName, false, generatedAs: GeneratedAs(investment.value, false), type: DriftSqlType.double);
late final GeneratedColumn<DateTime> valueUpdatedOn = GeneratedColumn<DateTime>('VALUE_UPDATED_ON', aliasedName, false, generatedAs: GeneratedAs(investment.valueUpdatedOn, false), type: DriftSqlType.dateTime);
late final GeneratedColumn<int> basketId = GeneratedColumn<int>('basket_id', aliasedName, true, generatedAs: GeneratedAs(basket.id, false), type: DriftSqlType.int);
late final GeneratedColumn<String> basketName = GeneratedColumn<String>('basket_name', aliasedName, true, generatedAs: GeneratedAs(basket.name, false), type: DriftSqlType.string);
late final GeneratedColumn<double> totalInvestedAmount = GeneratedColumn<double>('total_invested_amount', aliasedName, true, generatedAs: GeneratedAs(transaction.amount.sum(), false), type: DriftSqlType.double);
late final GeneratedColumn<int> totalTransactions = GeneratedColumn<int>('total_transactions', aliasedName, true, generatedAs: GeneratedAs(transaction.id.count(), false), type: DriftSqlType.int);
@override
$InvestmentEnrichedViewView createAlias(String alias) {
return $InvestmentEnrichedViewView(attachedDatabase, alias);}@override
Query? get query => (attachedDatabase.selectOnly(investment)..addColumns($columns)).join([ innerJoin(basket,basket.id.equalsExp(investment.basketId)), leftOuterJoin(transaction,transaction.investmentId.equalsExp(investment.id)) ]) ..groupBy([investment.id]);
      @override
      Set<String> get readTables => const {'investment_table', 'basket_table', 'transaction_table'};
    
}
class GoalInvestmentEnrichedMappingDO extends DataClass {
final int id;
final int goalId;
final int investmentId;
final double sharePercentage;
final String? goalName;
final String? investmentName;
const GoalInvestmentEnrichedMappingDO({required this.id, required this.goalId, required this.investmentId, required this.sharePercentage, this.goalName, this.investmentName});factory GoalInvestmentEnrichedMappingDO.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return GoalInvestmentEnrichedMappingDO(id: serializer.fromJson<int>(json['id']),goalId: serializer.fromJson<int>(json['goalId']),investmentId: serializer.fromJson<int>(json['investmentId']),sharePercentage: serializer.fromJson<double>(json['sharePercentage']),goalName: serializer.fromJson<String?>(json['goalName']),investmentName: serializer.fromJson<String?>(json['investmentName']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'goalId': serializer.toJson<int>(goalId),'investmentId': serializer.toJson<int>(investmentId),'sharePercentage': serializer.toJson<double>(sharePercentage),'goalName': serializer.toJson<String?>(goalName),'investmentName': serializer.toJson<String?>(investmentName),};}GoalInvestmentEnrichedMappingDO copyWith({int? id,int? goalId,int? investmentId,double? sharePercentage,Value<String?> goalName = const Value.absent(),Value<String?> investmentName = const Value.absent()}) => GoalInvestmentEnrichedMappingDO(id: id ?? this.id,goalId: goalId ?? this.goalId,investmentId: investmentId ?? this.investmentId,sharePercentage: sharePercentage ?? this.sharePercentage,goalName: goalName.present ? goalName.value : this.goalName,investmentName: investmentName.present ? investmentName.value : this.investmentName,);@override
String toString() {return (StringBuffer('GoalInvestmentEnrichedMappingDO(')..write('id: $id, ')..write('goalId: $goalId, ')..write('investmentId: $investmentId, ')..write('sharePercentage: $sharePercentage, ')..write('goalName: $goalName, ')..write('investmentName: $investmentName')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, goalId, investmentId, sharePercentage, goalName, investmentName);@override
bool operator ==(Object other) => identical(this, other) || (other is GoalInvestmentEnrichedMappingDO && other.id == this.id && other.goalId == this.goalId && other.investmentId == this.investmentId && other.sharePercentage == this.sharePercentage && other.goalName == this.goalName && other.investmentName == this.investmentName);
}class $GoalInvestmentEnrichedMappingViewView extends ViewInfo<$GoalInvestmentEnrichedMappingViewView, GoalInvestmentEnrichedMappingDO> implements HasResultSet {
final String? _alias;
@override final _$AppDatabase attachedDatabase;
$GoalInvestmentEnrichedMappingViewView(this.attachedDatabase, [this._alias]);
$GoalInvestmentTableTable get goalInvestment => attachedDatabase.goalInvestmentTable.createAlias('t0');
$GoalTableTable get goal => attachedDatabase.goalTable.createAlias('t1');
$InvestmentTableTable get investment => attachedDatabase.investmentTable.createAlias('t2');
@override
List<GeneratedColumn> get $columns => [id, goalId, investmentId, sharePercentage, goalName, investmentName];
@override
String get aliasedName => _alias ?? entityName;
@override
 String get entityName=> 'goal_investment_enriched_mapping_view';
@override
Map<SqlDialect, String>?get createViewStatements => null;
@override
$GoalInvestmentEnrichedMappingViewView get asDslTable => this;
@override GoalInvestmentEnrichedMappingDO map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return GoalInvestmentEnrichedMappingDO(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ID'])!, goalId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}GOAL_ID'])!, investmentId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}INVESTMENT_ID'])!, sharePercentage: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}SHARE_PERCENTAGE'])!, goalName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}goal_name']), investmentName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}investment_name']), );
}
late final GeneratedColumn<int> id = GeneratedColumn<int>('ID', aliasedName, false, generatedAs: GeneratedAs(goalInvestment.id, false), type: DriftSqlType.int);
late final GeneratedColumn<int> goalId = GeneratedColumn<int>('GOAL_ID', aliasedName, false, generatedAs: GeneratedAs(goalInvestment.goalId, false), type: DriftSqlType.int);
late final GeneratedColumn<int> investmentId = GeneratedColumn<int>('INVESTMENT_ID', aliasedName, false, generatedAs: GeneratedAs(goalInvestment.investmentId, false), type: DriftSqlType.int);
late final GeneratedColumn<double> sharePercentage = GeneratedColumn<double>('SHARE_PERCENTAGE', aliasedName, false, generatedAs: GeneratedAs(goalInvestment.sharePercentage, false), type: DriftSqlType.double);
late final GeneratedColumn<String> goalName = GeneratedColumn<String>('goal_name', aliasedName, true, generatedAs: GeneratedAs(goal.name, false), type: DriftSqlType.string);
late final GeneratedColumn<String> investmentName = GeneratedColumn<String>('investment_name', aliasedName, true, generatedAs: GeneratedAs(investment.name, false), type: DriftSqlType.string);
@override
$GoalInvestmentEnrichedMappingViewView createAlias(String alias) {
return $GoalInvestmentEnrichedMappingViewView(attachedDatabase, alias);}@override
Query? get query => (attachedDatabase.selectOnly(goalInvestment)..addColumns($columns)).join([ innerJoin(goal,goal.id.equalsExp(goalInvestment.goalId)), innerJoin(investment,investment.id.equalsExp(goalInvestment.investmentId)) ]);
      @override
      Set<String> get readTables => const {'goal_investment_table', 'goal_table', 'investment_table'};
    
}
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
late final $BasketTableTable basketTable = $BasketTableTable(this);
late final $InvestmentTableTable investmentTable = $InvestmentTableTable(this);
late final $TransactionTableTable transactionTable = $TransactionTableTable(this);
late final $GoalTableTable goalTable = $GoalTableTable(this);
late final $SipTableTable sipTable = $SipTableTable(this);
late final $GoalInvestmentTableTable goalInvestmentTable = $GoalInvestmentTableTable(this);
late final $InvestmentEnrichedViewView investmentEnrichedView = $InvestmentEnrichedViewView(this);
late final $GoalInvestmentEnrichedMappingViewView goalInvestmentEnrichedMappingView = $GoalInvestmentEnrichedMappingViewView(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [basketTable, investmentTable, transactionTable, goalTable, sipTable, goalInvestmentTable, investmentEnrichedView, goalInvestmentEnrichedMappingView];
}
