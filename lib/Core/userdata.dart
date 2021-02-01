import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class LocalCache extends ChangeNotifier {
  String user_id = 'J8pfvmGJLEX1Fz23YXG2aqRBP5I2';
  MyUser user = MyUser(
      user_id: 'ghtialdor',
      username: 'itsdanielworks',
      full_name: 'Reha Daniel',
      userbio: 'I made a social media app so I could get myself verified',
      email: 'rehadaniel@gmail.com',
      reg_date: DateTime.now(),
      post_count: 124,
      follower_count: 421242,
      following_count: 32,
      profile_img_url: '',
      profile_cover_url: '');

/*         {this.user_id,
      this.username,
      this.full_name,
      this.userbio,
      this.phone_number,
      this.email,
      this.reg_date,
      this.post_count,
      this.follower_count,
      this.following_count,
      this.profile_img_url,
      this.profile_cover_url}); */

  List<MyPost> feedPosts;
  List<MyPost> localUserPosts;

  List<int> likedPosts = [1];
  List<int> dislikedPosts = [2];

  void loadUser(int id) async {
    ApiServices apiServices = ApiServices();
    user = await apiServices.getUser(this.user_id).then((value) {
      if (value != null) {
        this.user = value;
        notifyListeners();
      } else {
        print('Error loading user into cache!');
      }
    });
  }

  void loadFollowing(String user_id) {
    ApiServices apiServices = ApiServices();
  }
}
