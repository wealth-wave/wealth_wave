import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:wealth_wave/contract/risk_profile_type.dart';

part 'app_database.g.dart';

@DataClassName('BASKET')
class BasketTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get name => text().named('NAME').unique()();
}

@DataClassName('INVESTMENT')
class InvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get name => text().named('NAME')();
  IntColumn get basketId => integer().named('BASKET_ID')();
  RealColumn get value => real().named('VALUE')();
  DateTimeColumn get valueUpdatedOn => dateTime().named('VALUE_UPDATED_ON')();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (BASKET_ID) REFERENCES BASKET ("ID")',
      ];
}

@DataClassName('TRANSACTION')
class TransactionTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get investmentId => integer().named('INVESTMENT_ID')();
  RealColumn get amount => real().named('AMOUNT')();
  DateTimeColumn get amountInvestedOn =>
      dateTime().named('AMOUNT_INVESTED_ON')();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (INVESTMENT_ID) REFERENCES INVESTMENT ("ID")',
      ];
}

@DataClassName('GOAL')
class GoalTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get name => text().named('NAME')();
  RealColumn get targetAmount => real().named('TARGET_AMOUNT')();
  DateTimeColumn get targetDate => dateTime().named('TARGET_DATE')();
  RealColumn get inflation => real().named('INFLATION')();
  TextColumn get riskProfileType =>
      textEnum<RiskProfileType>().named('RISK_PROFILE_TYPE').nullable()();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (INVESTMENT_ID) REFERENCES INVESTMENT ("ID")',
      ];
}

@DataClassName('GOAL_INVESTMENT_MAP')
class GoalInvestmentMapTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get goalId => integer().named('GOAL_ID')();
  IntColumn get investmentId => integer().named('INVESTMENT_ID')();
  RealColumn get investmentPercentage =>
      real().named('INVESTMENT_PERCENTAGE')();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (GOAL_ID) REFERENCES GOAL ("ID")',
        'FOREIGN KEY (INVESTMENT_ID) REFERENCES INVESTMENT ("ID")',
      ];
}

@DriftDatabase(tables: [BasketTable, InvestmentTable, TransactionTable, GoalTable, GoalInvestmentMapTable])
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
          'wealth_wave_db', // prefer to only use valid identifiers here
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
