import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_creation_req.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_req.dart';

abstract class AuthRepository {
  Future<Either> signUp(UserCreationReq user);
  Future<Either> signIn(UserSignInReq user);
  Future<Either> sendPasswordResetEmail(String email);
  Future<Either> getAges();
  Future<bool> isLoggedIn();
}
