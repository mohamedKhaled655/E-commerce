import 'package:e_shop/features/home/data/models/category_model.dart';

abstract class CategoriesStates{}
class CategoriesInitState extends CategoriesStates{}
class CategoriesLoadingState extends CategoriesStates{}
class CategoriesSuccessState extends CategoriesStates{
final List<CategoriesModel> categoriesModel;

   CategoriesSuccessState(this.categoriesModel);
}
class CategoriesErrorState extends CategoriesStates{
  final String errMessage;

   CategoriesErrorState(this.errMessage);
}