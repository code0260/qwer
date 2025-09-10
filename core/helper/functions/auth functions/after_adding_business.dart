import 'dart:io';

import 'package:almonazim/core/helper/functions/other%20functions/request_permissions.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void afterAddingBusiness() async {
  // notification
  if (!Platform.isWindows) {
    FirebaseMessaging.instance.subscribeToTopic("users");
    FirebaseMessaging.instance
        .subscribeToTopic("users${StoreUserModel.instance.usersId}");
  }
  requestPermissions();
  StoreStep.setStep("2");
}
