import 'package:flutter_hishab_khata/src/core/data/database/hishab_database.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';

class OrdersRepository implements IOrdersRepository {
  final HishabDatabase db;

  OrdersRepository({required this.db});

  @override
  Future<int?> addOrder(Order order) async {
    int? result = await db.database?.insert(db.ordersTable, order.toJson());
    Debugger.debug(
      title: "OrdersRepository.addOrder",
      data: result,
    );
    return result;
  }

  @override
  Future<int?> deleteOrder(int orderId) async {
    int? result = await db.database?.delete(db.ordersTable,
        where: 'id = ?', whereArgs: [orderId]).onError((error, stackTrace) {
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
  Future<List<Order>> fetchAllOrders() async {
    List<Map<String, Object?>>? mapList = await db.database?.query(db.ordersTable);
    Debugger.debug(
      title: "OrdersRepository.fetchAllOrders",
      data: mapList,
    );

    List<Order> ordersList = [];
    for (Map<String, Object?> item in mapList!) {
      ordersList.add(Order.fromJson(item));
    }
    return ordersList;
  }

  @override
  Future<int?> updateOrder(Order order) async {
    int? result = await db.database
        ?.update(db.ordersTable, order.toJson(), where: 'id = ?', whereArgs: [order.id]);
    Debugger.debug(
      title: "OrdersRepository.updateOrder",
      data: result,
    );
    return result;
  }
}
