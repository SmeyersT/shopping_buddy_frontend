// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavigationStore on _NavigationStoreBase, Store {
  final _$tabIndexAtom = Atom(name: '_NavigationStoreBase.tabIndex');

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  final _$_NavigationStoreBaseActionController =
      ActionController(name: '_NavigationStoreBase');

  @override
  void setTabIndex(int value, BuildContext context) {
    final _$actionInfo = _$_NavigationStoreBaseActionController.startAction(
        name: '_NavigationStoreBase.setTabIndex');
    try {
      return super.setTabIndex(value, context);
    } finally {
      _$_NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex}
    ''';
  }
}
