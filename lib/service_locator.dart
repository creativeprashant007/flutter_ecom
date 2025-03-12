import 'package:ecommerce/data/auth/repository/auth_repository_implementation.dart';
import 'package:ecommerce/data/auth/sources/authentication_firebase_service.dart';
import 'package:ecommerce/domain/auth/repository/auth_repository.dart';
import 'package:ecommerce/domain/auth/usecases/get_ages.dart';
import 'package:ecommerce/domain/auth/usecases/login_status.dart';
import 'package:ecommerce/domain/auth/usecases/reset_email.dart';
import 'package:ecommerce/domain/auth/usecases/sign_in.dart';
import 'package:ecommerce/domain/auth/usecases/sign_up.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  //services
  sl.registerSingleton<AuthenticationFirebaseService>(
    AuthenticationFirebaseServiceImp(),
  );

  //repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImplementation());

  //useCases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<ResetEmailUseCase>(ResetEmailUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<LoginStatusUseCase>(LoginStatusUseCase());
}
