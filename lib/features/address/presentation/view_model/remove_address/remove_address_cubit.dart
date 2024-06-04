
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/address/presentation/view_model/remove_address/remove_address_states.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RemoveAddressCubit extends Cubit<RemoveAddressStates> {
  RemoveAddressCubit(this.homeRepo) : super(RemoveAddressInitState());

  static RemoveAddressCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;


 Future<void>removeAddressData({required int id})async{
    emit(RemoveAddressLoadingState());
    var result= await homeRepo.removeAddress(id: id,token: token,lang: language);
    result.fold((failure) {
      emit(RemoveAddressErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (address){
   
      emit(RemoveAddressSuccessState(address));
     
      print("remove Address=${address.message}");
    
    });
  }

  

}