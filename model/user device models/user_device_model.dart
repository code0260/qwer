import 'package:equatable/equatable.dart';

class UserDeviceModel extends Equatable {
  final int? usersDevicesId;
  final int? usersDevicesUsersId;
  final String? usersDevicesPlatform;
  final String? usersDevicesModel;
  final String? usersDevicesManufacturer;
  final String? usersDevicesName;
  final String? usersDevicesOsVersion;
  final String? usersDevicesIdentifier;
  final String? usersDevicesSignedInAt;

  const UserDeviceModel({
    this.usersDevicesId,
    this.usersDevicesUsersId,
    this.usersDevicesPlatform,
    this.usersDevicesModel,
    this.usersDevicesManufacturer,
    this.usersDevicesName,
    this.usersDevicesOsVersion,
    this.usersDevicesIdentifier,
    this.usersDevicesSignedInAt,
  });

  factory UserDeviceModel.fromJson(Map<String, dynamic> json) {
    return UserDeviceModel(
      usersDevicesId: json['users_devices_id'] as int?,
      usersDevicesUsersId: json['users_devices_users_id'] as int?,
      usersDevicesPlatform: json['users_devices_platform'] as String?,
      usersDevicesModel: json['users_devices_model'] as String?,
      usersDevicesManufacturer: json['users_devices_manufacturer'] as String?,
      usersDevicesName: json['users_devices_name'] as String?,
      usersDevicesOsVersion: json['users_devices_os_version'] as String?,
      usersDevicesIdentifier: json['users_devices_identifier'] as String?,
      usersDevicesSignedInAt: json['users_devices_signed_in_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'users_devices_id': usersDevicesId,
        'users_devices_users_id': usersDevicesUsersId,
        'users_devices_platform': usersDevicesPlatform,
        'users_devices_model': usersDevicesModel,
        'users_devices_manufacturer': usersDevicesManufacturer,
        'users_devices_name': usersDevicesName,
        'users_devices_os_version': usersDevicesOsVersion,
        'users_devices_identifier': usersDevicesIdentifier,
        'users_devices_signed_in_at': usersDevicesSignedInAt,
      };

  UserDeviceModel copyWith({
    int? usersDevicesId,
    int? usersDevicesUsersId,
    String? usersDevicesPlatform,
    String? usersDevicesModel,
    String? usersDevicesManufacturer,
    String? usersDevicesName,
    String? usersDevicesOsVersion,
    String? usersDevicesIdentifier,
    String? usersDevicesSignedInAt,
  }) {
    return UserDeviceModel(
      usersDevicesId: usersDevicesId ?? this.usersDevicesId,
      usersDevicesUsersId: usersDevicesUsersId ?? this.usersDevicesUsersId,
      usersDevicesPlatform: usersDevicesPlatform ?? this.usersDevicesPlatform,
      usersDevicesModel: usersDevicesModel ?? this.usersDevicesModel,
      usersDevicesManufacturer:
          usersDevicesManufacturer ?? this.usersDevicesManufacturer,
      usersDevicesName: usersDevicesName ?? this.usersDevicesName,
      usersDevicesOsVersion:
          usersDevicesOsVersion ?? this.usersDevicesOsVersion,
      usersDevicesIdentifier:
          usersDevicesIdentifier ?? this.usersDevicesIdentifier,
      usersDevicesSignedInAt:
          usersDevicesSignedInAt ?? this.usersDevicesSignedInAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      usersDevicesId,
      usersDevicesUsersId,
      usersDevicesPlatform,
      usersDevicesModel,
      usersDevicesManufacturer,
      usersDevicesName,
      usersDevicesOsVersion,
      usersDevicesIdentifier,
      usersDevicesSignedInAt,
    ];
  }
}
