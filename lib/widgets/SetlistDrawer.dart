import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';

class SetlistDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildListTile(int numItems, String text, VoidCallback function) {
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
        leading: Icon(
          Icons.edit_outlined,
          color: AppTheme.maintheme().iconTheme.color,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppTheme.maintheme().iconTheme.color,
        ),
        onTap: function,
      );
    }

    return Column(
      children: [
        Container(
          color: AppTheme.darkBackground,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: AppTheme.maintheme().iconTheme.color,
                ),
                tooltip: "Add Setlist",
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit_outlined,
                  color: AppTheme.maintheme().iconTheme.color,
                ),
                tooltip: "Edit",
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
              buildListTile(1, "Setlist Name", () {}),
              buildListTile(1, "Setlist Name2", () {}),
            ],
          ),
        )
      ],
    );
  }
}
