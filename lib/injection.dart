import 'package:get_it/get_it.dart';
import 'package:groceries/domain/usecases/get_account.dart';
import 'package:groceries/domain/usecases/get_cart_fruits.dart';
import 'package:groceries/domain/usecases/remove_cart_fruit.dart';
import 'package:groceries/domain/usecases/save_cart_fruit.dart';
import 'package:groceries/presentation/bloc/account_bloc.dart';
import 'package:groceries/presentation/bloc/fruit_status_cubit.dart';

import 'data/datasource/account_remote_datasource.dart';
import 'data/datasource/db/database_helper.dart';
import 'data/datasource/fruit_local_datasource.dart';
import 'data/repositories/account_repositories_impl.dart';
import 'data/repositories/cart_repositories_impl.dart';
import 'domain/repositories/account_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/usecases/get_cart_fruit.dart';
import 'domain/usecases/update_cart_fruit.dart';
import 'presentation/bloc/cart_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => AccountBloc(locator()));
  locator.registerFactory(
    () => CartBloc(
        getCartFruits: locator(),
        saveCartFruit: locator(),
        removeCartFruit: locator(),
        updateCartFruit: locator(),
        getCartFruit: locator()),
  );
  locator.registerFactory(() => FruitStatusCubit(locator()));

  //use case
  locator.registerLazySingleton(() => GetAccountDetail(locator()));
  locator.registerLazySingleton(() => GetCartFruits(locator()));
  locator.registerLazySingleton(() => SaveCartFruit(locator()));
  locator.registerLazySingleton(() => RemoveCartFruit(locator()));
  locator.registerLazySingleton(() => UpdateCartFruit(locator()));
  locator.registerLazySingleton(() => GetCartFruit(locator()));

  //repository
  locator.registerLazySingleton<AccountRepository>(
      () => AccountRepositoriesImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<CartRepository>(
      () => CartRepositoriesImpl(localDataSource: locator()));

  //data sources
  locator.registerLazySingleton<AccountRemoteDatasource>(
      () => AccountRemoteDatasourceImpl());
  locator.registerLazySingleton<FruitLocalDataSource>(
      () => FruitLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
