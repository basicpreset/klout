import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Services/apiservices.dart';

class InitialDetailsPage extends StatefulWidget {
  @override
  _InitialDetailsPageState createState() => _InitialDetailsPageState();
}

class _InitialDetailsPageState extends State<InitialDetailsPage> {
  TextEditingController _usernameController;
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  double _imageSize = 80;
  int _usernameLength;
  bool _isPwObscure = true;

  ApiServices api;

  void updateUsername() {
    setState(() {
      _usernameLength = _usernameController.text.length;
    });
  }

  void togglePassword() {
    setState(() {
      _isPwObscure = !_isPwObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    updateUsername();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Account details',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      'blankprofile.png',
                      width: _imageSize,
                      height: _imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username'),
                    Text('$_usernameLength/14'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          '@',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, counterText: ''),
                          maxLength: 14,
                          controller: _usernameController,
                          onChanged: (String username) {
                            updateUsername();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name'),
                    Text('0/32'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    controller: _nameController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /* Text(
                  'E-mail address',
                  textAlign: TextAlign.start,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    controller: _emailController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Password',
                  textAlign: TextAlign.start,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          controller: _passwordController,
                          obscureText: _isPwObscure,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          child: Icon(
                            Icons.visibility,
                            color: _isPwObscure ? Colors.grey : Colors.black,
                          ),
                          onTap: () {
                            togglePassword();
                          },
                        ),
                      )
                    ],
                  ),
                ), */
                Consumer<LocalCache>(builder: (context, data, child) {
                  return Expanded(
                    child: Center(
                      child: InkWell(
                        child: Text(
                          'Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          MyUser newUser = MyUser(
                              user_id: data.user_id,
                              username: _usernameController.text,
                              full_name: _nameController.text,
                              userbio: '',
                              phone_number: '',
                              email: _emailController.text,
                              reg_date: '2021-02-04T00:42:00',
                              post_count: 0,
                              follower_count: 0,
                              following_count: 0,
                              profile_img_url: '');
                          createUser(context, newUser);
                        },
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createUser(BuildContext context, MyUser user) async {
    await api.createUser(user).then((value) {
      if (value.user_id == user.user_id) {
        Provider.of<LocalCache>(context, listen: false).setUser(user: value);
        print('Successfully created user: ${value.user_id}');
        Navigator.pushNamedAndRemoveUntil(
            context, '/navigationcanvas', (route) => false);
      } else {}
    });
  }
}
