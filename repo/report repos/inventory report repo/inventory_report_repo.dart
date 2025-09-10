import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/inventory%20report%20models/product%20profit%20models/get_product_inventory_model.dart';
import 'package:dartz/dartz.dart';

abstract class InventoryReportRepo {
  Future<Either<Failure, List<int>>> getProductInventory(
      GetProductInventoryModel getProductInventoryModel);
}
