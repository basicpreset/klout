import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class LocalCache extends ChangeNotifier {
  bool reloadFeed = true;
  bool reloadProfile = true;
  String user_id;
  MyUser user;

  List<MyPost> feedPosts;
  List<MyPost> thisUserPosts;

  List<int> likedPosts = [1];
  List<int> dislikedPosts = [2];

  void setFeed({List<MyPost> posts}) {
    this.feedPosts = posts;
    notifyListeners();
  }

  void setUserPosts({List<MyPost> posts}) {
    this.thisUserPosts = posts;
    notifyListeners();
  }

  void setUser({MyUser user}) {
    this.user = user;
    notifyListeners();
  }

  void setUID({String user_id}) {
    this.user_id = user_id;
    notifyListeners();
  }

  void removeUser() {
    this.user_id = '';
    this.user = null;
    notifyListeners();
  }
}
