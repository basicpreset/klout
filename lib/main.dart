import 'package:flutter/material.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Screens/userpage.dart';
import 'Models/user_model.dart';
import 'Screens/feedpage.dart';
import 'Screens/searchpage.dart';

void main() {
  runApp(MasterWidget());
}

class MasterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Proxima'),
      home: NavigationCanvas(user: UserData.user),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavigationCanvas extends StatefulWidget {
  User user;
  NavigationCanvas({this.user});
  @override
  _NavigationCanvasState createState() => _NavigationCanvasState();
}

class _NavigationCanvasState extends State<NavigationCanvas> {
  int _selectedIndex = 0;

  List pages = [FeedPage(), SearchPage()];

  List headers = [];

  @override
  void initState() {
    super.initState();
    pages.add(UserPage(widget.user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.only(left: 20, right: 20),
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
      ),
    );
  }
}
