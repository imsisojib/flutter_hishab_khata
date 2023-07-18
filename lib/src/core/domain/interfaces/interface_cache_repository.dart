
abstract class ICacheRepository{
  Future<void> saveToken(String token);
  String? fetchToken();
  Future<void>? saveCurrentUserId(int? id);
  int? fetchCurrentUserId();
  void logout();

  String? fetchLoginEmail();
  String? fetchLoginPassword();
  Future<void> rememberLoginCredentials(bool flag);
  bool fetchRememberLoginCredentials();
  Future<void> saveEmailAndPassword({
    required String email,
    required String password,
  });
}