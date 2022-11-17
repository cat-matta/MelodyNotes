import 'dart:collection';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodynotes/data/drift_db.dart';
import 'package:melodynotes/services/scores_service.dart';
import 'package:melodynotes/widgets/ScoresDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentScoreListNotifier extends StateNotifier<List<Score>> {
  CurrentScoreListNotifier() : super([]);

  void addScore(Score score) {
    state.add(score);
    setCache(state);
  }

  void removeScore(Score score) {
    state.remove(score);
    setCache(state);
  }

// how efficient is it to cache this list even
  void setCache(List<Score> currentScores) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = [];
    currentScores.forEach((scores) => ids.add("${scores.id}"));
    print(" IN PROVDIER $currentScores END");
    await prefs.setStringList('saved_scores', ids);
  }

  void getCache(List<String> savedIds) async {
    List<Score> currentSavedScores = [];
    // final prefs = await SharedPreferences.getInstance();
    // final List<String>? items = prefs.getStringList('saved_scores');
    // if (items == null)
    // return;
    // else {
    ScoreService servObj = ScoreService();
    List<Score> listsOfScores = await servObj.getAllScores();
    savedIds.forEach((element) => currentSavedScores
        .add(listsOfScores.singleWhere((score) => (element) == "${score.id}")));
    // }
    print(" FROM PROVDIER CACHE $currentSavedScores END");

    state = currentSavedScores;
  }

  Score getLast(Score score) => state.last;

  // Score getbyID(int id) => state.singleWhere((score) => score.id == id);

  void moveOrder(Score score) {
    // implement later
  }
}

final currentScoresListProvider =
    StateNotifierProvider<CurrentScoreListNotifier, List<Score>>((ref) {
  return CurrentScoreListNotifier();
});
