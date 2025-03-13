import 'package:ecommerce/data/auth/repository/auth_repository_implementation.dart';
import 'package:ecommerce/data/auth/sources/authentication_firebase_service.dart';
import 'package:ecommerce/data/category/repository/category.dart';
import 'package:ecommerce/data/category/sources/category_firebase_service.dart';
import 'package:ecommerce/data/order/repository/order.dart';
import 'package:ecommerce/data/order/source/order_firebase_service.dart';
import 'package:ecommerce/data/product/repository/product.dart';
import 'package:ecommerce/data/product/sources/product_firebase_service.dart';
import 'package:ecommerce/domain/auth/repository/auth_repository.dart';
import 'package:ecommerce/domain/auth/usecases/get_ages.dart';
import 'package:ecommerce/domain/auth/usecases/get_user.dart';
import 'package:ecommerce/domain/auth/usecases/login_status.dart';
import 'package:ecommerce/domain/auth/usecases/reset_email.dart';
import 'package:ecommerce/domain/auth/usecases/sign_in.dart';
import 'package:ecommerce/domain/auth/usecases/sign_up.dart';
import 'package:ecommerce/domain/category/repository/category.dart';
import 'package:ecommerce/domain/category/usecases/category.dart';
import 'package:ecommerce/domain/order/repository/order.dart';
import 'package:ecommerce/domain/order/usecases/add_to_cart.dart';
import 'package:ecommerce/domain/order/usecases/get_cart_products.dart';
import 'package:ecommerce/domain/order/usecases/get_orders.dart';
import 'package:ecommerce/domain/order/usecases/order_registration.dart';
import 'package:ecommerce/domain/order/usecases/remove_cart_product.dart';
import 'package:ecommerce/domain/product/repository/product.dart';
import 'package:ecommerce/domain/product/usecases/add_or_remove_favorite_product.dart';
import 'package:ecommerce/domain/product/usecases/get_favorties_products.dart';
import 'package:ecommerce/domain/product/usecases/is_favorite.dart';
import 'package:ecommerce/domain/product/usecases/product_by_cat_id.dart';
import 'package:ecommerce/domain/product/usecases/product_by_title.dart';
import 'package:ecommerce/domain/product/usecases/product_top_selling.dart';
import 'package:ecommerce/domain/product/usecases/product_new_in.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  //services
  //for auth
  sl.registerSingleton<AuthenticationFirebaseService>(
    AuthenticationFirebaseServiceImp(),
  );

  //for category
  sl.registerSingleton<CategoryFirebaseService>(CategoryFirebaseServiceImpl());

  //for for products
  sl.registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImpl());

  //for for orders
  sl.registerSingleton<OrderFirebaseService>(OrderFirebaseServiceImpl());

  //repositories
  //for auth
  sl.registerSingleton<AuthRepository>(AuthRepositoryImplementation());

  //for category
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImplementation());

  //for products
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());

  //for orders
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl());

  //useCases
  //for auth
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<ResetEmailUseCase>(ResetEmailUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<LoginStatusUseCase>(LoginStatusUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  //for category
  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());

  //for products
  sl.registerSingleton<GetTopSellingUseCase>(GetTopSellingUseCase());
  sl.registerSingleton<GetNewInProductUseCase>(GetNewInProductUseCase());
  sl.registerSingleton<GetProductByCategoryIdUseCase>(
    GetProductByCategoryIdUseCase(),
  );
  sl.registerSingleton<GetProductsByTitleUseCase>(GetProductsByTitleUseCase());

  //for favorite
  sl.registerSingleton<AddOrRemoveFavoriteProductUseCase>(
    AddOrRemoveFavoriteProductUseCase(),
  );

  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());

  sl.registerSingleton<GetFavortiesProductsUseCase>(
    GetFavortiesProductsUseCase(),
  );

  //for order
  sl.registerSingleton<GetOrdersUseCase>(GetOrdersUseCase());
  sl.registerSingleton<AddToCartUseCase>(AddToCartUseCase());

  sl.registerSingleton<GetCartProductsUseCase>(GetCartProductsUseCase());

  sl.registerSingleton<RemoveCartProductUseCase>(RemoveCartProductUseCase());

  sl.registerSingleton<OrderRegistrationUseCase>(OrderRegistrationUseCase());
}
