import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';

part 'app_database.g.dart';

@DataClassName('BasketDO')
class BasketTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name =>
      text().named('NAME').check(name.isNotValue('')).unique()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();
}

@DataClassName('BaseInvestmentDO')
class InvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name =>
      text().named('NAME').check(name.isNotValue('')).unique()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();

  IntColumn get basketId =>
      integer().nullable().named('BASKET_ID').references(BasketTable, #id)();

  RealColumn get value => real().nullable().named('VALUE')();

  DateTimeColumn get valueUpdatedOn =>
      dateTime().nullable().named('VALUE_UPDATED_ON')();

  RealColumn get irr => real().nullable().named('IRR')();

  DateTimeColumn get maturityDate =>
      dateTime().nullable().named('MATURITY_DATE')();

  TextColumn get riskLevel => textEnum<RiskLevel>().named('RISK_LEVEL')();
}

@DataClassName('TransactionDO')
class TransactionTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(InvestmentTable, #id)();

  IntColumn get sipId =>
      integer().nullable().named('SIP_ID').references(SipTable, #id)();

  RealColumn get amount =>
      real().named('AMOUNT').check(amount.isNotValue(0))();

  RealColumn get qty => real().named('QTY').withDefault(const Constant(0))();

  DateTimeColumn get createdOn => dateTime().named('CREATED_ON')();
}

@DataClassName('SipDO')
class SipTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(InvestmentTable, #id)();

  RealColumn get amount => real().named('AMOUNT')();

  DateTimeColumn get startDate => dateTime().named('START_DATE')();

  DateTimeColumn get endDate => dateTime()
      .nullable()
      .check(endDate.isNull() | endDate.isBiggerThan(startDate))
      .named('END_DATE')();

  TextColumn get frequency => textEnum<Frequency>().named('FREQUENCY')();

  DateTimeColumn get executedTill =>
      dateTime().nullable().named('EXECUTED_TILL')();
}

@DataClassName('ScriptDO')
class ScriptTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get script => text().named('SCRIPT')();

  IntColumn get investmentId => integer()
      .named('INVESTMENT_ID')
      .references(InvestmentTable, #id)
      .unique()();
}

@DataClassName('BaseGoalDO')
class GoalTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME').unique()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();

  RealColumn get amount =>
      real().named('AMOUNT').check(amount.isBiggerThanValue(0))();

  DateTimeColumn get amountUpdatedOn => dateTime().named('AMOUNT_UPDATED_ON')();

  RealColumn get inflation =>
      real().named('INFLATION').check(inflation.isBetweenValues(1, 100))();

  DateTimeColumn get maturityDate => dateTime()
      .named('MATURITY_DATE')();

  TextColumn get importance => textEnum<GoalImportance>().named('IMPORTANCE')();
}

@DataClassName('BaseGoalInvestmentDO')
class GoalInvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  IntColumn get goalId =>
      integer().named('GOAL_ID').references(GoalTable, #id)();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(InvestmentTable, #id)();

  RealColumn get splitPercentage => real().named('SPLIT_PERCENTAGE').check(
      splitPercentage.isBiggerThanValue(0) |
          splitPercentage.isSmallerOrEqualValue(100))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {goalId, investmentId}
      ];
}

@DataClassName('InvestmentDO')
abstract class InvestmentEnrichedView extends View {
  InvestmentTable get investment;

  BasketTable get basket;

  TransactionTable get transaction;

  SipTable get sip;

  ScriptTable get script;

  Expression<int> get basketId => basket.id;

  Expression<String> get basketName => basket.name;

  Expression<int> get totalTransactions => transaction.id.count(
      distinct: true,
      filter: transaction.investmentId.equalsExp(investment.id));

  Expression<double> get qty => transaction.qty
      .sum(filter: transaction.investmentId.equalsExp(investment.id));

  Expression<int> get totalSips => sip.id
      .count(distinct: true, filter: sip.investmentId.equalsExp(investment.id));
  
  @override
  Query as() => select([
        investment.id,
        investment.name,
        investment.description,
        investment.riskLevel,
        investment.maturityDate,
        investment.irr,
        investment.value,
        investment.valueUpdatedOn,
        basketId,
        basketName,
        totalTransactions,
        totalSips,
        qty
      ]).from(investment).join([
        leftOuterJoin(basket, basket.id.equalsExp(investment.basketId)),
        leftOuterJoin(
            transaction, transaction.investmentId.equalsExp(investment.id)),
        leftOuterJoin(sip, sip.investmentId.equalsExp(investment.id)),
        leftOuterJoin(script,
            script.investmentId.equalsExp(investment.id))
      ])
        ..groupBy([investment.id]);
}

@DataClassName('GoalDO')
abstract class GoalEnrichedView extends View {
  GoalTable get goal;

  GoalInvestmentTable get goalInvestment;

  Expression<int> get taggedInvestmentCount => goalInvestment.investmentId
      .count(distinct: true, filter: goalInvestment.goalId.equalsExp(goal.id));

  @override
  Query as() => select([
        goal.id,
        goal.name,
        goal.description,
        goal.importance,
        goal.maturityDate,
        goal.amount,
        goal.inflation,
        goal.amountUpdatedOn,
        taggedInvestmentCount
      ]).from(goal).join([
        leftOuterJoin(goalInvestment, goalInvestment.goalId.equalsExp(goal.id)),
      ])
        ..groupBy([goal.id]);
}

@DataClassName('GoalInvestmentDO')
abstract class GoalInvestmentEnrichedView extends View {
  GoalInvestmentTable get goalInvestment;

  InvestmentTable get investment;

  GoalTable get goal;

  Expression<String> get investmentName => investment.name;

  Expression<String> get goalName => goal.name;

  Expression<DateTime> get maturityDate => goal.maturityDate;

  @override
  Query as() => select([
        goalInvestment.id,
        goalInvestment.investmentId,
        goalInvestment.goalId,
        goalInvestment.splitPercentage,
        investmentName,
        goalName,
        maturityDate
      ]).from(goalInvestment).join([
        innerJoin(
            investment, investment.id.equalsExp(goalInvestment.investmentId)),
        innerJoin(goal, goal.id.equalsExp(goalInvestment.goalId)),
      ])
        ..groupBy([goalInvestment.id]);
}

@DataClassName('ExpenseDO')
class ExpenseTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();

  RealColumn get amount => real().named('AMOUNT')();

  TextColumn get tags => text().named('TAGS')();

  DateTimeColumn get createdOn =>
      dateTime().named('CREATED_ON')();
}

@DataClassName('AggregatedExpenseDO')
class AggregatedExpenseTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  RealColumn get amount => real().named('AMOUNT')();
  TextColumn get tags => text().named('TAGS')();

  DateTimeColumn get month => dateTime().named('MONTH')();
}

@DataClassName('ExpenseTagDO')
class ExpenseTagTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name =>
      text().named('NAME').check(name.isNotValue('')).unique()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();
}

@DriftDatabase(tables: [
  BasketTable,
  InvestmentTable,
  TransactionTable,
  GoalTable,
  SipTable,
  GoalInvestmentTable,
  ScriptTable,
  ExpenseTable,
  ExpenseTagTable,
  AggregatedExpenseTable
], views: [
  InvestmentEnrichedView,
  GoalInvestmentEnrichedView,
  GoalEnrichedView
])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  static AppDatabase get instance {
    return _instance ??= AppDatabase._(connectOnWeb());
  }

  AppDatabase._(super.e);

  @override
  int get schemaVersion => 1;

  Future<Map<String, List<Map<String, dynamic>>>> getBackup() async {
    final basketBackup =
        await executor.runSelect('SELECT * FROM basket_table', []);
    final investmentBackup =
        await executor.runSelect('SELECT * FROM investment_table', []);
    final transactionBackup =
        await executor.runSelect('SELECT * FROM transaction_table', []);
    final goalBackup = await executor.runSelect('SELECT * FROM goal_table', []);
    final sipBackup = await executor.runSelect('SELECT * FROM sip_table', []);
    final goalInvestmentBackup =
        await executor.runSelect('SELECT * FROM goal_investment_table', []);
    final scriptBackup = await executor.runSelect('SELECT * FROM script_table', []);
    final expenseBackup = await executor.runSelect('SELECT * FROM expense_table', []);
    final expenseTagBackup = await executor.runSelect('SELECT * FROM expense_tag_table', []);
    final aggregatedExpenseBackup = await executor.runSelect('SELECT * FROM aggregated_expense_table', []);

    return {
      'basket_table': basketBackup,
      'investment_table': investmentBackup,
      'transaction_table': transactionBackup,
      'goal_table': goalBackup,
      'sip_table': sipBackup,
      'goal_investment_table': goalInvestmentBackup,
      'script_table': scriptBackup,
      'expense_table': expenseBackup,
      'expense_tag_table': expenseTagBackup,
      'aggregated_expense_table': aggregatedExpenseBackup,
    };
  }

  Future<void> loadBackup(
      Map<String, List<Map<String, dynamic>>> backup) async {
    await transaction(() async {
      for (var entry in backup.entries) {
        var tableName = entry.key;
        var tableDataList = entry.value;

        print("Updating table $tableName");
        for (var tableData in tableDataList) {
          print("Inserting $tableData");
          final String columnsString =
              tableData.keys.where((key) => tableData[key] != null).join(', ');
          final String valuesString = tableData.keys
              .where((key) => tableData[key] != null)
              .map((key) => '?')
              .join(', ');

          await customInsert(
            'INSERT INTO $tableName ($columnsString) VALUES ($valuesString)',
            variables:
                tableData.values.where((value) => value != null).map((value) {
              if (value is int) {
                return Variable.withInt(value);
              } else if (value is double) {
                return Variable.withReal(value);
              } else if (value is DateTime) {
                return Variable.withDateTime(value);
              } else if (value is String) {
                return Variable.withString(value);
              } else if (value is bool) {
                return Variable.withBool(value);
              } else {
                return Variable.withString("");
              }
            }).toList(),
          );
        }
      }
    });
  }
}

DatabaseConnection connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'wealth_wave_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      if (kDebugMode) {
        print('Using ${result.chosenImplementation} due to missing browser '
            'features: ${result.missingFeatures}');
      }
    }

    return result.resolvedExecutor;
  }));
}
