import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';

class UserData {
  static MyUser user = MyUser(
      id: Uuid(),
      username: 'itsdanielworks',
      full_name: 'Reha Daniel',
      userbio: 'Lorem ipsum dolor sit amet, lorem ipsum dolor sit.',
      phone_number: '+36706136413',
      email: 'rehadaniel.personal@gmail.com',
      reg_date: DateTime.now(),
      post_count: 312,
      follower_count: 31412,
      following_count: 42);
  static Post post = Post(
      post_id: Uuid(),
      user_id: Uuid(),
      content: 'Dolor sit amet comet lorem ipsum dor simut.',
      image_url: 'URL',
      created_on: DateTime.now(),
      upvote_count: 313,
      downvote_count: 14,
      comment_count: 42);
}
