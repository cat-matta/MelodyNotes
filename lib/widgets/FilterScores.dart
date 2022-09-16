import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';
import 'package:file_picker/file_picker.dart';
import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './ScoreListTile.dart';

class FilterScores extends StatefulWidget {
  String headername;
  List<ScoreListTile> scores;

  FilterScores(this.headername, this.scores);

  @override
  State<FilterScores> createState() => _FilterScoresState();
}

class _FilterScoresState extends State<FilterScores> {
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

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);

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
                          name: file!.name, file: file?.path ?? "no path");
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
                    // clicking on back button should lead back to ScoresDrawer
                    // ie. the previous modal side sheet
                    //needs to be fixed
                    onPressed: () => {Navigator.pushNamed(context, '/')},
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: widget.scores,
            ),
          ),
        ],
      ),
    );
  }
}
