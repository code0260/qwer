import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BoughtInfoInputModel extends Equatable {
  int? productsId;
  DateTime? startDate;
  DateTime? endDate;

  BoughtInfoInputModel({this.productsId, this.startDate, this.endDate});

  @override
  List<Object?> get props => [productsId, startDate, endDate];

  Map<String, dynamic> toMap() {
    return {
      "products_id": productsId,
      "start_date": startDate == null
          ? DateTime.now().subtract(const Duration(days: 30))
          : startDate!.toUtc().toString(),
      "end_date":
          endDate == null ? DateTime.now() : endDate!.toUtc().toString(),
    };
  }

  // Optionally, if you want to support fromJson and toJson:
  factory BoughtInfoInputModel.fromJson(Map<String, dynamic> json) {
    return BoughtInfoInputModel(
      productsId: json['products_id'] as int?,
      startDate: json['start_date'] != null
          ? DateTime.parse('${json['start_date']}Z').toLocal()
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse('${json['end_date']}Z').toLocal()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products_id': productsId,
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
    };
  }
}
