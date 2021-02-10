import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Services/apiservices.dart';

class ForeignUserPage_TopBar extends StatefulWidget {
  MyUser foreignUser;
  MyUser cacheUser;
  ForeignUserPage_TopBar({this.foreignUser, this.cacheUser});
  @override
  _ForeignUserPage_TopBarState createState() => _ForeignUserPage_TopBarState();
}

class _ForeignUserPage_TopBarState extends State<ForeignUserPage_TopBar> {
  ApiServices api;

  bool followInProgress = false;

  @override
  void initState() {
    super.initState();
    api = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(Icons.keyboard_arrow_left),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            '@' + widget.foreignUser.username,
            style: TextStyle(fontSize: 16),
          ),
          Consumer<LocalCache>(builder: (context, cache, child) {
            return Row(
              children: [
                FutureBuilder<List<String>>(
                  future: api.following(user_id: cache.user_id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitCircle(
                        color: Colors.blue,
                        size: 24,
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.none) {
                      return Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    }

                    return followButton(context,
                        cache_user_id: cache.user_id,
                        user_id: widget.foreignUser.user_id,
                        following: snapshot.data);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Icon(Icons.send),
                ),
              ],
            );
          })
        ],
      ),
    );
  }

  Widget followButton(context,
      {String cache_user_id, String user_id, List<String> following}) {
    if (following.contains(user_id)) {
      return InkWell(
        child: Icon(Icons.how_to_reg, size: 24),
        onTap: () {
          setState(() {
            followInProgress = true;
          });
          api
              .unfollowUser(
                  unfollower_id: cache_user_id, unfollowed_id: user_id)
              .then((value) {
            setState(() {
              followInProgress = false;
            });
            Provider.of<LocalCache>(context, listen: false).setReloadFeed();
          });
        },
      );
    } else {
      return InkWell(
        child: Icon(Icons.person_add, size: 24),
        onTap: () {
          setState(() {
            followInProgress = true;
          });
          api
              .followUser(follower_id: cache_user_id, following_id: user_id)
              .then((value) {
            setState(() {
              followInProgress = false;
            });
            Provider.of<LocalCache>(context, listen: false).setReloadFeed();
          });
        },
      );
    }
  }
}
