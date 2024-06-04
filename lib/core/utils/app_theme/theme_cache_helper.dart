import 'package:shared_preferences/shared_preferences.dart';

class ThemeCacheHelper{
  Future<void> cacheTheme(bool isDark)async{
    final sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool("isDark", isDark);
  }

  Future<bool> getCacheTheme()async{
    final sharedPreferences=await SharedPreferences.getInstance();
    final themeSaved=sharedPreferences.getBool("isDark");
    if(themeSaved !=null){
      return themeSaved;
    }
    else{
      return false;
    }
  }
}