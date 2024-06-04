import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/features/address/presentation/view_model/address_cubit/address_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/icon_broken.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../address/presentation/view_model/addreess_view.dart';
import '../../../../address/presentation/view_model/address_cubit/address_cubit.dart';
import '../../../../home/data/repo/home_repo_imp.dart';
import '../../../../product_details_view/presentation/view/widgets/middle_text.dart';

class AddressItem extends StatefulWidget {
  const AddressItem({Key? key}) : super(key: key);

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  int result=0;
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => AddressCubit(getIt.get<HomeRepoImplement>())
        ..fetchAddressData()
        ..getAddressIndex(),
      child: BlocBuilder<AddressCubit, AddressStates>(
        builder: (context, state) {
          
          return Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).bottomAppBarColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor:
                        Theme.of(context).textTheme.headlineLarge!.color,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.location_on,
                        color: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .backgroundColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MiddleText(
                            text: state is AddressSuccessState
                                ? state
                                    .addressModel[result]
                                    .name!
                                : "",
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        MiddleText(
                          text: state is AddressSuccessState
                              ? state
                                  .addressModel[
                                      result]
                                  .details!
                              : "",
                          fontSize: 14,
                          textOverflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      //var result=GoRouter.of(context).pushNamed(AppRouter.address);
                      result= await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const  AddressView()),
                      );
                      print("re=$result");
                      setState(() {
                        
                      });
                    },
                    icon: Icon(
                      IconBroken.Edit,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
