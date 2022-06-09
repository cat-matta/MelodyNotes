import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
