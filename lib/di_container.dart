import 'package:flutter_hishab_khata/src/config/config_api.dart';
import 'package:flutter_hishab_khata/src/core/application/api_interceptor.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/data/database/hishab_database.dart';
import 'package:flutter_hishab_khata/src/core/data/repositories/cache_repository_impl.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/data/repositories/customers_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/data/repositories/orders_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_customer_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_common.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //using dependency-injection
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  ///database
  HishabDatabase database = HishabDatabase();
  await database.init();
  sl.registerSingleton(database);  //initializing database for run-time


  ///REPOSITORIES
  //#region Repositories
  sl.registerLazySingleton<ICacheRepository>(() => CacheRepositoryImpl(sharedPreference: sl()));
  sl.registerLazySingleton<ICustomersRepository>(() => CustomerRepository(db: sl()));
  sl.registerLazySingleton<IOrdersRepository>(() => OrdersRepository(db: sl()));
  //#endregion

  ///USE-CASES


  ///END of USE-CASES

  ///PROVIDERS
  //region Providers
  sl.registerFactory(() => ProviderCommon(),);

  //interceptors
  sl.registerLazySingleton<IApiInterceptor>(() => ApiInterceptor(baseUrl: ConfigApi.baseUrl));   ///CHANGE SERVER HERE

  ///services
  sl.registerSingleton(NavigationService());  //to initialize navigator-key for app-runtime
  sl.registerSingleton(TokenService()); //token service to store token app-runtime
  //logger
  sl.registerLazySingleton(()=>Logger(
    printer: PrettyPrinter(
      colors: false,
    ),
  ),);


}