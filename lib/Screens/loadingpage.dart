import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Services/apiservices.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  ApiServices api;
  @override
  void initState() {
    super.initState();
    api = ApiServices();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAuthState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      await Future.delayed(Duration(seconds: 1));
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
