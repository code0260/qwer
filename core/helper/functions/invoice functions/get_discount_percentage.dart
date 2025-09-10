import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

double getDiscountPercentage(InvoiceModel invoiceModel) {
  if (invoiceModel.invoicesDiscountValue == null ||
      invoiceModel.invoicesDiscountValue == 0) {
    return 0;
  }

  if (invoiceModel.invoicesDiscountType == OfferDiscountType.percentage.name) {
    return invoiceModel.invoicesDiscountValue!;
  } else {
    return (invoiceModel.invoicesDiscountValue! * 100) /
        invoiceModel.invoicesUndiscountedAmount!;
  }
}
