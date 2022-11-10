import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musescore/services/scores_service.dart';
import 'package:musescore/widgets/ScoresDrawer.dart';

class PdfStateNotifier extends StateNotifier<AsyncValue<String>> {
  PdfStateNotifier() : super(AsyncLoading());
  void giveFile(String file) async {
    state = AsyncData(file);
  }

  AsyncValue<String> getFile() {
    return state;
  }
}

final pdfFileProvider =
    StateNotifierProvider<PdfStateNotifier, AsyncValue<String>>((ref) {
  return PdfStateNotifier();
});
