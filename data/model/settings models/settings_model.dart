import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final int? settingsId;
  final int? settingsBusinessId;
  final String? settingsKey;
  final String? settingsValue;
  final String? settingsCreatedAt;
  final String? settingsUpdatedAt;

  const SettingsModel({
    this.settingsId,
    this.settingsBusinessId,
    this.settingsKey,
    this.settingsValue,
    this.settingsCreatedAt,
    this.settingsUpdatedAt,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        settingsId: json['settings_id'] as int?,
        settingsBusinessId: json['settings_business_id'] as int?,
        settingsKey: json['settings_key'] as String?,
        settingsValue: json['settings_value'] as String?,
        settingsCreatedAt: json['settings_created_at'] as String?,
        settingsUpdatedAt: json['settings_updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'settings_id': settingsId,
        'settings_business_id': settingsBusinessId,
        'settings_key': settingsKey,
        'settings_value': settingsValue,
        'settings_created_at': settingsCreatedAt,
        'settings_updated_at': settingsUpdatedAt,
      };

  SettingsModel copyWith({
    int? settingsId,
    int? settingsBusinessId,
    String? settingsKey,
    String? settingsValue,
    String? settingsCreatedAt,
    String? settingsUpdatedAt,
  }) {
    return SettingsModel(
      settingsId: settingsId ?? this.settingsId,
      settingsBusinessId: settingsBusinessId ?? this.settingsBusinessId,
      settingsKey: settingsKey ?? this.settingsKey,
      settingsValue: settingsValue ?? this.settingsValue,
      settingsCreatedAt: settingsCreatedAt ?? this.settingsCreatedAt,
      settingsUpdatedAt: settingsUpdatedAt ?? this.settingsUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      settingsId,
      settingsBusinessId,
      settingsKey,
      settingsValue,
      settingsCreatedAt,
      settingsUpdatedAt,
    ];
  }
}
