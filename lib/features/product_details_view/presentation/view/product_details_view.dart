import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/cart/presentation/view_model/add_to_cart/add_cart_cubit.dart';
import 'package:e_shop/features/cart/presentation/view_model/add_to_cart/add_cart_status.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';
import 'package:e_shop/features/home/presentation/view/widgets/favorit_widget.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/color_and_size.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/custombottom2.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/description_text.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/image_details_product.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/price_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../home/data/repo/home_repo_imp.dart';


class ProductDetailsView extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsView({Key? key, required this.productModel})
      : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ImageDetalisProduct(
              pageController: pageController,
              productModel: widget.productModel),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(widget.productModel.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 22)),
          ),
          PriceRow(productModel: widget.productModel),
          const Divider(endIndent: 50, indent: 50, thickness: 2),
          DescriptionText(
            productModel: widget.productModel,
          ),
          const ColorsAndSize(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: FavoriteWidget(
                  iconSize: 30,
                  radius: 30,
                  alignment: Alignment.center,
                  id:widget.productModel.id! ,
                )),
            BlocProvider(
              create: (context) => AddCartCubit(getIt.get<HomeRepoImplement>()),
              child: BlocConsumer<AddCartCubit,AddToCartStates>(
                listener: (context, state) {
                  if(state is AddToCartSuccessState){
                    ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                          backgroundColor:
                               Colors.green,
                          context: context,
                          message: state.addCartModel.message ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16)));
                  }else if(state is AddToCartErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                          backgroundColor:
                               Colors.red,
                          context: context,
                          message: state.errMessage ,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16)));
                  }
                },
                builder: (context,state){
                  return Expanded(
                  flex: 4,
                  child: CustomBottomTwo(
                    isLoading: state is AddToCartLoadingState? true : false,
                    icon: IconBroken.Bag,
                    title:AddCartCubit.get(context).isChange? "Remove from Cart".tr(context):"Add To Cart".tr(context),
                    borderRadius: 20,
                    onTap: () {
                        AddCartCubit.get(context).addToCartItems(id: widget.productModel.id!,);
                    },
                  ),
                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
