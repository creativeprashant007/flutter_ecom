import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_creation_req.dart';
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
}
