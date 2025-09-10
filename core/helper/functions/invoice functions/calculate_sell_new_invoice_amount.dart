import 'package:almonazim/data.dart';
import 'package:get/get.dart';

double calculateSellNewInvoiceAmount() {
  double newInvoiceTotal = 0.0;

  for (var editedItem in cartSellEditHome) {
    var originalItem = cartSellEditOriginalHome.firstWhereOrNull(
        (item) => item.getProductModel == editedItem.getProductModel);

    if (originalItem != null) {
      // Check total count change with unit conversion
      var editedTotalCount =
          editedItem.productCount * (editedItem.productConversion ?? 1);
      var originalTotalCount =
          originalItem.productCount * (originalItem.productConversion ?? 1);

      if (editedTotalCount != originalTotalCount) {
        if (editedTotalCount > originalTotalCount) {
          // Add the difference to the new invoice
          var countDifference = editedTotalCount - originalTotalCount;
          newInvoiceTotal += countDifference *
              editedItem.getProductModel.chosenPriceModel.pricesUnitPrice!;
        }
        continue; // Skip to the next item after count difference handling
      }
    } else {
      // New item not in original items, add full amount to the new invoice
      newInvoiceTotal +=
          editedItem.getProductModel.chosenPriceModel.pricesUnitPrice! *
              editedItem.productCount *
              (editedItem.productConversion ?? 1);
    }
  }

  return newInvoiceTotal; // Return the total new invoice amount
}
