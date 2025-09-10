import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/is_bigger_than_remaining.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/model/cart%20models/count_model.dart';

class CountSellProductCubit extends SafeCubit<CountProductModel> {
  CountSellProductCubit() : super(CountProductModel());

  void addCount(int productsId, double currentUnitConversion) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartSellHome) {
      if (item.getProductModel.productModel.productsId == productsId) {
        double currentTotalCount = item.productCount + count;
        if (StoreWorkOffline.getWorkOffline() == false) {
          if (isBiggerThanRemaining(
              productsId,
              currentTotalCount,
              currentUnitConversion.toDouble() *
                  item.getProductModel.productModel.unitsBaseConversion!,
              cartSellHome,
              useAllExistedPlaces: true)) {
            return;
          } else {
            item.productCount = currentTotalCount;
            count = currentTotalCount;
            break;
          }
        } else {
          item.productCount = currentTotalCount;
          count = currentTotalCount;
          break;
        }
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }

  void updateCountExplicitly(
      int productsId, double newCount, double currentUnitConversion) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();

    for (var item in cartSellHome) {
      if (item.getProductModel.productModel.productsId == productsId) {
        if (StoreWorkOffline.getWorkOffline() == false) {
          if (isBiggerThanRemaining(
              productsId,
              newCount,
              currentUnitConversion.toDouble() *
                  item.getProductModel.productModel.unitsBaseConversion!,
              cartSellHome,
              useAllExistedPlaces: true)) {
            return;
          } else {
            item.productCount = newCount;
            count = newCount;
            break;
          }
        } else {
          item.productCount = newCount;
          count = newCount;
          break;
        }
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }

  void subtractCount(int productsId, double currentUnitConversion) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartSellHome) {
      if (item.getProductModel.productModel.productsId == productsId) {
        if (item.productCount <=
            StoreCountInvoice.getCountInvoice().toDouble()) {
          break;
        }

        item.productCount = (item.productCount) - count;
        count = item.productCount;
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }

  void refreshCountByProductId(int productsId) {
    double count = 0;
    for (var item in cartSellHome) {
      if (item.getProductModel.productModel.productsId == productsId) {
        count = item.productCount;
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }
}
