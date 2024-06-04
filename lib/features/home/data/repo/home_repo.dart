import 'package:dartz/dartz.dart';
import 'package:e_shop/features/address/data/model/address_model.dart';
import 'package:e_shop/features/auth/data/models/login_model.dart';
import 'package:e_shop/features/cart/data/models/add_cart_model.dart';
import 'package:e_shop/features/cart/data/models/update_quantity_model.dart';
import 'package:e_shop/features/home/data/models/banner_model.dart';
import 'package:e_shop/features/home/data/models/category_model.dart';
import 'package:e_shop/features/home/data/models/favorites_mode.dart';
import 'package:e_shop/features/home/data/models/get_favorite_model.dart';
import 'package:e_shop/features/home/data/models/notification_model.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';

import '../../../../core/errors/failure .dart';
import '../../../cart/data/models/cart_model.dart';
import '../../../payment/data/model/pay_auth_token_model.dart';

abstract class HomeRepo{
  Future<Either<Failure,List<BannersModel>>> fetchBanner();
  Future<Either<Failure,List<CategoriesModel>>> fetchCategories({String lang});
  Future<Either<Failure,List<ProductModel>>> fetchCategoriesDetails({String lang,required int id,String token});
  Future<Either<Failure,List<ProductModel>>> fetchProduct({String lang,String token});
  Future<Either<Failure,FavoritesModel>> fetchFavorites({String lang,required int id,String token});
  Future<Either<Failure,List<GetFavoriteModel>>> getFavorites({String lang,String token});
  Future<Either<Failure,GetFavoriteModel>> removeFavorites({String lang,required int id,String token});
  Future<Either<Failure,AuthModel>> fetchProfile({String lang,String token});
  Future<Either<Failure,CartModel>> fetchCart({String lang,String token});
  Future<Either<Failure,AddCartModel>> addToCart({String lang,required int id,String token});
  Future<Either<Failure,FavoritesModel>> removeFromCart({String lang,required int id,String token});
  Future<Either<Failure,UpdateQuantityModel>> updateQuantityCart({String lang,required int id,String token,required int quantity});
  Future<Either<Failure,List<ProductModel>>> fetchSearch({String lang,required String text,String token});
  Future<Either<Failure,List<AddressModel>>> fetchAddress({String lang,String token});
  Future<Either<Failure,FavoritesModel>> addAddress({String lang,String token,required String name,required String city,required String region,required String notes,required String details,required String lat,required String long});
  Future<Either<Failure,FavoritesModel>> removeAddress({String lang,required int id,String token});
  Future<Either<Failure,List<NotificModel>>> fetchNotification({String lang,String token});
  Future<Either<Failure,PaymentAuthTokenModel>> getAuthPaymentToken();
  Future<Either<Failure,String>> getOrderRegistrationID({required String price,required String firstName,required String lastName,required String email,required String phone,});
  Future<Either<Failure,String>> getPaymentRequest({required String priceOrder,required String firstName,required String lastName,required String email,required String phone,});
  Future<Either<Failure,String>> getRefCode();

}