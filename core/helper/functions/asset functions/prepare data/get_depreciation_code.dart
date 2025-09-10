import 'package:almonazim/core/constant/app_enums.dart';

String getDepreciationCode(String assetsCategory) {
  if (assetsCategory == AssetCategory.land.name) {
    return ""; // no depreciation for land
  } else if (assetsCategory == AssetCategory.vehicles.name) {
    return "221000";
  } else if (assetsCategory == AssetCategory.buildings.name) {
    return "222000";
  } else if (assetsCategory == AssetCategory.equipment.name) {
    return "223000";
  }
  return '';
}
