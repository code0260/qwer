import 'dart:io';

import 'package:almonazim/data/model/client%20models/client_debt_report_input_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveClientDebtReportAndOpen(dynamic bytes,
    ClientDebtReportInputModel clientDebtReportInputModel) async {
  Directory tempDir = await getTemporaryDirectory();
  String savePath =
      '${tempDir.path}/تقرير_الديون.${clientDebtReportInputModel.fileType!.name}';
  File file = File(savePath);
  await file.writeAsBytes(bytes);
  await OpenFile.open(savePath);
}
