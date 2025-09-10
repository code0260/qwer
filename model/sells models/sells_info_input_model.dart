import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SellsInfoInputModel extends Equatable {
  int? productsId;
  DateTime? startDate;
  DateTime? endDate;

  SellsInfoInputModel({this.productsId, this.startDate, this.endDate});

  @override
  List<Object?> get props => [productsId, startDate, endDate];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "products_id": productsId,
      "start_date": startDate == null
          ? DateTime.now().subtract(const Duration(days: 30))
          : startDate!.toString(),
      "end_date": endDate == null ? DateTime.now() : endDate!.toString(),
    };
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }

  // Optionally, if you want to support fromJson and toJson:
  factory SellsInfoInputModel.fromJson(Map<String, dynamic> json) {
    return SellsInfoInputModel(
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
