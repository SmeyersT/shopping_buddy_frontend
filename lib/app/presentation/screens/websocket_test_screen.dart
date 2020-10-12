import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketTestScreen extends StatefulWidget {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  _WebsocketTestScreenState createState() => _WebsocketTestScreenState();

}

class _WebsocketTestScreenState extends State<WebsocketTestScreen> {
final _messageController = TextEditingController();

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.getAppBar(),
        body: Column(
          children: [
            Container(
              height: size.height*0.7,
              width: size.width,
              color: Colors.orange,
              child: StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData? '${snapshot.data}' : '');
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
                    widget.channel.sink.add(_messageController.text);
                  },
                  child: Text(
                    "Send"
                  )
              ),
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      )
    );
  }

}