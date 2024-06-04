import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/utils/service_locator.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/widgets/custom_bottom.dart';
import '../../../../../core/widgets/large_text.dart';
import '../../../../home/data/repo/home_repo_imp.dart';
import '../../../../home/presentation/view/widgets/image_widget.dart';
import '../../../../product_details_view/presentation/view/widgets/middle_text.dart';
import '../../../data/models/cart_model.dart';
import '../../view_model/cart_cubit/cart_cubit.dart';
import 'addandminus_widget.dart';

class RemoveItemfromCart extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  const RemoveItemfromCart({
    Key? key,
    required this.cartModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(getIt.get<HomeRepoImplement>())..fetchCartItems(),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if(state is RemoveCartSuccessState){
            print("removed");
            
          }
        
        },
        builder: (context, state) {
          
          return  Container(
            padding: const EdgeInsets.all(20),
            height: 300,
            child: Column(
              children: [
                LargeText(text: "Remove from Cart".tr(context)),
                SizedBox(
                  height: h10,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).bottomAppBarColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: ImageWidget(
                          imageUrl: cartModel
                                  .data?.cartItems?[index].product?.image ??
                              "",
                          height: 130,
                          width: 120,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: MiddleText(
                                    text: cartModel.data?.cartItems?[index]
                                            .product?.name ??
                                        "",
                                    fontSize: 18,
                                    maxline: 3,
                                    textOverflow: TextOverflow.ellipsis,
                                  )),
                              Row(
                                children: [
                                  MiddleText(
                                    text: cartModel.data?.cartItems?[index]
                                            .product?.price
                                            .toString() ??
                                        "",
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: AddAndMinusWidget(
                                       id: cartModel.data!.cartItems![index].id!,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: "Cancle",
                        onTap: () {
                      Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                        title: "Remove",
                        isLoading: State is RemoveCartLoadingState?true:false,
                        onTap: () {
                         CartCubit.get(context).removeItemFromCart(id: cartModel.data!.cartItems![index].id!);
                         
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
