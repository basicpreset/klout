import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:vrep/Services/errorhandler.dart';

class ApiServices {
  ErrorHandler errorHandler = ErrorHandler();

  void httpConfig() {
    HttpOverrides.global = new MyHttpOverrides();
  }

  String baseUrl = 'https://localhost:5002/';

  // USER ENDPOINTS -----------------

  // 1. Get user
  Future<MyUser> getUser({String user_id}) async {
    MyUser user;
    await http.get(baseUrl + 'user/$user_id').then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = jsonDecode(value.body);
        user = MyUser.fromJson(jsonResponse);
        print('Successful User fetch: ${user.username}');
        return user;
      } else {
        print(
            'API Request error, status code: ${value.statusCode}, error: ${value}');
      }
    });
    return user;
  }

  // 2. Create user
  Future<MyUser> createUser(MyUser user) async {
    var jsonBody = jsonEncode(user.toJson());
    MyUser newUser;
    await http.post(baseUrl + 'user/create', body: jsonBody, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    }).then((value) => {
          newUser = MyUser.fromJson(
            jsonDecode(value.body),
          ),
        });
    return newUser;
  }

  // 3. Edit user
  Future<MyUser> editUser({MyUser user}) async {
    var jsonBody = jsonEncode(user.toJson());
    await http.post(
      baseUrl + 'user/${user.user_id}/edit',
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((value) {
      errorHandler.networkError(value.statusCode, task: 'editing user');
      if (value.statusCode == 200) {
        MyUser editedUser = MyUser.fromJson(jsonDecode(value.body));
        return editedUser;
      } else {
        return null;
      }
    });
  }

  // 4. Delete user
  Future<bool> deleteUser({String user_id}) async {
    await http.get(baseUrl + 'user/$user_id/delete').then((value) {
      errorHandler.networkError(value.statusCode, task: 'deleting user');
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }

  // 5. Follow user
  Future<bool> followUser({String follower_id, String following_id}) async {
    await http
        .get(baseUrl + 'user/$follower_id/follow/$following_id')
        .then((value) {
      if (value.statusCode == 200) {
        errorHandler.networkError(value.statusCode, task: 'following user');
        return true;
      } else {
        return false;
      }
    });
  }

  // 6. Unfollow user
  Future<bool> unfollowUser(
      {String unfollower_id, String unfollowed_id}) async {
    print('User $unfollower_id unfollowing $unfollowed_id');
    await http
        .get(baseUrl + 'user/$unfollower_id/unfollow/$unfollowed_id')
        .then((value) {
      print('statuscode: ${value.statusCode}');
      if (value.statusCode == 200) {
        errorHandler.networkError(value.statusCode, task: 'unfollowing user');
        return true;
      } else {
        return false;
      }
    });
  }

  // 7. Followers
  Future<List<String>> followers({String user_id}) async {
    await http.get(baseUrl + 'user/$user_id/followers').then((value) {
      errorHandler.networkError(value.statusCode, task: 'getting followers');
      if (value.statusCode == 200) {
        if (value.body != null) {
          return (value.body as List);
        } else
          return List<String>();
      } else {
        return null;
      }
    });
  }

  // 8. Following
  Future<List<String>> following({String user_id}) async {
    List<String> following = [];
    await http.get(baseUrl + 'user/$user_id/following').then((value) {
      errorHandler.networkError(value.statusCode, task: 'getting following');
      if (value.statusCode == 200) {
        var jsonBody = jsonDecode(value.body);
        following =
            (jsonBody as List<dynamic>).map((e) => e.toString()).toList();
      } else {
        return null;
      }
    });
    return following;
  }

  // 9. Get users
  Future<List<MyUser>> searchUsers({String query}) async {
    List<MyUser> users;
    await http.get(baseUrl + 'user/search').then((value) {
      if (value.statusCode == 200) {
        print('Successfully retrieved all users from server.');
        users = (jsonDecode(value.body) as List)
            .map((e) => MyUser.fromJson(e))
            .toList();
      } else {
        print(
            'Error: ${value.statusCode}, couldnt retrieve users from server.');
      }
    });
    return users;
  }
  // FEED ENDPOINTS -----------------

  // 1. Get post
  Future<MyPost> getPost({int post_id}) async {
    MyPost post;
    await http.get(baseUrl + 'post/$post_id').then((value) {
      if (value.statusCode == 200) {
        post = MyPost.fromJson(json: jsonDecode(value.body));
        return post;
      } else {
        print(
            'Error getting post(id: $post_id), status code: ${value.statusCode}');
        return null;
      }
    });
    return post;
  }

  // 2. Create post
  Future<MyPost> createPost({MyPost post}) async {
    var jsonBody = jsonEncode(post.toJson());
    MyPost newPost;
    await http.post(baseUrl + 'post/${post.user_id}/create',
        body: jsonBody,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }).then((value) {
      if (value.statusCode == 200) {
        newPost = MyPost.fromJson(json: jsonDecode(value.body));
        return newPost;
      } else {
        print(
            'Error creating post, status code: ${value.statusCode}, error: ${value.headers}');
        return null;
      }
    });
    return newPost;
  }

  // 3. Edit post
  Future<MyPost> editPost({int post_id, MyPost post}) async {
    var jsonBody = jsonEncode(post.toJson());
    MyPost newPost;
    await http.post(baseUrl + 'post/edit/$post_id', body: jsonBody, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    }).then((value) {
      if (value.statusCode == 200) {
        newPost = MyPost.fromJson(json: jsonDecode(value.body));
        return newPost;
      } else {
        print('Error editing post, status code: ${value.statusCode}');
        return null;
      }
    });
    return newPost;
  }

  // 4. Repost
  Future<MyPost> repostPost(
      {String user_id, MyPost post, int original_post_id}) async {
    var jsonBody = jsonEncode(post.toJson());
    MyPost newPost;
    await http.post(baseUrl + 'post/$user_id/repost/$original_post_id',
        body: jsonBody,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }).then((value) {
      if (value.statusCode == 200) {
        newPost = MyPost.fromJson(json: jsonDecode(value.body));
        return newPost;
      } else {
        print(
            'Error reposting post(id: $original_post_id), status code: ${value.statusCode}');
        return null;
      }
    });
    return newPost;
  }

  // 5. Delete post
  Future<bool> deletePost({String user_id, int post_id}) async {
    await http.get(baseUrl + 'post/$user_id/delete/$post_id').then((value) {
      if (value.statusCode == 200) {
        print('Successfully deleted post(id: $post_id');
        return true;
      } else {
        print('Error deleting post(id: $post_id)');
        return false;
      }
    });
  }

  // 6. Like post
  Future<int> likePost({String user_id, int post_id}) async {
    int likeCount;
    await http.get(baseUrl + 'post/$user_id/like/$post_id').then((value) {
      if (value.statusCode == 200) {
        print('Successfully liked post(id: $post_id');
        likeCount = jsonDecode(value.body);
      } else {
        print('Error liking post, status code: ${value.statusCode}');
        return null;
      }
    });
    return likeCount;
  }

  // 7. Dislike post
  Future<int> dislikePost({String user_id, int post_id}) async {
    int dislikeCount;
    await http.get(baseUrl + 'post/$user_id/dislike/$post_id').then((value) {
      if (value.statusCode == 200) {
        print('Successfully disliked post(id: $post_id');
        dislikeCount = jsonDecode(value.body);
      } else {
        print('Error disliking post, status code: ${value.statusCode}');
        return null;
      }
    });
    return dislikeCount;
  }

  // 8. Load feed of {user_id}
  Future<List<MyPost>> loadFeed(context, {String user_id}) async {
    List<MyPost> posts;
    await http.get(baseUrl + 'post/$user_id/feed').then((value) {
      if (value.statusCode == 200) {
        posts = (jsonDecode(value.body) as List)
            .map((e) => MyPost.fromJson(json: e))
            .toList();
        Provider.of<LocalCache>(context, listen: false).reloadFeed = false;
        Provider.of<LocalCache>(context, listen: false).setFeed(posts: posts);
        print('Successfully loaded feed of user(id: $user_id)');
        return posts;
      } else {
        print('Error loading feed of user(id: $user_id): ${value.statusCode}');
      }
    });
    return posts;
  }

  // 9. All posts of {user_id}
  Future<List<MyPost>> userPosts({String user_id}) async {
    List<MyPost> posts;
    await http.get(baseUrl + 'post/$user_id/all').then((value) {
      if (value.statusCode == 200) {
        posts = (jsonDecode(value.body) as List)
            .map((e) => MyPost.fromJson(json: e))
            .toList();
        print('Successfully loaded posts of user(id: $user_id)');
        return posts;
      } else {
        print('Error loading user(id: $user_id) posts: ${value.statusCode}');
      }
    });
    return posts;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
