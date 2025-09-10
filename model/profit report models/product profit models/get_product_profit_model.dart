// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';

class GetProductProfitModel {
  DateTime? startDate;
  DateTime? endDate;
  ReportFileType? fileType;
  int? categoriesId;
  GetProductProfitModel({
    this.startDate,
    this.endDate,
    this.fileType,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "start_date": startDate?.toUtc().toString().substring(0, 19) ??
          (DateTime.now()
              .toUtc()
              .subtract(const Duration(days: 30))
              .toString()
              .substring(0, 19)),
      "end_date": endDate?.toUtc().toString().substring(0, 19) ??
          DateTime.now().toUtc().toString().substring(0, 19),
      "file_type": fileType?.name,
      "categories_id": categoriesId
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
