import 'package:almonazim/core/constant/app_enums.dart';

String getAssetCode(String assetsCategory) {
  if (assetsCategory == AssetCategory.land.name) {
    return "111000";
  } else if (assetsCategory == AssetCategory.vehicles.name) {
    return "112000";
  } else if (assetsCategory == AssetCategory.buildings.name) {
    return "113000";
  } else if (assetsCategory == AssetCategory.equipment.name) {
    return "114000";
  }
  return '';
}
