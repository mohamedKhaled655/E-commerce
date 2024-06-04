

import 'package:e_shop/features/home/data/models/get_favorite_model.dart';

import '../../../data/models/favorites_mode.dart';

abstract class FavoritesStates{}
class FavoritesInitState extends FavoritesStates{}
class FavoritesLoadingState extends FavoritesStates{}
class FavoritesSuccessState extends FavoritesStates{
final FavoritesModel favoritesModel;

   FavoritesSuccessState(this.favoritesModel);
}
class FavoritesErrorState extends FavoritesStates{
  final String errMessage;

   FavoritesErrorState(this.errMessage);
}


class GetFavoritesLoadingState extends FavoritesStates{}
class GetFavoritesSuccessState extends FavoritesStates{
final List<GetFavoriteModel> getFavoriteModel;

   GetFavoritesSuccessState(this.getFavoriteModel);
}
class GetFavoritesErrorState extends FavoritesStates{
  final String errMessage;

   GetFavoritesErrorState(this.errMessage);
}


class RemoveFavoritesLoadingState extends FavoritesStates{}
class RemoveFavoritesSuccessState extends FavoritesStates{
final GetFavoriteModel model;

   RemoveFavoritesSuccessState(this.model);
}
class RemoveFavoritesErrorState extends FavoritesStates{
  final String errMessage;

   RemoveFavoritesErrorState(this.errMessage);
}

class GetFavoritesSeccState extends FavoritesStates{}
