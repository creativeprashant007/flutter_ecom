import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecase/usecase.dart';
import 'package:ecommerce/data/auth/models/user_creation_req.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_req.dart';
import 'package:ecommerce/domain/auth/repository/auth_repository.dart';
import 'package:ecommerce/service_locator.dart';

class SignUpUseCase implements UseCase<Either, UserCreationReq> {
  @override
  Future<Either> call({UserCreationReq? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}
