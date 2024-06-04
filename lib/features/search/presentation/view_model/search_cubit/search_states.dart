

import 'package:e_shop/features/home/data/models/product_model.dart';

abstract class SearchStates{}
class SearchInitState extends SearchStates{}
class SearchLoadingState extends SearchStates{}
class SearchSuccessState extends SearchStates{
final List<ProductModel> searchModel;

   SearchSuccessState(this.searchModel);
}
class SearchErrorState extends SearchStates{
  final String errMessage;

   SearchErrorState(this.errMessage);
}