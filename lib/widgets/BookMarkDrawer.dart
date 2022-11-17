import 'package:flutter/material.dart';
import 'package:melodynotes/themedata.dart';

class BookMarkDrawer extends StatefulWidget {
  final String? title;
  const BookMarkDrawer({Key? key, this.title}) : super(key: key);

  @override
  _BookMarksWidgetState createState() => _BookMarksWidgetState();
}

class _BookMarksWidgetState extends State<BookMarkDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //This is for changing color in Second Nav bar each button
  bool _hasBeenPressedP = true;
  bool _hasBeenPressedT = false;
  bool _hasBeenPressedF = false;
  // This is for initializing for state indexes
  int _selectedIndex = 0;
  int _navLeftButtonsIndex = 0;
  int _navBottomIndex1 = 0;
  int _navBottomIndex2 = 3;
  int _navBottomIndex3 = 1;
  // Function to control indexes for Body view
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //This function will control indexes for TOP LEFT nav bar
  void _onItemTappedNavLeftButtons(int index1) {
    setState(() {
      _navLeftButtonsIndex = index1;
    });
  }

  //This function will control indexes for TOP LEFT nav bar
  void _onItemTappedBottomNavButtons(
      int firstButton, int secondButton, int thirdButton) {
    setState(() {
      _navBottomIndex1 = firstButton;
      _navBottomIndex2 = secondButton;
      _navBottomIndex3 = thirdButton;
    });
  }

  //Same from SetlistDrawer.dart
  late TextEditingController _controller;

  //method called when the stateful widget is inserted in the widget tree
  //it will only run once and initilize and listeners/variables
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  //to get rid of the controller when it is no longer needed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// This is the body (We have three atm so, there is three list)
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'This is for Pages',
      ),
      Text(
        'This is for Title',
      ),
      Text(
        'This is for Flags',
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
        onPressed: () => {
          setState(() {
            _onItemTappedNavLeftButtons(2);
          })
        },
        icon: Icon(
          Icons.flag_outlined,
          color: Color.fromRGBO(131, 195, 163, 1),
        ),
      ),

      IconButton(
        onPressed: () => {
          setState(() {
            _onItemTappedNavLeftButtons(1);
          })
        },
        icon: Icon(
          Icons.flag_sharp,
          color: Color.fromRGBO(131, 195, 163, 1),
        ),
      ),
    ];

    // This is the availabe list options for  bottom nav bar
    List<Widget> _navbottom = <Widget>[
      IconButton(
        onPressed: () => {},
        icon: Icon(
          Icons.add,
          color: Color.fromRGBO(131, 195, 163, 1),
        ),
      ),
      TextButton(
          onPressed: () => {},
          child: const Text('Edit'),
          style: TextButton.styleFrom(
            primary: Color.fromRGBO(131, 195, 163, 1),
            backgroundColor: Color.fromRGBO(44, 44, 60, 1),
          )),
      IconButton(
        onPressed: () => {},
        icon: Icon(
          Icons.delete,
          color: Color.fromRGBO(131, 195, 163, 1),
        ),
      ),
      TextButton(
          onPressed: () => {},
          child: const Text(''),
          style: TextButton.styleFrom(
            primary: Color.fromRGBO(131, 195, 163, 1),
            backgroundColor: Color.fromRGBO(44, 44, 60, 1),
          )),
      TextButton(
          onPressed: () => {},
          child: const Text('Flag All'),
          style: TextButton.styleFrom(
            primary: Color.fromRGBO(131, 195, 163, 1),
            backgroundColor: Color.fromRGBO(44, 44, 60, 1),
          )),
    ];

    final mediaQuerry = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('BookMarks'),
          toolbarHeight: 56.0,
          leading: _navLeftButtons.elementAt(_navLeftButtonsIndex),
          leadingWidth: 100,
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
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
                            _onItemTapped(0);
                            _onItemTappedNavLeftButtons(0);
                            _onItemTappedBottomNavButtons(0, 3, 1);
                          })
                        },
                    child: const Text('Pages'),
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
                            _onItemTapped(1);
                            _onItemTappedNavLeftButtons(0);
                            _onItemTappedBottomNavButtons(0, 3, 1);
                          })
                        },
                    child: const Text('Title'),
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
                            _onItemTapped(2);
                            _onItemTappedNavLeftButtons(1);
                            _onItemTappedBottomNavButtons(2, 4, 3);
                          })
                        },
                    child: const Text('Flags'),
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
              Expanded(
                child: _widgetOptions.elementAt(_selectedIndex),
              )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
              color: Color.fromRGBO(44, 44, 60, 1),
              child: Row(
                children: [
                  Spacer(),
                  Spacer(),
                  _navbottom.elementAt(_navBottomIndex1),
                  Spacer(),
                  _navbottom.elementAt(_navBottomIndex2),
                  Spacer(),
                  _navbottom.elementAt(_navBottomIndex3),
                ],
              ))),
    );
  }
}
