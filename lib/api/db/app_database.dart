import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'app_database.g.dart';

@DataClassName('BasketDO')
class BasketTable extends Table {
  TextColumn get name => text().withLength(min: 6, max: 32).unique()();
  RealColumn get expectedSplit => real().nullable()();
}

@DriftDatabase(tables: [BasketTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static final AppDatabase instance = AppDatabase(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}
