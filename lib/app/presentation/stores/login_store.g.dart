// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  final _$isSignedInAtom = Atom(name: '_LoginStoreBase.isSignedIn');

  @override
  bool get isSignedIn {
    _$isSignedInAtom.reportRead();
    return super.isSignedIn;
  }

  @override
  set isSignedIn(bool value) {
    _$isSignedInAtom.reportWrite(value, super.isSignedIn, () {
      super.isSignedIn = value;
    });
  }

  final _$isSigningInAtom = Atom(name: '_LoginStoreBase.isSigningIn');

  @override
  bool get isSigningIn {
    _$isSigningInAtom.reportRead();
    return super.isSigningIn;
  }

  @override
  set isSigningIn(bool value) {
    _$isSigningInAtom.reportWrite(value, super.isSigningIn, () {
      super.isSigningIn = value;
    });
  }

  final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase');

  @override
  dynamic _setSigningIn(bool value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase._setSigningIn');
    try {
      return super._setSigningIn(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setSignedIn(bool value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase._setSignedIn');
    try {
      return super._setSignedIn(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSignedIn: ${isSignedIn},
isSigningIn: ${isSigningIn}
    ''';
  }
}
