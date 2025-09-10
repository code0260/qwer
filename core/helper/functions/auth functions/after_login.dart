import 'dart:io';

import 'package:almonazim/core/constant/app_background_tasks.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/helper/functions/background%20functions/init_background_work.dart';
import 'package:almonazim/core/helper/functions/get_offline_data.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/notification%20functions/firebase_functions.dart';
import 'package:almonazim/core/helper/functions/offer%20functions/get_all_offers.dart';
import 'package:almonazim/core/helper/functions/other%20functions/request_permissions.dart';
import 'package:almonazim/core/helper/image_generator.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/data%20source/locale/store_default_invoice_payment_status.dart';
import 'package:almonazim/data/data%20source/locale/store_invoice_pdf_settings.dart';
import 'package:almonazim/data/data%20source/locale/store_show_overlay_icons.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:almonazim/data/data%20source/locale/store_task_time.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_pdf_settings_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> afterLogin() async {
  requestPermissions();
  await getIt.get<AccountRepoImpl>().getAllAccounts();
  await getOfflineData();
  await getAllOffers();
  StoreCountInvoice.setCountInvoice("1");
  StoreStep.setStep("3");
  StoreInvoicePdfSettings.setInvoicePdfSettings(const InvoicePdfSettingsModel(
      showInvoiceNotes: true,
      showTotalBalanceForClient: true,
      showTitle: true));
  await StoreShowOverlayIcons.setShowOverlayIcons(false);

  if (StoreUserModel.instance.businessImage != null) {
    await ImageGenerator.downloadAndSaveImage(
        "${AppLinks.imageLogoLink}/${StoreUserModel.instance.businessImage!}",
        StoreUserModel.instance.businessImage!);
  }
  await StoreTaskTime.setTaskTime(AppBackgroundTasks.refreshOfflineDataName,
      const TimeOfDay(hour: 3, minute: 0));
  await initBackgroundWork();

  await StoreDefaultInvoicePaymentStatus.setDefaultInvoicePaymentStatus('paid');

  // notification
  if (!Platform.isWindows) {
    FirebaseMessaging.instance.subscribeToTopic("users");
    FirebaseMessaging.instance
        .subscribeToTopic("users${StoreUserModel.instance.usersId}");
  }

  notificationPermission();
  listenFirebase();
}
