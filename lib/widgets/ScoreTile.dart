import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:musescore/themedata.dart';
import 'package:musescore/widgets/EditScoreDrawer.dart';
import '../data/drift_db.dart';

class ScoreTile extends StatelessWidget {
  String text;
  Score scoreInfo;
  VoidCallback mainfunction; // calls pdf viewer
  VoidCallback editFunction; // calls edit ui widget
  VoidCallback deleteFunction; // calls delete of score tile

  ScoreTile(this.text, this.scoreInfo, this.mainfunction, this.editFunction, this.deleteFunction);

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
      leading: IconButton(
        onPressed: (){
          showModalSideSheet(
          context: context,
          body: EditScoreDrawer(),
          width: mediaQuery.size.width * 0.70,
          barrierDismissible: true,
          withCloseControll: false,
          );
        },
        icon: Icon(Icons.edit_outlined),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      trailing: IconButton(
        onPressed: deleteFunction,
        icon: Icon(Icons.delete),
        color: AppTheme.maintheme().iconTheme.color,
      ),
      onTap: mainfunction,
    );
  }
}
