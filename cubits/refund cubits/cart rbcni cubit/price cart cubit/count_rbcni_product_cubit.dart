import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/count_model.dart';

class CountRBCNIProductCubit extends SafeCubit<CountProductModel> {
  CountRBCNIProductCubit() : super(CountProductModel());

  void addCount(int productsId) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in rBCNIHome) {
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
    emit(CountProductModel(count: count, productsId: productsId));
  }

  void updateCountExplicitly(int productsId, double newCount) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in rBCNIHome) {
      if (item.productModel.productsId == productsId) {
        item.batchModel.batchesProductsTotalCount = newCount;
        count = item.batchModel.batchesProductsTotalCount!;
        item.batchModel.batchesProductsId == null
            ? item.batchModel.batchesProductsId = productsId
            : null;
      }
    }

    emit(CountProductModel(count: count, productsId: productsId));
  }

  void subtractCount(int productsId) {
    double count = StoreCountInvoice.getCountInvoice().toDouble();
    for (var item in rBCNIHome) {
      if (item.productModel.productsId == productsId &&
          item.batchModel.batchesProductsTotalCount !=
              StoreCountInvoice.getCountInvoice().toDouble()) {
        item.batchModel.batchesProductsTotalCount =
            (item.batchModel.batchesProductsTotalCount ??
                    (StoreCountInvoice.getCountInvoice().toDouble() * 2)) -
                StoreCountInvoice.getCountInvoice().toDouble();

        count = item.batchModel.batchesProductsTotalCount!;
      }
    }
    emit(CountProductModel(count: count, productsId: productsId));
  }

  void refreshCountByProductId(int productsId) {
    double count = 0;
    for (var item in rBCNIHome) {
      if (item.productModel.productsId == productsId) {
        count = item.batchModel.batchesProductsTotalCount!;
      }
    }
    emit(CountProductModel(count: count, productsId: productsId));
  }
}
