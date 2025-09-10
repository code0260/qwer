import 'dart:io';

import 'package:almonazim/core/constant/app_routes.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/cubits/notifications%20cubits/get%20notifications%20cubit/get_notifications_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

void listenFirebase() {
  if (Platform.isWindows) {
    return;
  }
  FirebaseMessaging.onMessage.listen((message) async {
    mySnackBar(
        ToastificationType.warning,
        message.notification?.title.toString() ?? '',
        message.notification?.body.toString() ?? '');
    if (Get.currentRoute == AppRoute.notificationScreen) {
      notificationsContext.read<GetNotificationsCubit>().refresh();
    }
  });
}

Future<void> notificationPermission() async {
  // NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
