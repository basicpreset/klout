import 'dart:convert';
import 'dart:io';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  void httpConfig() {
    HttpOverrides.global = new MyHttpOverrides();
  }

  String baseUrl = 'https://localhost:5002/';

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

  Future<List<MyPost>> loadFeed({String user_id}) async {
    List<MyPost> posts;
    await http.get(baseUrl + 'post/$user_id/feed').then((value) {
      if (value.statusCode == 200) {
        posts = (jsonDecode(value.body) as List)
            .map((e) => MyPost.fromJson(json: e))
            .toList();
        print('Successful data fetch: $posts');
        return posts;
      } else {
        print('Error loading feed data: ${value.statusCode}');
      }
    });
    return posts;
  }

  Future<bool> likePost({int post_id}) async {
    await http.put(baseUrl + 'like/$post_id').then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        print('Error liking post, status code: ${value.statusCode}');
        return false;
      }
    });
    return true;
  }

  Future<bool> dislikePost({int post_id}) async {
    await http.put(baseUrl + 'dislike/$post_id').then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        print('Error disliking post, status code: ${value.statusCode}');
        return false;
      }
    });
    return true;
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
