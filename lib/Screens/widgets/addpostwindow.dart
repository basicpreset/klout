import 'package:flutter/material.dart';
import 'package:vrep/Core/userdata.dart';

class AddPostWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('profile.jpg'),
                  radius: 12,
                ),
                Text('Creating post'),
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
              decoration: InputDecoration(border: InputBorder.none),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autofocus: true,
              textAlignVertical: TextAlignVertical.top,
            ),
            Spacer(),
            Row(
              children: [
                Text('0/150'),
                Spacer(),
                InkWell(
                  child: Text('Post'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
