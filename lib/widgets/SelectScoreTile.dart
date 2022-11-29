import 'package:flutter/material.dart';
import 'package:melodyscore/themedata.dart';
import 'package:melodyscore/widgets/EditScoreDrawer.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import '../data/drift_db.dart';

//This widget gets displayed in the SetlistAllScores widget
//represents each individual score in the user's library with a
//checkmark for user to select it and add to the setlist
class SelectScoreTile extends StatelessWidget {
  //individual score to select
  String text;
  //Score scoreInfo;   //may need to uncomment

  SelectScoreTile(
    this.text,
    //this.scoreInfo,    //may need to uncomment
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontWeight: AppTheme.headerFontWeight,
          fontSize: 20,
        ),
      ),
      trailing: Checkbox(
        activeColor: AppTheme.accentMain,
        //value needs to be dynamically changed
        value: true,
        onChanged: (bool? value) {},
      ),
    );
  }
}
