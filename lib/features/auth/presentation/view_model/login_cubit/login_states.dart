
import 'package:e_shop/features/auth/data/models/login_model.dart';

abstract class LoginStates{}
class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final AuthModel loginModel;

   LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates{
  final String errMessage;

   LoginErrorState(this.errMessage);
}
