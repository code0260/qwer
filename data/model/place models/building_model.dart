import 'package:equatable/equatable.dart';

class BuildingModel extends Equatable {
  final int buildingsId;
  final int buildingsBusinessId;
  final String buildingsType;
  final String buildingsName;
  final String? buildingsLatitude;
  final String? buildingsLongitude;

  const BuildingModel({
    required this.buildingsId,
    required this.buildingsBusinessId,
    required this.buildingsType,
    required this.buildingsName,
    required this.buildingsLatitude,
    required this.buildingsLongitude,
  });

  BuildingModel copyWith({
    int? buildingsId,
    int? buildingsBusinessId,
    String? buildingsType,
    String? buildingsName,
    String? buildingsLatitude,
    String? buildingsLongitude,
  }) {
    return BuildingModel(
      buildingsId: buildingsId ?? this.buildingsId,
      buildingsBusinessId: buildingsBusinessId ?? this.buildingsBusinessId,
      buildingsType: buildingsType ?? this.buildingsType,
      buildingsName: buildingsName ?? this.buildingsName,
      buildingsLatitude: buildingsLatitude ?? this.buildingsLatitude,
      buildingsLongitude: buildingsLongitude ?? this.buildingsLongitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buildings_id': buildingsId,
      'buildings_business_id': buildingsBusinessId,
      'buildings_type': buildingsType,
      'buildings_name': buildingsName,
      'buildings_latitude': buildingsLatitude,
      'buildings_longitude': buildingsLongitude,
    };
  }

  factory BuildingModel.fromJson(Map<String, dynamic> map) {
    return BuildingModel(
      buildingsId: map['buildings_id'] as int,
      buildingsBusinessId: map['buildings_business_id'] as int,
      buildingsType: map['buildings_type'] as String,
      buildingsName: map['buildings_name'] as String,
      buildingsLatitude: map['buildings_latitude'] as String?,
      buildingsLongitude: map['buildings_longitude'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        buildingsId,
        buildingsBusinessId,
        buildingsType,
        buildingsName,
        buildingsLatitude,
        buildingsLongitude,
      ];

  @override
  String toString() {
    return 'BuildingModel(buildingsId: $buildingsId, buildingsBusinessId: $buildingsBusinessId, buildingsType: $buildingsType, buildingsName: $buildingsName, buildingsLatitude: $buildingsLatitude, buildingsLongitude: $buildingsLongitude)';
  }
}
