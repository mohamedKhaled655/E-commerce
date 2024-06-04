import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';
import 'package:e_shop/features/home/presentation/view/widgets/discount_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    Key? key,required this.productModel,

  }) : super(key: key);
    final ProductModel productModel;

  
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DiscountWidget(discount: "${productModel.discount}"),
          FaIcon(FontAwesomeIcons.solidStarHalfStroke,size: 30,color: Theme.of(context).backgroundColor),
          Padding(
            padding: EdgeInsets.only(left: h10, right: h10, bottom: h5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productModel.price} \$",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  "${productModel.oldPrice} \$",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
