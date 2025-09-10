import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/count_model.dart';

class CountInventoryAdjustmentProductCubit
    extends SafeCubit<CountProductModel> {
  CountInventoryAdjustmentProductCubit() : super(CountProductModel());

  void addCount(int productsId, double currentUnitConversion) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartInventoryAdjustmentHome) {
      if (item.productModel.productsId == productsId) {
        double currentTotalCount = item.inventoryAdjustmentItemInputModel
                .inventoryAdjustmentItemsCount! +
            count;
        item.inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount =
            currentTotalCount;
        count = currentTotalCount;
        break;
      }
    }
    emit(CountProductModel(count: count, productsId: productsId));
  }

  void updateCountExplicitly(
      int productsId, double newCount, double currentUnitConversion) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();

    for (var item in cartInventoryAdjustmentHome) {
      if (item.productModel.productsId == productsId) {
        item.inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount =
            newCount;
        count = newCount;
        break;
      }
    }
    emit(CountProductModel(count: count, productsId: productsId));
  }

  void subtractCount(int productsId, double currentUnitConversion) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartInventoryAdjustmentHome) {
      if (item.productModel.productsId == productsId) {
        item.inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount =
            (item.inventoryAdjustmentItemInputModel
                    .inventoryAdjustmentItemsCount!) -
                count;
        count = item
            .inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount!;
      }
    }
    emit(CountProductModel(count: count, productsId: productsId));
  }

  void refreshCountByProductId(int productsId) {
    double count = 0;
    for (var item in cartInventoryAdjustmentHome) {
      if (item.productModel.productsId == productsId) {
        count = item
            .inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount!;
      }
    }
    emit(CountProductModel(count: count, productsId: productsId));
  }
}
