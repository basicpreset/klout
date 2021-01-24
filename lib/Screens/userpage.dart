import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Screens/widgets/usertrait.dart';

class UserPage extends StatefulWidget {
  final User user;
  UserPage(this.user);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('tesla.jpg'), fit: BoxFit.cover)),
              child: Stack(children: [
                Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                            ),
                            Text('@' + widget.user.username,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            Icon(
                              Icons.send,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                          widget.user.userbio,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.person_add_alt_1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                transform: Matrix4.translationValues(0.0, -70, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile picture row
                    ClipRRect(
                        child: Image(
                          image: AssetImage('profile.jpg'),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(24)),
                    SizedBox(
                      height: 10,
                    ),
                    // USER TRAITS

                    UserTrait('Software developer'),
                    //Followers and stats
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.people),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              formatStats(widget.user.follower_count),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Icon(Icons.edit),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              formatStats(widget.user.post_count),
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    // USER POSTS
                    UserPost()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatStats(int statCount) {
    if (statCount < 10000) {
      return statCount.toString();
    } else if (statCount >= 10000 && statCount < 1000000) {
      double statDouble = (statCount.toDouble() / 1000);
      String statString = statDouble.toStringAsFixed(1) + 'K';
      return statString;
    } else if (statCount >= 1000000 && statCount < 1000000000) {
      double statDouble = (statCount.toDouble() / 1000000);
      String statString = statDouble.toStringAsFixed(1) + 'M';
      return statString;
    } else if (statCount >= 1000000000) {
      double statDouble = (statCount.toDouble() / 1000000000);
      String statString = statDouble.toStringAsFixed(1) + 'B';
      return statString;
    }
  }
}
