import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_categories.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo.dart';
import 'package:almonazim/data/model/categories_model.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final ApiService apiService;
  CategoriesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<CategoriesModel>>> getCategories() async {
    if (categories.isEmpty) {
      final result = await apiService.get(
        url: AppLinks.getCategoriesLink,
      );

      return result.fold(
        (failure) => left(failure),
        (response) {
          for (final category in response["data"]) {
            categories.add(CategoriesModel.fromJson(category));
          }
          return right(categories);
        },
      );
    }
    return right(categories);
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> refreshCategories() async {
    final result = await apiService.get(
      url: AppLinks.getCategoriesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        //& category
        List<int> categoryIds = [];
        List<CategoriesModel> categories = [];

        for (final category in response["data"]) {
          categoryIds.add(category['categories_id']);
          categories.add(CategoriesModel.fromJson(category));
          await StoreCategories.updateCategoryData(category);
        }
        await StoreCategories.deleteCategoriesViaIdList(categoryIds);
        return right(categories);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importCategories(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importCategoriesLink,
        requestName: "categories_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("3");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addCategory(String categoriesName) async {
    final result = await apiService.post(
        url: AppLinks.addCategoriesLink,
        data: {"categories_name": categoriesName});

    return result.fold(
      (failure) => left(failure),
      (response) {
        categories.add(CategoriesModel.fromJson(response["data"]));
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editCategoryProfitPercentage(
      List<int> categoriesId, int? percentage) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editCategoriesProfitPercentageLink,
        data: {"categories_ids": categoriesId, 'percentage': percentage});

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int categoriesId) async {
    final result = await apiService.post(
        url: AppLinks.deleteCategoriesLink,
        data: {"categories_id": categoriesId});

    return result.fold(
      (failure) => left(failure),
      (response) {
        categories.removeWhere(
          (element) {
            return element.categoriesId == categoriesId;
          },
        );
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editCategory(
      CategoriesModel categoriesModel) async {
    final result = await apiService.post(
      url: AppLinks.editCategoriesLink,
      formDataIsEnabled: false,
      data: categoriesModel.toJson(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        for (final category in categories) {
          if (category.categoriesId == categoriesModel.categoriesId) {
            category.categoriesName = categoriesModel.categoriesName;
          }
        }
        return right(null);
      },
    );
  }
}
