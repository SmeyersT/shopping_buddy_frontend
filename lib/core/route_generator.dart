import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/presentation/screens/add_group_screen.dart';
import 'package:shopping_buddy_frontend/app/presentation/screens/group_detail_screen.dart';
import 'package:shopping_buddy_frontend/app/presentation/screens/group_finder_screen.dart';
import 'package:shopping_buddy_frontend/app/presentation/screens/groups_screen.dart';
import 'package:shopping_buddy_frontend/app/presentation/screens/home_screen.dart';
import 'package:shopping_buddy_frontend/app/presentation/screens/shoppinglists_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/': return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomeScreen()
      );
      case '/shoppinglists': return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => ShoppingListsScreen()
      );
      case '/groups': return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => GroupsScreen()
      );
      case '/groupfinder': return PageTransition(
        child: GroupFinderScreen(),
        type: PageTransitionType.downToUp
      );
      case '/addgroup': return PageTransition(
        child: AddGroupScreen(),
        type: PageTransitionType.rightToLeft
      );
      case '/groupDetails':
        if(args is Group) {
          return PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => GroupDetailScreen(group: args,));
        }
        return null;
      default: return null;
    }

  }
}
