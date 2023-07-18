import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CacheRepositoryImpl implements ICacheRepository{
  final SharedPreferences sharedPreference;
  CacheRepositoryImpl({required this.sharedPreference});

  @override
  String? fetchToken() {
    return sharedPreference.getString('key_app_session_token');
  }

  @override
  Future<void> saveToken(String token) async{
    await sharedPreference.setString('key_app_session_token', token);
  }

  @override
  int? fetchCurrentUserId() {
    return sharedPreference.getInt("key_current_user_id");
  }

  @override
  Future<void>? saveCurrentUserId(int? id) async{
    await sharedPreference.setInt('key_current_user_id', id??-1);
  }

  @override
  void logout() async{
    await sharedPreference.setInt('key_current_user_id', -1);
    await sharedPreference.setString('key_app_session_token', '');
  }

  @override
  String? fetchLoginEmail() {
    return sharedPreference.getString('key_login_email');
  }

  @override
  String? fetchLoginPassword() {
    return sharedPreference.getString('key_login_password');
  }

  @override
  Future<void> rememberLoginCredentials(bool flag) async {
    await sharedPreference.setBool('key_remember_login_credentials', flag);
  }

  @override
  Future<void> saveEmailAndPassword({required String email, required String password}) async {
    await sharedPreference.setString('key_login_email', email,);
    await sharedPreference.setString('key_login_password', password,);
  }

  @override
  bool fetchRememberLoginCredentials() {
    return sharedPreference.getBool('key_remember_login_credentials')??false;
  }

}