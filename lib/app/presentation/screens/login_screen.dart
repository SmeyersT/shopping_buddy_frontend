

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/login_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore _loginStore = serviceLocator.get<LoginStore>();


  @override
  void initState() {
    _loginStore.signInSilently(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: primaryColor,
            width: size.width,
            child: Observer(
              builder:(context) {
                  return Column(
                    children: [
                      Flexible(
                        flex: 10,
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "ShoppingBuddy",
                            style: TextStyle(color: whiteColor, fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 2,
                          child: Visibility(
                            visible: !_loginStore.isSignedIn,
                              child: _buildLoginButton(context, size)
                          )
                      ),
                    ],
                  );
              }
            ),
          ),
        ));
  }


  Widget _buildLoginButton(BuildContext context, Size size) {
    return GestureDetector(
        onTap: () async =>
        _loginStore.isSigningIn ? null : _loginStore.signIn(context),
        child: Container(
          width: size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(40.0))
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("./assets/google_icon.png")),
                SizedBox(width: 12.0),
                Text(
                  "Inloggen met Google",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ));
  }

}


