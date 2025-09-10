// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/total_buy_product_model.dart';

class TableBuyProductPriceCubit extends SafeCubit<TotalBuyProductModel> {
  TableBuyProductPriceCubit() : super(TotalBuyProductModel());

  void getTotalProductPrice(int productsId) {
    int index = cartBuyHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    var value = prepareBuyPriceCurrency(cartBuyHome, index);
    if (value != null) cartBuyHome = value;
    if (cartBuyHome[index].batchModel.batchesProductsBuyPrice != null) {
      double buyPrice = cartBuyHome[index].batchModel.batchesProductsBuyPrice!;
      double total1 =
          (cartBuyHome[index].batchModel.batchesProductsTotalCount ??
                      StoreCountInvoice.getCountInvoice().toDouble())
                  .toDouble() *
              buyPrice;
      double total = total1 *
          (cartBuyHome[index].batchModel.unitsConversionFactor ?? 1).toDouble();

      double taxAmount =
          calculateProductTaxAmount(cartBuyHome[index].taxes, total);
      emit(TotalBuyProductModel(
          taxAmount: taxAmount,
          buyPrice: buyPrice,
          currencyId: currentCurrencyModel.businessCurrencyId,
          totalProduct: total,
          productsId: productsId));
    }
  }
}
