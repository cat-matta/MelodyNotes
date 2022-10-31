import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:musescore/themedata.dart';
import 'package:musescore/widgets/ScoreTile.dart';
import '../data/drift_db.dart';
import 'FilterScoresDrawer.dart';


class ScoreListTile extends StatelessWidget {
  int numItems; // this might be removed since you can take length of listofScores
  String text;
  List<Score> listOfScores;
  //VoidCallback mainfunction; // might be reintroduced
  VoidCallback editFunction;
  VoidCallback deleteFunction;

  ScoreListTile(this.numItems, this.text,this.listOfScores, this.editFunction,this.deleteFunction);

  List<ScoreTile> createScoreTiles(){
    List<ScoreTile> listOfScoreTileWidgets = [];
    listOfScores.forEach((score) => listOfScoreTileWidgets.add(ScoreTile("score name", score,(){},(){},(){})));
    return listOfScoreTileWidgets;
  }

  @override
  Widget build(BuildContext context){
    final mediaQuery = MediaQuery.of(context);
    var scoreTiles = createScoreTiles();
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontWeight: AppTheme.headerFontWeight,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        "$numItems Item",
        style: TextStyle(
          fontWeight: AppTheme.headerFontWeight,
          fontSize: 16,
        ),
      ),
      leading: IconButton(
        onPressed: editFunction,
        icon: Icon(Icons.edit_outlined),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      trailing: IconButton(
        onPressed: deleteFunction,
        icon: Icon(Icons.delete),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      onTap: (){
        showModalSideSheet(
          context: context, 
          body: FilterScoresDrawer(text,scoreTiles),
          width: mediaQuery.size.width * 0.70,
          withCloseControll: false,
        );
      },
    );
  }
}