import 'package:almonazim/core/helper/functions/invoice%20functions/is_there_offline_invoices.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_prices.dart';

Future<void> deleteUnusedPrice() async {
  if (!await isThereOfflineInvoices()) {
    final deleteResult = await StorePrices.deleteOlderSellPrices();
    deleteResult.fold((failure) => null, (_) => null);
  } else {}
}
