import 'package:e_shop/features/payment/data/repo/api_constance.dart';
import 'package:e_shop/features/payment/presentation/view_model/payment_cubit/payment_states.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../home/data/repo/home_repo_imp.dart';
import '../view_model/payment_cubit/payment_cubit.dart';

class ReferenceCodeView extends StatelessWidget {
  const ReferenceCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reference Code'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            paymentExitApp(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            PaymentCubit(getIt.get<HomeRepoImplement>())..fettchRefCode(),
        child: BlocConsumer<PaymentCubit, PaymentStates>(
          listener: (context, state) {
            if (state is GetRefCodeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(showSnakBar(
                  backgroundColor: Colors.red,
                  context: context,
                  message: state.errMessage,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16)));
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MiddleText(
                      text: 'You should go to any market to pay',
                    ),
                    const SizedBox(height: 10.0),
                    const MiddleText(
                      text: 'This is reference code',
                    ),
                    const SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: ApiContest.refCode.isEmpty
                                ? ''
                                : ApiContest.refCode));
                        SnackBar snackBar = const SnackBar(
                          content: Text('Text copied to clipboard'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            ApiContest.refCode.isEmpty
                                ? '🚫'
                                : ApiContest.refCode,
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void paymentExitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const MiddleText(
            text: 'Are you sure not completed the pay',
          ),
          actions: [
            TextButton(
              onPressed: () {
                //Navigator.pop(context);

                GoRouter.of(context).go("/");
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
