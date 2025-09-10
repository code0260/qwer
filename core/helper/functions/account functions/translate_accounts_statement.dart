String? translateToEnAccountsStatement(String statement) {
  if (statement == 'قائمة الدخل') {
    return "Income Statement";
  } else if (statement == 'الميزانية') {
    return "Balance Sheet";
  } else {
    return null;
  }
}

String? translateToArAccountsStatement(String? statement) {
  if (statement == "Income Statement") {
    return 'قائمة الدخل';
  } else if (statement == "Balance Sheet") {
    return 'الميزانية';
  } else {
    return null;
  }
}
