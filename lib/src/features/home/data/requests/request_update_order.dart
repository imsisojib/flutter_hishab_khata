class RequestUpdateOrder {
  int? id;
  double? total;
  double? paid;
  double? discount;
  double? due;

  RequestUpdateOrder(
      {this.id,
        this.total,
        this.paid,
        this.discount,
        this.due,
      });

  RequestUpdateOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    paid = json['paid'];
    discount = json['discount'];
    due = json['due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['paid'] = paid;
    data['discount'] = discount;
    data['due'] = due;
    return data;
  }

}