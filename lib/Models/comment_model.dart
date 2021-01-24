import 'package:uuid/uuid.dart';

class VrepComment {
  final Uuid comment_id;
  final Uuid post_id;
  final Uuid user_id;
  final String content;
  final DateTime created_on;
  final int upvote_count;
  final int downvote_count;

  VrepComment({
    this.comment_id,
    this.post_id,
    this.user_id,
    this.content,
    this.created_on,
    this.upvote_count,
    this.downvote_count,
  });
}
