import 'dart:convert';

import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/get_discount_percentage.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/get_shipping_cost_per_unit.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_clients.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_currencies.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20buy%20invoice/prepare_buy_shipping_transaction.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20buy%20invoice/prepare_buy_transaction.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_model.dart';

Future<String> prepareBuyData(InvoiceModel invoiceModel) async {
  Map data = {
    "invoices": {},
    "invoices_items": [],
    "batches": [],
    "places": []
  };
  // await prepareClientId(invoiceModel);
  int? newClientId = await syncOfflineClients(invoiceModel);
  if (newClientId != null) {
    invoiceModel = invoiceModel.copyWith(invoicesClientId: newClientId);
  }
  syncOfflineBusinessCurrency();

  var shippingCostPerUnit2 = getShippingCostPerUnit(invoiceModel);
  var discountPercentage = getDiscountPercentage(invoiceModel);

  for (final entry in cartBuyHome) {
    entry.batchModel.batchesImportersId = invoiceModel.invoicesClientId;
    var totalProduct = (entry.batchModel.batchesProductsBuyPrice! *
            entry.batchModel.batchesProductsTotalCount! *
            (entry.batchModel.unitsConversionFactor ?? 1))
        .roundToNearest(currencies
            .firstWhere((element) =>
                element.businessCurrencyId ==
                entry.batchModel.batchesProductsCurrencyId)
            .businessCurrencyNearFactor!);
    Map item = InvoiceItemsModel(
      invoicesItemsProductsId: entry.productModel.productsId,
      invoicesItemsProductsCount: entry.batchModel.batchesProductsTotalCount,
      invoicesItemsTotalProductPrice: totalProduct.toString(),
      invoicesItemsTaxAmount:
          calculateProductTaxAmount(entry.taxes, totalProduct),
      invoicesItemsCountUnitId: entry.batchModel.batchesCountUnitId,
      invoicesItemsInvoices: 0,
      invoicesItemsPricesId: entry.batchModel.batchesProductsPricesId,
      invoicesItemsDiscount: totalProduct * (discountPercentage / 100),
    ).toServerMap();
    Map place = ProductPlaceModel(
            productPlacesProductsId: entry.productModel.productsId!,
            productPlacesCount: entry.batchModel.batchesProductsTotalCount!,
            productPlacesCountUnitId: entry.batchModel.batchesCountUnitId!,
            productPlacesBatchesId: 0, // will be given in the server side
            productPlacesPlacesId: entry.placeModel.placesId!)
        .toJson();

    entry.batchModel.batchesProductUnitCost =
        entry.batchModel.batchesProductsBuyPrice! +
            shippingCostPerUnit2 -
            (totalProduct * (discountPercentage / 100));
    data["places"].add(place);
    data["invoices_items"].add(item);
    data["batches"].add(entry.batchModel.toServerMap());
  }
  data["invoices"] = invoiceModel.toJson();
  data["transaction_data"] = prepareBuyTransaction(invoiceModel).toMap();
  data["transaction_shipping_data"] =
      prepareBuyShippingTransaction(invoiceModel)?.toMap();
  return jsonEncode(data);
}
