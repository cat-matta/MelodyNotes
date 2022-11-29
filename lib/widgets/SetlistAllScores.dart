import 'dart:io';
import 'package:flutter/material.dart';

import 'package:melodyscore/themedata.dart';
import '../data/drift_db.dart';
import './SelectScoreTile.dart';

//This widget gets displayed when user wants to add a score to a setlist
//displays a list of all scores for user to select

//Scores are displayed as SelectScoreTile widgets that have a checkmark
//next to them
class SetlistAllScores extends StatefulWidget {
  //list of all scores to display
  List<Score> scores;

  SetlistAllScores(this.scores);

  @override
  State<SetlistAllScores> createState() => _SetlistAllScoresState();
}

class _SetlistAllScoresState extends State<SetlistAllScores> {
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
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            "All Scores",
            textAlign: TextAlign.left,
          ),
          toolbarHeight: 56.0,
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    //need to change, for now just pop
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                  style: TextButton.styleFrom(
                    primary: AppTheme.accentMain,
                    backgroundColor: AppTheme.darkBackground,
                  ),
                ),
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
            child: ListView(children: [
              SelectScoreTile(
                "Happy Birthday",
              ),
              SelectScoreTile(
                "Moonlight Sonata",
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
