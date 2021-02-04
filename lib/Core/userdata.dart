import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class LocalCache extends ChangeNotifier {
  String user_id;
  MyUser user = MyUser(
      user_id: 'ghtialdor',
      username: 'itsdanielworks',
      full_name: 'Reha Daniel',
      userbio: 'I made a social media app so I could get myself verified',
      email: 'rehadaniel@gmail.com',
      reg_date: DateTime.now().toString(),
      post_count: 124,
      follower_count: 421242,
      following_count: 32,
      profile_img_url: '',
      profile_cover_url: '');

  List<MyPost> feedPosts;
  List<MyPost> localUserPosts;

  List<int> likedPosts = [1];
  List<int> dislikedPosts = [2];

  void setFeed({List<MyPost> posts}) {
    this.feedPosts = posts;
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
