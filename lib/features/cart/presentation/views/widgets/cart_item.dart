import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:e_shop/features/cart/data/models/cart_model.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:e_shop/features/home/presentation/view/widgets/image_widget.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';

import 'addandminus_widget.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  const CartItem({
    Key? key,
    required this.cartModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).bottomAppBarColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //image
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ImageWidget(
              imageUrl: cartModel.data?.cartItems?[index].product?.image ?? "",
              height: 150,
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
                        text: cartModel.data?.cartItems?[index].product?.name ??
                            "",
                        fontSize: 18,
                        maxline: 3,
                        textOverflow: TextOverflow.ellipsis,
                      )),
                  Row(
                    children: [
                      MiddleText(
                        text: cartModel.data?.cartItems?[index].product?.price
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
                            id:cartModel.data!.cartItems![index].id!
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
             /* showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  builder: (context) {
                    return RemoveItemfromCart(
                      cartModel: cartModel,
                      index: index,
                    );
                  });*/
                 
               CartCubit.get(context).removeItemFromCart(id: cartModel.data!.cartItems![index].id!);
            },
            padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
            icon: Icon(
              IconBroken.Delete,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
