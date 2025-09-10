import 'dart:io';

import 'package:almonazim/core/helper/printing/invoice%20pdf/get_page_pdf_format_from_setting.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:pdf/widgets.dart';

class PrintBarcode {
  static Future<File> generateBarcode(String barcode) async {
    final pdf = Document();
    pdf.addPage(
      Page(
        pageFormat: getPdfPageFormatFromSetting(),
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: PdfGenerator.normalFont,
          bold: PdfGenerator.boldFont,
        ),
        build: (Context context) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BarcodeWidget(
                      width: 100,
                      height: 50,
                      barcode: Barcode.code128(),
                      data: barcode),
                ],
              ));
        },
      ),
    );
    return PdfGenerator.savePdf(
      name: 'طباعة_باركود',
      pdf: pdf,
    );
  }
}
