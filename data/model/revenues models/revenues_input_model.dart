// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: must_be_immutable
class RevenueInputModel {
  DateTime? startDate;
  DateTime? endDate;
  int? revenuesId;
  int? revenuesAccountId;
  String? revenuesName;
  dynamic revenuesDescription;
  double? revenuesAmount; // Changed from String to double
  String? revenuesCreatedAt;
  String? revenuesType;
  double? revenuesSecondAmount; // Changed from String to double
  double? paidThisTime;
  int? paidThisTimeCurrencyId;
  double? paidThisTimeInBase;
  String? originalType;

  // New properties
  double? revenuesAmountInBase;
  double? revenuesSecondAmountInBase;
  int? revenuesAmountCurrencyId;

  RevenueInputModel({
    this.paidThisTime,
    this.paidThisTimeInBase,
    this.paidThisTimeCurrencyId,
    this.revenuesAccountId,
    this.startDate,
    this.endDate,
    this.revenuesId,
    this.revenuesName,
    this.revenuesDescription,
    this.revenuesAmount,
    this.revenuesCreatedAt,
    this.revenuesType,
    this.revenuesSecondAmount,
    this.revenuesAmountInBase, // New property
    this.revenuesSecondAmountInBase, // New property
    this.revenuesAmountCurrencyId, // New property
    this.originalType,
  });

  RevenueInputModel copyWith({
    int? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? revenuesType,
    double? revenuesSecondAmount, // Updated type
    double? revenuesAmountInBase, // New property
    double? revenuesSecondAmountInBase, // New property
    int? revenuesAmountCurrencyId, // New property
  }) {
    return RevenueInputModel(
      revenuesAccountId: employeeId ?? revenuesAccountId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      revenuesId: revenuesId,
      revenuesName: revenuesName,
      revenuesDescription: revenuesDescription,
      revenuesAmount: revenuesAmount,
      revenuesCreatedAt: revenuesCreatedAt,
      revenuesType: revenuesType ?? this.revenuesType,
      revenuesSecondAmount: revenuesSecondAmount ?? this.revenuesSecondAmount,
      revenuesAmountInBase:
          revenuesAmountInBase ?? this.revenuesAmountInBase, // New property
      revenuesSecondAmountInBase: revenuesSecondAmountInBase ??
          this.revenuesSecondAmountInBase, // New property
      revenuesAmountCurrencyId: revenuesAmountCurrencyId ??
          this.revenuesAmountCurrencyId, // New property
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'revenues_account_id': revenuesAccountId,
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      'revenues_id': revenuesId,
      'revenues_name': revenuesName,
      'revenues_description': revenuesDescription,
      'revenues_amount': revenuesAmount, // Updated type
      'revenues_created_at': revenuesCreatedAt == null
          ? null
          : DateTime.parse(revenuesCreatedAt!).toUtc().toString(),
      'revenues_type': revenuesType,
      'revenues_second_amount': revenuesSecondAmount, // Updated type
      'revenues_amount_in_base': revenuesAmountInBase, // New property
      'revenues_second_amount_in_base':
          revenuesSecondAmountInBase, // New property
      'revenues_amount_currency_id': revenuesAmountCurrencyId, // New property
    };
    map.removeWhere((key, value) => value == null || value == "all");
    return map;
  }

  factory RevenueInputModel.fromMap(Map<String, dynamic> map) {
    return RevenueInputModel(
      revenuesAccountId: map['revenues_account_id'] as int?,
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
      revenuesId: map['revenues_id'] as int?,
      revenuesName: map['revenues_name'] as String?,
      revenuesDescription: map['revenues_description'],
      revenuesAmount: map['revenues_amount'] != null
          ? double.tryParse(map['revenues_amount'].toString()) // Updated type
          : null,
      revenuesCreatedAt: map['revenues_created_at'] == null
          ? null
          : DateTime.parse('${map['revenues_created_at']}Z')
              .toLocal()
              .toString(),
      revenuesType: map['revenues_type'] as String?,
      revenuesSecondAmount: map['revenues_second_amount'] != null
          ? double.tryParse(
              map['revenues_second_amount'].toString()) // Updated type
          : null,
      revenuesAmountInBase: map['revenues_amount_in_base'] != null
          ? double.tryParse(
              map['revenues_amount_in_base'].toString()) // New property
          : null,
      revenuesSecondAmountInBase: map['revenues_second_amount_in_base'] != null
          ? double.tryParse(
              map['revenues_second_amount_in_base'].toString()) // New property
          : null,
      revenuesAmountCurrencyId:
          map['revenues_amount_currency_id'] as int?, // New property
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueInputModel.fromJson(String source) =>
      RevenueInputModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
