
import 'package:get_it/get_it.dart';
import 'package:shopping_buddy_frontend/app/data/services/group_member_service.dart';
import 'package:shopping_buddy_frontend/app/data/services/group_service.dart';
import 'package:shopping_buddy_frontend/app/data/services/shopping_cart_service.dart';
import 'package:shopping_buddy_frontend/app/data/services/user_service.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_member_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/group_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/navigation_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/shopping_cart_store.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/nav_helper.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  serviceLocator.registerLazySingleton(() => NavHelper());

  serviceLocator.registerSingleton<UserService>(UserService.create());
  serviceLocator.registerSingleton<GroupService>(GroupService.create());
  serviceLocator.registerSingleton<GroupMemberService>(GroupMemberService.create());
  serviceLocator.registerSingleton<ShoppingCartService>(ShoppingCartService.create());

  serviceLocator.registerSingleton<UserStore>(UserStore());
  serviceLocator.registerSingleton<NavigationStore>(NavigationStore());
  serviceLocator.registerSingleton<GroupStore>(GroupStore());
  serviceLocator.registerSingleton<GroupMemberStore>(GroupMemberStore());
  serviceLocator.registerSingleton<ShoppingCartStore>(ShoppingCartStore());
}
