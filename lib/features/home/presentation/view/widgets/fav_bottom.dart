import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:flutter/material.dart';

class FavButtom extends StatelessWidget {
  final double radius;
  final double sizeIcon;
  final Color backgroundColor;
  final Color iconColor;
  final void Function()? onPressed;
  const FavButtom({
    Key? key, this.radius=18,required this.backgroundColor,required this.iconColor, this.sizeIcon=22, this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor:backgroundColor, //if fav->kprimarycolor else kbackground
      child: IconButton(
        alignment: Alignment.center,
        icon:  Icon(
          IconBroken.Heart,
          color:iconColor,
          size: sizeIcon,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
