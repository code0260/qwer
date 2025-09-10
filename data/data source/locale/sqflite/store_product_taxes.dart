import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart'; // Adjust the import path based on your actual model
import 'package:dartz/dartz.dart';

class StoreProductTaxes {
  StoreProductTaxes._(); // Private constructor to prevent instantiation

  // Fetch product taxes by product ID
  static Future<Either<Failure, List<ProductTaxModel>>>
      getProductTaxesByProductId(int productId) async {
    final result = await DatabaseHelper.query(
      "product_taxes",
      where: "product_taxes_product_id = ?",
      whereArgs: [productId],
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ProductTaxModel> taxesList =
            response.map((data) => ProductTaxModel.fromJson(data)).toList();
        return right(taxesList);
      },
    );
  }

  // Insert a new product tax mapping
  static Future<Either<Failure, int>> insertProductTax(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("product_taxes", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete product taxes by product ID
  static Future<Either<Failure, int>> deleteProductTaxesByProductId(
      int productId) async {
    final result = await DatabaseHelper.delete(
      "product_taxes",
      where: "product_taxes_product_id = ?",
      whereArgs: [productId],
    );

    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete product taxes by product ID
  static Future<Either<Failure, int>> deleteAllProductTaxes() async {
    final result = await DatabaseHelper.delete("product_taxes");

    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Fetch all product taxes with details (join with taxes and products tables)
  static Future<Either<Failure, List<Map<String, dynamic>>>>
      fetchAllProductTaxesWithDetails() async {
    const query = '''
      SELECT * 
      FROM product_taxes
      LEFT JOIN taxes ON product_taxes.product_taxes_tax_id = taxes.taxes_id
      LEFT JOIN products ON product_taxes.product_taxes_product_id = products.products_id
    ''';

    final result = await DatabaseHelper.rawQuery(query);

    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updateProductTaxData
  static Future<Either<Failure, int>> updateProductTaxData(
      Map<String, dynamic> productTax) async {
    final result =
        await DatabaseHelper.updateOrInsertData("product_taxes", productTax);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteProductTaxesViaIdList(
      List<int> list) async {
    final result =
        await DatabaseHelper.deleteViaIdList("product_taxes", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
