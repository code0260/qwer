import 'package:almonazim/core/extension/string_extensions.dart';

class IncomeStatementInputModel {
  DateTime startDate;
  DateTime endDate;
  int? accountParentId;
  IncomeStatementInputModel({
    required this.startDate,
    required this.endDate,
    this.accountParentId,
  });

  Map toMap() {
    Map map = {
      'start_date': startDate.toString().toServerDateTime(),
      'end_date': endDate.toString().toServerDateTime(),
      'parent_id': accountParentId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
