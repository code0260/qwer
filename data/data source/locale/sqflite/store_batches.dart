import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/batch_model.dart';
import 'package:dartz/dartz.dart';

class StoreBatches {
  StoreBatches._();

  // Search for batches by product ID or other criteria
  static Future<Either<Failure, BatchModel>> getBatchById(int id) async {
    final result = await DatabaseHelper.query(
      "batches",
      where: "batches_id = ?", // You can adjust this to other fields as needed
      whereArgs: ['%$id%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(BatchModel.fromJson(response[0]));
      },
    );
  }

  // Get all batches
  static Future<Either<Failure, List<BatchModel>>> getBatches() async {
    final result = await DatabaseHelper.query("batches");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<BatchModel> gotResults =
            response.map((data) => BatchModel.fromJson(data)).toList();
        return right(gotResults);
      },
    );
  }

  static Future<Either<Failure, List<BatchModel>>> getProductBatches(
      int productsId) async {
    final result = await DatabaseHelper.query("batches",
        where: " batches_products_id = ?", whereArgs: [productsId]);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<BatchModel> gotResults =
            response.map((data) => BatchModel.fromJson(data)).toList();
        return right(gotResults);
      },
    );
  }

  // Insert a new batch
  static Future<Either<Failure, int>> insertBatch(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("batches", value);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }

  // Delete all batches
  static Future<Either<Failure, int>> deleteAllBatches() async {
    final result = await DatabaseHelper.delete("batches");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }
}
