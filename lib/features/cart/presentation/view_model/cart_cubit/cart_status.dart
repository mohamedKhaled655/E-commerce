
import '../../../../home/data/models/favorites_mode.dart';
import '../../../data/models/cart_model.dart';

abstract class CartStates{}
class CartInitState extends CartStates{}
class CartLoadingState extends CartStates{}
class CartSuccessState extends CartStates{
final CartModel cart;

   CartSuccessState(this.cart);
}
class CartErrorState extends CartStates{
  final String errMessage;

   CartErrorState(this.errMessage);
}

class RemoveCartLoadingState extends CartStates{}
class RemoveCartSuccessState extends CartStates{
final FavoritesModel data;

   RemoveCartSuccessState(this.data);
}
class RemoveCartErrorState extends CartStates{
  final String errMessage;

   RemoveCartErrorState(this.errMessage);
}

