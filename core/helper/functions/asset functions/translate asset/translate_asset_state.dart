import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnAssetStatusEnum(AssetStatus? status) {
  switch (status) {
    case AssetStatus.active:
      return "active";
    case AssetStatus.disposed:
      return "disposed";
    case AssetStatus.sold:
      return "sold";
    case AssetStatus.retired:
      return "retired";
    default:
      return null;
  }
}

String? translateToArAssetStatusEnum(AssetStatus? status) {
  switch (status) {
    case AssetStatus.active:
      return "نشط";
    case AssetStatus.disposed:
      return "متخلص";
    case AssetStatus.sold:
      return "مباع";
    case AssetStatus.retired:
      return "متقاعد";
    default:
      return null;
  }
}

String? translateToEnAssetStatus(String? status) {
  switch (status) {
    case "نشط":
      return "active";
    case "متخلص":
      return "disposed";
    case "مباع":
      return "sold";
    case "متقاعد":
      return "retired";
    default:
      return null;
  }
}

String? translateToArAssetStatus(String? status) {
  switch (status) {
    case "active":
      return "نشط";
    case "disposed":
      return "متخلص";
    case "sold":
      return "مباع";
    case "retired":
      return "متقاعد";
    default:
      return null;
  }
}
