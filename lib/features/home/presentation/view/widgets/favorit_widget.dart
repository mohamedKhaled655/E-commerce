import 'package:dio/dio.dart';
import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/api_service.dart';
import '../../../data/repo/home_repo_imp.dart';
import '../../view_model/favorites_cubit/favorites_states.dart';
import '../../view_model/favorites_cubit/favourites_cubit.dart';
import 'fav_bottom.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    Key? key,
    required this.id, this.radius=18, this.iconSize=22, this.alignment=Alignment.topRight,
  }) : super(key: key);

  final int id;
  final double radius;
  final double iconSize;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesCubit(HomeRepoImplement(ApiServices(Dio()))),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {
          if (state is FavoritesSuccessState) {
            if(!state.favoritesModel.status!){
              print("eee="+state.favoritesModel.message!);
              ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                message: state.favoritesModel.message!,
                context: context,
                backgroundColor: Colors.red,
                ));
           
            }
          }
          else if(state is FavoritesErrorState){
            ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                message: state.errMessage,
                context: context,
                backgroundColor: Colors.red,
                ));
            
          }
        },
        builder: (context, state) {
         
          return Container(
           // margin: const EdgeInsets.all(8),
            child: Align(
                alignment: alignment,
                child: FavButtom(
                  radius:radius ,
                  sizeIcon: iconSize,
                  backgroundColor:
                    favorites[id]!
                          ? kPrimaryColor
                          : kbackground!,
                  iconColor: favorites[id]!
                      ? kbackground!
                      : kPrimaryColor,
                  onPressed: () {
                    print("${id}");
                    FavoritesCubit.get(context).changeFavorites(
                        id:id, context: context);
                    //BlocProvider.of<FavoritesCubit>(context).changeFavorites(id: productModel.id!);
                  },
                )),
          );
        },
      ),
    );
  }
}
