import 'package:dartz/dartz.dart';
import 'package:ecommerce/domain/product/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either> getTopSellingProduct();
  Future<Either> getNewInProduct();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<bool> isFavorite(String productId);
  Future<Either> getFavoritesProducts();
}
