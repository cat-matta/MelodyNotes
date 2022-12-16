import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodyscore/services/scores_service.dart';

import '../data/drift_db.dart';

class ScoreListNotifier extends StateNotifier<Map<String, List<Score>>> {
  ScoreListNotifier() : super({});

  void insertScore(ScoresCompanion score, String filter) async {
    ScoreService servObj = ScoreService();
    await servObj.insertScore(score);

    Map<String, List<Score>> mappedScores = await getMappedScoresHelper(filter);

    state = {...mappedScores};
  }

  Score getLast(String filter) {
    return state[filter]!.last;
  }

  Score getScorefromID(List<Score> listOfScores, int id) {
    return listOfScores.firstWhere((element) => element.id == id);
  }

  void updateScore(ScoresCompanion score) async {
    ScoreService servObj = ScoreService();
    await servObj.updateScore(score);

    // note: any filter can be used, just need to trigger helper function
    Map<String, List<Score>> mappedScored =
        await getMappedScoresHelper("composer");

    state = {...mappedScored};
  }

  void removeScore(List<Score> listOfScores, String filter) async {
    List<int> listOfIds = [];
    listOfScores.forEach((score) {
      listOfIds.add(score.id);
    });

    ScoreService servObj = ScoreService();
    await servObj.deleteListOfScores(listOfIds);

    Map<String, List<Score>> mappedScores = await getMappedScoresHelper(filter);

    state = {...mappedScores};
  }

  void getMappedScores(String filter) async {
    Map<String, List<Score>> mappedScores = await getMappedScoresHelper(filter);
    state = {...mappedScores};
  }

  Future<Map<String, List<Score>>> getMappedScoresHelper(String filter) async {
    ScoreService servObj = ScoreService();
    List<Score> listsOfScore = await servObj.getAllScores();
    Map<String, List<Score>> mappedScores = {};
    if (filter == 'composer') {

      listsOfScore.sort((a,b){
        int comparsion = a.composer.compareTo(b.composer);
        if(comparsion == 0){
          return a.name.compareTo(b.name);
        }
        return comparsion;
      });

      listsOfScore.forEach((score) {
        if (mappedScores[score.composer] == null) {
          mappedScores[score.composer] = [];
        }
        mappedScores[score.composer]!.add(score);
      });

    } else if (filter == 'genre') {

      listsOfScore.sort((a, b) {
        int comparsion = a.genre.compareTo(b.genre);
        if (comparsion == 0) {
          return a.name.compareTo(b.name);
        }
        return comparsion;
      });

      listsOfScore.forEach((score) {
        if (mappedScores[score.genre] == null) {
          mappedScores[score.genre] = [];
        }
        mappedScores[score.genre]!.add(score);
      });

    } else if (filter == 'tags') {
      
      listsOfScore.sort((a, b) {
        int comparsion = a.tag.compareTo(b.tag);
        if (comparsion == 0) {
          return a.name.compareTo(b.name);
        }
        return comparsion;
      });

      listsOfScore.forEach((score) {
        if (mappedScores[score.tag] == null) {
          mappedScores[score.tag] = [];
        }
        mappedScores[score.tag]!.add(score);
      });

    } else if (filter == 'labels') {

      listsOfScore.sort((a, b) {
        int comparsion = a.label.compareTo(b.label);
        if (comparsion == 0) {
          return a.name.compareTo(b.name);
        }
        return comparsion;
      });

      listsOfScore.forEach((score) {
        if (mappedScores[score.label] == null) {
          mappedScores[score.label] = [];
        }
        mappedScores[score.label]!.add(score);
      });
    }
    return mappedScores;
  }
}

final scoresListProvider =
    StateNotifierProvider<ScoreListNotifier, Map<String, List<Score>>>((ref) {
  return ScoreListNotifier();
});
