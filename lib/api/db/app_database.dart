import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

part 'app_database.g.dart';

@DataClassName('BasketDO')
class BasketTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}

@DriftDatabase(tables: [BasketTable])
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
      databaseName: 'wealth_wave_db', // prefer to only use valid identifiers here
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
