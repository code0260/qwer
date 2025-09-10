import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/inventory%20report%20repo/inventory_report_repo.dart';
import 'package:almonazim/data/model/inventory%20report%20models/product%20profit%20models/get_product_inventory_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InventoryReportRepoImpl implements InventoryReportRepo {
  final ApiService apiService;
  InventoryReportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<int>>> getProductInventory(
      GetProductInventoryModel getProductInventoryModel) async {
    // print(getProductInventoryModel.toMap());
    final result = await apiService.post(
        formDataIsEnabled: false,
        responseType: ResponseType.bytes,
        url: AppLinks.productInventoryLink,
        data: getProductInventoryModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) async {
        return right(response);
      },
    );
    // return left(ServerFailure('te'));
  }
}
