import 'dart:io';

import 'package:almonazim/data/model/profit%20report%20models/product%20profit%20models/get_product_profit_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<String> saveProductProfitReport(
    dynamic bytes, GetProductProfitModel getProductProfitModel,
    {bool autoOpen = true}) async {
  Directory tempDir = await getTemporaryDirectory();
  String savePath =
      '${tempDir.path}${r'\'}تقرير_أرباح_المنتجات ${getProductProfitModel.startDate.toString().substring(0, 10)}_${getProductProfitModel.endDate.toString().substring(0, 10)}.${getProductProfitModel.fileType!.name}';
  File file = File(savePath);
  await file.writeAsBytes(bytes);
  if (autoOpen) {
    await OpenFile.open(savePath);
  }
  return savePath;
}
