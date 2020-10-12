import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:shopping_buddy_frontend/app/domain/group_role.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_member_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/widgets/custom_app_bar.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class GroupDetailScreen extends StatefulWidget {
  final Group group;

  GroupDetailScreen({Key key, @required this.group}) : super(key: key);

  @override
  _GroupDetailScreenState createState() => _GroupDetailScreenState();

}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final GroupMemberStore _groupMemberStore = serviceLocator.get<GroupMemberStore>();
  final UserStore _userStore = serviceLocator.get<UserStore>();
  final GroupStore _groupStore = serviceLocator.get<GroupStore>();
  
  bool _isMember;
  GroupMember _groupMember;


  @override
  void initState() {
    _groupMember = widget.group.groupMembers.firstWhere((gm) => gm.user.id == _userStore.currentUser.id, orElse: () => null);
    _groupMember != null? _isMember = true : _isMember = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.getAppBar(),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: Container(
            color: Colors.white,
            width: size.width,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.05),
                  Center(
                    child: CircularProfileAvatar(
                      widget.group.imgUrl,
                      placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
                      borderColor: primaryColor,
                      borderWidth: 2.0,
                      radius: 60.0,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      widget.group.name,
                      style: TextStyle(
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20.0,
                    child: Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Leden",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 24.0
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Expanded(child: _buildMemberList()),
                  _buildActionButton(size)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(Size size) {
    if(_isMember) {
      switch(_groupMember.role) {
        case GroupRole.MEMBER: return _buildLeaveButton(size); break;
        case GroupRole.MODERATOR: return _buildLeaveButton(size); break;
        case GroupRole.OWNER: return _buildDeleteGroupButton(size); break;
      }
    } else {
      return _buildJoinButton(size);
    }
  }

  Widget _buildJoinButton(Size size) {
    return SizedBox(
      width: size.width*0.9,
      child: FlatButton(
        onPressed: () {
          _onJoinGroup();
          //Navigator.pop(context);
        },
        shape: ContinuousRectangleBorder(side: BorderSide(color: primaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add, color: primaryColor),
            SizedBox(width: 4.0),
            Text(
              "Join",
              style: TextStyle(color: primaryColor),
            )
          ],
        ),
      ),
    );
  }

  void _onJoinGroup() async {
    GroupMember _newGroupMember = new GroupMember(0, GroupRole.MEMBER, _userStore.currentUser, widget.group);
    await _groupMemberStore.createNewGroupMember(_newGroupMember);
    _groupStore.getUserGroups();
    widget.group.groupMembers.add(_groupMemberStore.createdGroupMember);
    setState(() {
      _isMember = true;
      _groupMember = _groupMemberStore.createdGroupMember;
    });
  }

  Widget _buildLeaveButton(Size size) {
    return SizedBox(
      width: size.width*0.9,
      child: FlatButton(
        onPressed: () {
          _onLeaveGroup(_groupMember);
          //Navigator.pop(context);
        },
        shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.red)),
        child: Text(
          "Group verlaten",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void _onLeaveGroup(GroupMember groupMember) async {
    await _groupMemberStore.deleteGroupMember(groupMember.id);
    await _groupStore.getUserGroups();
    Navigator.pushNamedAndRemoveUntil(context, '/groups', ModalRoute.withName('/groups'));
  }

  Widget _buildDeleteGroupButton(Size size) {
    return SizedBox(
      width: size.width*0.9,
      child: FlatButton(
        onPressed: () {
          _onDeleteGroup();
          //Navigator.pop(context);
        },
        shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.red)),
        child: Text(
          "Group verwijderen",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void _onDeleteGroup() async {
    await _groupStore.deleteGroup(widget.group);
    await _groupStore.getUserGroups();
    Navigator.pushNamedAndRemoveUntil(context, '/groups', ModalRoute.withName('/groups'));
  }

  Widget _buildMemberList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.group.groupMembers.length,
        itemBuilder: (context, index) {
          return _buildMemberItem(widget.group.groupMembers[index]);
        }
    );
  }

  Widget _buildMemberItem(GroupMember member) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 12.0),
      child: Row(
        children: <Widget>[
          CircularProfileAvatar(
            member.user.imgUrl,
            placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
            borderColor: primaryColor,
            borderWidth: 2.0,
            radius: 20.0,
          ),
          SizedBox(width: 12.0),
          Text(
            member.user.firstName + " " + member.user.lastName,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

}
