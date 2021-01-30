import 'dart:convert';
import 'dart:io';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  void httpConfig() {
    HttpOverrides.global = new MyHttpOverrides();
  }

  String baseUrl = 'https://localhost:5001/';
  Future<MyUser> getUser(int id) async {
    await http.get(baseUrl + 'user/$id').then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = jsonDecode(value.body);
        MyUser user = MyUser.fromJson(jsonResponse);
        print('Successful User fetch: ${user.username}');
        return user;
      } else {
        print(
            'API Request error, status code: ${value.statusCode}, error: ${value}');
      }
    });
  }

  Future<List<MyPost>> loadFeed(List<int> following) async {
    List<MyPost> posts;
    await http.post(baseUrl + 'post/following',
        body: jsonEncode(following),
        headers: {'Content-Type': 'application/json'}).then((value) {
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
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
