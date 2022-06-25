// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class BookMarksWidget extends StatefulWidget {
  static const routeName = '/bookMarks';
  final String? title;
  const BookMarksWidget({Key? key, this.title}) : super(key: key);

  @override
  _BookMarksWidgetState createState() => _BookMarksWidgetState();
}

class _BookMarksWidgetState extends State<BookMarksWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasBeenPressedP = true;
  bool _hasBeenPressedT = false;
  bool _hasBeenPressedF = false;
  

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

   // ignore: prefer_final_fields
   List<Widget> _widgetOptions = <Widget>[
    Text(
      'This is for Pages',
      style: optionStyle,
    ),
    Text(
      'This is for Title',
      style: optionStyle,
    ),
    Text(
      'This is for Flags',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    return Scaffold(
      appBar:
          AppBar(title: const Text('BookMarks'), toolbarHeight: 56.0, actions: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Close'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(44, 44, 60, 1),
                  ),
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
                          _hasBeenPressedP = !_hasBeenPressedP;
                          _hasBeenPressedF = false;
                          _hasBeenPressedT = false;
                          _onItemTapped(0);
                        })
                      },
                  child: const Text('Pages'),
                  style: TextButton.styleFrom(
                    primary: Color.fromRGBO(131, 195, 163, 1),
                    backgroundColor: _hasBeenPressedP
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromRGBO(44, 44, 60, 1),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () => {
                    
                        setState(() {
                          _hasBeenPressedT = !_hasBeenPressedT;
                          _hasBeenPressedP = false;
                          _hasBeenPressedF = false;
                          _onItemTapped(1);
                        })
                      },
                  child: const Text('Title'),
                  style: TextButton.styleFrom(
                    primary: Color.fromRGBO(131, 195, 163, 1),
                    backgroundColor: _hasBeenPressedT
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromRGBO(44, 44, 60, 1),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () => {
            
                        setState(() {
                          _hasBeenPressedF = !_hasBeenPressedF;
                          _hasBeenPressedP = false;
                          _hasBeenPressedT = false;
                         _onItemTapped(2);
                        })
                      },
                  child: const Text('Flags'),
                  style: TextButton.styleFrom(
                    primary: Color.fromRGBO(131, 195, 163, 1),
                    backgroundColor: _hasBeenPressedF
                        ? Color.fromARGB(255, 255, 255, 255)
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
      ),
    );
  }
}
