import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';

class StoreCurrencies {
  StoreCurrencies._();

  // Search for currencies by name
  static Future<Either<Failure, List<CurrencyModel>>> searchCurrencies(
      String query) async {
    final result = await DatabaseHelper.query(
      "currencies",
      where: "currencies_name_ar LIKE ?",
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

  // Get all currencies
  static Future<Either<Failure, List<CurrencyModel>>> getAllCurrencies() async {
    final result = await DatabaseHelper.query("currency_view");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<CurrencyModel> currenciesList =
            response.map((data) => CurrencyModel.fromJson(data)).toList();
        return right(currenciesList);
      },
    );
  }

  // Insert a new currency
  static Future<Either<Failure, int>> insertCurrency(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("currencies", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all currencies
  static Future<Either<Failure, int>> deleteAllCurrencies() async {
    final result = await DatabaseHelper.delete("currencies");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updateCurrencyData
  static Future<Either<Failure, int>> updateCurrencyData(
      Map<String, dynamic> currency) async {
    final result =
        await DatabaseHelper.updateOrInsertData("currencies", currency);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteCurrenciesViaIdList(
      List<int> list) async {
    final result =
        await DatabaseHelper.deleteViaIdList("currencies", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
