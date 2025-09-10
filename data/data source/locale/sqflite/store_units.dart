import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/enum_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:dartz/dartz.dart';

class StoreUnits {
  StoreUnits._();
  // Search units by name
  static Future<Either<Failure, List<UnitModel>>> searchUnits(
      String query) async {
    final result = await DatabaseHelper.query(
      "units",
      where: "units_name LIKE ?",
      whereArgs: ['%$query%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<UnitModel> unitsList =
            response.map((unit) => UnitModel.fromJson(unit)).toList();
        return right(unitsList);
      },
    );
  }

  static Future<Either<Failure, void>> getAllUnits() async {
    // Query to get all units from the local database
    final result = await DatabaseHelper.query("units");

    return result.fold(
      (failure) => left(failure),
      (response) async {
        // Initialize a map to store units grouped by 'units_group_en'

        for (final row in response) {
          UnitGroup unitsGroup =
              (row['units_group_en'] as String).toUnitGroup();

          // Create a UnitModel instance from the row data
          UnitModel unit = UnitModel.fromJson(row);

          // Check if this 'units_group_en' already exists in the map
          if (units.containsKey(unitsGroup)) {
            // If it exists, add the unit to the existing list
            units[unitsGroup]!.add(unit);
          } else {
            // If it does not exist, create a new entry with this group
            units[unitsGroup] = [unit];
          }
        }

        // Return a success response with no specific value
        return right(null);
      },
    );
  }

  // Insert a new unit
  static Future<Either<Failure, int>> insertUnit(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert(
      "units",
      value,
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        value['units_id'] = response;

        units[(value["units_group_en"] as String).toUnitGroup()] ??= [];
        units[(value["units_group_en"] as String).toUnitGroup()]!
            .add(UnitModel.fromJson(value));
        return right(response);
      },
    );
  }

  // Update a unit by ID
  static Future<Either<Failure, int>> updateUnit(
      int unitId, Map<String, dynamic> values) async {
    final result = await DatabaseHelper.update(
      "units",
      values,
      where: "units_id = ?",
      whereArgs: [unitId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete a unit by ID
  static Future<Either<Failure, int>> deleteUnit(int unitId) async {
    final result = await DatabaseHelper.delete(
      "units",
      where: "units_id = ?",
      whereArgs: [unitId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all units
  static Future<Either<Failure, int>> deleteAllUnits() async {
    final result = await DatabaseHelper.delete("units");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // updateUnitData
  static Future<Either<Failure, int>> updateUnitData(
      Map<String, dynamic> unit) async {
    final result = await DatabaseHelper.updateOrInsertData("units", unit);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteUnitsViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("units", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }

  static Future<Either<Failure, List<UnitModel>>> getOfflineUnits() async {
    final result = await DatabaseHelper.query(
      "units",
      where: "units_online = ?",
      whereArgs: [0],
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response.map((data) => UnitModel.fromJson(data)).toList());
      },
    );
  }

  static Future<Either<Failure, void>> updateUnitId(
      int oldId, int newId) async {
    var result = await DatabaseHelper.update(
      "units",
      {"units_id": newId, "units_online": 1},
      where: "units_id = ?",
      whereArgs: [oldId],
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
