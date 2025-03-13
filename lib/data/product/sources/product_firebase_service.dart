import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/product/models/product.dart';
import 'package:ecommerce/domain/product/entities/product_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProductFirebaseService {
  Future<Either> getTopSellingProduct();
  Future<Either> getNewInProduct();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<bool> isFavorite(String productId);
  Future<Either> getFavoritesProducts();
}

class ProductFirebaseServiceImpl extends ProductFirebaseService {
  @override
  Future<Either> getTopSellingProduct() async {
    try {
      var returnData =
          await FirebaseFirestore.instance
              .collection("Products")
              .where("salesNumber", isGreaterThanOrEqualTo: 1)
              .get();

      return Right(returnData.docs.map((e) => e.data()).toList());
    } on FirebaseException catch (e) {
      // Handle Firestore specific errors
      return Left("Firestore error: ${e.message ?? 'Unknown error'}");
    } catch (e) {
      // Handle any other general exceptions
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Either> getNewInProduct() async {
    try {
      var returnData =
          await FirebaseFirestore.instance
              .collection("Products")
              .where(
                "createdDate",
                isGreaterThanOrEqualTo: Timestamp.fromDate(
                  DateTime(2025, 1, 1),
                ),
              )
              .get();

      return Right(returnData.docs.map((e) => e.data()).toList());
    } on FirebaseException catch (e) {
      // Handle Firestore specific errors
      return Left("Firestore error: ${e.message ?? 'Unknown error'}");
    } catch (e) {
      // Handle any other general exceptions
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    try {
      var returnData =
          await FirebaseFirestore.instance
              .collection("Products")
              .where("categoryId", isEqualTo: categoryId)
              .get();

      return Right(returnData.docs.map((e) => e.data()).toList());
    } on FirebaseException catch (e) {
      // Handle Firestore specific errors
      return Left("Firestore error: ${e.message ?? 'Unknown error'}");
    } catch (e) {
      // Handle any other general exceptions
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    try {
      var returnData =
          await FirebaseFirestore.instance
              .collection("Products")
              .where("title", isGreaterThanOrEqualTo: title)
              .get();

      return Right(returnData.docs.map((e) => e.data()).toList());
    } on FirebaseException catch (e) {
      // Handle Firestore specific errors
      return Left("Firestore error: ${e.message ?? 'Unknown error'}");
    } catch (e) {
      // Handle any other general exceptions
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user!.uid)
              .collection('Favorites')
              .where('productId', isEqualTo: product.productId)
              .get();

      if (products.docs.isNotEmpty) {
        await products.docs.first.reference.delete();
        return const Right(false);
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .collection('Favorites')
            .add(product.fromEntity().toMap());
        return const Right(true);
      }
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user!.uid)
              .collection('Favorites')
              .where('productId', isEqualTo: productId)
              .get();

      if (products.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getFavoritesProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user!.uid)
              .collection('Favorites')
              .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again');
    }
  }

  
}
