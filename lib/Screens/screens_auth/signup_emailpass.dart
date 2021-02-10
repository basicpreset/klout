import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Services/authservices.dart';

class EmailPassSignUpPage extends StatefulWidget {
  @override
  _EmailPassSignUpPageState createState() => _EmailPassSignUpPageState();
}

class _EmailPassSignUpPageState extends State<EmailPassSignUpPage> {
  TextEditingController _emailController;

  TextEditingController _passController;

  AuthService authService;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalCache>(builder: (context, data, child) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.keyboard_arrow_left),
                      ),
                      Text(
                        'Registration',
                        textAlign: TextAlign.center,
                      ),
                      Icon(Icons.info_outline)
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('E-mail'),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12)),
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12)),
                            controller: _passController,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Text(
                                'Continue',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                createAccount(context);
                              },
                            ),
                            Text(this.errorMessage)
                          ],
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
    });
  }

  void createAccount(BuildContext context) async {
    print('Password: ${_passController.text}');
    await authService
        .createAccount(
      email: _emailController.text,
      password: _passController.text,
    )
        .then((value) {
      if (value[0] == 'success') {
        Provider.of<LocalCache>(context, listen: false)
            .setUID(user_id: value[1]);
        Navigator.pushNamedAndRemoveUntil(
            context, '/initialdetails', (route) => false);
      } else {
        setState(() {
          errorMessage = value[1];
        });
      }
    });
  }
}
