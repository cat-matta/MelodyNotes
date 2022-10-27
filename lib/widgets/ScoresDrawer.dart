import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';
import 'package:file_picker/file_picker.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './ScoreListTile.dart';

class ScoreDrawer extends StatefulWidget {
  @override
  State<ScoreDrawer> createState() => _ScoresLibraryWidgetState();
}

class _ScoresLibraryWidgetState extends State<ScoreDrawer> {
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

  late Map<String,List<Score>> sortedScoresMap = {};

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

  Future<Map<String,List<Score>>> getMappedScores(String filter) async {
    ScoreService servObj = ScoreService();
    List<Score> listsOfScore = await servObj.getAllScores();
    Map<String,List<Score>> mappedScores = {};

    if(filter == 'composer'){
      listsOfScore.forEach((score){
        if(mappedScores[score.composer] == null){mappedScores[score.composer] = [];}
        mappedScores[score.composer]!.add(score);
      });
    }
    return mappedScores;
  }

  List<ScoreListTile> createListOfScoreListTileWidgets(){
    List<ScoreListTile> listOfWidgets = [];
    sortedScoresMap.forEach((k,v)=> listOfWidgets.add(ScoreListTile(v.length,k,(){}, (){})));
    return listOfWidgets;
  }

  void setup() async {
    sortedScoresMap = await getMappedScores("composer");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
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

                      ScoreService servObj = ScoreService();
                      ScoresCompanion scoreObj = ScoresCompanion.insert(
                           name: file!.name, file: file?.path ?? "no path", composer: 'no composer');
                      await servObj.insertScore(scoreObj);

                      // use to test and show data storage in terminal
                      List<Score> listsOfScore = await servObj.getAllScores();
                      print(listsOfScore);

                      sortedScoresMap = await getMappedScores("composer");

                      setState(() {});
                    },
                    child: const Text('Import'),
                    style: TextButton.styleFrom(
                      primary: AppTheme.accentMain,
                      backgroundColor: AppTheme.darkBackground,
                    )),
                TextButton(
                    onPressed: () => {Navigator.pushNamed(context, '/')},
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
                  onPressed: () async => {
                    sortedScoresMap = await getMappedScores("composer"),
                    setState(() {
                      _hasBeenPressedComposer = true;
                      _hasBeenPressedTags = false;
                      _hasBeenPressedGenres = false;
                      _hasBeenPressedLabels = false;
                      //_onItemTapped(0);
                    })
                  },
                  child: const Text('Composers',
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
                  onPressed: () => {
                    setState(() {
                      _hasBeenPressedGenres = true;
                      _hasBeenPressedComposer = false;
                      _hasBeenPressedTags = false;
                      _hasBeenPressedLabels = false;
                      //_onItemTapped(1);
                    })
                  },
                  child: const Text( 'Genres',
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
                  onPressed: () => {
                    setState(() {
                      _hasBeenPressedTags = true;
                      _hasBeenPressedComposer = false;
                      _hasBeenPressedGenres = false;
                      _hasBeenPressedLabels = false;
                      //_onItemTapped(2);
                    })
                  },
                  child: const Text('Tags',
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
                  onPressed: () => {
                    setState(() {
                      _hasBeenPressedTags = false;
                      _hasBeenPressedComposer = false;
                      _hasBeenPressedGenres = false;
                      _hasBeenPressedLabels = true;
                      //_onItemTapped(3);
                    })
                  },
                  child: const Text('Labels',
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
