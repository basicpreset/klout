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

  MyPost post = MyPost(
/*           {this.post_id,
      this.user_id,
      this.username,
      this.user_img_url,
      this.content,
      this.image_url,
      this.created_on,
      this.upvote_count,
      this.downvote_count,
      this.comment_count,
      this.original_post_id}); */
      post_id: 1,
      user_id: 1,
      username: 'itsdanielworks',
      user_img_url: '',
      content: 'Lorem ipsum dolor sit amet.',
      created_on: DateTime(2021, 01, 27),
      upvote_count: 242,
      downvote_count: 23,
      comment_count: 42,
      original_post_id: null);
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
