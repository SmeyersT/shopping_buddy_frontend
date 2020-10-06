// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  Computed<StoreState> _$getCurrentUserStateComputed;

  @override
  StoreState get getCurrentUserState => (_$getCurrentUserStateComputed ??=
          Computed<StoreState>(() => super.getCurrentUserState,
              name: '_UserStoreBase.getCurrentUserState'))
      .value;

  final _$currentUserAtom = Atom(name: '_UserStoreBase.currentUser');

  @override
  User get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$_userFutureAtom = Atom(name: '_UserStoreBase._userFuture');

  @override
  ObservableFuture<Response<User>> get _userFuture {
    _$_userFutureAtom.reportRead();
    return super._userFuture;
  }

  @override
  set _userFuture(ObservableFuture<Response<User>> value) {
    _$_userFutureAtom.reportWrite(value, super._userFuture, () {
      super._userFuture = value;
    });
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
getCurrentUserState: ${getCurrentUserState}
    ''';
  }
}
