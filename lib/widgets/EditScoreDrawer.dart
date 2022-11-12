import 'package:drift/drift.dart' as driftHelper;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melodyscore/themedata.dart';

import '../data/drift_db.dart';
import '../providers/ScoresListProvider.dart';
import '../services/scores_service.dart';

class EditScoreDrawer extends ConsumerStatefulWidget {
  Score scoreInfo;

  EditScoreDrawer(this.scoreInfo);

  @override
  ConsumerState<EditScoreDrawer> createState() => _EditScoreWidget();
}

class _EditScoreWidget extends ConsumerState<EditScoreDrawer> {
  bool editTime =
      false; // place holder till the field is added to scores table db

  Map<String, bool> fieldUpdateFlag = {
    "title": false,
    "composer": false,
    "genre": false,
    "tag": false,
    "label": false,
    "reference": false,
    "rating": false,
    "difficulty": false,
  };

  Map<String, dynamic> updatedScore = {
    "title": "",
    "composer": "",
    "genre": "",
    "tag": "",
    "label": "",
    "reference": "",
    "rating": 0,
    "difficulty": 0,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scoreInfo.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(6),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    Text(
                      "Title",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["title"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["title"] = value!;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.name,
                      ),
                      onChanged: (String text) {
                        updatedScore["title"] = text;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Composer",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["composer"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["composer"] = value!;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.composer,
                      ),
                      onChanged: (String text) {
                        updatedScore["composer"] = text;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Genres",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["genre"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["genre"] = value!;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.genre,
                      ),
                      onChanged: (String text) {
                        updatedScore["genre"] = text;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Tags",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["tag"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["tag"] = value!;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.tag,
                      ),
                      onChanged: (String text) {
                        updatedScore["tag"] = text;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Labels",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["label"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["label"] = value!;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.label,
                      ),
                      onChanged: (String text) {
                        updatedScore["label"] = text;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Reference",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["reference"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["reference"] = value!;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.reference,
                      ),
                      onChanged: (String text) {
                        updatedScore["reference"] = text;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Rating",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["rating"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["rating"] = value!;
                        });
                      },
                    ),
                    RatingBar.builder(
                        initialRating: widget.scoreInfo.rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: AppTheme.accentMain,
                            ),
                        onRatingUpdate: (rating) {
                          updatedScore["rating"] = rating;
                        }),
                  ]),
                  TableRow(children: [
                    Text(
                      "Difficulty",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: fieldUpdateFlag["difficulty"]!,
                      onChanged: (bool? value) {
                        setState(() {
                          fieldUpdateFlag["difficulty"] = value!;
                        });
                      },
                    ),
                    RatingBar.builder(
                      initialRating: widget.scoreInfo.difficulty,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 3,
                      itemBuilder: (context, _) => Icon(
                        Icons.circle,
                        color: AppTheme.accentMain,
                      ),
                      onRatingUpdate: (rating) {
                        updatedScore["difficulty"] = rating;
                      },
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Time",
                      textAlign: TextAlign.right,
                      textScaleFactor: 1.3,
                    ),
                    Checkbox(
                      activeColor: AppTheme.accentMain,
                      value: editTime,
                      onChanged: (bool? value) {
                        //     setState(() {
                        //       //fieldUpdateFlag["time"] = value!;
                        //       //updatedScore["time"] =
                        //       fieldUpdateFlag["time"] = false;
                        //     });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'No Time',
                      ),
                    ),
                  ]),
                ],
              ),
              TextButton(
                onPressed: () async {
                  ScoresCompanion scoreObj = ScoresCompanion.insert(
                    id: driftHelper.Value(widget.scoreInfo.id),
                    name: fieldUpdateFlag["title"]!
                        ? updatedScore["title"]
                        : widget.scoreInfo.name,
                    file: widget.scoreInfo.file,
                    composer: fieldUpdateFlag["composer"]!
                        ? driftHelper.Value(updatedScore["composer"])
                        : driftHelper.Value(widget.scoreInfo.composer),
                    genre: fieldUpdateFlag['genre']!
                        ? driftHelper.Value(updatedScore['genre'])
                        : driftHelper.Value(widget.scoreInfo.genre),
                    tag: fieldUpdateFlag['tag']!
                        ? driftHelper.Value(updatedScore['tag'])
                        : driftHelper.Value(widget.scoreInfo.tag),
                    label: fieldUpdateFlag['label']!
                        ? driftHelper.Value(updatedScore['label'])
                        : driftHelper.Value(widget.scoreInfo.label),
                    reference: fieldUpdateFlag['reference']!
                        ? driftHelper.Value(updatedScore['reference'])
                        : driftHelper.Value(widget.scoreInfo.reference),
                    rating: fieldUpdateFlag['rating']!
                        ? driftHelper.Value(updatedScore['rating'])
                        : driftHelper.Value(widget.scoreInfo.rating),
                    difficulty: fieldUpdateFlag['difficulty']!
                        ? driftHelper.Value(updatedScore['difficulty'])
                        : driftHelper.Value(widget.scoreInfo.difficulty),
                  );

                  ref.watch(scoresListProvider.notifier).updateScore(scoreObj);

                  // this is to test that the db updated
                  print("updated score successfully");
                  print(await ScoreService().getAllScores());

                  // Navigator.of(context).pop(); // this may be added once again
                },
                child: const Text(
                  'Submit',
                  overflow: TextOverflow.ellipsis,
                ),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 15,
                  ),
                  primary: AppTheme.lightBackground,
                  backgroundColor: AppTheme.darkBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
