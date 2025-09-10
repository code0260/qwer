import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';

class EditRSCNIUnitCubit extends SafeCubit<EditUnitModel> {
  EditRSCNIUnitCubit() : super(EditUnitModel());

  void editRSCNIUnit(int productsId, String unitName, String unitSymbol,
      double unitConversionFactor, UnitGroup unitGroup) {
    int index = rSCNIHome.indexWhere(
        (item) => item.getProductModel.productModel.productsId == productsId);
    int unitId = units[unitGroup]!
        .firstWhere((unitModel) => unitModel.unitsName == unitName)
        .unitsId!;
    rSCNIHome[index].productCountUnitId = unitId;
    // rSCNIHome[index].batchModel.batchesCountUnitId = unitId;
    // rSCNIHome[index].batchModel.unitsSymbol = unitSymbol;
    rSCNIHome[index].productConversion = unitConversionFactor;

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
