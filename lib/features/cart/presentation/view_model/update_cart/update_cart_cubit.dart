


import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/cart/presentation/view_model/update_cart/update_cart_states.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class UpdateCartCubit extends Cubit<UpdateCartStates> {
  UpdateCartCubit(this.homeRepo) : super(UpdateCartInitState());

  static UpdateCartCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;
  
  Future<void>updateQuantityCartItems({required int id,required int quantity})async{
    emit(UpdateCartLoadingState());
    var result= await homeRepo.updateQuantityCart(id: id, quantity: quantity,token: token,lang: language);
    result.fold((failure) {
      emit(UpdateCartErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (updateCart){
      total=updateCart.data!.total!;
      emit(UpdateCartSuccessState(updateCart));
      print("updateCart=${updateCart.data!.cart}");
    });
  }

  int c=1;
  int x=1;
  void countQuantity({required String type,required int id}){
    if(type=="plus"){
      c=count[id]!;
      c++;
      count[id]=c;
      total=total+count[id]!*price[id]!;
      print("plus total=$total");
      updateQuantityCartItems(id: id,quantity:count[id]!,);
      emit(ChangeQuantityPlusState());
    }
     if(type=="minus"){
      c=count[id]!;
      if(c>1){
        c--;
       count[id]=c;
       total=total-count[id]!*price[id]!;
       print("minu total=$total");
       updateQuantityCartItems(id: id,quantity:count[id]! );
      }
      emit(ChangeQuantityMinusState());
    }
   // emit(ChangeQuantityState());
  }

}