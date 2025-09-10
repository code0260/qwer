import 'package:almonazim/core/helper/functions/currency%20functions/prepare_sell_price_currency.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_sell_edit_cart_state.dart';

class ViewSellEditCartCubit extends SafeCubit<ViewSellEditCartState> {
  ViewSellEditCartCubit(this.invoiceRepoImpl)
      : super(ViewSellEditCartInitial());
  InvoiceRepoImpl invoiceRepoImpl;
  OverlayEntry? overlayEntry;

  Future<void> viewCart(int invoiceId, int currencyId) async {
    emit(ViewSellEditCartLoading());
    var result = await invoiceRepoImpl.getInvoiceDataForSellEdit(invoiceId);
    result.fold((failure) {
      emit(ViewSellEditCartFailure(errorMessage: failure.errMessage));
    }, (items) {
      cartSellEditHome = items;
      currentCurrencyModel = currencies
          .firstWhere((element) => element.businessCurrencyId == currencyId);
      for (final item in cartSellEditHome) {
        if (currentCurrencyModel.businessCurrencyId != item.currencyId) {
          item.currencyId =
              item.getProductModel.chosenPriceModel.pricesAmountCurrencyId;
          cartSellEditHome = prepareSellPriceCurrency(
                  cartSellEditHome,
                  cartSellEditHome.indexWhere((element) =>
                      element.getProductModel.productModel.productsId ==
                      item.getProductModel.productModel.productsId)) ??
              cartSellEditHome;
        }
      }
      emit(ViewSellEditCartSuccess(items: items, itemsLength: items.length));
    });
  }

  void viewSellEditCartAfterSearch() {
    cartSellEditHome.addAll(cartSellEditSearch);
    cartSellEditSearch.clear();
    searchSellEditData.clear();
    if (cartSellEditHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewSellEditCartInitial());
    } else {
      for (final item in cartSellEditHome) {
        if (currentCurrencyModel.businessCurrencyId != item.currencyId) {
          item.currencyId =
              item.getProductModel.chosenPriceModel.pricesAmountCurrencyId;
          cartSellEditHome = prepareSellPriceCurrency(
                  cartSellEditHome,
                  cartSellEditHome.indexWhere((element) =>
                      element.getProductModel.productModel.productsId ==
                      item.getProductModel.productModel.productsId)) ??
              cartSellEditHome;
        }
      }

      emit(ViewSellEditCartSuccess(
          items: cartSellEditHome, itemsLength: cartSellEditHome.length));
    }
  }

  void deleteProduct(int productsId) {
    cartSellEditHome.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    productDiscount.remove(productsId);
    searchSellEditData.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    if (cartSellEditHome.isEmpty) {
      emit(ViewSellEditCartInitial());
    } else {
      emit(ViewSellEditCartSuccess(
          items: cartSellEditHome, itemsLength: cartSellEditHome.length));
    }
  }

  void refresh() {
    emit(ViewSellEditCartInitial());
    emit(ViewSellEditCartSuccess(
        items: cartSellEditHome, itemsLength: cartSellEditHome.length));
  }

  void clearProducts() {
    cartSellEditHome.clear();
    searchSellEditData.clear();
    productDiscount.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    emit(ViewSellEditCartInitial());
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, cartSellEditHome);
  }

  @override
  Future<void> close() {
    cartSellEditHome.clear();
    cartSellEditOriginalHome.clear();
    searchSellEditData.clear();
    productDiscount.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
