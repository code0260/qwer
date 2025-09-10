import 'package:almonazim/core/constant/app_routes.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    String? step = StoreStep.getStep();
    if (step == '1') {
      return const RouteSettings(name: AppRoute.loginScreen);
    } else if (step == "2") {
      return const RouteSettings(name: AppRoute.helpStepsScreen);
    } else if (step == "3") {
      // if (StoreUserModel.instance.usersType == 'admin') {
      return const RouteSettings(
          name: AppRoute.baseScreen, arguments: {"initialIndex": 0});
      // } else {
      //   return const RouteSettings(name: AppRoute.eHomeScreen);
      // }
    } else {
      return null;
    }
  }
}
