import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Screens/widgets/createpost.dart';
import 'package:vrep/Screens/widgets/userpost.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Trending header
              Text(
                'Feed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CreatePost(),
              ),
              //Toggle between feed and search
              ChangeNotifierProvider(
                create: (context) => PostsData(),
                              child: Column(
                  children: [PostWidget(post: ,), PostWidget(), PostWidget()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
