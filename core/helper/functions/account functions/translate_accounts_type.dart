String? translateToEnAccountsType(String type) {
  if (type == 'رئيسي') {
    return "0";
  } else if (type == 'فرعي') {
    return "1";
  } else {
    return null;
  }
}

String? translateToArAccountsType(String? type) {
  if (type == '0') {
    return "رئيسي";
  } else if (type == '1') {
    return "فرعي";
  } else {
    return null;
  }
}
