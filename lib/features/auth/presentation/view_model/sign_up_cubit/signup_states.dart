

import 'package:e_shop/features/auth/data/models/login_model.dart';

abstract class SignUpStates{}
class SignUpInitState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{
   final AuthModel signUpModel;

   SignUpSuccessState(this.signUpModel);
}
class SignUpErrorState extends SignUpStates{
  final String errMessage;

   SignUpErrorState(this.errMessage);
}
