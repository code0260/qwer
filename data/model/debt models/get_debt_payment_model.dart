// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_model.dart';

class GetDebtPaymentModel {
  final DebtPaymentModel debtPaymentModel;
  final DebtModel debtModel;
  GetDebtPaymentModel({
    required this.debtPaymentModel,
    required this.debtModel,
  });

  GetDebtPaymentModel copyWith({
    DebtPaymentModel? debtPaymentModel,
    DebtModel? debtModel,
  }) {
    return GetDebtPaymentModel(
      debtPaymentModel: debtPaymentModel ?? this.debtPaymentModel,
      debtModel: debtModel ?? this.debtModel,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'payment': debtPaymentModel.toJson(),
      'debt': debtModel.toJson(),
    };
  }

  factory GetDebtPaymentModel.fromJson(Map<String, dynamic> map) {
    return GetDebtPaymentModel(
      debtPaymentModel:
          DebtPaymentModel.fromJson(map['payment'] as Map<String, dynamic>),
      debtModel: DebtModel.fromJson(map['debt'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'GetDebtPaymentModel(debtPaymentModel: $debtPaymentModel, debtModel: $debtModel)';

  @override
  bool operator ==(covariant GetDebtPaymentModel other) {
    if (identical(this, other)) return true;

    return other.debtPaymentModel == debtPaymentModel &&
        other.debtModel == debtModel;
  }

  @override
  int get hashCode => debtPaymentModel.hashCode ^ debtModel.hashCode;
}
