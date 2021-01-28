import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Screens/initialdetailspage.dart';
import 'package:vrep/Screens/otppage.dart';
import 'package:vrep/Screens/userpage.dart';
import 'package:vrep/Services/apiservices.dart';
import 'Models/user_model.dart';
import 'Screens/feedpage.dart';
import 'Screens/loginpage.dart';
import 'Screens/registerpage.dart';
import 'Screens/searchpage.dart';
import 'Screens/thisuserpage.dart';

void main() {
  ApiServices apiServices = ApiServices();
  apiServices.httpConfig();
  apiServices.getUser(1);
  runApp(MasterWidget());
}

class MasterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Proxima'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => NavigationCanvas(),
        '/register': (context) => RegisterPage(),
        '/otpverificationpage': (context) => OtpPage(),
        '/initialdetails': (context) => InitialDetailsPage(),
        '/navigationcanvas': (context) => NavigationCanvas()
      },
    );
  }
}

class NavigationCanvas extends StatefulWidget {
  @override
  _NavigationCanvasState createState() => _NavigationCanvasState();
}

class _NavigationCanvasState extends State<NavigationCanvas> {
  int _selectedIndex = 0;

  List pages = [FeedPage(), SearchPage(), ThisUserPage()];

  List headers = [];

  @override
  void initState() {
    super.initState();
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
