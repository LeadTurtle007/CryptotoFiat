import 'package:cryptoapp/chat.dart';
import 'package:cryptoapp/settings.dart';
import 'package:cryptoapp/tracker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [Tracker(), Chat(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        elevation: 5,
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,

        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.track_changes,
              color: Colors.black,
            ),
            title: new Text('Tracker'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add, color: Colors.black),
            title: new Text('Add Currency'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black),
              title: Text('Settings'))
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
