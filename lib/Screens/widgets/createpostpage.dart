import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/theme.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Services/apiservices.dart';
import 'package:vrep/Models/user_model.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController _postController;

  ApiServices api;

  int maxPostLength = 150;
  int currentPostLength = 0;

  bool creating = false;

  bool error = false;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
    api = ApiServices();
  }

  void updatePostLength() {
    setState(() {
      currentPostLength = _postController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MyTheme.padding_horizontal,
                vertical: MyTheme.padding_vertical),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('profile.jpg'),
                      radius: 12,
                    ),
                    Text('Create post'),
                    //Spacer(),
                    InkWell(
                      child: Icon(Icons.close),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: 'Start typing here...',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 150,
                  controller: _postController,
                  onChanged: (String text) {
                    updatePostLength();
                  },
                ),
                Spacer(),
                Row(
                  children: [
                    Text('$currentPostLength/150'),
                    Spacer(),
                    creating
                        ? SpinKitCircle(
                            color: Colors.blue,
                            size: 24,
                          )
                        : postButton(context),
                    error
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          )
                        : SizedBox(
                            width: 0,
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget postButton(context) {
    MyUser user = Provider.of<LocalCache>(context).user;
    return InkWell(
      child: Text('Post'),
      onTap: () async {
        setState(() {
          creating = true;
          error = false;
        });
        MyPost newPost = MyPost(
          post_id: 0,
          user_id: user.user_id,
          username: user.username,
          user_img_url: user.profile_img_url,
          post_content: _postController.text,
          post_img_url: '',
          created_on: DateTime.now().toString(),
          likes_count: 0,
          dislikes_count: 0,
          comments_count: 0,
          original_post_id: 0,
        );
        print(
            'User: ${user.username}, ${user.user_id}, ${newPost.post_content}');
        await api.createPost(post: newPost).then((value) {
          if (value != null) {
            Navigator.of(context).pop();
            Provider.of<LocalCache>(context, listen: false)
                .addUserPost(post: newPost);
            Provider.of<LocalCache>(context, listen: false).reloadProfile =
                true;
          } else {
            setState(() {
              creating = false;
              error = true;
            });
            return null;
          }
        });
      },
    );
  }
}
