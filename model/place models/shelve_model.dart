import 'package:equatable/equatable.dart';

class ShelveModel extends Equatable {
  final String shelveName;

  const ShelveModel({
    required this.shelveName,
  });

  ShelveModel copyWith({
    String? shelveName,
  }) {
    return ShelveModel(
      shelveName: shelveName ?? this.shelveName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'places_shelves_alphabet': shelveName,
    };
  }

  factory ShelveModel.fromJson(Map<String, dynamic> map) {
    return ShelveModel(
      shelveName: map['places_shelves_alphabet'] as String,
    );
  }

  @override
  List<Object?> get props => [
        shelveName,
      ];

  @override
  String toString() {
    return 'ShelveModel(shelveName: $shelveName)';
  }
}
