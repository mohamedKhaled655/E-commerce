import 'package:dio/dio.dart';
import 'package:e_shop/features/address/data/model/address_model.dart';
import 'package:e_shop/features/auth/data/models/login_model.dart';
import 'package:e_shop/features/cart/data/models/add_cart_model.dart';
import 'package:e_shop/features/cart/data/models/cart_model.dart';
import 'package:e_shop/features/cart/data/models/update_quantity_model.dart';
import 'package:e_shop/features/home/data/models/banner_model.dart';

import 'package:e_shop/core/errors/failure%20.dart';

import 'package:dartz/dartz.dart';
import 'package:e_shop/features/home/data/models/category_model.dart';
import 'package:e_shop/features/home/data/models/favorites_mode.dart';
import 'package:e_shop/features/home/data/models/get_favorite_model.dart';
import 'package:e_shop/features/home/data/models/notification_model.dart';
import 'package:e_shop/features/home/data/models/product_model.dart';

import '../../../../core/utils/api_service.dart';
import '../../../payment/data/model/pay_auth_token_model.dart';
import '../../../payment/data/repo/api_constance.dart';
import 'home_repo.dart';

class HomeRepoImplement implements HomeRepo {
  final ApiServices apiServices;

  HomeRepoImplement(this.apiServices);

  @override
  Future<Either<Failure, List<BannersModel>>> fetchBanner() async {
    try {
      var data = await apiServices.get(endPoint: "banners");
      List<BannersModel> banners = [];
      for (var item in data["data"]) {
        banners.add(BannersModel.fromJson(item));
      }
      return Right(banners);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories(
      {String lang = "en"}) async {
    try {
      final data = await apiServices.get(endPoint: "categories", lang: lang);
      List<CategoriesModel> categories = [];
      for (var item in data["data"]["data"]) {
        categories.add(CategoriesModel.fromJson(item));
      }
      return Right(categories);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProduct(
      {String lang = "en", String? token}) async {
    try {
      final data =
          await apiServices.get(endPoint: "products", lang: lang, token: token);
      List<ProductModel> products = [];
      for (var item in data["data"]["data"]) {
        products.add(ProductModel.fromJson(item));
      }
      return Right(products);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchCategoriesDetails(
      {String lang = "en", required int? id, String? token}) async {
    try {
      final data = await apiServices.get(
          endPoint: "categories/$id", lang: lang, token: token);
      List<ProductModel> products = [];
      for (var item in data["data"]["data"]) {
        products.add(ProductModel.fromJson(item));
      }
      return Right(products);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoritesModel>> fetchFavorites(
      {String lang = "en", required int id, String? token}) async {
    try {
      final data = await apiServices.post(
          endPoint: "favorites",
          lang: lang,
          body: {
            "product_id": id,
          },
          token: token);

      return Right(FavoritesModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetFavoriteModel>>> getFavorites(
      {String lang = "en", String? token}) async {
    try {
      final data = await apiServices.get(
          endPoint: "favorites", lang: lang, token: token);
      List<GetFavoriteModel> favorite = [];
      for (var item in data["data"]["data"]) {
        favorite.add(GetFavoriteModel.fromJson(item));
      }
      return Right(favorite);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetFavoriteModel>> removeFavorites(
      {String lang = "en", required int id, String? token}) async {
    try {
      final data = await apiServices.remove(
          endPoint: "favorites/$id", lang: lang, token: token);

      return Right(GetFavoriteModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> fetchCart(
      {String lang = "en", String? token}) async {
    try {
      final data =
          await apiServices.get(endPoint: "carts", lang: lang, token: token);

      return Right(CartModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddCartModel>> addToCart(
      {String lang = "en", required int id, String? token}) async {
    try {
      final data = await apiServices.post(
          endPoint: "carts",
          lang: lang,
          body: {
            "product_id": id,
          },
          token: token);

      return Right(AddCartModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoritesModel>> removeFromCart(
      {String lang = "en", required int id, String? token}) async {
    try {
      final data = await apiServices.remove(
          endPoint: "carts/$id", lang: lang, token: token);

      return Right(FavoritesModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateQuantityModel>> updateQuantityCart(
      {String lang = "en",
      required int id,
      String? token,
      required int quantity}) async {
    try {
      final data = await apiServices.put(
          endPoint: "carts/$id",
          lang: lang,
          body: {
            "quantity": quantity,
          },
          token: token);

      return Right(UpdateQuantityModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchSearch(
      {String lang = "en", required String text, String? token}) async {
    try {
      final data = await apiServices.post(
          endPoint: "products/search",
          lang: lang,
          body: {
            "text": text,
          },
          token: token);
      List<ProductModel> search = [];
      for (var item in data["data"]["data"]) {
        search.add(ProductModel.fromJson(item));
      }

      return Right(search);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> fetchAddress(
      {String lang = "en", String? token}) async {
    try {
      final data = await apiServices.get(
          endPoint: "addresses", lang: lang, token: token);
      List<AddressModel> address = [];
      for (var item in data["data"]["data"]) {
        address.add(AddressModel.fromJson(item));
      }
      return Right(address);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoritesModel>> addAddress(
      {String lang = "en",
      String? token,
      required String name,
      required String city,
      required String region,
      required String notes,
      required String details,
      required String lat,
      required String long}) async {
    try {
      final data = await apiServices.post(
          endPoint: "addresses",
          lang: lang,
          body: {
            "name": name,
            "city": city,
            "region": region,
            "details": details,
            "latitude": lat,
            "longitude": long,
            "notes": notes,
          },
          token: token);

      return Right(FavoritesModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoritesModel>> removeAddress(
      {String lang = "en", required int id, String? token}) async {
    try {
      final data = await apiServices.remove(
          endPoint: "addresses/$id", lang: lang, token: token);

      return Right(FavoritesModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> fetchProfile(
      {String lang = "en", String? token}) async {
    try {
      final data =
          await apiServices.get(endPoint: "profile", lang: lang, token: token);

      return Right(AuthModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificModel>>> fetchNotification(
      {String lang = "en", String? token}) async {
    try {
      final data = await apiServices.get(endPoint: "notifications", lang: lang);
      List<NotificModel> notification = [];
      for (var item in data["data"]["data"]) {
        notification.add(NotificModel.fromJson(item));
      }
      return Right(notification);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentAuthTokenModel>> getAuthPaymentToken() async {
    try {
      final data = await apiServices.postPayment(
        endPoint: ApiContest.getAuthToken,
        body: {
          "api_key": ApiContest.paymentApiKey,
        },
      );
      ApiContest.paymentFirstToken = data["token"];

      return Right(PaymentAuthTokenModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getOrderRegistrationID(
      {required String price,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    try {
      final data = await apiServices.postPayment(
        endPoint: ApiContest.getOrderId,
        body: {
          'auth_token': ApiContest.paymentFirstToken,
          "delivery_needed": "false",
          "amount_cents": price,
          "currency": "EGP",
          "items": [],
        },
      );
      ApiContest.paymentOrderId = data["id"].toString();

      return Right(data["id"].toString());
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPaymentRequest(
      {required String priceOrder,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    try {
      final data = await apiServices.postPayment(
        endPoint: ApiContest.getPaymentRequest,
        body: {
        "auth_token":ApiContest.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": ApiContest.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApiContest.integrationIdCard,
        "lock_order_when_paid": "false"
        },
      );
      ApiContest.finalToken = data["token"];

      return Right(data["token"]);
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getRefCode() async{
    try {
      final data = await apiServices.postPayment(
        endPoint: ApiContest.getRefCode,
        body: {
           "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ApiContest.finalToken,
        },
      );
      ApiContest.refCode = data["id"].toString();

      return Right(data["id"].toString());
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }
}
