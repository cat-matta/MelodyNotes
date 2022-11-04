import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:musescore/themedata.dart';
import 'package:musescore/widgets/ScoreTile.dart';
import 'package:musescore/widgets/ScoresDrawer.dart';
import '../data/drift_db.dart';
import '../services/scores_service.dart';
import './FilterScoresDrawer.dart';


class ScoreListTile extends StatefulWidget {
  int numItems; // this might be removed since you can take length of listofScores
  String text;
  List<Score> listOfScores;
  //VoidCallback mainfunction; // might be reintroduced
  VoidCallback editFunction;
  AsyncCallback deleteFunction;

  ScoreListTile(this.numItems, this.text,this.listOfScores, this.editFunction,this.deleteFunction);

  @override
  State<ScoreListTile> createState() => _ScoreListTileState();
}

class _ScoreListTileState extends State<ScoreListTile> {

  // List<ScoreTile> createScoreTiles(){
  //   List<ScoreTile> listOfScoreTileWidgets = [];
  //   widget.listOfScores.forEach((score) => listOfScoreTileWidgets.add(ScoreTile(score.name, score,(){},(){},(){}
  //   })));
  //   return listOfScoreTileWidgets;
  // }

  List<int> testFunc(){
    List<int> listOfIds = [];
    widget.listOfScores.forEach((score) => listOfIds.add(score.id));
    return listOfIds;
  }

  @override
  Widget build(BuildContext context){
    final mediaQuery = MediaQuery.of(context);
    //var scoreTiles = createScoreTiles();
    return ListTile(
      title: Text(
        widget.text,
        style: TextStyle(
          fontWeight: AppTheme.headerFontWeight,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        "${widget.numItems} Item",
        style: TextStyle(
          fontWeight: AppTheme.headerFontWeight,
          fontSize: 16,
        ),
      ),
      leading: IconButton(
        onPressed: widget.editFunction,
        icon: Icon(Icons.edit_outlined),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      trailing: IconButton(
        onPressed: widget.deleteFunction,
        // NOTE: This does not work as smooth as needed,
        // SetState inside OnPressed doesn't update UI
        // When you click composer tab, the UI updates.
        // onPressed: () async {
        //   List<int> listOfIds = testFunc();
        //   ScoreService servObj = ScoreService();
        //   await servObj.deleteListOfScores(listOfIds);
        //   Navigator.of(context).pop();
        //   showModalSideSheet(
        //     context: context,
        //     barrierDismissible: true,
        //     withCloseControll: false,
        //     body: ScoreDrawer(),
        //     width: mediaQuery.size.width * 0.70,
        //   );
        //},
        icon: Icon(Icons.delete),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      onTap: (){
        showModalSideSheet(
          context: context, 
          body: FilterScoresDrawer(widget.text, widget.listOfScores),
          width: mediaQuery.size.width * 0.70,
          withCloseControll: false,
        );
      },
    );
  }
}