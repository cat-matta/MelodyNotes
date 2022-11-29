import 'package:flutter/material.dart';
import 'package:melodyscore/themedata.dart';

import 'SetListTile.dart';

//main Setlist widget, displays all setlists
//have the ability to create setlists
class SetlistDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //show dialog to create/edit setlist
    Future<void> _BuildDialog(
      String title,
      String hintText,
      String action2Text,
      VoidCallback action2,
    ) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                //border: InputBorder.none,
                hintText: hintText,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              //depending on whether the user is editing a setlist
              //or creating a setlist, the action2text and  action2
              //arguments will be different
              TextButton(
                child: Text(action2Text),
                onPressed: action2,
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          color: AppTheme.darkBackground,
          child: Row(
            children: [
              IconButton(
                onPressed: () => _BuildDialog(
                  "Create Setlist",
                  "Name",
                  "Create",
                  () {},
                ),
                icon: Icon(
                  Icons.add,
                  color: AppTheme.maintheme().iconTheme.color,
                ),
                tooltip: "Add Setlist",
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: AppTheme.maintheme().primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Setlists",
              style: TextStyle(
                fontWeight: AppTheme.headerFontWeight,
                fontSize: AppTheme.headerFontSize,
                color: AppTheme.accentMain,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Text("Manual"),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Title"),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Fresh"),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SetListTile(
                2,
                "Beethoven",
                [],
                () => _BuildDialog(
                  "Edit Setlist",
                  "Name",
                  "Change",
                  () {},
                ),
                () async {},
              ),
              SetListTile(1, "Mozart", [], () {}, () async {}),
            ],
          ),
        )
      ],
    );
  }
}
