import 'package:melodyscore/data/drift_db.dart';

class ScoreRepo {
  final AppDb drift;

  ScoreRepo(this.drift);

  Future<int> insertScore(ScoresCompanion score) {
    return this.drift.insertScoreDb(score);
  }

  Future<List<Score>> getAllScores() {
    return this.drift.allScoresDb;
  }

  Future deleteListOfScores(List<int> listOfIds) {
    return this.drift.deleteListOfScoresDB(listOfIds);
  }
}
