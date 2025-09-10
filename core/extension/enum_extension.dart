import 'package:almonazim/core/constant/app_enums.dart';

extension EnumExtension on String {
  UnitGroup toUnitGroup() {
    return UnitGroup.values.firstWhere((element) => element.name == this);
  }

  OfferDomainType toDomainType() {
    return OfferDomainType.values.firstWhere((element) => element.name == this);
  }
}
