import 'package:flutter/material.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';

class LocalCache extends ChangeNotifier {
  bool reloadFeed = true;
  bool reloadProfile = true;

  String user_id;
  MyUser user;

  List<MyPost> feed = [];

  Future<MyUser> likePost({MyPost post}) async {
    bool alreadyLiked = false;
    int alreadyLikedId;
    bool disliked = false;
    int alreadyDislikedId;
    for (var like in user.likes) {
      if (like == post.post_id) {
        alreadyLiked = true;
        alreadyLikedId = like;
      }
    }
    if (!alreadyLiked) {
      user.likes.add(post.post_id);
    } else {
      user.likes.remove(alreadyLikedId);
    }
    for (var dislike in user.dislikes) {
      if (dislike == post.post_id) {
        disliked = true;
        alreadyDislikedId = dislike;
      }
    }
    if (disliked) {
      user.dislikes.remove(alreadyDislikedId);
    }
    notifyListeners();
    return this.user;
  }

  Future<MyUser> dislikePost({MyPost post}) async {
    bool alreadyDisliked = false;
    int alreadyDislikedId;
    bool liked = false;
    int alreadyLikedId;
    for (var dislike in user.dislikes) {
      if (dislike == post.post_id) {
        alreadyDisliked = true;
        alreadyDislikedId = dislike;
      }
    }
    if (!alreadyDisliked) {
      user.dislikes.add(post.post_id);
    } else {
      user.dislikes.remove(alreadyDislikedId);
    }
    for (var like in user.likes) {
      if (like == post.post_id) {
        liked = true;
        alreadyLikedId = like;
      }
    }
    if (liked) {
      user.likes.remove(alreadyLikedId);
    }
    notifyListeners();
    return this.user;
  }

  void updatePost({MyPost post}) {
    if (post.user_id == this.user_id) {
      user.posts.firstWhere((e) => e.post_id == post.post_id);
    } else {}
  }

  void setReloadFeed() {
    this.reloadFeed = true;
    notifyListeners();
  }

  void setReloadProfile() {
    this.reloadProfile = true;
    notifyListeners();
  }

  void setFeed({List<MyPost> posts}) {
    this.feed = posts;
    notifyListeners();
  }

  void addUserPost({MyPost post}) {
    this.user.posts.add(post);
    this.user.post_count++;
    notifyListeners();
  }

  void setUser({MyUser user}) {
    this.user = user;
    print('Likes: ${user.dislikes}');
    notifyListeners();
  }

  void setUID({String user_id}) {
    this.user_id = user_id;
    notifyListeners();
  }

  void removeUser() {
    this.user_id = '';
    this.user = null;
    notifyListeners();
  }

  void unfollowUser({String unfollowed_id}) {
    this.user.following.remove(unfollowed_id);
    notifyListeners();
  }

  void followUser({String following_id}) {
    this.user.following.add(following_id);
    notifyListeners();
  }

  void logout() {
    this.user_id = '';
    this.feed = [];
    this.reloadFeed = true;
    this.reloadProfile = true;
    this.user = null;
  }
}
