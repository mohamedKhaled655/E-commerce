import 'package:shared_preferences/shared_preferences.dart';

class CacheOnbording{
  Future<void> cacheBoarding(bool onBording) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("onBording", onBording);
  }
}