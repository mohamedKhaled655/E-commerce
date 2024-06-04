import 'package:e_shop/features/home/data/models/category_model.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';

abstract class CategoriesDetailsStates{}
class CategoriesDetailsInitState extends CategoriesDetailsStates{}
class CategoriesDetailsLoadingState extends CategoriesDetailsStates{}
class CategoriesDetailsSuccessState extends CategoriesDetailsStates{
final List<ProductModel> categoriesDetailsModel;

   CategoriesDetailsSuccessState(this.categoriesDetailsModel);
}
class CategoriesDetailsErrorState extends CategoriesDetailsStates{
  final String errMessage;

   CategoriesDetailsErrorState(this.errMessage);
}