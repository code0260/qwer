import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_buy_cart_state.dart';

class ViewBuyCartCubit extends SafeCubit<ViewBuyCartState> {
  ViewBuyCartCubit() : super(ViewBuyCartInitial());
  OverlayEntry? overlayEntry;
  void viewCartAfterSearch() {
    cartBuyHome.addAll(cartBuySearch);
    cartBuySearch.clear();
    searchBuyData.clear();
    for (final item in cartBuyHome) {
      item.batchModel.batchesProductsTotalCount ??=
          StoreCountInvoice.getCountInvoice().toDouble();
      item.batchModel.batchesCountUnitId ??=
          item.productModel.productsBaseUnitId;
      if (currentCurrencyModel.businessCurrencyId !=
              item.batchModel.batchesProductsCurrencyId &&
          item.batchModel.batchesProductsBuyPrice != null) {
        cartBuyHome = prepareBuyPriceCurrency(
                cartBuyHome,
                cartBuyHome.indexWhere((element) =>
                    element.productModel.productsId ==
                    item.productModel.productsId)) ??
            cartBuyHome;
      }
    }
    if (cartBuyHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewBuyCartInitial());
    } else {
      emit(ViewBuyCartSuccess(
          items: cartBuyHome, itemsLength: cartBuyHome.length));
    }
  }

  void init() {
    emit(ViewBuyCartInitial());
  }

  void deleteProduct(int productsId) {
    cartBuyHome.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    if (cartBuyHome.isEmpty) {
      emit(ViewBuyCartInitial());
    } else {
      emit(ViewBuyCartSuccess(
          items: cartBuyHome, itemsLength: cartBuyHome.length));
    }
  }

  void refresh() {
    emit(ViewBuyCartInitial());
    emit(ViewBuyCartSuccess(
        items: cartBuyHome, itemsLength: cartBuyHome.length));
  }

  void clearProducts() {
    cartBuyHome.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    emit(ViewBuyCartInitial());
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, cartBuyHome);
  }

  @override
  Future<void> close() {
    cartBuyHome.clear();
    searchBuyData.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
