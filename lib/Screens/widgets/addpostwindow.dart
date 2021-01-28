import 'package:flutter/material.dart';
import 'package:vrep/Core/userdata.dart';

class AddPostWindow extends StatefulWidget {
  @override
  _AddPostWindowState createState() => _AddPostWindowState();
}

class _AddPostWindowState extends State<AddPostWindow> {
  TextEditingController _postController;

  int maxPostLength = 150;
  int currentPostLength = 0;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
  }

  void updatePostLength() {
    setState(() {
      currentPostLength = _postController.text.length;
    });
  }

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
