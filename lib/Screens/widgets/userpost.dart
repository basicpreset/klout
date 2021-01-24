import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vrep/Core/userdata.dart';

class UserPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Text('@' + UserData.user.username.toString() + ' megosztotta'),
                ),
                Spacer(),
                Text(getPostDate(UserData.post.created_on))
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Text(UserData.post.content, textAlign: TextAlign.start,),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.keyboard_arrow_up),
                    Text(UserData.post.upvote_count.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.keyboard_arrow_down),
                    Text(UserData.post.downvote_count.toString()),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment_outlined, size: 18),
                    Text('Hozzászólások (${UserData.post.comment_count.toString()})'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
