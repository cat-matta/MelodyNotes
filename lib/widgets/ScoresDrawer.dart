import 'dart:io';

import 'package:drift/drift.dart' as driftHelper;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodynotes/providers/PdfFileProvider.dart';
import 'package:melodynotes/providers/ScoresListProvider.dart';
import 'package:melodynotes/themedata.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './ScoreListTile.dart';

class ScoreDrawer extends ConsumerStatefulWidget {
  ScoreDrawer({Key? key}) : super(key: key);
  @override
  ConsumerState<ScoreDrawer> createState() => _ScoresLibraryWidgetState();
}

class _ScoresLibraryWidgetState extends ConsumerState<ScoreDrawer> {
  //This is for changing color in Second Nav bar each button
  bool _hasBeenPressedComposer = true;
  bool _hasBeenPressedGenres = false;
  bool _hasBeenPressedTags = false;
  bool _hasBeenPressedLabels = false;

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
    setup();
    _controller = TextEditingController();
  }

  //to get rid of the controller when it is no longer needed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setup() async {
    super.initState();
    ref.read(scoresListProvider.notifier).getMappedScores("composer");

    // ref.read(pdfFileProvider.notifier).giveFile(score);
  }

  List<ScoreListTile> createListOfScoreListTileWidgets() {
    Map<String, List<Score>> mapSortedScores = ref.watch(scoresListProvider);
    List<ScoreListTile> listOfWidgets = [];
    mapSortedScores.forEach((key, listOfScores) => listOfWidgets.add(
            ScoreListTile(listOfScores.length, key, listOfScores, () {},
                () async {
          ref
              .read(scoresListProvider.notifier)
              .removeScore(listOfScores, "composer");
        })));
    return listOfWidgets;
  }

  @override
  Widget build(BuildContext context) {
    // This is for list tile containing the unique composer/genre/tags/labels

    ListView listOfScoreListTiles = ListView(
      padding: EdgeInsets.zero,
      children: createListOfScoreListTileWidgets(),
    );

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text(
            'Scores Library',
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
                          composer: driftHelper.Value('No composer'));

                      ref.read(scoresListProvider.notifier).insertScore(
                          scoreObj,
                          "composer"); // need to fix for dynamic if provider works

                      // print(
                      //     "We chose: ${ref.read(pdfFileProvider.notifier).getFile()}");
                      // use to test and show data storage in terminal
                      List<Score> listsOfScore = await servObj.getAllScores();
                      Score score = (listsOfScore.last);

                      // print(listsOfScore);
                    },
                    child: const Text('Import'),
                    style: TextButton.styleFrom(
                      primary: AppTheme.accentMain,
                      backgroundColor: AppTheme.darkBackground,
                    )),
                TextButton(
                    onPressed: () => {
                          Navigator.of(context).pop()
                        }, //Navigator.pushNamed(context, '/')}, // pushName vs pop?
                    child: const Text('Back'),
                    style: TextButton.styleFrom(
                      primary: AppTheme.accentMain,
                      backgroundColor: AppTheme.darkBackground,
                    )),
              ],
            )
          ]),
      body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppTheme.darkBackground,
            toolbarHeight: 35.0,
            automaticallyImplyLeading: false,
            title: Row(
              children: <Widget>[
                Expanded(
                    child: TextButton(
                  onPressed: () async {
                    ref
                        .read(scoresListProvider.notifier)
                        .getMappedScores("composer");
                    _hasBeenPressedComposer = true;
                    _hasBeenPressedTags = false;
                    _hasBeenPressedGenres = false;
                    _hasBeenPressedLabels = false;
                  },
                  child: const Text(
                    'Composers',
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: TextButton.styleFrom(
                      primary: _hasBeenPressedComposer
                          ? AppTheme.lightBackground
                          : AppTheme.accentMain,
                      backgroundColor: _hasBeenPressedComposer
                          ? AppTheme.accentMain
                          : AppTheme.darkBackground),
                )),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    ref
                        .read(scoresListProvider.notifier)
                        .getMappedScores("genre");
                    _hasBeenPressedGenres = true;
                    _hasBeenPressedComposer = false;
                    _hasBeenPressedTags = false;
                    _hasBeenPressedLabels = false;
                  },
                  child: const Text(
                    'Genres',
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: TextButton.styleFrom(
                    primary: _hasBeenPressedGenres
                        ? AppTheme.lightBackground
                        : AppTheme.accentMain,
                    backgroundColor: _hasBeenPressedGenres
                        ? AppTheme.accentMain
                        : AppTheme.darkBackground,
                  ),
                )),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    ref
                        .read(scoresListProvider.notifier)
                        .getMappedScores("tags");
                    _hasBeenPressedTags = true;
                    _hasBeenPressedComposer = false;
                    _hasBeenPressedGenres = false;
                    _hasBeenPressedLabels = false;
                  },
                  child: const Text(
                    'Tags',
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: TextButton.styleFrom(
                    primary: _hasBeenPressedTags
                        ? AppTheme.lightBackground
                        : AppTheme.accentMain,
                    backgroundColor: _hasBeenPressedTags
                        ? AppTheme.accentMain
                        : AppTheme.darkBackground,
                  ),
                )),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    ref
                        .read(scoresListProvider.notifier)
                        .getMappedScores("labels");
                    _hasBeenPressedTags = false;
                    _hasBeenPressedComposer = false;
                    _hasBeenPressedGenres = false;
                    _hasBeenPressedLabels = true;
                  },
                  child: const Text(
                    'Labels',
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: TextButton.styleFrom(
                    primary: _hasBeenPressedLabels
                        ? AppTheme.lightBackground
                        : AppTheme.accentMain,
                    backgroundColor: _hasBeenPressedLabels
                        ? AppTheme.accentMain
                        : AppTheme.darkBackground,
                  ),
                )),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
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
              Expanded(
                child: listOfScoreListTiles,
              ),
            ],
          )),
    );
  }
}
