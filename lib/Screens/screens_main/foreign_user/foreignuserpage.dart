import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Core/utilities.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/screens_main/foreign_user/foreign_user_topbar.dart';
import 'package:vrep/Screens/widgets/createpostpage.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Screens/widgets/usertrait.dart';
import 'package:vrep/Services/apiservices.dart';
import 'package:flutter/services.dart';

class ForeignUserPage extends StatefulWidget {
  String user_id;
  MyUser user;
  ForeignUserPage({this.user_id, this.user});
  @override
  _ForeignUserPageState createState() => _ForeignUserPageState();
}

class _ForeignUserPageState extends State<ForeignUserPage> {
  ApiServices api;

  bool loading = false;

  MyUser user;

  bool followInProgress = false;

  @override
  void initState() {
    super.initState();
    api = ApiServices();
    loadUser();
  }

  void loadUser() {
    if (widget.user == null) {
      setState(() {
        loading = true;
      });
      api.getUser(user_id: widget.user_id).then((value) {
        if (value != null) {
          user = value;
          setState(() {
            loading = false;
          });
        }
      });
    } else {
      this.user = widget.user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              /* mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, */
              //scrollDirection: Axis.horizontal,
              children: [
                loading
                    ? Text('loading')
                    : Consumer<LocalCache>(builder: (context, cache, child) {
                        return ForeignUserPage_TopBar(
                          foreignUser: user,
                          cacheUser: cache.user,
                        );
                      }),
                //SingleChildScrollView(
                Expanded(
                  child: ListView(
                    //shrinkWrap: true,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('profile.jpg'),
                              radius: 36,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  (loading
                                      ? Text('')
                                      : Text(Utilities.formatStats(
                                          user.post_count))),
                                  Text('Posts')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  (loading
                                      ? Text('')
                                      : Text(Utilities.formatStats(
                                          user.follower_count))),
                                  Text('Followers')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  (loading
                                      ? Text('')
                                      : Text(Utilities.formatStats(
                                          user.following_count))),
                                  Text('Following')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        (loading ? '' : user.full_name),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text('Lorem ipsum dolor sit amet.'),
                      UserTrait('Software Developer'),
                      FutureBuilder<List<MyPost>>(
                        future: api.userPosts(user_id: widget.user_id),
                        builder: (BuildContext ctxt,
                            AsyncSnapshot<List<MyPost>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SpinKitCircle(
                              color: Colors.blue,
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Center(
                              child: Text(
                                  "No connection, please try restarting the app."),
                            );
                          }
                          if (snapshot.data.isEmpty || snapshot.data == null) {
                            return Center(
                              child: Text("No posts found."),
                            );
                          }

                          return posts(posts: snapshot.data);
                        },
                      )
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

  Widget posts({List<MyPost> posts}) {
    if (posts != null) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: posts.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return PostWidget(
              post: posts[index],
            );
          });
    } else {
      return Expanded(
        child: Center(
          child: Text("No posts found."),
        ),
      );
    }
  }
}
