import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_rbcni_cart_state.dart';

class ViewRBCNICartCubit extends SafeCubit<ViewRBCNICartState> {
  ViewRBCNICartCubit() : super(ViewRBCNICartInitial());
  OverlayEntry? overlayEntry;

  void viewCartAfterSearch() {
    rBCNIHome.addAll(rBCNISearch);
    rBCNISearch.clear();
    searchRBCNIData.clear();
    for (final item in rBCNIHome) {
      item.batchModel.batchesProductsTotalCount ??=
          StoreCountInvoice.getCountInvoice().toDouble();
      item.batchModel.batchesCountUnitId ??=
          item.productModel.productsBaseUnitId;
      if (currentCurrencyModel.businessCurrencyId !=
          item.batchModel.batchesProductsCurrencyId) {
        rBCNIHome = prepareBuyPriceCurrency(
                rBCNIHome,
                rBCNIHome.indexWhere((element) =>
                    element.productModel.productsId ==
                    item.productModel.productsId)) ??
            rBCNIHome;
      }
    }
    if (rBCNIHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewRBCNICartInitial());
    } else {
      emit(ViewRBCNICartSuccess(
          items: rBCNIHome, itemsLength: rBCNIHome.length));
    }
  }

  void deleteProduct(int productsId) {
    rBCNIHome.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    if (rBCNIHome.isEmpty) {
      emit(ViewRBCNICartInitial());
    } else {
      emit(ViewRBCNICartSuccess(
          items: rBCNIHome, itemsLength: rBCNIHome.length));
    }
  }

  void refresh() {
    emit(ViewRBCNICartInitial());
    emit(ViewRBCNICartSuccess(items: rBCNIHome, itemsLength: rBCNIHome.length));
  }

  void clearProducts() {
    rBCNIHome.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);

    emit(ViewRBCNICartInitial());
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, rBCNIHome);
  }

  @override
  Future<void> close() {
    rBCNIHome.clear();
    searchRBCNIData.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
