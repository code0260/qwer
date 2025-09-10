import 'package:almonazim/core/helper/functions/currency%20functions/prepare_sell_price_currency.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_rscni_cart_state.dart';

class ViewRSCNICartCubit extends SafeCubit<ViewRSCNICartState> {
  ViewRSCNICartCubit() : super(ViewRSCNICartInitial());
  OverlayEntry? overlayEntry;

  void viewRSCNICartAfterSearch() {
    rSCNIHome.addAll(rSCNISearch);
    rSCNISearch.clear();
    searchRSCNIData.clear();
    if (rSCNIHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewRSCNICartInitial());
    } else {
      for (final item in rSCNIHome) {
        if (currentCurrencyModel.businessCurrencyId != item.currencyId) {
          item.currencyId =
              item.getProductModel.chosenPriceModel.pricesAmountCurrencyId;
          rSCNIHome = prepareSellPriceCurrency(
                  rSCNIHome,
                  rSCNIHome.indexWhere((element) =>
                      element.getProductModel.productModel.productsId ==
                      item.getProductModel.productModel.productsId)) ??
              rSCNIHome;
        }
      }

      emit(ViewRSCNICartSuccess(
          items: rSCNIHome, itemsLength: rSCNIHome.length));
    }
  }

  void deleteProduct(int productsId) {
    rSCNIHome.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    productDiscount.remove(productsId);
    searchRSCNIData.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    if (rSCNIHome.isEmpty) {
      emit(ViewRSCNICartInitial());
    } else {
      emit(ViewRSCNICartSuccess(
          items: rSCNIHome, itemsLength: rSCNIHome.length));
    }
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void refresh() {
    emit(ViewRSCNICartInitial());
    emit(ViewRSCNICartSuccess(items: rSCNIHome, itemsLength: rSCNIHome.length));
  }

  void clearProducts() {
    rSCNIHome.clear();
    searchRSCNIData.clear();
    productDiscount.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    emit(ViewRSCNICartInitial());
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, rSCNIHome);
  }

  @override
  Future<void> close() {
    rSCNIHome.clear();
    searchRSCNIData.clear();
    productDiscount.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
