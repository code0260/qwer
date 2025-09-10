import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_model.dart';
import 'package:dartz/dartz.dart';

class StoreTaxes {
  StoreTaxes._(); // Private constructor to prevent instantiation

  // Search for taxes by name or other criteria
  static Future<Either<Failure, List<TaxesModel>>> searchTaxes(
      String taxName) async {
    final result = await DatabaseHelper.query(
      "taxes",
      where: "taxes_name LIKE ?",
      whereArgs: ['%$taxName%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<TaxesModel> searchResults =
            response.map((data) => TaxesModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

  // Insert a new tax record
  static Future<Either<Failure, int>> insertTax(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("taxes", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all tax records
  static Future<Either<Failure, int>> deleteAllTaxes() async {
    final result = await DatabaseHelper.delete("taxes");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // updateTaxData
  static Future<Either<Failure, int>> updateTaxData(
      Map<String, dynamic> tax) async {
    final result = await DatabaseHelper.updateOrInsertData("taxes", tax);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteTaxesViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("taxes", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
