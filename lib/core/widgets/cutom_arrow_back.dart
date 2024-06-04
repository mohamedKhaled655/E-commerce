import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CutomArrowBack extends StatelessWidget {
  const CutomArrowBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          GoRouter.of(context).pop();
        },
        child: Container(
        height: h10*6,
        width: h10*5.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(h10*1.5)),
          color: Theme.of(context).iconTheme.color,
        // border: Border.all(color:Colors.white30 ),
        ),
        child:const Icon(IconBroken.Arrow___Left_2,color: Colors.black,size: 35,),
               ),
      );
  }
}