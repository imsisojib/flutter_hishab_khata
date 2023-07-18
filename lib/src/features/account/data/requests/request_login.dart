import 'package:flutter/cupertino.dart';

class RequestLogin{
  String? username;
  String? password;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RequestLogin({this.username, this.password,});

  @override
  String toString() {
    return 'RequestLogin{email: $username, password: $password}';
  }
}