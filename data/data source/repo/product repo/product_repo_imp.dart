import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo.dart';
import 'package:almonazim/data/model/product%20models/add_product_model.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ApiService apiService;

  ProductsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(
      int category, int requestNumber) async {
    final requestData = {
      "categories_id": category,
      "request_number": requestNumber,
    };

    final result = await apiService.post(
      url: AppLinks.getProductsLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final List<ProductModel> products = response["data"]
            .map<ProductModel>((product) => ProductModel.fromJson(product))
            .toList();
        return right(products);
      },
    );
  }

  @override
  Future<Either<Failure, void>> refreshProducts() async {
    final result = await apiService.get(
      url: AppLinks.refreshProductsLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        List<int> productIds = [];
        for (final product in response["data"]) {
          productIds.add(product['products_id']);
          await StoreProducts.updateProductData(product);
        }
        await StoreProducts.deleteProductsViaIdList(productIds);
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importProducts(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importProductsLink,
        requestName: "products_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("4");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addProduct(
      AddProductModel addProductModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addProductLink,
        data: addProductModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) async {
        ProductInputModel productInputModel = addProductModel.productInputModel;
        productInputModel.productsId = (response['data'] as String).toInt();
        productInputModel.productsBusinessId =
            StoreUserModel.instance.businessId!;
        productInputModel.productsOnline = 1;
        var insertProductResult =
            await StoreProducts.insertProduct(productInputModel.toMap());
        return insertProductResult.fold((l) => right(null), (r) => right(null));
      },
    );
  }

  @override
  Future<Either<Failure, void>> editProduct(
      ProductInputModel productInputModel) async {
    final result = await apiService.post(
        url: AppLinks.editProductLink,
        formDataIsEnabled: false,
        data: productInputModel.toMap());

    return result.fold((failure) => left(failure), (response) {
      return right(null);
    });
  }

  @override
  Future<Either<Failure, Map>> addMultipleProduct(
      List<ProductInputModel> products) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addMultipleProductsLink,
        data: {
          "products": products
              .map(
                (productModel) => productModel.toMap(),
              )
              .toList()
        });

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response["data"]);
      },
    );
  }

  //? improve code for future (EDIT PRODUCT):
  // for (final productCategory in productsByCategory.entries) {
  //       for (final product in productCategory.value.entries) {
  //         if (product.key == "products") {
  //           for (final (lastProduct as ProductModel) in product.value) {
  //             if (lastProduct.productsId == productInputModel.productsId) {
  //               if (productInputModel.productsActive != null) {
  //                 lastProduct.productsActive ==
  //                     productInputModel.productsActive;
  //               }
  //                 lastProduct.productsActive ==
  //                     productInputModel.productsActive;
  //             }
  //           }
  //         }
  //       }
  //     }
}
