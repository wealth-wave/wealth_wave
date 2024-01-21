import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/contract/sip_frequency.dart';

part 'app_database.g.dart';

@DataClassName('BasketDO')
class BasketTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME').unique()();

  TextColumn get description => text().nullable().named('DESCRIPTION')();
}

@DataClassName('InvestmentDO')
class InvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME')();

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

  RealColumn get amount => real().named('AMOUNT')();

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

  DateTimeColumn get endDate => dateTime().nullable().named('END_DATE')();

  TextColumn get frequency => textEnum<SipFrequency>().named('FREQUENCY')();

  DateTimeColumn get executedTill =>
      dateTime().nullable().named('EXECUTED_TILL')();
}

@DataClassName('GoalDO')
class GoalTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  TextColumn get name => text().named('NAME')();

  TextColumn get description => text().nullable().named('DESCRIPTION')();

  RealColumn get amount => real().named('AMOUNT')();

  DateTimeColumn get amountUpdatedOn => dateTime().named('AMOUNT_UPDATED_ON')();

  RealColumn get inflation => real().named('INFLATION')();

  DateTimeColumn get maturityDate => dateTime().named('MATURITY_DATE')();

  TextColumn get importance => textEnum<GoalImportance>().named('IMPORTANCE')();
}

@DataClassName('GoalInvestmentDO')
class GoalInvestmentTable extends Table {
  IntColumn get id => integer().named('ID').autoIncrement()();

  IntColumn get goalId =>
      integer().named('GOAL_ID').references(GoalTable, #id)();

  IntColumn get investmentId =>
      integer().named('INVESTMENT_ID').references(GoalTable, #id)();

  RealColumn get splitPercentage => real().named('SPLIT_PERCENTAGE')();
}

@DriftDatabase(tables: [
  BasketTable,
  InvestmentTable,
  TransactionTable,
  GoalTable,
  SipTable,
  GoalInvestmentTable,
], views: [])
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
    final sipBackup = await executor.runSelect('SELECT * FROM sip_table', []);

    return {
      'basket_table': basketBackup,
      'investment_table': investmentBackup,
      'sip_table': sipBackup,
      'transaction_table': transactionBackup,
      'goal_table': goalBackup,
      'goal_investment_table': goalInvestmentBackup,
    };
  }

  Future<void> loadBackup(
      Map<String, List<Map<String, dynamic>>> backup) async {
    await transaction(() async {
      for (var entry in backup.entries) {
        var tableName = entry.key;
        var tableDataList = entry.value;

        for (var tableData in tableDataList) {
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
              } else {
                throw Exception('Unknown type $value');
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
