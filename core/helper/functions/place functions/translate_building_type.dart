import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnBuildingType(BuildingType? type) {
  switch (type) {
    case BuildingType.shop:
      return "shop";
    case BuildingType.warehouse:
      return "warehouse";
    default:
      return null;
  }
}

String? translateToArBuildingType(BuildingType? type) {
  switch (type) {
    case BuildingType.shop:
      return "محل";
    case BuildingType.warehouse:
      return "مستودع";
    default:
      return null;
  }
}

String? translateToEnBuildingTypeFromString(String? type) {
  switch (type) {
    case "محل":
      return "shop";
    case "مستودع":
      return "warehouse";
    default:
      return null;
  }
}

String? translateToArBuildingTypeFromString(String? type) {
  switch (type) {
    case "shop":
      return "محل";
    case "warehouse":
      return "مستودع";
    default:
      return null;
  }
}
