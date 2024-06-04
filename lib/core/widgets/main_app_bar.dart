import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/widgets/large_text.dart';
import 'package:flutter/material.dart';

import '../utils/icon_broken.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
    required this.title, this.isArrowBack=true, this.onPressed, this.isLeading=false, this.onPressedLeading, this.icon, this.prefixWidget=const SizedBox(),
  }) : super(key: key);
  final void Function()? onPressed;
  final String title;
  final bool isArrowBack;
  final bool isLeading;
  final void Function()? onPressedLeading;
  final Widget? icon;
  final Widget prefixWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20,),
      child: Row(
        children: [
        isArrowBack?  IconButton(
              onPressed:onPressed,
              icon: Icon(
               language=="en"? IconBroken.Arrow___Left_2:IconBroken.Arrow___Right_2,
                color: Theme.of(context).primaryColor,
                size: 30,
              )):prefixWidget,
          const SizedBox(
            width: 20,
          ),
          LargeText(text: title),
          const Spacer(),
          isLeading? IconButton(
            onPressed: onPressedLeading,
             icon: icon!,
          ):const SizedBox(),          
         
        ],
      ),
    );
  }
}

