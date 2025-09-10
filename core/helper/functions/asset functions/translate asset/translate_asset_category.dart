import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnAssetCategoryEnum(AssetCategory? category) {
  switch (category) {
    case AssetCategory.vehicles:
      return "vehicles";
    case AssetCategory.buildings:
      return "buildings";
    case AssetCategory.land:
      return "land";
    case AssetCategory.equipment:
      return "equipment";
    default:
      return null;
  }
}

String? translateToArAssetCategoryEnum(AssetCategory? category) {
  switch (category) {
    case AssetCategory.vehicles:
      return "مركبات";
    case AssetCategory.buildings:
      return "مباني";
    case AssetCategory.land:
      return "أراضي";
    case AssetCategory.equipment:
      return "معدات";
    default:
      return null;
  }
}

String? translateToArAssetCategory(String? category) {
  switch (category) {
    case "vehicles":
      return "مركبات";
    case "buildings":
      return "مباني";
    case "land":
      return "أراضي";
    case "equipment":
      return "معدات";
    default:
      return null;
  }
}

String? translateToEnAssetCategory(String? category) {
  switch (category) {
    case "مركبات":
      return "vehicles";
    case "مباني":
      return "buildings";
    case "أراضي":
      return "land";
    case "معدات":
      return "equipment";
    default:
      return null;
  }
}
