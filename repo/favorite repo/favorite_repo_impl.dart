import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/Favorite%20repo/Favorite_repo.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:dartz/dartz.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final ApiService apiService;

  FavoriteRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Map>> deleteFavorite(ProductModel productModel) async {
    final result = await apiService.post(
      url: AppLinks.deleteFavoriteLink,
      data: {
        "products_id": productModel.productsId,
      },
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        if (response["status"] == "failure") {
          return left(ServerFailure(response["message"]));
        } else {
          deleteFavoriteLocally(productModel);
          return right(response);
        }
      },
    );
  }

  @override
  Future<Either<Failure, Map>> addFavorite(ProductModel productModel) async {
    final result = await apiService.post(
      url: AppLinks.addFavoriteLink,
      data: {
        "products_id": productModel.productsId,
      },
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        if (response["status"] == "failure") {
          return left(ServerFailure(response["message"]));
        } else {
          addFavoriteLocally(productModel);
          return right(response);
        }
      },
    );
  }

  void deleteFavoriteLocally(ProductModel productModel) {
    if (favoritesMap.containsKey("products")) {
      (favoritesMap["products"] as List<ProductModel>).remove(productModel);
    }
  }

  void addFavoriteLocally(ProductModel productModel) {
    favoritesMap.containsKey("products")
        ? (favoritesMap["products"] as List<ProductModel>).add(productModel)
        : null;
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFavorite(
      bool isWantedMore) async {
    if (isWantedMore) {
      final result = await apiService.post(
        url: AppLinks.getFavoriteLink,
        data: {
          "request_number": favoritesMap["requestNumber"] ?? 0,
        },
      );
      return result.fold(
        (failure) {
          return left(failure);
        },
        (response) {
          final favorites = (response["data"] as List).map((product) {
            product["favorite"] = 1;
            return ProductModel.fromJson(product);
          }).toList();
          setFavoriteFromApi(favorites);
          return right(favoritesMap["products"]);
        },
      );
    }
    return right(favoritesMap["products"]);
  }

  void setFavoriteFromApi(List<ProductModel> products) {
    if (favoritesMap.isNotEmpty) {
      if (favoritesMap.containsKey("requestNumber")) {
        (favoritesMap["products"] as List<ProductModel>).addAll(products);
        favoritesMap["requestNumber"]++;
      } else {
        favoritesMap = {
          "products": products,
          "requestNumber": 0,
        };
      }
    } else {
      favoritesMap = {
        "products": products,
        "requestNumber": 1,
      };
    }
  }
}
