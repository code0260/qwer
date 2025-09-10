// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';

class EditRBCNIUnitCubit extends SafeCubit<EditUnitModel> {
  EditRBCNIUnitCubit() : super(EditUnitModel());

  void editRBCNIUnit(int productsId, String unitName, String unitSymbol,
      double unitConversionFactor, UnitGroup unitGroup) {
    int index = rBCNIHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    int unitId = units[unitGroup]!
        .firstWhere((unitModel) => unitModel.unitsName == unitName)
        .unitsId!;
    rBCNIHome[index].batchModel.batchesCountUnitId = unitId;
    rBCNIHome[index].batchModel.unitsSymbol = unitSymbol;
    rBCNIHome[index].batchModel.unitsConversionFactor = unitConversionFactor;

    emit(EditUnitModel(
        unitName: unitName,
        productsId: productsId,
        unitSymbol: unitSymbol,
        unitConversionFactor: unitConversionFactor));
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
