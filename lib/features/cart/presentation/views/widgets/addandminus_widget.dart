import 'package:e_shop/features/cart/presentation/view_model/update_cart/update_cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../home/data/repo/home_repo_imp.dart';
import '../../../../product_details_view/presentation/view/widgets/middle_text.dart';
import '../../view_model/update_cart/update_cart_cubit.dart';

class AddAndMinusWidget extends StatelessWidget {
  final int id;

  const AddAndMinusWidget({
    Key? key,required this.id,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateCartCubit(getIt.get<HomeRepoImplement>()),
      child: BlocConsumer<UpdateCartCubit,UpdateCartStates>(
        listener: (context, state) {
          
        },
        builder: (context,state){
          var cubit=UpdateCartCubit.get(context);
          return Container(
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              Theme.of(context).textTheme.headlineLarge!.color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              
              child: IconButton(
                onPressed: (){
                  cubit.countQuantity(type: "minus",id:id);
                },
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.remove,
                  size: 30,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
              ),
            ),
            MiddleText(text: "${count[id]}"),
            Expanded(
              
              child: IconButton(
                onPressed: (){
                  cubit.countQuantity(type: "plus",id:id);
                },
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
        },
      ),
    );
  }
}
