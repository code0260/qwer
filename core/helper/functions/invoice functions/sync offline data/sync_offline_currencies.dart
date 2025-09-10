import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_business_currency.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo_imp.dart';
import 'package:almonazim/data/model/currency%20models/currency_input_model.dart';

Future<int?> syncOfflineBusinessCurrency() async {
  // Fetch all offline currencies
  var result = await StoreBusinessCurrency.getOfflineCurrencies();
  return result.fold(
    (failure) => throw Exception(failure.errMessage),
    (offlineBusinessCurrency) async {
      if (offlineBusinessCurrency.isNotEmpty) {
        // Convert offline currencies to input models
        List<CurrencyInputModel> currenciesToSend =
            offlineBusinessCurrency.map((currencyModel) {
          return CurrencyInputModel(
            businessCurrencyId: currencyModel.businessCurrencyId,
            businessCurrencyBusinessId:
                currencyModel.businessCurrencyBusinessId,
            businessCurrencyCurrenciesId:
                currencyModel.businessCurrencyCurrenciesId,
            businessCurrencyIsBase: currencyModel.businessCurrencyIsBase,
            businessCurrencyManualExchange:
                currencyModel.businessCurrencyManualExchange,
            businessCurrencyNearFactor:
                currencyModel.businessCurrencyNearFactor,
          );
        }).toList();

        // Send currencies to the server
        var response = await getIt
            .get<CurrencyRepoImpl>()
            .editMultipleCurrency(currenciesToSend);

        return response.fold(
          (failure) =>
              throw Exception("فشل في مزامنة العملات: ${failure.errMessage}"),
          (_) async {
            // Update local database with new IDs
            for (var currencyModel in offlineBusinessCurrency) {
              int originalId = currencyModel.businessCurrencyId!;
              await StoreBusinessCurrency.updateCurrencyOffline(originalId);
            }

            return null;
          },
        );
      }
      return null;
    },
  );
}
