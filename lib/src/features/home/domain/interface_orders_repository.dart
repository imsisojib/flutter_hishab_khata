import 'package:flutter_hishab_khata/src/core/data/models/api_response.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_update_order.dart';

abstract class IOrdersRepository{
  Future<int?> addOrder(RequestOrder order);
  Future<int?> deleteOrder(var orderId);
  Future<int?> updateOrder(RequestUpdateOrder order);
  Future<List<OrderModel>> fetchAllOrders();
  Future<List<OrderModel>> fetchAllOrdersByPhoneNumber(String phoneNumber);
  Future<OrderModel?> totalOrdersInfoByPhoneNumber(String phoneNumber);
  Future<int?> countTotalOrders();
  Future<ApiResponse> calculateOrdersReport({required String fromDate, required String toDate});
}