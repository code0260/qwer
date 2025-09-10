import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/count_model.dart';
import 'package:toastification/toastification.dart';

class CountBuyEditProductCubit extends SafeCubit<CountProductModel> {
  CountBuyEditProductCubit() : super(CountProductModel());

  void addCount(int productsId) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartBuyEditHome) {
      if (item.productModel.productsId == productsId) {
        item.batchModel.batchesProductsTotalCount =
            (item.batchModel.batchesProductsTotalCount ??
                    StoreCountInvoice.getCountInvoice().toDouble()) +
                StoreCountInvoice.getCountInvoice().toDouble();
        count = item.batchModel.batchesProductsTotalCount!;
        item.batchModel.batchesProductsId == null
            ? item.batchModel.batchesProductsId = productsId
            : null;
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }

  void updateCountExplicitly(int productsId, double newCount) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartBuyEditHome) {
      if (item.productModel.productsId == productsId) {
        item.batchModel.batchesProductsTotalCount = newCount;
        count = item.batchModel.batchesProductsTotalCount!;
        item.batchModel.batchesProductsId == null
            ? item.batchModel.batchesProductsId = productsId
            : null;
      }
    }

    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }

  void subtractCount(int productsId) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in cartBuyEditHome) {
      if (item.productModel.productsId == productsId &&
          item.batchModel.batchesProductsTotalCount !=
              StoreCountInvoice.getCountInvoice().toDouble()) {
        if (item.batchModel.batchesProductsRemainingCount != null &&
            item.batchModel.batchesProductsRemainingCount! -
                    (item.batchModel.batchesProductsOriginalTotalCount! -
                        (item.batchModel.batchesProductsTotalCount! - count)) <
                0) {
          mySnackBar(ToastificationType.warning, 'تنبيه',
              'لا يوجد ما يكفي من ${item.productModel.productsName} لإرجاعه في هذه الدفعة');
          return;
        }
        item.batchModel.batchesProductsTotalCount =
            (item.batchModel.batchesProductsTotalCount ??
                    (StoreCountInvoice.getCountInvoice().toDouble() * 2)) -
                StoreCountInvoice.getCountInvoice().toDouble();

        count = item.batchModel.batchesProductsTotalCount!;
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }

  void refreshCountByProductId(int productsId) {
    double count = 0;
    for (var item in cartBuyEditHome) {
      if (item.productModel.productsId == productsId) {
        count = item.batchModel.batchesProductsTotalCount!;
      }
    }
    emit(CountProductModel(
        count: count.roundToNearest(-3), productsId: productsId));
  }
}
