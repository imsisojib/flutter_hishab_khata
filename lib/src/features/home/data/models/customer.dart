class Customer {
  String? phoneNumber;
  String? address;
  String? companyName;
  String? name;
  String? createdAt;

  Customer({this.phoneNumber, this.address, this.companyName, this.name});

  Customer.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    address = json['address'];
    companyName = json['company_name'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['company_name'] = companyName;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}