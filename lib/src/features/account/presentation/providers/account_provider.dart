import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/data/models/api_response.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_hishab_khata/src/features/account/data/models/sr_model.dart';
import 'package:flutter_hishab_khata/src/features/account/data/requests/request_login.dart';
import 'package:flutter_hishab_khata/src/features/account/domain/interface_account_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';
import 'package:flutter_hishab_khata/src/helpers/widget_helper.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountProvider extends ChangeNotifier {
  final IAccountRepository accountRepository;

  AccountProvider({required this.accountRepository});

  //states
  bool _loading = false;
  bool _rememberLoginCredentials = true;
  RequestLogin _requestLogin = RequestLogin();
  User? _currentUser;

  //getters
  bool get loading => _loading;
  bool get rememberLoginCredentials => _rememberLoginCredentials;
  RequestLogin get requestLogin => _requestLogin;
  User? get currentUser => _currentUser;

  //setters
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  set rememberLoginCredentials(bool flag){
    _rememberLoginCredentials = flag;
    notifyListeners();
  }

  set requestLogin(RequestLogin request){
    _requestLogin = request;
    notifyListeners();
  }

  set currentUser(User? model){
    _currentUser = model;
    notifyListeners();
  }

  //methods

  void initLoginPage() {
    _rememberLoginCredentials = sl<ICacheRepository>().fetchRememberLoginCredentials();
    if(_rememberLoginCredentials){
      _requestLogin.username = sl<ICacheRepository>().fetchLoginEmail();
      _requestLogin.password = sl<ICacheRepository>().fetchLoginPassword();
      _requestLogin.emailController.text = _requestLogin.username??"";
      _requestLogin.passwordController.text = _requestLogin.password??"";
    }
    Debugger.debug(title: "remember credentials", data: _rememberLoginCredentials,);
    Debugger.debug(title: "email credentials", data: _requestLogin.username,);
    Debugger.debug(title: "pass credentials", data: _requestLogin.password,);
    notifyListeners();
  }

  void login() async {
    if (_requestLogin.username ==null || _requestLogin.username!.isEmpty) {
      //invalid email, return
      WidgetHelper.showFailedToast("Invalid email address!");
      return;
    }
    if (_requestLogin.username==null || _requestLogin.password!.isEmpty) {
      //invalid email, return
      WidgetHelper.showFailedToast("Password can't be empty!");
      return;
    }
    loading = true;

    ApiResponse apiResponse = await accountRepository.login(_requestLogin);
    if (apiResponse.statusCode == 200) {
      var mappedJson = jsonDecode(apiResponse.result);
      User? user = User.fromJson(mappedJson["result"]);
      if (user.token!=null) {
        //successful
        WidgetHelper.showSuccessToast(mappedJson["message"] ?? "Login Successful.");
        sl<TokenService>().updateToken(user.token ?? "");
        sl<ICacheRepository>().saveToken(user.token ?? "");
        sl<ICacheRepository>().rememberLoginCredentials(_rememberLoginCredentials);
        if (_rememberLoginCredentials) {
          //save credentials, and flag
          sl<ICacheRepository>().saveEmailAndPassword(
            email: requestLogin.username??"",
            password: requestLogin.password??"",
          );
        }
        ///NOW NAVIGATE TO HOME-PAGE
        sl<NavigationService>().pushNamedANdRemoveUntil(Routes.homeScreen,);
        requestLogin = RequestLogin(); //clear data
      }else{
        WidgetHelper.showFailedToast("You are not allowed to access App.");
      }
    } else {
      WidgetHelper.showFailedToast("Invalid credentials!");
    }

    loading = false;
  }

  void logout() {
    Fluttertoast.showToast(msg: "Session Expired! Please login to continue!");
    sl<ICacheRepository>().logout();
    sl<NavigationService>().pushNamedANdRemoveUntil(Routes.loginScreen,);
  }



}
