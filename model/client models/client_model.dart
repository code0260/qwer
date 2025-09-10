import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:equatable/equatable.dart';

class ClientModel extends Equatable {
  final int? clientsId;
  final String? clientsName;
  final String? clientsType;
  final dynamic clientsEmail;
  final int? clientsPhoneNumber;
  final String? clientsAddress;
  final String? clientsCreatedAt;
  final int? clientsBusinessId;

  const ClientModel({
    this.clientsId,
    this.clientsName,
    this.clientsType,
    this.clientsEmail,
    this.clientsPhoneNumber,
    this.clientsAddress,
    this.clientsCreatedAt,
    this.clientsBusinessId,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        clientsId: json['clients_id'] as int?,
        clientsName: json['clients_name'] as String?,
        clientsType: json['clients_type'] as String?,
        clientsEmail: json['clients_email'] as dynamic,
        clientsPhoneNumber: json['clients_phone_number'] as int?,
        clientsAddress: json['clients_address'] as String?,
        clientsCreatedAt: toLocalTime(json['clients_createdAt']),
        clientsBusinessId: json['clients_business_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'clients_id': clientsId,
        'clients_name': clientsName,
        'clients_type': clientsType,
        'clients_email': clientsEmail,
        'clients_phone_number': clientsPhoneNumber,
        'clients_address': clientsAddress,
        'clients_createdAt': clientsCreatedAt,
        'clients_business_id': clientsBusinessId,
      };

  ClientModel copyWith({
    int? clientsId,
    String? clientsName,
    String? clientsType,
    dynamic clientsEmail,
    int? clientsPhoneNumber,
    String? clientsAddress,
    String? clientsCreatedAt,
    int? clientsBusinessId,
  }) {
    return ClientModel(
      clientsId: clientsId ?? this.clientsId,
      clientsName: clientsName ?? this.clientsName,
      clientsType: clientsType ?? this.clientsType,
      clientsEmail: clientsEmail ?? this.clientsEmail,
      clientsPhoneNumber: clientsPhoneNumber ?? this.clientsPhoneNumber,
      clientsAddress: clientsAddress ?? this.clientsAddress,
      clientsCreatedAt: clientsCreatedAt ?? this.clientsCreatedAt,
      clientsBusinessId: clientsBusinessId ?? this.clientsBusinessId,
    );
  }

  @override
  List<Object?> get props {
    return [
      clientsId,
      clientsName,
      clientsType,
      clientsEmail,
      clientsPhoneNumber,
      clientsAddress,
      clientsCreatedAt,
      clientsBusinessId,
    ];
  }
}
