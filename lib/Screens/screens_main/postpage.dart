import 'package:flutter/material.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/utilities.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Screens/widgets/post_widget/post_reactionbar.dart';
import 'package:vrep/Screens/widgets/post_widget/post_topbar.dart';
import 'package:vrep/Services/apiservices.dart';

class PostPage extends StatefulWidget {
  MyPost post;
  PostPage({this.post});
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ApiServices api;
  @override
  void initState() {
    api = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: MyTheme.padding_horizontal,
                vertical: MyTheme.padding_vertical),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(Icons.keyboard_arrow_left),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text("${widget.post.username}'s post"),
                    Icon(Icons.report)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Post_TopBar(
                  post: widget.post,
                ),
                Post_ReactionBar(
                  post: widget.post,
                ),
                FutureBuilder(
                    future: api.getPost(post_id: widget.post.post_id),
                    builder: (BuildContext ctxt, AsyncSnapshot snapshot) {
                      return Expanded(
                        child: Center(
                          child: Text('Comments go here'),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
