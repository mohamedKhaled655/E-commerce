import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/icon_broken.dart';

class CustomBottomTwo extends StatelessWidget {
  final String title;
  final double borderRadius;
  final void Function()? onTap;
  final bool isLoading;
  final IconData icon;
  const CustomBottomTwo({
    Key? key,required this.title, this.borderRadius=20, this.onTap,required this.icon, this.isLoading=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: kPrimaryColor,
        ),
        child:isLoading?const Center(child:  CircularProgressIndicator(color: Colors.white,)): Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Icon(IconBroken.Bag,size: 30,color: Colors.white,),
           const SizedBox(width: 5,),
           Text(title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 22),),
          
          ],
        ),
      ),
    );
  }
}