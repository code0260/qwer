import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_products.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_units.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20buy%20invoice/prepare_buy_data.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

Future<String> prepareBuyDraftData(InvoiceModel invoiceModel) async {
  await syncOfflineUnits();
  await syncOfflineProducts();
  var result =
      await StoreInvoices.fetchBuyItemsFromLocal(invoiceModel.invoicesId!);
  return result.fold(
    (failure) => throw Exception(failure.errMessage),
    (items) async {
      cartBuyHome = items;
      return await prepareBuyData(invoiceModel); // removing id and number
    },
  );
}
