import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

double getBuyDiscountPerUnit(InvoiceModel invoiceModel) {
  if (invoiceModel.invoicesDiscountValue == null ||
      invoiceModel.invoicesDiscountValue == 0) {
    return 0;
  }
  double allProductCount = 0;
  for (final entry in cartBuyHome) {
    allProductCount += entry.batchModel.batchesProductsTotalCount! *
        (entry.batchModel.unitsConversionFactor ?? 1);
  }
  return (invoiceModel.invoicesUndiscountedAmount! -
          invoiceModel.invoicesDiscountedAmount!) /
      allProductCount;
}
