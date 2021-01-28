import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class ThisUserData extends ChangeNotifier {
  MyUser user = MyUser(
      user_id: 1,
      username: 'itsdanielworks',
      full_name: 'Reha Daniel',
      userbio: 'Lorem ipsum dolor sit amet, lorem ipsum dolor sit.',
      phone_number: '+36706136413',
      email: 'rehadaniel.personal@gmail.com',
      reg_date: DateTime.now(),
      post_count: 312,
      follower_count: 31412,
      following_count: 42);

  Future<void> loadUser(int id) async {
    ApiServices apiServices = ApiServices();
    
  }
}

class PostsData extends ChangeNotifier {
  List<MyPost> feedPosts = [];

  void upvote({int postId}) {
    feedPosts.firstWhere((element) => element.post_id == postId).upvote_count +=
        1;
    notifyListeners();
  }

  void downvote({int postId}) {
    feedPosts.firstWhere((element) => element.post_id == postId).upvote_count -=
        1;
    notifyListeners();
  }
}
