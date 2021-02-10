import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/like_model.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Services/apiservices.dart';

class Post_ReactionBar extends StatefulWidget {
  MyPost post;
  Post_ReactionBar({this.post});

  @override
  _Post_ReactionBarState createState() => _Post_ReactionBarState();
}

class _Post_ReactionBarState extends State<Post_ReactionBar> {
  ApiServices api;

  ReactionStatus reaction;

  bool error = false;

  bool cooldown = false;

  @override
  void initState() {
    api = ApiServices();
  }

  void getReactionState({MyUser user}) {
    if (user.likes.contains(widget.post.post_id)) {
      reaction = ReactionStatus.liked;
    } else if (user.dislikes.contains(widget.post.post_id)) {
      reaction = ReactionStatus.disliked;
    } else {
      reaction = ReactionStatus.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalCache>(builder: (context, cache, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: voteButton(
                    type: 'like',
                    post_id: widget.post.post_id,
                    user: cache.user),
                onTap: () {
                  if (!cooldown) {
                    cooldown = true;
                    cache.likePost(post: widget.post);
                    react(type: 'like');
                    api
                        .likePost(
                            user_id: cache.user_id,
                            post_id: widget.post.post_id)
                        .then((value) {
                      cooldown = false;
                      cache.reloadFeed = true;
                    });
                  }
                },
              ),
              Text(widget.post.likes_count.toString()),
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: voteButton(
                    type: 'dislike',
                    post_id: widget.post.post_id,
                    user: cache.user),
                onTap: () {
                  if (!cooldown) {
                    cooldown = true;
                    cache.dislikePost(post: widget.post);
                    react(type: 'dislike');
                    api
                        .dislikePost(
                            user_id: cache.user_id,
                            post_id: widget.post.post_id)
                        .then((value) {
                      cooldown = false;
                      cache.reloadFeed = true;
                    });
                  }
                },
              ),
              Text(widget.post.dislikes_count.toString()),
            ],
          ),
          Row(
            children: [
              Icon(Icons.comment, size: 18),
              SizedBox(
                width: 4,
              ),
              Text('${widget.post.comments_count.toString()} comments'),
            ],
          ),
        ],
      );
    });
  }

  Widget voteButton({String type, int post_id, MyUser user}) {
    getReactionState(user: user);
    switch (type) {
      case 'like':
        if (user.likes.contains(post_id)) {
          return Icon(Icons.keyboard_arrow_up, color: Colors.blue);
        }
        return Icon(Icons.keyboard_arrow_up);
        break;
      case 'dislike':
        if (user.dislikes.contains(post_id)) {
          return Icon(
            Icons.keyboard_arrow_down,
            color: Colors.red,
          );
        }
        return Icon(Icons.keyboard_arrow_down);
        break;
    }
    return SpinKitCircle(
      size: 16,
      color: Colors.blue,
    );
  }

  void react({String type}) {
    switch (type) {
      case 'like':
        switch (reaction) {
          case ReactionStatus.disliked:
            widget.post.dislikes_count--;
            widget.post.likes_count++;
            break;
          case ReactionStatus.liked:
            widget.post.likes_count--;
            break;
          case ReactionStatus.none:
            widget.post.likes_count++;
            break;
        }
        break;
      case 'dislike':
        switch (reaction) {
          case ReactionStatus.disliked:
            widget.post.dislikes_count--;
            break;
          case ReactionStatus.liked:
            widget.post.likes_count--;
            widget.post.dislikes_count++;
            break;
          case ReactionStatus.none:
            widget.post.dislikes_count++;
            break;
        }
        break;
    }
  }
}

enum ReactionStatus { liked, disliked, none }
