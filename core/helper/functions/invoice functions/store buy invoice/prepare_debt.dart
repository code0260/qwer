// Function to prepare a DebtModel for insertion based on an InvoiceModel
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';

DebtModel prepareDebt(InvoiceModel invoiceModel, int invoiceId) {
  return DebtModel(
      // debtsId: 0,
      debtsBusinessId: StoreUserModel.instance.businessId,
      debtsInvoicesId: invoiceId,
      debtsCreatedAt: invoiceModel.invoicesCreatedAt,
      debtsDueDate: invoiceModel.debtsDueDate,
      debtsClientsId: invoiceModel.invoicesClientId,
      debtsPaidAmount: invoiceModel.invoicesPaidAmount,
      debtsPaidAmountInBase: invoiceModel.debtsPaidAmountInBase,
      debtsState: invoiceModel.invoicesPaymentStatus,
      debtsTotalAmount: invoiceModel.invoicesDiscountedAmount,
      debtsTotalAmountInBase: invoiceModel.invoicesAmountInBase,
      debtsAmountCurrencyId: invoiceModel.invoicesAmountCurrencyId);
}
