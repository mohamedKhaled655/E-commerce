
import 'package:e_shop/core/utils/app_theme/theme_cubit/theme_cubit.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:e_shop/features/home/presentation/view/favorit_view.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_nav/animated_bar.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_nav/constanss.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_nav/rive_assets.dart';
import 'package:e_shop/features/home/presentation/view/widgets/custom_nav/rive_utils.dart';
import 'package:e_shop/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:e_shop/features/notification/presentation/view/notiication_view.dart';
import 'package:e_shop/features/search/presentation/view/search_view.dart';
import 'package:e_shop/features/setting.dart';
import 'package:e_shop/features/setting_view/presentation/view/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../cart/presentation/views/cart_view.dart';
import '../../data/repo/home_repo_imp.dart';

List<Widget> screens =  const[
    HomeViewBody(),
    CartView(),
    //Center(child: Text("screen 22",style: TextStyle(color: Colors.black),)),
    SearchView(),
    FavoriteView(),
    NotificationView(),
    SettingView(),
  ];
class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

///for bottom Nav bar
  RiveAsset selectedBottomNav = bottomNavs.first;

  int selectedIdex = 0;

  
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:const Color(0xff17203A),
    // backgroundColor: Colors.white,

      resizeToAvoidBottomInset:false,
      extendBody: true,
      body: screens[selectedIdex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor2.withOpacity(.8),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(bottomNavs.length, (index) {
              return GestureDetector(
                onTap: () {
                  bottomNavs[index].input!.change(true);
                  if (bottomNavs[index] != selectedBottomNav) {
                    setState(() {
                      selectedBottomNav = bottomNavs[index];
                      selectedIdex = index;
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNavs[index].input!.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(
                        isActive: bottomNavs[index] == selectedBottomNav
                            ? true
                            : false),
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              bottomNavs[index] == selectedBottomNav ? 1 : .5,
                          child: RiveAnimation.asset(
                            bottomNavs[index].src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName);
                              bottomNavs[index].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ))
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}