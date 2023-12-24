import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';

part 'app_database.g.dart';

@DataClassName('Basket')
class BasketTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME').unique()();
}

@DataClassName('Investment')
class InvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME')();

  IntColumn get basketId =>
      integer().nullable().named('BASKET_ID').references(BasketTable, #id)();

  RealColumn get value => real().named('VALUE')();

  TextColumn get riskLevel => textEnum<RiskLevel>().named('RISK_LEVEL')();

  DateTimeColumn get valueUpdatedOn => dateTime().named('VALUE_UPDATED_ON')();
}

@DataClassName('InvestmentTransaction')
class InvestmentTransactionTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(InvestmentTable, #id)();

  RealColumn get amount => real().named('AMOUNT')();

  DateTimeColumn get amountInvestedOn =>
      dateTime().named('AMOUNT_INVESTED_ON')();
}

@DataClassName('Goal')
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

@DataClassName('GoalInvestment')
class GoalInvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  IntColumn get goalId =>
      integer().named('GOAL_ID').references(GoalTable, #id)();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(GoalTable, #id)();

  RealColumn get sharePercentage => real().named('SHARE_PERCENTAGE')();
}

@DriftDatabase(tables: [
  BasketTable,
  InvestmentTable,
  InvestmentTransactionTable,
  GoalTable,
  GoalInvestmentTable,
])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  static AppDatabase get instance {
    return _instance ??= AppDatabase._(connectOnWeb());
  }

  AppDatabase._(super.e);

  @override
  int get schemaVersion => 1;
}

DatabaseConnection connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName:
          'wealth_wave_db1', // prefer to only use valid identifiers here
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
