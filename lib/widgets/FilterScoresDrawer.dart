import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musescore/providers/PdfFileProvider.dart';
import 'package:musescore/providers/ScoresListProvider.dart';
import 'package:musescore/themedata.dart';
import 'package:file_picker/file_picker.dart';
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
              print(score.file);
              ref.read(pdfFileProvider.notifier).giveFile(score.file);
              // print(ref.read(pdfFileProvider.notifier).getFile());
            }, () {
              print('edit');
            }, () async {
              ref
                  .read(scoresListProvider.notifier)
                  .removeScore([score], 'composer');
            })));
    return listOfWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);

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

                      ScoreService servObj = ScoreService();
                      ScoresCompanion scoreObj = ScoresCompanion.insert(
                          name: file!.name,
                          file: file?.path ?? "no path",
                          composer: widget.headername);

                      ref
                          .read(scoresListProvider.notifier)
                          .insertScore(scoreObj, "composer");
                      ref
                          .read(pdfFileProvider.notifier)
                          .giveFile(file!.path as String);
                      // need to fix for dynamic if provider works
                      List<Score> listsOfScore = await servObj.getAllScores();
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
