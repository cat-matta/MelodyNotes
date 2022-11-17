import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodyscore/data/drift_db.dart';
import 'package:melodyscore/providers/ScoresListProvider.dart';
import 'package:melodyscore/services/scores_service.dart';
import 'package:melodyscore/widgets/ScoresDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfStateNotifier extends StateNotifier<AsyncValue<Score>> {
  PdfStateNotifier() : super(AsyncLoading());
  void giveFile(Score score) async {
    state = AsyncData(score);
    setCache(score.id);
  }

  AsyncValue<Score> getPrevFile() {
    return state;
  }

  void removeFile(Score score) {
    state = AsyncLoading();
  }

  void setCache(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('file_id', id);
  }
}

final pdfFileProvider =
    StateNotifierProvider.autoDispose<PdfStateNotifier, AsyncValue<Score>>(
        (ref) {
  ref.keepAlive();
  return PdfStateNotifier();
});
