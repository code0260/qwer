import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/price%20models/price_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

class StorePrices {
  StorePrices._();

  // Search prices by name or description
  static Future<Either<Failure, List<PriceModel>>> searchPrices(
      String query) async {
    final result = await DatabaseHelper.query(
      "prices",
      where: "prices_name LIKE ? OR prices_description LIKE ?",
      whereArgs: [
        '%$query%',
        '%$query%'
      ], // Parameterized to avoid SQL injection
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        List<PriceModel> pricesList =
            response.map((price) => PriceModel.fromJson(price)).toList();
        return right(pricesList);
      },
    );
  }

  // Get all prices
  static Future<Either<Failure, List<PriceModel>>> getAllPrices() async {
    // Query to get all prices from the local database
    final result = await DatabaseHelper.query("prices");
    return result.fold(
      (failure) => left(failure),
      (response) async {
        List<PriceModel> prices = [];
        for (final price in response) {
          prices.add(PriceModel.fromJson(price));
        }
        // Return a success response with no specific value
        return right(prices);
      },
    );
  }

  // Insert a new price
  static Future<Either<Failure, int>> insertPrice(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert(
      "prices",
      value,
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Update a price by ID
  static Future<Either<Failure, int>> updatePrice(
      int priceId, Map<String, dynamic> values) async {
    final result = await DatabaseHelper.update(
      "prices",
      values,
      where: "prices_id = ?",
      whereArgs: [priceId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, List<PriceModel>>> getOfflinePrices() async {
    final result = await DatabaseHelper.query(
      "prices",
      where: "prices_online = ?",
      whereArgs: [0],
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(
            response.map((data) => PriceModel.fromJson(data)).toList());
      },
    );
  }

  static Future<Either<Failure, void>> updatePriceId(
      int oldId, int newId) async {
    var result = await DatabaseHelper.update(
        "prices", {"prices_id": newId, "prices_online": 1},
        where: "prices_id = ?",
        whereArgs: [oldId],
        conflictAlgorithm: ConflictAlgorithm.ignore);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  // Delete a price by ID
  static Future<Either<Failure, int>> deletePrice(int priceId) async {
    final result = await DatabaseHelper.delete(
      "prices",
      where: "prices_id = ?",
      whereArgs: [priceId],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all prices
  static Future<Either<Failure, int>> deleteAllPrices() async {
    final result = await DatabaseHelper.delete("prices");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Update price data
  static Future<Either<Failure, int>> updatePriceData(
      Map<String, dynamic> price) async {
    final result = await DatabaseHelper.updateOrInsertData("prices", price);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete multiple prices via a list of IDs
  static Future<Either<Failure, int>> deletePricesViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("prices", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }

  static Future<Either<Failure, void>> deleteOlderSellPrices() async {
    const String deleteQuery = '''
    DELETE FROM prices
    WHERE prices_type = 'sell'
      AND prices_id NOT IN (
        SELECT prices_id FROM (
          SELECT pr.prices_id
          FROM prices pr
          INNER JOIN (
            SELECT prices_products_id, prices_partner_en,
                   MAX(prices_createdAt) AS max_createdAt
            FROM prices
            WHERE prices_type = 'sell'
            GROUP BY prices_products_id, prices_partner_en
          ) latest_prices
          ON pr.prices_products_id = latest_prices.prices_products_id
          AND pr.prices_partner_en = latest_prices.prices_partner_en
          AND pr.prices_createdAt = latest_prices.max_createdAt
          AND pr.prices_type = 'sell'
        )
      );
  ''';

    final result = await DatabaseHelper.execute(deleteQuery);
    return result.fold(
      (failure) => left(failure),
      (_) => right(null), // success, no return value needed
    );
  }
}
