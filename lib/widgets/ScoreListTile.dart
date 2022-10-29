import 'package:flutter/material.dart';

import 'package:musescore/themedata.dart';

class ScoreListTile extends StatelessWidget {
  int numItems;
  String text;
  VoidCallback mainfunction;
  VoidCallback editFunction;

  ScoreListTile(this.numItems, this.text, this.mainfunction, this.editFunction);

  @override
  Widget build(BuildContext context) {
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
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppTheme.maintheme().iconTheme.color,
      ),
      onTap: mainfunction,
    );
  }
}
