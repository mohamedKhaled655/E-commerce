import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/onboarding/data/repo/cache_onbording.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPageBotton extends StatelessWidget {
  final bool isLast;
  final PageController pageController;
  const CustomPageBotton({
    Key? key,
    required this.pageController,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLast == true) {
          final cache = CacheOnbording();
          cache.cacheBoarding(true);
          GoRouter.of(context).push(AppRouter.login);
          /*Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false);*/
        } else {
          pageController.nextPage(
              duration: const Duration(milliseconds: 750),
              curve: Curves.fastLinearToSlowEaseIn);
        }
      },
      child: Container(
        height: 65,
        width: 300,
        margin: const EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(
              "Next".tr(context),
              style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
           const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
