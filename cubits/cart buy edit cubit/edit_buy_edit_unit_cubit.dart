// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';

class EditBuyEditUnitCubit extends SafeCubit<EditUnitModel> {
  EditBuyEditUnitCubit() : super(EditUnitModel());

  void editBuyEditUnit(int productsId, String unitName, String unitSymbol,
      double unitConversionFactor, UnitGroup unitGroup) {
    int index = cartBuyEditHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    int unitId = units[unitGroup]!
        .firstWhere((unitModel) => unitModel.unitsName == unitName)
        .unitsId!;
    cartBuyEditHome[index].batchModel.batchesCountUnitId = unitId;
    cartBuyEditHome[index].batchModel.unitsSymbol = unitSymbol;
    var conversion = (unitConversionFactor /
            (cartBuyEditHome[index].productModel.unitsBaseConversion ?? 1))
        .roundToNearest(-3);
    cartBuyEditHome[index].batchModel.unitsConversionFactor = conversion;

    emit(EditUnitModel(
        unitName: unitName,
        productsId: productsId,
        unitSymbol: unitSymbol,
        unitConversionFactor: conversion));
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
