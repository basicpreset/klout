import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Screens/loadingpage.dart';
import 'package:vrep/Screens/screens_auth/initialdetailspage.dart';
import 'package:vrep/Screens/screens_auth/otppage.dart';
import 'package:vrep/Services/apiservices.dart';
import 'Screens/screens_auth/loginpage.dart';
import 'Screens/screens_auth/signup_emailpass.dart';
import 'Screens/screens_auth/signup_phone.dart';
import 'Screens/screens_main/feedpage.dart';
import 'Screens/screens_main/searchpage.dart';
import 'Screens/screens_main/thisuserpage.dart';

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
          '/loading': (context) => LoadingPage(),
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
        ));
  }
}
