import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnWithdrawalType(WithdrawalType? type) {
  switch (type) {
    case WithdrawalType.goods:
      return "goods";
    case WithdrawalType.cash:
      return "cash";
    default:
      return null;
  }
}

String? translateToArWithdrawalType(WithdrawalType? type) {
  switch (type) {
    case WithdrawalType.goods:
      return "بضاعة";
    case WithdrawalType.cash:
      return "نقد";
    default:
      return null;
  }
}

String? translateToEnWithdrawalTypeFromString(String? type) {
  switch (type) {
    case "بضاعة":
      return "goods";
    case "نقد":
      return "cash";
    default:
      return null;
  }
}

String? translateToArWithdrawalTypeFromString(String? type) {
  switch (type) {
    case "goods":
      return "بضاعة";
    case "cash":
      return "نقد";
    default:
      return null;
  }
}
