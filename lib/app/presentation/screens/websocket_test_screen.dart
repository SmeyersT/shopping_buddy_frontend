import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shopping_buddy_frontend/app/domain/message.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/google_helper.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketTestScreen extends StatefulWidget {

  @override
  _WebsocketTestScreenState createState() => _WebsocketTestScreenState();
}

class _WebsocketTestScreenState extends State<WebsocketTestScreen> {
  final GoogleHelper _googleHelper = serviceLocator.get<GoogleHelper>();
  final _messageController = TextEditingController();
  StompClient client;
  StreamController<String> _streamController = StreamController<String>();
  final List<int> ids = [5000, 5002, 4];

  dynamic onConnectCallback(StompClient stompClient, StompFrame frame) async {
    if(stompClient.connected) print("Connected to STOMP: " + frame.toString());
    print(frame.body);
    for (int id in ids) {

      stompClient.subscribe(
          destination: '/topic/shoppingLists/$id',
          callback: (frame) {
            print("Received frame: " + frame.body);
            _streamController.add(frame.body);
          },
          headers: {'Authorization': _googleHelper.getJwt()}
      );
    }

  }

  @override
  void initState() {
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

  @override
  void dispose() {
    client.deactivate();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    client.activate();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar.getAppBar(),
      body: Column(
        children: [
          Container(
            height: size.height * 0.7,
            width: size.width,
            color: Colors.orange,
            child: StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  Map cartMap = jsonDecode(snapshot.data);
                  ShoppingCart cart = ShoppingCart.fromJson(cartMap);
                  return Text('${snapshot.data}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          Container(
            child: TextField(
              controller: _messageController,
              maxLines: 1,
            ),
          ),
          Container(
            height: 50,
            child: FlatButton(
                onPressed: () {
                  _onSendMessage();
                },
                child: Text("Send")),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    ));
  }

  void _onSendMessage() {
    ShoppingCart cart = ShoppingCart(
              0,
              false,
              List<ShoppingCartItem>.of({new ShoppingCartItem(0, true, "dfqs")}),
              //List(),
              true);
          print("Sending JSON websocketmessage: " + json.encode(cart.toJson()));
    client.send(destination: '/app/shoppingList/5002/get', body: json.encode(cart.toJson()));
  }
}
