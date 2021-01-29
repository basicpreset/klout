import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class LocalCache extends ChangeNotifier {
  int user_id = 1;
  MyUser user;
  List<MyPost> feedPosts;
  List<MyPost> localUserPosts;

  Future<void> loadUser(int id) async {
    ApiServices apiServices = ApiServices();
    user = await apiServices.getUser(this.user_id).then((value) {
      if (value.user_id != null) {
        notifyListeners();
      }
    });
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
