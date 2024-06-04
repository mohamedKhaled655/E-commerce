
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/features/home/data/repo/home_repo.dart';
import 'package:e_shop/features/home/presentation/view_model/profile_cubit/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<SettingStates> {
  ProfileCubit(this.homeRepo) : super(SettingInitState());

  static ProfileCubit get(context)=>BlocProvider.of(context);
  
  final HomeRepo homeRepo;


  Future<void>fetchProfileData()async{
    emit(SettingLoadingState());
    var result= await homeRepo.fetchProfile(
      lang: language,
      token: token
    );
    result.fold((failure) {
      emit(SettingErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (profile){
   
      emit(SettingSuccessState(profile));
      print("Profile=${profile.data}");
      
      
    });
  }

}