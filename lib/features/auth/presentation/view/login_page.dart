import 'package:dio/dio.dart';
import 'package:e_shop/core/utils/app_theme/theme_cubit/theme_cubit.dart';
import 'package:e_shop/features/auth/presentation/view/widgets/login_view_body.dart';
import 'package:e_shop/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:e_shop/features/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/api_service.dart';
import '../../data/repo/auth_repo_imp.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
     /* appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ThemeCubit.get(context).changeTheme();
              },
              icon:  Icon(Icons.brightness_4_outlined,color: Theme.of(context).primaryColor,)),
              IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SettingsPage())),
              icon:  Icon(Icons.settings,color: Theme.of(context).primaryColor,))
        ],
      ),*/
      body:BlocProvider(
        create: (context) => LoginCubit(AuthRepoImplementation(ApiServices(Dio()))),
        child: const LoginViewBody()),
    );
  }
}