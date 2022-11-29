import 'package:flutter/material.dart';

import 'package:melodyscore/themedata.dart';
import './SetlistAllScores.dart';
import '../data/drift_db.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

//This widget gets displayed when an individual setlist is called
//from SetlistDrawer widget (when user presses on a SetListTile widget from
//SetlistDrawer widget)

//In this widget user can select which scores they want in the setlist
//by pressing on the + button --> leads to SetlistAllScores widget
class FilterSetlistDrawer extends StatefulWidget {
  String headername;
  List<Score> scores;

  FilterSetlistDrawer(this.headername, this.scores);

  @override
  State<FilterSetlistDrawer> createState() => _FilterSetlistDrawerState();
}

class _FilterSetlistDrawerState extends State<FilterSetlistDrawer> {
  //This is for search bar
  late TextEditingController _controller;

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
    final mediaQuery = MediaQuery.of(context);

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
                //needs to open a new drawer with list of all scores
                //for user to select and add to the setlist
                IconButton(
                  onPressed: () {
                    showModalSideSheet(
                      context: context,
                      body: SetlistAllScores([]),
                      width: mediaQuery.size.width * 0.70,
                      withCloseControll: false,
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: AppTheme.maintheme().iconTheme.color,
                  ),
                  //padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  splashRadius: 20.0,
                  tooltip: "Add score",
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
            //replace with list of ScoreTiles
            child: ListTile(
              title: Text("Example Score"),
              trailing: Icon(
                Icons.delete,
              ),
            ),

            // ScoreTile(
            //   "Happy Birthday",
            //   ,
            //   () {},
            //   () {},
            //   () {},
            // ),
          ),
        ],
      ),
    );
  }
}
