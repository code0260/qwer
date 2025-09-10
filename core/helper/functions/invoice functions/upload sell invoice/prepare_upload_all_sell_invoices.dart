import 'dart:convert';

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_sell_draft_data.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

Future<String> prepareUploadAllSellInvoices() async {
  List<Map<String, dynamic>> data = [];
  List<InvoiceModel> allInvoices = [];
// Fetch sell item models and assign to data
  final invoicesResult = await StoreInvoices.getInvoices(InvoiceType.sell.name);
  invoicesResult.fold(
    (failure) {
      throw Exception("خطأ في تحميل الفواتير: ${failure.errMessage}");
    },
    (invoices) {
      allInvoices = invoices;
    },
  );

  for (final invoice in allInvoices) {
    data.add(jsonDecode(await prepareSellDraftData(invoice)));
    cartSellHome.clear();
  }
  return jsonEncode(data);
}
