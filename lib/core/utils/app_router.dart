
import 'package:dio/dio.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/features/address/presentation/view_model/addreess_view.dart';
import 'package:e_shop/features/address/presentation/view_model/new_address_view.dart';
import 'package:e_shop/features/auth/presentation/view/login_page.dart';
import 'package:e_shop/features/auth/presentation/view/signup_view.dart';
import 'package:e_shop/features/cart/data/models/cart_model.dart';
import 'package:e_shop/features/cart/presentation/views/check_out_view.dart';
import 'package:e_shop/features/home/data/models/category_model.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';
import 'package:e_shop/features/home/data/repo/home_repo_imp.dart';
import 'package:e_shop/features/home/presentation/view/category_view.dart';
import 'package:e_shop/features/home/presentation/view/favorite_view_body.dart';
import 'package:e_shop/features/home/presentation/view/home_view.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:e_shop/features/main_page.dart';
import 'package:e_shop/features/payment/presentation/view/payment_view.dart';
import 'package:e_shop/features/payment/presentation/view/visa_view.dart';
import 'package:e_shop/features/product_details_view/presentation/view/product_details_view.dart';
import 'package:e_shop/features/search/presentation/view/search_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/payment/presentation/view/ref_code_view.dart';
import '../../features/search/presentation/view/widgets/search_details_view.dart';


abstract class AppRouter{

 static const login="/login";
 static const signUp="/signUp";
 static const home="/home";
 static const productDetails="/product_details";
static const categoryView="/category_view";
static const favorite="$home/favorite";
static const checkout="/checkout";
 static const searchDetails="/search_details";
  static const search="/search";
  static const address="/address";
  static const newAddress="/newAddress";
static const payment="/payment";
static const refCode="/refCode";
static const visa="/visa";

 static final router=GoRouter(
  
  routes: [
    GoRoute(
      path: "/",
      builder: (context,state)=>const MainPage(),
      
    ),
    GoRoute(
      path: login,
      builder: (context,state)=>const LoginPage(),
      
    ),
     GoRoute(
      path: signUp,
      builder: (context,state)=>const SignUpView(),
      
    ),
    GoRoute(
      path: home,
      builder: (context,state)=>const HomeView(),    
    ),
    GoRoute(
      path: productDetails,
      builder: (context,state)=> ProductDetailsView(productModel: state.extra as ProductModel),
      
    ),
    GoRoute(
      path: categoryView,
      builder: (context,state)=> CategoriesView(categoriesModel: state.extra as CategoriesModel),
      
    ),
    GoRoute(
      path:favorite,
      builder: (context,state)=>const FavoriteViewBody(isArrowBack: true),    
    ),
    GoRoute(
      path: checkout,
      builder: (context,state)=> CheckOutView(cartModel: state.extra as CartModel),    
    ),
    GoRoute(
      path: searchDetails,
      builder: (context,state)=> SearchDetailsView(productModel: state.extra as ProductModel),
      
    ),
     GoRoute(
      path: search,
      builder: (context,state)=>const SearchView(), 
    ),
    GoRoute(
      path: address,
      builder: (context,state)=>const AddressView(), 
    ),
    GoRoute(
      path: newAddress,
      builder: (context,state)=>const NewAddressView(), 
    ),
    GoRoute(
      path: payment,
      builder: (context,state)=>const PaymentView(), 
    ),
    GoRoute(
      path: refCode,
      builder: (context,state)=>const ReferenceCodeView(), 
    ),
    GoRoute(
      path: visa,
      builder: (context,state)=>const VisaView(), 
    ),
 
  ],
  
);
}