import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodyscore/data/drift_db.dart';
import 'package:melodyscore/providers/ScoresListProvider.dart';
import 'package:melodyscore/services/scores_service.dart';
import 'package:melodyscore/widgets/ScoresDrawer.dart';

class PdfStateNotifier extends StateNotifier<AsyncValue<Score>> {
  PdfStateNotifier() : super(AsyncLoading());
  void giveFile(Score score) async {
    state = AsyncData(score);
  }

  AsyncValue<Score> getFile() {
    return state;
  }
}

final pdfFileProvider =
    StateNotifierProvider.autoDispose<PdfStateNotifier, AsyncValue<Score>>(
        (ref) {
  // final score = ref.watch(scoresListProvider);
  // ref.keepAlive();
  return PdfStateNotifier();
});
