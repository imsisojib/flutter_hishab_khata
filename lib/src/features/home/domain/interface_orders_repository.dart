import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';

abstract class IOrdersRepository{
  Future<int?> addOrder(Order order);
  Future<int?> deleteOrder(int orderId);
  Future<int?> updateOrder(Order order);
  Future<List<Order>> fetchAllOrders();
  Future<int?> countTotalOrders();
}