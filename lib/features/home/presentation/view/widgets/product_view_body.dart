import 'package:dio/dio.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view/widgets/product_item.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/shimmer_screen/gridview_shimmer.dart';

class ProductViewBody extends StatelessWidget {
  const ProductViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit,ProductStates>(
      builder: (context, state) {
        if(state is ProductErrorState){
          return CustomErrorWidget(errorText: state.errMessage);
        }else if(state is ProductSuccessState){
          return SizedBox(
      height: 400,
      child: GridView.builder(
        itemCount: state.productModel.length,
        //shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 2.35/4,
        ),
        itemBuilder: (context, index) {
          return  GestureDetector(
            child: ProductItem(productModel: state.productModel[index],),
            onTap: (){
              GoRouter.of(context).push(AppRouter.productDetails,extra:state.productModel[index]  );
            },
            );
        },
      ),
    );
        }else{
          return const GridViewShimmer();
        }
      },
    );
  }
}
