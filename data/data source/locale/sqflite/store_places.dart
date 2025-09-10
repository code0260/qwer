import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:dartz/dartz.dart';

class StorePlaces {
  StorePlaces._();

  // Search for places by room number or other criteria
  static Future<Either<Failure, List<PlaceModel>>> searchPlaces(
      String buildingName) async {
    final result = await DatabaseHelper.query(
      "buildings_with_places",
      where: "buildings_name LIKE ?",
      whereArgs: ['%$buildingName%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<PlaceModel> searchResults =
            response.map((data) => PlaceModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

  // Insert a new place
  static Future<Either<Failure, int>> insertPlace(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("places", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updateUnitData
  static Future<Either<Failure, int>> updatePlaceData(
      Map<String, dynamic> place) async {
    final result = await DatabaseHelper.updateOrInsertData("places", place);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all places
  static Future<Either<Failure, int>> deleteAllPlaces() async {
    final result = await DatabaseHelper.delete("places");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deletePlacesViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("places", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
