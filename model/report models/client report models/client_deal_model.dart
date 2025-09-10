import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_int.dart';
import 'package:equatable/equatable.dart';

class ClientDealModel extends Equatable {
  final int? dealId;
  final String? dealDate;
  final String? dealNumber;
  final String? dealType;
  final double? dealAmount;
  final String? dealDebtCredit;

  const ClientDealModel({
    this.dealId,
    this.dealDate,
    this.dealNumber,
    this.dealType,
    this.dealAmount,
    this.dealDebtCredit,
  });

  factory ClientDealModel.fromJson(Map<String, dynamic> json) {
    return ClientDealModel(
      dealId: receiveInt(json['deal_id']),
      dealDate: json['deal_date'] as String?,
      dealNumber: json['deal_number'] as String?,
      dealType: json['deal_type'] as String?,
      dealAmount: receiveDouble(json['deal_amount']),
      dealDebtCredit: json['deal_debt_credit'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'deal_id': dealId,
        'deal_date': dealDate,
        'deal_number': dealNumber,
        'deal_type': dealType,
        'deal_amount': dealAmount,
        'deal_debt_credit': dealDebtCredit,
      };

  ClientDealModel copyWith({
    int? dealId,
    String? dealDate,
    String? dealNumber,
    String? dealType,
    double? dealAmount,
    String? dealDebtCredit,
  }) {
    return ClientDealModel(
      dealId: dealId ?? this.dealId,
      dealDate: dealDate ?? this.dealDate,
      dealNumber: dealNumber ?? this.dealNumber,
      dealType: dealType ?? this.dealType,
      dealAmount: dealAmount ?? this.dealAmount,
      dealDebtCredit: dealDebtCredit ?? this.dealDebtCredit,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dealId,
      dealDate,
      dealNumber,
      dealType,
      dealAmount,
      dealDebtCredit,
    ];
  }
}
