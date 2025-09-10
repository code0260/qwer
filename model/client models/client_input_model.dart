// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';

class ClientInputModel {
  int? clientsId;
  int? requestNumber;
  String? clientsName;
  String? clientsType;
  String? clientsEmail;
  int? clientsPhoneNumber;
  String? clientsAddress;
  String? clientsCreatedAt;
  int? clientsBusinessId;
  int? clientsOnline; // New property
  bool balanceNotZero;
  DateTime? startDate; // Added property
  DateTime? endDate; // Added property

  ClientInputModel({
    this.clientsId,
    this.requestNumber,
    this.clientsName,
    this.clientsType,
    this.clientsEmail,
    this.clientsPhoneNumber,
    this.clientsAddress,
    this.clientsCreatedAt,
    this.clientsBusinessId,
    this.balanceNotZero = false,
    this.clientsOnline, // New property in constructor
    this.startDate, // Added property
    this.endDate, // Added property
  });

  factory ClientInputModel.fromMap(Map<String, dynamic> map) {
    return ClientInputModel(
      clientsId: map['clients_id'] as int?,
      clientsName: map['clients_name'] as String?,
      clientsType: map['clients_type'] as String?,
      clientsEmail: map['clients_email'] as String?,
      clientsPhoneNumber: map['clients_phone_number'] as int?,
      clientsAddress: map['clients_address'] as String?,
      clientsCreatedAt: toLocalTime(map['clients_createdAt']),
      clientsBusinessId: map['clients_business_id'] as int?,
      clientsOnline: map['clients_online'] as int?, // New property in fromMap
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'clients_id': clientsId,
      'clients_name': clientsName,
      'clients_type': clientsType,
      'clients_email': clientsEmail,
      'clients_phone_number': clientsPhoneNumber,
      'clients_address': clientsAddress,
      'clients_createdAt': clientsCreatedAt == null
          ? null
          : DateTime.parse(clientsCreatedAt!).toUtc().toString(),
      'clients_business_id': clientsBusinessId,
      'clients_online': clientsOnline, // New field in map
      'request_number': requestNumber,
      'balance_not_zero': balanceNotZero, // Added property
      'start_date': startDate?.toUtc().toString(), // Added property
      'end_date': endDate?.toUtc().toString(), // Added property
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Map<String, dynamic> toDatabaseMap() {
    Map<String, dynamic> map = {
      'clients_id': clientsId,
      'clients_name': clientsName,
      'clients_type': clientsType,
      'clients_email': clientsEmail,
      'clients_phone_number': clientsPhoneNumber,
      'clients_address': clientsAddress,
      'clients_createdAt': clientsCreatedAt == null
          ? null
          : DateTime.parse(clientsCreatedAt!).toUtc().toString(),
      'clients_business_id': clientsBusinessId,
      'clients_online': clientsOnline, // New field in map
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
