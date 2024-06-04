import 'package:dio/dio.dart';
import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/core/utils/app_router.dart';
import 'package:e_shop/core/utils/service_locator.dart';
import 'package:e_shop/core/widgets/custom_loading_widget.dart';
import 'package:e_shop/core/widgets/error_widget.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view_model/category_cubit/categories_cubit.dart';
import 'package:e_shop/features/home/presentation/view_model/category_cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/shimmer_screen/circle_list_shimmer.dart';
import 'categoryItem.dart';

List<Widget>icon=[
const FaIcon(FontAwesomeIcons.laptop,size: 25,color: kPrimaryColor,),
const FaIcon(FontAwesomeIcons.faceTired,size: 25,color: kPrimaryColor,),
const FaIcon(FontAwesomeIcons.dumbbell,size: 25,color: kPrimaryColor,),
const FaIcon(FontAwesomeIcons.lightbulb,size: 25,color: kPrimaryColor,),
const FaIcon(FontAwesomeIcons.shirt,size: 25,color: kPrimaryColor,),
];

class ListCategoryItems extends StatelessWidget {
 

  const ListCategoryItems({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(getIt.get<HomeRepoImplement>())..fetchCategoryData(),
      child: BlocBuilder<CategoriesCubit,CategoriesStates>(
        builder: (context, state) {
          if(state is CategoriesSuccessState){
            return SizedBox(
        height: h10*11,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return CategoryItem(
          icon: icon[index],
          title: state.categoriesModel[index].name??"",
          onPressed: (){
            GoRouter.of(context).push(AppRouter.categoryView ,extra:state.categoriesModel[index] );
          },
        );
          },
          separatorBuilder: (context,index)=>SizedBox(width: h10*1.5,),
          itemCount: state.categoriesModel.length,
          scrollDirection: Axis.horizontal,
          physics:const BouncingScrollPhysics(),
        ),
      );
          }else if (state is CategoriesErrorState){
            return  CustomErrorWidget(errorText: state.errMessage,);
          }else{
            return const CircleListShimmer();
          }
        },
      ),
    );
  }
}