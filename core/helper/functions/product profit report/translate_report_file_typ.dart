import 'package:almonazim/core/constant/app_enums.dart';

ReportFileType translateToEnumReportFileTypeFromString(String type) {
  switch (type) {
    case "اكسل":
      return ReportFileType.xlsx;
    case "pdf":
      return ReportFileType.pdf;
    default:
      return ReportFileType.pdf;
  }
}

String translateToArReportFileType(ReportFileType? type) {
  switch (type) {
    case ReportFileType.xlsx:
      return "اكسل";
    case ReportFileType.pdf:
      return "pdf";
    default:
      return "pdf";
  }
}
