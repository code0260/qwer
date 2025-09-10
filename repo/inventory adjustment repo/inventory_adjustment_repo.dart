import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/get_inventory_adjustment_input_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/get_inventory_adjustment_items_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_all_data_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_model.dart';
import 'package:dartz/dartz.dart';

abstract class InventoryAdjustmentRepo {
  Future<Either<Failure, List<InventoryAdjustmentModel>>>
      getInventoryAdjustment(
          GetInventoryAdjustmentInputModel getInventoryAdjustmentInputModel);
  Future<Either<Failure, List<InventoryAdjustmentModel>>>
      getInventoryAdjustmentByNumber(String inventoryAdjustmentNumber);

  Future<Either<Failure, GetInventoryAdjustmentItemModel>>
      getInventoryAdjustmentItems(int inventoryAdjustment);
  Future<Either<Failure, void>> addInventoryAdjustment(
      InventoryAdjustmentAllDataModel inventoryAdjustmentAllDataModel);
}
