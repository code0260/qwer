import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:dartz/dartz.dart';

class StoreBusiness {
  StoreBusiness._();

  /// Retrieves all businesses from the database.
  static Future<Either<Failure, List<Map<String, dynamic>>>>
      getBusinesses() async {
    final result = await DatabaseHelper.query("business");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  /// Retrieves a single business by its ID.
  static Future<Either<Failure, Map<String, dynamic>?>> getBusinessById(
      int id) async {
    final result = await DatabaseHelper.query(
      "business",
      where: "business_id = ?",
      whereArgs: [id], // Avoids SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) => right(response.isNotEmpty ? response.first : null),
    );
  }

  /// Inserts a new business record into the database.
  static Future<Either<Failure, int>> insertBusiness(
      Map<String, dynamic> values) async {
    final result = await DatabaseHelper.insert("business", values);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  /// Deletes a business record by its ID.
  static Future<Either<Failure, int>> deleteBusinessById(int id) async {
    final result = await DatabaseHelper.delete(
      "business",
      where: "business_id = ?",
      whereArgs: [id], // Avoids SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }
}
