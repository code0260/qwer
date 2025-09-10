// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';

class GetProductInventoryModel {
  ReportFileType? fileType;
  List<int>? categoriesIds;
  int? buildingsId;
  bool isShowExisted;
  GetProductInventoryModel(
      {this.fileType,
      this.categoriesIds,
      this.isShowExisted = true,
      this.buildingsId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "file_type": fileType?.name,
      "categories_id": categoriesIds,
      "buildings_id": buildingsId,
      "is_show_exited": isShowExisted
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
