import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_prices.dart';
import 'package:almonazim/data/data%20source/repo/prices%20repo/prices_repo_imp.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';

Future<int?> syncOfflineSellPrices() async {
  // Fetch all offline prices
  var result = await StorePrices.getOfflinePrices();
  return result.fold(
    (failure) => throw Exception(failure.errMessage),
    (offlinePrices) async {
      if (offlinePrices.isNotEmpty) {
        // Convert offline prices to input models
        List<PriceInputModel> pricesToSend = offlinePrices.map((priceModel) {
          return PriceInputModel(
              pricesAmountCurrencyId: priceModel.pricesAmountCurrencyId,
              pricesId: priceModel.pricesId,
              pricesType: priceModel.pricesType,
              pricesUnitPrice: priceModel.pricesUnitPrice,
              pricesPartnerAr: priceModel.pricesPartnerAr,
              pricesPartnerEn: priceModel.pricesPartnerEn,
              pricesProductsId: priceModel.pricesProductsId);
        }).toList();

        // Send prices to the server
        var response =
            await getIt.get<PricesRepoImpl>().getRelatedPricesIds(pricesToSend);

        return response.fold(
          (failure) =>
              throw Exception("فشل في مزامنة الأسعار: ${failure.errMessage}"),
          (idMap) async {
            // Update local database with new IDs
            for (var priceModel in offlinePrices) {
              int originalId = priceModel.pricesId!;
              String? newId = idMap["$originalId"];
              if (newId != null) {
                await StorePrices.updatePriceId(originalId, newId.toInt());
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
