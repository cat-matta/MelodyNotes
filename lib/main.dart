import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:musescore/widgets/BookMarkDrawer.dart';
import 'package:musescore/widgets/ScoresDrawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './widgets/MainDrawer.dart';
import './widgets/SetlistDrawer.dart';
import 'package:musescore/screens/scanner_screen.dart';
import './screens/camera_screen.dart';
import 'locator.dart' as injector;

import 'themedata.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.setupLocator();
  cameras = await availableCameras();
  runApp(ProviderScope(child: AppEntry()));
}

class AppEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.maintheme(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: TopBar()),
      initialRoute: '/',
      routes: {
        CameraScreen.routeName: (ctx) => CameraScreen(cameras: cameras),
        ScannerScreen.routeName: (ctx) => ScannerScreen(),
      },
    );
  }
}

class TopBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopBarState();
}

class _TopBarState extends State {
  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    List<VoidCallback> menuFunctions = [];

    bool isDesktop(BuildContext context) {
      return mediaQuerry.size.width >= 700;
    }

    Future showMainDrawer(BuildContext context, Widget body, double width) {
      return showModalSideSheet(
        context: context,
        barrierDismissible: true,
        body: body,
        width: mediaQuerry.size.width * width,
      );
    }

    Future showSetlistDrawer(BuildContext context, Widget body, double width) {
      return showModalSideSheet(
        context: context,
        barrierDismissible: true,
        body: body,
        width: mediaQuerry.size.width * width,
      );
    }

    Future showBookMarkDrawer(BuildContext context, Widget body, double width) {
      return showModalSideSheet(
        context: context,
        barrierDismissible: true,
        withCloseControll: false,
        body: body,
        width: mediaQuerry.size.width * width,
      );
    }

    Future showScoreDrawer(BuildContext context, Widget body, double width) {
      return showModalSideSheet(
        context: context,
        barrierDismissible: true,
        withCloseControll: false,
        body: body,
        width: mediaQuerry.size.width * width,
      );
    }

    Widget buildAppBarIcons(IconData icon, VoidCallback function) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: function,
          child: Icon(
            icon,
            size: 26.0,
            color: AppTheme.maintheme().iconTheme.color,
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            titleSpacing: 0.0,
            title: Container(
                // alignment: Alignment.center,
                width: mediaQuerry.size.width * 0.5,
                decoration: BoxDecoration(
                    color: AppTheme.lightBackground,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.settings),
                      color: AppTheme.accentSecondary,
                    ),
                    Flexible(
                      child: Text(
                        "River Flows in You",
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.search),
                      color: AppTheme.accentSecondary,
                    ),
                  ],
                )),
            leadingWidth: mediaQuerry.orientation == Orientation.landscape ||
                    isDesktop(context)
                ? mediaQuerry.size.width * 0.25
                : mediaQuerry.size.width * 0.15,
            leading: mediaQuerry.orientation == Orientation.landscape ||
                    isDesktop(context)
                ? Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildAppBarIcons(Icons.photo_camera, () {
                        Navigator.pushNamed(context, CameraScreen.routeName);
                      }),
                      buildAppBarIcons(Icons.draw, () {}),
                      buildAppBarIcons(Icons.display_settings, () {}),
                      buildAppBarIcons(Icons.collections_bookmark, () {}),
                    ],
                  )
                : buildAppBarIcons(Icons.draw, () {}),
            actions: [
              buildAppBarIcons(Icons.library_music, () {
                showScoreDrawer(
                  context,
                  ScoreDrawer(),
                  0.7,
                );
              }),
              buildAppBarIcons(Icons.music_note, () {
                showSetlistDrawer(
                  context,
                  SetlistDrawer(),
                  0.7,
                );
              }),
              buildAppBarIcons(Icons.bookmark, () {
                showBookMarkDrawer(
                  context,
                  BookMarkDrawer(),
                  0.7,
                );
              }),
              buildAppBarIcons(Icons.menu, () {
                showMainDrawer(context, MainDrawer(), 0.7);
              }),
            ]),
        body: AppBody());
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
