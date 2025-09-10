// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class PartnerInputModel {
  int? partnersId;
  int? partnersUsersId;
  String? partnersType;
  String? partnersName;
  String? partnersEmail;
  String? partnersPhone;
  String? partnersOwnershipPercentage;
  double? partnersCapitalContribution;
  int? partnersCapitalContributionCurrencyId;
  String? partnersDateJoined;
  String? partnersPartnersRole;
  String? partnersNotes;
  String? partnersCreatedAt;
  String? partnersUpdatedAt;

  PartnerInputModel({
    this.partnersId,
    this.partnersUsersId,
    this.partnersType,
    this.partnersName,
    this.partnersEmail,
    this.partnersPhone,
    this.partnersOwnershipPercentage,
    this.partnersCapitalContribution,
    this.partnersDateJoined,
    this.partnersPartnersRole,
    this.partnersNotes,
    this.partnersCreatedAt,
    this.partnersUpdatedAt,
  });

  factory PartnerInputModel.fromMap(Map<String, dynamic> map) =>
      PartnerInputModel(
        partnersId: map['partners_id'] as int?,
        partnersUsersId: map['partners_users_id'] as int?,
        partnersType: map['partners_type'] as String?,
        partnersName: map['partners_name'] as String?,
        partnersEmail: map['partners_email'] as String?,
        partnersPhone: map['partners_phone'] as String?,
        partnersOwnershipPercentage:
            map['partners_ownership_percentage'] as String?,
        partnersCapitalContribution:
            receiveDouble(map['partners_capital_contribution']),
        partnersDateJoined: map['partners_date_joined'] == null
            ? null
            : DateTime.parse('${map['partners_date_joined']}Z')
                .toLocal()
                .toString(),
        partnersPartnersRole: map['partners_role'] as String?,
        partnersNotes: map['partners_notes'] as String?,
        partnersCreatedAt: map['partners_created_at'] == null
            ? null
            : DateTime.parse('${map['partners_created_at']}Z')
                .toLocal()
                .toString(),
        partnersUpdatedAt: map['partners_updated_at'] == null
            ? null
            : DateTime.parse('${map['partners_updated_at']}Z')
                .toLocal()
                .toString(),
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'partners_id': partnersId,
      'partners_users_id': partnersUsersId,
      'partners_type': partnersType,
      'partners_name': partnersName,
      'partners_email': partnersEmail,
      'partners_phone': partnersPhone,
      'partners_ownership_percentage': partnersOwnershipPercentage,
      'partners_capital_contribution': partnersCapitalContribution,
      'partners_date_joined': partnersDateJoined == null
          ? null
          : DateTime.parse(partnersDateJoined!).toUtc().toString(),
      'partners_role': partnersPartnersRole,
      'partners_notes': partnersNotes,
      'partners_created_at': partnersCreatedAt == null
          ? null
          : DateTime.parse(partnersCreatedAt!).toUtc().toString(),
      'partners_updated_at': partnersUpdatedAt == null
          ? null
          : DateTime.parse(partnersUpdatedAt!).toUtc().toString(),
    };
    map.removeWhere((key, value) => value == null || value == "");
    return map;
  }
}
