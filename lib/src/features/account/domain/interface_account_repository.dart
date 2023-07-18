import 'package:flutter_hishab_khata/src/core/data/models/api_response.dart';
import 'package:flutter_hishab_khata/src/features/account/data/requests/request_login.dart';

abstract class IAccountRepository{
  Future<ApiResponse> login(RequestLogin request);
}