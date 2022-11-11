import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodyscore/services/scores_service.dart';
import 'package:melodyscore/widgets/ScoresDrawer.dart';

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
