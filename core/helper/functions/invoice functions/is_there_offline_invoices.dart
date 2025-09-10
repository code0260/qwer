import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';

Future<bool> isThereOfflineInvoices({InvoiceType? invoiceType}) async {
  final invoicesResult = await DatabaseHelper.query("invoices",
      where: invoiceType == null ? null : 'invoices_type = ? ',
      whereArgs: invoiceType == null ? null : [invoiceType.name]);

  // If failed to fetch invoices, stop the process
  if (invoicesResult.isLeft()) return false;

  final invoices = invoicesResult.getOrElse(() => []);
  if (invoices.isEmpty) {
    return false;
  } else {
    return true;
  }
}
