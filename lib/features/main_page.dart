import 'package:dio/dio.dart';
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/features/auth/presentation/view/login_page.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view/home_view.dart';
import 'package:e_shop/features/home/presentation/view_model/banners_cubit/banners_cubit.dart';

import 'package:e_shop/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/service_locator.dart';
import '../core/widgets/custom_loading_widget.dart';
import 'home/presentation/view_model/profile_cubit/profile_cubit.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool? cacheOnBording;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cache();
    getToken();
  }

  void cache() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    cacheOnBording = sharedPreferences.getBool("onBording") ?? false;
    setState(() {});
    print("onBording=$cacheOnBording");
  }
  void getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token")??"" ;
  }

  @override
  Widget build(BuildContext context) {
    getHeight = MediaQuery.of(context).size.height;
    print("getHeight=$getHeight");
    if (cacheOnBording != null) {
      if (cacheOnBording == true) {
        if(token.isNotEmpty){
          print(token);
          return BlocProvider(
            create: (context) => ProfileCubit(getIt.get<HomeRepoImplement>())..fetchProfileData(),
            child: const HomeView());
        }else{
          print("token=$token");
          return  const LoginPage();
        }
        
      } else {
        return const OnBoardingView();
      }
    } else {
      return const Scaffold(
        body: CustomLoadingWidget(),
      );
    }
  }
}
