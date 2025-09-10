String? translateToEnDebtType(String type) {
  if (type == 'ملك لي') {
    return "Debit";
  } else if (type == 'التزام عليَّ') {
    return "Credit";
  } else {
    return null;
  }
}

String? translateToArDebtType(String? type) {
  if (type == "Debit") {
    return 'ملك لي';
  } else if (type == "Credit") {
    return 'التزام عليَّ';
  } else {
    return null;
  }
}
