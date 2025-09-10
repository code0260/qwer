String? translateToEnAccountsNature(String nature) {
  if (nature == 'مدين') {
    return "Debit";
  } else if (nature == 'دائن') {
    return "Credit";
  } else {
    return null;
  }
}

String? translateToArAccountsNature(String? nature) {
  if (nature == 'Debit') {
    return "مدين";
  } else if (nature == 'Credit') {
    return "دائن";
  } else {
    return null;
  }
}
