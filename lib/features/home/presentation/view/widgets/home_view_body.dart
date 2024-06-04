import 'package:dio/dio.dart';
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/utils/service_locator.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_search_bar.dart';
import 'package:e_shop/features/home/presentation/view/widgets/listCategoryItems.dart';
import 'package:e_shop/features/home/presentation/view/widgets/product_view_body.dart';
import 'package:e_shop/features/home/presentation/view/widgets/rowTitle.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:e_shop/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:e_shop/features/home/presentation/view_model/profile_cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'customCarousel.dart';
import 'custom_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              BlocConsumer<ProfileCubit,SettingStates>(
                listener: (context, state) {
                  if(state is SettingSuccessState){
                    name=state.profileModel.data!.name!;
                    phone=state.profileModel.data!.phone!;
                    email=state.profileModel.data!.email!;
                  }
                },
                builder: (context, state) {
                  return CustomAppBar(
                name: state is SettingSuccessState?state.profileModel.data!.name!:"Mohamed khaled",
                image: state is SettingSuccessState?state.profileModel.data!.image??profileImage:profileImage,
                onPressedFav: () {
                  GoRouter.of(context).push(AppRouter.favorite);
                },
                onPressedImage: () {},
                onPressedNot: () {},
              );
                },
              ),
              SizedBox(
                height: h10 * 2,
              ),
              CustomSearchBar(
                onSaved: (value) {},
                onChanged: (value) {},
                onPressedPrefix: () {},
                onPressedsuffix: () {},
              ),
              SizedBox(
                height: h10 * 2,
              ),
              //Special Offers
              RowTitle(
                title: "Special Offers".tr(context),
                seeMorOnTap: () {},
              ),
              SizedBox(
                height: h10 * 2,
              ),
              const CustomCarousel(),
              SizedBox(
                height: h10 * 3,
              ),
              const ListCategoryItems(
                //محتاج ليست من الاسماء خلي بالك
               // titleModel: "electrionic devices",
              ),
              SizedBox(
                height: h10 * 2,
              ),
              RowTitle(
                title: "Must Popular".tr(context),
                seeMorOnTap: () {},
              ),
              SizedBox(
                height: h10 * 2,
              ),
             BlocProvider(
              create: (context) => ProductCubit(getIt.get<HomeRepoImplement>())..fetchProductData(lang: "ar"),
              child: const ProductViewBody()),
            ],
          ),
        ),
      ),
    );
  }
}

