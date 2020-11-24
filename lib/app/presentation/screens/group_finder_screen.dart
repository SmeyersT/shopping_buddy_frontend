
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:shopping_buddy_frontend/app/domain/group_role.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_member_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';

class GroupFinderScreen extends StatefulWidget {
  const GroupFinderScreen({ Key key }) : super(key: key);

  @override
  _GroupFinderScreenState createState() => _GroupFinderScreenState();
}

class _GroupFinderScreenState extends State<GroupFinderScreen> {
  final GroupStore _groupStore = serviceLocator.get<GroupStore>();
  final GroupMemberStore _groupMemberStore = serviceLocator.get<GroupMemberStore>();
  final UserStore _userStore = serviceLocator.get<UserStore>();

  final _searchController = TextEditingController();
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    if(_groupStore.searchResultGroups != null && _groupStore.searchResultGroups.isNotEmpty) _groupStore.searchResultGroups.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: Icon(Icons.arrow_back, color: backGroundColor, size: 35.0,),
          onPressed: () { Navigator.pop(context);},
        ),
        body: Observer(
          builder: (context) {
            return Container(
              color: backGroundColor,
              child: Column(
                children: <Widget>[
                  _buildSearchBar(size),
                  Expanded(
                    child: _groupStore.searchResultGroups == null? Center(child: Text("No results.")) : _buildResultsList(size, context),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResultsList(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0, top: 24.0, bottom: 24.0),
      child: ListView.builder(
          itemCount: _groupStore.searchResultGroups.length,
          itemBuilder: (context, index) {
            return _buildResultItem(_groupStore.searchResultGroups[index], size, context);
          }
      ),
    );
  }

  Widget _buildResultItem(Group group, Size size, BuildContext context) {
    bool _isMember;
    (group.groupMembers.firstWhere((gm) => gm.user.id == _userStore.currentUser.id, orElse: () => null) != null)? _isMember = true : _isMember = false;
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () { Navigator.pushNamed(context, '/groupDetails', arguments: group); },
        child: Container(
          width: size.width,
          child: Row(
            children: <Widget>[
              CircularProfileAvatar(
                group.imgUrl,
                placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
                borderColor: primaryColor,
                borderWidth: 2.0,
                radius: 25.0,
              ),
              SizedBox(width: 12.0),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  group.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.normal),
                ),
              ),
              _isMember? SizedBox.shrink() : Container(
                child: _buildJoinButton(group),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJoinButton(Group group) {
    bool hasJoined = false;
    return FlatButton(
      onPressed: () {
        _onJoinGroup(group);
        setState(() {
          hasJoined = true;
        });
      },
      child: SizedBox(
        width: 50.0,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: <Widget>[
              Visibility(
                visible: !hasJoined,
                  child: Icon(Icons.add, color: primaryColor, size: 20.0)
              ),
              SizedBox(width: 4.0),
              hasJoined? Text("Joined!", style: TextStyle(color: Colors.white)) :
              Text("Join", style: TextStyle(color: primaryColor)),
            ],
          ),
        ),
      ),
      splashColor: secondaryColor,
      highlightColor: Colors.transparent,
      shape: RoundedRectangleBorder(side: BorderSide(
          color: primaryColor,
          width: 1,
          style: BorderStyle.solid
      ),
          borderRadius: BorderRadius.circular(15.0)
      ),
    );
  }

  void _onJoinGroup(Group group) async {
    GroupMember newGroupMember = new GroupMember(0, GroupRole.MEMBER, _userStore.currentUser, group);
    await _groupMemberStore.createNewGroupMember(newGroupMember);
    _groupStore.getUserGroups();
    _groupStore.searchGroups(_searchController.text);
  }

  Widget _buildSearchBar(Size size) {
    return //Search bar
      Container(
        width: size.width,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0, top: 16.0, bottom: 16.0),
          child: Container(
            height: 50,
            width: size.width * 0.5,
            decoration: BoxDecoration(
                border: Border.all(color: secondaryColor),
                color: backGroundColor
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 14.0, top: 2.0, bottom: 2.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Icon(Icons.group, color: Colors.black12),
                  ),
                  Flexible(
                    flex: 11,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 4.0),
                      child: TextField(
                        maxLines: 1,
                        controller: _searchController,
                        cursorColor: primaryColor,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (input) {
                          if(input != null && input != "") {
                            _groupStore.searchGroups(input);
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            setState(() { _hasSearched = !_hasSearched;});
                          }
                        },
                        style: TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    )
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.black12,),
                      onPressed: () {
                        if(_searchController.text.isNotEmpty && _searchController.text != "") {
                          _groupStore.searchGroups(_searchController.text);
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          setState(() { _hasSearched = !_hasSearched;});
                        }
                        },
                      iconSize: 30.0,
                    ),
                  )
                ],
              ),
            ),

          ),
        ),
      );
  }

}
