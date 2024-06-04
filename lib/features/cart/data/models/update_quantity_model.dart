import 'package:equatable/equatable.dart';

class UpdateQuantityModel extends Equatable {
  bool? status;
  String? message;
  Data? data;

  UpdateQuantityModel({this.status, this.message, this.data});

  UpdateQuantityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status,message,data];

  
}

class Data extends Equatable{
  Cart? cart;
  int? subTotal;
  int? total;

  Data({this.cart, this.subTotal, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [total,subTotal,cart];

  
}

class Cart extends Equatable{
  int? id;
  int? quantity;
  Product? product;

  Cart({this.id, this.quantity, this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>[id,quantity,product];

 
}

class Product extends Equatable{
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  Product({this.id, this.price, this.oldPrice, this.discount, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,price,oldPrice,discount,image];


}