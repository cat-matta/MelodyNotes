import 'package:drift/drift.dart' as driftHelper;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musescore/data/drift_db.dart';
import 'package:musescore/providers/ScoresListProvider.dart';
import 'package:musescore/services/scores_service.dart';
import 'package:musescore/themedata.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EditScoreDrawer extends ConsumerStatefulWidget {
  Score scoreInfo;

  EditScoreDrawer(this.scoreInfo);

  @override
  ConsumerState<EditScoreDrawer> createState() => _EditScoreWidget();
}

class _EditScoreWidget extends ConsumerState<EditScoreDrawer> {
  // the bools can change to a map of Booleans. Ex: Map<String,bool>
  // bool editTitle = false;
  // bool editComposer = false;
  // bool editGenres = false;
  // bool editTags = false;
  // bool editLabels = false;
  // bool editReference = false;
  // bool editRating = false;
  // bool editDifficulty = false;
   bool editTime = false;

  Map<String,bool> fieldUpdateFlag = {
    "title": false,
    "composer": false,
    "genre": false,
    "tag": false,
    "label": false,
    "reference": false,
    "rating": false,
    "difficulty": false,
    // "editTime":false, need correct field type for db
  };

  Map<String,dynamic> updatedScore = {
    "title": "",
    "composer": "",
    "genre": "",
    "tag": "",
    "label": "",
    "reference": "",
    "rating": 0,
    "difficulty": "",
  };

  late TextEditingController titleController;
  late TextEditingController composerController;
  late TextEditingController genreController;
  late TextEditingController tagController;
  late TextEditingController labelController;
  late TextEditingController referenceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    composerController = TextEditingController();
    genreController = TextEditingController();
    tagController = TextEditingController();
    labelController = TextEditingController();
    referenceController = TextEditingController();
    updatedScore["title"] =  widget.scoreInfo.name;
  }

  @override
  void dispose() {
    titleController.dispose();
    composerController.dispose();
    genreController.dispose();
    tagController.dispose();
    labelController.dispose();
    referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
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
                          updatedScore["title"] = titleController.text;
                          print(fieldUpdateFlag);
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.name,
                      ),
                      controller: titleController,
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
                          updatedScore["composer"] = composerController.text;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.composer,
                      ),
                      controller: composerController,
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
                          updatedScore["genre"] = genreController.text;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.genre,
                      ),
                      controller: genreController,
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
                          updatedScore["tag"] = tagController.text;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.tag,
                      ),
                      controller: tagController,
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
                          updatedScore["label"] = labelController.text;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.label,
                      ),
                      controller: labelController,
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
                          updatedScore["reference"] = referenceController.text;
                        });
                      },
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.scoreInfo.reference,
                      ),
                      controller: referenceController,
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
                      onRatingUpdate: (rating) {updatedScore["rating"] = rating;}
                    ),
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
                    name: updatedScore["title"],
                    file: widget.scoreInfo.file,
                    composer: driftHelper.Value(updatedScore["composer"]),
                    genre: driftHelper.Value(updatedScore["genre"]),
                    tag: driftHelper.Value(updatedScore["tag"]),
                    label: driftHelper.Value(updatedScore["label"]),
                    reference: driftHelper.Value(updatedScore["reference"]),
                    //rating: driftHelper.Value(updatedScore["rating"]),
                    //difficulty: driftHelper.Value(updatedScore["difficulty"]),
                  );

                  ref.watch(scoresListProvider.notifier).updateScore(scoreObj);

                 //await ScoreService().updateScore(scoreObj);

                 print("help it works");
                 //Navigator.of(context).pop();
                 //setState(() {});
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
