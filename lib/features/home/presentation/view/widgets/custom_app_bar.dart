import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_image.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  final String ?image;
  final void Function()? onPressedImage;
  final void Function()? onPressedFav;
  final void Function()? onPressedNot;
  const CustomAppBar({
    Key? key,required this.name, this.image, this.onPressedImage, this.onPressedFav, this.onPressedNot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         CustomImage(image:image,onTap: onPressedImage),
        Padding(
          padding:  EdgeInsets.only(left: h10,right: h10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiddleText(text: "Good Morning".tr(context),fontSize: 16,color: Colors.grey,),
              MiddleText(text: name,fontSize: 18,),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(onPressed: onPressedNot, icon:const Icon(IconBroken.Notification,color: Colors.grey,size: 30,),),
            IconButton(onPressed: onPressedFav, icon: const Icon(IconBroken.Heart,color: Colors.grey,size: 30,),),
          ],
        ),
      ],
    );
  }
}