import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vrep/Core/localcache.dart';
import 'package:vrep/Models/user_model.dart';
import 'package:vrep/Screens/screens_main/foreign_user/foreignuserpage.dart';
import 'package:vrep/Services/apiservices.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController;
  ApiServices api;

  List<MyUser> allUsers;
  List<MyUser> filteredUsers;

  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    api = ApiServices();
    api.searchUsers().then((value) {
      allUsers = value;
    });
  }

  void filterUsers(String searchText) {
    filteredUsers =
        allUsers.where((user) => user.username.contains(searchText)).toList();
/*     filteredUsers.removeWhere(
        (user) => user.user_id == Provider.of<LocalCache>(context).user_id); */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Keresés',
                            contentPadding:
                                EdgeInsets.only(bottom: 13.5, left: 12)),
                        //style: TextStyle(height: 1),
                        textAlignVertical: TextAlignVertical.center,
                        controller: _searchController,
                        onChanged: (String searchText) {
                          filterUsers(searchText);
                          if (_searchController.text.length > 0) {
                            setState(() {
                              isSearching = true;
                            });
                          } else {
                            setState(() {
                              isSearching = false;
                            });
                          }
                        },
                        onTap: () {
                          //userdata.openSearch();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              isSearching
                  ? searchResultList(context, users: filteredUsers)
                  : Text('Not searching')
            ],
          ),
        ),
      ),
    );
  }

  Widget searchResultList(context, {List<MyUser> users}) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return searchResultRow(context, user: users[index]);
        });
  }

  Widget searchResultRow(context, {MyUser user}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('profile.jpg'),
              radius: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(user.username),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: ForeignUserPage(
                user_id: user.user_id,
                user: user,
              ),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 200)),
        );
      },
    );
  }
}
