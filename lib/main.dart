import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hishab_khata/my_app.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_hishab_khata/src/features/account/presentation/providers/account_provider.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_customers.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_orders.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'di_container.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //to hide/change color of notification statusbar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffoldColorLight,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await di.init();  //initializing Dependency Injection

  //update auth-token from cache [to check user logged-in or not]
  var token = di.sl<ICacheRepository>().fetchToken();
  di.sl<TokenService>().updateToken(token??"");  //update token will re-initialize wherever token was used

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ProviderCustomers>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProviderOrders>()),
        ChangeNotifierProvider(create: (context) => di.sl<AccountProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}
