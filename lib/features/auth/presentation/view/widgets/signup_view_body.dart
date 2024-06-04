import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_bottom.dart';
import 'package:e_shop/core/widgets/custom_text_feild.dart';
import 'package:e_shop/features/auth/presentation/view_model/sign_up_cubit/signup_cubit.dart';
import 'package:e_shop/features/auth/presentation/view_model/sign_up_cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({Key? key}) : super(key: key);

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password, name, phone, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),

            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: h10 * 2,
              ),
              CustomTextFeild(
                hint: "Name".tr(context),
                prefixIcon: Icons.person_outline_outlined,
                onSave: (value) {
                  name = value;
                },
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
                hint: "Phone".tr(context),
                prefixIcon: Icons.phone_paused_outlined,
                onSave: (value) {
                  phone = value;
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
              BlocConsumer<SignUpCubit, SignUpStates>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    if (state.signUpModel.status == true) {
                      ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                          backgroundColor: kPrimaryColor,
                          context: context,
                          message: state.signUpModel.message ?? "",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)));

                          GoRouter.of(context).push(AppRouter.home);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                          backgroundColor: Colors.red,
                          context: context,
                          message: state.signUpModel.message ?? "",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)));
                    }
                  }else if(state is SignUpErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                          backgroundColor: Colors.red,
                          context: context,
                          message: state.errMessage,
                          style: Theme.of(context).textTheme.bodyLarge));
                  }
                },
                builder: (context, state) {
                  var cubit = SignUpCubit.get(context);
                  return CustomButton(
                    isLoading: state is SignUpLoadingState ? true : false,
                    title: "confirm".tr(context),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        cubit.signUp(
                            email: email!,
                            password: password!,
                            name: name!,
                            phone: phone!,
                            image:
                                "https://cdn-icons-png.flaticon.com/512/138/138661.png?w=740&t=st=1677761910~exp=1677762510~hmac=11e080286e7d623e5ae55c5dc74aeecb63f4918e9e615949a4163576b4461dca",
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
            ],
          ),
        ),
      ),
    );
  }
}
