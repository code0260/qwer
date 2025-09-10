import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class RentPrepaidExpenseModel extends Equatable {
  final int? rentPrepaidExpensesId;
  final int? rentPrepaidExpensesAccountsId;
  final double? rentPrepaidExpensesAmount;
  final int? rentPrepaidExpensesMonthCount;
  final String? rentPrepaidExpensesName;
  final dynamic rentPrepaidExpensesNotes;
  final String? rentPrepaidExpensesStartDate;
  final String? rentPrepaidExpensesEndDate;
  final String? rentPrepaidExpensesCreatedAt;
  final String? rentPrepaidExpensesUpdatedAt;
  final double? rentPrepaidExpensesBookValue;
  final double? rentPrepaidExpensesAmountInBase;
  final int? rentPrepaidExpensesAmountCurrencyId;

  const RentPrepaidExpenseModel({
    this.rentPrepaidExpensesId,
    this.rentPrepaidExpensesAccountsId,
    this.rentPrepaidExpensesAmount,
    this.rentPrepaidExpensesMonthCount,
    this.rentPrepaidExpensesName,
    this.rentPrepaidExpensesNotes,
    this.rentPrepaidExpensesStartDate,
    this.rentPrepaidExpensesEndDate,
    this.rentPrepaidExpensesCreatedAt,
    this.rentPrepaidExpensesUpdatedAt,
    this.rentPrepaidExpensesBookValue,
    this.rentPrepaidExpensesAmountInBase,
    this.rentPrepaidExpensesAmountCurrencyId,
  });

  factory RentPrepaidExpenseModel.fromJson(Map<String, dynamic> json) {
    return RentPrepaidExpenseModel(
      rentPrepaidExpensesId: json['rent_prepaid_expenses_id'] as int?,
      rentPrepaidExpensesAccountsId:
          json['rent_prepaid_expenses_accounts_id'] as int?,
      rentPrepaidExpensesAmount:
          receiveDouble(json['rent_prepaid_expenses_amount']),
      rentPrepaidExpensesMonthCount:
          json['rent_prepaid_expenses_month_count'] as int?,
      rentPrepaidExpensesName: json['rent_prepaid_expenses_name'] as String?,
      rentPrepaidExpensesNotes: json['rent_prepaid_expenses_notes'],
      rentPrepaidExpensesStartDate: json['rent_prepaid_expenses_start_date'],
      rentPrepaidExpensesEndDate: json['rent_prepaid_expenses_end_date'],
      rentPrepaidExpensesCreatedAt:
          json['rent_prepaid_expenses_created_at'] != null
              ? DateTime.parse(json['rent_prepaid_expenses_created_at'])
                  .toLocal()
                  .toString()
              : null,
      rentPrepaidExpensesUpdatedAt:
          json['rent_prepaid_expenses_updated_at'] != null
              ? DateTime.parse(json['rent_prepaid_expenses_updated_at'])
                  .toLocal()
                  .toString()
              : null,
      rentPrepaidExpensesBookValue:
          receiveDouble(json['rent_prepaid_expenses_book_value']),
      rentPrepaidExpensesAmountInBase:
          receiveDouble(json['rent_prepaid_expenses_amount_in_base']),
      rentPrepaidExpensesAmountCurrencyId:
          json['rent_prepaid_expenses_amount_currency_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'rent_prepaid_expenses_id': rentPrepaidExpensesId,
        'rent_prepaid_expenses_accounts_id': rentPrepaidExpensesAccountsId,
        'rent_prepaid_expenses_amount': rentPrepaidExpensesAmount,
        'rent_prepaid_expenses_month_count': rentPrepaidExpensesMonthCount,
        'rent_prepaid_expenses_name': rentPrepaidExpensesName,
        'rent_prepaid_expenses_notes': rentPrepaidExpensesNotes,
        'rent_prepaid_expenses_start_date':
            rentPrepaidExpensesStartDate?.toString(),
        'rent_prepaid_expenses_end_date':
            rentPrepaidExpensesEndDate?.toString(),
        'rent_prepaid_expenses_created_at': rentPrepaidExpensesCreatedAt != null
            ? DateTime.parse(rentPrepaidExpensesCreatedAt!).toUtc().toString()
            : null,
        'rent_prepaid_expenses_updated_at': rentPrepaidExpensesUpdatedAt != null
            ? DateTime.parse(rentPrepaidExpensesUpdatedAt!).toUtc().toString()
            : null,
        'rent_prepaid_expenses_book_value': rentPrepaidExpensesBookValue,
        'rent_prepaid_expenses_amount_in_base': rentPrepaidExpensesAmountInBase,
        'rent_prepaid_expenses_amount_currency_id':
            rentPrepaidExpensesAmountCurrencyId,
      };

  RentPrepaidExpenseModel copyWith({
    int? rentPrepaidExpensesId,
    int? rentPrepaidExpensesAccountsId,
    double? rentPrepaidExpensesAmount,
    int? rentPrepaidExpensesMonthCount,
    String? rentPrepaidExpensesName,
    dynamic rentPrepaidExpensesNotes,
    String? rentPrepaidExpensesStartDate,
    String? rentPrepaidExpensesEndDate,
    String? rentPrepaidExpensesCreatedAt,
    String? rentPrepaidExpensesUpdatedAt,
    double? rentPrepaidExpensesBookValue,
    double? rentPrepaidExpensesAmountInBase,
    int? rentPrepaidExpensesAmountCurrencyId,
  }) {
    return RentPrepaidExpenseModel(
      rentPrepaidExpensesId:
          rentPrepaidExpensesId ?? this.rentPrepaidExpensesId,
      rentPrepaidExpensesAccountsId:
          rentPrepaidExpensesAccountsId ?? this.rentPrepaidExpensesAccountsId,
      rentPrepaidExpensesAmount:
          rentPrepaidExpensesAmount ?? this.rentPrepaidExpensesAmount,
      rentPrepaidExpensesMonthCount:
          rentPrepaidExpensesMonthCount ?? this.rentPrepaidExpensesMonthCount,
      rentPrepaidExpensesName:
          rentPrepaidExpensesName ?? this.rentPrepaidExpensesName,
      rentPrepaidExpensesNotes:
          rentPrepaidExpensesNotes ?? this.rentPrepaidExpensesNotes,
      rentPrepaidExpensesStartDate:
          rentPrepaidExpensesStartDate ?? this.rentPrepaidExpensesStartDate,
      rentPrepaidExpensesEndDate:
          rentPrepaidExpensesEndDate ?? this.rentPrepaidExpensesEndDate,
      rentPrepaidExpensesCreatedAt:
          rentPrepaidExpensesCreatedAt ?? this.rentPrepaidExpensesCreatedAt,
      rentPrepaidExpensesUpdatedAt:
          rentPrepaidExpensesUpdatedAt ?? this.rentPrepaidExpensesUpdatedAt,
      rentPrepaidExpensesBookValue:
          rentPrepaidExpensesBookValue ?? this.rentPrepaidExpensesBookValue,
      rentPrepaidExpensesAmountInBase: rentPrepaidExpensesAmountInBase ??
          this.rentPrepaidExpensesAmountInBase,
      rentPrepaidExpensesAmountCurrencyId:
          rentPrepaidExpensesAmountCurrencyId ??
              this.rentPrepaidExpensesAmountCurrencyId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      rentPrepaidExpensesId,
      rentPrepaidExpensesAccountsId,
      rentPrepaidExpensesAmount,
      rentPrepaidExpensesMonthCount,
      rentPrepaidExpensesName,
      rentPrepaidExpensesNotes,
      rentPrepaidExpensesStartDate,
      rentPrepaidExpensesEndDate,
      rentPrepaidExpensesCreatedAt,
      rentPrepaidExpensesUpdatedAt,
      rentPrepaidExpensesBookValue,
      rentPrepaidExpensesAmountInBase,
      rentPrepaidExpensesAmountCurrencyId,
    ];
  }
}
