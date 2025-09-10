import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:dartz/dartz.dart';

abstract class SearchProductRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts(
      ProductInputModel productInputModel);

  Future<Either<Failure, List<BuyItemModel>>> getBuyProductsBySearch(
      String searchQuery);
  Future<Either<Failure, List<BuyItemModel>>> getBuyEditProductsBySearch(
      String searchQuery);
  Future<Either<Failure, List<BuyItemModel>>> getBuyBarcodeBySearch(
      String barcode);

  Future<Either<Failure, List<SellItemModel>>> getSellBarcodeBySearch(
      String barcode);
  Future<Either<Failure, List<SellItemModel>>> getSellEditProductsBySearch(
      String searchQuery);
  Future<Either<Failure, List<BuyItemModel>>> getRBCNIProductsBySearch(
      String searchQuery);
  Future<Either<Failure, List<SellItemModel>>> getSellProductsBySearch(
      String searchQuery);
  Future<Either<Failure, List<SellItemModel>>> getRSCNIProductsBySearch(
      String? searchQuery, String? barcode);
  Future<Either<Failure, List<InventoryAdjustmentDataModel>>>
      getInventoryAdjustmentProductsBySearch(String searchQuery);
  Future<Either<Failure, List<InventoryAdjustmentDataModel>>>
      getInventoryAdjustmentBarcodeProductsBySearch(String barcode);
}
