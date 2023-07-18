class ResponseLogin {
  int? status;
  String? message;
  String? accessToken;
  String? isMobile;
  String? tokenType;
  int? expiresIn;

  ResponseLogin(
      {this.status,
        this.message,
        this.accessToken,
        this.isMobile,
        this.tokenType,
        this.expiresIn});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    isMobile = json['is_mobile'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

}