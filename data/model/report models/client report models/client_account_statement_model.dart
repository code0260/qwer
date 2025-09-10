// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/client%20models/get_client_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_summary_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_deal_model.dart';
import 'package:flutter/foundation.dart';

class ClientAccountStatementModel {
  final GetClientModel getClientModel;
  final List<ClientDealModel> clientDeals;
  final ClientAccountStatementSummaryModel summaryModel;
  ClientAccountStatementModel({
    required this.getClientModel,
    required this.clientDeals,
    required this.summaryModel,
  });

  ClientAccountStatementModel copyWith({
    GetClientModel? getClientModel,
    List<ClientDealModel>? clientDeals,
    ClientAccountStatementSummaryModel? summaryModel,
  }) {
    return ClientAccountStatementModel(
      getClientModel: getClientModel ?? this.getClientModel,
      clientDeals: clientDeals ?? this.clientDeals,
      summaryModel: summaryModel ?? this.summaryModel,
    );
  }

  factory ClientAccountStatementModel.fromJson(Map<String, dynamic> map) {
    return ClientAccountStatementModel(
      getClientModel:
          GetClientModel.fromJson(map['client'] as Map<String, dynamic>),
      clientDeals: List<ClientDealModel>.from(
        (map['deals'] as List<dynamic>).map<ClientDealModel>(
          (x) => ClientDealModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      summaryModel: ClientAccountStatementSummaryModel.fromJson(
          map['summary'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'ClientAccountStatementModel(getClientModel: $getClientModel, clientDeals: $clientDeals, summaryModel: $summaryModel)';

  @override
  bool operator ==(covariant ClientAccountStatementModel other) {
    if (identical(this, other)) return true;

    return other.getClientModel == getClientModel &&
        listEquals(other.clientDeals, clientDeals) &&
        other.summaryModel == summaryModel;
  }

  @override
  int get hashCode =>
      getClientModel.hashCode ^ clientDeals.hashCode ^ summaryModel.hashCode;
}
