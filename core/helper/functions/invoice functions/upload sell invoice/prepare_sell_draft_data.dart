import 'dart:convert';

import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_clients.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_currencies.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_products.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_units.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_sell_transaction.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

Future<String> prepareSellDraftData(InvoiceModel invoiceModel) async {
  Map data = {
    "invoices": {},
    //"offers": [/** list of int offers_id */]
  };

  await syncOfflineBusinessCurrency();
  await syncOfflineUnits();
  await syncOfflineProducts();
  // Synchronize the client ID
  int? newClientId = await syncOfflineClients(invoiceModel);
  if (newClientId != null) {
    invoiceModel = invoiceModel.copyWith(invoicesClientId: newClientId);
  }

  // Fetch sell item models and assign to data
  final sellItemsResult =
      await StoreInvoices.fetchSellItemsFromLocal(invoiceModel.invoicesId!);
  sellItemsResult.fold(
    (failure) {
      throw Exception("خطأ في تحميل تفاصيل الفاتورة: ${failure.errMessage}");
    },
    (sellItems) {
      cartSellHome = sellItems;
      data["sell_item_models"] = sellItems.map((item) => item.toMap()).toList();
    },
  );

  // Prepare other invoice data
  data["invoices"] = invoiceModel.toJson();

  // Optional: Add applied offers (if implemented)
  // data["offers"] = appliedOffers.map((offer) => offer.offersId!).toList();

  // Prepare transaction data
  data["transaction_data"] = prepareSellTransaction(invoiceModel).toMap();

  return jsonEncode(data);
}
