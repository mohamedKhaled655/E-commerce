
import '../../../../home/data/models/favorites_mode.dart';

abstract class RemoveAddressStates{}
class RemoveAddressInitState extends RemoveAddressStates{}
class RemoveAddressLoadingState extends RemoveAddressStates{}
class RemoveAddressSuccessState extends RemoveAddressStates{
final FavoritesModel removeAddressModel;

   RemoveAddressSuccessState(this.removeAddressModel);
}
class RemoveAddressErrorState extends RemoveAddressStates{
  final String errMessage;

   RemoveAddressErrorState(this.errMessage);
}