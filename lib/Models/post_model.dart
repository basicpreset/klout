import 'package:uuid/uuid.dart';

class MyPost {
  int post_id;
  int user_id;
  String username;
  String user_img_url;
  String content;
  String image_url;
  DateTime created_on;
  int upvote_count;
  int downvote_count;
  int comment_count;
  int original_post_id;

  MyPost(
      {this.post_id,
      this.user_id,
      this.username,
      this.user_img_url,
      this.content,
      this.image_url,
      this.created_on,
      this.upvote_count,
      this.downvote_count,
      this.comment_count,
      this.original_post_id});

  MyPost.fromJson({var json}) {
    this.post_id = json['post_id'];
    this.user_id = json['user_id'];
    this.username = json['username'];
    this.user_img_url = json['user_img_url'];
    this.content = json['content'];
    this.image_url = json['image_url'];
    this.created_on = json['created_on'];
    this.upvote_count = json['upvote_count'];
    this.downvote_count = json['downvote_count'];
    this.comment_count = json['comment_count'];
    this.original_post_id = json['original_post_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': this.post_id,
      'user_id': this.user_id,
      'username': this.username,
      'user_img_url': this.user_img_url,
      'content': this.content,
      'image_url': this.image_url,
      'created_on': this.created_on,
      'upvote_count': this.upvote_count,
      'downvote_count': this.downvote_count,
      'comment_count': this.comment_count,
      'original_post_id': this.original_post_id,
    };
  }
}
