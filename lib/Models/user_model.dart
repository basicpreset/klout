import 'package:uuid/uuid.dart';
import 'package:vrep/Models/comment_model.dart';
import 'package:vrep/Models/post_model.dart';

class User {
  final Uuid id;
  final String username;
  final String name;
  final String userbio;
  final String phone_number;
  final String email;
  final DateTime reg_date;
  final int post_count;
  final int follower_count;
  final double karma;

  User({
    this.id,
    this.username,
    this.name,
    this.userbio,
    this.phone_number,
    this.email,
    this.reg_date,
    this.post_count,
    this.follower_count,
    this.karma,
  });
}
