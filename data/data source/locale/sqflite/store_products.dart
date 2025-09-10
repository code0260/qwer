import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/data%20source/locale/store_default_building.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/batch_model.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_model.dart';
import 'package:almonazim/data/model/price%20models/price_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:almonazim/data/model/product%20models/get_product_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

class StoreProducts {
  StoreProducts._();

  static Future<Either<Failure, List<BuyItemModel>>> searchBuyProducts(
      String query) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        PlaceModel defaultPlaceModel = const PlaceModel();
        int? defaultBuildingId = StoreDefaultBuilding.getDefaultBuilding("buy");
        if (defaultBuildingId != null) {
          final resultPlace = await txn.query(
            "places",
            where: "places_buildings_id = ?",
            whereArgs: [defaultBuildingId],
          );
          defaultPlaceModel = PlaceModel.fromJson(resultPlace[0]);
        }

        var where = "products_name LIKE ? AND products_type = 'product' ";
        if (defaultPlaceModel.placesId != null) {
          where +=
              ' AND (places_id = ${defaultPlaceModel.placesId} OR places_id IS NULL)';
        } else {
          where += ' GROUP BY products_id';
        }
        final result = await txn.query(
          "my_buy_products",
          where: where,
          whereArgs: [
            '%$query%'
          ], // Parameterized argument to avoid SQL injection
        );

        for (final product in result) {
          final taxes = await txn.query(
            "product_taxes_view",
            where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'buy' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
            whereArgs: [product['products_id']],
          );
          BatchModel batchModel =
              BatchModel.fromJson(product).copyWith(unitsConversionFactor: 1);
          if (batchModel.batchesCountUnitId != null) {
            UnitModel batchUnitModel = getIt
                .get<UnitRepoImpl>()
                .completeUnitModel(
                    UnitModel(unitsId: batchModel.batchesCountUnitId));
            batchModel = batchModel.copyWith(
                unitsName: batchUnitModel.unitsName,
                unitsConversionFactor:
                    (batchUnitModel.unitsConversionFactor?.toDouble() ?? 1) /
                        (batchModel.unitsConversionFactor ?? 1),
                unitsSymbol: batchUnitModel.unitsSymbol);
          }
          searchBuyData.add(BuyItemModel(
              taxes: taxes
                  .map(
                    (tax) => ProductTaxModel.fromJson(tax),
                  )
                  .toList(),
              batchModel: batchModel,
              placeModel: defaultPlaceModel,
              productModel: ProductModel.fromJson(product).copyWith(
                  unitsBaseConversion:
                      receiveDouble(product['units_conversion_factor']))));
        }
        if (searchBuyData.isEmpty) {
          throw LocalDatabaseFailure("لا يوجد منتج بهذا الاسم");
        }
        return right(searchBuyData);
      });
    } catch (e) {
      if (e is LocalDatabaseFailure) {
        return left(LocalDatabaseFailure(e.errMessage));
      }
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, List<BuyItemModel>>> searchBuyBarcode(
      String barcode) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        final result = await txn.query(
          "my_buy_products",
          where: "products_barcode = ? AND products_type = 'product' ",
          whereArgs: [barcode], // Parameterized argument to avoid SQL injection
        );
        PlaceModel defaultPlaceModel = const PlaceModel();
        int? defaultBuildingId = StoreDefaultBuilding.getDefaultBuilding("buy");
        if (defaultBuildingId != null) {
          final resultPlace = await txn.query(
            "places",
            where: "places_buildings_id = ?",
            whereArgs: [defaultBuildingId],
          );
          defaultPlaceModel = PlaceModel.fromJson(resultPlace[0]);
        }
        List<BuyItemModel> items = [];

        for (final product in result) {
          final taxes = await txn.query(
            "product_taxes_view",
            where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'buy' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
            whereArgs: [product['products_id']],
          );
          BatchModel batchModel =
              BatchModel.fromJson(product).copyWith(unitsConversionFactor: 1);
          if (batchModel.batchesCountUnitId != null) {
            UnitModel batchUnitModel = getIt
                .get<UnitRepoImpl>()
                .completeUnitModel(
                    UnitModel(unitsId: batchModel.batchesCountUnitId));
            batchModel = batchModel.copyWith(
                unitsName: batchUnitModel.unitsName,
                unitsConversionFactor:
                    (batchUnitModel.unitsConversionFactor?.toDouble() ?? 1) /
                        (batchModel.unitsConversionFactor ?? 1),
                unitsSymbol: batchUnitModel.unitsSymbol);
          }
          items.add(BuyItemModel(
              taxes: taxes
                  .map(
                    (tax) => ProductTaxModel.fromJson(tax),
                  )
                  .toList(),
              batchModel: batchModel,
              placeModel: defaultPlaceModel,
              productModel: ProductModel.fromJson(product).copyWith(
                  unitsBaseConversion:
                      receiveDouble(product['units_conversion_factor']))));
        }
        if (items.isEmpty) {
          throw LocalDatabaseFailure("لا يوجد منتج بهذا الباركود");
        }
        return right(items);
      });
    } catch (e) {
      if (e is LocalDatabaseFailure) {
        return left(LocalDatabaseFailure(e.errMessage));
      }
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, List<SellItemModel>>> searchSellProducts(
      String query) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        // Query to find matching products based on the search query
        final result = await txn.query(
          "my_sell_products",
          where: "products_name LIKE ?",
          whereArgs: [
            '%$query%'
          ], // Parameterized argument to avoid SQL injection
        );

        PlaceModel defaultPlaceModel = const PlaceModel();
        int? defaultBuildingId =
            StoreDefaultBuilding.getDefaultBuilding("sell");

        // Fetch the default place if a building ID is available
        if (defaultBuildingId != null) {
          final resultPlace = await txn.query(
            "places",
            where: "places_buildings_id = ?",
            whereArgs: [defaultBuildingId],
          );
          if (resultPlace.isNotEmpty) {
            defaultPlaceModel = PlaceModel.fromJson(resultPlace[0]);
          }
        }

        // Build SellItemModel list with the fetched place and product data
        for (final product in result) {
          final taxes = await txn.query(
            "product_taxes_view",
            where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'sell' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
            whereArgs: [product['products_id']],
          );
          final prices = await txn.rawQuery('''
          SELECT pr.*
          FROM prices pr
          INNER JOIN (
              SELECT prices_products_id, prices_partner_en,
                    MAX(prices_createdAt) AS max_createdAt
              FROM prices
              WHERE prices_type = 'sell'
              GROUP BY prices_products_id, prices_partner_en
          ) latest_prices 
          ON pr.prices_products_id = latest_prices.prices_products_id
          AND pr.prices_partner_en = latest_prices.prices_partner_en
          AND pr.prices_createdAt = latest_prices.max_createdAt
          AND pr.prices_type = 'sell'
          WHERE pr.prices_products_id = ?
        ''', [product['products_id']]);
          GetProductModel getProductModel = GetProductModel(
              chosenPriceModel: prices.isNotEmpty
                  ? PriceModel.fromJson(prices[0])
                  : const PriceModel(),
              productModel: ProductModel.fromJson(product).copyWith(
                  unitsBaseConversion:
                      receiveDouble(product['units_conversion_factor'])),
              prices: prices
                  .map(
                    (price) => PriceModel.fromJson(price),
                  )
                  .toList());
          searchSellData.add(SellItemModel(
            editedPriceModel: PriceInputModel(),
            taxes: taxes
                .map(
                  (tax) => ProductTaxModel.fromJson(tax),
                )
                .toList(),
            offers: null,
            productCount: StoreCountInvoice.getCountInvoice().toDouble(),
            places: [],
            chosenPlaceModels: [
              ProductPlaceDetailsModel(
                //! no done
                placeModel: defaultPlaceModel,
                productPlaceModel: ProductPlaceModel(),
                batchModel: BatchModel(),
              )
            ],
            getProductModel: getProductModel,
          ));
        }
        if (searchSellData.isEmpty) {
          throw LocalDatabaseFailure("لا يوجد منتج بهذا الاسم");
        }
        return right(searchSellData);
      });
    } catch (e) {
      if (e is LocalDatabaseFailure) {
        return left(LocalDatabaseFailure(e.errMessage));
      }
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, List<SellItemModel>>> searchSellBarcode(
      String query) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        // Query to find matching products based on the search query
        final result = await txn.query(
          "my_sell_products",
          where: "products_barcode = ?",
          whereArgs: [query], // Parameterized argument to avoid SQL injection
        );

        PlaceModel defaultPlaceModel = const PlaceModel();
        int? defaultBuildingId =
            StoreDefaultBuilding.getDefaultBuilding("sell");

        // Fetch the default place if a building ID is available
        if (defaultBuildingId != null) {
          final resultPlace = await txn.query(
            "places",
            where: "places_buildings_id = ?",
            whereArgs: [defaultBuildingId],
          );
          if (resultPlace.isNotEmpty) {
            defaultPlaceModel = PlaceModel.fromJson(resultPlace[0]);
          }
        }
        List<SellItemModel> items = [];

        // Build SellItemModel list with the fetched place and product data
        for (final product in result) {
          final taxes = await txn.query(
            "product_taxes_view",
            where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'sell' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
            whereArgs: [product['products_id']],
          );
          final prices = await txn.rawQuery('''
            SELECT pr.*
            FROM prices pr
            INNER JOIN (
                SELECT prices_products_id, prices_partner_en,
                      MAX(prices_createdAt) AS max_createdAt
                FROM prices
                WHERE prices_type = 'sell'
                GROUP BY prices_products_id, prices_partner_en
            ) latest_prices 
            ON pr.prices_products_id = latest_prices.prices_products_id
            AND pr.prices_partner_en = latest_prices.prices_partner_en
            AND pr.prices_createdAt = latest_prices.max_createdAt
            AND pr.prices_type = 'sell'
            WHERE pr.prices_products_id = ?
          ''', [product['products_id']]);
          var productModel = ProductModel.fromJson(product);
          GetProductModel getProductModel = GetProductModel(
              chosenPriceModel: prices.isNotEmpty
                  ? PriceModel.fromJson(prices[0])
                  : const PriceModel(),
              productModel: productModel,
              prices: prices
                  .map(
                    (price) => PriceModel.fromJson(price),
                  )
                  .toList());
          items.add(SellItemModel(
            editedPriceModel: PriceInputModel(),
            taxes: taxes
                .map(
                  (tax) => ProductTaxModel.fromJson(tax),
                )
                .toList(),
            offers: null,
            productCount: 1,
            productCountUnitId: productModel.productsBaseUnitId,
            places: [],
            chosenPlaceModels: [
              ProductPlaceDetailsModel(
                //! not done
                placeModel: defaultPlaceModel,
                productPlaceModel: ProductPlaceModel(),
                batchModel: BatchModel(),
              )
            ],
            getProductModel: getProductModel,
          ));
        }
        if (items.isEmpty) {
          throw LocalDatabaseFailure("لا يوجد منتج بهذا الباركود");
        }
        return right(items);
      });
    } catch (e) {
      if (e is LocalDatabaseFailure) {
        return left(LocalDatabaseFailure(e.errMessage));
      }
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, int>> insertProduct(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("products", value,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }

  // updateUnitData
  static Future<Either<Failure, int>> updateProductData(
      Map<String, dynamic> unit) async {
    final result = await DatabaseHelper.updateOrInsertData("products", unit);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteAllProducts() async {
    final result = await DatabaseHelper.delete("products");
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }

  static Future<Either<Failure, int>> deleteProductsViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("products", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }

  static Future<Either<Failure, void>> updateProductId(
      int oldId, int newId) async {
    var result = await DatabaseHelper.update(
      "products",
      {"products_id": newId, "products_online": 1},
      where: "products_id = ?",
      whereArgs: [oldId],
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  static Future<Either<Failure, List<ProductModel>>>
      getOfflineProducts() async {
    final result = await DatabaseHelper.query(
      "products",
      where: "products_online = ?",
      whereArgs: [0],
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(
            response.map((data) => ProductModel.fromJson(data)).toList());
      },
    );
  }
}
