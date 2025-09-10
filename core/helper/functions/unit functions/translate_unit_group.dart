import 'package:almonazim/core/constant/app_enums.dart';

String translateUnitGroup(UnitGroup unitGroup) {
  switch (unitGroup) {
    case UnitGroup.weight:
      return "وزن";
    case UnitGroup.general:
      return "عامة";
    case UnitGroup.volume:
      return "حجم";
    case UnitGroup.length:
      return "طول";
    case UnitGroup.area:
      return "مساحة";
    default:
      return "جملة"; // Handle any additional cases as needed
  }
}
