import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class RentPrepaidRevenueInputModel {
  int? rentPrepaidRevenuesId;
  int? rentPrepaidRevenuesAccountsId;
  double? rentPrepaidRevenuesAmount;
  int? rentPrepaidRevenuesMonthCount;
  String? rentPrepaidRevenuesName;
  dynamic rentPrepaidRevenuesNotes;
  String? rentPrepaidRevenuesStartDate;
  String? rentPrepaidRevenuesEndDate;
  String? rentPrepaidRevenuesCreatedAt;
  String? rentPrepaidRevenuesUpdatedAt;
  double? rentPrepaidRevenuesBookValue;
  double? rentPrepaidRevenuesAmountInBase;
  int? rentPrepaidRevenuesAmountCurrencyId;

  RentPrepaidRevenueInputModel({
    this.rentPrepaidRevenuesId,
    this.rentPrepaidRevenuesAccountsId,
    this.rentPrepaidRevenuesAmount,
    this.rentPrepaidRevenuesMonthCount,
    this.rentPrepaidRevenuesName,
    this.rentPrepaidRevenuesNotes,
    this.rentPrepaidRevenuesStartDate,
    this.rentPrepaidRevenuesEndDate,
    this.rentPrepaidRevenuesCreatedAt,
    this.rentPrepaidRevenuesUpdatedAt,
    this.rentPrepaidRevenuesBookValue,
    this.rentPrepaidRevenuesAmountInBase,
    this.rentPrepaidRevenuesAmountCurrencyId,
  });

  factory RentPrepaidRevenueInputModel.fromJson(Map<String, dynamic> json) {
    return RentPrepaidRevenueInputModel(
      rentPrepaidRevenuesId: json['rent_prepaid_revenues_id'] as int?,
      rentPrepaidRevenuesAccountsId:
          json['rent_prepaid_revenues_accounts_id'] as int?,
      rentPrepaidRevenuesAmount:
          receiveDouble(json['rent_prepaid_revenues_amount']),
      rentPrepaidRevenuesMonthCount:
          json['rent_prepaid_revenues_month_count'] as int?,
      rentPrepaidRevenuesName: json['rent_prepaid_revenues_name'] as String?,
      rentPrepaidRevenuesNotes: json['rent_prepaid_revenues_notes'],
      rentPrepaidRevenuesStartDate: json['rent_prepaid_revenues_start_date'],
      rentPrepaidRevenuesEndDate: json['rent_prepaid_revenues_end_date'],
      rentPrepaidRevenuesCreatedAt:
          json['rent_prepaid_revenues_created_at'] != null
              ? DateTime.parse(json['rent_prepaid_revenues_created_at'])
                  .toLocal()
                  .toString()
              : null,
      rentPrepaidRevenuesUpdatedAt:
          json['rent_prepaid_revenues_updated_at'] != null
              ? DateTime.parse(json['rent_prepaid_revenues_updated_at'])
                  .toLocal()
                  .toString()
              : null,
      rentPrepaidRevenuesBookValue:
          receiveDouble(json['rent_prepaid_revenues_book_value']),
      rentPrepaidRevenuesAmountInBase:
          receiveDouble(json['rent_prepaid_revenues_amount_in_base']),
      rentPrepaidRevenuesAmountCurrencyId:
          json['rent_prepaid_revenues_amount_currency_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'rent_prepaid_revenues_id': rentPrepaidRevenuesId,
      'rent_prepaid_revenues_accounts_id': rentPrepaidRevenuesAccountsId,
      'rent_prepaid_revenues_amount': rentPrepaidRevenuesAmount,
      'rent_prepaid_revenues_month_count': rentPrepaidRevenuesMonthCount,
      'rent_prepaid_revenues_name': rentPrepaidRevenuesName,
      'rent_prepaid_revenues_notes': rentPrepaidRevenuesNotes,
      'rent_prepaid_revenues_start_date':
          rentPrepaidRevenuesStartDate?.toString(),
      'rent_prepaid_revenues_end_date': rentPrepaidRevenuesEndDate?.toString(),
      'rent_prepaid_revenues_created_at': rentPrepaidRevenuesCreatedAt != null
          ? DateTime.parse(rentPrepaidRevenuesCreatedAt!).toUtc().toString()
          : null,
      'rent_prepaid_revenues_updated_at': rentPrepaidRevenuesUpdatedAt != null
          ? DateTime.parse(rentPrepaidRevenuesUpdatedAt!).toUtc().toString()
          : null,
      'rent_prepaid_revenues_book_value': rentPrepaidRevenuesBookValue,
      'rent_prepaid_revenues_amount_in_base': rentPrepaidRevenuesAmountInBase,
      'rent_prepaid_revenues_amount_currency_id':
          rentPrepaidRevenuesAmountCurrencyId,
    };
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }

  RentPrepaidRevenueInputModel copyWith({
    int? rentPrepaidRevenuesId,
    int? rentPrepaidRevenuesAccountsId,
    double? rentPrepaidRevenuesAmount,
    int? rentPrepaidRevenuesMonthCount,
    String? rentPrepaidRevenuesName,
    dynamic rentPrepaidRevenuesNotes,
    String? rentPrepaidRevenuesStartDate,
    String? rentPrepaidRevenuesEndDate,
    String? rentPrepaidRevenuesCreatedAt,
    String? rentPrepaidRevenuesUpdatedAt,
    double? rentPrepaidRevenuesBookValue,
    double? rentPrepaidRevenuesAmountInBase,
    int? rentPrepaidRevenuesAmountCurrencyId,
  }) {
    return RentPrepaidRevenueInputModel(
      rentPrepaidRevenuesId:
          rentPrepaidRevenuesId ?? this.rentPrepaidRevenuesId,
      rentPrepaidRevenuesAccountsId:
          rentPrepaidRevenuesAccountsId ?? this.rentPrepaidRevenuesAccountsId,
      rentPrepaidRevenuesAmount:
          rentPrepaidRevenuesAmount ?? this.rentPrepaidRevenuesAmount,
      rentPrepaidRevenuesMonthCount:
          rentPrepaidRevenuesMonthCount ?? this.rentPrepaidRevenuesMonthCount,
      rentPrepaidRevenuesName:
          rentPrepaidRevenuesName ?? this.rentPrepaidRevenuesName,
      rentPrepaidRevenuesNotes:
          rentPrepaidRevenuesNotes ?? this.rentPrepaidRevenuesNotes,
      rentPrepaidRevenuesStartDate:
          rentPrepaidRevenuesStartDate ?? this.rentPrepaidRevenuesStartDate,
      rentPrepaidRevenuesEndDate:
          rentPrepaidRevenuesEndDate ?? this.rentPrepaidRevenuesEndDate,
      rentPrepaidRevenuesCreatedAt:
          rentPrepaidRevenuesCreatedAt ?? this.rentPrepaidRevenuesCreatedAt,
      rentPrepaidRevenuesUpdatedAt:
          rentPrepaidRevenuesUpdatedAt ?? this.rentPrepaidRevenuesUpdatedAt,
      rentPrepaidRevenuesBookValue:
          rentPrepaidRevenuesBookValue ?? this.rentPrepaidRevenuesBookValue,
      rentPrepaidRevenuesAmountInBase: rentPrepaidRevenuesAmountInBase ??
          this.rentPrepaidRevenuesAmountInBase,
      rentPrepaidRevenuesAmountCurrencyId:
          rentPrepaidRevenuesAmountCurrencyId ??
              this.rentPrepaidRevenuesAmountCurrencyId,
    );
  }
}
