import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String image;
  final String title;
  final String body;

  const CustomEmptyWidget({ Key? key,required this.image,required this.title,required this.body }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 0),
      child: Column(
        children: [
          Expanded(child: Image.asset(image,)),
          const SizedBox(height: 20,),
           MiddleText(text: title,fontSize: 24,),
          const SizedBox(height: 20,),
           MiddleText(text: body,fontSize: 20,),
        ],
      ),
    );
  }
}