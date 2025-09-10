import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class ClientBalanceModel extends Equatable {
  final int? clientsBalanceId;
  final int? clientsBalanceClientsId;
  final int? clientsBalanceTrialBalanceId;
  final double? clientsBalanceOpening;
  final double? clientsBalanceCurrent;
  final double? clientsBalanceClosing;
  final String? clientsBalanceCreatedAt;
  final String? clientsBalanceUpdatedAt;
  final int? clientsBalanceCurrencyId;

  const ClientBalanceModel({
    this.clientsBalanceId,
    this.clientsBalanceClientsId,
    this.clientsBalanceTrialBalanceId,
    this.clientsBalanceOpening,
    this.clientsBalanceCurrent,
    this.clientsBalanceClosing,
    this.clientsBalanceCreatedAt,
    this.clientsBalanceUpdatedAt,
    this.clientsBalanceCurrencyId,
  });

  factory ClientBalanceModel.fromJson(Map<String, dynamic> json) {
    return ClientBalanceModel(
      clientsBalanceId: json['clients_balance_id'] as int?,
      clientsBalanceClientsId: json['clients_balance_clients_id'] as int?,
      clientsBalanceTrialBalanceId:
          json['clients_balance_trial_balance_id'] as int?,
      clientsBalanceOpening: receiveDouble(json['clients_balance_opening']),
      clientsBalanceCurrent: receiveDouble(json['clients_balance_current']),
      clientsBalanceClosing: receiveDouble(json['clients_balance_closing']),
      clientsBalanceCreatedAt: json['clients_balance_created_at'] as String?,
      clientsBalanceUpdatedAt: json['clients_balance_updated_at'] as String?,
      clientsBalanceCurrencyId: json['clients_balance_currency_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'clients_balance_id': clientsBalanceId,
        'clients_balance_clients_id': clientsBalanceClientsId,
        'clients_balance_trial_balance_id': clientsBalanceTrialBalanceId,
        'clients_balance_opening': clientsBalanceOpening,
        'clients_balance_current': clientsBalanceCurrent,
        'clients_balance_closing': clientsBalanceClosing,
        'clients_balance_created_at': clientsBalanceCreatedAt,
        'clients_balance_updated_at': clientsBalanceUpdatedAt,
        'clients_balance_currency_id': clientsBalanceCurrencyId,
      };

  ClientBalanceModel copyWith({
    int? clientsBalanceId,
    int? clientsBalanceClientsId,
    int? clientsBalanceTrialBalanceId,
    double? clientsBalanceOpening,
    double? clientsBalanceCurrent,
    double? clientsBalanceClosing,
    String? clientsBalanceCreatedAt,
    String? clientsBalanceUpdatedAt,
    int? clientsBalanceCurrencyId,
  }) {
    return ClientBalanceModel(
      clientsBalanceId: clientsBalanceId ?? this.clientsBalanceId,
      clientsBalanceClientsId:
          clientsBalanceClientsId ?? this.clientsBalanceClientsId,
      clientsBalanceTrialBalanceId:
          clientsBalanceTrialBalanceId ?? this.clientsBalanceTrialBalanceId,
      clientsBalanceOpening:
          clientsBalanceOpening ?? this.clientsBalanceOpening,
      clientsBalanceCurrent:
          clientsBalanceCurrent ?? this.clientsBalanceCurrent,
      clientsBalanceClosing:
          clientsBalanceClosing ?? this.clientsBalanceClosing,
      clientsBalanceCreatedAt:
          clientsBalanceCreatedAt ?? this.clientsBalanceCreatedAt,
      clientsBalanceUpdatedAt:
          clientsBalanceUpdatedAt ?? this.clientsBalanceUpdatedAt,
      clientsBalanceCurrencyId:
          clientsBalanceCurrencyId ?? this.clientsBalanceCurrencyId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      clientsBalanceId,
      clientsBalanceClientsId,
      clientsBalanceTrialBalanceId,
      clientsBalanceOpening,
      clientsBalanceCurrent,
      clientsBalanceClosing,
      clientsBalanceCreatedAt,
      clientsBalanceUpdatedAt,
      clientsBalanceCurrencyId,
    ];
  }
}
