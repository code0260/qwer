import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_buy_edit_cart_state.dart';

class ViewBuyEditCartCubit extends SafeCubit<ViewBuyEditCartState> {
  ViewBuyEditCartCubit(this.invoiceRepoImpl) : super(ViewBuyEditCartInitial());
  InvoiceRepoImpl invoiceRepoImpl;
  OverlayEntry? overlayEntry;

  Future<void> viewCart(int invoiceId, int currencyId) async {
    emit(ViewBuyEditCartLoading());
    var result = await invoiceRepoImpl.getInvoiceDataForBuyEdit(invoiceId);
    result.fold((failure) {
      emit(ViewBuyEditCartFailure(errorMessage: failure.errMessage));
    }, (items) {
      cartBuyEditHome = items;
      currentCurrencyModel = currencies
          .firstWhere((element) => element.businessCurrencyId == currencyId);
      for (final item in cartBuyEditHome) {
        if (currentCurrencyModel.businessCurrencyId !=
            item.batchModel.batchesProductsCurrencyId) {
          cartBuyEditHome = prepareBuyPriceCurrency(
                  cartBuyEditHome,
                  cartBuyEditHome.indexWhere((element) =>
                      element.productModel.productsId ==
                      item.productModel.productsId)) ??
              cartBuyEditHome;
        }
      }
      emit(ViewBuyEditCartSuccess(items: items, itemsLength: items.length));
    });
  }

  void viewCartAfterSearch() {
    cartBuyEditHome.addAll(cartBuyEditSearch);
    cartBuyEditSearch.clear();
    searchBuyEditData.clear();
    for (final item in cartBuyEditHome) {
      item.batchModel.batchesProductsTotalCount ??=
          StoreCountInvoice.getCountInvoice().toDouble();
      item.batchModel.batchesCountUnitId ??=
          item.productModel.productsBaseUnitId;
      if (currentCurrencyModel.businessCurrencyId !=
          item.batchModel.batchesProductsCurrencyId) {
        cartBuyEditHome = prepareBuyPriceCurrency(
                cartBuyEditHome,
                cartBuyEditHome.indexWhere((element) =>
                    element.productModel.productsId ==
                    item.productModel.productsId)) ??
            cartBuyEditHome;
      }
    }
    if (cartBuyEditHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewBuyEditCartInitial());
    } else {
      emit(ViewBuyEditCartSuccess(
          items: cartBuyEditHome, itemsLength: cartBuyEditHome.length));
    }
  }

  void deleteProduct(int productsId) {
    cartBuyEditHome.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    if (cartBuyEditHome.isEmpty) {
      emit(ViewBuyEditCartInitial());
    } else {
      emit(ViewBuyEditCartSuccess(
          items: cartBuyEditHome, itemsLength: cartBuyEditHome.length));
    }
  }

  void refresh() {
    emit(ViewBuyEditCartInitial());
    emit(ViewBuyEditCartSuccess(
        items: cartBuyEditHome, itemsLength: cartBuyEditHome.length));
  }

  void clearProducts() {
    cartBuyEditHome.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    emit(ViewBuyEditCartInitial());
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, cartBuyEditHome);
  }

  @override
  Future<void> close() {
    cartBuyEditHome.clear();
    cartBuyEditOriginalHome.clear();
    searchBuyEditData.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
