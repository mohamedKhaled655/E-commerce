import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/auth/data/repo/auth_repo.dart';
import 'package:e_shop/features/auth/presentation/view_model/sign_up_cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this.authRepo) : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final AuthRepo authRepo;

  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String image,
      required BuildContext context}) async {
    emit(SignUpLoadingState());
    var result = await authRepo.signUpAuth(
        email: email,
        password: password,
        name: name,
        phone: phone,
        image: image);
    result.fold((failure) {
      emit(SignUpErrorState(failure.errorMessage));
      print("errorMessage=${failure.errorMessage}");
    }, (signUpData) {
      emit(SignUpSuccessState(signUpData));
      print("SignUpData=$signUpData");
    });
  }
}
