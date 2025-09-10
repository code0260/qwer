import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';

class EditInventoryAdjustmentUnitCubit extends SafeCubit<EditUnitModel> {
  EditInventoryAdjustmentUnitCubit() : super(EditUnitModel());

  void editInventoryAdjustmentUnit(int productsId, String unitName,
      String unitSymbol, double unitConversionFactor, UnitGroup unitGroup) {
    int index = cartInventoryAdjustmentHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    int unitId = units[unitGroup]!
        .firstWhere((unitModel) => unitModel.unitsName == unitName)
        .unitsId!;
    var conversion = (unitConversionFactor /
            (cartInventoryAdjustmentHome[index]
                .productModel
                .unitsBaseConversion!))
        .roundToNearest(-3);

    cartInventoryAdjustmentHome[index]
        .inventoryAdjustmentItemInputModel
        .inventoryAdjustmentItemsCountUnitId = unitId;
    cartInventoryAdjustmentHome[index].conversion = conversion;

    emit(EditUnitModel(
        unitName: unitName,
        productsId: productsId,
        unitSymbol: unitSymbol,
        unitConversionFactor: conversion));
  }

  void refresh() {
    for (final item in cartInventoryAdjustmentHome) {
      UnitModel unit = getIt.get<UnitRepoImpl>().completeUnitModel(UnitModel(
          unitsId: item.inventoryAdjustmentItemInputModel
              .inventoryAdjustmentItemsCountUnitId));
      emit(EditUnitModel(
          unitName: unit.unitsName,
          productsId: item.productModel.productsId,
          unitSymbol: unit.unitsSymbol,
          unitConversionFactor: item.conversion));
    }
  }
}

class EditUnitModel {
  int? productsId;
  String? unitName;
  String? unitSymbol;
  double? unitConversionFactor;
  EditUnitModel(
      {this.productsId,
      this.unitName,
      this.unitSymbol,
      this.unitConversionFactor});

  @override
  bool operator ==(covariant EditUnitModel other) {
    if (identical(this, other)) return true;

    return other.productsId == productsId &&
        other.unitName == unitName &&
        other.unitSymbol == unitSymbol &&
        other.unitConversionFactor == unitConversionFactor;
  }

  @override
  int get hashCode {
    return productsId.hashCode ^
        unitName.hashCode ^
        unitSymbol.hashCode ^
        unitConversionFactor.hashCode;
  }

  @override
  String toString() {
    return 'EditUnitModel(productsId: $productsId, unitName: $unitName, unitSymbol: $unitSymbol, unitConversionFactor: $unitConversionFactor)';
  }
}
