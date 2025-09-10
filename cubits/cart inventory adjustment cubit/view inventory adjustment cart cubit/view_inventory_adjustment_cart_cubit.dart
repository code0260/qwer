import 'package:almonazim/core/helper/functions/custom%20dialogs/on_cart_pop_invoked.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'view_inventory_adjustment_cart_state.dart';

class ViewInventoryAdjustmentCartCubit
    extends SafeCubit<ViewInventoryAdjustmentCartState> {
  ViewInventoryAdjustmentCartCubit()
      : super(ViewInventoryAdjustmentCartInitial());
  OverlayEntry? overlayEntry;
  void viewInventoryAdjustmentCartAfterSearch() {
    cartInventoryAdjustmentHome.addAll(cartInventoryAdjustmentSearch);
    cartInventoryAdjustmentSearch.clear();
    searchInventoryAdjustmentData.clear();
    if (cartInventoryAdjustmentHome.isEmpty) {
      // this is for when the user deletes the all products
      emit(ViewInventoryAdjustmentCartInitial());
    } else {
      emit(ViewInventoryAdjustmentCartSuccess(
          items: cartInventoryAdjustmentHome,
          itemsLength: cartInventoryAdjustmentHome.length));
    }
  }

  void deleteProduct(int productsId) {
    cartInventoryAdjustmentHome.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    searchInventoryAdjustmentData.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    if (cartInventoryAdjustmentHome.isEmpty) {
      emit(ViewInventoryAdjustmentCartInitial());
    } else {
      emit(ViewInventoryAdjustmentCartSuccess(
          items: cartInventoryAdjustmentHome,
          itemsLength: cartInventoryAdjustmentHome.length));
    }
  }

  void refresh() {
    emit(ViewInventoryAdjustmentCartInitial());
    emit(ViewInventoryAdjustmentCartSuccess(
        items: cartInventoryAdjustmentHome,
        itemsLength: cartInventoryAdjustmentHome.length));
  }

  void clearProducts() {
    cartInventoryAdjustmentHome.clear();
    searchInventoryAdjustmentData.clear();
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    emit(ViewInventoryAdjustmentCartInitial());
  }

  void removeOverlay() {
    overlayEntry = null;
  }

  void onPop(bool didPop) {
    onCartPopInvoked(didPop, cartInventoryAdjustmentHome);
  }

  @override
  Future<void> close() {
    cartInventoryAdjustmentHome.clear();
    searchInventoryAdjustmentData.clear();
    removeFloatingWidget(overlayEntry);
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    return super.close();
  }
}
