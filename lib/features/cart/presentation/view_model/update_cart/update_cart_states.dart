

import 'package:e_shop/features/cart/data/models/update_quantity_model.dart';

abstract class UpdateCartStates{}
class UpdateCartInitState extends UpdateCartStates{}
class UpdateCartLoadingState extends UpdateCartStates{}
class UpdateCartSuccessState extends UpdateCartStates{
final UpdateQuantityModel updateQuantityModel;

   UpdateCartSuccessState(this.updateQuantityModel);
}
class UpdateCartErrorState extends UpdateCartStates{
  final String errMessage;

   UpdateCartErrorState(this.errMessage);
}

class ChangeQuantityState extends UpdateCartStates{}
class ChangeQuantityPlusState extends UpdateCartStates{}
class ChangeQuantityMinusState extends UpdateCartStates{}