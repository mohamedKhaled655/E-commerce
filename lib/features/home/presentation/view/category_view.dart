import 'package:dio/dio.dart';
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/core/widgets/main_app_bar.dart';
import 'package:e_shop/features/home/data/models/category_model.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view/widgets/product_item.dart';
import 'package:e_shop/features/home/presentation/view_model/category_cubit/category_details/category_detials_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../view_model/category_cubit/category_details/category_details_cubit.dart';
import '../view_model/favorites_cubit/favourites_cubit.dart';

class CategoriesView extends StatelessWidget {
  final CategoriesModel categoriesModel;
  const CategoriesView({Key? key, required this.categoriesModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            CategoriesDetailsCubit(HomeRepoImplement(ApiServices(Dio())))
              ..fetchCategoryDetails(categoriesModel.id!),
        child: SafeArea(
          child: BlocBuilder<CategoriesDetailsCubit, CategoriesDetailsStates>(
            builder: (context, state) {
              if (state is CategoriesDetailsSuccessState) {
                return Column(
                  children: [
                    MainAppBar(
                      title: categoriesModel.name!,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: h10*120,
                        child: GridView.builder(
                          itemCount: state.categoriesDetailsModel.length,
                          padding:const EdgeInsets.symmetric(horizontal: 20),
                          //shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.4 / 4,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: ProductItem(
                                productModel: state.categoriesDetailsModel[index],
                              ),
                              onTap: () {
                                GoRouter.of(context).push(
                                    AppRouter.productDetails,
                                    extra: state.categoriesDetailsModel[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    
                  ],
                );
              } else if (state is CategoriesDetailsErrorState) {
                return CustomErrorWidget(errorText: state.errMessage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
