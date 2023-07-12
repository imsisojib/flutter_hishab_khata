import 'dart:convert';

import 'package:flutter_hishab_khata/src/config/config_api.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';

class OrdersRepository implements IOrdersRepository {
  //final HishabDatabase db;

  //final HishabDatabase db;
  final IApiInterceptor apiInterceptor;
  final TokenService tokenService;

  OrdersRepository({required this.apiInterceptor, required this.tokenService});

  @override
  Future<int?> addOrder(RequestOrder request) async {

    var response = await apiInterceptor.post(
      endPoint: ConfigApi.createOrder,
      body: jsonEncode(request.toJson()),
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    if(response.statusCode!=200){
      Debugger.debug(title: "OrdersRepository.addOrder(): request", data: request.toJson(),);
      Debugger.debug(title: "OrdersRepository.addOrder(): response", data: response.body, statusCode: response.statusCode,);
    }else{
      print("------------uploaded: ${request.phoneNumber}");
    }


    return response.statusCode;

    /*int? result = await db.database?.insert(db.ordersTable, order.toJson());
    Debugger.debug(
      title: "OrdersRepository.addOrder",
      data: result,
    );
    return result;*/
  }

  @override
  Future<int?> deleteOrder(var orderId) async {
    var response = await apiInterceptor.post(
      endPoint: ConfigApi.deleteOrder(orderId),
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.debug(
      title: "OrdersRepository.deleteOrder(): response",
      data: response.body,
      statusCode: response.statusCode,
    );

    return response.statusCode;
  }

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    List<OrderModel> orders = [];

    var response = await apiInterceptor.get(
      endPoint: ConfigApi.allOrders,
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.debug(
      title: "OrdersRepository.fetchAllOrders(): response",
      data: response.body,
      statusCode: response.statusCode,
    );
    var data = jsonDecode(response.body);
    data['result'].forEach((map){
      orders.add(OrderModel.fromJson(map));
    });
    return orders;
  }

  @override
  Future<List<OrderModel>> fetchAllOrdersByPhoneNumber(String phoneNumber) async {
    List<OrderModel> orders = [];

    var response = await apiInterceptor.get(
      endPoint: ConfigApi.findOrdersByPhoneNumber(phoneNumber),
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.debug(
      title: "OrdersRepository.fetchAllOrders(): response",
      data: response.body,
      statusCode: response.statusCode,
    );
    var data = jsonDecode(response.body);
    data['result'].forEach((map){
      orders.add(OrderModel.fromJson(map));
    });
    return orders;
  }

  @override
  Future<OrderModel?> totalOrdersInfoByPhoneNumber(String phoneNumber) async {
    var response = await apiInterceptor.get(
      endPoint: ConfigApi.calculateOrdersForPhoneNumber(phoneNumber),
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.debug(
      title: "OrdersRepository.fetchAllOrders(): response",
      data: response.body,
      statusCode: response.statusCode,
    );
    var data = jsonDecode(response.body);
    return OrderModel.fromJson(data['result']);
  }

  @override
  Future<int?> updateOrder(OrderModel order) async {
    /*int? result = await db.database
        ?.update(db.ordersTable, order.toJson(), where: 'id = ?', whereArgs: [order.id]);
    Debugger.debug(
      title: "OrdersRepository.updateOrder",
      data: result,
    );
    return result;*/

    return null;
  }

  @override
  Future<int?> countTotalOrders() async {
    var response = await apiInterceptor.get(
      endPoint: ConfigApi.countOrders,
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.debug(
      title: "OrdersRepository.countTotalOrders(): response",
      data: response.body,
      statusCode: response.statusCode,
    );
    var data = jsonDecode(response.body);
    return data['result'];
  }
}
