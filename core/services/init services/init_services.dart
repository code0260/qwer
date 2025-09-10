import 'dart:io';

import 'package:almonazim/core/helper/functions/background%20functions/init_background_work.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/get_all_currencies.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/is_there_offline_invoices.dart';
import 'package:almonazim/core/helper/functions/notification%20functions/firebase_functions.dart';
import 'package:almonazim/core/helper/functions/offer%20functions/get_all_offers.dart';
import 'package:almonazim/core/helper/functions/unit%20functions/get_all_units.dart';
import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:almonazim/data/data%20source/locale/store_token.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/model/almonazim_data_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:almonazim/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class InitServices {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    initGetIt();
    sqfliteFfiInit();
    if (Platform.isWindows) {
      databaseFactory = databaseFactoryFfi;
    }

    await PrefStorage.init();
    await PdfGenerator.init();
    await DatabaseHelper.init();

    // PrefStorage.clearPreferencesData();
    Jiffy.setLocale("ar");
    StoreUserModel.init();
    AlmonazimDataModel.init();
    await testing();
    if (StoreStep.getStep() == "2" || StoreStep.getStep() == "3") {
      isThereOfflineInvoices().then((value) async {
        workingOffline = value;
        await StoreWorkOffline.setWorkOffline(value);
      });

      // after login in
      notificationPermission();
      listenFirebase();
      await StoreToken.initTokenVariable();
      await getAllUnits();
      await getAllCurrencies();
      await getAllOffers();
      // background work
      await initBackgroundWork();
    }
  }

  static Future<void> testing() async {
    //$ testing:
    // StoreInsertDateSteps.removeStep("4");
    // print(StoreInsertDateSteps.getDoneSteps());
    // StoreStep.setStep("1");
    // print(StoreStep.getStep());
    // StoreStep.setStep('3');
    // await StoreToken.storeToken(TokenModel(
    //   refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ5b3VyX2RvbWFpbi5jb20iLCJhdWQiOiJtb2JpbGUgYXBwbGljYXRpb24iLCJpYXQiOjE3MTc0MTk3NzMsIm5iZiI6MTcxNzQxOTc3MywiZGF0YSI6eyJ1c2Vyc19pZCI6MSwidXNlcnNfY3JlYXRlZEF0IjoiMjAyMy0xMS0xMSAyMjo1MTo0OSIsInVzZXJzX25hbWUiOiJsZWVuIiwidXNlcnNfcGhvbmUiOiI1NDU0NTQ1NDUiLCJidXNpbmVzc19pZCI6MSwiYnVzaW5lc3NfbmFtZSI6Ilx1MDYyN1x1MDY0NFx1MDYyZVx1MDYzN1x1MDYyN1x1MDYyOCIsImJ1c2luZXNzX2FkZHJlc3MiOiJcdTA2MzFcdTA2NDNcdTA2NDYgXHUwNjI3XHUwNjQ0XHUwNjJmXHUwNjRhXHUwNjQ2IiwiYnVzaW5lc3NfaW1hZ2UiOiJcdTA2NGFcdTA2MjdcdTA2MjhcdTA2NGFcdTA2MjdcdTA2MzMiLCJidXNpbmVzc19hcHByb3ZlIjoxLCJyZWZyZXNoX3Rva2VuX2lkIjo3OTc2MTkwN319.lqk16-I9exLQcM8G5uwazz7JFBdvdQtcSsWKNDcVXBg",
    //     accessToken:
    //         "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ5b3VyX2RvbWFpbi5jb20iLCJhdWQiOiJtb2JpbGUgYXBwbGljYXRpb24iLCJpYXQiOjE3MTc0MDY1OTksIm5iZiI6MTcxNzQwNjU5OSwiZXhwIjoxNzE3NDEwMTk5LCJkYXRhIjp7InVzZXJzX2lkIjoxLCJ1c2Vyc19jcmVhdGVkQXQiOiIyMDIzLTExLTExIDIyOjUxOjQ5IiwidXNlcnNfbmFtZSI6ImxlZW4iLCJ1c2Vyc19waG9uZSI6IjU0NTQ1NDU0NSIsImJ1c2luZXNzX2lkIjoxLCJidXNpbmVzc19uYW1lIjoiXHUwNjI3XHUwNjQ0XHUwNjJlXHUwNjM3XHUwNjI3XHUwNjI4IiwiYnVzaW5lc3NfYWRkcmVzcyI6Ilx1MDYzMVx1MDY0M1x1MDY0NiBcdTA2MjdcdTA2NDRcdTA2MmZcdTA2NGFcdTA2NDYiLCJidXNpbmVzc19pbWFnZSI6Ilx1MDY0YVx1MDYyN1x1MDYyOFx1MDY0YVx1MDYyN1x1MDYzMyIsImJ1c2luZXNzX2FwcHJvdmUiOjF9fQ.nmh7J2-QiKU8wYBHYY6fzp_dzcIeTYraLCUYtDOuL9o"));
  }

  static Future<void> initBackgroundData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    initGetIt();
    sqfliteFfiInit();
    if (Platform.isWindows) {
      databaseFactory = databaseFactoryFfi;
    }
    await PrefStorage.init();
    await PdfGenerator.init();
    await DatabaseHelper.init();
    // await PrefStorage.clearPreferencesData();
    Jiffy.setLocale("en");
    StoreUserModel.init();
    AlmonazimDataModel.init();

    if (StoreStep.getStep() == "2") {
      // after login in
      await StoreToken.initTokenVariable();
      await getAllUnits();
      await getAllCurrencies();
    }
  }
}
