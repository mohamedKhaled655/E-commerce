

import '../../../data/model/address_model.dart';

abstract class AddressStates{}
class AddressInitState extends AddressStates{}
class AddressLoadingState extends AddressStates{}
class AddressSuccessState extends AddressStates{
final List<AddressModel> addressModel;

   AddressSuccessState(this.addressModel);
}
class AddressErrorState extends AddressStates{
  final String errMessage;

   AddressErrorState(this.errMessage);
}

class SaveAddressState extends AddressStates{}
class GetSavedAddressState extends AddressStates{}


