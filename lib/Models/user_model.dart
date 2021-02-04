import 'package:uuid/uuid.dart';

class MyUser {
  String user_id;
  String username;
  String full_name;
  String userbio;
  String phone_number;
  String email;
  String reg_date;
  int post_count;
  int follower_count;
  int following_count;
  String profile_img_url;
  String profile_cover_url;

  MyUser(
      {this.user_id,
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
      this.profile_cover_url});

  MyUser.fromJson(Map<String, dynamic> json) {
    this.user_id = json['user_id'];
    this.username = json['username'];
    this.full_name = json['full_name'];
    this.userbio = json['userbio'];
    this.phone_number = json['phone_number'];
    this.email = json['email'];
    this.reg_date = json['reg_date'];
    this.post_count = json['post_count'];
    this.follower_count = json['follower_count'];
    this.following_count = json['following_count'];
    this.profile_img_url = json['profile_img_url'];
    this.profile_cover_url = json['profile_cover_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': this.user_id,
      'username': this.username,
      'full_name': this.full_name,
      'userbio': this.userbio,
      'phone_number': this.phone_number,
      'email': this.email,
      'reg_date': this.reg_date,
      'post_count': this.post_count,
      'follower_count': this.follower_count,
      'following': this.following_count,
      'profile_img_url': this.profile_img_url,
      'profile_cover_url': this.profile_cover_url
    };
  }
}
