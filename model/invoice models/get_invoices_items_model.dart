import 'package:almonazim/data/model/invoice%20models/invoice_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

class GetInvoicesItemsModel {
  final InvoiceModel invoiceModel;
  final List<InvoiceItemsModel> items;
  final List<String>? offersDescriptions;

  GetInvoicesItemsModel(
      {required this.invoiceModel,
      required this.items,
      this.offersDescriptions});

  factory GetInvoicesItemsModel.fromJson(Map<String, dynamic> json) {
    return GetInvoicesItemsModel(
      invoiceModel: InvoiceModel.fromJson(json["invoice"]),
      items: List.generate(json["invoices_items"].length,
          (index) => InvoiceItemsModel.fromJson(json["invoices_items"][index])),
      offersDescriptions: json["offers_descriptions"] == null
          ? null
          : List.generate(json["offers_descriptions"].length,
              (index) => json["offers_descriptions"][index]),
    );
  }
}
