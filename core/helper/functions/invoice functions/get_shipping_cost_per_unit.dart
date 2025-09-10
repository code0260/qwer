import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

num getShippingCostPerUnit(InvoiceModel invoiceModel) {
  if (invoiceModel.invoicesShippingCost == null ||
      invoiceModel.invoicesShippingCost == 0) {
    return 0;
  }
  double allProductCount = 0;
  for (final entry in cartBuyHome) {
    allProductCount += entry.batchModel.batchesProductsTotalCount! *
        (entry.batchModel.unitsConversionFactor ?? 1);
  }
  return invoiceModel.invoicesShippingCost! / allProductCount;
}
