class Order {
  int? id;
  double? total;
  double? paid;
  double? discount;
  double? due;
  String? phoneNumber;

  Order(
      {this.id,
      this.total,
      this.paid,
      this.discount,
      this.due,
      this.phoneNumber});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    paid = json['paid'];
    discount = json['discount'];
    due = json['due'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['paid'] = paid;
    data['discount'] = discount;
    data['due'] = due;
    data['phone_number'] = phoneNumber;
    return data;
  }
}