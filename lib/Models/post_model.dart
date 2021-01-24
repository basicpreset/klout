import 'package:uuid/uuid.dart';

class Post {
  final Uuid post_id;
  final Uuid user_id;
  final String content;
  final String image_url;
  final DateTime created_on;
  final int upvote_count;
  final int downvote_count;
  final int comment_count;

  Post(
      {this.post_id,
      this.user_id,
      this.content,
      this.image_url,
      this.created_on,
      this.upvote_count,
      this.downvote_count,
      this.comment_count});
}
