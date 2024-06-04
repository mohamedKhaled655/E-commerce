import 'package:dio/dio.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';
import 'package:e_shop/features/home/presentation/view/widgets/discount_widget.dart';
import 'package:e_shop/features/home/presentation/view/widgets/favorit_widget.dart';
import 'package:e_shop/features/home/presentation/view/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../data/repo/home_repo_imp.dart';
import '../../view_model/favorites_cubit/favourites_cubit.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  const ProductItem({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .45,
      height: h10 * 30,
      decoration: BoxDecoration(
        // color: kbackground,
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              //image
              ImageWidget(imageUrl: productModel.image!,width: h10*20,height: h10*16,),
              //fav heart
              BlocProvider(
                create: (context) => FavoritesCubit(HomeRepoImplement(ApiServices(Dio()))),
                child: Container(
                  margin:const EdgeInsets.all(8),
                  child: FavoriteWidget(id: productModel.id!))),
            ],
          ),
          const Expanded(child: SizedBox(height: 10,)),
          //title
          SizedBox(
            height: h10 * 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(productModel.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(
            height: h10,
          ),
          DiscountWidget(discount: "${productModel.discount}"),
          SizedBox(
            height: h10,
          ),
          Padding(
            padding: EdgeInsets.only(left: h10, right: h10, bottom: h5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productModel.price} \$",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  "${productModel.oldPrice} \$",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

