import 'dart:convert';
import 'dart:io';
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
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
