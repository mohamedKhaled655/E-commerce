import 'package:dio/dio.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/core/widgets/cutom_arrow_back.dart';
import 'package:e_shop/features/auth/data/repo/auth_repo_imp.dart';
import 'package:e_shop/features/auth/presentation/view/widgets/signup_view_body.dart';
import 'package:e_shop/features/auth/presentation/view_model/sign_up_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading:const CutomArrowBack(),
      ),
      body:BlocProvider(
        create: (context) => SignUpCubit(AuthRepoImplementation(ApiServices(Dio()))),
        child: const SignUpViewBody()),
    );
  }
}