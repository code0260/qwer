import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnAddDebtFrom(String type) {
  if (type == 'نقدية') {
    return 'cash';
  } else if (type == 'رأس المال') {
    return 'capital';
  } else {
    return null;
  }
}

String? translateToArAddDebtFrom(String? type) {
  if (type == 'cash') {
    return 'نقدية';
  } else if (type == 'capital') {
    return 'رأس المال';
  } else {
    return null;
  }
}

AddDebtFrom translateToEnumAddDebtFrom(String type) {
  if (type == 'نقدية') {
    return AddDebtFrom.cash;
  } else if (type == 'رأس المال') {
    return AddDebtFrom.capital;
  } else {
    return AddDebtFrom.cash;
  }
}
