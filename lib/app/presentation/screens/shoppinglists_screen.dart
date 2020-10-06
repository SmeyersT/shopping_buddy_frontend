

import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/navigation_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/shopping_cart_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/quit_alert_dialog.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class ShoppingListsScreen extends StatefulWidget {
  @override
  _ShoppingListsScreenState createState() => _ShoppingListsScreenState();
}

class _ShoppingListsScreenState extends State<ShoppingListsScreen> {
  final UserStore _userStore = serviceLocator.get<UserStore>();
  final GroupStore _groupStore = serviceLocator.get<GroupStore>();
  final ShoppingCartStore _shoppingCartStore = serviceLocator.get<ShoppingCartStore>();


  @override
  void initState() {
    getGroups();
    super.initState();
  }

  void getGroups() async {
    if(_userStore.currentUser == null) {
      await _userStore.getCurrentUser();
      print("Retrieving current user.");
    }
    if(_groupStore.userGroups == null) {
      await _groupStore.getUserGroups(_userStore.currentUser);
      print("Retrieving user groups.");
    }
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
          body: Container(
            color: Colors.white,
            width: size.width,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0, top: 16.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: Text(
                            _userStore.currentUser.firstName + "'s shoppinglist",
                          style: TextStyle(fontSize: 20, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildPersonalShoppingList(),
                  _buildGroupShoppingLists(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(),
          floatingActionButton: FabCircularMenu(
            fabColor: primaryColor,
            ringColor: primaryColor,
            //ringDiameter: 500.0,
            fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
            fabCloseIcon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  print("1");
                },
              ),
              Text("test"),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  print("2");
                },
              ),
              IconButton(
                icon: Icon(Icons.group),
                onPressed: () {
                  print("3");
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalShoppingList() {
    return _buildShoppingList(_userStore.currentUser.personalShoppingCart);
  }

  Widget _buildGroupShoppingLists() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _groupStore.userGroups.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Text(
                        _groupStore.userGroups[index].name + "'s shoppinglist",
                      style: TextStyle(fontSize: 20.0, color: primaryColor),
                    ),
                  ),
                ),
                _buildShoppingList(_groupStore.userGroups[index].shoppingCart)
              ],
            ),
          );
        }
        );
  }

  Widget _buildShoppingList(ShoppingCart shoppingCart) {
    return shoppingCart.items.length < 1? Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
          child: Text("Boodschappenlijstje is leeg!"),
        )
    ) : Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: shoppingCart.items.length,
        itemBuilder: (context, index) {
          return _buildShoppingListItem(shoppingCart, index);
        },
      ),
    );
  }

  Widget _buildShoppingListItem(ShoppingCart shoppingCart, int index) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(top: index==0? BorderSide.none : BorderSide()),
      ),
      child: Dismissible(
        resizeDuration: null,
        dismissThresholds: {DismissDirection.startToEnd: 0.25, DismissDirection.endToStart: 0.4 },
        confirmDismiss: (direction) {
          if(direction == DismissDirection.startToEnd) {
            setState(() {
              shoppingCart.items[index].isBought = true;
              _shoppingCartStore.updateShoppingCart(shoppingCart);
            });
          }
          if (direction == DismissDirection.endToStart) {
            setState(() {
              shoppingCart.items[index].isBought = false;
              _shoppingCartStore.updateShoppingCart(shoppingCart);
            });
          }
          return Future.value(false);
        },
        direction: shoppingCart.items[index].isBought? DismissDirection.endToStart : DismissDirection.startToEnd,
        key: Key(shoppingCart.items[index].name),
        background: Container(
          child: Visibility(
            visible: !shoppingCart.items[index].isBought,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.check_circle_outline, color: Colors.black26)
            ),
          ),
        ),
        secondaryBackground: Container(),
        child: Row(
          children: <Widget>[
            Visibility(
              visible: shoppingCart.items[index].isBought,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 0.0, end: 8.0),
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.7,
              child: AutoSizeText(
                  shoppingCart.items[index].name,
                minFontSize: 8.0,
                maxLines: 3,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
                child: SizedBox()
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.black26),
              onPressed: () {
                _onRemoveShoppingItem(shoppingCart, index);
              },
              padding: EdgeInsets.all(0.0),
            )

          ],
        ),
      ),
    );
  }

  void _onRemoveShoppingItem(ShoppingCart shoppingCart, int itemIndex) async {
    shoppingCart.items.removeAt(itemIndex);
    await _shoppingCartStore.updateShoppingCart(shoppingCart);
    setState(() {});
  }

}
