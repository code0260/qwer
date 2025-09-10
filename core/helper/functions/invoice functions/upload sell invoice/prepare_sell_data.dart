import 'dart:convert';

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/get_discount_percentage.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_clients.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_currencies.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_product_place_details_for_sell.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_sell_transaction.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

Future<String> prepareSellData(InvoiceModel invoiceModel) async {
  Map data = {
    "invoices": {},
    "invoices_items": [],
    "product_place_details": [],
    "offers": [/** list of int offers_id */]
  };
  // await prepareClientId(invoiceModel);
  int? newClientId = await syncOfflineClients(invoiceModel);
  if (newClientId != null) {
    invoiceModel = invoiceModel.copyWith(invoicesClientId: newClientId);
  }
  syncOfflineBusinessCurrency();
  var discountPercentage = getDiscountPercentage(invoiceModel);

  for (final sellItemModel in cartSellHome) {
    // sending data to subtract the total amount
    List<double> countForEach = [];
    if (sellItemModel.getProductModel.productModel.productsType ==
        ProductType.product.name) {
      List<Map<dynamic, dynamic>> productPlaceDetails =
          prepareProductPlaceDetailsForSell(sellItemModel, countForEach);
      data["product_place_details"].addAll(productPlaceDetails);
    }

    var totalProduct = ((sellItemModel.editedPriceModel.pricesUnitPrice ??
            sellItemModel.getProductModel.chosenPriceModel.pricesUnitPrice!) *
        sellItemModel.productCount *
        (sellItemModel.productConversion ?? 1));
    Map item = InvoiceItemsModel(
            invoicesItemsCountForEachPlace: countForEach
                .toList()
                .toString()
                .replaceAll(']', "")
                .replaceAll('[', "")
                .replaceAll(' ', ""),
            invoicesItemsProductPlaces: sellItemModel.chosenPlaceModels
                .map(
                  (e) => e.productPlaceModel.productPlacesId,
                )
                .toList()
                .toString()
                .replaceAll(']', "")
                .replaceAll('[', "")
                .replaceAll(' ', ""),
            invoicesItemsProductsId:
                sellItemModel.getProductModel.productModel.productsId,
            invoicesItemsCountUnitId: sellItemModel.productCountUnitId ??
                sellItemModel.getProductModel.productModel.productsBaseUnitId,
            invoicesItemsProductsCount: sellItemModel.productCount,
            invoicesItemsTotalProductPrice: totalProduct
                .roundToNearest(currencies
                    .firstWhere((element) =>
                        element.businessCurrencyId == sellItemModel.currencyId)
                    .businessCurrencyNearFactor!)
                .toString(),
            invoicesItemsTaxAmount:
                calculateProductTaxAmount(sellItemModel.taxes, totalProduct),
            invoicesItemsInvoices: 0,
            invoicesItemsDiscount: totalProduct * (discountPercentage / 100),
            invoicesItemsPricesId:
                sellItemModel.editedPriceModel.pricesUnitPrice != null
                    ? 0
                    : sellItemModel.getProductModel.chosenPriceModel.pricesId)
        .toServerMap();
    item['price_data'] = sellItemModel.editedPriceModel.toMap();
    data["invoices_items"].add(item);
  }
  data["invoices"] = invoiceModel.toJson();
  //offer:
  for (final offer in appliedOffers) {
    data["offers"].add(offer.offersId!);
  }
  data["transaction_data"] = prepareSellTransaction(invoiceModel).toMap();

  return jsonEncode(data);
}
