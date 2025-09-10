import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/categories_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoriesModel>>> getCategories();
  Future<Either<Failure, void>> importCategories(String filePath);
  Future<Either<Failure, List<CategoriesModel>>> refreshCategories();
  Future<Either<Failure, void>> addCategory(String categoriesName);
  Future<Either<Failure, void>> editCategoryProfitPercentage(
      List<int> categoriesId, int? percentage);
  Future<Either<Failure, void>> deleteCategory(int categoriesId);
  Future<Either<Failure, void>> editCategory(CategoriesModel categoriesModel);
}
