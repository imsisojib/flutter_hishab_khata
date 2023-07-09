import 'package:flutter_hishab_khata/src/core/data/database/hishab_database.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';

class OrdersRepository implements IOrdersRepository {
  final HishabDatabase db;

  OrdersRepository({required this.db});

  @override
  Future<int?> addOrder(OrderModel order) async {
    int? result = await db.database?.insert(db.ordersTable, order.toJson());
    Debugger.debug(
      title: "OrdersRepository.addOrder",
      data: result,
    );
    return result;
  }

  @override
  Future<int?> deleteOrder(int orderId) async {
    int? result = await db.database?.delete(
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
    return result;
  }

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    //List<Map<String, Object?>>? mapList = await db.database?.query(db.ordersTable);
    List<Map<String, Object?>>? mapList = await db.database?.rawQuery("""SELECT
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
    return ordersList;
  }

  @override
  Future<List<OrderModel>> fetchAllOrdersByPhoneNumber(String phoneNumber) async {
    Debugger.debug(
      title: "OrdersRepository.fetchAllOrdersByPhoneNumber: request",
      data: phoneNumber,
    );
    /*List<Map<String, Object?>>? mapList = await db.database?.query(
      db.ordersTable,
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
    );*/
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
    return ordersList;
  }

  @override
  Future<OrderModel?> totalOrdersInfoByPhoneNumber(String phoneNumber) async {
    Debugger.debug(
      title: "OrdersRepository.totalOrdersInfoByPhoneNumber: request",
      data: phoneNumber,
    );
    /*List<Map<String, Object?>>? mapList = await db.database?.query(
      db.ordersTable,
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
    );*/
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

    return OrderModel.fromJson(mapList?.first??{});
  }

  @override
  Future<int?> updateOrder(OrderModel order) async {
    int? result = await db.database
        ?.update(db.ordersTable, order.toJson(), where: 'id = ?', whereArgs: [order.id]);
    Debugger.debug(
      title: "OrdersRepository.updateOrder",
      data: result,
    );
    return result;
  }

  @override
  Future<int?> countTotalOrders() async {
    var result = await db.database?.rawQuery("SELECT COUNT(*) FROM ${db.ordersTable}");
    Debugger.debug(
      title: "OrdersRepository.countTotalCustomers",
      data: result,
    );

    return result?.first['COUNT(*)'] as int?;
  }
}
