import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_business_currency.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_currencies.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo.dart';
import 'package:almonazim/data/model/currency%20models/currency_input_model.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';

class CurrencyRepoImpl implements CurrencyRepo {
  final ApiService apiService;
  CurrencyRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<CurrencyModel>>> getCurrencies() async {
    final result = await apiService.get(
      url: AppLinks.getCurrenciesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        List<int> currencyIds = [];
        List<CurrencyModel> currencies = [];
        for (final currency in response["data"]) {
          var currencyModel = CurrencyModel.fromJson(currency);
          currencyIds.add(currencyModel.currenciesId!);
          if (StoreStep.getStep() == '3') {
            await StoreCurrencies.updateCurrencyData(
                currencyModel.toCurrency());
          }
          if (currencyModel.businessCurrencyIsBase == 1) {
            currentCurrencyModel = currencyModel;
          }
          currencies.add(currencyModel);
        }

        if (StoreStep.getStep() == '3') {
          await StoreCurrencies.deleteCurrenciesViaIdList(currencyIds);
        }

        return right(currencies);
      },
    );
  }

  @override
  Future<Either<Failure, List<CurrencyModel>>> getBusinessCurrencies() async {
    final result = await apiService.get(
      url: AppLinks.getBusinessCurrenciesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        List<CurrencyModel> currencies = [];
        if (response["data"] != null) {
          List<int> currencyIds = [];
          List<int> businessCurrencyIds = [];

          for (final currency in response["data"]) {
            var currencyModel = CurrencyModel.fromJson(currency);
            currencyIds.add(currencyModel.currenciesId!);
            currencies.add(currencyModel);
            if (StoreStep.getStep() == '3') {
              await StoreCurrencies.updateCurrencyData(
                  currencyModel.toCurrency());
            }

            if (currencyModel.businessCurrencyId != null) {
              businessCurrencyIds.add(currencyModel.businessCurrencyId!);
              if (StoreStep.getStep() == '3') {
                await StoreBusinessCurrency.updateBusinessCurrencyData(
                    currencyModel.toBusinessCurrency());
              }
            }
          }

          if (StoreStep.getStep() == '3') {
            await StoreCurrencies.deleteCurrenciesViaIdList(currencyIds);
            await StoreBusinessCurrency.deleteBusinessCurrencyViaIdList(
                businessCurrencyIds);
          }
        }
        return right(currencies);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addCurrency(
      CurrencyInputModel currencyInputModel) async {
    final result = await apiService.post(
      url: AppLinks.addCurrencyLink,
      formDataIsEnabled: false,
      data: currencyInputModel.toJson(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editCurrency(
      CurrencyInputModel currencyInputModel) async {
    final result = await apiService.post(
      url: AppLinks.editCurrencyLink,
      formDataIsEnabled: false,
      data: currencyInputModel.toJson(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editMultipleCurrency(
      List<CurrencyInputModel> currencies) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editMultipleCurrenciesLink,
        data: {
          "currencies": currencies
              .map(
                (currencyModel) => currencyModel.toJson(),
              )
              .toList()
        });

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
