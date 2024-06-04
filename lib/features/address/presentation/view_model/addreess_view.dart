import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/features/address/presentation/view_model/address_cubit/address_cubit.dart';
import 'package:e_shop/features/address/presentation/view_model/address_cubit/address_states.dart';
import 'package:e_shop/features/address/presentation/view_model/remove_address/remove_address_cubit.dart';
import 'package:e_shop/features/address/presentation/view_model/remove_address/remove_address_states.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/utils/services_location.dart';
import '../../../../core/widgets/custom_bottom.dart';
import '../../../../core/widgets/main_app_bar.dart';
import '../../../home/data/repo/home_repo_imp.dart';
import 'new_address_view.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  int _selectedOption = 0;
  Future<void> cacheAddressIndex(int indexAddress) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("indexAddress", indexAddress);
  }

  Future<void> getAddressIndex() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _selectedOption = sharedPreferences.getInt("indexAddress")!;
    print("address index=$_selectedOption");
  }

  ServicesLocation servicesLocation = ServicesLocation();
  bool isLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressIndex();
    servicesLocation.getPostion(context);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RemoveAddressCubit(getIt.get<HomeRepoImplement>()),
        child: BlocProvider(
          create: (context) {
            return AddressCubit(getIt.get<HomeRepoImplement>())
              ..fetchAddressData()
              ..getAddressIndex();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  MainAppBar(
                    title: "Address".tr(context),
                    isArrowBack: true,
                    onPressed: () {
                      //GoRouter.of(context).pop();
                      Navigator.of(context).pop(_selectedOption);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 10,
                    child: BlocConsumer<RemoveAddressCubit,RemoveAddressStates>(
                      listener: (context, state) {
                        
                      },
                      builder: (contex,state){
                        return BlocBuilder<AddressCubit, AddressStates>(
                      builder: (context, state) {
                        if (state is AddressSuccessState) {
                           
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return CustomAddressItem(
                                  onPressedRemove: (context){
                                   RemoveAddressCubit.get(context).removeAddressData(id: state.addressModel[index].id!);
                                    state.addressModel.removeAt(index);
                                    print("remove1=${ state.addressModel[index].id!}");
                                  },
                                  id: state.addressModel[index].id!,
                                  title: state.addressModel[index].name!,
                                  subTitle: state.addressModel[index].details!,
                                  city: state.addressModel[index].city!,
                                  region: state.addressModel[index].region!,
                                  value: index,
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    _selectedOption = value;
                                    setState(() {
                                      print(_selectedOption);
                                      //cacheAddressIndex(_selectedOption);
                                      AddressCubit.get(context)
                                          .cacheAddressIndex(_selectedOption);
                                    });
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.addressModel.length);
                        } else if (state is AddressErrorState) {
                          return CustomErrorWidget(errorText: state.errMessage);
                        } else {
                          return const CustomLoadingWidget();
                        }
                      },
                    );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      borderRadius: 30,
                      title: "Add New Address".tr(context),
                      color: Theme.of(context).primaryColor,
                      onTap: () async {
                        // GoRouter.of(context).push(AppRouter.newAddress);
                        isLoad = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewAddressView()),
                        );
                        print("re=$isLoad");
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAddressItem extends StatelessWidget {
  final String title, subTitle, city, region;
  final dynamic value;
  final dynamic groupValue;
  final int id;
  final void Function(dynamic)? onChanged;
  final void Function(BuildContext)? onPressedRemove;
  const CustomAddressItem({
    Key? key,
    required this.title,
    required this.subTitle,
    this.value,
    this.groupValue,
    this.onChanged,
    required this.city,
    required this.region,
    required this.id,
    required this.onPressedRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(id),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const StretchMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {
          onPressedRemove;
        }),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: onPressedRemove,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
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
                        text: title, fontSize: 18, fontWeight: FontWeight.w700),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MiddleText(
                          text: city,
                          fontSize: 14,
                          textOverflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                        ),
                        MiddleText(
                          text: region,
                          fontSize: 14,
                          textOverflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    MiddleText(
                      text: subTitle,
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
              Radio(
                value: value,
                groupValue: groupValue,
                activeColor: Theme.of(context).primaryColor,
                onChanged: onChanged,
              )
            ],
          ),
        ),
      ),
    );
  }
}
