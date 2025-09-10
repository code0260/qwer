import 'package:almonazim/data.dart';
import 'package:get/get.dart';

double calculateBuyNewInvoiceAmount() {
  double newInvoiceTotal = 0.0;

  for (var editedItem in cartBuyEditHome) {
    var originalItem = cartBuyEditOriginalHome.firstWhereOrNull(
        (item) => item.productModel == editedItem.productModel);

    if (originalItem != null) {
      var editedBatch = editedItem.batchModel;
      var originalBatch = originalItem.batchModel;

      // Check price change
      if (editedBatch.batchesProductsBuyPrice !=
          originalBatch.batchesProductsBuyPrice) {
        // Add entire edited item to the new invoice
        newInvoiceTotal += editedBatch.batchesProductsBuyPrice! *
            editedBatch.batchesProductsTotalCount! *
            editedBatch.unitsConversionFactor!.toDouble();
        continue; // Skip further checks if price changed
      }

      // Check total count change with unit conversion
      var editedTotalCount = editedBatch.batchesProductsTotalCount! *
          editedBatch.unitsConversionFactor!.toDouble();
      var originalTotalCount = originalBatch.batchesProductsTotalCount! *
          originalBatch.unitsConversionFactor!.toDouble();

      if (editedTotalCount != originalTotalCount) {
        if (editedTotalCount > originalTotalCount) {
          // Add the difference to the new invoice
          var countDifference = editedTotalCount - originalTotalCount;
          newInvoiceTotal +=
              countDifference * editedBatch.batchesProductsBuyPrice!;
        }
        continue; // Skip to the next item after count difference handling
      }
    } else {
      // New item not in original items, add full amount to the new invoice
      newInvoiceTotal += editedItem.batchModel.batchesProductsBuyPrice! *
          editedItem.batchModel.batchesProductsTotalCount! *
          (editedItem.batchModel.unitsConversionFactor ?? 1);
    }
  }

  return newInvoiceTotal; // Return the total new invoice amount
}
