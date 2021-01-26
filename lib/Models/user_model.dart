import 'package:uuid/uuid.dart';

class MyUser {
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

  MyUser({
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
