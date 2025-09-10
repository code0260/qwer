// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';

class AllInvoicesItemsModel {
  final GetInvoicesItemsModel originalInvoiceItems;
  final List<GetInvoicesItemsModel> refundItems;

  AllInvoicesItemsModel(
      {required this.originalInvoiceItems, required this.refundItems});

  factory AllInvoicesItemsModel.fromJson(Map<String, dynamic> map) {
    return AllInvoicesItemsModel(
      originalInvoiceItems: GetInvoicesItemsModel.fromJson(
          map['original'] as Map<String, dynamic>),
      refundItems: map["refund"] == null
          ? []
          : List<GetInvoicesItemsModel>.from(
              (map['refund'] as List<dynamic>).map<GetInvoicesItemsModel>(
                (x) =>
                    GetInvoicesItemsModel.fromJson(x as Map<String, dynamic>),
              ),
            ),
    );
  }
}
