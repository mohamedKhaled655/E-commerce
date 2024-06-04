

import 'package:e_shop/features/cart/data/models/add_cart_model.dart';

abstract class AddToCartStates{}
class AddToCartInitState extends AddToCartStates{}
class AddToCartLoadingState extends AddToCartStates{}
class AddToCartSuccessState extends AddToCartStates{
final AddCartModel addCartModel;

   AddToCartSuccessState(this.addCartModel);
}
class AddToCartErrorState extends AddToCartStates{
  final String errMessage;

   AddToCartErrorState(this.errMessage);
}