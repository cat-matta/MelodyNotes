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
  TextColumn get composer => text().withDefault(const Constant("No Composer"))(); // needs a min and max length
  TextColumn get genre => text().withDefault(const Constant("No Genre"))(); // need a min max length
  TextColumn get tag => text().withDefault(const Constant("No Tag"))(); // needs a min max length
  TextColumn get label => text().withDefault(const Constant("No Label"))(); // needs a min max length
  TextColumn get reference => text().withDefault(const Constant("No Reference"))();
  RealColumn get rating => real().withDefault(const Constant(0)).check(rating.isBetween(Constant(0), Constant(5)))();
  RealColumn get difficulty => real().withDefault(const Constant(0)).check(rating.isBetween(Constant(0), Constant(3)))();
  //DateTimeColumn get time => dateTime().withDefault(const Constant(0:00:00)(); // need to figure out correct way to store length of score, ex: 8:23
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
  // delete records by bulk or individual
  Future deleteListOfScoresDB(List<int> listOfIds){
    return (delete(scores)..where((score)=>score.id.isIn(listOfIds))).go();
  }
  // update individual record
  Future updateScoreDB(ScoresCompanion updatedScore){
    return update(scores).replace(updatedScore);
  }

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
