import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';

class ScoreDrawer extends StatefulWidget {
  @override
  State<ScoreDrawer> createState() => _ScoresLibraryWidgetState();
}

class _ScoresLibraryWidgetState extends State<ScoreDrawer> {
  //final scaffoldKey = GlobalKey<ScaffoldState>();

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
          title: const Text(
            'Scores Library',
            textAlign: TextAlign.center,
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
          body: Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomAppBar(
              color: Color.fromRGBO(44, 44, 60, 1),
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () => {},
                      child: const Text('Import'),
                      style: TextButton.styleFrom(
                        primary: Color.fromRGBO(131, 195, 163, 1),
                      )),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  TextButton(
                      onPressed: () => {},
                      child: const Text('Edit'),
                      style: TextButton.styleFrom(
                        primary: Color.fromRGBO(131, 195, 163, 1),
                      )),
                  Spacer(),
                ],
              ))),
    );
  }
}
