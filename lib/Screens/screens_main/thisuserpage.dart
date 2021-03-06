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
import 'package:vrep/Screens/widgets/createpostpage.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Screens/widgets/usertrait.dart';
import 'package:vrep/Services/apiservices.dart';

class ThisUserPage extends StatefulWidget {
  @override
  _ThisUserPageState createState() => _ThisUserPageState();
}

class _ThisUserPageState extends State<ThisUserPage> {
  ApiServices api;
  @override
  void initState() {
    super.initState();
    api = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalCache>(builder: (context, cache, child) {
      return Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              /* mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, */
              //scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '@' + cache.user.username,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
/*                     Icon(
                        Icons.add,
                        size: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ), */
                      InkWell(
                        child: Icon(
                          Icons.edit,
                          size: 24,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: CreatePostPage(),
                                curve: Curves.decelerate,
                                duration: Duration(milliseconds: 200)),
                          );
                        },
                      )
                    ],
                  ),
                ),
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
                                  Text(Utilities.formatStats(
                                      cache.user.post_count)),
                                  Text('Posts')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(Utilities.formatStats(
                                      cache.user.follower_count)),
                                  Text('Followers')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(Utilities.formatStats(
                                      cache.user.following_count)),
                                  Text('Following')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        cache.user.full_name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text('Lorem ipsum dolor sit amet.'),
                      UserTrait('Software Developer'),
/*                       cache.reloadProfile
                          ? FutureBuilder<List<MyPost>>(
                              future: api.thisUserPosts(context,
                                  user_id: cache.user_id),
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
                                if (snapshot.data == null) {
                                  return Center(
                                    child: Text("No posts found."),
                                  );
                                }

                                return posts(posts: snapshot.data);
                              },
                            )
                          : posts(posts: cache.user.posts), */
                      posts(posts: cache.user.posts)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
