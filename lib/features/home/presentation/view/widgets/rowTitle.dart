import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:flutter/material.dart';

class RowTitle extends StatelessWidget {
  final String title;
  final void Function()? seeMorOnTap;
  const RowTitle({
    Key? key,required this.title, this.seeMorOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
            onTap: seeMorOnTap,
            child: Text(
              "See All".tr(context),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w500),
            )),
      ],
    );
  }
}