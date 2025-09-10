// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/data/model/client%20models/client_balance_model.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';

class GetClientModel {
  final ClientModel clientModel;
  final List<ClientBalanceModel> balances;
  final double totalBalance;
  GetClientModel({
    required this.clientModel,
    required this.balances,
    required this.totalBalance,
  });

  factory GetClientModel.fromJson(Map<String, dynamic> map) {
    return GetClientModel(
      totalBalance: receiveDouble(map['total_balance'])!,
      clientModel: ClientModel.fromJson(map['client'] as Map<String, dynamic>),
      balances: List<ClientBalanceModel>.from(
        (map['balances'] as List<dynamic>).map<ClientBalanceModel>(
          (x) => ClientBalanceModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
