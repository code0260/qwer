import 'dart:io';

import 'package:almonazim/core/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';

class PdfGenerator {
  static late Font boldFont;
  static late Font normalFont;

  static dynamic init() async {
    boldFont = Font.ttf(
      (await rootBundle.load(Assets.assetsFontsAmiriAmiriBold)),
    );
    normalFont = Font.ttf(
      (await rootBundle.load(Assets.assetsFontsAmiriAmiriRegular)),
    );
  }

  static Future<void> openPdf(File file) async {
    final path = file.path;
    await OpenFile.open(path);
  }

  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name.pdf');
    await file.writeAsBytes(await pdf.save());
    debugPrint('${root.path}/$name.pdf');
    return file;
  }

  static Future<void> sharePdfFile(File pdfFile) async {
    // get the context
    final context = Get.context!;
    final box = context.findRenderObject() as RenderBox?;

    // Share the PDF file
    XFile xfile = XFile(pdfFile.path);
    await SharePlus.instance.share(ShareParams(
      files: [xfile],
      text: 'فاتورة',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    ));
  }
}
