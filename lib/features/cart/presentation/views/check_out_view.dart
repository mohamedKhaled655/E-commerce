import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/main_app_bar.dart';
import 'package:e_shop/features/cart/presentation/views/widgets/choose_shipping.dart';
import 'package:e_shop/features/payment/presentation/view_model/payment_cubit/payment_cubit.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_bottom.dart';
import '../../../home/data/repo/home_repo_imp.dart';
import '../../../payment/presentation/view_model/payment_cubit/payment_states.dart';
import '../../data/models/cart_model.dart';
import 'widgets/address_item.dart';
import 'widgets/order_list.dart';

class CheckOutView extends StatefulWidget {
  final CartModel cartModel;
  const CheckOutView({Key? key, required this.cartModel}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  String? promoCode;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ));
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                MainAppBar(
                  title: "CheckOut".tr(context),
                  isLeading: true,
                  icon: Icon(
                    IconBroken.More_Circle,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () {
                    print("arrow back");
                    GoRouter.of(context).pop();
                  },
                  isArrowBack: true,
                  onPressedLeading: () {},
                ),
                const Divider(
                  thickness: .8,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    
                    physics: const BouncingScrollPhysics(),
                    children: [
                       MiddleText(
                        text: "Shipping Address".tr(context),
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const AddressItem(),
                      const Divider(
                        thickness: .8,
                      ),
                       MiddleText(
                        text: "Ordere List".tr(context),
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const OrderList(),
                      const Divider(
                        thickness: .8,
                      ),
                      const ChooseShipping(),
                      const Divider(
                        thickness: .8,
                      ),
                      SizedBox(
                        height: h10 * 27,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             MiddleText(
                              text: "Promo Code".tr(context),
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .color,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: TextFormField(
                                        cursorColor: kPrimaryColor,
                                        onSaved: (value) {
                                          promoCode = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Enter Promo Code".tr(context),
                                          fillColor: Colors.transparent,
                                          enabledBorder: outlineInputBorder,
                                          border: outlineInputBorder,
                                          focusedBorder: outlineInputBorder,
                                        ),
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return "Field is required";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .backgroundColor,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: h10 * 14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).bottomAppBarColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:  [
                                        MiddleText(
                                          text: "Amount".tr(context),
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                       const MiddleText(
                                          text: "\$ 12330",
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:  [
                                        MiddleText(
                                          text: "Shipping".tr(context),
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        const MiddleText(
                                          text: "\$ 15",
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:  [
                                        MiddleText(
                                          text: "promo Code".tr(context),
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                       const MiddleText(
                                          text: "\$ - 30",
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: .8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:  [
                                        MiddleText(
                                          text: "Total".tr(context),
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                       const MiddleText(
                                          text: "\$ 123250",
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: .8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => PaymentCubit(getIt.get<HomeRepoImplement>()),
        child: BlocConsumer<PaymentCubit,PaymentStates>(
          listener: (context, state) {
            if(state is GetPaymentRequestSuccessState){
              GoRouter.of(context).push(AppRouter.payment);
            }
          },
          builder: (context, state) {
            return Container(
          margin: EdgeInsets.only(
              right: language == "en" ? 0 : 30, left: language == "en" ? 30 : 0),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).bottomAppBarColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Payment".tr(context),
                    isLoading: state is GetOrderRegistrationIDLoadingState?true:false,
                    borderRadius: 20,
                    onTap: () {
                      print(total);//price
                      PaymentCubit.get(context).getOrderRegistrationID(price: "10", firstName: name, lastName: name, email: email, phone: phone);             
                      
                    },
                  ),
                ),
              ],
            ),
          ),
        );
          },
        ),
      ),
    );
  }
}
