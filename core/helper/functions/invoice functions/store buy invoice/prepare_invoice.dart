import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';

// Function to prepare an InvoiceModel for insertion
InvoiceModel prepareInvoice(InvoiceModel invoiceModel) {
  return InvoiceModel(
    // invoicesId: 0,
    invoicesBusinessId: StoreUserModel.instance.businessId,
    invoicesDiscountedAmount: invoiceModel.invoicesDiscountedAmount,
    invoicesUndiscountedAmount: invoiceModel.invoicesUndiscountedAmount,
    debtsPaidAmountCurrencyId: invoiceModel.debtsPaidAmountCurrencyId,
    invoicesAmountInBase: invoiceModel.invoicesAmountInBase,
    invoicesTotalTaxAmount: invoiceModel.invoicesTotalTaxAmount,
    invoicesAmountCurrencyId: invoiceModel.invoicesAmountCurrencyId,
    invoicesClientId: invoiceModel.invoicesClientId,
    invoicesPaidAmount: invoiceModel.debtsPaidAmount,
    invoicesNotes: invoiceModel.invoicesNotes,
    invoicesShippingCost: invoiceModel.invoicesShippingCost,
    invoicesShippingClientId: invoiceModel.invoicesShippingClientId,
    invoicesShippingCurrencyId: invoiceModel.invoicesShippingCurrencyId,
    invoicesShippingPayment: invoiceModel.invoicesShippingPayment,
    invoicesShippingCostInBase: invoiceModel.invoicesShippingCostInBase,
    invoicesType: invoiceModel.invoicesType,
    invoicesCreatedAt: invoiceModel.invoicesCreatedAt,
    invoicesAppliedAt: invoiceModel.invoicesAppliedAt,
    invoicesPaymentStatus: invoiceModel.invoicesPaymentStatus,
    invoicesPartnerId: invoiceModel.invoicesPartnerId,
    invoicesDiscountType: invoiceModel.invoicesDiscountType,
    invoicesDiscountValue: invoiceModel.invoicesDiscountValue,
    invoicesNumber: invoiceModel.invoicesNumber ??
        StoreInvoiceNumber.getAfterLatestInvoiceNumber(
            invoiceModel.invoicesType!),
  );
}
