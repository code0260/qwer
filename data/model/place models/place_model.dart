import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final int? placesId;
  final int? placesBuildingsId;
  final int? placesFloorNumber;
  final String? placesRoomName;
  final String? placesShelvesAlphabet;

  const PlaceModel({
    this.placesId,
    this.placesBuildingsId,
    this.placesFloorNumber,
    this.placesRoomName,
    this.placesShelvesAlphabet,
  });

  PlaceModel copyWith({
    int? placesId,
    int? placesBuildingsId,
    int? placesFloorNumber,
    String? placesRoomNumber,
    String? placesShelvesAlphabet,
  }) {
    return PlaceModel(
      placesId: placesId ?? this.placesId,
      placesBuildingsId: placesBuildingsId ?? this.placesBuildingsId,
      placesFloorNumber: placesFloorNumber ?? this.placesFloorNumber,
      placesRoomName: placesRoomNumber ?? placesRoomName,
      placesShelvesAlphabet:
          placesShelvesAlphabet ?? this.placesShelvesAlphabet,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'places_id': placesId,
      'places_buildings_id': placesBuildingsId,
      'places_floor_number': placesFloorNumber,
      'places_room_number': placesRoomName,
      'places_shelves_alphabet': placesShelvesAlphabet,
    };
    map.removeWhere((key, value) =>
        value == null || value == "" || (key == "places_id" && value == 0));
    return map;
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory PlaceModel.fromJson(Map<String, dynamic> map) {
    return PlaceModel(
      placesId: map['places_id'] as int?,
      placesBuildingsId: map['places_buildings_id'] as int?,
      placesFloorNumber: map['places_floor_number'] as int?,
      placesRoomName: map['places_room_number'] as String?,
      placesShelvesAlphabet: map['places_shelves_alphabet'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        placesId,
        placesBuildingsId,
        placesFloorNumber,
        placesRoomName,
        placesShelvesAlphabet,
      ];

  @override
  String toString() {
    return 'PlaceModel(placesId: $placesId, placesBuildingsId: $placesBuildingsId, placesFloorNumber: $placesFloorNumber, placesRoomNumber: $placesRoomName, placesShelvesAlphabet: $placesShelvesAlphabet)';
  }
}
