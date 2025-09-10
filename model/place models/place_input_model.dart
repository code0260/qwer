// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceInputModel {
  int? placesId;
  int? placesBuildingsId;
  int? placesFloorNumber;
  String? placesRoomName;
  String? placesShelvesAlphabet;
  PlaceInputModel({
    this.placesId,
    this.placesBuildingsId,
    this.placesFloorNumber,
    this.placesRoomName,
    this.placesShelvesAlphabet,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'places_id': placesId,
      'places_buildings_id': placesBuildingsId,
      'places_floor_number': placesFloorNumber,
      'places_room_number': placesRoomName,
      'places_shelves_alphabet': placesShelvesAlphabet,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Map<String, dynamic> toMapEvenNull() {
    Map<String, dynamic> map = {
      'places_id': placesId,
      'places_buildings_id': placesBuildingsId,
      'places_floor_number': placesFloorNumber,
      'places_room_number': placesRoomName,
      'places_shelves_alphabet': placesShelvesAlphabet,
    };
    return map;
  }
}
