import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Screens/screens_auth/initialdetailspage.dart';
import 'package:vrep/Screens/screens_auth/otppage.dart';
import 'package:vrep/Screens/userpage.dart';
import 'package:vrep/Services/apiservices.dart';
import 'Models/user_model.dart';
import 'Screens/feedpage.dart';
import 'Screens/screens_auth/loginpage.dart';
import 'Screens/screens_auth/signup_emailpass.dart';
import 'Screens/screens_auth/signup_phone.dart';
import 'Screens/searchpage.dart';
import 'Screens/thisuserpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ApiServices apiServices = ApiServices();
  apiServices.httpConfig();
  runApp(MasterWidget());
}

class MasterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocalCache(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Proxima'),
        debugShowCheckedModeBanner: false,
        initialRoute: '/loading',
        routes: {
          '/loading': (context) => LoadingScreen(),
          '/': (context) => LoginPage(),
          '/signup_phone': (context) => PhoneSignUpPage(),
          '/signup_emailpass': (context) => EmailPassSignUpPage(),
          '/otpverificationpage': (context) => OtpPage(),
          '/initialdetails': (context) => InitialDetailsPage(),
          '/navigationcanvas': (context) => NavigationCanvas()
        },
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  ApiServices api;
  @override
  void initState() {
    super.initState();
    api = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    getAuthState(context);
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: SpinKitHourGlass(
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> getAuthState(context) async {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      Provider.of<LocalCache>(context, listen: false).user_id = user.uid;
      await api.getUser(user_id: user.uid).then((value) {
        if (value != null) {
          Provider.of<LocalCache>(context, listen: false).setUser(user: value);
          Navigator.pushNamedAndRemoveUntil(
              context, '/navigationcanvas', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/initialdetails', (route) => false);
        }
      });
    }
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
      body: ChangeNotifierProvider(
        create: (context) => LocalCache(),
        child: Container(
          //padding: EdgeInsets.only(left: 20, right: 20),
          child: pages[_selectedIndex],
        ),
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
