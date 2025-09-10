import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/place%20models/building_model.dart';
import 'package:dartz/dartz.dart';

class StoreBuildings {
  StoreBuildings._();
  // Search for buildings by name
  static Future<Either<Failure, List<BuildingModel>>> searchBuildings(
      String query) async {
    final result = await DatabaseHelper.query(
      "buildings",
      where: "buildings_name LIKE ?",
      whereArgs: ['%$query%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<BuildingModel> searchResults =
            response.map((data) => BuildingModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

// Search for buildings by name
  static Future<Either<Failure, List<BuildingModel>>> getBuildings() async {
    final result = await DatabaseHelper.query("buildings");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<BuildingModel> gotResults =
            response.map((data) => BuildingModel.fromJson(data)).toList();
        return right(gotResults);
      },
    );
  }

  // Insert a new building
  static Future<Either<Failure, int>> insertBuilding(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("buildings", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updateBuildingData
  static Future<Either<Failure, int>> updateBuildingData(
      Map<String, dynamic> building) async {
    final result =
        await DatabaseHelper.updateOrInsertData("buildings", building);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all buildings
  static Future<Either<Failure, int>> deleteAllBuildings() async {
    final result = await DatabaseHelper.delete("buildings");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteBuildingsViaIdList(
      List<int> list) async {
    final result =
        await DatabaseHelper.deleteViaIdList("buildings", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
