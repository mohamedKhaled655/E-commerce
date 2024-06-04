
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit(this.homeRepo) : super(AddressInitState());

  static AddressCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;

  //Map <int,bool>favorites={};

  Future<void>fetchAddressData()async{
    emit(AddressLoadingState());
    var result= await homeRepo.fetchAddress(
      lang: language,
      token: token
    );
    result.fold((failure) {
      emit(AddressErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (address){
   
      emit(AddressSuccessState(address));
     
      print("Address=$address");
    
    });
  }

  int selectedOption=0 ;
  Future<void> cacheAddressIndex(int indexAddress) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("indexAddress", indexAddress);
   // emit(SaveAddressState());
  }
  Future<void> getAddressIndex() async {
    final sharedPreferences = await SharedPreferences.getInstance();
     selectedOption=sharedPreferences.getInt("indexAddress")!;
     print("address index=$selectedOption");
     emit(GetSavedAddressState());
  }

  

}