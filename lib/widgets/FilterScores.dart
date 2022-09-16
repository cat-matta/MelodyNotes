import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';
import 'package:file_picker/file_picker.dart';
import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './ScoreListTile.dart';

class FilterScores extends StatefulWidget {
  // String headername';
  // FilterScores(this.headername);
  @override
  State<FilterScores> createState() => _FilterScoresState();

}

class _FilterScoresState extends State<FilterScores> {

 
  //This is for search bar
  late TextEditingController _controller;

  // // This is selected index is for widgets options list
  // int _selectedIndex = 0;

  //variable to initialize file picker object & hold the file object
  FilePickerResult? result;
  PlatformFile? file;

  // // Function to control indexes for Body view
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

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
          title: const Text(
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
            leadingWidth: mediaQuerry.size.width,
            title: Row(
              children: [
                //Spacer(),
                Spacer(),
                TextButton(
                  onPressed: () => {
                    setState(() {
                      _hasBeenPressedComposer = true;
                      _hasBeenPressedTags = false;
                      _hasBeenPressedGenres = false;
                      _hasBeenPressedLabels = false;
                      _onItemTapped(0);
                    })
                  },
                  child: const Text('Composers'),
                  style: TextButton.styleFrom(
                      primary: _hasBeenPressedComposer
                          ? AppTheme.lightBackground
                          : AppTheme.accentMain,
                      backgroundColor: _hasBeenPressedComposer
                          ? AppTheme.accentMain
                          : AppTheme.darkBackground),
                ),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedGenres = true;
                            _hasBeenPressedComposer = false;
                            _hasBeenPressedTags = false;
                            _hasBeenPressedLabels = false;
                            _onItemTapped(1);
                          })
                        },
                    child: const Text('Genres'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedGenres
                          ? AppTheme.lightBackground
                          : AppTheme.accentMain,
                      backgroundColor: _hasBeenPressedGenres
                          ? AppTheme.accentMain
                          : AppTheme.darkBackground,
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedTags = true;
                            _hasBeenPressedComposer = false;
                            _hasBeenPressedGenres = false;
                            _hasBeenPressedLabels = false;
                            _onItemTapped(2);
                          })
                        },
                    child: const Text('Tags'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedTags
                          ? AppTheme.lightBackground
                          : AppTheme.accentMain,
                      backgroundColor: _hasBeenPressedTags
                          ? AppTheme.accentMain
                          : AppTheme.darkBackground,
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedTags = false;
                            _hasBeenPressedComposer = false;
                            _hasBeenPressedGenres = false;
                            _hasBeenPressedLabels = true;
                            _onItemTapped(3);
                          })
                        },
                    child: const Text('Labels'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedLabels
                          ? AppTheme.lightBackground
                          : AppTheme.accentMain,
                      backgroundColor: _hasBeenPressedLabels
                          ? AppTheme.accentMain
                          : AppTheme.darkBackground,
                    )),
                Spacer(),
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
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ],
          )),
    );
  }
}
