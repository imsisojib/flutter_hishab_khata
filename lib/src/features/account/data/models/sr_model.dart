class User {
  String? token;
  int? id;
  String? username;
  String? email;
  List<String>? roles;

  User({this.token, this.id, this.username, this.email, this.roles});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['roles'] = this.roles;
    return data;
  }
}