import 'package:dio/dio.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {

  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  getIt.registerSingleton<HomeRepoImplement>(HomeRepoImplement(
    getIt.get<ApiServices>(),
  ));


}