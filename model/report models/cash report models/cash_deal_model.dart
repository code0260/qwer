import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_int.dart';
import 'package:equatable/equatable.dart';

class CashDealModel extends Equatable {
  final String? dealDate;
  final String? dealNumber;
  final String? dealType;
  final int? dealId;
  final double? dealAmount;
  final String? dealDebtCredit;
  final String? dealDesc;

  const CashDealModel({
    this.dealDate,
    this.dealNumber,
    this.dealType,
    this.dealId,
    this.dealAmount,
    this.dealDebtCredit,
    this.dealDesc,
  });

  factory CashDealModel.fromJson(Map<String, dynamic> json) {
    return CashDealModel(
      dealDate: json['deal_date'] as String?,
      dealNumber: json['deal_number'] as String?,
      dealType: json['deal_type'] as String?,
      dealId: receiveInt(json['deal_id']),
      dealAmount: receiveDouble(json['deal_amount']),
      dealDebtCredit: json['deal_debt_credit'] as String?,
      dealDesc: json['deal_desc'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'deal_date': dealDate,
        'deal_number': dealNumber,
        'deal_type': dealType,
        'deal_id': dealId,
        'deal_amount': dealAmount,
        'deal_debt_credit': dealDebtCredit,
        'deal_desc': dealDesc,
      };

  CashDealModel copyWith({
    String? dealDate,
    String? dealNumber,
    String? dealType,
    int? dealTypeId,
    double? dealAmount,
    String? dealDebtCredit,
    String? dealDesc,
  }) {
    return CashDealModel(
      dealDate: dealDate ?? this.dealDate,
      dealNumber: dealNumber ?? this.dealNumber,
      dealType: dealType ?? this.dealType,
      dealId: dealTypeId ?? dealId,
      dealAmount: dealAmount ?? this.dealAmount,
      dealDebtCredit: dealDebtCredit ?? this.dealDebtCredit,
      dealDesc: dealDesc ?? this.dealDesc,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dealDate,
      dealNumber,
      dealType,
      dealId,
      dealAmount,
      dealDebtCredit,
      dealDesc,
    ];
  }
}
