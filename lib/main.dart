import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

import './widgets/MainDrawer.dart';
import './screens/camera_screen.dart';

import 'themedata.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(AppEntry());
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
      },
    );
  }
}

class TopBar extends StatefulWidget {
  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);

    bool isDesktop(BuildContext context) {
      return mediaQuerry.size.width >= 600;
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
                ? Builder(builder: (context) {
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              showModalSideSheet(
                                context: context,
                                barrierDismissible: true,
                                withCloseControll: false,
                                body: MainDrawer(),
                                width: mediaQuerry.size.width * 0.7,
                              );
                            },
                            child: Icon(
                              Icons.menu,
                              size: 26.0,
                              color: AppTheme.maintheme().iconTheme.color,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.display_settings,
                              size: 26.0,
                              color: AppTheme.maintheme().iconTheme.color,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.collections_bookmark,
                              size: 26.0,
                              color: AppTheme.maintheme().iconTheme.color,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.library_music,
                              size: 26.0,
                              color: AppTheme.maintheme().iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                : Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalSideSheet(
                            context: context,
                            barrierDismissible: true,
                            withCloseControll: false,
                            body: MainDrawer(),
                            width: mediaQuerry.size.width * 0.7,
                          );
                        },
                        child: Icon(
                          Icons.menu,
                          size: 26.0,
                          color: AppTheme.maintheme().iconTheme.color,
                        ),
                      ),
                    );
                  }),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.draw,
                    size: 26.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CameraScreen.routeName);
                  },
                  child: Icon(
                    Icons.photo_camera,
                    size: 26.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.music_note,
                    size: 26.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.bookmark,
                    size: 26.0,
                  ),
                ),
              ),
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
