import 'package:almonazim/data/model/profit%20report%20models/invoice%20profit%20models/invoice_profit_model.dart';
import 'package:almonazim/data/model/profit%20report%20models/invoice%20profit%20models/summary_invoice_profit_model.dart';

class AllInvoicesProfitModel {
  final List<InvoiceProfitModel> invoices;
  final SummaryInvoiceProfitModel summary;
  AllInvoicesProfitModel({
    required this.invoices,
    required this.summary,
  });

  factory AllInvoicesProfitModel.fromJson(Map<String, dynamic> map) {
    return AllInvoicesProfitModel(
      invoices: List<InvoiceProfitModel>.from(
        (map['invoices'] as List<dynamic>).map<InvoiceProfitModel>(
          (x) => InvoiceProfitModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      summary: SummaryInvoiceProfitModel.fromJson(
          map['summary'] as Map<String, dynamic>),
    );
  }
}
