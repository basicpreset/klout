import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Services/apiservices.dart';
import 'package:vrep/Services/authservices.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passController;

  AuthService authService;
  ApiServices api;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();

    authService = AuthService();
    api = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: MyTheme.padding_horizontal,
                vertical: MyTheme.padding_vertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Text('E-mail'),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                      controller: _emailController,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Password'),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                    controller: _passController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    InkWell(
                      child: Text(
                        'Login',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        login(context);
                      },
                    ),
                  ],
                ),
                Text(errorMessage),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          "Sign up for an account",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/signup_emailpass');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    await authService
        .login(
      email: _emailController.text,
      password: _passController.text,
    )
        .then((value) {
      if (value[0] == 'success') {
        Provider.of<LocalCache>(context, listen: false)
            .setUID(user_id: value[1]);
        api.getUser(user_id: value[1]).then((value) {
          Provider.of<LocalCache>(context, listen: false).setUser(user: value);
          Navigator.pushNamedAndRemoveUntil(
              context, '/navigationcanvas', (route) => false);
        });
      } else {
        setState(() {
          errorMessage = value[1];
        });
      }
    });
  }
}
