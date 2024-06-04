import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final ProductModel productModel;
  const DescriptionText({ Key? key,required this.productModel }) : super(key: key);

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
   bool isMax = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MiddleText(text: "Description".tr(context)),
                const SizedBox(
                  height: 10,
                ),
                isMax ?Text(
                  widget.productModel.description!,
                 // maxLines:  5,
                 // overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ):Text(
                  widget.productModel.description!,
                  maxLines:  3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
               isMax==false? TextButton(onPressed: (){
                  setState(() {
                   isMax=true ;
                  });
                }, child: Row(
                  children: [
                    Text("See All".tr(context),style:const TextStyle(color: kPrimaryColor,fontSize: 16,fontWeight: FontWeight.bold)),
                   const Icon(Icons.arrow_drop_down,color: kPrimaryColor,size: 30,)
                  ],
                ),)
                : TextButton(onPressed: (){
                  setState(() {
                   isMax=false ;
                  });
                }, child: Row(
                  children: [
                    Text("See Less".tr(context),style:const TextStyle(color: kPrimaryColor,fontSize: 16,fontWeight: FontWeight.bold),),
                    const Icon(Icons.arrow_drop_up,color: kPrimaryColor,size: 30,)
                  ],
                ),
                ),
              ],
            ),
          );
  }
}

