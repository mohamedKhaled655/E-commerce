import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/icon_broken.dart';
import '../../../../product_details_view/presentation/view/widgets/middle_text.dart';

class ChooseShipping extends StatelessWidget {
  const ChooseShipping({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           MiddleText(
            text: "Choose Shipping".tr(context),
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).bottomAppBarColor,
            ),
            child: Center(
              child: ListTile(
                title:  MiddleText(
                  text: "Choose Shipping Type".tr(context),
                ),
                leading: FaIcon(
                  FontAwesomeIcons.truck,
                  color: Theme.of(context).primaryColor,
                ),
                trailing: Icon(
                  language=="en"? IconBroken.Arrow___Right_2:IconBroken.Arrow___Left_2,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
