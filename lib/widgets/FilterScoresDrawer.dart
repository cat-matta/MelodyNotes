import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';
import 'package:file_picker/file_picker.dart';
import 'package:musescore/widgets/ScoresDrawer.dart';
import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './ScoreTile.dart';
class FilterScoresDrawer extends StatefulWidget {
  String headername;
  List<Score> scores;

  FilterScoresDrawer(this.headername, this.scores);

  @override
  State<FilterScoresDrawer> createState() => _FilterScoresDrawerState();
}

class _FilterScoresDrawerState extends State<FilterScoresDrawer> {
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

  List<ScoreTile> createListOfScoreTileWidgets(){
    List<ScoreTile> listOfWidgets = [];
    widget.scores.forEach((score)=> listOfWidgets.add(ScoreTile(score.name,score,(){},(){},()async{
      // delete callback function
      List<int> listOfIds = [];
      listOfIds.add(score.id);
      ScoreService servObj = ScoreService();
      await servObj.deleteListOfScores(listOfIds);
      // get mapped function, need to rewrite as a dynamic function
          List<Score> listsOfScore = await servObj.getAllScores();
          Map<String, List<Score>> mappedScores = {};
          listsOfScore.forEach((score) {
            if (mappedScores[score.composer] == null) {
              mappedScores[score.composer] = [];
            }
            mappedScores[score.composer]!.add(score);
          });
          // end of mapped function
          // this is just test to delete,code needs heavy clean up to be dynamic
          if(mappedScores == {}){setState((){widget.scores = [];});}
          else{
            setState(() {
              widget.scores = mappedScores[score.composer]!;
            });
          }
    })));
    return listOfWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);

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

                      // sample code on how to insert and fetch from db (DON'T DELETE YET)
                      // start of sample code
                      ScoreService servObj = ScoreService();
                      ScoresCompanion scoreObj = ScoresCompanion.insert(
                          name: file!.name, file: file?.path ?? "no path",
                          composer: 'no composer');
                      await servObj.insertScore(scoreObj);
                      List<Score> listsOfScore = await servObj.getAllScores();
                      print(listsOfScore);
                      // end of sample code

                      setState(() {});
                    },
                    child: const Text('Import'),
                    style: TextButton.styleFrom(
                      primary: AppTheme.accentMain,
                      backgroundColor: AppTheme.darkBackground,
                    )),
                TextButton(
                    onPressed: () {
                      // Excuse the really bad code
                      // this can probably work with better use of routing
                      // Needs to rebuild scoresDrawer widget from here
                      Navigator.of(context).pop();
                      ScoreDrawer();
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
          Expanded(
            child: listOfScoreTiles
          ),
        ],
      ),
    );
  }
}
