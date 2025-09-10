import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/get_all_currencies.dart';
import 'package:almonazim/core/helper/functions/unit%20functions/get_all_units.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_batches.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_buildings.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_business.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_business_currency.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_categories.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_clients.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_currencies.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_partners.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_places.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_prices.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_product_taxes.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_taxes.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_units.dart';
import 'package:almonazim/data/data%20source/locale/store_default_building.dart';
import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
import 'package:almonazim/data/data%20source/repo/general%20repo/general_repo.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:almonazim/data/model/place%20models/building_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';

class GeneralRepoImpl implements GeneralRepo {
  final ApiService apiService;
  GeneralRepoImpl(this.apiService);
  @override
  Future<Either<Failure, void>> getOfflineData() async {
    final result = await apiService.get(
      url: AppLinks.getOfflineData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        //& business
        // delete first
        await StoreBusiness.deleteBusinessById(
            StoreUserModel.instance.businessId!);
        // insert second
        await StoreBusiness.insertBusiness(response["data"]["business"][0]);

        //& units
        List<int> unitIds = [];
        for (final unit in response["data"]["units"] ?? []) {
          unitIds.add(unit['units_id']);
          await StoreUnits.updateUnitData(unit);
        }
        await StoreUnits.deleteUnitsViaIdList(unitIds);
        getAllUnits();
        //& category
        List<int> categoryIds = [];
        for (final category in response["data"]["categories"] ?? []) {
          categoryIds.add(category['categories_id']);
          await StoreCategories.updateCategoryData(category);
        }
        await StoreCategories.deleteCategoriesViaIdList(categoryIds);

        //& product
        List<int> productIds = [];
        for (final product in response["data"]["products"] ?? []) {
          productIds.add(product['products_id']);
          await StoreProducts.updateProductData(product);
        }
        await StoreProducts.deleteProductsViaIdList(productIds);
        //& price
        List<int> priceIds = [];
        for (final price in response["data"]["prices"] ?? []) {
          priceIds.add(price['prices_id']);
          await StorePrices.updatePriceData(price);
        }
        await StorePrices.deletePricesViaIdList(priceIds);

        //& buildings & places
        List<int> buildingIds = [];
        List<int> placeIds = [];

        for (final item in response["data"]["buildings_and_places"] ?? []) {
          buildingIds.add(item['buildings_id']);
          placeIds.add(item['places_id']);
          await StoreBuildings.updateBuildingData(
              BuildingModel.fromJson(item).toMap());
          await StorePlaces.updatePlaceData(PlaceModel.fromJson(item).toMap());
        }
        await StoreBuildings.deleteBuildingsViaIdList(buildingIds);
        await StorePlaces.deletePlacesViaIdList(placeIds);
        if (buildingIds.length == 1) {
          StoreDefaultBuilding.setDefaultBuilding(
              InvoiceType.sell.name, buildingIds[0].toString());
          StoreDefaultBuilding.setDefaultBuilding(
              InvoiceType.buy.name, buildingIds[0].toString());
        }
        //& clients
        List<int> clientIds = [];
        for (final client in response["data"]["clients"] ?? []) {
          clientIds.add(client['clients_id']);
          await StoreClients.updateClientData(client);
        }
        await StoreClients.deleteClientsViaIdList(clientIds);
        //& partners
        List<int> partnerIds = [];
        for (final partner in response["data"]["partners"]) {
          partnerIds.add(partner['partners_id']);
          await StorePartners.updatePartnerData(partner);
        }
        await StorePartners.deletePartnersViaIdList(partnerIds);
        //& invoice Number
        if (response["data"]["latest_invoice_numbers"] != null) {
          for (final entry
              in (response["data"]["latest_invoice_numbers"] as Map).entries) {
            await StoreInvoiceNumber.setLatestInvoiceNumber(
                entry.key, entry.value);
          }
        }
        //& taxes
        if (response["data"]["taxes"] != null) {
          List<int> taxIds = [];
          List<int> productTaxesIds = [];
          for (final item in response["data"]["taxes"]) {
            taxIds.add(item['taxes_id']);
            productTaxesIds.add(item['product_taxes_id']);
            await StoreTaxes.updateTaxData(TaxesModel.fromJson(item).toJson());
            await StoreProductTaxes.updateProductTaxData(
                ProductTaxModel.fromJson(item).toStoring());
          }
          await StoreTaxes.deleteTaxesViaIdList(taxIds);
          await StoreProductTaxes.deleteProductTaxesViaIdList(productTaxesIds);
        }
        //& currencies
        if (response["data"]["currencies"] != null) {
          List<int> currencyIds = [];
          List<int> businessCurrencyIds = [];

          for (final currency in response["data"]["currencies"]) {
            var currencyModel = CurrencyModel.fromJson(currency);
            currencyIds.add(currencyModel.currenciesId!);
            await StoreCurrencies.updateCurrencyData(
                currencyModel.toCurrency());
            if (currencyModel.businessCurrencyId != null) {
              businessCurrencyIds.add(currencyModel.businessCurrencyId!);
              await StoreBusinessCurrency.updateBusinessCurrencyData(
                  currencyModel.toBusinessCurrency());
            }
          }
          await StoreCurrencies.deleteCurrenciesViaIdList(currencyIds);
          await StoreBusinessCurrency.deleteBusinessCurrencyViaIdList(
              businessCurrencyIds);
        }
        getAllCurrencies();
        //& batches
        await StoreBatches.deleteAllBatches();
        if (response["data"]["batches"] != null) {
          for (final batch in response["data"]["batches"]) {
            await StoreBatches.insertBatch(batch);
          }
        }
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, String>> getLatestVersion() async {
    final result = await apiService.get(url: AppLinks.getLatestVersion);

    return result.fold(
      (failure) => left(failure),
      (response) => right(response["data"]),
    );
  }

  @override
  Future<Either<Failure, void>> doneImportData() async {
    final result = await apiService.get(url: AppLinks.doneImportDataLink);

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }
}
