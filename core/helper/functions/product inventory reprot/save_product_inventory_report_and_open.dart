import 'dart:io';

import 'package:almonazim/data/model/inventory%20report%20models/product%20profit%20models/get_product_inventory_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveInventoryReportAndOpen(
    bytes, GetProductInventoryModel getProductInventoryModel) async {
  Directory tempDir = await getTemporaryDirectory();
  String savePath =
      '${tempDir.path}/تقرير_جرد_المنتجات.${getProductInventoryModel.fileType!.name}';
  File file = File(savePath);
  await file.writeAsBytes(bytes);
  await OpenFile.open(savePath);
}
