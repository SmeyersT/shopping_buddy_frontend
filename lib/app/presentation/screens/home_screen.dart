import 'dart:ui';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/shopping_cart_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_drawer.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/quit_alert_dialog.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

import '../StoreState.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserStore _userStore = serviceLocator.get<UserStore>();
  final GroupStore _groupStore = serviceLocator.get<GroupStore>();
  final ShoppingCartStore _shoppingCartStore =
      serviceLocator.get<ShoppingCartStore>();

  @override
  void initState() {
    _getInitData();
    super.initState();
  }

  void _getInitData() async {
    if (_userStore.currentUser == null) {
      await _userStore.getCurrentUser();
      print("Retrieving current user.");
    }
    if (_groupStore.userGroups == null) {
      await _groupStore.getUserGroups();
      print("Retrieving user groups.");
    }
  }

  @override
  void dispose() {
    _shoppingItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => showDialog<bool>(
          context: context,
          builder: (c) => QuitAlertDialog.getQuitAlertDialog(context),
        ),
        child: Scaffold(
          appBar: CustomAppBar.getAppBar(),
          body: GestureDetector(
            onTap: () {setState(() {
              addItemIsOpen = false;
            });},
            child: Observer(
              builder:(context) {
                return Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("./assets/home_screen_background.jpg"),
                          fit: BoxFit.fill)),
                  child: ClipRRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: _userStore.getCurrentUserState == StoreState.loaded && _groupStore.getUserGroupsState == StoreState.loaded? _buildAddShoppingItem(size) : SizedBox.shrink())),
                );
              }
            ),
          ),
          drawer: CustomDrawer(),
          bottomNavigationBar: CustomBottomNavBar(),
        ),
      ),
    );
  }

  bool addItemIsOpen = false;
  bool chooseShoppingList = false;
  ShoppingCartItem _newItem;
  ShoppingCart _selectedShoppingCart;
  final _shoppingItemController = TextEditingController();

  Widget _buildAddShoppingItem(Size size) {
    if(_selectedShoppingCart == null) _selectedShoppingCart = _userStore.currentUser.personalShoppingCart;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print("tap: " + addItemIsOpen.toString());
            setState(() {
              addItemIsOpen = true;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: addItemIsOpen ? size.height * 0.4 : 160,
            width: addItemIsOpen ? size.width * 0.8 : 160,
            decoration: addItemIsOpen
                ? BoxDecoration(
                    border: Border.all(color: primaryColor, width: 4),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                  )
                : BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(180)),
            child: addItemIsOpen
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 28.0, start: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Wat heb je nodig?",
                            style: TextStyle(color: primaryColor, fontSize: 24.0),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _shoppingItemController,
                            enableInteractiveSelection: true,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            style: TextStyle(
                              fontSize: 26.0,
                            ),
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
//                                labelText: "Wat heb je nodig?",
//                                labelStyle: TextStyle(color: primaryColor),
//                                hasFloatingPlaceholder: true,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none
                                //focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.teal))
                                ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60.0,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  this._selectedShoppingCart = _userStore.currentUser.personalShoppingCart;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  CircularProfileAvatar(
                                    _userStore.currentUser.imgUrl,
                                    placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
                                    borderColor:  secondaryColor,
                                    borderWidth: _selectedShoppingCart.id == _userStore.currentUser.personalShoppingCart.id? 3.0 : 0.0,
                                    radius: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 2.0),
                                    child: Text(
                                        _userStore.currentUser.firstName,
                                      style: TextStyle(fontSize: 10, color: _selectedShoppingCart.id == _userStore.currentUser.personalShoppingCart.id? primaryColor : Colors.black45),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _groupStore.userGroups.length,
                                itemBuilder: (context, index) {
                                return _buildGroup(_groupStore.userGroups[index], index);
                                }
                                )
                          ],
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          return FlatButton(
                            onPressed: () {
                              _onAddShoppingItem(context);
                            },
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: primaryColor),
                                borderRadius: BorderRadius.circular(16.0)),
                            color: primaryColor,
                            child: Text(
                              "Boodschap toevoegen",
                              style: TextStyle(color: whiteColor),
                            ),
                          );
                        }
                      ),
                      SizedBox(height: 8.0)
                    ],
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text("Iets nodig?",
                          style:
                              TextStyle(fontSize: 26.0, color: Colors.white)),
//              child: Icon(Icons.add, color: Colors.white, size: 120,),
                    )),
          ),
        ),
      ],
    );
  }

  void _onAddShoppingItem(BuildContext context) async {
    if(_shoppingItemController.text.isNotEmpty) {
      ShoppingCartItem newShoppingItem = new ShoppingCartItem(
          0, false, _shoppingItemController.text);
      //_selectedShoppingCart.items.add(newShoppingItem);
      await _shoppingCartStore.addItemToCart(_selectedShoppingCart, newShoppingItem);
      _shoppingItemController.clear();
      _selectedShoppingCart.items = _shoppingCartStore.updatedShoppingCart.items;
      setState(() {
        addItemIsOpen = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(newShoppingItem.name + " toegevoegd!"),
      ));
    }
  }

  Widget _buildGroup(Group group, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this._selectedShoppingCart = group.shoppingCart;
        });
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: _groupStore.userGroups.length == index+1? 0.0 : 10.0),
        child: Column(
          children: <Widget>[
            CircularProfileAvatar(
              group.imgUrl,
              placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
              borderColor:  secondaryColor,
              borderWidth: _selectedShoppingCart.id == group.shoppingCart.id? 3.0 : 0.0,
              radius: 20.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 2.0),
              child: Text(
                group.name,
                style: TextStyle(fontSize: 10, color: _selectedShoppingCart.id == group.shoppingCart.id? primaryColor : Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
