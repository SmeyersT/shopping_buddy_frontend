// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GroupStore on _GroupStoreBase, Store {
  Computed<StoreState> _$getUserGroupsStateComputed;

  @override
  StoreState get getUserGroupsState => (_$getUserGroupsStateComputed ??=
          Computed<StoreState>(() => super.getUserGroupsState,
              name: '_GroupStoreBase.getUserGroupsState'))
      .value;

  final _$createdGroupAtom = Atom(name: '_GroupStoreBase.createdGroup');

  @override
  Group get createdGroup {
    _$createdGroupAtom.reportRead();
    return super.createdGroup;
  }

  @override
  set createdGroup(Group value) {
    _$createdGroupAtom.reportWrite(value, super.createdGroup, () {
      super.createdGroup = value;
    });
  }

  final _$userGroupsAtom = Atom(name: '_GroupStoreBase.userGroups');

  @override
  List<Group> get userGroups {
    _$userGroupsAtom.reportRead();
    return super.userGroups;
  }

  @override
  set userGroups(List<Group> value) {
    _$userGroupsAtom.reportWrite(value, super.userGroups, () {
      super.userGroups = value;
    });
  }

  final _$searchResultGroupsAtom =
      Atom(name: '_GroupStoreBase.searchResultGroups');

  @override
  List<Group> get searchResultGroups {
    _$searchResultGroupsAtom.reportRead();
    return super.searchResultGroups;
  }

  @override
  set searchResultGroups(List<Group> value) {
    _$searchResultGroupsAtom.reportWrite(value, super.searchResultGroups, () {
      super.searchResultGroups = value;
    });
  }

  final _$_searchResultGroupsFutureAtom =
      Atom(name: '_GroupStoreBase._searchResultGroupsFuture');

  @override
  ObservableFuture<Response<List<Group>>> get _searchResultGroupsFuture {
    _$_searchResultGroupsFutureAtom.reportRead();
    return super._searchResultGroupsFuture;
  }

  @override
  set _searchResultGroupsFuture(ObservableFuture<Response<List<Group>>> value) {
    _$_searchResultGroupsFutureAtom
        .reportWrite(value, super._searchResultGroupsFuture, () {
      super._searchResultGroupsFuture = value;
    });
  }

  final _$_userGroupsFutureAtom =
      Atom(name: '_GroupStoreBase._userGroupsFuture');

  @override
  ObservableFuture<Response<List<Group>>> get _userGroupsFuture {
    _$_userGroupsFutureAtom.reportRead();
    return super._userGroupsFuture;
  }

  @override
  set _userGroupsFuture(ObservableFuture<Response<List<Group>>> value) {
    _$_userGroupsFutureAtom.reportWrite(value, super._userGroupsFuture, () {
      super._userGroupsFuture = value;
    });
  }

  final _$_createGroupFutureAtom =
      Atom(name: '_GroupStoreBase._createGroupFuture');

  @override
  ObservableFuture<Response<Group>> get _createGroupFuture {
    _$_createGroupFutureAtom.reportRead();
    return super._createGroupFuture;
  }

  @override
  set _createGroupFuture(ObservableFuture<Response<Group>> value) {
    _$_createGroupFutureAtom.reportWrite(value, super._createGroupFuture, () {
      super._createGroupFuture = value;
    });
  }

  final _$_deleteGroupFutureAtom =
      Atom(name: '_GroupStoreBase._deleteGroupFuture');

  @override
  ObservableFuture<Response<dynamic>> get _deleteGroupFuture {
    _$_deleteGroupFutureAtom.reportRead();
    return super._deleteGroupFuture;
  }

  @override
  set _deleteGroupFuture(ObservableFuture<Response<dynamic>> value) {
    _$_deleteGroupFutureAtom.reportWrite(value, super._deleteGroupFuture, () {
      super._deleteGroupFuture = value;
    });
  }

  @override
  String toString() {
    return '''
createdGroup: ${createdGroup},
userGroups: ${userGroups},
searchResultGroups: ${searchResultGroups},
getUserGroupsState: ${getUserGroupsState}
    ''';
  }
}
