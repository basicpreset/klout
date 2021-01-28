import 'package:flutter/material.dart';

import 'addpostwindow.dart';

class CreatePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* CircleAvatar(
                                    backgroundImage: AssetImage('profile.jpg'),
                                    radius: 12,
                                  ), 
                                  SizedBox(
                                    width: 8,
                                  ), */
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                    size: 18,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Something you might want to share with others?'),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddPostWindow();
          },
        );
      },
    );
  }
}
