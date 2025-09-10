import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/view/widget/cart/shared%20cart/same_buy_barcode_product_bod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showSameBuyBarcodeProductDialog(List<BuyItemModel> items) {
  return showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
          title: const Text('اختر منتج'),
          content: SizedBox(
            width: double.maxFinite,
            // Setting max height for the dialog content
            height: MediaQuery.of(context).size.height / 3,
            child: SameBuyBarcodeProductBody(
              items: items,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: const [
            CancelButton(),
          ]);
    },
  );
}
