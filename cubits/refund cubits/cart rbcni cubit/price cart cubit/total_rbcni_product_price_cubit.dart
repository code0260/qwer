// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/total_buy_product_model.dart';

class TableRBCNIProductPriceCubit extends SafeCubit<TotalBuyProductModel> {
  TableRBCNIProductPriceCubit() : super(TotalBuyProductModel());

  void getTotalProductPrice(int productsId) {
    int index = rBCNIHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    var value = prepareBuyPriceCurrency(rBCNIHome, index);
    if (value != null) rBCNIHome = value;

    if (rBCNIHome[index].batchModel.batchesProductsBuyPrice != null) {
      double buyPrice =
          rBCNIHome[index].batchModel.batchesProductsBuyPrice!.toDouble();
      double total1 = (rBCNIHome[index].batchModel.batchesProductsTotalCount ??
                  StoreCountInvoice.getCountInvoice().toDouble())
              .toDouble() *
          buyPrice;
      double total =
          total1 * (rBCNIHome[index].batchModel.unitsConversionFactor ?? 1);
      double taxAmount =
          calculateProductTaxAmount(rBCNIHome[index].taxes, total);

      emit(TotalBuyProductModel(
          taxAmount: taxAmount,
          buyPrice: buyPrice,
          currencyId: currentCurrencyModel.businessCurrencyId,
          totalProduct: total,
          productsId: productsId));
    }
  }
}
