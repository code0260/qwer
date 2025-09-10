import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20repo/inventory_repo.dart';
import 'package:almonazim/data/model/inventory%20models/stock_input_model.dart';
import 'package:almonazim/data/model/inventory%20models/stock_model.dart';
import 'package:dartz/dartz.dart';

class InventoryRepoImpl implements InventoryRepo {
  ApiService apiService;
  InventoryRepoImpl(this.apiService);
  @override
  Future<Either<Failure, StockModel>> getInventoryInfo(
      int productsId, int buildingsId) async {
    Map<String, dynamic> data = {
      "buildings_id": buildingsId,
      "products_id": productsId,
    };
    data.removeWhere((key, value) => value == 0);
    var result = await apiService.post(
        url: AppLinks.getProductInventoryLink, data: data);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(StockModel.fromJson(response["data"]));
      },
    );
  }

  @override
  Future<Either<Failure, void>> editReorderPoint(
      StockInputModel stockInputModel) async {
    var result = await apiService.post(
        url: AppLinks.editReorderPointLink,
        formDataIsEnabled: false,
        data: stockInputModel.toMap());
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
