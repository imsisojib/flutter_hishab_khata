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
  Future<int?> deleteOrder(int orderId) async {
    /*int? result = await db.database?.delete(
      db.ordersTable,
      where: 'id = ?',
      whereArgs: [orderId],
    ).onError((error, stackTrace) {
      Debugger.debug(
        title: "OrdersRepository.deleteOrder: onError",
        data: error,
      );
      return -1;
    });
    Debugger.debug(
      title: "OrdersRepository.deleteOrder",
      data: result,
    );
    return result;*/

    return null;
  }

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    //List<Map<String, Object?>>? mapList = await db.database?.query(db.ordersTable);
    /*List<Map<String, Object?>>? mapList = await db.database?.rawQuery("""SELECT
        ${db.ordersTable}.id as id,
        ${db.ordersTable}.total as total,
        ${db.ordersTable}.paid as paid,
        ${db.ordersTable}.discount as discount,
        ${db.ordersTable}.due as due,
        ${db.ordersTable}.created_at as created_at,
        ${db.ordersTable}.phone_number as phone_number,
        (SELECT ${db.customerTable}.name FROM ${db.customerTable}
        WHERE ${db.customerTable}.phone_number = ${db.ordersTable}.phone_number) as name
        FROM ${db.ordersTable}""");
    Debugger.debug(
      title: "OrdersRepository.fetchAllOrders",
      data: mapList,
    );

    List<OrderModel> ordersList = [];
    for (Map<String, Object?> item in mapList!) {
      ordersList.add(OrderModel.fromJson(item));
    }
    return ordersList;*/

    return [];
  }

  @override
  Future<List<OrderModel>> fetchAllOrdersByPhoneNumber(String phoneNumber) async {
    /*Debugger.debug(
      title: "OrdersRepository.fetchAllOrdersByPhoneNumber: request",
      data: phoneNumber,
    );
    */ /*List<Map<String, Object?>>? mapList = await db.database?.query(
      db.ordersTable,
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
    );*/ /*
    List<Map<String, Object?>>? mapList = await db.database?.rawQuery(
        """SELECT
        ${db.ordersTable}.id as id,
        ${db.ordersTable}.total as total,
        ${db.ordersTable}.paid as paid,
        ${db.ordersTable}.discount as discount,
        ${db.ordersTable}.due as due,
        ${db.ordersTable}.created_at as created_at,
        ${db.ordersTable}.phone_number as phone_number,
        ${db.customerTable}.name as name
        FROM ${db.ordersTable}
        LEFT JOIN ${db.customerTable}
        ON ${db.ordersTable}.phone_number = ${db.customerTable}.phone_number
        WHERE ${db.ordersTable}.phone_number = ?
        """,
        [phoneNumber]
    );
    Debugger.debug(
      title: "OrdersRepository.fetchAllOrdersByPhoneNumber",
      data: mapList,
    );

    List<OrderModel> ordersList = [];
    for (Map<String, Object?> item in mapList!) {
      ordersList.add(OrderModel.fromJson(item));
    }
    return ordersList;*/

    return [];
  }

  @override
  Future<OrderModel?> totalOrdersInfoByPhoneNumber(String phoneNumber) async {
    /*Debugger.debug(
      title: "OrdersRepository.totalOrdersInfoByPhoneNumber: request",
      data: phoneNumber,
    );
    */ /*List<Map<String, Object?>>? mapList = await db.database?.query(
      db.ordersTable,
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
    );*/ /*
    List<Map<String, Object?>>? mapList = await db.database?.rawQuery(
        """SELECT
        SUM(${db.ordersTable}.total) as total,
        SUM(${db.ordersTable}.paid) as paid,
        SUM(${db.ordersTable}.discount) as discount,
        SUM(${db.ordersTable}.due) as due
        FROM ${db.ordersTable}
        WHERE phone_number = ?
        """,
      [phoneNumber],
    );
    Debugger.debug(
      title: "OrdersRepository.totalOrdersInfoByPhoneNumber: result",
      data: mapList,
    );

    return OrderModel.fromJson(mapList?.first??{});*/

    return null;
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
