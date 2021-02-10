import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Core/utilities.dart';
import 'package:vrep/Models/post_model.dart';

class Post_TopBar extends StatelessWidget {
  MyPost post;
  Post_TopBar({this.post});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          ClipRRect(
              child: Image(
                image: AssetImage('profile.jpg'),
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('@' + post.username),
          ),
          originIcon(),
          Spacer(),
          Text(Utilities.formatTime(createdOn: DateTime.parse(post.created_on)))
        ],
      ),
    ]);
  }

  Widget originIcon() {
    if (post.original_post_id == 0) {
      return Icon(
        Icons.edit,
        size: 16,
      );
    } else {
      return Icon(Icons.repeat);
    }
  }
}
