import 'dart:convert';

import 'package:almonazim/data/model/partner%20models/partner_input_model.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';

class AddPartnerModel {
  final PartnerInputModel partnerInputModel;
  final UserInputModel userInputModel;
  bool isUser;
  AddPartnerModel({
    required this.partnerInputModel,
    required this.userInputModel,
    this.isUser = false,
  });

  AddPartnerModel copyWith({
    PartnerInputModel? partnerInputModel,
    UserInputModel? userInputModel,
    bool? isUser,
  }) {
    return AddPartnerModel(
      partnerInputModel: partnerInputModel ?? this.partnerInputModel,
      userInputModel: userInputModel ?? this.userInputModel,
      isUser: isUser ?? this.isUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partner': partnerInputModel.toMap(),
      'user': userInputModel.toMap(),
      'is_user': isUser,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'AddPartnerModel(partnerInputModel: $partnerInputModel, userInputModel: $userInputModel, isUser: $isUser)';

  @override
  bool operator ==(covariant AddPartnerModel other) {
    if (identical(this, other)) return true;

    return other.partnerInputModel == partnerInputModel &&
        other.userInputModel == userInputModel &&
        other.isUser == isUser;
  }

  @override
  int get hashCode =>
      partnerInputModel.hashCode ^ userInputModel.hashCode ^ isUser.hashCode;
}
