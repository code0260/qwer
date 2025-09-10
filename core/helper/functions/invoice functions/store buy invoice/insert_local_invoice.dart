// Function to insert an invoice into the database
import 'package:almonazim/core/helper/functions/invoice%20functions/is_duplicate_invoice.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<dynamic> insertLocalInvoice(
    Transaction txn, InvoiceModel invoiceModel) async {
  int invoiceId = await isDuplicateInvoice(txn, invoiceModel);
  if (invoiceId > 0) {
    return invoiceId.toString();
    // throw Exception('تم إنشاء فاتورة مماثلة خلال آخر خمس دقائق');
  }

  var invoiceResult = await txn.insert("invoices", invoiceModel.toJson());
  if (invoiceResult == 0) throw Exception("خطأ في إدخال الفاتورة");
  return invoiceResult;
}
