import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:melodyscore/providers/ScoresListProvider.dart';
import 'package:melodyscore/services/scores_service.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:melodyscore/providers/PdfFileProvider.dart';
import 'package:melodyscore/widgets/BookMarkDrawer.dart';
import 'package:melodyscore/widgets/ScoresDrawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import './widgets/MainDrawer.dart';
import './widgets/SetlistDrawer.dart';
import 'package:melodyscore/screens/scanner_screen.dart';
import './screens/camera_screen.dart';
import 'data/drift_db.dart';
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
        // ScannerScreen.routeName: (ctx) => ScannerScreen(),
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
            title: ScoreTitle(),
            leadingWidth: mediaQuerry.orientation == Orientation.landscape ||
                    isDesktop(context)
                ? mediaQuerry.size.width * 0.25
                : mediaQuerry.size.width * 0.15,
            leading: mediaQuerry.orientation == Orientation.landscape ||
                    isDesktop(context)
                ? Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildAppBarIcons(Icons.photo_camera, () {}),
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

class ScoreTitle extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScoreTitleState();
}

class _ScoreTitleState extends ConsumerState<ScoreTitle> {
  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    final int? fileId = prefs.getInt('file_id');
    if (fileId == null)
      return;
    else {
      ScoreService servObj = ScoreService();
      List<Score> listsOfScores = await servObj.getAllScores();

      Score cachedScore = ref
          .read(scoresListProvider.notifier)
          .getScorefromID(listsOfScores, fileId);
      print("cached score id: $fileId");
      ref.read(pdfFileProvider.notifier).giveFile(cachedScore);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var currentFile = ref.watch(pdfFileProvider);
    final MediaQueryData mediaQuerry = MediaQuery.of(context);

    return Container(
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
              child: currentFile.when(
                data: (data) => Text(
                  data.name,
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                error: ((error, stackTrace) => Text(
                      "Error picking file",
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    )),
                loading: () => Text(
                  "",
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.search),
              color: AppTheme.accentSecondary,
            ),
          ],
        ));
  }
}

class AppBody extends ConsumerStatefulWidget {
  // const AppBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBodyState();
}

class _AppBodyState extends ConsumerState<AppBody> {
  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    final int? fileId = prefs.getInt('file_id');

    if (fileId == null)
      return;
    else {
      ScoreService servObj = ScoreService();
      List<Score> listsOfScores = await servObj.getAllScores();

      Score cachedScore = ref
          .read(scoresListProvider.notifier)
          .getScorefromID(listsOfScores, fileId);
      print("cached score id: $fileId");
      ref.read(pdfFileProvider.notifier).giveFile(cachedScore);
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentFile = ref.watch(pdfFileProvider);

    return currentFile.when(
        data: (currentFile) {
          // return Text("$currentFile");
          print("Currently on: $currentFile");

          return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
            if (orientation == Orientation.landscape)
              return SfPdfViewer.file(File(currentFile.file));
            else
              return SfPdfViewer.file(File(currentFile.file),
                  pageLayoutMode: PdfPageLayoutMode.single);
          });
        },
        error: ((error, stackTrace) => Text("Err: $error")),
        loading: () => Center(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: AppTheme.darkBackground),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_note),
                          Icon(Icons.music_note),
                          Icon(Icons.music_note),
                        ],
                      ),
                      Spacer(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Welcome to MelodyScore! You can import a file by clicking on the ",
                              style: TextStyle(
                                color: AppTheme.accentMain,
                                fontSize: 20,
                              ),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.library_music, size: 20),
                            ),
                            TextSpan(
                              text: " above",
                              style: TextStyle(
                                color: AppTheme.accentMain,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Happy Playing!",
                        style:
                            TextStyle(color: AppTheme.accentMain, fontSize: 20),
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_note),
                          Icon(Icons.music_note),
                          Icon(Icons.music_note),
                        ],
                      ),
                      Spacer(),
                    ],
                  )),
            ));
  }
}
