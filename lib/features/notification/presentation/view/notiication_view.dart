import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/features/notification/presentation/view_model/notification_cubit.dart';
import 'package:e_shop/features/notification/presentation/view_model/notification_states.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/icon_broken.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/main_app_bar.dart';
import '../../../home/data/repo/home_repo_imp.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NotificationCubit(getIt.get<HomeRepoImplement>())
          ..fetchNotificationData(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                MainAppBar(
                  title: "Notification".tr(context),
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
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<NotificationCubit, NotificationStates>(
                    builder: (context, state) {
                      if (state is NotificationSuccessState) {
                        return AnimationLimiter(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: const Duration(milliseconds: 100),
                                  child: SlideAnimation(
                                    duration:
                                        const Duration(milliseconds: 2500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    verticalOffset: -250,
                                    child: ScaleAnimation(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: Container(
                                        height: 150,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Theme.of(context)
                                                .bottomAppBarColor),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                radius: 30,
                                                child: Icon(
                                                  index.isEven
                                                      ? IconBroken.Wallet
                                                      : IconBroken.Chart,
                                                  color: Theme.of(context)
                                                      .bottomAppBarColor,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: MiddleText(
                                                    text: state
                                                        .notificationModel
                                                        .reversed
                                                        .toList()[index]
                                                        .title!,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                                  Expanded(
                                                      child: MiddleText(
                                                          text: state
                                                              .notificationModel
                                                              .reversed
                                                              .toList()[index]
                                                              .message!,
                                                          color: Colors.grey)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.notificationModel.length),
                        );
                      } else if (state is NotificationErrorState) {
                        return CustomErrorWidget(errorText: state.errMessage);
                      } else {
                        return const CustomLoadingWidget();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
