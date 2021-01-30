import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class LocalCache extends ChangeNotifier {
  int user_id = 1;
  MyUser user;
  List<MyPost> feedPosts;
  List<MyPost> localUserPosts;

  Future<void> loadUser(int id) async {
    ApiServices apiServices = ApiServices();
    user = await apiServices.getUser(this.user_id).then((value) {
      if (value.user_id != null) {
        notifyListeners();
      }
    });
  }
}
