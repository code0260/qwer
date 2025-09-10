import 'package:almonazim/data/model/employees%20models/compensation_model.dart';

class AllCompensationModel {
  final List<CompensationModel> bonuses;
  final List<CompensationModel> deductions;

  AllCompensationModel({required this.bonuses, required this.deductions});

  factory AllCompensationModel.formJson(Map<String, dynamic> map) {
    return AllCompensationModel(
      bonuses: map['bonuses'] == null
          ? []
          : List<CompensationModel>.from(
              (map['bonuses'] as List<dynamic>).map<CompensationModel>(
                (x) => CompensationModel.fromJson(x as Map<String, dynamic>),
              ),
            ),
      deductions: map['deductions'] == null
          ? []
          : List<CompensationModel>.from(
              (map['deductions'] as List<dynamic>).map<CompensationModel>(
                (x) => CompensationModel.fromJson(x as Map<String, dynamic>),
              ),
            ),
    );
  }
}
