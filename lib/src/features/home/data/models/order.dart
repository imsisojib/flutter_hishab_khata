import 'customer.dart';

class Order {
  int? id;
  double? total;
  double? paid;
  double? discount;
  double? due;
  String? phoneNumber;
  String? createdAt;
  Customer? customer; //local usages only

  Order(
      {this.id,
      this.total = 0,
      this.paid = 0,
      this.discount = 0,
      this.due = 0,
      this.phoneNumber});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    paid = json['paid'];
    discount = json['discount'];
    due = json['due'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['paid'] = paid;
    data['discount'] = discount;
    data['due'] = due;
    data['phone_number'] = phoneNumber;
    data['created_at'] = createdAt;
    return data;
  }
}