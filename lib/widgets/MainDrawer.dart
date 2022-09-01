import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

import 'package:musescore/themedata.dart';
import './SetlistDrawer.dart';
import 'BookMarkDrawer.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future showSetlistDrawer(BuildContext context, Widget body, double width) {
      return showModalSideSheet(
        context: context,
        barrierDismissible: true,
        body: body,
        width: MediaQuery.of(context).size.width * width,
      );
    }

    Future showBookMarkDrawer(BuildContext context, Widget body, double width) {
      return showModalSideSheet(
        context: context,
        barrierDismissible: true,
        withCloseControll: false,
        body: body,
        width: MediaQuery.of(context).size.width * width,
      );
    }

    Widget buildListTile(IconData icon, String text, VoidCallback function) {
      return ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: Icon(
          icon,
          color: AppTheme.maintheme().iconTheme.color,
        ),
        onTap: function,
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          color: AppTheme.maintheme().primaryColor,
          child: Image.asset(
            'assets/images/M.png',
            height: 100,
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              buildListTile(Icons.library_music, "Score Library", () {}),
              buildListTile(
                Icons.music_note,
                "Setlists",
                () {
                  showSetlistDrawer(
                    context,
                    SetlistDrawer(),
                    0.7,
                  );
                },
              ),
              buildListTile(Icons.bookmark, "Bookmarks", () {
                showBookMarkDrawer(
                  context,
                  BookMarkDrawer(),
                  0.7,
                );
              }),
              buildListTile(Icons.photo_camera, "Scan", () {}),
              buildListTile(Icons.draw, "Edit", () {}),
              buildListTile(Icons.display_settings, "Display Settings", () {}),
              buildListTile(Icons.collections_bookmark, "NOT SURE", () {}),
            ],
          ),
        )
      ],
    );
  }
}
