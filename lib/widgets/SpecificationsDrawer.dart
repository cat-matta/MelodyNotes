import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SpecificationsDrawer extends StatefulWidget {
  @override
  State<SpecificationsDrawer> createState() => _SpecificationsWidget();
}

class _SpecificationsWidget extends State<SpecificationsDrawer> {
  bool editTitle = false;
  bool editComposer = false;
  bool editGenres = false;
  bool editTags = false;
  bool editLabels = false;
  bool editReference = false;
  bool editRating = false;
  bool editDifficulty = false;
  bool editTime = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('No Title'),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Table(
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
                value: editTitle,
                onChanged: (bool? value) {
                  setState(() {
                    editTitle = value!;
                  });
                },
              ),
              TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'No Title',
                ),
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
                value: editComposer,
                onChanged: (bool? value) {
                  setState(() {
                    editComposer = value!;
                  });
                },
              ),
              TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'No Composer',
                ),
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
                value: editGenres,
                onChanged: (bool? value) {
                  setState(() {
                    editGenres = value!;
                  });
                },
              ),
              TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'No Genres',
                ),
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
                value: editTags,
                onChanged: (bool? value) {
                  setState(() {
                    editTags = value!;
                  });
                },
              ),
              TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'No Tags',
                ),
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
                value: editLabels,
                onChanged: (bool? value) {
                  setState(() {
                    editLabels = value!;
                  });
                },
              ),
              TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'No Labels',
                ),
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
                value: editReference,
                onChanged: (bool? value) {
                  setState(() {
                    editReference = value!;
                  });
                },
              ),
              TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'No Reference',
                ),
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
                value: editRating,
                onChanged: (bool? value) {
                  setState(() {
                    editRating = value!;
                  });
                },
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: AppTheme.accentMain,
                ),
                onRatingUpdate: (rating) {},
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
                value: editDifficulty,
                onChanged: (bool? value) {
                  setState(() {
                    editDifficulty = value!;
                  });
                },
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 3,
                itemBuilder: (context, _) => Icon(
                  Icons.circle,
                  color: AppTheme.accentMain,
                ),
                onRatingUpdate: (rating) {},
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
                  setState(() {
                    editTime = value!;
                  });
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
      ),
    );
  }
}
