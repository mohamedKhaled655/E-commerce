

import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_status.dart';



class CartCubit extends Cubit<CartStates> {
  CartCubit(this.homeRepo) : super(CartInitState());

  static CartCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;
  
  Future<void>fetchCartItems()async{
    emit(CartLoadingState());
    var result= await homeRepo.fetchCart(
      token: token,
      lang: language,
    );
    result.fold((failure) {
      emit(CartErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (cart){
      emit(CartSuccessState(cart));
      total=cart.data!.total!;
      print("total 1=$total");
      for (var element in cart.data!.cartItems!) { 
        count.addAll(
          {
            element.id!:element.quantity!
          } 
        );
        price.addAll(
          {
            element.id!:element.product!.price!
          } 
        );
        
      }
      
      print("price=$price");
      print("count=$count");
      print("Cart=${cart.data?.cartItems}");
    });
  }
  

  bool isRemove=false;
  Future<void>removeItemFromCart({required int id})async{
    emit(RemoveCartLoadingState());
    var result= await homeRepo.removeFromCart(
      id: id,
      token: token,
      lang: language,
    );
    result.fold((failure) {
      emit(RemoveCartErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (removeItem){
      fetchCartItems();
      isRemove=true;
      emit(RemoveCartSuccessState(removeItem));
      
      print("removeItem Cart=${removeItem.message}");
    });
  }

}