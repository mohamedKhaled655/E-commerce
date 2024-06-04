import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/auth/data/repo/auth_repo.dart';
import 'package:e_shop/features/auth/presentation/view_model/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constant.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.authRepo) : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final AuthRepo authRepo;

  Future<void> cacheToken(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }
  
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoginLoadingState());
    var result = await authRepo.loginAuth(
        email: email, password: password, lang: "en".tr(context));
    result.fold((failure) {
      emit(LoginErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (loginData) {
      emit(LoginSuccessState(loginData));
      print("loginData=$loginData");
      print(loginData.data!.token);
      cacheToken(loginData.data!.token ?? "");
    });
  }

  void getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token")! ;
  }
}
