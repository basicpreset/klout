import 'package:flutter/material.dart';
import 'package:vrep/Models/post_model.dart';

class Post_ContentBar extends StatelessWidget {
  MyPost post;
  Post_ContentBar({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        post.post_content,
        textAlign: TextAlign.start,
      ),
    );
  }
}
