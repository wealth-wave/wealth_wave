import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';

part 'app_database.g.dart';

@DataClassName('BasketDO')
class BasketTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME').unique()();
}

@DataClassName('InvestmentDO')
class InvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME')();

  IntColumn get basketId =>
      integer().nullable().named('BASKET_ID').references(BasketTable, #id)();

  RealColumn get value => real().named('VALUE')();

  TextColumn get riskLevel => textEnum<RiskLevel>().named('RISK_LEVEL')();

  DateTimeColumn get valueUpdatedOn => dateTime().named('VALUE_UPDATED_ON')();
}

@DataClassName('TransactionDO')
class TransactionTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(InvestmentTable, #id)();

  RealColumn get amount => real().named('AMOUNT')();

  DateTimeColumn get amountInvestedOn =>
      dateTime().named('AMOUNT_INVESTED_ON')();
}

@DataClassName('GoalDO')
class GoalTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME')();

  RealColumn get amount => real().named('AMOUNT')();

  DateTimeColumn get date => dateTime().named('DATE')();

  RealColumn get inflation => real().named('INFLATION')();

  RealColumn get targetAmount => real().named('TARGET_AMOUNT')();

  DateTimeColumn get targetDate => dateTime().named('TARGET_DATE')();

  TextColumn get importance => textEnum<GoalImportance>().named('IMPORTANCE')();
}

@DataClassName('GoalInvestmentMappingDO')
class GoalInvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  IntColumn get goalId =>
      integer().named('GOAL_ID').references(GoalTable, #id)();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(GoalTable, #id)();

  RealColumn get sharePercentage => real().named('SHARE_PERCENTAGE')();
}

@DataClassName('InvestmentEnrichedDO')
abstract class InvestmentEnrichedView extends View {
  InvestmentTable get investment;
  BasketTable get basket;
  TransactionTable get transaction;

  Expression<int> get basketId => basket.id;
  Expression<String> get basketName => basket.name;
  Expression<double> get totalInvestedAmount => transaction.amount.sum();
  Expression<int> get totalTransactions => transaction.id.count();

  @override
  Query as() => select([
        investment.id,
        investment.name,
        investment.riskLevel,
        investment.value,
        investment.valueUpdatedOn,
        basketId,
        basketName,
        totalInvestedAmount,
        totalTransactions,
      ]).from(investment).join([
        innerJoin(basket, basket.id.equalsExp(investment.basketId)),
        leftOuterJoin(
            transaction, transaction.investmentId.equalsExp(investment.id)),
      ])
        ..groupBy([investment.id]);
}

@DataClassName('GoalInvestmentEnrichedMappingDO')
abstract class GoalInvestmentEnrichedMappingView extends View {
  GoalInvestmentTable get goalInvestment;
  GoalTable get goal;
  InvestmentTable get investment;

  Expression<String> get goalName => goal.name;
  Expression<String> get investmentName => investment.name;

  @override
  Query as() => select([
        goalInvestment.id,
        goalInvestment.goalId,
        goalInvestment.investmentId,
        goalInvestment.sharePercentage,
        goalName,
        investmentName
      ]).from(goalInvestment).join([
        innerJoin(goal, goal.id.equalsExp(goalInvestment.goalId)),
        innerJoin(
            investment, investment.id.equalsExp(goalInvestment.investmentId)),
      ]);
}

@DriftDatabase(tables: [
  BasketTable,
  InvestmentTable,
  TransactionTable,
  GoalTable,
  GoalInvestmentTable,
], views: [
  InvestmentEnrichedView,
  GoalInvestmentEnrichedMappingView,
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
    final goalInvestmentBackup =
        await executor.runSelect('SELECT * FROM goal_investment_table', []);

    return {
      'basket_table': basketBackup,
      'investment_table': investmentBackup,
      'transaction_table': transactionBackup,
      'goal_table': goalBackup,
      'goal_investment_table': goalInvestmentBackup,
    };
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
