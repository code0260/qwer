import 'dart:convert';

import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/enum_extension.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_units.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class UnitRepoImpl implements UnitRepo {
  ApiService apiService;
  UnitRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> deleteUnit(UnitModel unitModel) async {
    final requestData = {
      "units_id": unitModel.unitsId,
    };

    final result = await apiService.post(
      url: AppLinks.deleteUnitsLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        if (response["status"] == "success") {
          units[unitModel.unitsGroupEn!.toUnitGroup()]!.remove(unitModel);
          return right(response["message"]);
        } else {
          return left(ServerFailure(response["message"]));
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<UnitModel>>> getUnitsByGroup(
      UnitGroup unitGroup) async {
    if (units[unitGroup] == null) {
      final result = await apiService.post(
        url: AppLinks.getUnitsLink,
        data: {"units_group_en": unitGroup.name},
      );
      return result.fold(
        (failure) => left(failure),
        (response) {
          units[unitGroup] = [];
          for (final unit in response["data"]) {
            units[unitGroup]!.add(UnitModel.fromJson(unit));
          }
          return right(units[unitGroup]!);
        },
      );
    } else {
      return right(units[unitGroup]!);
    }
  }

  @override
  Future<Either<Failure, List<UnitModel>>> getAllUnits() async {
    var result = await apiService.get(
      url: AppLinks.getAllUnitsLink,
    );
    return result.fold((failure) {
      return left(failure);
    }, (response) async {
      List<UnitModel> allUnits = [];
      //& units
      List<int> unitIds = [];
      for (final item in response["data"]) {
        units[(item["units_group_en"] as String).toUnitGroup()] = [];
        for (final unit in item["units"]) {
          unitIds.add(unit['units_id']);
          allUnits.add(UnitModel.fromJson(unit));
          if (StoreStep.getStep() == '3') {
            await StoreUnits.updateUnitData(unit);
          }
          units[(unit["units_group_en"] as String).toUnitGroup()]!
              .add(UnitModel.fromJson(unit));
        }
      }

      if (StoreStep.getStep() == '3') {
        await StoreUnits.deleteUnitsViaIdList(unitIds);
      }
      return right(allUnits);
    });
  }

  @override
  Future<Either<Failure, List<UnitModel>>> refreshUnits(
      UnitGroup unitGroup) async {
    final requestData = {
      "units_group_en": unitGroup.name,
    };

    final result = await apiService.post(
      url: AppLinks.getUnitsLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        units[unitGroup]!.clear();
        for (final unit in response["data"]) {
          units[unitGroup]!.add(UnitModel.fromJson(unit));
        }
        return right(units[unitGroup]!);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addUnit(UnitModel unitModel) async {
    // print(unitModel.toServer());
    final result = await apiService.post(
        url: AppLinks.addUnitLink,
        data: unitModel.toServer(),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) async {
        if (StoreStep.getStep() != '3') {
          return right(null);
        } else {
          unitModel = unitModel.copyWith(
              unitsId: (response['data'] as String).toInt(),
              unitsBusinessId: StoreUserModel.instance.businessId!,
              unitsOnline: 1);
          var insertUnitResult =
              await StoreUnits.insertUnit(unitModel.toServer());
          return insertUnitResult.fold((l) => right(null), (r) => right(null));
        }
      },
    );
    // return left(ServerFailure("test"));
  }

  @override
  Future<Either<Failure, String>> editUnit(UnitModel unitModel) async {
    final requestData = jsonEncode(unitModel.toServer());

    final result = await apiService.post(
      url: AppLinks.editUnitsLink,
      formDataIsEnabled: false,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        if (response["status"] == "success") {
          editUnitLocally(unitModel);
          return right(response["status"]);
        } else {
          return left(ServerFailure(response["message"]));
        }
      },
    );
  }

  void editUnitLocally(UnitModel unitModel) {
    final unitGroup = unitModel.unitsGroupEn!.toUnitGroup();
    final index = units[unitGroup]!.indexWhere(
      (unitModelList) => unitModelList.unitsId == unitModel.unitsId,
    );
    units[unitGroup]![index] = unitModel;
  }

  @override
  UnitModel completeUnitModel(UnitModel unitModel) {
    for (final entry in units.entries) {
      final result = entry.value.firstWhereOrNull(
        (unitModelEntry) =>
            unitModelEntry.unitsId == unitModel.unitsId ||
            unitModelEntry.unitsName == unitModel.unitsName ||
            unitModelEntry.unitsSymbol == unitModel.unitsSymbol ||
            unitModelEntry.unitsIsBaseUnit == unitModel.unitsIsBaseUnit,
      );
      if (result != null) {
        return result;
      }
    }
    throw Exception("no unit in map");
  }

  // give small uint id and will have the biggest unit of the same group of small unit
  // قطعة would give you the biggest one (like طرد if existed or bigger if too)
  @override
  UnitModel getBiggestUnitBySmallId(int unitsId) {
    UnitModel unitModel = completeUnitModel(UnitModel(unitsId: unitsId));
    for (final entry in units.entries) {
      if (entry.key.name == unitModel.unitsGroupEn) {
        for (final unit in entry.value) {
          if (unit.unitsConversionFactor! > unitModel.unitsConversionFactor!) {
            unitModel = unit;
          }
        }
        return unitModel;
      }
    }
    throw Exception("no unit in map");
  }

  UnitModel getSmallUnitByBiggestId(int unitsId) {
    UnitModel unitModel = completeUnitModel(UnitModel(unitsId: unitsId));
    for (final entry in units.entries) {
      if (entry.key.name == unitModel.unitsGroupEn) {
        for (final unit in entry.value) {
          if (unit.unitsConversionFactor! < unitModel.unitsConversionFactor!) {
            unitModel = unit;
          }
        }
        return unitModel;
      }
    }
    throw Exception("no unit in map");
  }

  UnitModel getBaseUnitForGroupByUnitId(int unitsId) {
    UnitModel unitModel = completeUnitModel(UnitModel(unitsId: unitsId));
    for (final entry in units.entries) {
      if (entry.key.name == unitModel.unitsGroupEn) {
        for (final unit in entry.value) {
          if (unit.unitsIsBaseUnit == 1) {
            unitModel = unit;
          }
        }
        return unitModel;
      }
    }
    throw Exception("no unit in map");
  }

  @override
  Future<Either<Failure, Map>> addMultipleUnits(List<UnitModel> units) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addMultipleUnitsLink,
        data: {
          "units": units
              .map(
                (unitModel) => unitModel.toJson(),
              )
              .toList()
        });

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response["data"]);
      },
    );
  }
}
