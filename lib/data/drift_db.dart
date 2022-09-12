import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_db.g.dart';

class Scores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get file => text()();
}

@DriftDatabase(tables: [Scores])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  // queries setup for each table

  // Create score record
  Future<int> insertScoreDb(ScoresCompanion score) {
    return into(scores).insert(score);
  }
  // get all score records
  Future<List<Score>> get allScoresDb => select(scores).get();

  // Note: this is for migration, so not applicable yet.
  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
