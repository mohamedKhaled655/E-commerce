import 'package:equatable/equatable.dart';

class BannersModel extends Equatable{
  int? id;
  String? image;
  Category? category;
  

  BannersModel({this.id, this.image, this.category, });

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,image,category];

 
}

class Category extends Equatable{
  int? id;
  String? image;
  String? name;

  Category({this.id, this.image, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,image,name];

 
}