import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final String? roomName;

  const RoomModel({
    required this.roomName,
  });

  RoomModel copyWith({
    String? roomName,
  }) {
    return RoomModel(
      roomName: roomName ?? this.roomName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'places_room_number': roomName,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> map) {
    return RoomModel(
      roomName: map['places_room_number'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        roomName,
      ];

  @override
  String toString() {
    return 'RoomModel(roomName: $roomName)';
  }
}
