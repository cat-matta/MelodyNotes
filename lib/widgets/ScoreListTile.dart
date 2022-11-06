import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:musescore/themedata.dart';
import '../data/drift_db.dart';
import './FilterScoresDrawer.dart';


class ScoreListTile extends StatefulWidget {
  int numItems; // this might be removed since you can take length of listofScores
  String text;
  List<Score> listOfScores;
  VoidCallback editFunction;
  AsyncCallback deleteFunction;

  ScoreListTile(this.numItems, this.text,this.listOfScores, this.editFunction,this.deleteFunction);

  @override
  State<ScoreListTile> createState() => _ScoreListTileState();
}

class _ScoreListTileState extends State<ScoreListTile> {

  @override
  Widget build(BuildContext context){
    final mediaQuery = MediaQuery.of(context);
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