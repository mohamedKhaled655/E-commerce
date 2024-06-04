

import 'package:e_shop/features/auth/data/models/login_model.dart';

abstract class SettingStates{}
class SettingInitState extends SettingStates{}
class SettingLoadingState extends SettingStates{}
class SettingSuccessState extends SettingStates{
final AuthModel profileModel;

   SettingSuccessState(this.profileModel);
}
class SettingErrorState extends SettingStates{
  final String errMessage;

   SettingErrorState(this.errMessage);
}