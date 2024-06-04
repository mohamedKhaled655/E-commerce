import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant.dart';

class DiscountWidget extends StatelessWidget {
  final String discount;
  const DiscountWidget({
    Key? key,required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h10 * 3,
      width: h10 * 10.5,
      margin: const EdgeInsets.symmetric(
          horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).textTheme.headlineLarge!.color),
      child: Center(
        child: Text(
          "discount :".tr(context) +
              "$discount %",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
