import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/presentation/StoreState.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/navigation_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_drawer.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/quit_alert_dialog.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final NavigationStore _navStore = serviceLocator.get<NavigationStore>();
  final GroupStore _groupStore = serviceLocator.get<GroupStore>();
  final UserStore _userStore = serviceLocator.get<UserStore>();


  @override
  void initState() {
    if(_groupStore.userGroups == null) {
      _groupStore.getUserGroups();
    }
    super.initState();
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
            color: backGroundColor,
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12.0),
                    child: Text(
                      "Mijn groepen",
                      style: TextStyle(color: primaryColor, fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Icon(
                          Icons.add_circle_outline, color: primaryColor,
                      ),
                    ),
                    onPressed: () { Navigator.pushNamed(context, '/addgroup'); },
                  )
                ],
              ),
                SizedBox(height: 12.0),
                Observer(
                  builder: (context) {
                    if(_groupStore.getUserGroupsState == StoreState.loaded) {
                      return Expanded(child: _buildGroupList(size));
                    }
                    else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 12.0, bottom: 12.0),
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: 40,
                    child: FlatButton(
                      onPressed: () {Navigator.pushNamed(context, '/groupfinder');},
                      shape: ContinuousRectangleBorder(side: BorderSide(color: primaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search),
                          SizedBox(width: 4.0),
                          Text("Groepen zoeken")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          drawer: CustomDrawer(),
          bottomNavigationBar: CustomBottomNavBar()
        ),
      ),
    );
  }

  Widget _buildGroupList(Size size) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return true;
      },
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _groupStore.userGroups.length,
          itemBuilder: (context, index) {
            return _buildGroupItem(size, _groupStore.userGroups[index], context);
          }
      ),
    );
  }

  Widget _buildGroupItem(Size size, Group group, BuildContext context) {
    return Container(
      width: size.width,
      height: 75.0,
      child: FlatButton(
        onPressed: () {_selectGroup(group, context);},
        splashColor: secondaryColor,
        highlightColor: Colors.transparent,
        child: Row(
          children: <Widget>[
            SizedBox(width: 0.0),
            CircularProfileAvatar(
              group.imgUrl,
              placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
              borderColor: primaryColor,
              borderWidth: 2.0,
              radius: 20.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                group.name,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Icon(Icons.group, color: primaryColor),
            SizedBox(width: 4.0),
            Text(
              group.groupMembers.length.toString(),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 24.0)
          ],
        ),
      ),
    );
  }

  void _selectGroup(Group group, BuildContext context) {
    Navigator.pushNamed(context, '/groupDetails', arguments: group);
  }


}
