import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/shimmer_screen/list_items_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../../../home/data/repo/home_repo_imp.dart';
import '../../view_model/cart_cubit/cart_cubit.dart';
import '../../view_model/cart_cubit/cart_status.dart';
import 'orderItem.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
         create: (context) =>
          CartCubit(getIt.get<HomeRepoImplement>())..fetchCartItems(),
      child: BlocBuilder<CartCubit,CartStates>(
        builder: (context, state) {
          if(state is CartSuccessState){
            return SizedBox(
        height: 300,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return OrderItem(cartModel: state.cart, index: index);
          },
          separatorBuilder: (context, index) => const Divider(
            indent: 50,
            endIndent: 50,
            thickness: 1.8,
          ),
          itemCount:state.cart.data!.cartItems!.length,
        ),
      );
          }else if(state is CartErrorState){
            return CustomErrorWidget(errorText: state.errMessage);
          }else{
            return const ItemsListShimmer();
          }
        },
      ),
    );
  }
}