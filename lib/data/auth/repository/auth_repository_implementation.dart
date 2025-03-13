import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_creation_req.dart';
import 'package:ecommerce/data/auth/models/user_model.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_req.dart';
import 'package:ecommerce/data/auth/sources/authentication_firebase_service.dart';
import 'package:ecommerce/domain/auth/repository/auth_repository.dart';
import 'package:ecommerce/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {
  @override
  Future<Either> signUp(UserCreationReq user) async {
    return sl<AuthenticationFirebaseService>().signUp(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthenticationFirebaseService>().getAges();
  }

  @override
  Future<Either> signIn(UserSignInReq user) {
    return sl<AuthenticationFirebaseService>().signIn(user);
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) {
    return sl<AuthenticationFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthenticationFirebaseService>().getUser();
    return user.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(UserModel.fromMap(data).toEntity());
      },
    );
  }

  @override
  Future<bool> isLoggedIn() {
    return sl<AuthenticationFirebaseService>().isLoggedIn();
  }
}
