import 'package:flutter/material.dart';

import 'fridge/fridge_content.dart';
import 'history/history_content.dart';
import 'top5/top_five_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FridgeContent(),
    HistoryContent(),
    TopFiveContent(),
  ];

  void onPressed(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  //   return Scaffold(
  //     body: _children[_currentIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       onTap: onPressed, 
  //       currentIndex: 0, // this will be set when a new tab is tapped
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: new Icon(Icons.home),
  //           title: new Text('Home'),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: new Icon(Icons.mail),
  //           title: new Text('Messages'),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           title: Text('Profile')
  //         )
  //       ],
  //    ),
  //   );
  // }
}