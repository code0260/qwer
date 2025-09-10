import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class CashModel extends Equatable {
  final int? cashId;
  final int? cashBusinessId;
  final int? cashAmountCurrencyId;
  final double? cashAmount;
  final String? cashCreatedAt;
  final String? cashUpdatedAt;

  const CashModel({
    this.cashId,
    this.cashBusinessId,
    this.cashAmountCurrencyId,
    this.cashAmount,
    this.cashCreatedAt,
    this.cashUpdatedAt,
  });

  factory CashModel.fromJson(Map<String, dynamic> json) => CashModel(
        cashId: json['cash_id'] as int?,
        cashBusinessId: json['cash_business_id'] as int?,
        cashAmountCurrencyId: json['cash_amount_currency_id'] as int?,
        cashAmount: receiveDouble(json['cash_amount']),
        cashCreatedAt: json['cash_created_at'] as String?,
        cashUpdatedAt: json['cash_updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'cash_id': cashId,
        'cash_business_id': cashBusinessId,
        'cash_amount_currency_id': cashAmountCurrencyId,
        'cash_amount': cashAmount,
        'cash_created_at': cashCreatedAt,
        'cash_updated_at': cashUpdatedAt,
      };

  CashModel copyWith({
    int? cashId,
    int? cashBusinessId,
    int? cashAmountCurrencyId,
    double? cashAmount,
    String? cashCreatedAt,
    String? cashUpdatedAt,
  }) {
    return CashModel(
      cashId: cashId ?? this.cashId,
      cashBusinessId: cashBusinessId ?? this.cashBusinessId,
      cashAmountCurrencyId: cashAmountCurrencyId ?? this.cashAmountCurrencyId,
      cashAmount: cashAmount ?? this.cashAmount,
      cashCreatedAt: cashCreatedAt ?? this.cashCreatedAt,
      cashUpdatedAt: cashUpdatedAt ?? this.cashUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      cashId,
      cashBusinessId,
      cashAmountCurrencyId,
      cashAmount,
      cashCreatedAt,
      cashUpdatedAt,
    ];
  }
}
