import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

import 'package:melodyscore/themedata.dart';
import './FilterSetlistDrawer.dart';
import '../data/drift_db.dart';

//this widget represents individual setlists
//they are displayed in the SetlistDrawer widget

class SetListTile extends StatefulWidget {
  int numItems; // num of scores in the setlist
  String text; //title of setlist
  List<Score> listOfScores;
  VoidCallback
      editFunction; //edit the name of the setlist; may open a alert dialog box
  AsyncCallback deleteFunction; // delete the setlist

  SetListTile(
    this.numItems,
    this.text,
    this.listOfScores,
    this.editFunction,
    this.deleteFunction,
  );

  @override
  State<SetListTile> createState() => _SetListTileState();
}

class _SetListTileState extends State<SetListTile> {
  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        splashRadius: 25.0,
        color: AppTheme.maintheme().iconTheme.color,
      ),
      trailing: IconButton(
        onPressed: widget.deleteFunction,
        icon: Icon(Icons.delete),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      onTap: () {
        //open new modal side sheet to show scores in this setlist
        showModalSideSheet(
          context: context,
          body: FilterSetlistDrawer(widget.text, widget.listOfScores),
          width: mediaQuery.size.width * 0.70,
          withCloseControll: false,
        );
      },
    );
  }
}
