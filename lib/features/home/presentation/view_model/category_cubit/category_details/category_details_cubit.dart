import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_detials_states.dart';

class CategoriesDetailsCubit extends Cubit<CategoriesDetailsStates> {
  CategoriesDetailsCubit(this.homeRepo) : super(CategoriesDetailsInitState());

  static CategoriesDetailsCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;

  Future<void>fetchCategoryDetails(int id)async{
    emit(CategoriesDetailsLoadingState());
    var result= await homeRepo.fetchCategoriesDetails(lang: language,id: id,token: token);
    result.fold((failure) {
      emit(CategoriesDetailsErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (category){
      emit(CategoriesDetailsSuccessState(category));
      print("category=$category");
    });
  }

}