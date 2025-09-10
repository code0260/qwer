import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/categories_model.dart';
import 'package:dartz/dartz.dart';

class StoreCategories {
  StoreCategories._();

  // Search categories by name or description
  static Future<Either<Failure, List<CategoriesModel>>> searchCategories(
      String query) async {
    final result = await DatabaseHelper.query(
      "categories",
      where: "categories_name LIKE ? OR categories_description LIKE ?",
      whereArgs: [
        '%$query%',
        '%$query%'
      ], // Parameterized to avoid SQL injection
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        List<CategoriesModel> categoriesList = response
            .map((category) => CategoriesModel.fromJson(category))
            .toList();
        return right(categoriesList);
      },
    );
  }

  // Get all categories
  static Future<Either<Failure, List<CategoriesModel>>>
      getAllCategories() async {
    // Query to get all categories from the local database
    final result = await DatabaseHelper.query("categories");
    return result.fold(
      (failure) => left(failure),
      (response) async {
        for (final category in response) {
          categories.add(CategoriesModel.fromJson(category));
        }
        // Return a success response with no specific value
        return right(categories);
      },
    );
  }

  // Insert a new category
  static Future<Either<Failure, int>> insertCategory(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert(
      "categories",
      value,
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Update a category by ID
  static Future<Either<Failure, int>> updateCategory(
      int categoryId, Map<String, dynamic> values) async {
    final result = await DatabaseHelper.update(
      "categories",
      values,
      where: "categories_id = ?",
      whereArgs: [categoryId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete a category by ID
  static Future<Either<Failure, int>> deleteCategory(int categoryId) async {
    final result = await DatabaseHelper.delete(
      "categories",
      where: "categories_id = ?",
      whereArgs: [categoryId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all categories
  static Future<Either<Failure, int>> deleteAllCategories() async {
    final result = await DatabaseHelper.delete("categories");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Update category data
  static Future<Either<Failure, int>> updateCategoryData(
      Map<String, dynamic> category) async {
    final result =
        await DatabaseHelper.updateOrInsertData("categories", category);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete multiple categories via a list of IDs
  static Future<Either<Failure, int>> deleteCategoriesViaIdList(
      List<int> list) async {
    final result =
        await DatabaseHelper.deleteViaIdList("categories", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
