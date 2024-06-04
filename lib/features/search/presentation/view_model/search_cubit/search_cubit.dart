
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:e_shop/features/search/presentation/view_model/search_cubit/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(this.homeRepo) : super(SearchInitState());

  static SearchCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;


  Future<void>fetchSearchData({required String text})async{
    emit(SearchLoadingState());
    var result= await homeRepo.fetchSearch(
      lang: language,
      token: token,
      text: text
    );
    result.fold((failure) {
      emit(SearchErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (search){
   
      emit(SearchSuccessState(search));
      print("Search=$search");
        
    });
  }

}