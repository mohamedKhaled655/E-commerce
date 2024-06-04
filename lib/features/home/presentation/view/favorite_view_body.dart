import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/utils/service_locator.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/core/widgets/large_text.dart';
import 'package:e_shop/core/widgets/main_app_bar.dart';
import 'package:e_shop/features/home/data/models/get_favorite_model.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view/widgets/discount_widget.dart';
import 'package:e_shop/features/home/presentation/view/widgets/fav_bottom.dart';
import 'package:e_shop/features/home/presentation/view_model/favorites_cubit/favorites_states.dart';
import 'package:e_shop/features/home/presentation/view_model/favorites_cubit/favourites_cubit.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_empty_widget.dart';
import 'widgets/image_widget.dart';

class FavoriteViewBody extends StatelessWidget {
  final bool isArrowBack;
  const FavoriteViewBody({
    Key? key,
    required this.isArrowBack,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            FavoritesCubit(getIt.get<HomeRepoImplement>())
              ..getFavorites(),
        child: BlocConsumer<FavoritesCubit, FavoritesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetFavoritesSuccessState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      MainAppBar(
                        title: "Favorites".tr(context),
                        isArrowBack: isArrowBack,
                        isLeading: true,
                        icon: Icon(IconBroken.Search,size: 30,color: Theme.of(context).primaryColor,),
                        onPressedLeading: (){
                          GoRouter.of(context).push(AppRouter.search);
                        },
                        onPressed: () {
                         // GoRouter.of(context).pop();
                           GoRouter.of(context).go(AppRouter.home);
                         // GoRouter.of(context).push(AppRouter.home);
                        },
                      ),
                    state.getFavoriteModel.isNotEmpty?  Expanded(
                        child: AnimationLimiter(
                          child: ListView.separated(
                            physics:const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: const Duration(milliseconds: 100),
                                  child: SlideAnimation(
                                    duration:const Duration(milliseconds: 2500) ,
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    verticalOffset: -250,
                                    child: ScaleAnimation(
                                      duration:const Duration(milliseconds: 1500)  ,
                                       curve: Curves.fastLinearToSlowEaseIn,
                                      child: FavoriteItem(
                                        getFavoriteModel:
                                            state.getFavoriteModel[index],
                                        onPressedFav: () {
                                          print(state.getFavoriteModel[index].id!);
                                                            
                                          FavoritesCubit.get(context).removeFavorites(
                                              id: state.getFavoriteModel[index].id!);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.getFavoriteModel.length),
                        ),
                      ):Center(
                    child: SizedBox(
                      height: h10*40,
                      child: CustomEmptyWidget(image: "assets/images/s1.png", title: "Favourit is Empty".tr(context), body: "You can add Items in favourit".tr(context))),
                  ),
                    ],
                  ),
                ),
              );
            }  else if (state is GetFavoritesErrorState) {
              return CustomErrorWidget(errorText: state.errMessage);
            } else {
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final GetFavoriteModel getFavoriteModel;
  final void Function()? onPressedFav;
  const FavoriteItem({
    Key? key,
    required this.getFavoriteModel,
    this.onPressedFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).bottomAppBarColor),
      child: Row(
        children: [
          ImageWidget(
            imageUrl: getFavoriteModel.product?.image ?? "",
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MiddleText(
                    text: getFavoriteModel.product?.name ?? "",
                    maxline: 3,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DiscountWidget(
                    discount: "${getFavoriteModel.product?.discount ?? ""}"),
                Padding(
                  padding: EdgeInsets.only(left: h10, right: h10, bottom: h5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LargeText(text: "${getFavoriteModel.product?.price} \$"),
                      FavButtom(
                        radius: 25,
                        iconColor: kbackground!,
                        backgroundColor: kPrimaryColor,
                        sizeIcon: 25,
                        onPressed: onPressedFav,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
