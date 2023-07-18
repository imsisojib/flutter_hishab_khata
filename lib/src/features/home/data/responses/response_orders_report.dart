import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';

class ResponseOrdersReport {
  int? ordersCount;
  double? total;
  List<OrderModel>? data;
  double? due;
  double? paid;
  double? discount;

  ResponseOrdersReport(
      {this.ordersCount,
        this.total,
        this.data,
        this.due,
        this.paid,
        this.discount});

  ResponseOrdersReport.fromJson(Map<String, dynamic> json) {
    ordersCount = json['ordersCount'];
    total = json['total'];
    if (json['data'] != null) {
      data = <OrderModel>[];
      json['data'].forEach((v) {
        data!.add(OrderModel.fromJson(v));
      });
    }
    due = json['due'];
    paid = json['paid'];
    discount = json['discount'];
  }

  @override
  String toString() {
    return 'ResponseOrdersReport{ordersCount: $ordersCount, total: $total, due: $due, paid: $paid, discount: $discount}';
  }
}