// import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
// import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
// import 'package:almonazim/data/model/user%20models/user_model.dart';

// // Function to prepare an InvoiceModel for insertion
// InvoiceModel prepareEditInvoice(InvoiceModel invoiceModel) {
//   return InvoiceModel(
//     // invoicesId: 0,
//     invoicesBusinessId: UserModel.instance.businessId,
//     invoicesDiscountedAmount: invoiceModel.invoicesDiscountedAmount,
//     invoicesUndiscountedAmount: invoiceModel.invoicesUndiscountedAmount,
//     invoicesClientId: invoiceModel.invoicesClientId,
//     invoicesPaidAmount: (invoiceModel.debtsPaidAmount as num?)?.toInt(),
//     invoicesNotes: invoiceModel.invoicesNotes,
//     invoicesShippingCost: invoiceModel.invoicesShippingCost,
//     invoicesType: invoiceModel.invoicesType,
//     invoicesCreatedAt: invoiceModel.invoicesCreatedAt,
//     invoicesAppliedAt: invoiceModel.invoicesAppliedAt,
//     invoicesPaymentStatus: invoiceModel.invoicesPaymentStatus,
//     invoicesPartnerId: invoiceModel.invoicesPartnerId,
//     invoicesNumber: StoreInvoiceNumber.getAfterLatestInvoiceNumber(
//         invoiceModel.invoicesType!),
//   );
// }
