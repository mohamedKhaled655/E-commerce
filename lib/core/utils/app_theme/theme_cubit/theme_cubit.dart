

import 'package:e_shop/core/utils/app_theme/theme_cache_helper.dart';
import 'package:e_shop/core/utils/app_theme/theme_cubit/theme_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitState());

  static ThemeCubit get(context)=>BlocProvider.of(context);


  

  bool isDark=false;
  
  void changeTheme({bool? cached})async{
    if(cached !=null){
      isDark=cached;
      emit(ThemeSuccessState());
    }
    else{
      isDark= !isDark;
    ThemeCacheHelper themeCacheHelper= ThemeCacheHelper();
    themeCacheHelper.cacheTheme(isDark).then((value) {
      emit(ThemeChangeState());
    });
    }
    
    
  }



}