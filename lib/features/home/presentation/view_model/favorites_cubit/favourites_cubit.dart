
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant.dart';
import '../../../data/models/get_favorite_model.dart';
import 'favorites_states.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit(this.homeRepo) : super(FavoritesInitState());

  static FavoritesCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;
 
  
  Future<void>changeFavorites({required int id,required BuildContext context,})async{
    //BlocProvider.of<ProductCubit>(context).favorites[id]=! BlocProvider.of<ProductCubit>(context).favorites[id]!;
    favorites[id]=! favorites[id]!;
    emit(FavoritesLoadingState());
    var result= await homeRepo.fetchFavorites(id: id,lang: language,token: token);
    result.fold((failure) {
      emit(FavoritesErrorState(failure.errorMessage));
     // BlocProvider.of<ProductCubit>(context).favorites[id]=! BlocProvider.of<ProductCubit>(context).favorites[id]!;
     favorites[id]=! favorites[id]!;
      print("errorMessage=${failure.errorMessage}");
    }, (favorite){
      emit(FavoritesSuccessState(favorite));
      if(!favorite.status!){
        //BlocProvider.of<ProductCubit>(context).favorites[id]=! BlocProvider.of<ProductCubit>(context).favorites[id]!;
        favorites[id]=! favorites[id]!;
        isfav=false;
      }else{
        getFavorites();
        isfav=true;
        emit(GetFavoritesSeccState());
      }
      print("favorite=${favorite.message}");
    });
  }

  ////
 late bool isfav ;
  List<GetFavoriteModel> ?fav;
  Future<void>getFavorites()async{
    emit(GetFavoritesLoadingState());
    var result= await homeRepo.getFavorites(lang: language,token: token);
    result.fold((failure) {
      emit(GetFavoritesErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (favorite){
      fav=favorite;
      emit(GetFavoritesSuccessState(favorite));
      
      print("get favorite=$favorite");
    });
  }


  //
   Future<void>removeFavorites({required int id})async{
    emit(RemoveFavoritesLoadingState());
    var result= await homeRepo.removeFavorites(lang: language,token: token,id: id);
    result.fold((failure) {
      emit(RemoveFavoritesErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (removeFav){
      getFavorites();
      emit(RemoveFavoritesSuccessState(removeFav));
      
      print("get favorite=$removeFav");
    });
  }

}