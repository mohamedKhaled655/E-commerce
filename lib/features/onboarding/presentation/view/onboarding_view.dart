import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/app_theme/theme_cubit/theme_cubit.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/auth/presentation/view/login_page.dart';
import 'package:e_shop/features/onboarding/data/repo/cache_onbording.dart';
import 'package:e_shop/features/onboarding/data/repo/onboarding_data.dart';
import 'package:e_shop/features/onboarding/presentation/view/widgets/custom_page_bottom.dart';
import 'package:e_shop/features/onboarding/presentation/view/widgets/custom_smooth_indicator.dart';
import 'package:e_shop/features/onboarding/presentation/view/widgets/page_view_body.dart';
import 'package:e_shop/features/setting.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController pageController = PageController();
  bool isLast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  cacheBoarding(true);
  }

 /* Future<void> cacheBoarding(bool onBording) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("onBording", onBording);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //skip
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
         
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final cache=CacheOnbording();
                    cache.cacheBoarding(true);
                    
                    GoRouter.of(context).push(AppRouter.login);
                    /*Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false);*/
                  },
                  child:  Text(
                    "Skip".tr(context),
                    style:const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  style: TextButton.styleFrom(),
                ),
              ],
            ),
            //page view body
            Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onbordingList.length,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    print("$index");
                    if (index == onbordingList.length - 1) {
                      print("last");
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) {
                    return PageViewBody(index: index);
                  },
                )),
            //indecitor
            CustomSmoothIndicator(pageController: pageController,count: onbordingList.length,),
            const SizedBox(
              height: 25,
            ),
            //bottom
            CustomPageBotton(pageController: pageController, isLast: isLast),
           const SizedBox(
             height: 30,
           ),
          ],
        ),
      ),
    );
  }
}


