import 'package:dio/dio.dart';
import 'package:e_shop/core/errors/failure%20.dart';
import 'package:dartz/dartz.dart';
import 'package:e_shop/core/utils/api_service.dart';
import 'package:e_shop/features/auth/data/models/login_model.dart';
import 'package:e_shop/features/auth/data/repo/auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final ApiServices apiServices;

  AuthRepoImplementation(this.apiServices);

  @override
  Future<Either<Failure, AuthModel>> loginAuth(
      {required String email,
      required String password,
      String lang = "en"}) async {
    try {
      final data = await apiServices.post(
          endPoint: 'login',
          body: {"email": email, "password": password},
          lang: lang);
      return Right(AuthModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signUpAuth(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String image,
      String lang = "en"}) async {
    try {
      final data = await apiServices.post(
          endPoint: 'register',
          body: {
            "email": email,
            "password": password,
            "name": name,
            "phone": phone,
            "image": image
          },
          lang: lang);
      return Right(AuthModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(e.toString()));
    }
  }
}
