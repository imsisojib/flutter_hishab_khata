import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/my_app.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_common.dart';
import 'di_container.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();  //initializing Dependency Injection

  //update auth-token from cache [to check user logged-in or not]
  var token = di.sl<ICacheRepository>().fetchToken();
  di.sl<TokenService>().updateToken(token??"");  //update token will re-initialize wherever token was used

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ProviderCommon>()),
      ],
      child: const MyApp(),
    ),
  );
}
