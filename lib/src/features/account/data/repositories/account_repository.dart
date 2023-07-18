import 'dart:convert';
import 'package:flutter_hishab_khata/src/config/config_api.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/data/models/api_response.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_hishab_khata/src/features/account/data/requests/request_login.dart';
import 'package:flutter_hishab_khata/src/features/account/domain/interface_account_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';
import 'package:http/http.dart' as http;

class AccountRepository implements IAccountRepository {
  final IApiInterceptor apiInterceptor;
  final TokenService tokenService;

  AccountRepository({
    required this.apiInterceptor,
    required this.tokenService,
  });

  @override
  Future<ApiResponse> login(RequestLogin request) async {
    http.Response response = await apiInterceptor.post(
      endPoint: ConfigApi.userLogin,
      body: jsonEncode({
        "username": request.username,
        "password": request.password,
      }),
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.info(
      title: 'AccountRepository.login(): response-body',
      data: response.body,
      statusCode: response.statusCode,
    );

    return ApiResponse(statusCode: response.statusCode, result: response.body);
  }
}
