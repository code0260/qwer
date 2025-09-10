import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? usersId;
  final int? usersBusinessId;
  final String? usersName;
  final String? usersEmail;
  final String? usersPassword;
  final String? usersPhone;
  final String? usersType;
  final String? usersPowers;
  final String? usersCreatedAt;
  final String? usersStartTrial;
  final String? usersEndTrial;
  final int? usersActive;

  const UserModel({
    this.usersId,
    this.usersBusinessId,
    this.usersName,
    this.usersEmail,
    this.usersPassword,
    this.usersPhone,
    this.usersType,
    this.usersPowers,
    this.usersCreatedAt,
    this.usersStartTrial,
    this.usersEndTrial,
    this.usersActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        usersId: json['users_id'] as int?,
        usersBusinessId: json['users_business_id'] as int?,
        usersName: json['users_name'] as String?,
        usersEmail: json['users_email'] as String?,
        usersPassword: json['users_password'] as String?,
        usersPhone: json['users_phone'] as String?,
        usersType: json['users_type'] as String?,
        usersPowers: json['users_powers'] as String?,
        usersCreatedAt: json['users_createdAt'] as String?,
        usersStartTrial: json['users_start_trial'] as String?,
        usersEndTrial: json['users_end_trial'] as String?,
        usersActive: json['users_active'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'users_id': usersId,
        'users_business_id': usersBusinessId,
        'users_name': usersName,
        'users_email': usersEmail,
        'users_password': usersPassword,
        'users_phone': usersPhone,
        'users_type': usersType,
        'users_powers': usersPowers,
        'users_createdAt': usersCreatedAt,
        'users_start_trial': usersStartTrial,
        'users_end_trial': usersEndTrial,
        'users_active': usersActive,
      };

  UserModel copyWith({
    int? usersId,
    int? usersBusinessId,
    String? usersName,
    String? usersEmail,
    String? usersPassword,
    String? usersPhone,
    String? usersType,
    String? usersPowers,
    String? usersCreatedAt,
    String? usersStartTrial,
    String? usersEndTrial,
    int? usersActive,
  }) {
    return UserModel(
      usersId: usersId ?? this.usersId,
      usersBusinessId: usersBusinessId ?? this.usersBusinessId,
      usersName: usersName ?? this.usersName,
      usersEmail: usersEmail ?? this.usersEmail,
      usersPassword: usersPassword ?? this.usersPassword,
      usersPhone: usersPhone ?? this.usersPhone,
      usersType: usersType ?? this.usersType,
      usersPowers: usersPowers ?? this.usersPowers,
      usersCreatedAt: usersCreatedAt ?? this.usersCreatedAt,
      usersStartTrial: usersStartTrial ?? this.usersStartTrial,
      usersEndTrial: usersEndTrial ?? this.usersEndTrial,
      usersActive: usersActive ?? this.usersActive,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      usersId,
      usersBusinessId,
      usersName,
      usersEmail,
      usersPassword,
      usersPhone,
      usersType,
      usersPowers,
      usersCreatedAt,
      usersStartTrial,
      usersEndTrial,
      usersActive,
    ];
  }
}
