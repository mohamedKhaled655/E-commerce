

import '../../../../home/data/models/favorites_mode.dart';

abstract class AddAddressStates{}
class AddAddressInitState extends AddAddressStates{}
class AddAddressLoadingState extends AddAddressStates{}
class AddAddressSuccessState extends AddAddressStates{
final FavoritesModel favoritesModel;

   AddAddressSuccessState(this.favoritesModel);
}
class AddAddressErrorState extends AddAddressStates{
  final String errMessage;

   AddAddressErrorState(this.errMessage);
}

class SaveAddAddressState extends AddAddressStates{}
class GetSavedAddAddressState extends AddAddressStates{}

