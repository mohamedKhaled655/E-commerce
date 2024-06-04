import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/widgets/custom_empty_widget.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/core/widgets/large_text.dart';
import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:e_shop/features/search/presentation/view_model/search_cubit/search_cubit.dart';
import 'package:e_shop/features/search/presentation/view_model/search_cubit/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../home/data/repo/home_repo_imp.dart';
import '../../../home/presentation/view/widgets/product_item.dart';
import 'widgets/searchItem.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ));
    return Scaffold(
      body: BlocProvider(
        create: (context) => SearchCubit(getIt.get<HomeRepoImplement>()),
        child: BlocBuilder<SearchCubit, SearchStates>(
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return SafeArea(
              child: Padding(
                padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom,left: 20,right: 20,top: 20),
                child: ListView(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).textTheme.headlineLarge!.color,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        onChanged: (value) {
                          searchText = value;
                          print("change=$searchText");
                        },
                        onSaved: (value) {
                          searchText = value ?? "";
                          setState(() {});
                          print("searchText=$value");
                        },
                        decoration: InputDecoration(
                          hintText: "Search".tr(context),
                          fillColor: Colors.transparent,
                          enabledBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          suffixIconColor: Theme.of(context).primaryColor,
                          suffixIcon: IconButton(
                            icon: Icon(
                              IconBroken.Search,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              print("searchText1=$searchText");
                              setState(() {});
                              cubit.fetchSearchData(text: searchText);
                            },
                          ),
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
                   const SizedBox(height: 20,),
                   const Divider(),
                    if (state is SearchInitState) LargeText(text: "Search for the product that you want".tr(context)),
                    if (state is SearchLoadingState)
                      const CustomLoadingWidget(),
                    if (state is SearchErrorState)
                      CustomErrorWidget(errorText: state.errMessage),
                    if (state is SearchSuccessState)MiddleText(text:"result contain ".tr(context)+" ${state.searchModel.length} "+"items".tr(context)), 
                    const SizedBox(height: 20,), 
                    if (state is SearchSuccessState)
                      state.searchModel.isNotEmpty? SizedBox(
                        height: h10*60,
                        child: GridView.builder(
                          itemCount: state.searchModel.length,
                          //shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 2.35 / 4,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: SearchItem(
                                productModel: state.searchModel[index],
                              ),
                              onTap: () {
                                GoRouter.of(context).push(
                                    AppRouter.searchDetails,
                                    extra: state.searchModel[index]);
                              },
                            );
                          },
                        ),
                      ): SizedBox(
                        height: 400,
                        child: CustomEmptyWidget(
                          image: "assets/images/s2.png",
                          title: "Not Found".tr(context),
                          body: "Sorry, the keyword you entered can not be found, please check again or search with anther keyword".tr(context),
                        )),
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
