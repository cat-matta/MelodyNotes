import 'package:flutter/material.dart';
import 'package:musescore/themedata.dart';

class ScoreDrawer extends StatefulWidget {
  final String? title;
  const ScoreDrawer({Key? key, this.title}) : super(key: key);

  @override
  _BookMarksWidgetState createState() => _BookMarksWidgetState();
}

class _BookMarksWidgetState extends State<ScoreDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //This is for changing color in Second Nav bar each button
  bool _hasBeenPressedP = true;
  bool _hasBeenPressedT = false;
  bool _hasBeenPressedF = false;
    bool _hasBeenPressedL = false;

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
// This is the body (We have three atm so, there is three list)
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'This is for Composers',
      ),
      Text(
        'This is for Genres',
      ),
      Text(
        'This is for Tags',
      ),
       Text(
        'This is for Labels',
      ),
    ];
// This is for Top left Nav Bar Options
    List<Widget> _navLeftButtons = <Widget>[
//Option one: Indexes
      TextButton(
          onPressed: () => {},
          child: const Text('Indexs'),
          style: TextButton.styleFrom(
            primary: Color.fromRGBO(131, 195, 163, 1),
            backgroundColor: Color.fromRGBO(44, 44, 60, 1),
          )),
      // Option two: Flag with color and without color
      IconButton(
        onPressed: () => { },
        icon: Icon(
          Icons.flag_outlined,
          color: Color.fromRGBO(131, 195, 163, 1),
        ),
      ),

      IconButton(
        onPressed: () => { },
        icon: Icon(
          Icons.flag_sharp,
          color: Color.fromRGBO(131, 195, 163, 1),
        ),
      ),
    ];


    final mediaQuerry = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Scores'),
          toolbarHeight: 56.0,
          leading: TextButton(
              onPressed: () => {},
              child: const Text('Library'),
              style: TextButton.styleFrom(
                primary: Color.fromRGBO(131, 195, 163, 1),
              )),
          leadingWidth: 100,
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
                Spacer(),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedP = true;
                            _hasBeenPressedF = false;
                            _hasBeenPressedT = false;
                            _hasBeenPressedL = false;
                            _onItemTapped(0);
                  
                          })
                        },
                    child: const Text('Composers'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedP
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedP
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedT = true;
                            _hasBeenPressedP = false;
                            _hasBeenPressedF = false;
                            _hasBeenPressedL = false;
                            _onItemTapped(1);
                         
                          })
                        },
                    child: const Text('Genres'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedT
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedT
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedF = true;
                            _hasBeenPressedP = false;
                            _hasBeenPressedT = false;
                            _hasBeenPressedL = false;
                            _onItemTapped(2);

                          })
                        },
                    child: const Text('Tags'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedF
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedF
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                             Spacer(),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressedF = false;
                            _hasBeenPressedP = false;
                            _hasBeenPressedT = false;
                            _hasBeenPressedL = true;
                            _onItemTapped(3);
                          })
                        },
                    child: const Text('Labels'),
                    style: TextButton.styleFrom(
                      primary: _hasBeenPressedF
                          ? Color.fromARGB(255, 244, 247, 244)
                          : Color.fromRGBO(131, 195, 163, 1),
                      backgroundColor: _hasBeenPressedF
                          ? Color.fromARGB(255, 90, 151, 118)
                          : Color.fromRGBO(44, 44, 60, 1),
                    )),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomAppBar(
              color: Color.fromRGBO(44, 44, 60, 1),
              child: Row(
                children: [
                  Spacer(),
                    TextButton(
                      onPressed: () => { },
                      child: const Text('Import'),
                      style: TextButton.styleFrom(
                         primary : Color.fromRGBO(131, 195, 163, 1),
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
