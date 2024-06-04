import 'package:equatable/equatable.dart';

class AuthModel extends Equatable{
  bool? status;
String? message;
  LoginData? data;

   AuthModel({ this.status, this.message, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    status,message,data
  ];

  
}

class LoginData extends Equatable{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  LoginData(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.points,
      this.credit,
      this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,email,phone,image,id,token,phone,credit];

  
}