
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_address_states.dart';


class AddAddressCubit extends Cubit<AddAddressStates> {
  AddAddressCubit(this.homeRepo) : super(AddAddressInitState());

  static AddAddressCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;


  Future<void>addAddressData({required String name,required String city,required String details,required String notes,required String region,required String lat,required String long,})async{
    emit(AddAddressLoadingState());
    var result= await homeRepo.addAddress(name: name, city: city, region: region, notes: notes, details: details, lat: lat, long: long,token: token,lang: language);
    result.fold((failure) {
      emit(AddAddressErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (addAddress){
   
      emit(AddAddressSuccessState(addAddress));
     
      print("AddAddress=${addAddress.message}");
    
    });
  }

  

}