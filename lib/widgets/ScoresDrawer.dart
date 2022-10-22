import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:flutter/services.dart';

import './pdf_viewer_page.dart';
import 'dart:io' show Platform;
import 'dart:io';

class ScoreDrawer extends StatefulWidget {
  @override
  State<ScoreDrawer> createState() => _ScoresLibraryWidgetState();
}

class _ScoresLibraryWidgetState extends State<ScoreDrawer> {
  // String pathPDF = "";
  // String landscapePathPdf = "";
  // String remotePDFpath = "";
  // String corruptedPathPDF = "";
  //final scaffoldKey = GlobalKey<ScaffoldState>();
  String _version = 'Unknown';
  bool _showViewer = true;

  //This is for changing color in Second Nav bar each button
  bool _hasBeenPressedComposer = true;
  bool _hasBeenPressedGenres = false;
  bool _hasBeenPressedTags = false;
  bool _hasBeenPressedLabels = false;

  // This is for initializing for state indexes
  int _selectedIndex = 0;

  // Function to control indexes for Body view
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Same from SetlistDrawer.dart
  late TextEditingController _controller;

  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so use a try/catch PlatformException.
    try {
      // Initializes the PDFTron SDK, it must be called before you can use
      // any functionality.
      PdftronFlutter.initialize("your_pdftron_license_key");

      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, you want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  //method called when the stateful widget is inserted in the widget tree
  //it will only run once and initilize and listeners/variables
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    initPlatformState();
  }

  //to get rid of the controller when it is no longer needed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);

    Widget buildListTile(
      int numItems,
      String text,
      VoidCallback mainfunction,
      VoidCallback editFunction,
    ) {
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

    // This is the body (We have four atm so, there is four list)
    List<Widget> _widgetOptions = <Widget>[
      //scores filtered by composers
      ListView(
        padding: EdgeInsets.zero,

        //must create this list of list tiles dynamically
        children: [
          buildListTile(1, "Beethoven", () {}, () {}),
          buildListTile(4, "Mozart", () {}, () {}),
        ],
      ),

      //scores filtered by genres
      ListView(
        padding: EdgeInsets.zero,

        //list needs to be dynamically created
        children: [
          buildListTile(1, "Pop", () {}, () {}),
          buildListTile(1, "Classical", () {}, () {}),
        ],
      ),

      //scores filtered by tags
      ListView(
        padding: EdgeInsets.zero,

        //list needs to be dynamically created
        children: [
          buildListTile(1, "Easy", () {}, () {}),
          buildListTile(1, "Hard", () {}, () {}),
        ],
      ),

      //scores for labels
      ListView(
        padding: EdgeInsets.zero,

        //list needs to be dynamically created
        children: [
          buildListTile(1, "Label 1", () {}, () {}),
          buildListTile(1, "Label 2", () {}, () {}),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text(
            'Scores Library',
            textAlign: TextAlign.left,
          ),
          toolbarHeight: 56.0,
          // leading: TextButton(
          //     onPressed: () => {},
          //     child: const Text('Library'),
          //     style: TextButton.styleFrom(
          //       primary: Color.fromRGBO(131, 195, 163, 1),
          //     )),
          // leadingWidth: 100,
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      String url = '';
                      final file = await pickFile();
                      if (file == null) return;
                      url = file.path;
                      openPdf2(context, file, url);
                      // result = await FilePicker.platform.pickFiles(
                      //   type: FileType.custom,
                      //   allowedExtensions: ['pdf'],
                      // );
                      // if (result == null) return;

                      // file = result!.files.first;

                      // setState(() {});
                    },
                    child: const Text('Import'),
                    style: TextButton.styleFrom(
                      primary: Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: Color.fromRGBO(44, 44, 60, 1),
                    )),
                TextButton(
                    onPressed: () => {Navigator.pushNamed(context, '/')},
                    child: const Text('Back'),
                    style: TextButton.styleFrom(
                      primary: Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: Color.fromRGBO(44, 44, 60, 1),
                    )),
              ],
            )
          ]),
      body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(44, 44, 60, 1),
            toolbarHeight: 35.0,
            automaticallyImplyLeading: false,
            leadingWidth: mediaQuerry.size.width,
            title: Row(
              children: [
                //Spacer(),
                Spacer(),
                TextButton(
                  onPressed: () => {
                    setState(() {
                      _hasBeenPressedComposer = true;
                      _hasBeenPressedTags = false;
                      _hasBeenPressedGenres = false;
                      _hasBeenPressedLabels = false;
                      _onItemTapped(0);
                    })
                  },
                  child: const Text('Composers'),
                  style: TextButton.styleFrom(
                      primary: _hasBeenPressedComposer
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedComposer
                          ? Color.fromARGB(255, 90, 151, 118)
                          //: Color.fromRGBO(44, 44, 60, 1),
                          : AppTheme.darkBackground),
                ),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedGenres = true;
                            _hasBeenPressedComposer = false;
                            _hasBeenPressedTags = false;
                            _hasBeenPressedLabels = false;
                            _onItemTapped(1);
                          })
                        },
                    child: const Text('Genres'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedGenres
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedGenres
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedTags = true;
                            _hasBeenPressedComposer = false;
                            _hasBeenPressedGenres = false;
                            _hasBeenPressedLabels = false;
                            _onItemTapped(2);
                          })
                        },
                    child: const Text('Tags'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedTags
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedTags
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedTags = false;
                            _hasBeenPressedComposer = false;
                            _hasBeenPressedGenres = false;
                            _hasBeenPressedLabels = true;
                            _onItemTapped(3);
                          })
                        },
                    child: const Text('Labels'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedLabels
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedLabels
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                Spacer(),
                //Spacer(),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 8,
                  left: 8,
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (String value) async {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.accentSecondary,
                    ),
                    hintText: 'Search',
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
//Local

              //  Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       backgroundColor:
              //           MaterialStateProperty.all<Color>(Colors.amber),
              //     ),
              //     onPressed: () async {
              //       String url = '';
              //       final file = await pickFile();
              //       if (file == null) return;
              //       openPdf(context, file, url);
              //     },
              //     child: const Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text(
              //         'Press to Pick File from Local',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),

//External

              // const SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       backgroundColor:
              //           MaterialStateProperty.all<Color>(Colors.amber),
              //     ),
              //     onPressed: () async {
              //       const url =
              //           "http://www.africau.edu/images/default/sample.pdf";
              //       final file = await loadPdfFromNetwork(url);
              //       openPdf(context, file, url);
              //     },
              //     child: const Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text(
              //         'Press to Load File from Network',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: _widgetOptions.elementAt(_selectedIndex),
              // )
              // if (file != null) fileDetails(file!),
            ],
          )),
    );
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;
    return File(result.paths.first ?? '');
  }

  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );

  void openPdf2(BuildContext context, File file, String url) async {
    // opening without a config file will have all functionality enabled.
    // await PdftronFlutter.openDocument(_document);

    var config = Config();
    // How to disable functionality:
    //      config.disabledElements = [Buttons.shareButton, Buttons.searchButton];
    //      config.disabledTools = [Tools.annotationCreateLine, Tools.annotationCreateRectangle];
    // Other viewer configurations:
    //      config.multiTabEnabled = true;
    //      config.customHeaders = {'headerName': 'headerValue'};

    // An event listener for document loading
    var documentLoadedCancel = startDocumentLoadedListener((filePath) {
      print("document loaded: $filePath");
    });

    await PdftronFlutter.openDocument(url, config: config);

    try {
      // The imported command is in XFDF format and tells whether to add, modify or delete annotations in the current document.
      PdftronFlutter.importAnnotationCommand(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
              "    <xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">\n" +
              "      <add>\n" +
              "        <square style=\"solid\" width=\"5\" color=\"#E44234\" opacity=\"1\" creationdate=\"D:20200619203211Z\" flags=\"print\" date=\"D:20200619203211Z\" name=\"c684da06-12d2-4ccd-9361-0a1bf2e089e3\" page=\"1\" rect=\"113.312,277.056,235.43,350.173\" title=\"\" />\n" +
              "      </add>\n" +
              "      <modify />\n" +
              "      <delete />\n" +
              "      <pdf-info import-version=\"3\" version=\"2\" xmlns=\"http://www.pdftron.com/pdfinfo\" />\n" +
              "    </xfdf>");
    } on PlatformException catch (e) {
      print("Failed to importAnnotationCommand '${e.message}'.");
    }

    try {
      // Adds a bookmark into the document.
      PdftronFlutter.importBookmarkJson('{"0":"Page 1"}');
    } on PlatformException catch (e) {
      print("Failed to importBookmarkJson '${e.message}'.");
    }

    // An event listener for when local annotation changes are committed to the document.
    // xfdfCommand is the XFDF Command of the annotation that was last changed.
    var annotCancel = startExportAnnotationCommandListener((xfdfCommand) async {
      String command = xfdfCommand;
      print("flutter xfdfCommand:\n");
      // Dart limits how many characters are printed onto the console.
      // The code below ensures that all of the XFDF command is printed.
      if (command.length > 1024) {
        int start = 0;
        int end = 1023;
        while (end < command.length) {
          print(command.substring(start, end) + "\n");
          start += 1024;
          end += 1024;
        }
        print(command.substring(start));
      } else {
        print(command);
      }
    });

    // An event listener for when local bookmark changes are committed to the document.
    // bookmarkJson is JSON string containing all the bookmarks that exist when the change was made.
    var bookmarkCancel = startExportBookmarkListener((bookmarkJson) {
      print("flutter bookmark: $bookmarkJson");
    });

    var path = await PdftronFlutter.saveDocument();
    print("flutter save: $path");

    // To cancel event:
    // annotCancel();
    // bookmarkCancel();
    // documentLoadedCancel();
  }
}
