import 'package:musescore/data/drift_db.dart';
import '../repositories/scores_repository.dart';
import '../locator.dart';

class ScoreService {

  final ScoreRepo repo = ScoreRepo(locator<AppDb>());

  Future<int> insertScore(ScoresCompanion score) {
    return this.repo.insertScore(score);
  }

  Future<List<Score>> getAllScores() {
    return this.repo.getAllScores();
  }

  Future deleteListOfScores(List<int> listOfIds){
    return this.repo.deleteListOfScores(listOfIds);
  }

  Future updateScore(ScoresCompanion updatedScore){
    return this.repo.updateScore(updatedScore);
  }
}
