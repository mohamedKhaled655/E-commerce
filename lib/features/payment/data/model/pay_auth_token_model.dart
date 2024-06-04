class PaymentAuthTokenModel {
  String? token;

  PaymentAuthTokenModel({this.token});

  PaymentAuthTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  
}