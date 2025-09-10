import 'package:almonazim/data/data%20source/locale/store_print_setting.dart';
import 'package:pdf/pdf.dart';

PdfPageFormat getPdfPageFormatFromSetting() {
  switch (StorePrintSetting.getPaperSize()) {
    case 'a3':
      return PdfPageFormat.a3;
    case 'a4':
      return PdfPageFormat.a4;
    case 'a5':
      return PdfPageFormat.a5;
    case 'a6':
      return PdfPageFormat.a6;
    case 'legal':
      return PdfPageFormat.legal;
    case 'letter':
      return PdfPageFormat.letter;
    case 'roll57':
      return PdfPageFormat.roll57;
    case 'roll80':
      return PdfPageFormat.roll80;
    case 'standard':
      return PdfPageFormat.standard;
    default:
      return PdfPageFormat.undefined;
  }
}
