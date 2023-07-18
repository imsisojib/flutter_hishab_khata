import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_hishab_khata/src/features/account/presentation/providers/account_provider.dart';
import 'package:flutter_hishab_khata/src/helpers/connectivity_helper.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiInterceptor implements IApiInterceptor {
  final String baseUrl;

  ApiInterceptor({required this.baseUrl});

  @override
  Future<http.Response> get(
      {required String endPoint,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    if (!await ConnectivityHelper.hasInternetConnection()) {
      return http.Response('No Internet Connection!', 504);
    }
    try {
      Uri url = Uri.parse(baseUrl + endPoint);
      var response =  await http.get(
        url,
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          return http.Response('Server response timeout.', 408);
        },
      );

      if(response.statusCode==401){
        makeLogout();
      }

      return response;

    } catch (e) {
      Debugger.error(title: 'ApiInterceptor.get()', data: e);
      return http.Response('$e', 404);
    }
  }

  @override
  Future<http.Response> post(
      {required String endPoint,
      Map<String, String>? headers,
      dynamic body}) async {
    if (!await ConnectivityHelper.hasInternetConnection()) {
      return http.Response('No Internet Connection!', 504);
    }
    try {
      Uri url = Uri.parse(baseUrl + endPoint);
      var response = await http.post(
        url,
        body: body,
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          return http.Response('Server response timeout.', 408);
        },
      );

      if(response.statusCode==401){
        makeLogout();
      }

      return response;

    } catch (e) {
      Debugger.error(title: 'ApiInterceptor.post()', data: e);
      return http.Response('$e', 404);
    }
  }

  @override
  Future<http.Response> delete(
      {required String endPoint,
      Map<String, String>? headers,
      dynamic body}) async {
    if (!await ConnectivityHelper.hasInternetConnection()) {
      return http.Response('No Internet Connection!', 504);
    }
    try {
      Uri url = Uri.parse(baseUrl + endPoint);
      var response = await http.delete(
        url,
        body: body,
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          return http.Response('Server response timeout.', 408);
        },
      );

      if(response.statusCode==401){
        makeLogout();
      }

      return response;

    } catch (e) {
      Debugger.error(title: 'ApiInterceptor.post()', data: e);
      return http.Response('$e', 404);
    }
  }

  @override
  Future<http.Response> put(
      {required String endPoint, Map<String, String>? headers, body}) async {
    if (!await ConnectivityHelper.hasInternetConnection()) {
      return http.Response('No Internet Connection!', 504);
    }
    try {
      Uri url = Uri.parse(baseUrl + endPoint);
      var response = await http.put(
        url,
        body: body,
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          return http.Response('Server response timeout.', 408);
        },
      );

      if(response.statusCode==401){
        makeLogout();
      }

      return response;

    } catch (e) {
      Debugger.error(title: 'ApiInterceptor.post()', data: e);
      return http.Response('$e', 404);
    }
  }

  @override
  Future<http.Response> postFormData({
    required String endPoint,
    required Map<String,String> headers,
    required Map<String,String> map,
    List<http.MultipartFile>? files,
  }) async{
    try{
      Uri url = Uri.parse(baseUrl + endPoint);
      var requestHttp = http.MultipartRequest("POST", url);
      requestHttp.fields.addAll(map);
      requestHttp.headers.addAll(headers);

      //add files if available
      if(files!=null){
        requestHttp.files.addAll(files);
      }

      http.StreamedResponse streamResponse = await requestHttp.send();
      http.Response response = await http.Response.fromStream(streamResponse);

      if(response.statusCode==401){
        makeLogout();
      }

      return response;

      return response;
    }catch(e){
      Debugger.error(title: 'ApiInterceptor.postFormData()', data: e);
      return http.Response('$e', 404);
    }

  }

  void makeLogout(){
    Provider.of<AccountProvider>(sl<NavigationService>().navigatorKey.currentContext!,listen: false).logout();
  }
}
