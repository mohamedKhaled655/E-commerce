import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/icon_broken.dart';
import '../../../../core/widgets/main_app_bar.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MainAppBar(
                  title: "Payment Methodes",
                  isLeading: true,
                  icon: Icon(
                    IconBroken.More_Circle,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () {
                    print("arrow back");
                    GoRouter.of(context).pop();
                  },
                  isArrowBack: true,
                  onPressedLeading: () {},
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).bottomAppBarColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(FontAwesomeIcons.ccVisa,color: Theme.of(context).primaryColor,size: 50,),
                      
                      MiddleText(text: "Visa Card".tr(context),fontSize: 25,color: Theme.of(context).primaryColor,),
                      IconButton(
                        icon: Icon(IconBroken.Arrow___Right_2,size: 30,color: Theme.of(context).primaryColor,),
                        onPressed: (){
                           GoRouter.of(context).push(AppRouter.visa);
                        },
                      )
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).bottomAppBarColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(FontAwesomeIcons.creditCard,color: Theme.of(context).primaryColor,size: 50,),
                      
                      MiddleText(text: "Ref code".tr(context),fontSize: 25,color: Theme.of(context).primaryColor,),
                      IconButton(
                        icon: Icon(IconBroken.Arrow___Right_2,size: 30,color: Theme.of(context).primaryColor,),
                        onPressed: (){
                          GoRouter.of(context).push(AppRouter.refCode);
                        },
                      )
                    ],
                  ),
                ),
          ],
        ),
      )),
    );
  }
}
