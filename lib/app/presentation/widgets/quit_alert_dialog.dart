
import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class QuitAlertDialog  {

  static getQuitAlertDialog(BuildContext c) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Do you really want to exit'),
      actions: [
        FlatButton(
          child: Text('Yes', style: TextStyle(color: primaryColor)),
          onPressed: () => Navigator.pop(c, true),
        ),
        FlatButton(
          child: Text('No', style: TextStyle(color: primaryColor)),
          onPressed: () => Navigator.pop(c, false),
        ),
      ],
    );
  }

}
