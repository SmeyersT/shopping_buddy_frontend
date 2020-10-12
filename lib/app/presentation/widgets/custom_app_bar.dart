import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class CustomAppBar  {

  static getAppBar() {
    return AppBar(
      title: Text("ShoppingBuddy"),
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      actions: <Widget>[
//        IconButton(
//          onPressed: () {print("Menu button pressed.");},
//          icon: Icon(Icons.menu),
//        )
      ],
    );
  }

}
