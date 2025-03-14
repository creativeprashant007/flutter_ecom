import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/product/models/product.dart';
import 'package:ecommerce/data/product/sources/product_firebase_service.dart';
import 'package:ecommerce/domain/product/entities/product_entity.dart';
import 'package:ecommerce/domain/product/repository/product.dart';
import 'package:ecommerce/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getTopSellingProduct() async {
    var returnData = await sl<ProductFirebaseService>().getTopSellingProduct();
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }

  @override
  Future<Either> getNewInProduct() async {
    var returnData = await sl<ProductFirebaseService>().getNewInProduct();
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    var returnData = await sl<ProductFirebaseService>().getProductsByCategoryId(
      categoryId,
    );
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    var returnData = await sl<ProductFirebaseService>().getProductsByTitle(title);
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }
  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
     var returnedData = await sl<ProductFirebaseService>().addOrRemoveFavoriteProduct(product);
    return returnedData.fold(
      (error){
        return Left(error);
      }, 
      (data){
        return Right(
          data
        );
      }
    );
  }
  
  @override
  Future<bool> isFavorite(String productId) async {
    return await sl<ProductFirebaseService>().isFavorite(productId);
  }
  
  @override
  Future<Either> getFavoritesProducts() async {
    var returnedData = await sl<ProductFirebaseService>().getFavoritesProducts();
    return returnedData.fold(
      (error){
        return Left(error);
      }, 
      (data){
        return Right(
          List.from(data).map((e) => ProductModel.fromMap(e).toEntity()).toList()
        );
      }
    );
  }

}
