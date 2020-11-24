
import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:shopping_buddy_frontend/app/domain/group_role.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_member_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/values/colors.dart';
import 'package:christian_picker_image/christian_picker_image.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({Key key}) : super(key: key);

  @override
  _AddGroupScreenState createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _groupStore = serviceLocator.get<GroupStore>();
  final _groupMemberStore = serviceLocator.get<GroupMemberStore>();
  final _userStore = serviceLocator.get<UserStore>();
  File image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: backGroundColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12.0),
                  child: Text(
                    "Nieuwe groep aanmaken",
                    style: TextStyle(color: primaryColor, fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                  child: _buildForm(size)
              ),
              SizedBox(height: 8.0),
              _buildSubmitButton(size),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  Widget _buildForm(Size size) {
    return Container(
      width: size.width * 0.9,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              maxLines: 1,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Naam",
                labelStyle: TextStyle(color: primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                isDense: true,
              ),
              cursorColor: primaryColor,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _imageUrlController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Afbeelding",
                labelStyle: TextStyle(color: primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              cursorColor: primaryColor,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter an imageUrl.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Afbeelding",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16.0
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Align(
              alignment: Alignment.centerLeft,
              child: image != null? CircularProfileAvatar(
                "imagePreview",
                  child: Image.file(
                      image,
                    fit: BoxFit.cover,
                  ),
                placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
                borderColor: primaryColor,
                borderWidth: 2.0,
              ) : CircularProfileAvatar(
                "noImage",
                borderColor: primaryColor,
                placeHolder: (context, string) { return Image(image: AssetImage("./assets/group_profile_placeholder.png"));},
                borderWidth: 2.0,
              ),
            ),
            SizedBox(height: 12.0),
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () {
                  _pickImage(context);
                },
                child: Text(
                    "Foto kiezen",
                  style: TextStyle(
                    color: whiteColor
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void takeImage(BuildContext context) async {
    List<File> newImage = await ChristianPickerImage.pickImages(maxImages: 1);
    setState(() {
      image = newImage.first;
    });
    print(image);
    Navigator.of(context).pop();
  }

  Future _pickImage(BuildContext context) async {

    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          takeImage(context);
          return Center();
        });

  }


  Widget _buildSubmitButton(Size size) {
    return SizedBox(
      height: 40,
      width: size.width * 0.9,
      child: FlatButton(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Groep aanmaken",
              style: TextStyle(color: primaryColor, fontSize: 50),
            ),
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()) {
            _onSubmitGroup();
          }
        },
        highlightColor: primaryColor,
        splashColor: secondaryColor,
        shape: new ContinuousRectangleBorder(side: BorderSide(color: primaryColor)),
      ),
    );
  }

  _onSubmitGroup() async {
    Group group = new Group(0, _nameController.text, _imageUrlController.text, new List<GroupMember>(), new ShoppingCart(0, false, new List<ShoppingCartItem>(), false));
    await _groupStore.createNewGroup(group);
    print(_groupStore.createdGroup.toString());
    GroupMember groupMember = new GroupMember(0, GroupRole.OWNER, _userStore.currentUser, _groupStore.createdGroup);
    await _groupMemberStore.createNewGroupMember(groupMember);
    _groupStore.getUserGroups();
    Navigator.pop(context);
  }

}
