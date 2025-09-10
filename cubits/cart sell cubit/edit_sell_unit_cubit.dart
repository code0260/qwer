import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';

class EditSellUnitCubit extends SafeCubit<EditUnitModel> {
  EditSellUnitCubit() : super(EditUnitModel());

  void editSellUnit(int productsId, String unitName, String unitSymbol,
      double unitConversionFactor, UnitGroup unitGroup) {
    int index = cartSellHome.indexWhere(
        (item) => item.getProductModel.productModel.productsId == productsId);
    int unitId = units[unitGroup]!
        .firstWhere((unitModel) => unitModel.unitsName == unitName)
        .unitsId!;
    var conversion = (unitConversionFactor /
            (cartSellHome[index]
                .getProductModel
                .productModel
                .unitsBaseConversion!))
        .roundToNearest(-3);

    cartSellHome[index].productCountUnitId = unitId;
    cartSellHome[index].productConversion = conversion;

    emit(EditUnitModel(
        unitName: unitName,
        productsId: productsId,
        unitSymbol: unitSymbol,
        unitConversionFactor: conversion));
  }

  void refresh() {
    for (final item in cartSellHome) {
      UnitModel unit = getIt
          .get<UnitRepoImpl>()
          .completeUnitModel(UnitModel(unitsId: item.productCountUnitId));
      emit(EditUnitModel(
          unitName: unit.unitsName,
          productsId: item.getProductModel.productModel.productsId,
          unitSymbol: unit.unitsSymbol,
          unitConversionFactor: item.productConversion));
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
