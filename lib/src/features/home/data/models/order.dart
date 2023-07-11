import 'customer.dart';

class OrderModel {
  int? id;
  double? total;
  double? paid;
  double? discount;
  double? due;
  Customer? customer;
  String? createdAt;

  //local usages
  String? phoneNumber;

  OrderModel(
      {this.id,
        this.total,
        this.paid,
        this.discount,
        this.due,
        this.customer,
        this.createdAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    paid = json['paid'];
    discount = json['discount'];
    due = json['due'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
  }
}