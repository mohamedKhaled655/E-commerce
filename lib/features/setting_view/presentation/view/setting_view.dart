import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_bottom.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/core/widgets/large_text.dart';
import 'package:e_shop/features/home/presentation/view_model/profile_cubit/profile_states.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_theme/theme_cubit/theme_cubit.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../../core/utils/languages/cubit/language_cubit.dart';
import '../../../../core/utils/languages/cubit/language_states.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/main_app_bar.dart';
import '../../../home/data/repo/home_repo_imp.dart';
import '../../../home/presentation/view_model/profile_cubit/profile_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainAppBar(
                title: "Profile".tr(context),
                isLeading: true,
                icon: Icon(
                  IconBroken.More_Circle,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                prefixWidget: FaIcon(
                  FontAwesomeIcons.joomla,
                  color: Theme.of(context).backgroundColor,
                  size: 35,
                ),
                isArrowBack: false,
                onPressedLeading: () {},
              ),
              Expanded(
                child: ListView(
                  children: [
                    BlocProvider(
                       create: (context) => ProfileCubit(getIt.get<HomeRepoImplement>())..fetchProfileData(),
                      child: BlocBuilder<ProfileCubit,SettingStates>(
                        builder: (context, state) {
                          return state is SettingErrorState?Center(child: CustomErrorWidget(errorText: state.errMessage)): Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             CircleAvatar(
                              radius: 75,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(75),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                    state is SettingSuccessState?  state.profileModel.data!.image??"":"https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?w=996&t=st=1679187400~exp=1679188000~hmac=24958191102813240a24d739aa3b649b53902894aef815ed2e5ad386b99988c4",
                                    
                                  ),
                                  fit: BoxFit.cover
                                  )
                                ),
                                
                              ),
                            ),
                            MiddleText(text: state is SettingSuccessState?  state.profileModel.data!.name!:"Moahmed khaled",fontSize: 22,),
                            MiddleText(text: state is SettingSuccessState?  state.profileModel.data!.phone!:"01017485777",fontSize: 22,color: Colors.grey,),
                          ],
                        ),
                      );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    ProfileItem(
                      title: "Edit Profile".tr(context),
                      prefix: IconBroken.Profile,
                      suffix: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            language == "en"
                                ? IconBroken.Arrow___Right_2
                                : IconBroken.Arrow___Left_2,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )),
                    ),
                    ProfileItem(
                      title: "Address".tr(context),
                      prefix: IconBroken.Location,
                      suffix: IconButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.address);
                          },
                          icon: Icon(
                            language == "en"
                                ? IconBroken.Arrow___Right_2
                                : IconBroken.Arrow___Left_2,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )),
                    ),
                    ProfileItem(
                      title: "Notification".tr(context),
                      prefix: IconBroken.Notification,
                      suffix: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            language == "en"
                                ? IconBroken.Arrow___Right_2
                                : IconBroken.Arrow___Left_2,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )),
                    ),
                    ProfileItem(
                      title: "Payment".tr(context),
                      prefix: IconBroken.Wallet,
                      suffix: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            language == "en"
                                ? IconBroken.Arrow___Right_2
                                : IconBroken.Arrow___Left_2,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )),
                    ),
                    ProfileItem(
                      title: "Languages".tr(context),
                      prefix: IconBroken.Paper,
                      suffix: BlocConsumer<LanguagesCubit, LanguagesStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is ChangeLanguageLocalstates) {
                            return Switch(
                              value: state.locale.languageCode == "en"
                                  ? true
                                  : false,
                              onChanged: (value) {
                                context
                                    .read<LanguagesCubit>()
                                    .changeLanguage(value ? "en" : "ar");
                              },
                              activeColor: kPrimaryColor,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey[300],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    ProfileItem(
                      title: "Dark Mode".tr(context),
                      prefix: IconBroken.Show,
                      suffix: Switch(
                        value: ThemeCubit.get(context).isDark,
                        onChanged: (value) {
                          ThemeCubit.get(context).changeTheme();
                        },
                        activeColor: kPrimaryColor,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ),
                    ProfileItem(
                      title: "Privacy Policy".tr(context),
                      prefix: IconBroken.Info_Square,
                      suffix: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            language == "en"
                                ? IconBroken.Arrow___Right_2
                                : IconBroken.Arrow___Left_2,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )),
                    ),
                    ProfileItem(
                      title: "Logout".tr(context),
                      prefix: IconBroken.Logout,
                      suffix: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                builder: (context) {
                                  return Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const LargeText(text: "Logout"),
                                        const Divider(thickness: .8),
                                        const MiddleText(
                                            text:
                                                "Are you sure want to log out ?"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomButton(
                                                title: "Cancle",
                                                borderRadius: 25,
                                                color: Colors.grey[400],
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: CustomButton(
                                                title: "Yes,Logout",
                                                borderRadius: 25,
                                                onTap: () {
                                                  GoRouter.of(context)
                                                      .go(AppRouter.login);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            language == "en"
                                ? IconBroken.Arrow___Right_2
                                : IconBroken.Arrow___Left_2,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final IconData prefix;
  final Widget? suffix;
  const ProfileItem({
    Key? key,
    required this.title,
    required this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MiddleText(
        text: title,
      ),
      leading: Icon(
        prefix,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
      trailing: suffix,
    );
  }
}
