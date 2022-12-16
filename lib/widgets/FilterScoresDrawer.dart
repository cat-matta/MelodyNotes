import 'dart:io';

import 'package:drift/drift.dart' as driftHelper;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodyscore/providers/CurrentFilesProvider.dart';
import 'package:melodyscore/providers/PdfFileProvider.dart';
import 'package:melodyscore/providers/ScoresListProvider.dart';
import 'package:melodyscore/themedata.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './ScoreTile.dart';

class FilterScoresDrawer extends ConsumerStatefulWidget {
  String headername;
  List<Score> scores;

  FilterScoresDrawer(this.headername, this.scores);

  @override
  ConsumerState<FilterScoresDrawer> createState() => _FilterScoresDrawerState();
}

class _FilterScoresDrawerState extends ConsumerState<FilterScoresDrawer> {
  //This is for search bar
  late TextEditingController _controller;

  //variable to initialize file picker object & hold the file object
  FilePickerResult? result;
  PlatformFile? file;

  //method called when the stateful widget is inserted in the widget tree
  //it will only run once and initilize and listeners/variables
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  //to get rid of the controller when it is no longer needed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<ScoreTile> createListOfScoreTileWidgets() {
    List<ScoreTile> listOfWidgets = [];

    widget.scores
        .forEach((score) => listOfWidgets.add(ScoreTile(score.name, score, () {
              print('click');
              // choose the pdf file based on what got clicked
              // print(score.file);

              ref.read(pdfFileProvider.notifier).giveFile(score);
              ref.read(currentScoresListProvider.notifier).addScore(score);
              // print(ref.read(currentScoresListProvider.notifier).state);
              print(ref.read(currentScoresListProvider.notifier).state);
              // print(ref.read(pdfFileProvider.notifier).getFile());
            }, () {
              print('edit');
              // don't need this edit callback function for editDrawer. can be removed
            }, () async {
              ref
                  .read(scoresListProvider.notifier)
                  .removeScore([score], 'composer');

              ref.read(currentScoresListProvider.notifier).removeScore(score);
              print(ref.read(currentScoresListProvider.notifier).state);
              var currentScore =
                  ref.read(pdfFileProvider.notifier).getPrevFile();
              currentScore.whenData((value) {
                if (value.id == score.id)
                  ref.read(pdfFileProvider.notifier).removeFile(score);
              });

              ref.read(currentScoresListProvider.notifier).removeScore(score);
              print(ref
                  .read(currentScoresListProvider.notifier)
                  .state); // need to fix for dynamic if provider works
            })));
    return listOfWidgets;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Score>> mapSortedScores = ref.watch(scoresListProvider);
    widget.scores = (mapSortedScores[widget.headername] == null)
        ? []
        : mapSortedScores[widget.headername]!;

    ListView listOfScoreTiles = ListView(
      padding: EdgeInsets.zero,
      children: createListOfScoreTileWidgets(),
    );

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            widget.headername,
            textAlign: TextAlign.left,
          ),
          toolbarHeight: 56.0,
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result == null) return;
                      file = result!.files.first;
                      // print("PICKED FILE: ${file!.path!}");
                      String pickedFile = file!.path!;
                      if (Platform.isIOS) {
                        final appPath =
                            await getApplicationDocumentsDirectory();
                        final newFilePath = (p.join(appPath.path, file!.name));
                        final newFile = File(pickedFile).rename(newFilePath);
                        file = await newFile.then((value) => PlatformFile(
                            name: value.path.split('/').last,
                            size: value.lengthSync(),
                            path: value.path));
                        // print("OUR NEW FILE: ${file!.path!}");
                      }
                      // print("OUTSIDE NEW FILE: ${file!.path!}");

                      ScoreService servObj = ScoreService();
                      ScoresCompanion scoreObj = ScoresCompanion.insert(
                          name: file!.name
                              .split('/')
                              .last
                              .split('.')
                              .first
                              .split('-')
                              .last,
                          file: file?.path ?? "no path",
                          composer: driftHelper.Value(widget.headername));
                      ref
                          .read(scoresListProvider.notifier)
                          .insertScore(scoreObj, "composer");

                      // need to fix for dynamic if provider works
                      List<Score> listsOfScore = await servObj.getAllScores();
                      listsOfScore.sort((a, b) => a.name.compareTo(b.name));
                      print(listsOfScore);
                    },
                    child: const Text('Import'),
                    style: TextButton.styleFrom(
                      primary: AppTheme.accentMain,
                      backgroundColor: AppTheme.darkBackground,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //ScoreDrawer(); // This is most likely not needed
                    },
                    child: const Text('Back'),
                    style: TextButton.styleFrom(
                      primary: AppTheme.accentMain,
                      backgroundColor: AppTheme.darkBackground,
                    )),
              ],
            )
          ]),
      body: Column(
        children: <Widget>[
          // search button widget
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
            ),
            child: TextField(
              controller: _controller,
              onSubmitted: (String value) async {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppTheme.accentSecondary,
                ),
                hintText: 'Search',
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          // list tiles
          Expanded(child: listOfScoreTiles),
        ],
      ),
    );
  }
}
