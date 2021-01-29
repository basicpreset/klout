import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Models/post_model.dart';

class PostWidget extends StatelessWidget {
  MyPost post;
  PostWidget({this.post});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalCache>(builder: (context, data, child) {
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
                    child: Text(
                        '@' + data.post.username.toString() + ' megosztotta'),
                  ),
                  Spacer(),
                  Text(getPostDate(data.post.created_on))
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                data.post.content,
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
                      Icon(Icons.keyboard_arrow_up),
                      Text(data.post.upvote_count.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.keyboard_arrow_down),
                      Text(data.post.downvote_count.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment_outlined, size: 18),
                      Text(
                          'Hozzászólások (${data.post.comment_count.toString()})'),
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
}
