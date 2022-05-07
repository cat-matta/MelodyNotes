import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            titleSpacing: 2.3,
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
                    Text(
                      "Piece",
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.search),
                      color: AppTheme.accentSecondary,
                    ),
                  ],
                )),
            leadingWidth: mediaQuerry.size.width,
            leading: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.display_settings),
                  color: AppTheme.maintheme().iconTheme.color,
                  onPressed: () {
                    // handle the press
                  },
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.music_note),
                  color: AppTheme.maintheme().iconTheme.color,
                  onPressed: () {
                    // handle the press
                  },
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmarks),
                  color: AppTheme.maintheme().iconTheme.color,
                  onPressed: () {
                    // handle the press
                  },
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.collections_bookmark),
                  color: AppTheme.maintheme().iconTheme.color,
                  onPressed: () {
                    // handle the press
                  },
                ),
                Spacer(),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Spacer(),
                  IconButton(
                    icon: const Icon(Icons.draw),
                    tooltip: 'Open shopping cart',
                    onPressed: () {
                      // handle the press
                    },
                  ),
                  // Spacer(),
                  IconButton(
                    icon: const Icon(Icons.library_music),
                    tooltip: 'Open shopping cart',
                    onPressed: () {
                      // handle the press
                    },
                  ),
                  // Spacer(),
                  IconButton(
                    icon: const Icon(Icons.photo_camera),
                    tooltip: 'Open shopping cart',
                    onPressed: () {
                      // handle the press
                    },
                  ),
                  // Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: 'Open shopping cart',
                    onPressed: () {
                      // handle the press
                    },
                  ),
                  // Spacer(),
                ],
              )
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
