import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_product_taxes.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_taxes.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_taxes_input_model.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_model.dart';
import 'package:dartz/dartz.dart';

class ProductTaxesRepoImpl implements ProductTaxesRepo {
  final ApiService apiService;
  ProductTaxesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductTaxModel>>> getProductTaxes(
      int? productsId) async {
    var requestData = {"products_id": productsId};
    final result = await apiService.post(
      formDataIsEnabled: true,
      data: requestData,
      url: AppLinks.getProductTaxesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ProductTaxModel> taxesLocale = [];
        for (final tax in response["data"]) {
          taxesLocale.add(ProductTaxModel.fromJson(tax));
        }
        return right(taxesLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteProductTax(int productsTaxesId) async {
    final result = await apiService.post(
        url: AppLinks.deleteProductTaxLink,
        formDataIsEnabled: true,
        data: {"product_taxes_id": productsTaxesId});

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> addProductTax(
      ProductTaxesInputModel productTaxInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addProductTaxesLink,
        data: productTaxInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importProductTaxes(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importProductTaxesLink,
        requestName: "product_taxes_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("17"); //!
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editProductTax(
      ProductTaxesInputModel productTaxInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editProductTaxesLink,
        data: productTaxInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, List<ProductTaxModel>>> getAllProductTaxes() async {
    final result = await apiService.get(
      url: AppLinks.getProductTaxesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        List<int> taxIds = [];
        List<int> productTaxesIds = [];
        List<ProductTaxModel> productTaxesLocale = [];
        for (final item in response["data"]) {
          taxIds.add(item['taxes_id']);
          productTaxesIds.add(item['product_taxes_id']);
          await StoreTaxes.updateTaxData(TaxesModel.fromJson(item).toJson());
          await StoreProductTaxes.updateProductTaxData(
              ProductTaxModel.fromJson(item).toStoring());
          productTaxesLocale.add(ProductTaxModel.fromJson(item));
        }
        await StoreTaxes.deleteTaxesViaIdList(taxIds);
        await StoreProductTaxes.deleteProductTaxesViaIdList(productTaxesIds);
        return right(productTaxesLocale);
      },
    );
  }
}
