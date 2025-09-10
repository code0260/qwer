import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class PartnerModel extends Equatable {
  final int? partnersId;
  final int? partnersUsersId;
  final String? partnersType;
  final String? partnersName;
  final String? partnersEmail;
  final String? partnersPhone;
  final String? partnersOwnershipPercentage;
  final double? partnersCapitalContribution;
  final String? partnersDateJoined;
  final String? partnersPartnersRole;
  final String? partnersNotes;
  final String? partnersCreatedAt;
  final String? partnersUpdatedAt;

  const PartnerModel({
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

  factory PartnerModel.fromJson(Map<String, dynamic> json) => PartnerModel(
        partnersId: json['partners_id'] as int?,
        partnersUsersId: json['partners_users_id'] as int?,
        partnersType: json['partners_type'] as String?,
        partnersName: json['partners_name'] as String?,
        partnersEmail: json['partners_email'] as String?,
        partnersPhone: json['partners_phone'] as String?,
        partnersOwnershipPercentage:
            json['partners_ownership_percentage'] as String?,
        partnersCapitalContribution:
            receiveDouble(json['partners_capital_contribution']),
        partnersDateJoined: json['partners_date_joined'],
        partnersPartnersRole: json['partners_role'] as String?,
        partnersNotes: json['partners_notes'] as String?,
        partnersCreatedAt: json['partners_created_at'] == null
            ? null
            : DateTime.parse('${json['partners_created_at']}Z')
                .toLocal()
                .toString(),
        partnersUpdatedAt: json['partners_updated_at'] == null
            ? null
            : DateTime.parse('${json['partners_updated_at']}Z')
                .toLocal()
                .toString(),
      );

  Map<String, dynamic> toJson() => {
        'partners_id': partnersId,
        'partners_users_id': partnersUsersId,
        'partners_type': partnersType,
        'partners_name': partnersName,
        'partners_email': partnersEmail,
        'partners_phone': partnersPhone,
        'partners_ownership_percentage': partnersOwnershipPercentage,
        'partners_capital_contribution': partnersCapitalContribution,
        'partners_date_joined': partnersDateJoined?.toString(),
        'partners_role': partnersPartnersRole,
        'partners_notes': partnersNotes,
        'partners_created_at': partnersCreatedAt == null
            ? null
            : DateTime.parse(partnersCreatedAt!).toUtc().toString(),
        'partners_updated_at': partnersUpdatedAt == null
            ? null
            : DateTime.parse(partnersUpdatedAt!).toUtc().toString(),
      };

  PartnerModel copyWith({
    int? partnersId,
    int? partnersUsersId,
    String? partnersType,
    String? partnersName,
    String? partnersEmail,
    String? partnersPhone,
    String? partnersOwnershipPercentage,
    double? partnersCapitalContribution,
    String? partnersDateJoined,
    String? partnersPartnersRole,
    String? partnersNotes,
    String? partnersCreatedAt,
    String? partnersUpdatedAt,
  }) {
    return PartnerModel(
      partnersId: partnersId ?? this.partnersId,
      partnersUsersId: partnersUsersId ?? this.partnersUsersId,
      partnersType: partnersType ?? this.partnersType,
      partnersName: partnersName ?? this.partnersName,
      partnersEmail: partnersEmail ?? this.partnersEmail,
      partnersPhone: partnersPhone ?? this.partnersPhone,
      partnersOwnershipPercentage:
          partnersOwnershipPercentage ?? this.partnersOwnershipPercentage,
      partnersCapitalContribution:
          partnersCapitalContribution ?? this.partnersCapitalContribution,
      partnersDateJoined: partnersDateJoined ?? this.partnersDateJoined,
      partnersPartnersRole: partnersPartnersRole ?? this.partnersPartnersRole,
      partnersNotes: partnersNotes ?? this.partnersNotes,
      partnersCreatedAt: partnersCreatedAt ?? this.partnersCreatedAt,
      partnersUpdatedAt: partnersUpdatedAt ?? this.partnersUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      partnersId,
      partnersUsersId,
      partnersType,
      partnersName,
      partnersEmail,
      partnersPhone,
      partnersOwnershipPercentage,
      partnersCapitalContribution,
      partnersDateJoined,
      partnersPartnersRole,
      partnersNotes,
      partnersCreatedAt,
      partnersUpdatedAt,
    ];
  }
}
