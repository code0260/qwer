import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/helper/functions/other%20functions/copy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

Future<double?> showCalculator(context) {
  return showDialog<double?>(
    context: context,
    builder: (context) => AlertDialog(
      icon: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.cancel,
              size: 40,
            ),
          ],
        ),
      ),
      content: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: AppDesignEndpoint.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 3,
          child: SimpleCalculator(
            onTappedDisplay: (number, value) {
              copyText(number.toString());
              Get.back(result: number);
            },
            theme: CalculatorThemeData(
                borderColor: AppColor.whiteMainReverse,
                borderWidth: 1,
                operatorColor: AppColor.primaryColor),
          )),
    ),
  );
}
