import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore = _NavigationStoreBase with _$NavigationStore;

abstract class _NavigationStoreBase with Store {

  @observable
  int tabIndex = 0;


  @action
  void setTabIndex(int value, BuildContext context) {
    //if(value >= 0 && value < 3) tabIndex = value;
    switch(value) {
      case 0: tabIndex = value; Navigator.pushReplacementNamed(context, '/home'); break;
      case 1: tabIndex = value; Navigator.pushReplacementNamed(context, '/shoppinglists'); break;
      case 2: tabIndex = value; Navigator.pushReplacementNamed(context, '/groups'); break;
    }
  }

}
