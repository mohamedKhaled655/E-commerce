import 'package:e_shop/features/cart/data/models/cart_model.dart';
import 'package:e_shop/features/home/presentation/view/widgets/image_widget.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';


class OrderItem extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  const OrderItem({
    Key? key,
    required this.cartModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ImageWidget(
              imageUrl: cartModel.data?.cartItems?[index].product?.image ?? "",
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
                        text: cartModel.data?.cartItems?[index].product?.name ??
                            "",
                        fontSize: 18,
                        maxline: 3,
                        textOverflow: TextOverflow.ellipsis,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).textTheme.headlineLarge!.color,
                        child: MiddleText(text: "${cartModel.data!.cartItems![index].quantity}"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
