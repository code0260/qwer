import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnDepreciationMethodEnum(DepreciationMethod? method) {
  switch (method) {
    case DepreciationMethod.straightLine:
      return "Straight Line";
    case DepreciationMethod.decliningBalance:
      return "Declining Balance";
    case DepreciationMethod.sumOfYearsDigits:
      return "Sum of Years' Digits";
    case DepreciationMethod.unitsOfProduction:
      return "Units of Production";
    default:
      return null;
  }
}

String? translateToArDepreciationMethodEnum(DepreciationMethod? method) {
  switch (method) {
    case DepreciationMethod.straightLine:
      return "القسط الثابت";
    case DepreciationMethod.decliningBalance:
      return "الرصيد المتناقص";
    case DepreciationMethod.sumOfYearsDigits:
      return "مجموع أرقام السنوات";
    case DepreciationMethod.unitsOfProduction:
      return "وحدات الإنتاج";
    default:
      return null;
  }
}

String? translateToEnDepreciationMethod(String? method) {
  switch (method) {
    case "القسط الثابت":
      return "Straight Line";
    case "الرصيد المتناقص":
      return "Declining Balance";
    case "مجموع أرقام السنوات":
      return "Sum of Years' Digits";
    case "وحدات الإنتاج":
      return "Units of Production";
    default:
      return null;
  }
}

String? translateToArDepreciationMethod(String? method) {
  switch (method) {
    case "Straight Line":
      return "القسط الثابت";
    case "Declining Balance":
      return "الرصيد المتناقص";
    case "Sum of Years' Digits":
      return "مجموع أرقام السنوات";
    case "Units of Production":
      return "وحدات الإنتاج";
    default:
      return null;
  }
}
