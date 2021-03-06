import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';
import 'package:vrep/Services/authservices.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  ApiServices api;
  AuthService auth;
  @override
  void initState() {
    super.initState();
    api = ApiServices();
    auth = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalCache>(builder: (context, cache, child) {
      return Container(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Trending header
                Row(
                  children: [
                    Text(
                      'Feed',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                    InkWell(
                      child: Text('Log out'),
                      onTap: () {
                        logout(context);
                      },
                    )
                  ],
                ),
                // Feed view
                cache.reloadFeed
                    ? FutureBuilder(
                        future: api.loadFeed(context, user_id: cache.user_id),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<MyPost>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Expanded(
                              child: Center(
                                child: SpinKitCircle(
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          }
                          if (snapshot.data.isEmpty) {
                            return Text(
                                "Uh oh, looks like you don't follow anyone yet!");
                          }
                          return buildFeed(posts: snapshot.data);
                        },
                      )
                    : buildFeed(posts: cache.feed)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildFeed({List<MyPost> posts}) {
    if (posts != null && posts.length > 0) {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return PostWidget(
              post: posts[index],
            );
          },
        ),
      );
    } else {
      return Text("Uh oh, looks like you don't follow anyone yet!");
    }
  }

  Future<void> logout(BuildContext context) async {
    await auth.logout().then((value) {
      Provider.of<LocalCache>(context, listen: false).logout();
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    });
  }

  void reload() {
    setState(() {
      Provider.of<LocalCache>(context).reloadFeed = true;
    });
  }
}
