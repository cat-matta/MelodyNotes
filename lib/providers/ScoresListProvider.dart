import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musescore/services/scores_service.dart';

import '../data/drift_db.dart';

class ScoreListNotifier extends StateNotifier<Map<String,List<Score>>>{
  ScoreListNotifier(): super({});

  void insertScore(ScoresCompanion score,String filter) async {
    ScoreService servObj = ScoreService();
    await servObj.insertScore(score);

    Map<String,List<Score>> mappedScores = await getMappedScoresHelper(filter);

    state = {...mappedScores};
  }

  void updateScore(ScoresCompanion score) async {
    ScoreService servObj = ScoreService();
    await servObj.updateScore(score);

    Map<String,List<Score>> mappedScored = await getMappedScoresHelper("composer"); // note: any filter can be used, just need to trigger

    state = {...mappedScored};
  }

  void removeScore(List<Score> listOfScores, String filter) async{
    List<int> listOfIds = [];
    listOfScores.forEach((score) {listOfIds.add(score.id);});

    ScoreService servObj = ScoreService();
    await servObj.deleteListOfScores(listOfIds);

    Map<String, List<Score>> mappedScores = await getMappedScoresHelper(filter);

    state = {...mappedScores};

  }

  void getMappedScores(String filter) async {
    Map<String, List<Score>> mappedScores = await getMappedScoresHelper(filter);
    state = {...mappedScores};
  }

  Future<Map<String,List<Score>>> getMappedScoresHelper(String filter) async {
    ScoreService servObj = ScoreService();
    List<Score> listsOfScore = await servObj.getAllScores();
    Map<String, List<Score>> mappedScores = {};
    if (filter == 'composer') {
      listsOfScore.forEach((score) {
        if (mappedScores[score.composer] == null) {
          mappedScores[score.composer] = [];
        }
        mappedScores[score.composer]!.add(score);
      });
    }
    return mappedScores;
  }
}

final scoresListProvider = StateNotifierProvider<ScoreListNotifier,Map<String,List<Score>>>((ref){
  return ScoreListNotifier();
});