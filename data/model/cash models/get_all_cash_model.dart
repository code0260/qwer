import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/data/model/cash%20models/cash_model.dart';

class GetAllCashModel {
  final List<CashModel> cash;
  final double totalCash;

  GetAllCashModel({
    required this.cash,
    required this.totalCash,
  });

  factory GetAllCashModel.fromJson(Map<String, dynamic> map) {
    return GetAllCashModel(
      cash: List<CashModel>.from(
        (map['cash'] as List<dynamic>).map<CashModel>(
          (x) => CashModel.fromJson(x),
        ),
      ),
      totalCash: receiveDouble(map['total_cash'])!,
    );
  }
}
