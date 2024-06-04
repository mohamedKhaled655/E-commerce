import 'package:e_shop/features/home/data/models/product_model.dart';

class CartModel {
  bool? status;
  
  Data? data;

  CartModel({this.status, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
   
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  List<CartItems>? cartItems;
  int? subTotal;
  int? total;

  Data({this.cartItems, this.subTotal, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }


}

class CartItems {
  int? id;
  int? quantity;
  ProductModel? product;

  CartItems({this.id, this.quantity, this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new ProductModel.fromJson(json['product']) : null;
  }

 
}

