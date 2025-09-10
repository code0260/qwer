// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/data/model/revenues%20models/revenues_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_summary_model.dart';
import 'package:flutter/foundation.dart';

class GetRevenuesModel {
  final List<RevenuesModel> revenues;
  final RevenuesSummaryModel revenuesSummaryModel;

  GetRevenuesModel({
    required this.revenues,
    required this.revenuesSummaryModel,
  });

  GetRevenuesModel copyWith({
    List<RevenuesModel>? revenues,
    RevenuesSummaryModel? revenuesSummaryModel,
  }) {
    return GetRevenuesModel(
      revenues: revenues ?? this.revenues,
      revenuesSummaryModel: revenuesSummaryModel ?? this.revenuesSummaryModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'revenues': revenues.map((x) => x.toJson()).toList(),
      'revenuesSummaryModel': revenuesSummaryModel.toJson(),
    };
  }

  factory GetRevenuesModel.fromMap(Map<String, dynamic> map) {
    return GetRevenuesModel(
      revenues: List<RevenuesModel>.from(
        (map['revenues'] as List<int>).map<RevenuesModel>(
          (x) => RevenuesModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      revenuesSummaryModel:
          map['revenues_summary_model'] as RevenuesSummaryModel,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetRevenuesModel.fromJson(String source) =>
      GetRevenuesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RevenuesModel(revenues: $revenues, revenuesSummaryModel: $revenuesSummaryModel)';

  @override
  bool operator ==(covariant GetRevenuesModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.revenues, revenues) &&
        other.revenuesSummaryModel == revenuesSummaryModel;
  }

  @override
  int get hashCode => revenues.hashCode ^ revenuesSummaryModel.hashCode;
}
