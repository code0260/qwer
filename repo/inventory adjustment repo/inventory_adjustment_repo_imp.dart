import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20adjustment%20repo/inventory_adjustment_repo.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/get_inventory_adjustment_input_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/get_inventory_adjustment_items_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_all_data_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_model.dart';
import 'package:dartz/dartz.dart';

class InventoryAdjustmentRepoImpl implements InventoryAdjustmentRepo {
  ApiService apiService;
  InventoryAdjustmentRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GetInventoryAdjustmentItemModel>>
      getInventoryAdjustmentItems(int inventoryAdjustment) async {
    var result = await apiService.post(
        url: AppLinks.getInventoryAdjustmentsItemsLink,
        data: {"inventory_adjustment_id": inventoryAdjustment});

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(GetInventoryAdjustmentItemModel.fromJson(response["data"]));
    });
  }

  @override
  Future<Either<Failure, List<InventoryAdjustmentModel>>>
      getInventoryAdjustment(
          GetInventoryAdjustmentInputModel
              getInventoryAdjustmentInputModel) async {
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getInventoryAdjustmentsLink,
        data: getInventoryAdjustmentInputModel.toJson());
    return result.fold(
      (failure) => left(failure),
      (response) {
        List<InventoryAdjustmentModel> adjustments = [];
        for (final i in response['data']) {
          adjustments.add(InventoryAdjustmentModel.fromJson(i));
        }
        return right(adjustments);
      },
    );
  }

  @override
  Future<Either<Failure, List<InventoryAdjustmentModel>>>
      getInventoryAdjustmentByNumber(String inventoryAdjustmentNumber) async {
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getInventoryAdjustmentsByNumberLink,
        data: {"inventory_adjustment_number": inventoryAdjustmentNumber});
    return result.fold(
      (failure) => left(failure),
      (response) {
        List<InventoryAdjustmentModel> adjustments = [];
        for (final i in response['data']) {
          adjustments.add(InventoryAdjustmentModel.fromJson(i));
        }
        return right(adjustments);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addInventoryAdjustment(
      InventoryAdjustmentAllDataModel inventoryAdjustmentAllDataModel) async {
    var result = await apiService.post(
        url: AppLinks.addInventoryAdjustmentLink,
        formDataIsEnabled: false,
        data: inventoryAdjustmentAllDataModel.toJson());
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
