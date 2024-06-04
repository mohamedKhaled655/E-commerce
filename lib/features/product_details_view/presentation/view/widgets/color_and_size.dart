import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';

class ColorsAndSize extends StatelessWidget {
  const ColorsAndSize({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 MiddleText(text: "Size".tr(context)),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    ...List.generate(4,(index) {
                  return  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child:  CircleAvatar(
                      radius: 22,
                      backgroundColor: kPrimaryColor,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: MiddleText(text:index==0? "S":index==1?"L":index==2?"XL":"XXL"),
                      ),
                    ),
                  );
                }),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 20,),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 MiddleText(text: "Color".tr(context)),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    ...List.generate(6,(index) {
                  return  Padding(
                    padding:const  EdgeInsets.only(right: 5),
                    child:  CircleAvatar(
                      radius: 22,
                      backgroundColor: kPrimaryColor,
                      child: CircleAvatar(
                        backgroundColor: index==0?kPrimaryColor:index==1?Colors.red:index==2? Colors.blueGrey:index==3?Colors.amber:index==4?Colors.blue: Colors.white,
                        radius: 20,
                        
                      ),
                    ),
                  );
                }),
                  ],
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }
}