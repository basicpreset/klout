import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/userdata.dart';
import 'package:vrep/Models/post_model.dart';
import 'package:vrep/Screens/widgets/createpost.dart';
import 'package:vrep/Screens/widgets/userpost.dart';
import 'package:vrep/Services/apiservices.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return Consumer<LocalCache>(builder: (context, cache, child) {
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
                FutureBuilder(
                  future: apiServices.loadFeed(cache.user_id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MyPost>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitCircle(
                        color: Colors.blue,
                      );
                    }
                    if (!snapshot.hasData) {
                      return Text(
                          "Uh oh, looks like you don't follow anyone yet!");
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data);
                        return PostWidget(
                          post: snapshot.data[index],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
