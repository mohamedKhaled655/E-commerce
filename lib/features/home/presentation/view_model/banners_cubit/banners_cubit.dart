

import 'package:e_shop/features/home/presentation/view_model/banners_cubit/banners_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/home_repo.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit(this.homeRepo) : super(BannersInitState());

  static BannersCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;

  Future<void>fetchBannerData()async{
    emit(BannersLoadingState());
    var result= await homeRepo.fetchBanner();
    result.fold((failure) {
      emit(BannersErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (banners){
      emit(BannersSuccessState(banners));
      print("banners=$banners");
    });
  }

}