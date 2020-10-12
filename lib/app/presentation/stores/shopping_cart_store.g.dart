// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShoppingCartStore on _ShoppingCartStoreBase, Store {
  Computed<StoreState> _$getShoppingCartStateComputed;

  @override
  StoreState get getShoppingCartState => (_$getShoppingCartStateComputed ??=
          Computed<StoreState>(() => super.getShoppingCartState,
              name: '_ShoppingCartStoreBase.getShoppingCartState'))
      .value;

  final _$updatedShoppingCartAtom =
      Atom(name: '_ShoppingCartStoreBase.updatedShoppingCart');

  @override
  ShoppingCart get updatedShoppingCart {
    _$updatedShoppingCartAtom.reportRead();
    return super.updatedShoppingCart;
  }

  @override
  set updatedShoppingCart(ShoppingCart value) {
    _$updatedShoppingCartAtom.reportWrite(value, super.updatedShoppingCart, () {
      super.updatedShoppingCart = value;
    });
  }

  final _$_updatedShoppingCartFutureAtom =
      Atom(name: '_ShoppingCartStoreBase._updatedShoppingCartFuture');

  @override
  ObservableFuture<Response<ShoppingCart>> get _updatedShoppingCartFuture {
    _$_updatedShoppingCartFutureAtom.reportRead();
    return super._updatedShoppingCartFuture;
  }

  @override
  set _updatedShoppingCartFuture(
      ObservableFuture<Response<ShoppingCart>> value) {
    _$_updatedShoppingCartFutureAtom
        .reportWrite(value, super._updatedShoppingCartFuture, () {
      super._updatedShoppingCartFuture = value;
    });
  }

  @override
  String toString() {
    return '''
updatedShoppingCart: ${updatedShoppingCart},
getShoppingCartState: ${getShoppingCartState}
    ''';
  }
}
