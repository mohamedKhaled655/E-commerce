import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable{
  int? id;
  String? name;
  String? image;

  CategoriesModel({this.id, this.name, this.image});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,image];

 
}