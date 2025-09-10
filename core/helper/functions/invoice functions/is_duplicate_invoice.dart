import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<int> isDuplicateInvoice(Transaction db, InvoiceModel inv) async {
  // compute threshold time 5 minutes ago
  String fiveMinAgo =
      DateTime.now().subtract(const Duration(minutes: 5)).toUtc().toString();
  // We compare invoices_created_at >= fiveMinAgo
  // and handle nullable client_id / partner_id via `OR (? IS NULL AND ... IS NULL)`
  final sql = '''
      SELECT invoices_id
      FROM invoices
      WHERE invoices_business_id = ?
        AND (
          invoices_client_id = ?
          OR (? IS NULL AND invoices_client_id IS NULL)
        )
        AND (
          invoices_partner_id = ?
          OR (? IS NULL AND invoices_partner_id IS NULL)
        )
        AND invoices_type = ?
        AND invoices_discounted_amount = ?
        AND invoices_payment_status = ?
        AND invoices_amount_currency_id = ?
        AND invoices_created_at >= '$fiveMinAgo'
        LIMIT 1
    ''';
  final args = <Object?>[
    inv.invoicesBusinessId,
    inv.invoicesClientId,
    inv.invoicesClientId,
    inv.invoicesPartnerId,
    inv.invoicesPartnerId,
    inv.invoicesType,
    inv.invoicesDiscountedAmount,
    inv.invoicesPaymentStatus,
    inv.invoicesAmountCurrencyId
  ];

  final result = await db.rawQuery(sql, args);
  final invoiceId = result.isNotEmpty ? result.first['invoices_id'] as int : 0;
  return invoiceId;
}
