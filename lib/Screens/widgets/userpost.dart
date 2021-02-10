import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Core/utilities.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Screens/screens_main/postpage.dart';
import 'package:vrep/Screens/screens_main/foreign_user/foreignuserpage.dart';
import 'package:vrep/Screens/widgets/post_widget/post_contentbar.dart';
import 'package:vrep/Screens/widgets/post_widget/post_reactionbar.dart';
import 'package:vrep/Screens/widgets/post_widget/post_topbar.dart';

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
              InkWell(
                  child: Post_TopBar(
                    post: post,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ForeignUserPage(
                              user_id: post.user_id,
                            ),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.decelerate));
                  }),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Post_ContentBar(
                  post: post,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: PostPage(
                            post: post,
                          ),
                          type: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.decelerate));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Post_ReactionBar(
                post: post,
              )
            ],
          ),
        ),
      );
    });
  }
}
