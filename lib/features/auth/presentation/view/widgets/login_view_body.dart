import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_bottom.dart';
import 'package:e_shop/core/widgets/custom_text_feild.dart';
import 'package:e_shop/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:e_shop/features/auth/presentation/view_model/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: h10 * 2,
              ),
              CustomTextFeild(
                hint: "Email".tr(context),
                prefixIcon: Icons.email_outlined,
                onSave: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: h10 * 2,
              ),
              CustomTextFeild(
                hint: "Password".tr(context),
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: true,
                onSave: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: h10 * 2.5,
              ),
              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    if (state.loginModel.status == true) {
                        name=state.loginModel.data!.name??"";
                        phone=state.loginModel.data!.phone??"";
                        profileImage=state.loginModel.data!.image??"";
                      if (token !=null) {
                        print("token=$token");
                        print(state.loginModel.data!.token??"");
                        
                        ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                            backgroundColor: kPrimaryColor,
                            context: context,
                            message: state.loginModel.message ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16)));

                        GoRouter.of(context).go(AppRouter.home);
                      }
                      else{
                        print("token=$token");
                        GoRouter.of(context).go(AppRouter.login);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                          backgroundColor:
                              const Color.fromARGB(255, 197, 45, 45),
                          context: context,
                          message: state.loginModel.message ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16)));
                    }
                  } else if (state is LoginErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                        backgroundColor: Colors.red,
                        context: context,
                        message: state.errMessage,
                        style: Theme.of(context).textTheme.bodyLarge));
                  }
                },
                builder: (context, state) {
                  var cubit = LoginCubit.get(context);

                  return CustomButton(
                    isLoading: state is LoginLoadingState ? true : false,
                    title: "Login".tr(context),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        cubit.login(
                            email: email!,
                            password: password!,
                            context: context);
                      } else {
                        autovalidateMode = AutovalidateMode.onUserInteraction;
                        setState(() {});
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: h10 * 2.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet ?".tr(context),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.signUp);
                      },
                      child: Text(
                        "Sign Up".tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
