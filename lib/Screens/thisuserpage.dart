import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/addpostwindow.dart';
import 'package:vrep/Screens/widgets/createpost.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Screens/widgets/usertrait.dart';

class ThisUserPage extends StatefulWidget {
  @override
  _ThisUserPageState createState() => _ThisUserPageState();
}

class _ThisUserPageState extends State<ThisUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TOP HEADER
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('bgcity.jpg'), fit: BoxFit.cover)),
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
                              color: Colors.transparent,
                            ),
                            Text('@' + UserData.user.username,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            Icon(
                              Icons.image,
                              color: Colors.white,
                              size: 24,
                            )
                          ],
                        ),
                        Spacer(),
                        /* Text(
                          UserData.user.userbio,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ), */
                        ClipRRect(
                            child: Image(
                              image: AssetImage('profile.jpg'),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    formatStats(UserData.user.follower_count),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    formatStats(UserData.user.post_count),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),

            //UNDER HEADER -> Profile pic, details, feed, etc
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: MyTheme.padding_horizontal),
              child: Container(
                //transform: Matrix4.translationValues(0.0, -70, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Followers and stats
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(UserData.user.full_name,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                              Spacer(),
                              //Text('Edit profile'),
                              Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          UserTrait('Software developer'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(UserData.user.userbio),
                        ],
                      ),
                    ),

                    //Divider(),
                    //UPLOAD POST
                    CreatePost(),

                    // USER POSTS
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserPost(),
                        ],
                      ),
                    ),
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
    return null;
  }
}
