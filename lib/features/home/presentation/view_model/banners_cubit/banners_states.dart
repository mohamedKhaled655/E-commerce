import 'package:e_shop/features/home/data/models/banner_model.dart';

abstract class BannersStates{}
class BannersInitState extends BannersStates{}
class BannersLoadingState extends BannersStates{}
class BannersSuccessState extends BannersStates{
final List<BannersModel> banners;

   BannersSuccessState(this.banners);
}
class BannersErrorState extends BannersStates{
  final String errMessage;

   BannersErrorState(this.errMessage);
}