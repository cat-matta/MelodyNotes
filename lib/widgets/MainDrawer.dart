import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              buildListTile(Icons.music_note, "Setlists", () {}),
              buildListTile(Icons.bookmark, "Bookmarks", () {}),
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
