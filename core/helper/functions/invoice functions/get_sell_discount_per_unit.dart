import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

double getSellDiscountPerUnit(InvoiceModel invoiceModel) {
  if (invoiceModel.invoicesDiscountValue == null ||
      invoiceModel.invoicesDiscountValue == 0) {
    return 0;
  }
  double allProductCount = 0;
  for (final entry in cartSellHome) {
    allProductCount += entry.productCount * (entry.productConversion ?? 1);
  }
  return (invoiceModel.invoicesUndiscountedAmount! -
          invoiceModel.invoicesDiscountedAmount!) /
      allProductCount;
}
