import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/store%20buy%20invoice/insert_debt.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/store%20buy%20invoice/insert_local_invoice.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/store%20buy%20invoice/prepare_debt.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/store%20buy%20invoice/prepare_invoice.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/core/helper/functions/prices%20functions/translate_prices_partner.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
import 'package:almonazim/data/model/batch_model.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/invoice%20models/all_invoices_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_model.dart';
import 'package:almonazim/data/model/price%20models/price_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:almonazim/data/model/product%20models/get_product_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StoreInvoices {
  StoreInvoices._();

  // Search for invoices by invoice number or other criteria
  static Future<Either<Failure, List<InvoiceModel>>> searchInvoicesByNumber(
      String query) async {
    final result = await DatabaseHelper.query(
      "my_invoices",
      where: "invoices_number = ?", // Search by invoice number
      whereArgs: [query], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<InvoiceModel> searchResults =
            response.map((data) => InvoiceModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

  // Get all invoices
  static Future<Either<Failure, InvoiceModel>> getInvoiceById(int id) async {
    final result = await DatabaseHelper.query("my_invoices",
        where: "invoices_id = ?", whereArgs: [id]);

    return result.fold(
      (failure) => left(failure),
      (response) {
        InvoiceModel model = InvoiceModel.fromJson(response[0]);
        return right(model);
      },
    );
  }

// Get all invoices
  static Future<Either<Failure, InvoiceModel>> getInvoiceForEditById(
      int id) async {
    final result = await DatabaseHelper.rawQuery('''SELECT 
        invoices_number,
        invoices_id,
        invoices_notes,
        invoices_type,
        clients_name,
        invoices_client_id,
        invoices_partner_id,
        partners_name 
        FROM my_invoices WHERE invoices_id = ? ''', [id]);

    return result.fold(
      (failure) => left(failure),
      (response) {
        InvoiceModel model = InvoiceModel.fromJson(response[0]);
        return right(model);
      },
    );
  }

  // Get all invoices
  static Future<Either<Failure, List<InvoiceModel>>> getInvoices(
      String invoiceType) async {
    final result = await DatabaseHelper.query("my_invoices",
        where: "invoices_type = ? ORDER BY invoices_number",
        whereArgs: [invoiceType]);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<InvoiceModel> gotResults =
            response.map((data) => InvoiceModel.fromJson(data)).toList();
        return right(gotResults);
      },
    );
  }

  // Insert a new invoice
  static Future<Either<Failure, int>> insertInvoice(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("invoices", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all invoices
  static Future<Either<Failure, int>> deleteAllInvoices() async {
    final result = await DatabaseHelper.delete("invoices");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete invoice and related debts and batches in a transaction
  static Future<Either<Failure, void>> deleteInvoice(int invoiceId) async {
    final result = await DatabaseHelper.delete(
      "invoices",
      where: "invoices_id = ?",
      whereArgs: [invoiceId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  static Future<Either<Failure, AllInvoicesItemsModel>> getBuyLocalInvoiceItems(
      int invoiceId) async {
    try {
      // Begin database transaction
      final database = DatabaseHelper.db;

      // Query the main invoice details from the `invoices` table
      final invoiceResult = await database.query(
        "my_invoices",
        where: "invoices_id = ?",
        whereArgs: [invoiceId],
      );

      if (invoiceResult.isEmpty) {
        return left(LocalDatabaseFailure("الفاتورة غير موجودة"));
      }

      // Build the InvoiceModel from the fetched data
      final invoiceModel = InvoiceModel.fromJson(invoiceResult.first);

      // Query related items by joining `products`, `batches`, `units`, and `invoices`
      final itemsResult = await database.rawQuery('''
      SELECT 
        p.products_name,
        p.products_id,
        up.units_conversion_factor as units_base_conversion,
        b.batches_products_total_count AS invoices_items_products_count,
        u.units_name,
        u.units_symbol,
        u.units_conversion_factor,
        b.batches_products_buy_price AS unit_price
      FROM batches AS b
      INNER JOIN products AS p ON p.products_id = b.batches_products_id
      INNER JOIN units AS u ON u.units_id = b.batches_count_unit_id
      INNER JOIN units AS up ON up.units_id = p.products_base_unit_id
      WHERE b.batches_invoices_id = ?
    ''', [invoiceId]);

      // Convert the query result into a list of InvoiceItemsModel
      List<InvoiceItemsModel> items = [];
      for (final item in itemsResult) {
        // tax
        final taxes = await database.query(
          "product_taxes_view",
          where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'buy' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
          whereArgs: [item['products_id']],
        );
        var conversion = ((receiveDouble(item['units_conversion_factor'])!) /
            receiveDouble(item['units_base_conversion'])!);
        double total = conversion *
            receiveDouble(item['unit_price'])! *
            receiveDouble(item['invoices_items_products_count'])!;
        items.add(InvoiceItemsModel(
          invoicesItemsTaxAmount: calculateProductTaxAmount(
              taxes
                  .map(
                    (e) => ProductTaxModel.fromJson(e),
                  )
                  .toList(),
              total),
          productsName: item['products_name'] as String?,
          invoicesItemsProductsCount:
              (item['invoices_items_products_count'] as num?)?.toDouble(),
          invoicesItemsTotalProductPrice: total.toString(),
          unitsName: item['units_name'] as String?,
          unitsSymbol: item['units_symbol'] as String?,
          unitsConversionFactor: receiveDouble(item['units_conversion_factor']),
          unitPrice: receiveDouble(item['unit_price'])! * conversion,
        ));
      }
      // Return the combined result
      AllInvoicesItemsModel model = AllInvoicesItemsModel(
          originalInvoiceItems: GetInvoicesItemsModel(
            invoiceModel: invoiceModel,
            items: items,
            offersDescriptions: null, // Empty list as specified
          ),
          refundItems: []);

      return right(model);
    } catch (e) {
      return left(
          LocalDatabaseFailure("خطأ تحميل تفاصيل الفاتورة: ${e.toString()}"));
    }
  }

  static Future<Either<Failure, AllInvoicesItemsModel>>
      getSellLocalInvoiceItems(int invoiceId) async {
    try {
      // Begin database transaction
      final database = DatabaseHelper.db;

      // Query the main invoice details from the `invoices` table
      final invoiceResult = await database.query(
        "my_invoices",
        where: "invoices_id = ?",
        whereArgs: [invoiceId],
      );

      if (invoiceResult.isEmpty) {
        return left(LocalDatabaseFailure("الفاتورة غير موجودة"));
      }

      // Build the InvoiceModel from the fetched data
      final invoiceModel = InvoiceModel.fromJson(invoiceResult.first);

      // Query related items by joining `sell_item`, `products`, `places`, and `units`
      final itemsResult = await database.rawQuery('''
      SELECT 
        p.products_name,
        ub.units_conversion_factor as units_base_conversion,
        pr.prices_unit_price as unit_price,
        si.sell_item_product_count AS invoices_items_products_count,
        si.sell_item_product_tax_amount as invoices_items_tax_amount,
        si.sell_item_edited_price as unit_edited_price,
        u.units_name,
        u.units_symbol,
        u.units_conversion_factor
      FROM sell_item AS si
      INNER JOIN products AS p ON p.products_id = si.sell_item_products_id
      LEFT JOIN prices AS pr ON pr.prices_id = si.sell_item_prices_id
      INNER JOIN units AS u ON u.units_id = si.sell_item_product_count_unit_id
      INNER JOIN units AS ub ON ub.units_id = p.products_base_unit_id
      WHERE si.sell_item_invoices_id = ?
    ''', [invoiceId]);

      // Convert the query result into a list of InvoiceItemsModel
      final items = itemsResult.map((item) {
        double unitPrice = ((item['unit_edited_price'] as String?) ??
                (item['unit_price'] as String))
            .toDouble();
        var conversion = (receiveDouble(item['units_conversion_factor'])! /
            receiveDouble(item['units_base_conversion'])!);
        double total = conversion *
            unitPrice *
            (item['invoices_items_products_count'] as num).toDouble();
        return InvoiceItemsModel(
            productsName: item['products_name'] as String?,
            invoicesItemsProductsCount:
                (item['invoices_items_products_count'] as num?)?.toDouble(),
            invoicesItemsTotalProductPrice: total.toString(),
            unitsName: item['units_name'] as String?,
            unitsSymbol: item['units_symbol'] as String?,
            unitsConversionFactor:
                receiveDouble(item['units_conversion_factor']),
            unitPrice: unitPrice * conversion,
            invoicesItemsTaxAmount:
                item['invoices_items_tax_amount'] as double?);
      }).toList();

      // Return the combined result
      AllInvoicesItemsModel model = AllInvoicesItemsModel(
        originalInvoiceItems: GetInvoicesItemsModel(
          invoiceModel: invoiceModel,
          items: items,
          offersDescriptions: null, // Empty list as specified
        ),
        refundItems: [],
      );

      return right(model);
    } catch (e) {
      return left(
          LocalDatabaseFailure("خطأ تحميل تفاصيل الفاتورة: ${e.toString()}"));
    }
  }

  // Function to store an invoice locally with optional debt creation
  static Future<Either<Failure, int>> storeBuyInvoiceLocally(
      InvoiceModel invoiceModel) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        // Prepare and insert the invoice
        var invoiceToInsert = prepareInvoice(invoiceModel);
        dynamic invoiceId = await insertLocalInvoice(txn, invoiceToInsert);
        if (invoiceId is String) {
          return right(invoiceId.toInt());
        }
        // Insert debt if there is a due date
        if (invoiceModel.invoicesPaymentStatus != "paid") {
          var debtModel = prepareDebt(invoiceModel, invoiceId);
          await insertDebt(txn, debtModel);
        }

        // Inserting BuyItemModels
        for (final item in cartBuyHome) {
          // batch
          //& insert for use in search:
          txn.delete("batches",
              where: "batches_invoices_id IS NULL AND batches_products_id = ? ",
              whereArgs: [item.batchModel.batchesProductsId!]);
          item.batchModel.batchesImportersId = invoiceModel.invoicesClientId!;
          item.batchModel.batchesActive = 1;
          item.batchModel.batchesProductsRemainingCount =
              item.batchModel.batchesProductsTotalCount;
          item.batchModel.placeId = item.placeModel.placesId!;
          var firstBatch = item.batchModel.toJson();
          firstBatch.remove('batches_id');
          txn.insert("batches", firstBatch);
          item.batchModel.batchesInvoicesId = invoiceId;
          var secondBatch = item.batchModel.toJson();
          secondBatch.remove('batches_id');
          txn.insert("batches", secondBatch);
          // place
          txn.insert("places", item.placeModel.toMap(),
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
        await StoreInvoiceNumber.setLatestInvoiceNumber(
            invoiceModel.invoicesType!,
            StoreInvoiceNumber.getAfterLatestInvoiceNumber(
                invoiceModel.invoicesType!));
        return right(invoiceId);
      });
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  // Function to store an invoice locally with optional debt creation
  static Future<Either<Failure, int>> editBuyInvoiceLocally(
      InvoiceModel invoiceModel) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        // Prepare and insert the invoice
        txn.delete("invoices",
            where: "invoices_id = ?", whereArgs: [invoiceModel.invoicesId!]);

        var invoiceToInsert = prepareInvoice(invoiceModel);
        dynamic invoiceId = await insertLocalInvoice(txn, invoiceToInsert);
        if (invoiceId is String) {
          return right(invoiceId.toInt());
        }

        // Insert debt if there is a due date
        if (invoiceModel.invoicesPaymentStatus != "paid") {
          var debtModel = prepareDebt(invoiceModel, invoiceId);
          await insertDebt(txn, debtModel);
        }

        // Inserting BuyItemModels
        for (final item in cartBuyHome) {
          //& insert for use in search:
          txn.delete("batches",
              where: "batches_invoices_id IS NULL AND batches_products_id = ? ",
              whereArgs: [item.batchModel.batchesProductsId!]);
          item.batchModel.batchesImportersId = invoiceModel.invoicesClientId!;
          item.batchModel.placeId = item.placeModel.placesId!;
          item.batchModel.batchesActive = 1;
          item.batchModel.batchesProductsRemainingCount =
              item.batchModel.batchesProductsTotalCount;
          var firstBatch = item.batchModel.toJson();
          firstBatch.remove('batches_id');
          firstBatch.remove('batches_invoices_id');
          txn.insert("batches", firstBatch);
          item.batchModel.batchesInvoicesId = invoiceId;
          var secondBatch = item.batchModel.toJson();
          secondBatch.remove('batches_id');
          txn.insert("batches", secondBatch);
          //? no need to insert the product, when you want it you can get it from the batches table (batches_products_id)
          // place
          txn.insert("places", item.placeModel.toMap(),
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
        return right(invoiceId);
      });
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

// Function to store an invoice locally with optional debt creation
  static Future<Either<Failure, int>> storeSellInvoiceLocally(
      InvoiceModel invoiceModel) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        // Prepare and insert the invoice
        var invoiceToInsert = prepareInvoice(invoiceModel);
        dynamic invoiceId = await insertLocalInvoice(txn, invoiceToInsert);
        if (invoiceId is String) {
          return right(invoiceId.toInt());
        }

        // Insert debt if there is a due date
        if (invoiceModel.invoicesPaymentStatus != "paid") {
          var debtModel = prepareDebt(invoiceModel, invoiceId);
          await insertDebt(txn, debtModel);
        }

        //! Inserting SellItemModels
        for (final sellItemModel in cartSellHome) {
          // dealing with first sell price
          int priceId =
              sellItemModel.getProductModel.chosenPriceModel.pricesId ?? 0;
          priceId = await insertNewPriceLocally(sellItemModel, txn, priceId);
          var total = ((sellItemModel.editedPriceModel.pricesUnitPrice ??
                  sellItemModel
                      .getProductModel.chosenPriceModel.pricesUnitPrice!) *
              sellItemModel.productCount *
              (sellItemModel.productConversion ?? 1));
          txn.insert("sell_item", {
            'sell_item_prices_id': priceId,
            'sell_item_invoices_id': invoiceId,
            'sell_item_product_count': sellItemModel.productCount,
            'sell_item_product_count_unit_id': sellItemModel
                    .productCountUnitId ??
                sellItemModel.getProductModel.productModel.productsBaseUnitId!,
            'sell_item_product_conversion':
                sellItemModel.productConversion ?? 1,
            'sell_item_products_id':
                sellItemModel.getProductModel.productModel.productsId!,
            'sell_item_edited_price':
                sellItemModel.editedPriceModel.pricesUnitPrice,
            'sell_item_edited_price_partner_en':
                sellItemModel.editedPriceModel.pricesPartnerEn,
            'sell_item_currency_id': sellItemModel.currencyId ??
                sellItemModel
                    .getProductModel.chosenPriceModel.pricesAmountCurrencyId,
            'sell_item_places_id': sellItemModel.chosenPlaceModels[0].placeModel
                .placesId, // in offline there is only one place
            'sell_item_product_tax_amount':
                calculateProductTaxAmount(sellItemModel.taxes, total)
          });
          if (sellItemModel.chosenPlaceModels[0].placeModel.placesId != null) {
            // place
            txn.insert(
                "places", sellItemModel.chosenPlaceModels[0].placeModel.toMap(),
                conflictAlgorithm: ConflictAlgorithm.ignore);
          }
        }
        // throw Exception('test');
        await StoreInvoiceNumber.setLatestInvoiceNumber(
            invoiceModel.invoicesType!,
            StoreInvoiceNumber.getAfterLatestInvoiceNumber(
                invoiceModel.invoicesType!));
        return right(invoiceId);
      });
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<int> insertNewPriceLocally(
      SellItemModel sellItemModel, Transaction txn, int priceId) async {
    if (sellItemModel.editedPriceModel.pricesUnitPrice != null) {
      var latestPriceData = await txn.query('prices',
          where:
              "prices_type = 'sell' AND prices_products_id = ? AND prices_partner_en = ? AND prices_business_id = ? ORDER BY prices_createdAt LIMIT 1",
          whereArgs: [
            sellItemModel.getProductModel.productModel.productsId,
            sellItemModel.editedPriceModel.pricesPartnerEn,
            StoreUserModel.instance.businessId
          ]);
      if (latestPriceData.isNotEmpty &&
          convertAmountToBase(
                  receiveDouble(latestPriceData[0]['prices_unit_price'])!,
                  latestPriceData[0]['prices_amount_currency_id'] as int) ==
              convertAmountToBase(
                  sellItemModel.editedPriceModel.pricesUnitPrice!,
                  sellItemModel.currencyId!)) {
        priceId = latestPriceData[0]['prices_id'] as int;
      } else {
        PriceInputModel priceInputModel;
        if (latestPriceData.isNotEmpty) {
          priceInputModel = PriceInputModel(
              pricesAmountCurrencyId:
                  latestPriceData[0]['prices_amount_currency_id'] as int,
              pricesUnitPrice: convertAmount(
                  sellItemModel.editedPriceModel.pricesUnitPrice!,
                  sellItemModel.currencyId!,
                  latestPriceData[0]['prices_amount_currency_id'] as int),
              pricesProductsId:
                  sellItemModel.getProductModel.productModel.productsId,
              pricesType: "sell",
              pricesBusinessId: StoreUserModel.instance.businessId,
              pricesPartnerEn: sellItemModel.editedPriceModel.pricesPartnerEn,
              pricesPartnerAr: translateToArPricesPartnerFromString(
                  sellItemModel.editedPriceModel.pricesPartnerEn!),
              pricesOnline: 0);
        } else {
          priceInputModel = PriceInputModel(
              pricesAmountCurrencyId: sellItemModel.currencyId,
              pricesUnitPrice: sellItemModel.editedPriceModel.pricesUnitPrice,
              pricesProductsId:
                  sellItemModel.getProductModel.productModel.productsId,
              pricesType: "sell",
              pricesBusinessId: StoreUserModel.instance.businessId,
              pricesPartnerEn:
                  sellItemModel.editedPriceModel.pricesPartnerEn ?? 'price1',
              pricesPartnerAr: translateToArPricesPartnerFromString(
                  sellItemModel.editedPriceModel.pricesPartnerEn ?? 'price1'),
              pricesOnline: 0);
        }
        priceId = await txn.insert('prices', priceInputModel.toMap());
      }
    }
    return priceId;
  }

// Function to store an invoice locally with optional debt creation
  static Future<Either<Failure, int>> editSellInvoiceLocally(
      InvoiceModel invoiceModel) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        // Prepare and insert the invoice
        txn.delete("invoices",
            where: "invoices_id = ?", whereArgs: [invoiceModel.invoicesId!]);
        // Prepare and insert the invoice
        var invoiceToInsert = prepareInvoice(invoiceModel);
        dynamic invoiceId = await insertLocalInvoice(txn, invoiceToInsert);
        if (invoiceId is String) {
          return right(invoiceId.toInt());
        }

        // Insert debt if there is a due date
        if (invoiceModel.invoicesPaymentStatus != "paid") {
          var debtModel = prepareDebt(invoiceModel, invoiceId);
          await insertDebt(txn, debtModel);
        }

        //! Inserting SellItemModels
        for (final item in cartSellHome) {
          int priceId = item.getProductModel.chosenPriceModel.pricesId ?? 0;
          priceId = await insertNewPriceLocally(item, txn, priceId);

          double total = (item.productConversion ?? 1) *
              item.productCount *
              (item.editedPriceModel.pricesUnitPrice ??
                  item.getProductModel.chosenPriceModel.pricesUnitPrice!);
          txn.insert("sell_item", {
            'sell_item_prices_id': priceId,
            'sell_item_invoices_id': invoiceId,
            'sell_item_product_count': item.productCount,
            'sell_item_product_count_unit_id': item.productCountUnitId ??
                item.getProductModel.productModel.productsBaseUnitId!,
            'sell_item_product_conversion': item.productConversion ?? 1,
            'sell_item_products_id':
                item.getProductModel.productModel.productsId!,
            'sell_item_edited_price': item.editedPriceModel.pricesUnitPrice,
            'sell_item_edited_price_partner_en':
                item.editedPriceModel.pricesPartnerEn,
            'sell_item_currency_id': item.currencyId ??
                item.getProductModel.chosenPriceModel.pricesAmountCurrencyId,
            'sell_item_places_id':
                item.chosenPlaceModels[0].placeModel.placesId!,
            'sell_item_product_tax_amount':
                calculateProductTaxAmount(item.taxes, total)
          });
          // place
          txn.insert("places", item.chosenPlaceModels[0].placeModel.toMap(),
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
        return right(invoiceId);
      });
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, List<BuyItemModel>>> fetchBuyItemsFromLocal(
      int invoiceId) async {
    try {
      // Query to join `batches`, `places`, and `products` tables based on invoiceId
      final List<Map<String, dynamic>> results =
          await DatabaseHelper.db.rawQuery('''
      SELECT 
      batches.*,
      places.*,
      products.*,
      ub.*,
      up.units_name as units_base_name,
      up.units_conversion_factor as units_base_conversion
      FROM batches
      INNER JOIN places ON batches.places_id = places.places_id
      INNER JOIN products ON batches.batches_products_id = products.products_id
      INNER JOIN units ub ON batches.batches_count_unit_id = ub.units_id
      INNER JOIN units up ON products.products_base_unit_id = up.units_id
      WHERE batches.batches_invoices_id = ?
    ''', [invoiceId]);

      // Map each result to a `BuyItemModel`
      List<BuyItemModel> buyItems = [];
      for (final result in results) {
        final taxes = await DatabaseHelper.db.query(
          "product_taxes_view",
          where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'buy' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
          whereArgs: [result['products_id']],
        );
        // Map to BuyItemModel
        var batchModel = BatchModel.fromJson(result);
        buyItems.add(BuyItemModel(
          taxes: taxes
              .map(
                (tax) => ProductTaxModel.fromJson(tax),
              )
              .toList(),
          batchModel: batchModel.copyWith(
              unitsConversionFactor: ((batchModel.unitsConversionFactor! /
                      receiveDouble(result['units_base_conversion'])!))
                  .roundToNearest(-3)),
          placeModel: PlaceModel.fromJson(result),
          productModel: ProductModel.fromJson(result),
        ));
      }
      if (buyItems.isEmpty) {
        throw Exception('لا يوجد أقلام');
      }
      cartBuyHome = buyItems;
      return right(buyItems);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, List<SellItemModel>>> fetchSellItemsFromLocal(
      int invoiceId) async {
    try {
      // Query to join necessary tables to retrieve sell item data
      final List<Map<String, dynamic>> results =
          await DatabaseHelper.db.rawQuery('''
      SELECT 
        products.*,
        pr.*,
        up.units_name as units_base_name,
        up.units_conversion_factor as units_base_conversion,
        places.*,
        sell_item.sell_item_product_count AS product_count,
        sell_item.sell_item_product_count_unit_id AS product_count_unit_id,
        sell_item.sell_item_product_conversion AS product_conversion,
        sell_item.sell_item_edited_price AS edited_prices_unit_price,
        sell_item.sell_item_edited_price_partner_en AS edited_prices_partner_en,
        sell_item.sell_item_currency_id AS currency_id,
        sell_item.sell_item_id AS sell_item_id,
        sell_item.sell_item_product_tax_amount AS sell_item_product_tax_amount

      FROM sell_item
      INNER JOIN products ON sell_item.sell_item_products_id = products.products_id
      INNER JOIN units up ON products.products_base_unit_id = up.units_id
      LEFT JOIN prices pr ON pr.prices_id = sell_item.sell_item_prices_id
      LEFT JOIN places ON sell_item.sell_item_places_id = places.places_id
      WHERE sell_item.sell_item_invoices_id = ?
    ''', [invoiceId]);

      // Grouping by `products_id` to aggregate places and offers
      Map<int, List<Map<String, dynamic>>> groupedResults = {};
      for (var result in results) {
        int productId = result['products_id'] as int;
        if (!groupedResults.containsKey(productId)) {
          groupedResults[productId] = [];
        }
        groupedResults[productId]!.add(result);
      }

      // Map grouped results to `SellItemModel`
      List<SellItemModel> sellItems = [];
      for (final entry in groupedResults.entries) {
        // Extract places and offers for the product
        // List<ProductPlaceDetailsModel> places = entry.value.map((row) {
        //   return ProductPlaceDetailsModel(
        //     batchModel: BatchModel.fromJson(row),
        //     placeModel: PlaceModel.fromJson(row),
        //     productPlaceModel: ProductPlaceModel.fromJson(row),
        //   );
        // }).toList();
        List<ProductPlaceDetailsModel> places = entry.value.map((row) {
          return ProductPlaceDetailsModel(
            batchModel: BatchModel(),
            placeModel: PlaceModel.fromJson(row),
            productPlaceModel: ProductPlaceModel(),
          );
        }).toList();
        final taxes = await DatabaseHelper.db.query(
          "product_taxes_view",
          where: ''' product_taxes_product_id = ? AND taxes_is_active = 1
            AND (product_taxes_application_level = 'sell' OR product_taxes_application_level = 'both')
            ORDER BY product_taxes_order ASC
          ''',
          whereArgs: [entry.value.first['products_id']],
        );
        final prices = await DatabaseHelper.db.rawQuery('''
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
        ''', [entry.value.first['products_id']]);
        // Map to SellItemModel
        sellItems.add(SellItemModel(
          taxAmount: entry.value.first["sell_item_product_tax_amount"],
          taxes: taxes
              .map(
                (tax) => ProductTaxModel.fromJson(tax),
              )
              .toList(),
          getProductModel: GetProductModel(
              productModel: ProductModel.fromJson(entry.value.first),
              prices: prices.map((e) => PriceModel.fromJson(e)).toList(),
              chosenPriceModel: PriceModel.fromJson(entry.value.first)),
          places: places,
          chosenPlaceModels: [places.first], //! this is not being done
          offers: null, // Offers can be added with additional queries if needed
          productCount: (entry.value.first['product_count'] as num).toDouble(),
          productCountUnitId:
              entry.value.first['product_count_unit_id'] as int?,
          currencyId: entry.value.first['currency_id'] as int?,
          editedPriceModel: PriceInputModel(
            pricesUnitPrice:
                receiveDouble(entry.value.first['edited_prices_unit_price']),
            pricesPartnerEn: entry.value.first['edited_prices_partner_en'],
          ),
          productConversion:
              receiveDouble(entry.value.first['product_conversion']),
        ));
      }
      if (sellItems.isEmpty) {
        throw Exception('لا يوجد أقلام');
      }
      return right(sellItems);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}
