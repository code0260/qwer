import 'package:almonazim/core/helper/functions/currency%20functions/prepare_sell_price_currency.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_sell_cart_state.dart';

class ViewSellCartCubit extends SafeCubit<ViewSellCartState> {
  ViewSellCartCubit() : super(ViewSellCartInitial());
  OverlayEntry? overlayEntry;
  void viewSellCartAfterSearch() {
    cartSellHome.addAll(cartSellSearch);
    cartSellSearch.clear();
    searchSellData.clear();
    if (cartSellHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewSellCartInitial());
    } else {
      for (final item in cartSellHome) {
        if (currentCurrencyModel.businessCurrencyId != item.currencyId) {
          item.currencyId =
              item.getProductModel.chosenPriceModel.pricesAmountCurrencyId;
          cartSellHome = prepareSellPriceCurrency(
                  cartSellHome,
                  cartSellHome.indexWhere((element) =>
                      element.getProductModel.productModel.productsId ==
                      item.getProductModel.productModel.productsId)) ??
              cartSellHome;
        }
      }
      emit(ViewSellCartSuccess(
          items: cartSellHome, itemsLength: cartSellHome.length));
    }
  }

  void deleteProduct(int productsId) {
    cartSellHome.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    productDiscount.remove(productsId);
    searchSellData.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    if (cartSellHome.isEmpty) {
      emit(ViewSellCartInitial());
    } else {
      emit(ViewSellCartSuccess(
          items: cartSellHome, itemsLength: cartSellHome.length));
    }
  }

  void refresh() {
    emit(ViewSellCartInitial());
    emit(ViewSellCartSuccess(
        items: cartSellHome, itemsLength: cartSellHome.length));
  }

  void init() {
    emit(ViewSellCartInitial());
  }

  void clearProducts() {
    cartSellHome.clear();
    searchSellData.clear();
    productDiscount.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    emit(ViewSellCartInitial());
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, cartSellHome);
  }

  @override
  Future<void> close() {
    cartSellHome.clear();
    searchSellData.clear();
    productDiscount.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
