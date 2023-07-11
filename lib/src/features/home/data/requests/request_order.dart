class RequestOrder {
  double? total;
  double? paid;
  double? discount;
  double? due;
  String? phoneNumber;
  String? createdAt;

  RequestOrder({
    this.total = 0,
    this.paid = 0,
    this.discount = 0,
    this.due = 0,
    this.phoneNumber,
    this.createdAt,
  });

  RequestOrder.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    paid = json['paid'];
    discount = json['discount'];
    due = json['due'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['paid'] = paid;
    data['discount'] = discount;
    data['due'] = due;
    data['phoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt;
    return data;
  }
}
