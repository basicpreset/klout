import 'package:flutter/material.dart';

class UserTrait extends StatelessWidget {
  String traitName;
  String traitType;
  UserTrait(this.traitName, {this.traitType});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Icon(
            Icons.computer,
            size: 18,
          ),
          SizedBox(width: 10),
          Text(traitName)
        ],
      ),
    );
  }
}
