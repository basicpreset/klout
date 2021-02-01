import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Models/post_model.dart';

class PostWidget extends StatelessWidget {
  MyPost post;
  PostWidget({this.post});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalCache>(builder: (context, cache, child) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('profile.jpg'),
                    radius: 12,
                  ),
                  //Icon(Icons.repeat),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('@' + post.username + ' megosztotta'),
                  ),
                  Spacer(),
                  Text(getPostDate(post.created_on))
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                post.post_content,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          child: voteButton(
                              type: 'like',
                              post_id: post.post_id,
                              likedPosts: cache.likedPosts,
                              dislikedPosts: cache.dislikedPosts)),
                      Text(post.likes_count.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          child: voteButton(
                              type: 'dislike',
                              post_id: post.post_id,
                              likedPosts: cache.likedPosts,
                              dislikedPosts: cache.dislikedPosts)),
                      Text(post.dislikes_count.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment_outlined, size: 18),
                      Text('Hozzászólások (${post.comments_count.toString()})'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  String getPostDate(DateTime created_on) {
    String date = created_on.month.toString() +
        '.' +
        created_on.day.toString() +
        '.' +
        created_on.year.toString();
    return date;
  }

  Widget voteButton(
      {String type,
      int post_id,
      List<int> likedPosts,
      List<int> dislikedPosts}) {
    switch (type) {
      case 'like':
        if (likedPosts.contains(post_id) && likedPosts.isNotEmpty) {
          return Icon(
            Icons.keyboard_arrow_up,
            color: Colors.blue,
          );
        }
        return Icon(Icons.keyboard_arrow_up);
        break;
      case 'dislike':
        if (dislikedPosts.contains(post_id) && dislikedPosts.isNotEmpty) {
          return Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue,
          );
        }
        return Icon(Icons.keyboard_arrow_down);
        break;
    }
    return SpinKitCircle(
      size: 16,
    );
  }
}
