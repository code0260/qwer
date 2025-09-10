import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';

class StoreBusinessCurrency {
  StoreBusinessCurrency._();

  // Search for businessCurrency by name
  static Future<Either<Failure, List<CurrencyModel>>> searchBusinessCurrency(
      String query) async {
    final result = await DatabaseHelper.query(
      "business_currency",
      where: "business_currency_name_ar LIKE ?",
      whereArgs: ['%$query%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<CurrencyModel> searchResults =
            response.map((data) => CurrencyModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

  // Get all businessCurrency
  static Future<Either<Failure, List<CurrencyModel>>>
      getAllBusinessCurrency() async {
    final result = await DatabaseHelper.query("business_currency");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<CurrencyModel> businessCurrencyList =
            response.map((data) => CurrencyModel.fromJson(data)).toList();
        return right(businessCurrencyList);
      },
    );
  }

  // Insert a new currency
  static Future<Either<Failure, int>> insertBusinessCurrency(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("business_currency", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, List<CurrencyModel>>>
      getOfflineCurrencies() async {
    final result = await DatabaseHelper.query(
      "business_currency",
      where: "business_currency_online = ?",
      whereArgs: [0],
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(
            response.map((data) => CurrencyModel.fromJson(data)).toList());
      },
    );
  }

  // Search for business_currency by name
  static Future<Either<Failure, CurrencyModel>> getBusinessCurrencyById(
      int id) async {
    final result = await DatabaseHelper.query(
      "business_currency",
      where: "business_currency_id = ?",
      whereArgs: [id], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(CurrencyModel.fromJson(response[0]));
      },
    );
  }

  static Future<Either<Failure, void>> updateCurrencyOffline(int oldId) async {
    var result = await DatabaseHelper.update(
      "business_currency",
      {"business_currency_online": 1},
      where: "business_currency_id = ?",
      whereArgs: [oldId],
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  // Delete all businessCurrency
  static Future<Either<Failure, int>> deleteAllBusinessCurrency() async {
    final result = await DatabaseHelper.delete("business_currency");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updateBusinessCurrencyData
  static Future<Either<Failure, int>> updateBusinessCurrencyData(
      Map<String, dynamic> businessCurrency) async {
    final result = await DatabaseHelper.updateOrInsertData(
        "business_currency", businessCurrency);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteBusinessCurrencyViaIdList(
      List<int> list) async {
    final result =
        await DatabaseHelper.deleteViaIdList("business_currency", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
