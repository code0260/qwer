import 'package:equatable/equatable.dart';

class FloorModel extends Equatable {
  final int floorNumber;

  const FloorModel({
    required this.floorNumber,
  });

  FloorModel copyWith({
    int? floorNumber,
  }) {
    return FloorModel(
      floorNumber: floorNumber ?? this.floorNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'places_floor_number': floorNumber,
    };
  }

  factory FloorModel.fromJson(Map<String, dynamic> map) {
    return FloorModel(
      floorNumber: map['places_floor_number'] as int,
    );
  }

  @override
  List<Object?> get props => [
        floorNumber,
      ];

  @override
  String toString() {
    return 'FloorModel(floorNumber: $floorNumber)';
  }
}
