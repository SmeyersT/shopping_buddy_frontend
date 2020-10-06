import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/app/data/services/shopping_cart_service.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:mobx/mobx.dart';

import '../StoreState.dart';


part 'shopping_cart_store.g.dart';

class ShoppingCartStore = _ShoppingCartStoreBase with _$ShoppingCartStore;

abstract class _ShoppingCartStoreBase with Store {

  final ShoppingCartService _shoppingCartService = serviceLocator.get<ShoppingCartService>();

  @observable
  ShoppingCart _updatedShoppingCart;

  @observable
  ObservableFuture<Response<ShoppingCart>> _updatedShoppingCartFuture;


  Future updateShoppingCart(ShoppingCart shoppingCart) async {
    _updatedShoppingCartFuture = ObservableFuture(
        _shoppingCartService.updateShoppingCart(shoppingCart)
    );
    Response<ShoppingCart> response = await _updatedShoppingCartFuture;
    _updatedShoppingCart = response.body;
  }

  @computed
  StoreState get getShoppingCartState {
    if (_updatedShoppingCartFuture == null || _updatedShoppingCartFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _updatedShoppingCartFuture.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

}
