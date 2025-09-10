import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo_imp.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';

Future<int?> syncOfflineProducts() async {
  // Fetch all offline products
  var result = await StoreProducts.getOfflineProducts();
  return result.fold(
    (failure) => throw Exception(failure.errMessage),
    (offlineProducts) async {
      if (offlineProducts.isNotEmpty) {
        // Convert offline products to input models
        List<ProductInputModel> productsToSend =
            offlineProducts.map((productModel) {
          return ProductInputModel(
            productsId: productModel.productsId,
            productsName: productModel.productsName,
            productsType: productModel.productsType,
            productsActive: productModel.productsActive,
            productsBarcode: productModel.productsBarcode,
            productsCategories: productModel.productsCategories,
            productsDescription: productModel.productsDescription,
            productsBaseUnitId: productModel.productsBaseUnitId,
            productsBusinessId: productModel.productsBusinessId,
          );
        }).toList();

        // Send products to the server
        var response = await getIt
            .get<ProductsRepoImpl>()
            .addMultipleProduct(productsToSend);

        return response.fold(
          (failure) =>
              throw Exception("فشل في مزامنة المنتجات: ${failure.errMessage}"),
          (idMap) async {
            // Update local database with new IDs
            for (var productModel in offlineProducts) {
              int originalId = productModel.productsId!;
              String? newId = idMap["$originalId"];
              if (newId != null) {
                await StoreProducts.updateProductId(originalId, newId.toInt());
              }
            }
            return 1;
          },
        );
      }
      return null;
    },
  );
}
