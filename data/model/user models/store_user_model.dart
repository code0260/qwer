import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:almonazim/data/data%20source/locale/store_user.dart';
import 'package:equatable/equatable.dart';

class StoreUserModel extends Equatable {
  final int? usersId;
  final String? usersCreatedAt; // String type that needs conversion
  final String? usersName;
  final String? usersEmail;
  final String? usersType;
  final String? usersPowers;
  final String? usersPhone;
  final String? usersStartTrial;
  final String? usersEndTrial;
  final int? usersActive;
  final int? businessId;
  final String? businessName;
  final String? businessAddress;
  final String? businessImage;
  final int? businessApprove;

  const StoreUserModel._({
    this.usersId,
    this.usersCreatedAt,
    this.usersName,
    this.usersPowers,
    this.usersEmail,
    this.usersPhone,
    this.usersEndTrial,
    this.usersStartTrial,
    this.usersActive,
    this.businessId,
    this.usersType,
    this.businessName,
    this.businessAddress,
    this.businessImage,
    this.businessApprove,
  });

  // Static instance
  static StoreUserModel instance = const StoreUserModel._();

  // Factory constructor to provide the singleton instance
  factory StoreUserModel.init() {
    instance = StoreUser.getUser() ?? const StoreUserModel._();
    return instance;
  }

  StoreUserModel updateInstance({
    int? usersId,
    String? usersCreatedAt,
    String? usersName,
    String? usersEmail,
    String? usersType,
    String? usersPowers,
    String? usersPhone,
    String? usersStartTrial,
    String? usersEndTrial,
    int? usersActive,
    int? businessId,
    String? businessName,
    String? businessAddress,
    String? businessImage,
    int? businessApprove,
  }) {
    instance = StoreUserModel._(
      usersId: usersId ?? this.usersId,
      usersCreatedAt: usersCreatedAt ?? this.usersCreatedAt,
      usersName: usersName ?? this.usersName,
      usersEmail: usersEmail ?? this.usersEmail,
      usersType: usersType ?? this.usersType,
      usersPowers: usersPowers ?? this.usersPowers,
      usersPhone: usersPhone ?? this.usersPhone,
      usersStartTrial: usersStartTrial ?? this.usersStartTrial,
      usersEndTrial: usersEndTrial ?? this.usersEndTrial,
      usersActive: usersActive ?? this.usersActive,
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessImage: businessImage ?? this.businessImage,
      businessApprove: businessApprove ?? this.businessApprove,
    );
    return instance;
  }

  factory StoreUserModel.fromJson(Map<String, dynamic> json) =>
      instance.updateInstance(
        usersId: json['users_id'] as int?,
        usersCreatedAt: toLocalTime(
            json['users_createdAt']), // Converts from UTC to local time
        usersName: json['users_name'] as String?,
        usersEmail: json['users_email'] as String?,
        usersType: json['users_type'] as String?,
        usersPowers: json['users_powers'] as String?,
        usersPhone: json['users_phone'] as String?,
        usersStartTrial: json['users_start_trial'] as String?,
        usersEndTrial: json['users_end_trial'] as String?,
        usersActive: json['users_active'] as int?,
        businessId: json['business_id'] as int?,
        businessName: json['business_name'] as String?,
        businessAddress: json['business_address'] as String?,
        businessImage: json['business_image'] as String?,
        businessApprove: json['business_approve'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'users_id': usersId,
        'users_createdAt': usersCreatedAt == null
            ? null
            : DateTime.parse(usersCreatedAt!)
                .toUtc()
                .toString(), // Converts from local time to UTC
        'users_name': usersName,
        'users_email': usersEmail,
        'users_type': usersType,
        'users_powers': usersPowers,
        'users_phone': usersPhone,
        'users_start_trial': usersStartTrial,
        'users_end_trial': usersEndTrial,
        'users_active': usersActive,
        'business_id': businessId,
        'business_name': businessName,
        'business_address': businessAddress,
        'business_image': businessImage,
        'business_approve': businessApprove,
      };

  StoreUserModel copyWith({
    int? usersId,
    String? usersCreatedAt,
    String? usersName,
    String? usersEmail,
    String? usersType,
    String? usersPowers,
    String? usersPhone,
    String? usersStartTrial,
    String? usersEndTrial,
    int? usersActive,
    int? businessId,
    String? businessName,
    String? businessAddress,
    String? businessImage,
    int? businessApprove,
  }) {
    return StoreUserModel._(
      usersId: usersId ?? this.usersId,
      usersCreatedAt: usersCreatedAt ?? this.usersCreatedAt,
      usersName: usersName ?? this.usersName,
      usersEmail: usersEmail ?? this.usersEmail,
      usersType: usersType ?? this.usersType,
      usersPowers: usersPowers ?? this.usersPowers,
      usersPhone: usersPhone ?? this.usersPhone,
      usersStartTrial: usersStartTrial ?? this.usersStartTrial,
      usersEndTrial: usersEndTrial ?? this.usersEndTrial,
      usersActive: usersActive ?? this.usersActive,
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessImage: businessImage ?? this.businessImage,
      businessApprove: businessApprove ?? this.businessApprove,
    );
  }

  @override
  List<Object?> get props {
    return [
      usersId,
      usersCreatedAt,
      usersName,
      usersEmail,
      usersType,
      usersPowers,
      usersPhone,
      usersActive,
      usersEndTrial,
      usersStartTrial,
      businessId,
      businessName,
      businessAddress,
      businessImage,
      businessApprove,
    ];
  }
}
