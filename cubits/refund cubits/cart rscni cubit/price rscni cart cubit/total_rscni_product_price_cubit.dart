// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_sell_price_currency.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/apply%20offer%20repo/apply_offer_repo_imp.dart';
import 'package:almonazim/data/model/offer_model/total_offer_model.dart';

class TableRSCNIProductPriceCubit extends SafeCubit<TotalOfferModel> {
  TableRSCNIProductPriceCubit(this.applyOfferImp) : super(TotalOfferModel());
  ApplyOfferImp applyOfferImp;
  void getTotalProductPrice(int productsId) {
    TotalOfferModel totalProductModel = TotalOfferModel(productsId: productsId);

    int index = rSCNIHome.indexWhere(
        (item) => item.getProductModel.productModel.productsId == productsId);
    var value = prepareSellPriceCurrency(rSCNIHome, index);
    if (value != null) rSCNIHome = value;
    var unitPrice = rSCNIHome[index].editedPriceModel.pricesUnitPrice ??
        rSCNIHome[index].getProductModel.chosenPriceModel.pricesUnitPrice ??
        0;
    totalProductModel.count = rSCNIHome[index].productCount;
    totalProductModel.conversion = (rSCNIHome[index].productConversion ?? 1);
    double total1 = rSCNIHome[index].productCount * unitPrice;
    totalProductModel.undiscountedPrice =
        total1 * (rSCNIHome[index].productConversion ?? 1);

    totalProductModel.unitPrice = unitPrice;
    //applying discount
    totalProductModel.discountedPrice = totalProductModel.undiscountedPrice;
    applyOfferImp.applyOffer(totalProductModel);
    productDiscount[totalProductModel.productsId!] =
        totalProductModel.discountedPrice;
    // tax
    totalProductModel.taxAmount = calculateProductTaxAmount(
        rSCNIHome[index].taxes, totalProductModel.undiscountedPrice);
    totalProductModel.currencyId = currentCurrencyModel.businessCurrencyId;
    emit(totalProductModel);
  }
}
