import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/login_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class CustomDrawer extends StatelessWidget {
  final UserStore _userStore = serviceLocator.get<UserStore>();
  final LoginStore _loginStore = serviceLocator.get<LoginStore>();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: primaryColor,
            child: _userStore.currentUser != null? Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              child: Row(
                children: <Widget>[
                  CircularProfileAvatar(
                    _userStore.currentUser.imgUrl,
                    radius: 35.0,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    _userStore.currentUser.firstName + " " + _userStore.currentUser.lastName,
                    style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ) : SizedBox.shrink(),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () { _loginStore.signOut(context); },
              child: Text("Uitloggen"),
              textColor: Colors.black54,
            ),
          )
        ],
      ),
    );
  }


}