import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';

import 'package:e_shop/core/utils/service_locator.dart';
import 'package:e_shop/core/widgets/custom_bottom.dart';
import 'package:e_shop/core/widgets/custom_empty_widget.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_status.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/payment/presentation/view_model/payment_cubit/payment_states.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

import '../../../../payment/presentation/view_model/payment_cubit/payment_cubit.dart';
import '../../../data/models/cart_model.dart';
import 'cart_item.dart';
import 'custom_bar.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartCubit(getIt.get<HomeRepoImplement>())..fetchCartItems(),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CartSuccessState) {
            print('object=${state.cart}');
            CartModel cartModel=state.cart;
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                       CustomBar(
                        text: "My Cart".tr(context),
                        onPressedSearch: (){
                          GoRouter.of(context).push(AppRouter.search);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      state.cart.data!.cartItems!.isNotEmpty? Expanded(
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
                                    child: CartItem(
                                        cartModel: state.cart, index: index),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                              indent: 50,
                              endIndent: 50,
                              thickness: 1.8,
                            ),
                            itemCount: state.cart.data!.cartItems!.length,
                          ),
                        ),
                      ): Center(
                    child: SizedBox(
                      height: h10*40,
                      child: CustomEmptyWidget(image: "assets/images/s1.png", title: "Cart is Empty".tr(context), body: "You Can Add Items in this cart".tr(context))),
                  ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: BlocProvider(
                create: (context) => PaymentCubit(getIt.get<HomeRepoImplement>())..getPaymenttAuthToken(),
                child: BlocBuilder<PaymentCubit,PaymentStates>(
                  builder: (context, state) {
                    return Container(
                  margin: EdgeInsets.only(bottom: h10 * 6.5, right: language=="en"?0: 30, left:language=="en"? 30:0),
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             MiddleText(
                              text: "Total Price".tr(context),
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            MiddleText(
                              text: "${cartModel.data!.total} \$",
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomButton(
                            title: "Checkout".tr(context),
                            borderRadius: 20,
                            onTap: () {
                              GoRouter.of(context).push(AppRouter.checkout ,extra: cartModel);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                  },
                ),
              ),
            );
          } else if (state is CartErrorState) {
            return Scaffold(body: CustomErrorWidget(errorText: state.errMessage));
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
