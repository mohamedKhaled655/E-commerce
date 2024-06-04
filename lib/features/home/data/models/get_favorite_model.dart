import 'package:equatable/equatable.dart';

class GetFavoriteModel extends Equatable{
  int? id;
  Product? product;

  GetFavoriteModel({this.id, this.product});

  GetFavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, product];

 
}

class Product extends Equatable{
  int? id;
  num? price;
  num? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,price,oldPrice,discount,image,name,description];

  
}