import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_with_item_wrapper.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/shopping_cart_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_drawer.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/quit_alert_dialog.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/google_helper.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ShoppingListsScreen extends StatefulWidget {
  @override
  _ShoppingListsScreenState createState() => _ShoppingListsScreenState();
}

class _ShoppingListsScreenState extends State<ShoppingListsScreen> {
  final UserStore _userStore = serviceLocator.get<UserStore>();
  final GroupStore _groupStore = serviceLocator.get<GroupStore>();
  final ShoppingCartStore _shoppingCartStore = serviceLocator.get<ShoppingCartStore>();

  //Websockets
  final GoogleHelper _googleHelper = serviceLocator.get<GoogleHelper>();
  StompClient client;
  Map<int, StreamController<String>> _streams = Map<int, StreamController<String>>();

  dynamic onConnectCallback(StompClient stompClient, StompFrame frame) async {
    if(stompClient.connected) print("Connected to STOMP: " + frame.toString());
    print(frame.body);
    for (Group g in _groupStore.userGroups) {
      print("Subscribing to shoppingCart ${g.shoppingCart.id}");
      // StreamController<String> _streamController = StreamController<String>();
      // _streams[g.id] = _streamController;
      stompClient.subscribe(
          destination: '/topic/shoppingLists/${g.shoppingCart.id}',
          callback: (frame) {
            print("Received frame: " + frame.body);
            _streams[g.shoppingCart.id].add(frame.body);
          },
          headers: {'Authorization': _googleHelper.getJwt()}
      );
    }

  }

  @override
  void initState() {
    _getGroups();
    _initStreams();
    client = StompClient(
      config: StompConfig.SockJS(
          stompConnectHeaders: {"Authorization": _googleHelper.getJwt()},
          webSocketConnectHeaders: {"Authorization": _googleHelper.getJwt()},
          onWebSocketError: (dynamic error) => print(error.toString()),
          url: SOCKET_URL,
          onConnect: (client, frame) async {await onConnectCallback(client, frame);}
      ),
    );
    super.initState();
  }

  void _initStreams() {
    for (Group g in _groupStore.userGroups) {
      StreamController<String> _streamController = StreamController<String>();
      _streams[g.shoppingCart.id] = _streamController;
    }
  }

  void _getGroups() async {
    if(_userStore.currentUser == null) {
      await _userStore.getCurrentUser();
      print("Retrieving current user.");
    }
    // if(_groupStore.userGroups == null) {
    //   await _groupStore.getUserGroups();
    //   print("Retrieving user groups.");
    // }
    await _groupStore.getUserGroups();
  }


  @override
  void dispose() {
    client.deactivate();
    for (var o in _streams.entries) {
      o.value.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    client.activate();
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
              padding: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0, top: 0.0),
              child: NotificationListener(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8.0),
                          child: Text(
                              "Mijn boodschappenlijstje",
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
          ),
          drawer: CustomDrawer(),
          bottomNavigationBar: CustomBottomNavBar(),
        ),
      ),
    );
  }

  Widget _buildPersonalShoppingList() {
    return _userStore.currentUser.personalShoppingCart.items.length < 1? Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
          child: Text("Boodschappenlijstje is leeg!"),
        )
    ) : Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _userStore.currentUser.personalShoppingCart.items.length,
        itemBuilder: (context, index) {
          return _buildShoppingListItem(_userStore.currentUser.personalShoppingCart, index);
        },
      ),
    );
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
                        _groupStore.userGroups[index].name,
                      style: TextStyle(fontSize: 20.0, color: primaryColor),
                    ),
                  ),
                ),
                StreamBuilder(
                  initialData: json.encode(_groupStore.userGroups[index].shoppingCart),
                  stream: _streams[_groupStore.userGroups[index].shoppingCart.id].stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        Map cartMap = jsonDecode(snapshot.data);
                        ShoppingCart cart = ShoppingCart.fromJson(cartMap);
                        _groupStore.userGroups[index].shoppingCart = cart;
                        return _buildGroupShoppingList(cart);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                ),
                //_buildGroupShoppingList(_groupStore.userGroups[index].shoppingCart)
              ],
            ),
          );
        });
  }

  Widget _buildGroupShoppingList(ShoppingCart shoppingCart) {

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
        physics: NeverScrollableScrollPhysics(),
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
            if(shoppingCart.isPersonalCart){
              setState(() {
                shoppingCart.items[index].isBought = true;
                _shoppingCartStore.updateShoppingCart(shoppingCart);
              });
            }
            else {
              shoppingCart.items[index].isBought = true;
              ShoppingCartWithItemWrapper wrapper = new ShoppingCartWithItemWrapper(shoppingCart, shoppingCart.items[index]);
              client.send(destination: '/app/shoppingList/${shoppingCart.id}/update', body: json.encode(wrapper.toJson()));
            }
          }
          if (direction == DismissDirection.endToStart) {
            if(shoppingCart.isPersonalCart) {
              setState(() {
                shoppingCart.items[index].isBought = false;
                _shoppingCartStore.updateShoppingCart(shoppingCart);
              });
            }
            else {
              shoppingCart.items[index].isBought = false;
              ShoppingCartWithItemWrapper wrapper = new ShoppingCartWithItemWrapper(shoppingCart, shoppingCart.items[index]);
              client.send(destination: '/app/shoppingList/${shoppingCart.id}/update', body: json.encode(wrapper.toJson()));
            }
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
                if(shoppingCart.isPersonalCart) {
                  _onRemovePersonalShoppingItem(shoppingCart, index);
                }
                else _onRemoveGroupShoppingItem(shoppingCart, index);
              },
              padding: EdgeInsets.all(0.0),
            )

          ],
        ),
      ),
    );
  }

  void _onRemovePersonalShoppingItem(ShoppingCart shoppingCart, int itemIndex) async {
    await _shoppingCartStore.removeItemFromCart(shoppingCart, shoppingCart.items[itemIndex]);
    shoppingCart.items.removeAt(itemIndex);
    setState(() {});
  }

  void _onRemoveGroupShoppingItem(ShoppingCart shoppingCart, int itemIndex) async {
    ShoppingCartWithItemWrapper wrapper = new ShoppingCartWithItemWrapper(shoppingCart, shoppingCart.items[itemIndex]);
    print("Sending JSON websocketmessage: " + json.encode(shoppingCart.toJson()));
    client.send(destination: '/app/shoppingList/${shoppingCart.id}/remove', body: json.encode(wrapper.toJson()));
  }

}
