import 'package:uuid/uuid.dart';

class MyPost {
  int post_id;
  int user_id;
  String username;
  String user_img_url;
  String post_content;
  String image_url;
  DateTime created_on;
  int likes_count;
  int dislikes_count;
  int comments_count;
  int original_post_id;

  MyPost(
      {this.post_id,
      this.user_id,
      this.username,
      this.user_img_url,
      this.post_content,
      this.image_url,
      this.created_on,
      this.likes_count,
      this.dislikes_count,
      this.comments_count,
      this.original_post_id});

  MyPost.fromJson({var json}) {
    this.post_id = json['post_id'];
    this.user_id = json['user_id'];
    this.username = json['username'];
    this.user_img_url = json['user_img_url'];
    this.post_content = json['post_content'];
    this.image_url = json['image_url'];
    this.created_on = DateTime.parse(json['created_on']);
    this.likes_count = json['likes_count'];
    this.dislikes_count = json['dislikes_count'];
    this.comments_count = json['comments_count'];
    this.original_post_id = json['original_post_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': this.post_id,
      'user_id': this.user_id,
      'username': this.username,
      'user_img_url': this.user_img_url,
      'post_content': this.post_content,
      'image_url': this.image_url,
      'created_on': this.created_on,
      'likes_count': this.likes_count,
      'dislikes_count': this.dislikes_count,
      'comments_count': this.comments_count,
      'original_post_id': this.original_post_id,
    };
  }
}
