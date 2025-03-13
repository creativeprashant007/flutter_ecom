import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/category/models/category.dart';
import 'package:ecommerce/data/category/sources/category_firebase_service.dart';
import 'package:ecommerce/domain/category/repository/category.dart';
import 'package:ecommerce/service_locator.dart';

class CategoryRepositoryImplementation extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var categories = await sl<CategoryFirebaseService>().getCategories();

    return categories.fold((error) => Left(error), (data) {
      if (data == null || data.isEmpty) {
        return Left("No categories found");
      }
      return Right(
        List.from(
          data,
        ).map((e) => CategoryModel.fromMap(e).toEntity()).toList(),
      );
    });
  }
}
