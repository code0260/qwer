import 'package:almonazim/core/device/device_utility.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_units.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:dartz/dartz.dart';

Future<void> getAllUnits() async {
  Either<Failure, void> result;
  if (StoreWorkOffline.getWorkOffline() == true ||
      (StoreWorkOffline.getWorkOffline() == false &&
          await AppDevice.checkInternetFunction() == false)) {
    result = await StoreUnits.getAllUnits();
  } else {
    result = await getIt.get<UnitRepoImpl>().getAllUnits();
  }
  result.fold((l) {
    // mySnackBar(
    //   ToastificationType.error,
    //   "خطأ",
    //   l.errMessage,
    // );
  }, (r) => null);
}
