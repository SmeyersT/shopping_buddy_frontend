
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/navigation_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class CustomBottomNavBar extends StatefulWidget {


  const CustomBottomNavBar({ Key key }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final NavigationStore _navStore = serviceLocator.get<NavigationStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return BottomNavigationBar(
          selectedItemColor: primaryColor,
          currentIndex: _navStore.tabIndex,
          onTap: (index) {
            _onTap(index, context);
            },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Lists")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text("Groups")
            )
          ],
        );
      },
    );
  }

  void _onTap(int index, BuildContext context) {
    if(index != _navStore.tabIndex) _navStore.setTabIndex(index, context);
  }

}
