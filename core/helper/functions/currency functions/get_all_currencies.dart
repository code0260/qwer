import 'package:almonazim/core/device/device_utility.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_currencies.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo_imp.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';

Future<void> getAllCurrencies() async {
  Either<Failure, List<CurrencyModel>> result;
  if (StoreWorkOffline.getWorkOffline() == true ||
      (await AppDevice.checkInternetFunction() == false)) {
    result = await StoreCurrencies.getAllCurrencies();
  } else {
    result = await getIt.get<CurrencyRepoImpl>().getBusinessCurrencies();
  }
  result.fold((l) {
    // mySnackBar(
    //   ToastificationType.error,
    //   "خطأ",
    //   l.errMessage,
    // );
  }, (r) {
    currencies = r;
    currentCurrencyModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
  });
}
