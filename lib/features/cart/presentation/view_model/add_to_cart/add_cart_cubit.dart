


import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/cart/presentation/view_model/add_to_cart/add_cart_status.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AddCartCubit extends Cubit<AddToCartStates> {
  AddCartCubit(this.homeRepo) : super(AddToCartInitState());

  static AddCartCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;
  bool isChange=false;
  Future<void>addToCartItems({required int id,})async{
    emit(AddToCartLoadingState());
    var result= await homeRepo.addToCart(id: id,lang: language,token: token);
    result.fold((failure) {
      emit(AddToCartErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (addTodCart){
      isChange=!isChange;
      
      emit(AddToCartSuccessState(addTodCart));
      print("AddCart=${addTodCart.message}");
    });
  }

}