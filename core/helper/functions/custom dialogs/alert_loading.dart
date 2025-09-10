import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void alertLoading() {
  Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: AppColor.whiteBlackSame,
    title: '',
    content: const Padding(
      padding: EdgeInsets.only(bottom: 35.0),
      child: PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    ),
  );
}
