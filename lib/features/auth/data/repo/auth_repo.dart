
import 'package:dartz/dartz.dart';
import 'package:e_shop/core/errors/failure%20.dart';
import 'package:e_shop/features/auth/data/models/login_model.dart';

abstract class AuthRepo{
  Future<Either<Failure,AuthModel>> loginAuth({required String email,required String password,String lang="en"});
  Future<Either<Failure,AuthModel>> signUpAuth({required String email,required String password,required String name,required String phone,required String image,String lang="en"});
}