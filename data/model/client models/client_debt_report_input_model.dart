// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';

class ClientDebtReportInputModel {
  ReportFileType? fileType;
  List<ClientType> types;
  ClientDebtReportInputModel({this.fileType, required this.types});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "file_type": fileType?.name,
      "types": types.map((e) => e.name).toList(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
