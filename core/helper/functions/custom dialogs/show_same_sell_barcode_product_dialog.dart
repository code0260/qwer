import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/view/widget/cart/shared%20cart/same_sell_barcode_product_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showSameSellBarcodeProductDialog(List<SellItemModel> items) {
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
          child: SameSellBarcodeProductBody(
            items: items,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: const [
          CancelButton(),
        ],
      );
    },
  );
}
