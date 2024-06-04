import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:e_shop/features/home/presentation/view_model/category_cubit/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit(this.homeRepo) : super(CategoriesInitState());

  static CategoriesCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;

  Future<void>fetchCategoryData()async{
    emit(CategoriesLoadingState());
    var result= await homeRepo.fetchCategories(lang: language);
    result.fold((failure) {
      emit(CategoriesErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (category){
      emit(CategoriesSuccessState(category));
      print("category=$category");
    });
  }

}